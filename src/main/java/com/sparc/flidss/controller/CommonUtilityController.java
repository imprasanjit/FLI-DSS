package com.sparc.flidss.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sparc.flidss.model.common.CircleMaster;
import com.sparc.flidss.model.common.DistrictDivisionLinkMaster;
import com.sparc.flidss.model.common.NfbDetail;
import com.sparc.flidss.model.common.RasterMasterData;
import com.sparc.flidss.model.common.RevnueForestMaster;
import com.sparc.flidss.model.common.VectorMasterData;
import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;
import com.sparc.flidss.repository.common.RevnueForestMasterRepository;
import com.sparc.flidss.service.ForestLandDetailsService;
import com.sparc.flidss.service.UtilityMasterService;
import com.sparc.flidss.utility.CustomUtility;
import com.sparc.flidss.utility.ValueText;
import com.sparc.flidss.viewmodel.IDlcRevPlotArea;
import com.sparc.flidss.viewmodel.IDlcRevTehwiseArea;
import com.sparc.flidss.viewmodel.IDlcRevVillArea;
import com.sparc.flidss.viewmodel.INfbDetailsV2;
import com.sparc.flidss.viewmodel.INfbFbwiseArea;

@Controller
@RequestMapping("/Utility")
public class CommonUtilityController {
	@Autowired
	private UtilityMasterService service;
	@Autowired
	ForestLandDetailsService vectorMaster;
	@Autowired
	RevnueForestMasterRepository revForestRepo;	
	@Autowired 
	DistrictDivisionLinkMasterRepository districtDivisionLinkMasterRepository;

	@GetMapping("/getCircleList")
	@ResponseBody
	public List<ValueText> getCircleList() {
		List<ValueText> obj = new ArrayList<ValueText>();
		//service.GetCircleList().stream().map(f -> obj.add(new ValueText(f.getIntId(), f.getChrvCircle()))).collect(Collectors.toList());
		//service.GetCircleList().stream().sorted(Comparator.comparingInt(x->x.getIntId())).collect(Collectors.toList());
		//service.GetCircleList().stream().sorted(Comparator.comparingInt(CircleMaster::getIntId)).collect(Collectors.toList());
		service.GetCircleList().forEach(f -> obj.add(new ValueText(f.getIntId(), f.getChrvCircle())));
		return obj;
	}

