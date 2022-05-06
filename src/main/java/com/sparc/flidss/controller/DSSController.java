package com.sparc.flidss.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.TreeMap;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.servlet.http.HttpSession;

import org.apache.taglibs.standard.lang.jstl.GreaterThanOrEqualsOperator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.spel.ast.Operator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sparc.flidss.model.common.DistrictDivisionLinkMaster;
import com.sparc.flidss.model.common.DistrictMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.ForestLandTypeMaster;
import com.sparc.flidss.model.common.GlobalLinkMaster;
import com.sparc.flidss.model.common.NfbDetail;
import com.sparc.flidss.model.common.NfbMaster;
import com.sparc.flidss.model.common.RangeMaster;
import com.sparc.flidss.model.common.RevnueForestMaster;
import com.sparc.flidss.model.common.TehsilMaster;
import com.sparc.flidss.model.common.VectorMasterData;
import com.sparc.flidss.model.common.VillageMaster;
import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;
import com.sparc.flidss.security.service.SecurityUtility;
import com.sparc.flidss.service.DBService;
import com.sparc.flidss.service.ForestLandDetailsService;
import com.sparc.flidss.service.UtilityMasterService;
import com.sparc.flidss.utility.CustomUtility;
import com.sparc.flidss.utility.ValueText;
import com.sparc.flidss.viewmodel.AOIAnalysisViewModel;
import com.sparc.flidss.viewmodel.AOIViewModel;
import com.sparc.flidss.viewmodel.POIViewModel;
import com.sparc.flidss.viewmodel.SP_NFBViewModel;
import com.sparc.flidss.viewmodel.UvwNfbDetails;



@Controller
public class DSSController {
	/**
	 * @implNote AOI Analysis
	 * @return Page-aoiAnalysis
	 * @author Smita
	 * @CDate 18 April 2021
	 */

	@Autowired
	SecurityUtility securityUtility;
	@Autowired
	UtilityMasterService utility;
	@Autowired
	ForestLandDetailsService frlservice;
	@Autowired
	DistrictDivisionLinkMasterRepository distDivLinkRepo;

	@RequestMapping("DSS/aoiAnalysis")
	public String aoiAnalysis() {
		return "/dss/aoiAnalysis";
	}

	@GetMapping("DSS/aoiAnalysis2")
	public String aoiAnalysis2() {

		String url = securityUtility.checkAuthority(4, 4);
		if (url.equalsIgnoreCase("dss/aoiAnalysis2")) {
			url = "/dss/aoiAnalysis2";
		}
		return url;

//	System.out.println("user:"+ listPermisson);

	}

	@RequestMapping("DSS/poiAnalysis")
	public String poiAnalysis() {

		return "/dss/poiAnalysis";
	}

	@RequestMapping("/DSS/customQuery")
	public String customQuery(Model model,HttpSession session) {
		String url = securityUtility.checkAuthority(4, 5);
		if (url.equalsIgnoreCase("dss/customQuery")) {
			url = "/dss/customQuery";

			try {
				Integer distId = session.getAttribute("distID")!=null?Integer.parseInt(session.getAttribute("distID").toString()):0;
				Integer divId = session.getAttribute("divID")!=null?Integer.parseInt(session.getAttribute("divID").toString()):0;
				List<Integer> dividsByDist = new ArrayList<Integer>();
				
				if(distId!=null && Integer.parseInt(distId.toString())>0) {
					dividsByDist = distDivLinkRepo.findByDistId(distId)
				.stream().map(m->m.getDivisionMaster().getIntId()).collect(Collectors.toList());
				}
				else {
						if(divId>0) {
						dividsByDist.add(divId);
						}
					
				}
				var divids=dividsByDist;

				
				
				List<ForestLandTypeMaster> fLandType = utility.GetForestLandType();
				List<DistrictMaster> distList = utility.GetDistrictList().stream().filter(f->f.getIntId()==(distId>0?distId:(divId>0?-1:f.getIntId()) )).collect(Collectors.toList());
				
				List<DivisionMaster> divList = utility.GetDivisionList().stream()
						.filter(f -> f.getIntId() > 0 && (!divids.isEmpty()? divids.contains(f.getIntId()):true) && f.getPhaseMaster().getIntId() == 1)
						.collect(Collectors.toList());
				List<RangeMaster> rngList = utility.GetRangeList();
				List<TehsilMaster> tehsList = utility.GetTehsilList();
				model.addAttribute("fLandType", fLandType);
				model.addAttribute("distList", distList);
				model.addAttribute("divList", divList.stream().filter(f->f.getIntId()>0).collect(Collectors.toList()));
				//model.addAttribute("rngList", rngList);
				//model.addAttribute("tehsList", tehsList);

				//model.addAttribute("customFieldsNfb", utility.getCustomQueryFieldsNFB());

			} catch (Exception ex) {
				throw ex;
			}
		}
		return url;
	}

