package com.sparc.flidss.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sparc.flidss.model.common.DistrictMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.ForestLandTypeMaster;
import com.sparc.flidss.model.common.NfbDetail;
import com.sparc.flidss.model.common.RangeMaster;
import com.sparc.flidss.model.common.TehsilMaster;
import com.sparc.flidss.security.service.SecurityUtility;
import com.sparc.flidss.service.ForestLandDetailsService;
import com.sparc.flidss.service.ForestLandInformationService;
import com.sparc.flidss.service.UtilityMasterService;
import com.sparc.flidss.viewmodel.SP_NFBViewModel;

@Controller
public class ForestLandInformationController {
	
	@Autowired 
	UtilityMasterService service; 
	@Autowired 
	ForestLandInformationService fliService;
	@Autowired
	ForestLandDetailsService frlservice;
	
	@Autowired
    SecurityUtility securityUtility; 
	
	@RequestMapping("/FLD/forestlandinfo")
	public String forestLandDetails() {
		return "/fld/forestlandinfo";
	}
	
	/**
	 * @implNote ForestLand Information Map Viewer
	 * @return Page-forestlandinfo
	 * @param Model- Stores page attribues info
	 * @author Smita
	 * @CDate 18 April 2021
	 */
	@RequestMapping("/FLD/forestLandInfo")
	public String getForestLandDetails(Model model) {
		String url =securityUtility.checkAuthority(3, 3);
		if(url.equalsIgnoreCase("fld/forestlandinformation")) {
			url="/fld/forestlandinfo";
			model.addAttribute("districtList", service.GetDistrictList());
			model.addAttribute("divisionList", service.GetDivisionList());
			return url;
		}
		
	
		return url;
	}
	
	/**
	 * @implNote ForestLand Layer List fr1om Post GIS
	 * @return List<Object[]>
	 * @param (layer ,distid ,divid ,tehsilid ,rangeCode)
	 * @author Smita
	 * @CDate 20 April 2021
	 */
	@RequestMapping("/FLD/getLayerInfo")
	public @ResponseBody List<Object[]> getLayerInfo(@RequestParam String layer,@RequestParam Integer distid,@RequestParam Integer divid,@RequestParam Integer tehsilid,@RequestParam String rangeCode) {
		List<Object[]> objList=fliService.getLayerInfo(layer, distid, divid, tehsilid, rangeCode);
		return objList;
	}
	
	@RequestMapping(value = "/LoadLayersForFli", method = RequestMethod.GET)
	public @ResponseBody String LoadLayers(Model model, @RequestParam String landType, @RequestParam Integer distid,
			@RequestParam Integer divid, @RequestParam String rangeCode) throws JsonProcessingException {
		try {
			String layerList="";
			//for(int i=0;i<landType.length;i++) {
				if(landType.equals("1"))
				{
					List<SP_NFBViewModel> objList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode);
					ObjectMapper mapper = new ObjectMapper();
					layerList=mapper.writeValueAsString(objList);
					//model.addAttribute("layer", mapper.writeValueAsString(objList));
				}
				else
				{
					
				}
			//}
			
			
			return layerList;
		} catch (Exception ex) {
			throw ex;
		}
	}


	@RequestMapping(value = "/FLI/fli")
	public String forestLandDetails(Model model) {
		String url =securityUtility.checkAuthority(2, 2);
		if(url.equalsIgnoreCase("fld/forestLandDetails")) {
			url="/fli/fli";
			try {
				List<ForestLandTypeMaster> fLandType = service.GetForestLandType();
				List<DistrictMaster> distList = service.GetDistrictList();
				List<DivisionMaster> divList = service.GetDivisionList().stream()
						.filter(f->f.getIntId()>0 && f.getPhaseMaster().getIntId()==1).collect(Collectors.toList());
				List<RangeMaster> rngList = service.GetRangeList();
				List<TehsilMaster> tehsList = service.GetTehsilList();
				model.addAttribute("fLandType", fLandType);
				model.addAttribute("distList", distList);
				model.addAttribute("divList", divList);
				model.addAttribute("rngList", rngList);
				model.addAttribute("tehsList", tehsList);
				
				return url;
			} catch (Exception ex) {
				throw ex;
			}
		}
		
		return url;
		

	}
	
}