	/*
	 * public @ResponseBody String UpdateGlobalLinkStatus(@RequestParam(value =
	 * "slnoList[]") String[] slnoList,
	 * 
	 * @RequestParam(name = "astatus") Integer astatus, HttpServletRequest request,
	 * HttpSession session) {
	 */
	@GetMapping("/getDistwiseTahasil")
	public @ResponseBody List<ValueText> getDistwiseTahasilList(@RequestParam Integer distid) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.GetDistrictwiseTehsilList(distid)
				.forEach(f -> obj.add(new ValueText(f.getIntId(), f.getChrvTahasilNm())));
		return obj;
	}

	@GetMapping("/getDivwiseTahasil")
	public @ResponseBody List<ValueText> getDivwiseTahasilList(@RequestParam Integer divid) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.GetDivisionwiseTehsilList(divid)
				.forEach(f -> obj.add(new ValueText(f.getIntId(), f.getChrvTahasilNm())));
		return obj;
	}

	@GetMapping("/getDivwiseRange")
	public @ResponseBody List<ValueText> getDivwiseRangeList(@RequestParam Integer divid) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.GetDivisionwiseRangeList(divid)
				.forEach(f -> obj.add(new ValueText(f.getChrvRangeCd(), f.getChrvRangeNm())));
		return obj;
	}

	@GetMapping("/getDistwiseRange")
	public @ResponseBody List<ValueText> getDistwiseRange(@RequestParam Integer distid) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.GetDistwiseRangeList(distid)
				.forEach(f -> obj.add(new ValueText(f.getChrvRangeCd(), f.getChrvRangeNm())));
		return obj;
	}

	@GetMapping("/getDistwiseDivision")
	public @ResponseBody List<ValueText> getDistwiseDivision(@RequestParam Integer distid) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.GetDistrictwiseDivisionList(distid)
				.forEach(f -> obj.add(new ValueText(f.getIntId(), f.getChrvDivisionNm())));
		return obj;
	}

	@GetMapping("/getRoleWisePositionList")
	public @ResponseBody List<ValueText> getRoleWisePositionList(@RequestParam Integer roleid) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.GetRoleWisePositionList(roleid)
				.forEach(f -> obj.add(new ValueText(f.getIntId(), f.getChrvPositionNm())));
		return obj;
	}

	@GetMapping("/getCircleWiseDivisionList")
	public @ResponseBody List<ValueText> getCircleWiseDivisionList(@RequestParam Integer cirid) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.GetCircleWiseDivisionList(cirid)
				.forEach(f -> obj.add(new ValueText(f.getIntId(), f.getChrvDivisionNm())));
		return obj;
	}
	
	@GetMapping("/getPhaseWiseDivisionList")
	public @ResponseBody List<ValueText> getPhaseWiseDivisionList(@RequestParam Integer phase) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.GetPhaseWiseDivisionList(phase)
				.forEach(f -> obj.add(new ValueText(f.getIntId(), f.getChrvDivisionNm())));
		return obj;
	}

	// GET : division and vector map type wise map link layer list.
	@GetMapping("/getDivisionVectorMapTypeLayerList")
	public @ResponseBody List<ValueText> getDivisionVectorMapTypeLayerList(Model model, 
			@RequestParam(name="distid",required = false) Integer distid,
			@RequestParam(name="distids[]",required = false) Integer distids[],
			@RequestParam(name="tahsilids[]",required = false) Integer tahsilids[],
			@RequestParam(name = "divid",required = false) Integer divid,
			@RequestParam(name = "divids[]",required = false) Integer divids[], 
			@RequestParam Integer type) throws Exception {
		try {
			List<ValueText> obj = new ArrayList<ValueText>();
			
			 if (distid != 0 && (distids==null || distids.length==0)) {
				service.GetdistWiseLayerList(distid, type).forEach(f -> obj
						.add(new ValueText(f.getTehsilMaster()!=null?f.getTehsilMaster().getIntId():0, f.getChrvGlink(), f.getChrvStrLayerNm())));
			}
			 else if((distids!=null && distids.length>0) || (tahsilids!=null && tahsilids.length>0) ) {
				 service.GetdistWiseLayerList(distids,tahsilids,type).forEach(f -> obj
							.add(new ValueText(f.getTehsilMaster()!=null?f.getTehsilMaster().getIntId():0, f.getChrvGlink(), f.getChrvStrLayerNm())));
			 }
			
			 else if (divid!=null && divid != 0 && type!=29) {
				
				service.GetdivWiseLayerList(divid, type).forEach(f -> obj
						.add(new ValueText(f.getDivisionMaster().getIntId(), f.getChrvGlink(), f.getChrvStrLayerNm())));
			}
			 else if(divids!=null && divids.length>0) {
				 service.GetdivWiseLayerList(divids, type).forEach(f -> obj
							.add(new ValueText(f.getDivisionMaster().getIntId(), f.getChrvGlink(), f.getChrvStrLayerNm())));
			 }
			/*
			 * else if (divid != 0) { service.GetdivWiseLayerList(divid, type).forEach(f ->
			 * obj .add(new
			 * ValueText(f.getTehsilMaster()!=null?f.getTehsilMaster().getIntId():0,
			 * f.getChrvGlink(), f.getChrvStrLayerNm()))); }
			 */
			 else {
				
				if(distid ==0 && divid == 0 && type !=0 ) {
					VectorMasterData vmData = service.GetAlldivLayer(divid, type);
					obj.add(new ValueText(vmData.getDivisionMaster().getIntId(), vmData.getChrvGlink(),
			vmData.getChrvStrLayerNm()));
					
				}else {
					VectorMasterData vmData1 = service.GetAlldisLayer(type);
					obj.add(new ValueText(vmData1.getDivisionMaster().getIntId(), vmData1.getChrvGlink(),
							vmData1.getChrvStrLayerNm()));
					
					List<DistrictDivisionLinkMaster> distList = districtDivisionLinkMasterRepository.getDivisionMaster(divid);
					for(DistrictDivisionLinkMaster distCount :distList)
					obj.add(new ValueText(distCount.getDistrictMaster().getIntId(),distCount.getDistrictMaster().getChrvDistrictNm()));
					
				}
			}
			return obj;
		} catch (Exception ex) {
			throw ex;
		}
		/*
		 * var layer=_context.m_vector_data .Where(c =>c.int_fk_division==did &&
		 * c.int_fk_vector_type_id==type).ToList(); return layer;
		 */
	}

	@GetMapping("/getAllLayerList")
	public @ResponseBody List<ValueText> getAllLayerList(Model model, @RequestParam Integer type) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.GetAllLayerList(type).forEach(f -> obj.add(new ValueText(f.getDivisionMaster().getIntId(),f.getChrvGlink(), f.getChrvStrLayerNm())));

		return obj;
	}
	
	@GetMapping("/getDivLayerList")
	public @ResponseBody List<ValueText> getDivLayerList(Model model,@RequestParam Integer divid, @RequestParam Integer type) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.getDivLayerList(divid,type).forEach(f -> obj.add(new ValueText(f.getDivisionMaster().getIntId(),f.getChrvGlink(), f.getChrvStrLayerNm())));

		return obj;
	}

	@GetMapping("/getCustomQueryFields")
	public @ResponseBody List<ValueText> getCustomQueryFieldsList(Model model, @RequestParam Integer forestLandType) {
		List<ValueText> obj = new ArrayList<ValueText>();
		if(forestLandType==1){
			service.getCustomQueryFieldsNFB()
				.forEach(f -> obj.add(new ValueText(f.getStrValue(), f.getText(), f.getIsChecked(),f.getIsNumeric())));
		}
		else if(forestLandType==2 || forestLandType==3){
			service.getCustomQueryFieldsDLC()
				.forEach(f -> obj.add(new ValueText(f.getStrValue(), f.getText(), f.getIsChecked(),f.getIsNumeric())));
		}

		return obj;
	}
	

	// GET : division and vector map type wise map link layer list.
	@GetMapping("/getDivisionRasterMapTypeLayerList")
	public @ResponseBody List<ValueText> getDivisionRasterMapTypeLayerList(Model model, @RequestParam Integer distid,
			@RequestParam Integer divid, @RequestParam Integer type) throws Exception {
		try {
			List<ValueText> obj = new ArrayList<ValueText>();
			if (divid != 0) {
				service.GetdivWiseRasterLayerList(divid, type).forEach(f -> obj
						.add(new ValueText(f.getDivisionMaster().getIntId(), f.getChrvLink(), f.getChrvLayerNm())));
			} else {
				RasterMasterData rmData = service.GetAllDivRLayer(divid, type);
				obj.add(new ValueText(rmData.getDivisionMaster().getIntId(), rmData.getChrvLink(),
						rmData.getChrvLayerNm()));
			}
			return obj;
		} catch (Exception ex) {
			throw ex;
		}
	}
