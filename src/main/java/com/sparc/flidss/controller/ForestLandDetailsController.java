package com.sparc.flidss.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sparc.flidss.model.common.DistrictMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.ForestLandTypeMaster;
import com.sparc.flidss.model.common.GlobalLinkMaster;
import com.sparc.flidss.model.common.NfbDetail;
import com.sparc.flidss.model.common.NfbMaster;
import com.sparc.flidss.model.common.RangeMaster;
import com.sparc.flidss.model.common.RevnueForestMaster;
import com.sparc.flidss.model.common.SacntuaryBoundary;
import com.sparc.flidss.model.common.TehsilMaster;
import com.sparc.flidss.model.common.VectorMasterData;
import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;
import com.sparc.flidss.repository.common.NfbMasterRepository;
import com.sparc.flidss.repository.common.RevnueForestMasterRepository;
import com.sparc.flidss.repository.common.SacntuaryBoundaryRepository;
import com.sparc.flidss.security.service.SecurityUtility;
import com.sparc.flidss.service.ForestLandDetailsService;
import com.sparc.flidss.service.UtilityMasterService;
import com.sparc.flidss.utility.ValueText;
import com.sparc.flidss.viewmodel.INfbDlcDivwiseArea;
import com.sparc.flidss.viewmodel.INfbFbwiseArea;
//import com.sparc.flidss.viewmodel.NfbDlcDivwiseArea;
import com.sparc.flidss.viewmodel.SP_NFBViewModel;

@Controller
public class ForestLandDetailsController {
	@Autowired
	UtilityMasterService utility;
	@Autowired
	ForestLandDetailsService frlservice;
	@Autowired
	SecurityUtility securityUtility;
	@Autowired
	DistrictDivisionLinkMasterRepository distDivLinkRepo;
	@Autowired
	SacntuaryBoundaryRepository sacnRepo;
	@Autowired
	RevnueForestMasterRepository revForestRepo;

	/**
	 * @implNote Get Forest Land Details in a tabular/ map view
	 * @param (Model- Stores model attributes)
	 * @return Page -forestLandDetails
	 * @author Madhu
	 * @CDate 20 April 2021
	 */

