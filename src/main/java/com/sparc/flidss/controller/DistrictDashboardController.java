package com.sparc.flidss.controller;

import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.DistrictDivisionLinkMaster;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
import com.sparc.flidss.repository.common.CircleMasterRepository;
import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;
import com.sparc.flidss.repository.common.DivisionMasterRepository;
import com.sparc.flidss.repository.common.NfbDetailsRepository;
import com.sparc.flidss.repository.common.NfbMasterRepository;
import com.sparc.flidss.repository.common.RevnueForestMasterRepository;
import com.sparc.flidss.security.service.DssUserDetails;
import com.sparc.flidss.security.service.SecurityUtility;
import com.sparc.flidss.service.DBService;
import com.sparc.flidss.service.DashboardService;
import com.sparc.flidss.service.UtilityChartService;
import com.sparc.flidss.utility.CustomUtility;
import com.sparc.flidss.utility.chart.Series;


@Controller
public class DistrictDashboardController {
	@Autowired
	AutoUserInfoRepository autoUserInfoRepository;
	@Autowired
	DivisionMasterRepository divRepo;
	@Autowired
	NfbMasterRepository nfbmrepo;
	@Autowired
	NfbDetailsRepository nfbrepo;
	@Autowired
	RevnueForestMasterRepository revrepo;
	@Autowired
	DashboardService dashboardService;
	@Autowired
	SecurityUtility securityUtility;
	@Autowired
	DBService dbService;
	@Autowired
	UtilityChartService chartService;
	@Autowired
	DistrictDivisionLinkMasterRepository distDivLinkRepo;

	@RequestMapping("/DistDashboard")
	private ModelAndView Dashboard() {
		ModelAndView modelView = new ModelAndView();
		String url = securityUtility.checkAuthority(8, 16);
		if (url != null && url.equalsIgnoreCase("Dashboard")) {
			url = "/dashboard/distDashboard";
		}
		modelView.setViewName(url);
		return modelView;
	}
	
	@RequestMapping("/DistDashboard/getTargetAchv")
	private @ResponseBody TargetAchievement getTargetAchv(HttpSession session,@RequestParam(name = "phase") Set<Integer> phase) {
		
		TargetAchievement objTarAchv=new TargetAchievement();
		try {
			Object distId = session.getAttribute("distID");
			Set<Integer> dividsByDist = distDivLinkRepo.findByDistId(distId!=null?Integer.parseInt(distId.toString()):0)
			.stream().map(m->m.getDivisionMaster().getIntId()).collect(Collectors.toSet());
			
			var nfbAll= nfbrepo.findAll().stream().filter(f->dividsByDist.contains(f.getDivisionMaster().getIntId())).collect(Collectors.toList());
			var divAll= divRepo.findAll().stream().filter(f->dividsByDist.contains(f.getIntId())).collect(Collectors.toList());
			
			Integer totalNfbAchv = (int) nfbAll.stream().filter(f->phase.contains(f.getDivisionMaster().getPhaseMaster().getIntPhase()))
					.mapToInt(f -> f.getNfbMaster() != null ? f.getNfbMaster().getIntId() : 0).distinct().count();
			
			Double NfbAreasum = nfbAll.stream().filter(f->phase.contains(f.getDivisionMaster().getPhaseMaster().getIntPhase()))
					.mapToDouble(f -> f.getDgpsfHa() != null && f.getDgpsfHa().doubleValue() > 0
							? f.getDgpsfHa().doubleValue() * 0.01
							: (f.getDgpsdHa() != null && f.getDgpsdHa().doubleValue() > 0
									? f.getDgpsdHa().doubleValue() * 0.01
									: (f.getJvHa() != null && f.getJvHa().doubleValue() > 0
											? f.getJvHa().doubleValue() * 0.01
											: (f.getCmvHa() != null && f.getCmvHa().doubleValue() > 0
													? f.getCmvHa().doubleValue() * 0.01
													: (f.getMmvHa() != null && f.getMmvHa().doubleValue() > 0
															? f.getMmvHa().doubleValue() * 0.01
															: 0))))).sum();

			
			objTarAchv.setTargetNfbNos((int)divAll.stream().filter(f->phase.contains(f.getPhaseMaster().getIntPhase()))
					.mapToInt(m->m.getDecNoOfFbs()!=null? m.getDecNoOfFbs():0).sum());
			
			objTarAchv.setTargetNfbA(divAll.stream().filter(f->phase.contains(f.getPhaseMaster().getIntPhase()))
					.mapToDouble(m->m.getDecNfbAreaSkm()!=null? m.getDecNfbAreaSkm():0).sum());
			objTarAchv.setAchvNfbNos(totalNfbAchv);
			objTarAchv.setAchvNfbA(NfbAreasum);
			
			
			objTarAchv.setTargetRecordedFA(divAll.stream().filter(f->phase.contains(f.getPhaseMaster().getIntPhase()))
					.mapToDouble(m->m.getDecRevenueLand()!=null? m.getDecRevenueLand():0).sum());
			objTarAchv.setAchvRecordedFAPlots(revrepo.getTotalRevPlots(phase));
			objTarAchv.setAchvRecordedFA(revrepo.getTotalRevArea(phase));
			
		} catch (Exception e) {
			
		}
		
		return objTarAchv;
	}
	