//Get All division RasterLayer
//By Madhu
	@GetMapping("/getAllRasterList")
	public @ResponseBody List<ValueText> getAllRasterList(Model model, @RequestParam Integer type) {
		List<ValueText> obj = new ArrayList<ValueText>();
		service.GetAllRasterList(type).forEach(f -> obj.add(new ValueText(f.getChrvLink(), f.getChrvLayerNm())));
		return obj;
	}

	// GET : division and vector map type wise map link layer list.
	@GetMapping("/getDivisionVectorMapLayerList")
	public @ResponseBody List<ValueText> getDivisionVectorMapLayerList(Model model, @RequestParam Integer distid,
			@RequestParam Integer type) throws Exception {
		try {
			List<ValueText> obj = new ArrayList<ValueText>();

			List<VectorMasterData> vmData = service.GetAllFlayerList(distid, type);
			vmData.forEach(f -> obj.add(new ValueText(f.getChrvGlink(), f.getChrvStrLayerNm())));

			return obj;
		} catch (Exception ex) {
			throw ex;
		}
	}
	
	@GetMapping("/getNfbFbWiseArea")
	public @ResponseBody List<INfbFbwiseArea> getNfbDlcDivWiseArea(@RequestParam Integer divid) throws Exception {
		try {
			
			return vectorMaster.getNfbFbwiseArea(divid);
		} catch (Exception ex) {
			throw ex;
		}
	}
	@GetMapping("/getDlcRevTehwiseArea")
	public @ResponseBody List<IDlcRevTehwiseArea> getDlcRevTehwiseArea(Model model,@RequestParam Integer divid) throws Exception {
		try {
				//model.addAttribute("DlcArea", revForestRepo.getDlcRevTehwiseArea(divid));
				
				return revForestRepo.getDlcRevTehwiseArea(divid);
		} catch (Exception ex) {
			throw ex;
		}
	}
	@GetMapping("/getDlcRevVillwiseArea")
	public @ResponseBody List<IDlcRevVillArea> getDlcRevVillwiseArea(@RequestParam Integer tehid) throws Exception {
		try {
			
			return revForestRepo.getDlcRevVillwiseArea(tehid);
		} catch (Exception ex) {
			throw ex;
		}
	}
	@GetMapping("/getDlcRevPlotwiseArea")
	public @ResponseBody List<IDlcRevPlotArea> getDlcRevPlotwiseArea(@RequestParam String villcode) throws Exception {
		try {
			List<IDlcRevPlotArea> dlcRevPlotwiseArea = revForestRepo.getDlcRevPlotwiseArea(villcode);
			return dlcRevPlotwiseArea;
		} catch (Exception ex) {
			throw ex;
		}
	}
	@GetMapping("/getAreaType")
	public @ResponseBody List<ValueText> getAreaTypeList(Model model, @RequestParam(name = "forestLandType[]") String forestLandType[]) {
		List<ValueText> obj = new ArrayList<ValueText>();
		List<String> forestLandTypeList = CustomUtility.convertArrayToStringList(forestLandType); 
		for(String fltype:forestLandTypeList) {
			if(fltype.equals("1")) {
				service.getCustomQueryFieldsNFB().stream().filter(f->f.getIsNumeric()==true)
				.forEach(f -> obj.add(new ValueText(f.getStrValue(), f.getText(), f.getIsChecked(),f.getIsNumeric())));
			}
			else if(fltype.equals("2")) {
				service.getCustomQueryFieldsDLC().stream().filter(f->f.getIsNumeric()==true)
				  .forEach(f -> obj.add(new ValueText(f.getStrValue(), f.getText(),
				  f.getIsChecked(),f.getIsNumeric()))); 
			}
			else if(fltype.equals("4")) {
				service.getCustomQueryFieldsCALanBank().stream().filter(f->f.getIsNumeric()==true)
				  .forEach(f -> obj.add(new ValueText(f.getStrValue(), f.getText(),
				  f.getIsChecked(),f.getIsNumeric()))); 
			}
		}
		
		
		/*
		 * else if(forestLandTypeList.contains("2") || forestLandTypeList.contains("3"))
		 * { service.getCustomQueryFieldsDLC() .forEach(f -> obj.add(new
		 * ValueText(f.getStrValue(), f.getText(), f.getIsChecked(),f.getIsNumeric())));
		 * 
		 * }
		 */
		 

		return obj;
	}
	@GetMapping("/getRangeWiseFB")
	public @ResponseBody List<ValueText> getRangeWiseFBList(@RequestParam Integer divid,@RequestParam String rid) {
		List<ValueText> obj = new ArrayList<ValueText>();
		try {
			service.GetRangeWiseFBList(divid,rid)
					.forEach(f -> obj.add(new ValueText(f.getIntId(), f.getNfbName(),f.getNfbType())));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		return obj;
	}
	
	@GetMapping("/getTehsilWiseRICircle")
	public @ResponseBody List<ValueText> getTehsilWiseRICircleList(@RequestParam Integer tid) {
		List<ValueText> obj = new ArrayList<ValueText>();
		try {
			service.GetTehsilWiseRIList(tid)
					.forEach(f -> obj.add(new ValueText(f.getIntId(), f.getRicName())));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		return obj;
	}
	@GetMapping("/getRICircleWiseVillage")
	public @ResponseBody List<ValueText> getRICircleWiseVillageList(@RequestParam Integer tid, @RequestParam String ricname) {
		List<ValueText> obj = new ArrayList<ValueText>();
		try {
			service.GetRICircleWiseVillageList(tid,ricname)
					.forEach(f -> obj.add(new ValueText(f.getVillCode(),f.getVillName())));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		return obj;
	}
	
	@GetMapping("/getNfbById")
	public @ResponseBody NfbDetail getNfbById(@RequestParam Integer fbid) {
		try {
			return vectorMaster.getNFBDetails(fbid);
		} catch (Exception e) {
			return null;
		}
	}
	
	@GetMapping("/getRevByVillPlot")
	public @ResponseBody RevnueForestMaster getRevByVillPlot(@RequestParam String villcode,@RequestParam String plotno) {
		try {
			return vectorMaster.getRFDetails(villcode,plotno);
		} catch (Exception e) {
			return null;
		}
	}
	
	@Async
	@GetMapping("/getMaxNareaFb")
	public @ResponseBody List<INfbDetailsV2> getMaxNareaFb(Integer divid,String rangeCode){
		try {
			rangeCode=rangeCode.length()>0?rangeCode:null;
			return vectorMaster.getMaxNareaFb(divid, rangeCode);
		} catch (Exception e) {
			return null;
		}
	}
	
	@Async
	@GetMapping("/getMinNareaFb")
	public @ResponseBody List<INfbDetailsV2> getMinNareaFb(Integer divid,String rangeCode){
		try {
			rangeCode=rangeCode.length()>0?rangeCode:null;
			return vectorMaster.getMinNareaFb(divid, rangeCode);
		} catch (Exception e) {
			return null;
		}
	}
	
	@Async
	@GetMapping("/getAvgNarea")
	public @ResponseBody Double getAvgNarea(Integer divid,String rangeCode){
		try {
			rangeCode=rangeCode.length()>0?rangeCode:null;
			return vectorMaster.getAvgNarea(divid, rangeCode);
		} catch (Exception e) {
			return null;
		}
	}
	
}