	@SuppressWarnings("null")
	@RequestMapping(value = "FLD/forestLandDetails")
	public String forestLandDetails(Model model, HttpSession session) {
		String url = securityUtility.checkAuthority(2, 2);
		if (url.equalsIgnoreCase("fld/forestLandDetails")) {
			url = "/fld/forestLandDetails";
			try {
				Integer distId = session.getAttribute("distID") != null
						? Integer.parseInt(session.getAttribute("distID").toString())
						: 0;
				Integer divId = session.getAttribute("divID") != null
						? Integer.parseInt(session.getAttribute("divID").toString())
						: 0;
				List<Integer> dividsByDist = new ArrayList<Integer>();

				if (distId != null && Integer.parseInt(distId.toString()) > 0) {
					dividsByDist = distDivLinkRepo.findByDistId(distId).stream()
							.map(m -> m.getDivisionMaster().getIntId()).collect(Collectors.toList());
				} else {
					if (divId > 0) {
						dividsByDist.add(divId);
					}

				}
				var divids = dividsByDist;
				List<ForestLandTypeMaster> fLandType = utility.GetForestLandType().stream()
						.filter(f -> f.getSeqNo() <= 3).sorted(Comparator.comparing(ForestLandTypeMaster::getSeqNo))
						.collect(Collectors.toList());

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
								&& f.getPhaseMaster().getIntPhase() == 1 || f.getPhaseMaster().getIntPhase()==2 
										/* || f.getPhaseMaster().getIntPhase()==3 
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
				
				
				List<RangeMaster> rngList = utility.GetRangeList();
				List<TehsilMaster> tehsList = utility.GetTehsilList();
				model.addAttribute("fLandType", fLandType);
				model.addAttribute("distList", distList);
				model.addAttribute("divList", divList);
				model.addAttribute("rngList", rngList);
				model.addAttribute("tehsList", tehsList);

				return url;
			} catch (Exception ex) {
				//throw ex;
			}
		}

		return url;

	}

	/**
	 * @implNote Get Forest Land Details of Selected forest Land Type
	 * @param (land_type, selection, dist_id, div_id, tahasil_id, range_code,
	 *                    pageNo, pageSize)
	 * @return Page (Partial View containing Forest block/plot list in a tabular
	 *         view)
	 * @author Smita, Madhu
	 * @CDate 20 April 2021
	 */

	@RequestMapping(value = "/partialForestLandDetails", method = RequestMethod.GET)
	public String partialForestLandDetails(@RequestParam Integer land_type, @RequestParam Integer selection,
			@RequestParam Integer dist_id, @RequestParam Integer div_id, @RequestParam Integer tahasil_id,
			@RequestParam String range_code, Model model) {
		model.addAttribute("landType", land_type);
		model.addAttribute("fSelection", selection);
		if (land_type == 1) // Notified Forest
		{
			List<NfbMaster> nfbList = new ArrayList<NfbMaster>();
			nfbList = frlservice.getNFBList(model, selection, dist_id, div_id, tahasil_id, range_code);
			model.addAttribute("nfbList", nfbList);
		} else if (land_type == 2) // Revnue Forest
		{
			List<RevnueForestMaster> revFList = new ArrayList<RevnueForestMaster>();
			int page_size = 1000;
			model.addAttribute("page_size", page_size);
			revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
					page_size);
			model.addAttribute("revenueList", revFList);

		} else if (land_type == 3) { // DLC Forest
			List<RevnueForestMaster> revFList = new ArrayList<RevnueForestMaster>();
			int page_size = 1000;
			model.addAttribute("page_size", page_size);
			revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code, 0,
					page_size);
			model.addAttribute("revenueList", revFList);
		}
		return "/fld/partialForestLandDetails";
	}

	/**
	 * @implNote Get particular details of notified Forest Block
	 * @param (Model- Stores model attributes, fid- FB Id)
	 * @return Partial View- partialFbWiseForestLandDetails( View in a modal popup)
	 * @author Madhu
	 * @CDate 20 April 2021
	 */

	@RequestMapping(value = "/partialFbWiseForestLandDetails", method = RequestMethod.GET)
	public String fbWiseForestLandDetails(Model model, @RequestParam Integer fid) {
		try {
			NfbDetail nfbdetail = frlservice.getNFBDetails(fid);
			model.addAttribute("fid", fid);
			model.addAttribute("nfbdetail", nfbdetail);
			return "/fld/partialFbWiseForestLandDetails";
		} catch (Exception ex) {
			throw ex;
		}
	}

	/**
	 * @implNote View Spatial details of notified Forest Block in a map view
	 * @param (Model- Stores model attributes,layer,distid,divid,rangeCode)
	 * @return Partial View- partialmapview
	 * @author Smita
	 * @CDate 20 April 2021
	 */

	@RequestMapping(value = "/partialMapview", method = RequestMethod.GET)
	public String viewForestLandMap(Model model, @RequestParam String layer, @RequestParam Integer distid,
			@RequestParam Integer divid, @RequestParam String rangeCode) throws JsonProcessingException {
		try {
			List<SP_NFBViewModel> objList = frlservice.getNFBLayers(layer, distid, divid, rangeCode);
			ObjectMapper mapper = new ObjectMapper();
			model.addAttribute("layer", mapper.writeValueAsString(objList));
			model.addAttribute("village_code", "");
			return "/fld/partialmapview";
		} catch (Exception ex) {
			throw ex;
		}
	}

	/**
	 * @implNote Get forest land details of Revenue Forest Plot- Implement Paging
	 *           technique
	 * @param (Model- Stores model attributes, selection,dist_id,div_id,
	 *                tahasil_id,range_code,pageNo,pageSize)
	 * @return List<RevnueForestMaster>
	 * @author Smita
	 * @CDate 20 April 2021
	 */

	@RequestMapping(value = "/getRevForestData", method = RequestMethod.GET)
	public @ResponseBody List<RevnueForestMaster> getRevForestData(Model model, @RequestParam Integer land_type,
			@RequestParam Integer selection, @RequestParam Integer dist_id, @RequestParam Integer div_id,
			@RequestParam Integer tahasil_id, @RequestParam String range_code, @RequestParam Integer pageNo,
			@RequestParam Integer pageSize) {
		try {
			List<RevnueForestMaster> revFList = new ArrayList<RevnueForestMaster>();
			if (land_type == 2)
				revFList = frlservice.getRevVillageList(model, selection, dist_id, div_id, tahasil_id, range_code,
						pageNo, pageSize);
			else
				revFList = frlservice.getDLCVillageList(model, selection, dist_id, div_id, tahasil_id, range_code,
						pageNo, pageSize);
			return revFList;
		} catch (Exception ex) {
			throw ex;
		}
	}

	/**
	 * @implNote Get particular details of Revenue Forest/DLC Forest Plot
	 * @param (Model- Stores model attributes, villageCode,plotNo)
	 * @return Partial View-partialPlotwiseRevenueForestDetails (View in a modal
	 *         popup)
	 * @author Smita
	 * @CDate 20 April 2021
	 */

	@RequestMapping(value = "/plotwiseRevenueForestDetails", method = RequestMethod.GET)
	public String plotwiseRevenueForestDetails(Model model, @RequestParam String villageCode,
			@RequestParam String plotNo) {
		try {
			RevnueForestMaster rfMaster = frlservice.getRFDetails(villageCode, plotNo);
			model.addAttribute("rfModel", rfMaster);
			return "/fld/partialPlotwiseRevenueForestDetails";
		} catch (Exception ex) {
			throw ex;
		}
	}

	/**
	 * @implNote View Spatial details of revenue Forest Plot in a map view
	 * @param (Model- Stores model attributes,layer,distid,divid,rangeCode)
	 * @return Partial View- partialmapview
	 * @author Smita
	 * @CDate 20 April 2021
	 */

	@RequestMapping(value = "/partialrevMapview", method = RequestMethod.GET)
	public String viewRForestLandMap(Model model, @RequestParam Integer type, @RequestParam Integer land_type,
			@RequestParam Integer distid, @RequestParam Integer divid, @RequestParam String village_code)
			throws JsonProcessingException {
		try {
			if (land_type == 2) {
				List<VectorMasterData> vectorList = frlservice.getDIvisionwiseVectorLayerList(distid, divid, type);

				ObjectMapper mapper = new ObjectMapper();
				model.addAttribute("layer", (vectorList != null ? mapper.writeValueAsString(vectorList) : null));
				model.addAttribute("village_code", village_code);
			}
			/*
			 * else if (land_type == 4) { List<VectorMasterData> vectorList =
			 * frlservice.getDIvisionwiseVectorLayerList(distid, divid, type);
			 * 
			 * ObjectMapper mapper = new ObjectMapper(); model.addAttribute("layer",
			 * (vectorList != null ? mapper.writeValueAsString(vectorList) : null));
			 * model.addAttribute("village_code", village_code); }
			 */
			/*
			 * else if(land_type==3) { List<VectorMasterData> DLCList =
			 * frlservice.getDIvisionwiseDLCLayerList(distid, divid);
			 * 
			 * ObjectMapper mapper = new ObjectMapper();
			 * model.addAttribute("layer",(DLCList!=null?
			 * mapper.writeValueAsString(DLCList):null)); model.addAttribute("village_code",
			 * village_code); }
			 */
			return "/fld/MapView";
		} catch (Exception ex) {
			throw ex;
		}

	}

	/**
	 * @implNote map view of forest land details
	 * @param (distid,divid)
	 * @return Partial View- forestlandmapview
	 * @author Smruti
	 * @CDate 17 Aug 2021
	 */
	@RequestMapping(value = "/forestlandmapview", method = RequestMethod.GET)
	public String forestlandmapview() {
		try {

			return "/fld/forestlandmapview";
		} catch (Exception ex) {
			throw ex;
		}
	}

	@RequestMapping(value = "/ForestlandDataView", method = RequestMethod.GET)
	public String forestlandDataview(Model model) {
		try {
			return "/fld/ForestlandDataView";
		} catch (Exception ex) {
			throw ex;
		}
	}

	/**
	 * @implNote View Spatial details of notified Forest Block in a map view
	 * @param (Model- Stores model attributes,layer,distid,divid,rangeCode)
	 * @return Partial View- partialmapview
	 * @author Smita
	 * @CDate 20 April 2021
	 */

	@RequestMapping(value = "/LoadLayers", method = RequestMethod.GET)
	public @ResponseBody String LoadLayers(Model model, @RequestParam(required = false) Integer type,
			@RequestParam(required = false) String landType, @RequestParam(required = false) Integer distid,
			@RequestParam(required = false) Integer divid, @RequestParam(required = false) String rangeCode,
			@RequestParam(required = false) Integer tahasil_id, @RequestParam(required = false) String ric,
			@RequestParam(required = false) String vill_code, @RequestParam(required = false) String condn,
			@RequestParam(required = false) String operator, @RequestParam(required = false) Double opvalue)
			throws JsonProcessingException {
		try {
			String layerList = "";
			// for(int i=0;i<landType.length;i++) {
			if (landType.equals("1")) {
				List<SP_NFBViewModel> nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode);

				// List<SP_NFBViewModel> nfbList=new ArrayList<SP_NFBViewModel>();
				switch (condn) {
				case "jvHa":
					if (operator.equals("<=") && opvalue != null) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream()
								.filter(f -> f.getSurveytype().equals("JV")
										&& (f.getArea_ha() != null ? f.getArea_ha() : 0) <= opvalue)
								.collect(Collectors.toList());
					} else if (operator.equals(">=")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream()
								.filter(f -> f.getSurveytype().equals("JV")
										&& (f.getArea_ha() != null ? f.getArea_ha() : 0) >= opvalue)
								.collect(Collectors.toList());
					} else if (operator.equals("==")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream()
								.filter(f -> f.getSurveytype().equals("JV")
										&& (f.getArea_ha() != null ? f.getArea_ha() : 0) == opvalue)
								.collect(Collectors.toList());
					}
					break;

				case "dgpsdHa":
					if (operator.equals("<=")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream().filter(
								f -> f.getSurveytype().equals("DGPS Final") || f.getSurveytype().equals("DGPS Draft")
										&& (f.getArea_ha() != null ? f.getArea_ha() : 0) <= opvalue)
								.collect(Collectors.toList());
					} else if (operator.equals(">=")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream().filter(
								f -> f.getSurveytype().equals("DGPS Final") || f.getSurveytype().equals("DGPS Draft")
										&& (f.getArea_ha() != null ? f.getArea_ha() : 0) >= opvalue)
								.collect(Collectors.toList());
					} else if (operator.equals("==")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream().filter(
								f -> f.getSurveytype().equals("DGPS Final") || f.getSurveytype().equals("DGPS Draft")
										&& (f.getArea_ha() != null ? f.getArea_ha() : 0) == opvalue)
								.collect(Collectors.toList());
					}
					break;

				case "cmvHa":
					if (operator.equals("<=")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream()
								.filter(f -> f.getSurveytype().equals("CMV")
										&& (f.getArea_ha() != null ? f.getArea_ha() : 0) <= opvalue)
								.collect(Collectors.toList());
					} else if (operator.equals(">=")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream()
								.filter(f -> f.getSurveytype().equals("CMV")
										&& (f.getArea_ha() != null ? f.getArea_ha() : 0) >= opvalue)
								.collect(Collectors.toList());
					} else if (operator.equals("==")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream()
								.filter(f -> f.getSurveytype().equals("CMV")
										&& (f.getArea_ha() != null ? f.getArea_ha() : 0) == opvalue)
								.collect(Collectors.toList());
					}
					break;

				case "nareaHa":
					if (operator.equals("<=")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream()
								.filter(f -> (f.getNfa_ha() != null ? f.getNfa_ha() : 0) <= opvalue)
								.collect(Collectors.toList());
					} else if (operator.equals(">=")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream()
								.filter(f -> (f.getNfa_ha() != null ? f.getNfa_ha() : 0) >= opvalue)
								.collect(Collectors.toList());
					} else if (operator.equals("==")) {
						nfbList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode).stream()
								.filter(f -> (f.getNfa_ha() != null ? f.getNfa_ha() : 0) == opvalue)
								.collect(Collectors.toList());
					}
					break;
				default:
					break;

				}
				ObjectMapper mapper = new ObjectMapper();
				layerList = mapper.writeValueAsString(nfbList);
				// model.addAttribute("layer", mapper.writeValueAsString(objList));
			} else {
				List<VectorMasterData> objList = frlservice.getDIvisionwiseVectorLayerList(distid, divid, type);
				// .stream().filter(f->f.getTehsilMaster().getIntId()==(tahasil_id!=0?tahasil_id:f.getTehsilMaster().getIntId())).collect(Collectors.toList());
				ObjectMapper mapper = new ObjectMapper();
				// model.addAttribute("layer",(objList!=null?
				// mapper.writeValueAsString(objList):null));
				layerList = mapper.writeValueAsString(objList);
				// model.addAttribute("layer",(objList!=null?
				// mapper.writeValueAsString(objList):null));
				// model.addAttribute("village_code", village_code);
			}
			// }

