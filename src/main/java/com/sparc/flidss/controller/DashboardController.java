package com.sparc.flidss.controller;

import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sparc.flidss.repository.common.CircleMasterRepository;
import com.sparc.flidss.repository.common.DivisionMasterRepository;
import com.sparc.flidss.repository.common.NfbDetailsRepository;
import com.sparc.flidss.repository.common.NfbMasterRepository;
import com.sparc.flidss.repository.common.RevnueForestMasterRepository;
import com.sparc.flidss.security.service.SecurityUtility;
import com.sparc.flidss.service.DBService;
import com.sparc.flidss.service.DashboardService;
import com.sparc.flidss.service.UtilityChartService;
import com.sparc.flidss.viewmodel.ParentChildChart;
import com.sparc.flidss.viewmodel.TargetAchievement;

@Controller
public class DashboardController {
	@Autowired
	CircleMasterRepository circlerepo;
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

	@RequestMapping("/Dashboard")
	private ModelAndView Dashboard(HttpSession session) {

		ModelAndView modelView = new ModelAndView();
		String url = securityUtility.checkAuthority(8, 16);
		if (url != null && url.equalsIgnoreCase("Dashboard")) {
			url = "/dashboard/dashboard";

			/*
			 * try {
			 * 
			 * // Priority wise Compute the area. e.g-> if DGPS Final is available then left
			 * // other like wise..; Integer OrsacNfbAchv = (int) nfbrepo.findAll().stream()
			 * .mapToInt(f -> f.getNfbMaster() != null ? f.getNfbMaster().getIntId() :
			 * 0).distinct().count(); Double OrsacArea = nfbrepo.findAll().stream()
			 * .mapToDouble(f -> f.getDgpsfHa() != null && f.getDgpsfHa().doubleValue() > 0
			 * ? f.getDgpsfHa().doubleValue() * 0.01 : (f.getDgpsdHa() != null &&
			 * f.getDgpsdHa().doubleValue() > 0 ? f.getDgpsdHa().doubleValue() * 0.01 :
			 * (f.getJvHa() != null && f.getJvHa().doubleValue() > 0 ?
			 * f.getJvHa().doubleValue() * 0.01 : (f.getCmvHa() != null &&
			 * f.getCmvHa().doubleValue() > 0 ? f.getCmvHa().doubleValue() * 0.01 :
			 * (f.getMmvHa() != null && f.getMmvHa().doubleValue() > 0 ?
			 * f.getMmvHa().doubleValue() * 0.01 : 0))))) .sum();
			 * 
			 * Double DLCAreasum = revrepo.getTotalRevArea();
			 * 
			 * modelView.addObject("NFBArea", OrsacArea); modelView.addObject("DLCArea",
			 * DLCAreasum); modelView.addObject("TotalRevPlots",revrepo.getTotalRevPlots());
			 * modelView.addObject("NFBAchv", OrsacNfbAchv);
			 * 
			 * //modelView.addObject("stackedDrilldownParent", // new
			 * ObjectMapper().writeValueAsString(chartService.stackedDrilldownParent()));
			 * //modelView.addObject("stackedDrilldown", // new
			 * ObjectMapper().writeValueAsString(chartService.stackedDrilldownChild()));
			 * 
			 * } catch (Exception e) { // TODO Auto-generated catch block
			 * e.printStackTrace(); }
			 */
		}
		modelView.setViewName(url);
		return modelView;
	}

