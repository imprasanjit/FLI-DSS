package com.sparc.flidss.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sparc.flidss.model.common.DistrictMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.ForestLandTypeMaster;
import com.sparc.flidss.model.common.RangeMaster;
import com.sparc.flidss.model.common.TehsilMaster;
import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;
import com.sparc.flidss.security.service.SecurityUtility;
import com.sparc.flidss.service.DBService;
import com.sparc.flidss.service.ForestLandDetailsService;
import com.sparc.flidss.service.ProgressMonitoringService;
import com.sparc.flidss.service.UtilityMasterService;
import com.sparc.flidss.utility.CustomUtility;
import com.sparc.flidss.viewmodel.progressmonitoring.IFpcppointDetails;
import com.sparc.flidss.viewmodel.progressmonitoring.IFrjvcCertifiedpointDetails;
import com.sparc.flidss.viewmodel.progressmonitoring.IOrsacCertifiedpointDetails;
import com.sparc.flidss.viewmodel.progressmonitoring.UvwNfbSummary;

@Controller
@RequestMapping("/ProgressMonitoring")
public class ProgressMonitoringController {
	@Autowired UtilityMasterService service; 
	@Autowired SecurityUtility securityUtility; 
	//@Autowired ForestLandDetailsService frlservice;
	@Autowired
	DBService dbservice;
	
	@Autowired 
	ProgressMonitoringService pms;
	
	@Autowired
	DistrictDivisionLinkMasterRepository distDivLinkRepo;
	
	@Autowired
	UtilityMasterService utility;
	
	@Async
	@RequestMapping("/nfbSummary")
	public String customQuery(Model model) {
		
			try {
				List<ForestLandTypeMaster> fLandType = service.GetForestLandType();
				List<DistrictMaster> distList = service.GetDistrictList();
				List<DivisionMaster> divList = service.GetDivisionList();
				List<RangeMaster> rngList = service.GetRangeList();
				List<TehsilMaster> tehsList = service.GetTehsilList();
				model.addAttribute("fLandType", fLandType);
				model.addAttribute("distList", distList);
				model.addAttribute("divList", divList.stream().filter(f->f.getIntId()>0).collect(Collectors.toList()));
				model.addAttribute("rngList", rngList);
				model.addAttribute("tehsList", tehsList);

				//model.addAttribute("customFieldsNfb", utility.getCustomQueryFieldsNFB());

			} catch (Exception ex) {
				throw ex;
			}
		
		return "/progressmonitoring/frjvcDetails";
	}
	
	@RequestMapping("/nfbSummaryPartial2")		
	public String customQueryPartial2(@RequestParam Integer land_type, @RequestParam Integer selection,
			@RequestParam Integer dist_id, @RequestParam Integer div_id, @RequestParam Integer tahasil_id,
			@RequestParam String range_code, @RequestParam String info, @RequestParam String condn,
			@RequestParam String operator, @RequestParam Double opvalue, Model model,@RequestParam String cq){
		
		info = info.replace("[", "").replace("]", "").replace("\"", "").replace(" ", "");
		String[] selectedFields = info.split(",");

		List<String> convertArrayToStringList = CustomUtility.convertArrayToStringList(selectedFields);

		model.addAttribute("selectedFields", convertArrayToStringList);

		model.addAttribute("landType", land_type);
		model.addAttribute("fSelection", selection);
		
		cq=!cq.isBlank()?" and "+cq:"";
		
		cq+=dist_id>0?" and int_fk_district="+dist_id:"";
		cq+=div_id>0?" and int_fk_division="+div_id:"";
		
		
		String defQry=condn+" "+operator+" "+(opvalue>=0?opvalue:"");
		cq+=!defQry.isBlank()?" and "+defQry:"";
		
		if (land_type == 1) // Notified Forest
		{
			List<UvwNfbSummary> nfbDetails = pms.getNfbSummary(cq);
			model.addAttribute("nfbList", nfbDetails);
		}
		
		return "/progressmonitoring/nfbSummaryPartial";
	}
	