			return layerList;
		} catch (Exception ex) {
			throw ex;
		}
	}

	@RequestMapping(value = "/FLD/fldv2")
	public String fldv2(Model model, HttpSession session) {
		String url = securityUtility.checkAuthority(7, 2);
		if (url.equalsIgnoreCase("FLD/fldv2")) {
			url = "/fld/fldv2";
			try {
				Integer roleId = Integer.parseInt(
						session.getAttribute("roleID") != null ? session.getAttribute("roleID").toString() : "0");

				List<Integer> divIds = new ArrayList<Integer>();
				List<Integer> distIds = new ArrayList<Integer>();

				if (roleId == 10) { //District Level
					Integer distId = Integer.parseInt(
							session.getAttribute("distID") != null ? session.getAttribute("distID").toString() : "0");
					List<Integer> dividList = distDivLinkRepo.findAll().stream()
							.filter(f -> f.getDistrictMaster().getIntId() == distId)
							.map(m -> m.getDivisionMaster().getIntId()).collect(Collectors.toList());
					divIds.addAll(dividList);
					distIds.add(distId);
				} else if (roleId == 8) { //Division Level
					Integer divId = Integer.parseInt(
							session.getAttribute("divID") != null ? session.getAttribute("divID").toString() : "0");
					divIds.add(divId);
					List<Integer> distidList = distDivLinkRepo.findAll().stream()
							.filter(f -> f.getDivisionMaster().getIntId() == divId)
							.map(m -> m.getDistrictMaster().getIntId()).collect(Collectors.toList());
					distIds.addAll(distidList);
				}

				List<ForestLandTypeMaster> fLandType = utility.GetForestLandType();
				//List<DistrictMaster> distList = utility.GetDistrictList().stream().filter(f->!distIds.isEmpty()?distIds.contains(f.getIntId()):true ).collect(Collectors.toList());
				//List<DivisionMaster> divList = utility.GetDivisionList().stream().filter(f->!divIds.isEmpty()?divIds.contains(f.getIntId()):true ).collect(Collectors.toList());
				//List<RangeMaster> rngList = utility.GetRangeList();
				//List<TehsilMaster> tehsList = utility.GetTehsilList();
				model.addAttribute("fLandType", fLandType);
				//model.addAttribute("distList", distList);
				//model.addAttribute("divList", divList);
				//model.addAttribute("rngList", rngList);
				//model.addAttribute("tehsList", tehsList);

				model.addAttribute("nfbDlcDivArea",
						frlservice.getNfbDlcDivWiseArea().stream()
								.filter(f -> !distIds.isEmpty() ? divIds.contains(f.getDiv_id()) : true)
								.collect(Collectors.toList()));
				//model.addAttribute("nfbStatistics", frlservice.getNFBStatistics());
				//model.addAttribute("DlcArea", revForestRepo.getDlcRevTehwiseArea(divid));
				return url;
			} catch (Exception ex) {
				throw ex;
			}
		}

		return url;
	}

	@RequestMapping(value = "/LoadSanctuary", method = RequestMethod.GET)
	public @ResponseBody String LoadSanctuaryLayers(Model model, @RequestParam(required = false) Integer distid,
			@RequestParam(required = false) Integer divid) throws JsonProcessingException {
		try {
			String sanclayerList = "";

			List<SacntuaryBoundary> sancList = sacnRepo.getSancLayers(28);
			ObjectMapper mapper = new ObjectMapper();
			sanclayerList = mapper.writeValueAsString(sancList);

			return sanclayerList;
		} catch (Exception ex) {
			throw ex;
		}
	}

	/*
	 * @RequestMapping(value = "/partialForestLandSummary", method =
	 * RequestMethod.GET) public @ResponseBody String ForestLandSummary(Model
	 * model,@RequestParam(required = false) Integer divid) throws
	 * JsonProcessingException { try { model.addAttribute("nfbStatistics",
	 * frlservice.getNFBStatistics()); return sanclayerList; } catch (Exception ex)
	 * { throw ex; } }
	 */
	@RequestMapping(value = "/partialForestLandSummary")
	public String ForestLandSummary(Model model, @RequestParam(required = false) Integer divid) {
		/*String url = securityUtility.checkAuthority(2, 2);
		if (url.equalsIgnoreCase("fld/forestLandDetails")) {
			url = "/fld/partialForestLandSummary";*/
		try {
			model.addAttribute("nfbStatistics", frlservice.getINfbStatistics(divid));
			//return url;
		} catch (Exception ex) {
			throw ex;
		}
		//}
		return "/fld/partialForestLandSummary";
	}

	@RequestMapping(value = "/map", method = RequestMethod.GET)
	public String Viewmap() {
		try {

			return "/fld/map";
		} catch (Exception ex) {
			throw ex;
		}
	}
}