	@RequestMapping("/DSS/customQueryPartial")
	public String partialForestLandDetails(@RequestParam Integer land_type, @RequestParam Integer selection,
			@RequestParam Integer dist_id, @RequestParam Integer div_id, @RequestParam Integer tahasil_id,
			@RequestParam String range_code, @RequestParam String info, @RequestParam String condn,
			@RequestParam String operator, @RequestParam Double opvalue, Model model) {

		info = info.replace("[", "").replace("]", "").replace("\"", "").replace(" ", "");
		String[] selectedFields = info.split(",");

		List<String> convertArrayToStringList = CustomUtility.convertArrayToStringList(selectedFields);

		model.addAttribute("selectedFields", convertArrayToStringList);

		model.addAttribute("landType", land_type);
		model.addAttribute("fSelection", selection);
		
		if (land_type == 1) // Notified Forest
		{
			List<NfbDetail> nfbList = new ArrayList<NfbDetail>();
			
			switch (condn) {
			case "nareaHa":
				if(operator.equals("<=") && opvalue!=null) {
				nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
					.stream().filter(f->(f.getNfbMaster().getNareaHa() !=null? f.getNfbMaster().getNareaHa().doubleValue():0) <= opvalue).collect(Collectors.toList());
				}
				else if(operator.equals(">=")) {
					nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
							.stream().filter(f->(f.getNfbMaster().getNareaHa()!=null? f.getNfbMaster().getNareaHa().doubleValue():0) >= opvalue).collect(Collectors.toList());
				}
				else if(operator.equals("==")) {
					nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
							.stream().filter(f->(f.getNfbMaster().getNareaHa()!=null? f.getNfbMaster().getNareaHa().doubleValue():0) == opvalue).collect(Collectors.toList());
				}
				break;
				
			case "dgpsfHa":
				if(operator.equals("<=")) {
					nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
							.stream().filter(f->(f.getDgpsdHa()!=null? f.getDgpsdHa().doubleValue() :0) <= opvalue).collect(Collectors.toList());
					}
					else if(operator.equals(">=")) {
						nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
								.stream().filter(f->(f.getDgpsdHa()!=null? f.getDgpsdHa().doubleValue() :0) >= opvalue).collect(Collectors.toList());
					}
					else if(operator.equals("==")) {
						nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
								.stream().filter(f->(f.getDgpsdHa()!=null? f.getDgpsdHa().doubleValue() :0) == opvalue).collect(Collectors.toList());
					}
				break;
				
			case "jvHa":
				if(operator.equals("<=")) {
					nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
							.stream().filter(f->(f.getJvHa()!=null? f.getJvHa().doubleValue():0) <= opvalue).collect(Collectors.toList());
					}
					else if(operator.equals(">=")) {
						nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
								.stream().filter(f->(f.getJvHa()!=null? f.getJvHa().doubleValue():0) >= opvalue).collect(Collectors.toList());
					}
					else if(operator.equals("==")) {
						nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
								.stream().filter(f->(f.getJvHa()!=null? f.getJvHa().doubleValue():0) == opvalue).collect(Collectors.toList());
					}
				break;
			case "cmvHa":
				if(operator.equals("<=")) {
					nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
							.stream().filter(f->(f.getCmvHa()!=null?f.getCmvHa().doubleValue():0) <= opvalue).collect(Collectors.toList());
					}
					else if(operator.equals(">=")) {
						nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
								.stream().filter(f->(f.getCmvHa()!=null?f.getCmvHa().doubleValue():0) >= opvalue).collect(Collectors.toList());
					}
					else if(operator.equals("==")) {
						nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code)
								.stream().filter(f->(f.getCmvHa()!=null?f.getCmvHa().doubleValue():0) == opvalue).collect(Collectors.toList());
					}
				break;

			default:
				nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id, tahasil_id, range_code);
				break;
			}
			