	/**
	 * FRJVC Details
	 * @param model
	 * @return
	 */
	@Async
	@RequestMapping("/frjvcDetails")
	public String frjvcDetails(Model model,HttpSession session) {
		/*
		 * String url = securityUtility.checkAuthority(4, 5); try { if
		 * (url.equalsIgnoreCase("dss/customQuery")) { url =
		 * "/progressmonitoring/frjvcDetails";
		 */
				try {
					List<ForestLandTypeMaster> fLandType = service.GetForestLandType();
					//List<DistrictMaster> distList = service.GetDistrictList();
					//List<DivisionMaster> divList = service.GetDivisionList().stream().filter(f->f.getPhaseMaster().getIntPhase()==1).collect(Collectors.toList());
					Integer distId = session.getAttribute("distID")!=null?Integer.parseInt(session.getAttribute("distID").toString()):0;
					Integer divId = session.getAttribute("divID")!=null?Integer.parseInt(session.getAttribute("divID").toString()):0;
					
					List<Integer> dividsByDivid = new ArrayList<Integer>();

					if (distId != null && Integer.parseInt(distId.toString()) > 0) {
						/*dividsByDist = distDivLinkRepo.findByDistId(distId).stream()
								.map(m -> m.getDivisionMaster().getIntId()).collect(Collectors.toList());*/
						dividsByDivid = distDivLinkRepo.getDivisionMaster(divId).stream()
								.map(m -> m.getDivisionMaster().getIntId()).collect(Collectors.toList());
					} else {
						if (divId > 0) {
							dividsByDivid.add(divId);
						}

					}
					var divids = dividsByDivid;
					List<DistrictMaster> distList = utility.GetDistrictList().stream()
							.filter(f -> f.getIntId() == (distId > 0 ? distId : (divId > 0 ? -1 : f.getIntId())))
							.collect(Collectors.toList());
					distList.sort((p1, p2) -> p1.getChrvDistrictNm().compareTo(p2.getChrvDistrictNm()));

	//here we have done division id wise permission after login the user will get only division dropdown accordingly divid from session
					List<DivisionMaster> divList= new ArrayList<DivisionMaster>();
					//for admin role
					if(divId==0 && distId==0) {
					 divList = utility.GetDivisionList().stream()
							.filter(f -> f.getIntId() > 0 && (!divids.isEmpty() ? divids.contains(f.getIntId()) : true)
									&& f.getPhaseMaster().getIntPhase() == 1 /*|| f.getPhaseMaster().getIntPhase()==2 
											 || f.getPhaseMaster().getIntPhase()==3 
																			   || f.getPhaseMaster().getIntPhase()==4*/ )
							.collect(Collectors.toList());
					divList.sort((d1, d2) -> d1.getChrvDivisionNm().compareTo(d2.getChrvDivisionNm()));
					}
					//for others official role
					else {
						 divList = utility.GetDivisionList().stream()
								.filter(f -> f.getIntId() > 0 && (!divids.isEmpty() ? divids.contains(f.getIntId()) : true))
								.collect(Collectors.toList());
					}
					//List<RangeMaster> rngList = service.GetRangeList();
					//List<TehsilMaster> tehsList = service.GetTehsilList();
					model.addAttribute("fLandType", fLandType);
					model.addAttribute("distList", distList);
					model.addAttribute("divList", divList.stream().filter(f->f.getIntId()>0).collect(Collectors.toList()));
					//model.addAttribute("rngList", rngList);
					//model.addAttribute("tehsList", tehsList);

					//model.addAttribute("customFieldsNfb", utility.getCustomQueryFieldsNFB());

				} catch (Exception ex) {
					//throw ex;
				}
			//}
	/*
	 * } catch (Exception e) { // TODO Auto-generated catch block
	 * //e.printStackTrace(); }
	 */
		return "/progressmonitoring/frjvcDetails";
	}
	
	@RequestMapping("/partialFrjvcDetails")		
	public String partialFrjvcDetails(@RequestParam Integer land_type, @RequestParam Integer selection,
			@RequestParam Integer dist_id, @RequestParam Integer div_id, @RequestParam Integer tahasil_id,
			@RequestParam String range_code, @RequestParam String info, @RequestParam(required = false) String condn,
			@RequestParam(required = false) String operator, @RequestParam(required = false) Double opvalue, Model model,@RequestParam(required = false) String cq){
		
		info = info.replace("[", "").replace("]", "").replace("\"", "").replace(" ", "");
		String[] selectedFields = info.split(",");

		List<String> convertArrayToStringList = CustomUtility.convertArrayToStringList(selectedFields);

		model.addAttribute("selectedFields", convertArrayToStringList);

		model.addAttribute("landType", land_type);
		model.addAttribute("fSelection", selection);
		
		cq=!cq.isBlank()?" and "+cq:"";
		
		cq+=dist_id>0?" and int_fk_district="+dist_id:"";
		cq+=div_id>0?" and int_fk_division="+div_id:"";
		cq+=range_code!=null?" and chrv_fk_range_cd="+'\'' + range_code + '\'':"";
		
		
		String defQry=condn+" "+operator+" "+(opvalue>=0?opvalue:"");
		//cq+=!defQry.isBlank()?" and "+defQry:"";
		
		if (land_type == 1) // Notified Forest
		{
			List<UvwNfbSummary> nfbDetails = pms.getNfbSummary(cq);
			model.addAttribute("nfbList", nfbDetails);
		}
		
		return "/progressmonitoring/partialFrjvcDetails";
	}
	

