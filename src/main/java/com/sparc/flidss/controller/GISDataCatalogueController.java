package com.sparc.flidss.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.DataCatalogueMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.GlobalLinkMaster;
import com.sparc.flidss.model.common.LayersMaster;
import com.sparc.flidss.model.common.UserProjectMaster;
import com.sparc.flidss.model.common.UserProjectMasterDetails;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
import com.sparc.flidss.repository.common.DatasetCatalogueMasterRepository;
import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;
import com.sparc.flidss.repository.common.DivisionMasterRepository;
import com.sparc.flidss.repository.common.LayersMasterRepository;
import com.sparc.flidss.repository.common.UserProjectMasterDetailsRepository;
import com.sparc.flidss.repository.common.UserProjectMasterRepository;
import com.sparc.flidss.security.service.SecurityUtility;
import com.sparc.flidss.service.LoggedInUser;
import com.sparc.flidss.utility.ValueText;
import com.sparc.flidss.viewmodel.DataCatalougeViewModel;

@Controller
public class GISDataCatalogueController {
	//@Autowired
	//DatasetMasterRepository repoDatasetMaster;
	//@Autowired
	//DatasetTagRepository repoDatasetTag;
	@Autowired
	DatasetCatalogueMasterRepository repoDataCatalogueMaster;
	@Autowired
	DivisionMasterRepository repoDivisionMaster;
	@Autowired
	AutoUserInfoRepository userrepository;
	/*
	 * @Autowired TripleDESEncryptionService encService;
	 */
	//String authorizeRole = "";
	//@Autowired
	//SetPermissionRepository permissionrepository;
	//@Autowired
	//GlobalLinkRepository globalrepository;
	//@Autowired
	//PrimaryLinkRepository primaryrepository;
	@Autowired
	LayersMasterRepository layersMasterRepo;
	//@Autowired
	//DistrictMasterRepository districtMasterRepository;
	@Autowired
	LoggedInUser loggedInUser;
	@Autowired
	DivisionMasterRepository divisionMasterRepository;
	@Autowired
	UserProjectMasterRepository userProjectMasterRepository;
	@Autowired
	UserProjectMasterDetailsRepository userProjectMasterDetailsRepository;
	@Autowired
	SecurityUtility securityUtility;
	@Autowired
	DistrictDivisionLinkMasterRepository distDivLinkRepo;
	@Autowired
	UserProjectMasterRepository userProjectRepo;

