package com.sparc.flidss.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.LayersMaster;
import com.sparc.flidss.model.common.UserProjectMaster;
import com.sparc.flidss.model.common.UserProjectMasterDetails;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;
import com.sparc.flidss.repository.common.DivisionMasterRepository;
import com.sparc.flidss.repository.common.LayersMasterRepository;
import com.sparc.flidss.repository.common.UserProjectMasterDetailsRepository;
import com.sparc.flidss.repository.common.UserProjectMasterRepository;
import com.sparc.flidss.service.ForestLandDetailsService;
import com.sparc.flidss.service.ForestLandInformationService;
import com.sparc.flidss.service.LoggedInUser;
import com.sparc.flidss.service.UtilityMasterService;

@Controller
public class UserProjectController {
	@Autowired
	ForestLandDetailsService frlservice;
	@Autowired
	UtilityMasterService service;
	@Autowired
	ForestLandInformationService fliService;
	@Autowired
	LayersMasterRepository layersMasterRepo;
	@Autowired
	UserProjectMasterRepository userProjectMasterRepository;
	@Autowired
	LoggedInUser loggedInUser;
	@Autowired
	DivisionMasterRepository divisionMasterRepository;
	@Autowired
	UserProjectMasterDetailsRepository userProjectMasterDetailsRepository;
	@Autowired
	DistrictDivisionLinkMasterRepository distdivRepo;

	@Autowired
	AutoUserInfoRepository autoUserInfoRepository;

	/*
	 * @Autowired HomeController homecontroller;
	 */

	@RequestMapping("/UserProject/userMapView")
	public String getForestLandDetails(Model model, @RequestParam Integer projId) {
		String dMasterName = "none";
		List<Integer> layersIds = new ArrayList<Integer>();
		layersIds.add(19);
		layersIds.add(26);
		layersIds.add(32);
		model.addAttribute("districtList", service.GetDistrictList());
		model.addAttribute("divisionList", service.GetDivisionList());

		var v = layersMasterRepo.findAll().stream().filter(f -> !layersIds.contains(f.getId()))
				.collect(Collectors.toList());

		model.addAttribute("layers", v);

		UserProjectMaster userPM = userProjectMasterRepository.findAllByUser(loggedInUser.getUser()).stream()
				.filter(f -> f.getIntId() == projId).findFirst().orElse(null);

		if (userPM == null) {
			model.addAttribute("dMasterName", dMasterName);

			return "/userProject/userMapView";
		} else {
			DivisionMaster lm = userPM.getDivision();
			// dMasterName = userPM.getDivision().getChrvDivisionNm();
			List<UserProjectMasterDetails> userPMD = userProjectMasterDetailsRepository
					.findAllByUserProjectMaster(userPM);

			List<LayersMaster> layersList = userPMD.stream().map(e -> e.getLayers()).collect(Collectors.toList());
			// List<Integer> layers = layersList.stream().map(e ->
			// e.getId()).collect(Collectors.toList());
			model.addAttribute("ActiveLayers", layersList);
			model.addAttribute("dMasterName", lm);
			model.addAttribute("Project", userPM);

			return "/userProject/userMapView";
		}

	}
	/*
	 * @RequestMapping(value = "/UserLoadLayers", method = RequestMethod.GET)
	 * public @ResponseBody String UserLoadLayers(Model model, @RequestParam String
	 * landType, @RequestParam Integer distid,
	 * 
	 * @RequestParam Integer divid, @RequestParam String rangeCode) throws
	 * JsonProcessingException { try { String layerList=""; //for(int
	 * i=0;i<landType.length;i++) { if(landType.equals("1")) { List<SP_NFBViewModel>
	 * objList = frlservice.getNFBLayers("nfb", distid, divid, rangeCode);
	 * ObjectMapper mapper = new ObjectMapper();
	 * layerList=mapper.writeValueAsString(objList); //model.addAttribute("layer",
	 * mapper.writeValueAsString(objList)); } else {
	 * 
	 * } //}
	 * 
	 * 
	 * return layerList; } catch (Exception ex) { throw ex; } }
	 */

//	@DeleteMapping("/deleteProject/{intId}")
//	public ResponseEntity<?> projectDeleteFunc(@PathVariable String intId, Model model, HttpSession session) {
//		userProjectMasterRepository.deleteById(Integer.parseInt(intId));
//		// UserProjectMaster projectM =
//		// userProjectMasterRepository.findByIntId(Integer.parseInt(intId));
//		// AutoUserInfoMaster loggedInUser =
//		// autoUserInfoRepository.findBychrvUserId(username);
//		// setSession(projectM, model);
//		//if (session.getAttribute("userProjList") == null)
//			//session.removeAttribute("userProjList");
//		return ResponseEntity.ok("project deleted successfully");
//
//	}

	@DeleteMapping("/deleteProject/{intId}")
	public ResponseEntity<?> projectDeleteFunc(@PathVariable String intId, Model model, HttpSession session) {
		userProjectMasterRepository.deleteById(Integer.parseInt(intId));
		setSession(model, session);
		return ResponseEntity.ok("project deleted successfully");

	}

	public void setSession(Model model, HttpSession session) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = null;
		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
		} else {
			username = principal.toString();
		}
		AutoUserInfoMaster loggedInUser = autoUserInfoRepository.findBychrvUserId(username);
		List<UserProjectMaster> userProjects = userProjectMasterRepository.findAllByUser(loggedInUser);
		session.setAttribute("userProjList", userProjects);
		// model.addAttribute("userProjList", userProjects);
	}
}