	@Async
	@RequestMapping(value = "/frjvcCerPointDetailsview", method = RequestMethod.GET)
	public String frjvcCertifiedpointDetailsview(@RequestParam Integer nfbId,Model model) {
		try {
			UvwNfbSummary nfbSummary = pms.getNfbSummary(nfbId);
			 model.addAttribute("frjvcMaster", nfbSummary);
			 model.addAttribute("frjvcPointDtls", pms.getFrjvcCertifiedPointDetailsFindByNfbId(nfbId));
			
		} catch (Exception ex) {
			throw ex;
		}
		return "/progressmonitoring/partialFrjvcPoindDetails";
	}
	/**
	 * End of FRJVC Details
	 */
	
	/**
	 * @implNote  map view of progress monitoring
	 * @return Partial View- pmMapView
	 * @author Smruti
	 * @throws Exception 
	 * @CDate 30 Nov 2021
	 */
	@RequestMapping(value = "/pmMapView", method = RequestMethod.GET)
	public String progressmonitoringmapview(Model model,@RequestParam Integer fbid) throws Exception {
		try {
			String jvlayerList="";
			String dgpslayerList="";
			String fscpLayerList="";
			String fpcpLayerList="";
			List<IFrjvcCertifiedpointDetails> jvPillarList = pms.getFrjvcCertifiedPointDetails(fbid);
			List<IOrsacCertifiedpointDetails> dgpsPillarList = pms.getOrsacCertifiedPointDetails(fbid);
			List<IOrsacCertifiedpointDetails> fscpPillarList = pms.getFscpPointDetails(fbid);
			
			List<IFpcppointDetails> fpcpPillarList = pms.getFpcpPointDetails(fbid);
			/*
			 * for(IFpcppointDetails res:fpcpPillarList) { Double decLatitude =
			 * res.getDecLatitude(); Double decLongitude = res.getDecLongitude(); }
			 */
			 ObjectMapper mapper = new ObjectMapper(); 
			 jvlayerList=mapper.writeValueAsString(jvPillarList);
			 dgpslayerList=mapper.writeValueAsString(dgpsPillarList);
			 fscpLayerList=mapper.writeValueAsString(fscpPillarList);
			 fpcpLayerList=mapper.writeValueAsString(fpcpPillarList);
			 model.addAttribute("jvPillarList", jvlayerList);
			 model.addAttribute("dgpsPillarList",dgpslayerList);
			 model.addAttribute("nfb_id", fbid);
			 model.addAttribute("fscpPillarList", fscpLayerList);
			 model.addAttribute("fpcpPillarList", fpcpLayerList);
			
		} catch (Exception ex) {
			throw ex;
		}
		
		return "/progressmonitoring/pmMapView";
	}	

	@Async
	@RequestMapping("/dgpsDetails")
	public String dgpsDetails(Model model,HttpSession session) {
		/*String url = securityUtility.checkAuthority(4, 5);
		if (url.equalsIgnoreCase("dss/customQuery")) {
			url = "/progressmonitoring/dgpsDetails";*/

			try {
				List<ForestLandTypeMaster> fLandType = service.GetForestLandType();
				/*List<DistrictMaster> distList = service.GetDistrictList();
				List<DivisionMaster> divList = service.GetDivisionList().stream().filter(f->f.getPhaseMaster().getIntPhase()==1).collect(Collectors.toList());;*/
				Integer distId = session.getAttribute("distID")!=null?Integer.parseInt(session.getAttribute("distID").toString()):0;
				Integer divId = session.getAttribute("divID")!=null?Integer.parseInt(session.getAttribute("divID").toString()):0;
				
				List<Integer> dividsByDivid = new ArrayList<Integer>();

				if (distId != null && Integer.parseInt(distId.toString()) > 0) {
					/*dividsByDist = distDivLinkRepo.findByDistId(distId).stream()
							.map(m -> m.getDivisionMaster().getIntId()).collect(Collectors.toList());*/
					dividsByDivid = distDivLinkRepo.getDivisionMaster(divId).stream()
							.map(m -> m.getDivisionMaster().getIntId()).collect(Collectors.toList());
				} else {
					if (divId > 0) {
						dividsByDivid.add(divId);
					}

				}
				var divids = dividsByDivid;
				List<DistrictMaster> distList = utility.GetDistrictList().stream()
						.filter(f -> f.getIntId() == (distId > 0 ? distId : (divId > 0 ? -1 : f.getIntId())))
						.collect(Collectors.toList());
				distList.sort((p1, p2) -> p1.getChrvDistrictNm().compareTo(p2.getChrvDistrictNm()));

//here we have done division id wise permission after login the user will get only division dropdown accordingly divid from session
				List<DivisionMaster> divList= new ArrayList<DivisionMaster>();
				//for admin role
				if(divId==0 && distId==0) {
				 divList = utility.GetDivisionList().stream()
						.filter(f -> f.getIntId() > 0 && (!divids.isEmpty() ? divids.contains(f.getIntId()) : true)
								&& f.getPhaseMaster().getIntPhase() == 1 /*|| f.getPhaseMaster().getIntPhase()==2 
										 || f.getPhaseMaster().getIntPhase()==3 
																		   || f.getPhaseMaster().getIntPhase()==4*/ )
						.collect(Collectors.toList());
				divList.sort((d1, d2) -> d1.getChrvDivisionNm().compareTo(d2.getChrvDivisionNm()));
				}
				//for others official role
				else {
					 divList = utility.GetDivisionList().stream()
							.filter(f -> f.getIntId() > 0 && (!divids.isEmpty() ? divids.contains(f.getIntId()) : true))
							.collect(Collectors.toList());
				}
				
				//List<RangeMaster> rngList = service.GetRangeList();
				//List<TehsilMaster> tehsList = service.GetTehsilList();
				model.addAttribute("fLandType", fLandType);
				model.addAttribute("distList", distList);
				model.addAttribute("divList", divList.stream().filter(f->f.getIntId()>0).collect(Collectors.toList()));
				//model.addAttribute("rngList", rngList);
				//model.addAttribute("tehsList", tehsList);

				//model.addAttribute("customFieldsNfb", utility.getCustomQueryFieldsNFB());

			} catch (Exception ex) {
				throw ex;
			}
		//}
		return "/progressmonitoring/dgpsDetails";
	}
	