	@RequestMapping("/GIS/dataCatalogueui1")
	public String viewGISDataCatalouge(Model model, HttpSession session, DataCatalougeViewModel viewModel) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
			String username = ((UserDetails) principal).getUsername();
			AutoUserInfoMaster user = userrepository.findBychrvUserIdAndIntUserSts(username, 1).orElse(null);
			// setSession(user, model);
		} else {
			String username = principal.toString();
		}

		if (session.getAttribute("gLinkList") != null) {
			List<GlobalLinkMaster> glink = new ArrayList<GlobalLinkMaster>();
			glink = (List<GlobalLinkMaster>) session.getAttribute("gLinkList");
			List<String> strLink = new ArrayList<String>();
			strLink = glink.stream().map(m -> m.getChrvGlinkUrl()).collect(Collectors.toList());
			if (strLink.contains("GIS/datacatalogue")) {
				String str2 = "Test";
			}

		}

		try {
			/*
			 * List<ValueText> datasetList = new ArrayList<ValueText>();
			 * repoDatasetMaster.findAll() .forEach(f -> datasetList.add(new
			 * ValueText(f.getIntId(), f.getChrvDatasetNm() + " (" +
			 * (repoDataCatalogueMaster.findAll().stream() .filter(cf ->
			 * cf.getDatasetMaster().getIntId() == f.getIntId()) .map(m ->
			 * m.getDatasetMaster().getIntId()).count()) + ")")));
			 * viewModel.setDatasetMasterValueText(datasetList);
			 */
			List<ValueText> divisionList = new ArrayList<ValueText>();
			repoDivisionMaster.findAll().stream().filter(f -> f.getPhaseMaster().getIntPhase() == 1 && f.getIntId() > 0)
					.forEach(f -> divisionList.add(new ValueText(f.getIntId(),
							f.getChrvDivisionNm() /*
													 * + " (" + (repoDataCatalogueMaster.findAll().stream() .filter(div
													 * -> div.getDivisionMaster().getIntId() == f.getIntId()) .map(m ->
													 * m.getDivisionMaster().getIntId()).count()) + ")"
													 */)));
			viewModel.setDivisionValueText(divisionList);

			model.addAttribute("dataset", viewModel);
			// model.addAttribute("ddl", ob);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/gis/datacatalogue";
	}

	@RequestMapping("/GIS/dataCatalogue")
	public String viewGISDataCatalougev2(Model model, HttpSession session, DataCatalougeViewModel viewModel) {
		
		String url = securityUtility.checkAuthority(1, 1);
		if (url.equalsIgnoreCase("GIS/dataCatalogue")) {
			url = "/gis/datacatalogue";
		}
		
		/*Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
			String username = ((UserDetails) principal).getUsername();
			//AutoUserInfoMaster user = userrepository.findBychrvUserIdAndIntUserSts(username, 1).orElse(null);
		} else {
			String username = principal.toString();
		}

		if (session.getAttribute("gLinkList") != null) {
			List<GlobalLinkMaster> glink = new ArrayList<GlobalLinkMaster>();
			glink = (List<GlobalLinkMaster>) session.getAttribute("gLinkList");
			List<String> strLink = new ArrayList<String>();
			strLink = glink.stream().map(m -> m.getChrvGlinkUrl()).collect(Collectors.toList());
			if (strLink.contains("GIS/datacatalogue")) {
				
			}

		}
		*/

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
			

			List<ValueText> divisionList = new ArrayList<ValueText>();
			repoDivisionMaster.findAll().stream().filter(f -> (!divids.isEmpty()? divids.contains(f.getIntId()):true) && f.getPhaseMaster().getIntPhase() == 1 && f.getIntId() > 0)
					.forEach(f -> divisionList.add(new ValueText(f.getIntId(), f.getChrvDivisionNm())));
			viewModel.setDivisionValueText(divisionList);

			List<Integer> layersIds = new ArrayList<Integer>();
			layersIds.add(19);
			layersIds.add(26);
			layersIds.add(32);

			var v = layersMasterRepo.findAll().stream().filter(f -> !layersIds.contains(f.getId()))
					.collect(Collectors.toList());
			model.addAttribute("layers", v);
			model.addAttribute("dataset", viewModel);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		return url;
	}

	@RequestMapping("/GIS/partialDatacatalogue")
	public String partialDatacatalogue(Model model, @RequestParam(required = false, value = "dsid[]") String[] dsid,
			@RequestParam(required = false, value = "dstagid[]") String[] dstagid,
			@RequestParam(required = false, value = "divid[]") String[] divid,
			@RequestParam(required = false, value = "dstypeid[]") String[] dstypeid,
			@RequestParam(required = false, value = "dsourceid[]") String[] dsourceid) {
		try {
			List<String> strdsArrya = convertArrayToStringList(dsid);
			List<String> strdstagArrya = convertArrayToStringList(dstagid);
			List<String> strdivid = convertArrayToStringList(divid);
			List<String> strdstypeid = convertArrayToStringList(dstypeid);
			List<String> strdsourceid = convertArrayToStringList(dsourceid);

			List<DataCatalogueMaster> findAll = repoDataCatalogueMaster.findAll().stream()
					.filter(f -> (!strdsArrya.isEmpty()
							? strdsArrya.contains(f.getDatasetMaster().getIntId().toString())
							: true)
							&& (!strdstagArrya.isEmpty()
									? strdstagArrya.contains(f.getDatasetTag().getIntId().toString())
									: true)
							&& (!strdivid.isEmpty()
									? strdivid.contains(f.getDivisionMaster().getIntId().toString())
									: true)
							&& (!strdstypeid.isEmpty() ? strdstypeid.contains(f.getDatasetTag().getChrvDatasetType())
									: true)
							&& (!strdsourceid.isEmpty()
									? strdsourceid.contains(f.getDatasetTag().getChrvSource().replace(" ", ""))
									: true))
					.collect(Collectors.toList());

			/*
			 * for (DataCatalogueMaster item : findAll) { var v =
			 * item.getDatasetTag().getIntId();
			 * 
			 * Concatenate Description with Division Name DatasetTag datasetTag =
			 * repoDatasetTag.findById(v).get(); if (item.getDatasetTag().getChrvDesc() !=
			 * null) //
			 * datasetTag.setChrvDesc(item.getDatasetTag().getChrvDesc().replaceFirst("is",
			 * // "of "+item.getDivisionMaster().getChrvDivisionNm()+" Division is"));
			 * datasetTag.setChrvDesc(item.getDatasetTag().getChrvDesc());
			 * item.setDatasetTag(datasetTag); }
			 */

			model.addAttribute("model", findAll);

		//	List<Test> obj = new ArrayList<Test>();

			//model.addAttribute("test", obj);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/gis/partialDatacatalogue";
	}

	@RequestMapping("/GIS/partialDatacatalogue2")
	public String partialDatacatalogue(@RequestParam(name = "id[]") String[] id, Model model) 
	{
		List<String> layersArrya = convertArrayToStringList(id);	 
		var res = layersMasterRepo.findAll().stream().filter(f -> layersArrya.contains(f.getId().toString())).collect(Collectors.toList());
		model.addAttribute("model", res);
		return "/gis/partialDatacatalogue";
	}

	private List<String> convertArrayToStringList(String[] arr) {
		List<String> strArrya = new ArrayList<String>();
		if (arr != null) {
			for (var s : arr) {
				strArrya.add(s);
			}
		}
		return strArrya;
	}

	@PostMapping("/GIS/createProject")
	@Transactional
	public ResponseEntity<String> createProject(HttpSession session,
												@RequestParam("projectname") String projName,
			                                    @RequestParam("divName") Integer divId, 
			                                    @RequestParam("listlayers[]") Integer[] list) 
	{
		UserProjectMaster userPM = new UserProjectMaster();
		List<UserProjectMaster> userPM1 = userProjectMasterRepository.findAllByUser(loggedInUser.getUser());
		userPM1 = userPM1.stream().filter(e -> e.getProjectName().equalsIgnoreCase(projName)).collect(Collectors.toList());

		DivisionMaster dm = divisionMasterRepository.getOne(divId);
		Date date = new Date();
		Timestamp ts = new Timestamp(date.getTime());

		if (userPM1.isEmpty()) {
			try {
				if (userProjectMasterRepository.getMaxId() == null) {
					userPM.setIntId(1);
				} else {
					userPM.setIntId(userProjectMasterRepository.getMaxId() + 1);
				}

				userPM.setDoc(ts);
				userPM.setProjectName(projName);
				userPM.setDivision(dm);
				userPM.setUser(loggedInUser.getUser());
				userPM = userProjectMasterRepository.save(userPM);
				Integer createdId= userProjectMasterRepository.getMaxId();
				for (int i = 0; i < list.length; i++) {
					UserProjectMasterDetails userPMD = new UserProjectMasterDetails();
					LayersMaster layerM = layersMasterRepo.getOne(list[i]);
					if (userProjectMasterDetailsRepository.getMaxId() == null) {
						userPMD.setIntId(1);
					} else {
						userPMD.setIntId(userProjectMasterDetailsRepository.getMaxId() + 1);
					}

					userPMD.setDoc(ts);
					userPMD.setLayers(layerM);
					userPMD.setUserProjectMaster(userPM);
					userProjectMasterDetailsRepository.save(userPMD);
					
					
					List<UserProjectMaster> userProjects = userProjectRepo.findAllByUser(loggedInUser.getUser());
					session.setAttribute("userProjList",userProjects);
				}
				return new ResponseEntity<>("Project Successfully Created_"+createdId, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<>("Sorry, Something went wrong !!", HttpStatus.BAD_REQUEST);
			}

		} else {

			return new ResponseEntity<>("!!! Already Exists !!! Please give another name to project !!",
					HttpStatus.BAD_REQUEST);

		}

	}

}