	@RequestMapping("/DistDashboard/getChart")
	private @ResponseBody ParentChildChart getChart(@RequestParam(name = "phase") Set<Integer> phase,HttpSession session) {
		Object distId = session.getAttribute("distID");
		Set<Integer> divIds = distDivLinkRepo.findByDistId(distId!=null?Integer.parseInt(distId.toString()):0)
		.stream().map(m->m.getDivisionMaster().getIntId()).collect(Collectors.toSet());
		
		ParentChildChart objChartList=new ParentChildChart();
		objChartList.setParent(chartService.stackedDrilldownDivision(phase,divIds));
		objChartList.setChild(chartService.stackedDrilldownChildRange(phase,divIds));
		
		return objChartList;
	}

	class ParentChildChart{
		List<Series> Parent;
		List<Series> child;
		
		public List<Series> getParent() {
			return Parent;
		}
		public void setParent(List<Series> parent) {
			Parent = parent;
		}
		public List<Series> getChild() {
			return child;
		}
		public void setChild(List<Series> child) {
			this.child = child;
		}
	}
	
	class TargetAchievement{
		Integer targetNfbNos;
		Double targetNfbA;
		
		Integer achvNfbNos;
		Double achvNfbA;
		
		Double targetRecordedFA;
		Integer achvRecordedFAPlots;
		Double achvRecordedFA;

		
		
		public Integer getTargetNfbNos() {
			return targetNfbNos;
		}

		public void setTargetNfbNos(Integer targetNfbNos) {
			this.targetNfbNos = targetNfbNos;
		}

		public Double getTargetNfbA() {
			return targetNfbA;
		}

		public void setTargetNfbA(Double targetNfbA) {
			this.targetNfbA = targetNfbA;
		}

		public Integer getAchvNfbNos() {
			return achvNfbNos;
		}

		public void setAchvNfbNos(Integer achvNfbNos) {
			this.achvNfbNos = achvNfbNos;
		}

		public Double getAchvNfbA() {
			return achvNfbA;
		}

		public void setAchvNfbA(Double achvNfbA) {
			this.achvNfbA = achvNfbA;
		}

		public Double getTargetRecordedFA() {
			return targetRecordedFA;
		}

		public void setTargetRecordedFA(Double targetRecordedFA) {
			this.targetRecordedFA = targetRecordedFA;
		}

		public Integer getAchvRecordedFAPlots() {
			return achvRecordedFAPlots;
		}

		public void setAchvRecordedFAPlots(Integer achvRecordedFAPlots) {
			this.achvRecordedFAPlots = achvRecordedFAPlots;
		}

		public Double getAchvRecordedFA() {
			return achvRecordedFA;
		}

		public void setAchvRecordedFA(Double achvRecordedFA) {
			this.achvRecordedFA = achvRecordedFA;
		}
		
	}

}