	@RequestMapping("/partialDgpsDetails")		
	public String partialDgpsDetails(@RequestParam Integer land_type, @RequestParam Integer selection,
			@RequestParam Integer dist_id, @RequestParam Integer div_id, @RequestParam Integer tahasil_id,
			@RequestParam String range_code, @RequestParam String info, @RequestParam String condn,
			@RequestParam String operator, @RequestParam Double opvalue, Model model,@RequestParam String cq){
		
		info = info.replace("[", "").replace("]", "").replace("\"", "").replace(" ", "");
		String[] selectedFields = info.split(",");

		List<String> convertArrayToStringList = CustomUtility.convertArrayToStringList(selectedFields);

		model.addAttribute("selectedFields", convertArrayToStringList);

		model.addAttribute("landType", land_type);
		model.addAttribute("fSelection", selection);
		
		cq=!cq.isBlank()?" and "+cq:"";
		
		cq+=dist_id>0?" and int_fk_district="+dist_id:"";
		cq+=div_id>0?" and int_fk_division="+div_id:"";
		cq+=range_code!=null?" and chrv_fk_range_cd="+'\'' + range_code + '\'':""; //for range param filteration dynamic query inserted in single quote
		
		
		String defQry=condn+" "+operator+" "+(opvalue>=0?opvalue:"");
		//cq+=!defQry.isBlank()?" and "+defQry:"";
		
		if (land_type == 1) // Notified Forest
		{
			List<UvwNfbSummary> nfbDetails = pms.getNfbSummary(cq);
			model.addAttribute("nfbList", nfbDetails);
		}
		
		return "/progressmonitoring/partialDgpsDetails";
	}
	
	@Async
	@RequestMapping(value = "/dgpsCerPointDetailsview", method = RequestMethod.GET)
	public String dgpsCerPointDetailsview(@RequestParam Integer nfbId,Model model) {
		try {
			UvwNfbSummary nfbSummary = pms.getNfbSummary(nfbId);
			List<IOrsacCertifiedpointDetails> orsacCertifiedPointDetails = pms.getOrsacCertifiedPointDetails(nfbId);
			 model.addAttribute("frjvcMaster", nfbSummary);
			 model.addAttribute("frjvcPointDtls", orsacCertifiedPointDetails);
			
		} catch (Exception ex) {
			//throw ex;
		}
		return "/progressmonitoring/partialDgpsPoindDetails";
	}
	
	public List<Integer> getDivIdsbyDistOrDiv(HttpSession session) {

		Integer distId = session.getAttribute("distID") != null
				? Integer.parseInt(session.getAttribute("distID").toString())
				: 0;
		Integer divId = session.getAttribute("divID") != null
				? Integer.parseInt(session.getAttribute("divID").toString())
				: 0;
		List<Integer> dividsByDivId = new ArrayList<Integer>();

		if (distId != null && Integer.parseInt(distId.toString()) > 0) {
			/*dividsByDist = distDivLinkRepo.findByDistId(distId).stream().map(m -> m.getDivisionMaster().getIntId())
					.collect(Collectors.toList());*/
			dividsByDivId = distDivLinkRepo.getDivisionMaster(divId).stream().map(m -> m.getDivisionMaster().getIntId())
					.collect(Collectors.toList());
		} else {
			if (divId > 0) {
				dividsByDivId.add(divId);
			}
		}

		return dividsByDivId;
	}
	
}