			model.addAttribute("nfbList", nfbList);
			
		} else if (land_type == 2) // Revnue Forest
		{
			List<RevnueForestMaster> revFList = new ArrayList<RevnueForestMaster>();
			int page_size = 1000;
			model.addAttribute("page_size", page_size);
			
			switch (condn) {
			case "plot_no":
				/*if(operator.equals("<=") && opvalue!=null) {
					revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getPlotNo()!=null?f.getPlotNo().doubleValue():0)<=opvalue).collect(Collectors.toList());
					model.addAttribute("revenueList", revFList);
				}
				else if(operator.equals(">=")) {
					revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getPlotNo()!=null?f.getPlotNo().doubleValue():0)>=opvalue).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}*/
				 if(operator.equals("==")) {
					revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getPlotNo()!=null?f.getPlotNo():"0").equals(opvalue.toString())).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}
				break;
				
			case "area_ac":
				if(operator.equals("<=") && opvalue!=null) {
					revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getAreaAc() !=null?f.getAreaAc().doubleValue():0)<=opvalue).collect(Collectors.toList());
					model.addAttribute("revenueList", revFList);
				}
				else if(operator.equals(">=")) {
					revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getAreaAc()!=null?f.getAreaAc().doubleValue():0)>=opvalue).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}
				else if(operator.equals("==")) {
					revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getAreaAc()!=null?f.getAreaAc().doubleValue():0)==opvalue).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}
				break;
			case "publYear":
				if(operator.equals("<=") && opvalue!=null) {
					revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getPublYear() !=null?f.getPublYear().doubleValue():0)<=opvalue).collect(Collectors.toList());
					model.addAttribute("revenueList", revFList);
				}
				else if(operator.equals(">=")) {
					revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getPublYear()!=null?f.getPublYear().doubleValue():0)>=opvalue).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}
				else if(operator.equals("==")) {
					revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getPublYear()!=null?f.getPublYear().doubleValue():0)==opvalue).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}
				break;
			
				default:
					revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size);
					model.addAttribute("revenueList", revFList);
					break;
				
			}
			
			model.addAttribute("revenueList", revFList);

		} else if (land_type == 3) { // DLC Forest
			List<RevnueForestMaster> revFList = new ArrayList<RevnueForestMaster>();
			int page_size = 10000;
			model.addAttribute("page_size", page_size);
			
			switch (condn) {
			case "plot_no":
				/*if(operator.equals("<=") && opvalue!=null) {
					revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getDlc().equals("Y") && f.getPlotNo()!=null?f.getPlotNo():0)<=opvalue).collect(Collectors.toList());
					model.addAttribute("revenueList", revFList);
				}*/
				/*
				 * else if(operator.equals(">=")) { revFList =
				 * frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id,
				 * range_code, 0,
				 * page_size).stream().filter(f->(f.getPlotNo()!=null?f.getPlotNo().doubleValue(
				 * ):0)>=opvalue).collect(Collectors.toList());;
				 * model.addAttribute("revenueList", revFList); }
				 */
				 if(operator.equals("==")) {
					revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getPlotNo()!=null?f.getPlotNo():"0").equals(opvalue.toString())).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}
				break;
				
			case "area_ac":
				if(operator.equals("<=") && opvalue!=null) {
					revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getAreaAc() !=null?f.getAreaAc().doubleValue():0)<=opvalue).collect(Collectors.toList());
					model.addAttribute("revenueList", revFList);
				}
				else if(operator.equals(">=")) {
					revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getAreaAc()!=null?f.getAreaAc().doubleValue():0)>=opvalue).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}
				else if(operator.equals("==")) {
					revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getAreaAc()!=null?f.getAreaAc().doubleValue():0)==opvalue).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}
				break;
				
			case "publYear":
				if(operator.equals("<=") && opvalue!=null) {
					revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getPublYear() !=null?f.getPublYear().doubleValue():0)<=opvalue).collect(Collectors.toList());
					model.addAttribute("revenueList", revFList);
				}
				else if(operator.equals(">=")) {
					revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getPublYear()!=null?f.getPublYear().doubleValue():0)>=opvalue).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}
				else if(operator.equals("==")) {
					revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size).stream().filter(f->(f.getPublYear()!=null?f.getPublYear().doubleValue():0)==opvalue).collect(Collectors.toList());;
					model.addAttribute("revenueList", revFList);
				}
				break;
			
				default:
					revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size);
					model.addAttribute("revenueList", revFList);
					break;
				
			}
			
			model.addAttribute("revenueList", revFList);
		}
		return "/dss/customQueryPartial";
	}
	
	@Autowired
	DBService dbservice;
			
	@RequestMapping("/DSS/customQueryPartial2")		
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
		
		//cq+=dist_id>0?" and int_fk_district="+dist_id:"";
		//cq+=div_id>0?" and int_fk_division="+div_id:"";
		//cq+=tahasil_id>0?" and int_fk_division="+div_id:"";
		
		String defQry=condn+" "+operator+" "+(opvalue>=0?opvalue:"");
		cq+=!defQry.isBlank()?" and "+defQry:"";
		
		if (land_type == 1) // Notified Forest
		{
			//cq+=dist_id>0?" and int_fk_district="+dist_id:"";
			//cq+=tahasil_id>0?" and int_fk_division="+tahasil_id:"";
			
			Set<Integer> divIds = distDivLinkRepo.findAll().stream().filter(f->f.getDistrictMaster().getIntId()==dist_id).map(m->m.getDivisionMaster().getIntId()).collect(Collectors.toSet());
			
			
			cq+=div_id>0?" and int_fk_division ="+div_id: dist_id>0?" and int_fk_division in("+divIds+")":""; ;
			cq+=range_code.length()>1?" and chrv_fk_range_cd='"+range_code+"'":"";
			
			
			
			List<UvwNfbDetails> nfbDetails = dbservice.getNfbDetails(cq);
			model.addAttribute("nfbList", nfbDetails);
		}
		else if (land_type == 2) // DLC Forest
		{
			List<RevnueForestMaster> revFList = new ArrayList<RevnueForestMaster>();
			int page_size = 1000;
			model.addAttribute("page_size", page_size);
			
					revFList = dbservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size,cq).stream().collect(Collectors.toList());
					model.addAttribute("revenueList", revFList);
			
		} else if (land_type == 3) { // Other Revenue Forest
			
			List<RevnueForestMaster> revFList = new ArrayList<RevnueForestMaster>();
			int page_size = 1000;
			model.addAttribute("page_size", page_size);
			
					revFList = dbservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
							page_size,cq).stream().collect(Collectors.toList());
					model.addAttribute("revenueList", revFList);
		}
	
		return "/dss/customQueryPartial";
	}
	

	// @RequestMapping(value = "/DSS/customQueryPartial2", method = RequestMethod.GET)
	// public String partialForestLandDetails(@RequestParam Integer land_type, @RequestParam Integer selection,
	// 		@RequestParam Integer dist_id, @RequestParam Integer div_id, @RequestParam Integer tahasil_id,
	// 		@RequestParam String range_code, Model model) {
	// 	model.addAttribute("landType", land_type);
	// 	model.addAttribute("fSelection", selection);
	// 	if (land_type == 1) // Notified Forest
	// 	{
	// 		List<NfbMaster> nfbList = new ArrayList<NfbMaster>();
	// 		nfbList = frlservice.getNFBList(model, selection, dist_id, div_id, tahasil_id, range_code);
	// 		model.addAttribute("nfbList", nfbList);
	// 	}
	// 	else if (land_type == 2) // Revnue Forest
	// 	{
	// 		List<RevnueForestMaster> revFList = new ArrayList<RevnueForestMaster>();
	// 		int page_size = 1000;
	// 		model.addAttribute("page_size", page_size);
	// 		revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
	// 				page_size);
	// 		model.addAttribute("revenueList", revFList);

	// 	} else if (land_type == 3) { // DLC Forest
	// 		List<RevnueForestMaster> revFList = new ArrayList<RevnueForestMaster>();
	// 		int page_size = 1000;
	// 		model.addAttribute("page_size", page_size);
	// 		revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
	// 				page_size);
	// 		model.addAttribute("revenueList", revFList);
	// 	}
	// 	//return "/dss/customQueryPartial";
	// 	return "/fld/partialForestLandDetails";

	// }








	@RequestMapping("DSS/getFeatureInfo")
	public @ResponseBody List<Object[]> getFeatureInfo(@RequestParam String featureGeom, @RequestParam String layer) {
		List<Object[]> objList = new ArrayList<Object[]>();
		return objList;
	}
	
	@RequestMapping(value = "/DSS/DSSAnalysis", method = RequestMethod.GET)
	public String revisedAOI(Model model) {
		try {
			return "/dss/RevisedAOI";
		} catch (Exception ex) {
			throw ex;
		}
	}
	/**
	 * @implNote  POI details
	 * @param (geom)
	 * @author Smruti
	 * @CDate 21 OCt 2021
	 */
	@RequestMapping(value = "/getPOIGeom", method = RequestMethod.GET)
	public @ResponseBody List<POIViewModel> LoadPOI(Model model, @RequestParam(required = false) String geom) throws JsonProcessingException {
		try {
		         String poiData="";
		        // POIViewModel v=new POIViewModel();
		         //v.setDivision_name("Angul");
		         
				 List<POIViewModel> poiList = frlservice.getPOI(geom);
				 
				// List<POIViewModel> poiList=new ArrayList<POIViewModel>();																	 
				 //poiList.add(v);
				  ObjectMapper mapper = new ObjectMapper(); 
				  poiData=mapper.writeValueAsString(poiList);
							
			return poiList;
		} catch (Exception ex) {
			throw ex;
		}
	}
	/**
	 * @implNote  AOI details
	 * @param (geom)
	 * @author Smruti
	 * @CDate 21 OCt 2021
	 */
	@RequestMapping(value = "/getAOIGeom", method = RequestMethod.GET)
	public @ResponseBody String LoadAOI(Model model, @RequestParam(required = false) String geom,@RequestParam(required = false) String bgeom) throws JsonProcessingException {
		try {
		         String aoiData="";
		         
				 List<AOIViewModel> aoiList = frlservice.getAOI(geom,bgeom);
					
					  
					 // List<AOIViewModel> aoiList1 = frlservice.getAOI(geom,bgeom).stream().collect(Collectors.groupingBy(VillageMaster::getVillName, TreeMap::new, Collectors.toList());
				 
						/*
						 * List<AOIViewModel> collectGL = frlservice.getAOI(geom,bgeom).stream() .map(a
						 * -> a.getVillg_name()).distinct().sorted(Comparator.comparing(VillageMaster::
						 * getVillName)) .collect(Collectors.toList());
						 */
				 
					/*
					 * List<AOIViewModel> dlist = frlservice.getAOI(geom,bgeom).stream()
					 * .sorted(Comparator.comparing(VillageMaster::getVillName)).collect(Collectors.
					 * toList());
					 */
				 
				 //List<AOIViewModel> aoiList=new ArrayList<AOIViewModel>();																	 				
				  ObjectMapper mapper = new ObjectMapper(); 
				  aoiData=mapper.writeValueAsString(aoiList);
							
			return aoiData;
		} catch (Exception ex) {
			throw ex;
		}
	}
	
	
	/**
	 * @implNote  AOI Analysis
	 * @param (geom)
	 * @author Smruti
	 * @CDate 28 OCt 2021
	 */
	@RequestMapping(value = "/getAOIAnalysis", method = RequestMethod.GET)
	public @ResponseBody String LoadAOIAnalysis(Model model, @RequestParam(required = false) String geom,@RequestParam(required = false) String bgeom) throws JsonProcessingException {
		try {
		         String aoiAnalysisData="";
		         
				 List<AOIAnalysisViewModel> aoiAnalysisList = frlservice.getAOIAnalysis(geom,bgeom);																	 
				
				  ObjectMapper mapper = new ObjectMapper(); 
				  aoiAnalysisData=mapper.writeValueAsString(aoiAnalysisList);
							
			return aoiAnalysisData;
		} catch (Exception ex) {
			throw ex;
		}
	}
	/*
	 * @RequestMapping("/DSS/customQuery") public String customQuery(Model model) {
	 * String url =securityUtility.checkAuthority(4, 5);
	 * if(url.equalsIgnoreCase("dss/customQuery")) { url="/dss/customQuery";
	 * 
	 * try { List<ForestLandTypeMaster> fLandType = utility.GetForestLandType();
	 * List<DistrictMaster> distList = utility.GetDistrictList();
	 * List<DivisionMaster> divList = utility.GetDivisionList(); List<RangeMaster>
	 * rngList = utility.GetRangeList(); List<TehsilMaster> tehsList =
	 * utility.GetTehsilList(); model.addAttribute("fLandType", fLandType);
	 * model.addAttribute("distList", distList); model.addAttribute("divList",
	 * divList); model.addAttribute("rngList", rngList);
	 * model.addAttribute("tehsList", tehsList);
	 * 
	 * model.addAttribute("customFieldsNfb",utility.getCustomQueryFieldsNFB());
	 * 
	 * } catch (Exception ex) { throw ex; } } return url; }
	 * 
	 * @RequestMapping("/DSS/customQueryPartial") public String
	 * partialForestLandDetails(@RequestParam Integer land_type, @RequestParam
	 * Integer selection,
	 * 
	 * @RequestParam Integer dist_id, @RequestParam Integer div_id, @RequestParam
	 * Integer tahasil_id,
	 * 
	 * @RequestParam String range_code,@RequestParam String info, Model model) {
	 * 
	 * info=info.replace("[","").replace("]", "").replace("\"", "").replace(" ",
	 * ""); String[] selectedFields=info.split(",");
	 * 
	 * List<String> convertArrayToStringList =
	 * CustomUtility.convertArrayToStringList(selectedFields);
	 * 
	 * model.addAttribute("selectedFields", convertArrayToStringList);
	 * 
	 * model.addAttribute("landType", land_type); model.addAttribute("fSelection",
	 * selection); if (land_type == 1) // Notified Forest { List<NfbDetail> nfbList
	 * = new ArrayList<NfbDetail>(); nfbList = frlservice.getNFBDetails(model,
	 * selection, dist_id, div_id, tahasil_id, range_code);
	 * 
	 * model.addAttribute("nfbList", nfbList); } else if (land_type == 2) // Revnue
	 * Forest { List<RevnueForestMaster> revFList = new
	 * ArrayList<RevnueForestMaster>(); int page_size = 1000;
	 * model.addAttribute("page_size", page_size); revFList =
	 * frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id,
	 * range_code, 0, page_size); model.addAttribute("revenueList", revFList);
	 * 
	 * } else if (land_type == 3) { // DLC Forest List<RevnueForestMaster> revFList
	 * = new ArrayList<RevnueForestMaster>(); int page_size = 1000;
	 * model.addAttribute("page_size", page_size); revFList =
	 * frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id,
	 * range_code, 0, page_size); model.addAttribute("revenueList", revFList); }
	 * return "/dss/customQueryPartial"; }
	 * 
	 * @RequestMapping("/DSS/customQueryPartialDemo")
	 * 
	 * @ResponseBody public List<NfbDetail>
	 * partialForestLandDetailsDemo(@RequestParam Integer land_type, @RequestParam
	 * Integer selection,
	 * 
	 * @RequestParam Integer dist_id, @RequestParam Integer div_id, @RequestParam
	 * Integer tahasil_id,
	 * 
	 * @RequestParam String range_code,@RequestParam String info, Model model) {
	 * String s=info; model.addAttribute("landType", land_type);
	 * model.addAttribute("fSelection", selection);
	 * 
	 * List<NfbDetail> nfbList = new ArrayList<NfbDetail>(); if (land_type == 1) //
	 * Notified Forest {
	 * 
	 * nfbList = frlservice.getNFBDetails(model, selection, dist_id, div_id,
	 * tahasil_id, range_code);
	 * 
	 * model.addAttribute("nfbList", nfbList); }
	 * 
	 * return nfbList; }
	 * 
	 * 
	 * @RequestMapping("DSS/getFeatureInfo") public @ResponseBody List<Object[]>
	 * getFeatureInfo(@RequestParam String featureGeom,@RequestParam String layer) {
	 * List<Object[]> objList=new ArrayList<Object[]>(); return objList; }
	 */
}