	@RequestMapping("/Dashboard/getTargetAchv")
	private @ResponseBody TargetAchievement getTargetAchv(@RequestParam(name = "phase") Set<Integer> phase) {
		TargetAchievement objTarAchv = new TargetAchievement();
		try {
			//var nfbAll = nfbrepo.getAllData();
			var nfbAll = nfbrepo.findAll();
			var divAll = divRepo.findAll();
			
			/*List<DivisionMaster> divAll=null;
			
			new Thread(new Runnable() {
				
				@Override
				public void run() {
					// TODO Auto-generated method 
					
					 divRepo.findAll();
				}
			}).start();
			
			var nfbAll = nfbrepo.findAll();*/

			Integer OrsacNfbAchv = (int) nfbAll.stream()
					.filter(f -> phase.contains(f.getDivisionMaster().getPhaseMaster().getIntPhase())
							&& f.isDelete != true && f.orsacClearenceDt != null)
					.mapToInt(f -> f.getNfbMaster() != null ? f.getNfbMaster().getIntId() : 0).distinct().count();
			Integer FsoNfbAchv = (int) nfbAll.stream()
					.filter(f -> phase.contains(f.getDivisionMaster().getPhaseMaster().getIntPhase())
							&& f.isDelete != true && f.fsoCertificationDt != null)
					.mapToInt(f -> f.getNfbMaster() != null ? f.getNfbMaster().getIntId() : 0).distinct().count();
			Integer RenotifiNfbAchv = (int) nfbAll.stream()
					.filter(f -> phase.contains(f.getDivisionMaster().getPhaseMaster().getIntPhase())
							&& f.isDelete != true && f.renotificationPropDt != null)
					.mapToInt(f -> f.getNfbMaster() != null ? f.getNfbMaster().getIntId() : 0).distinct().count();

			/*
			 * Double OrsacArea =
			 * nfbAll.stream().filter(f->phase.contains(f.getDivisionMaster().getPhaseMaster
			 * ().getIntPhase()) && f.isDelete!=true) .mapToDouble(f -> f.getDgpsfHa() !=
			 * null && f.getDgpsfHa().doubleValue() > 0 ? f.getDgpsfHa().doubleValue() *
			 * 0.01 : (f.getDgpsdHa() != null && f.getDgpsdHa().doubleValue() > 0 ?
			 * f.getDgpsdHa().doubleValue() * 0.01 : (f.getJvHa() != null &&
			 * f.getJvHa().doubleValue() > 0 ? f.getJvHa().doubleValue() * 0.01 :
			 * (f.getCmvHa() != null && f.getCmvHa().doubleValue() > 0 ?
			 * f.getCmvHa().doubleValue() * 0.01 : (f.getMmvHa() != null &&
			 * f.getMmvHa().doubleValue() > 0 ? f.getMmvHa().doubleValue() * 0.01 :
			 * 0))))).sum();
			 */

			Double OrsacArea = nfbAll.stream()
					.filter(f -> phase.contains(f.getDivisionMaster().getPhaseMaster().getIntPhase())
							&& f.isDelete != true && f.orsacClearenceDt != null)
					.mapToDouble(f -> f.getDgpsfHa() != null && f.getDgpsfHa().doubleValue() > 0
							? f.getDgpsfHa().doubleValue() * 0.01
							: 0)
					.sum();
			Double FsoArea = nfbAll.stream()
					.filter(f -> phase.contains(f.getDivisionMaster().getPhaseMaster().getIntPhase())
							&& f.isDelete != true && f.fsoCertificationDt != null)
					.mapToDouble(f -> f.getDgpsfHa() != null && f.getDgpsfHa().doubleValue() > 0
							? f.getDgpsfHa().doubleValue() * 0.01
							: 0)
					.sum();
			Double RenotifiArea = nfbAll.stream()
					.filter(f -> phase.contains(f.getDivisionMaster().getPhaseMaster().getIntPhase())
							&& f.isDelete != true && f.renotificationPropDt != null)
					.mapToDouble(f -> f.getDgpsfHa() != null && f.getDgpsfHa().doubleValue() > 0
							? f.getDgpsfHa().doubleValue() * 0.01
							: 0)
					.sum();

			objTarAchv.setTargetNfbNos((int) divAll.stream().filter(f -> phase.contains(f.getPhaseMaster().getIntPhase()))
							.mapToInt(m -> m.getDecNoOfFbs() != null ? m.getDecNoOfFbs() : 0).sum());

			//Target of Notified forest block
			objTarAchv.setTargetNfbA(divAll.stream().filter(f -> phase.contains(f.getPhaseMaster().getIntPhase()))
					.mapToDouble(m -> m.getDecNfbAreaSkm() != null ? m.getDecNfbAreaSkm() : 0).sum());

			//Target of Revenue and DLC forest
			objTarAchv.setTargetRecordedFA(divAll.stream().filter(f -> phase.contains(f.getPhaseMaster().getIntPhase()))
					.mapToDouble(m -> m.getDecRevenueLand() != null ? m.getDecRevenueLand() : 0).sum());
			
			//Target of Deemed forest
			objTarAchv.setTargetDeemedA(divAll.stream().filter(f -> phase.contains(f.getPhaseMaster().getIntPhase()))
					.mapToDouble(m -> m.getDecDeemedforestAreaSkm() != null ? m.getDecDeemedforestAreaSkm() : 0).sum());
			
			//Achievement of Revenue and DLC forest
			objTarAchv.setAchvRecordedFAPlots(revrepo.getTotalRevPlots(phase));
			objTarAchv.setAchvRecordedFA(revrepo.getTotalRevArea(phase));
			objTarAchv.setAchvDLCPlots(revrepo.getTotalDLCPlots(phase));
			objTarAchv.setAchvDLCA(revrepo.getTotalDLCArea(phase));
			
			//total notified forest block count
			objTarAchv.setOrsacCertification(OrsacNfbAchv);
			objTarAchv.setFsoCertification(FsoNfbAchv);
			objTarAchv.setReNotification(RenotifiNfbAchv);

			//notified forest no of block achievement area
			objTarAchv.setOrsacCertificationVal(OrsacArea);
			objTarAchv.setFsoCertificationVal(FsoArea);
			objTarAchv.setReNotificationVal(RenotifiArea);

		} catch (Exception e) {
			// e.printStackTrace();
		}

		return objTarAchv;
	}

	@RequestMapping("/Dashboard/getChart")
	private @ResponseBody ParentChildChart getChart(@RequestParam(name = "phase") Set<Integer> phase) {
		ParentChildChart objChartList = new ParentChildChart();

		objChartList.setParent(chartService.stackedDrilldownParent(phase));//chat data for circle
		objChartList.setChild(chartService.stackedDrilldownChild(phase));//chat data for div and rng 
		return objChartList;
	}
}
