package com.sparc.flidss.controller;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;
import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.CircleMaster;
import com.sparc.flidss.model.common.DistrictMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.GlobalLinkMaster;
import com.sparc.flidss.model.common.PositionMaster;
import com.sparc.flidss.model.common.PrimaryLinkMaster;
import com.sparc.flidss.model.common.PrivilegeMaster;
import com.sparc.flidss.model.common.RangeMaster;
import com.sparc.flidss.model.common.ResponseUser;
import com.sparc.flidss.model.common.RoleMaster;
import com.sparc.flidss.model.common.SetPermissionMaster;
import com.sparc.flidss.model.common.TehsilMaster;
import com.sparc.flidss.model.common.UserLogTable;
import com.sparc.flidss.model.common.UsersRole;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
import com.sparc.flidss.repository.common.CircleMasterRepository;
import com.sparc.flidss.repository.common.DistrictMasterRepository;
import com.sparc.flidss.repository.common.DivisionMasterRepository;
import com.sparc.flidss.repository.common.GlobalLinkRepository;
import com.sparc.flidss.repository.common.ModuleMasterRepository;
import com.sparc.flidss.repository.common.ModuleWorkRepository;
import com.sparc.flidss.repository.common.PositionMasterRepository;
import com.sparc.flidss.repository.common.PrimaryLinkRepository;
import com.sparc.flidss.repository.common.PrivilegeMasterRepository;
import com.sparc.flidss.repository.common.RangeMasterRepository;
import com.sparc.flidss.repository.common.RoleMasterRepository;
import com.sparc.flidss.repository.common.SetPermissionRepository;
import com.sparc.flidss.repository.common.TehsilMasterRepository;
import com.sparc.flidss.repository.common.UserLogRepository;
import com.sparc.flidss.repository.common.UsersRolesRepository;
import com.sparc.flidss.service.TripleDESEncryptionService;
import com.sparc.flidss.service.UtilityMasterService;
import com.sparc.flidss.service.impl.UtilityMasterServiceImpl;
import com.sparc.flidss.utility.CustomUtility;
import com.sparc.flidss.utility.RandomNumberGenerator;
import com.sparc.flidss.viewmodel.RWPermissionViewModel;
import com.sparc.flidss.viewmodel.RegistrationViewModelDetails;
import com.sparc.flidss.viewmodel.UserMgmtViewModel;
import com.sparc.flidss.viewmodel.viewUserlist;

@Controller
@RequestMapping("/UserMgmt")
@SessionAttributes("userID")
public class UserMgmtController {
	private static final Logger logger = LoggerFactory.getLogger(AutoUserInfoMaster.class);
	@Autowired
	CircleMasterRepository cirRepo;
	@Autowired
	DivisionMasterRepository divRepo;
	@Autowired
	DistrictMasterRepository distRepo;
	@Autowired
	RangeMasterRepository rangeRepo;
	@Autowired
	TehsilMasterRepository tehRepo;
	@Autowired
	RoleMasterRepository roleMasterRepo;
	@Autowired
	PositionMasterRepository positionRepo;
	@Autowired
	AutoUserInfoRepository autoUserInfoRepo;
	@Autowired
	UtilityMasterService uservice;
	@Autowired
	UtilityMasterServiceImpl userviceImpl;

	@Autowired
	TripleDESEncryptionService encService;
	@Autowired
	GlobalLinkRepository globalLinkRepo;
	@Autowired
	ModuleMasterRepository modulerepository;
	AutoUserInfoMaster res;
	@Autowired
	ModuleWorkRepository moduleworkrepository;
	@Autowired
	UserLogRepository userlogrepository;
	@Autowired
	PrimaryLinkRepository primaryLinkRepo;
	@Autowired
	SetPermissionRepository setPermissionRepo;
	@Autowired
	PrivilegeMasterRepository privilagerepository;

	@Autowired
	UsersRolesRepository usersRolesRepository;

	/*
	 * @RequestMapping("UserMgmt/manageUser") public String manageUser() { return
	 * "userMgmt/manageUser"; }
	 */
	@RequestMapping("UserMgmt/addUser")
	public String addUser() {
		return "userMgmt/addUser";
	}

	/**
	 * View Role list
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/roleCreation", method = RequestMethod.GET)
	public String roleCreation(Model model) {
		List<RoleMaster> roleList = roleMasterRepo.findAll();
		model.addAttribute("roleList", roleList);
		return "UserMgmt/roleCreation";
	}

	/**
	 * Update existing role
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/updateRole", method = RequestMethod.POST)
	public @ResponseBody Integer updateRole(@RequestParam String roleNM, @RequestParam int id) {
		Integer rstatus = 0;
		var existRole = roleMasterRepo.findById(id).get();
		if (!existRole.getChrvRoleNm().equals(roleNM)) {
			existRole.setChrvRoleNm(roleNM);
			RoleMaster res = roleMasterRepo.save(existRole);
			System.out.println(res);
			rstatus = 9;
		} else {
			rstatus = 6;
		}
		return rstatus;
	}

	/**
	 * Create new role
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/roleCreation", method = RequestMethod.POST)
	public @ResponseBody Integer createNewRole(@RequestParam String newRoleNM) {
		Integer rstatus = 0;
		Integer max = roleMasterRepo.getMaxId();
		boolean existRole = roleMasterRepo.findBychrvRoleNm(newRoleNM).isPresent();
		if (existRole == true) {
			rstatus = 6;
		} else {
			RoleMaster role = new RoleMaster();
			role.setChrvRoleNm(newRoleNM);
			role.setIntID(max + 1);
			RoleMaster res = roleMasterRepo.save(role);
			rstatus = 5;
		}
		return rstatus;
	}

	/**
	 * View Position List
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/addPosition", method = RequestMethod.GET)
	public String positionList(Model model) {
		List<PositionMaster> posList = positionRepo.findAll();
		List<RoleMaster> rolelist = roleMasterRepo.findAll();
		model.addAttribute("rolelist", rolelist);
		model.addAttribute("posList", posList);
		return "/UserMgmt/addPosition";
	}

	/**
	 * Update existing Position
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/addPositionToUser", method = RequestMethod.GET)
	public String positionToUserList(Model model) {
		List<AutoUserInfoMaster> uroleList = autoUserInfoRepo.getAllActiveUsers();
		List<PositionMaster> rolelist = positionRepo.getAll();
		List<UsersRole> users = usersRolesRepository.findAll();
		List<ResponseUser> rusers = new ArrayList<>();
		//System.out.println("uroleList : "+uroleList);

		for (int i = 0; i < users.size(); i++) {

			PositionMaster pm = new PositionMaster();
			AutoUserInfoMaster au = new AutoUserInfoMaster();
			ResponseUser user = new ResponseUser();
			UsersRole newUser = new UsersRole();
			newUser = users.get(i);
			au = autoUserInfoRepo.getOne(newUser.getUserId());
			pm = positionRepo.getOne(newUser.getPositionId());
			if (au.getIntUserSts() != null && au.getIntUserSts() == 1) {
				user.setId(newUser.getId());
				user.setUserName(au.getChrvNm());
				user.setUserPosition(pm.getChrvPositionNm());
				rusers.add(user);
			}
		}

		//System.out.println("Users : "+rusers);

		model.addAttribute("rolelist", rolelist);
		model.addAttribute("uroleList", uroleList);
		model.addAttribute("rusers", rusers);
		return "/UserMgmt/addPositionToUser";
	}

	@RequestMapping(value = "/updatePosition", method = RequestMethod.POST)
	public @ResponseBody Integer updatePosition(@RequestParam int rId, @RequestParam String positionNM,
			@RequestParam int id) {
		Integer rstatus = 0;
		var existPosition = positionRepo.findById(id).get();
		var roleId = roleMasterRepo.findById(rId).get();
		if (!existPosition.getChrvPositionNm().equals(positionNM) || existPosition.getRoleMaster().getIntID() != rId) {
			existPosition.setChrvPositionNm(positionNM);
			existPosition.setRoleMaster(roleId);
			positionRepo.save(existPosition);

			rstatus = 9;
		} else {
			rstatus = 7;
		}
		return rstatus;
	}

	/**
	 * Create new Position
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/addPosition", method = RequestMethod.POST)
	public @ResponseBody Integer createNewPosition(@RequestParam Integer rid, @RequestParam String newPosNM) {
		var rolId = roleMasterRepo.findById(rid).get();
		Integer rstatus = 0;
		Integer max = positionRepo.getMaxId();
		boolean existPos = positionRepo.findBychrvPositionNm(newPosNM).isPresent();
		if (existPos == true) {
			rstatus = 6;
		} else {
			PositionMaster pos = new PositionMaster();
			pos.setChrvPositionNm(newPosNM);
			pos.setRoleMaster(rolId);
			pos.setIntId(max + 1);
			positionRepo.save(pos);
			rstatus = 5;
		}
		return rstatus;
	}

	/**
	 * User Page
	 * @version 1.0
	 * @author Madhu
	 */
	@GetMapping(value = "/userCreation")
	public String userCreationPage(Model model) {
		List<RoleMaster> rlist = roleMasterRepo.findAll();
		rlist.remove(8).setIntID(2);//FITGC removed
		rlist.sort((f1,f2)->f1.getChrvRoleNm().compareTo(f2.getChrvRoleNm()));//sorted role according alphabetically
		
		List<PositionMaster> pList = positionRepo.findAll();
		pList.sort((f1,f2)->f1.getChrvPositionNm().compareTo(f2.getChrvPositionNm()));//sorted position according alphabetically
		
		List<CircleMaster> cirList = cirRepo.findAll();
		cirList.sort((f1,f2)->f1.getChrvCircle().compareTo(f2.getChrvCircle()));
		
		List<DivisionMaster> divList = divRepo.findAll();
		divList.sort((f1,f2)->f1.getChrvDivisionNm().compareTo(f2.getChrvDivisionNm()));
		
		List<DistrictMaster> distList = distRepo.findAll();
		distList.sort((f1,f2)->f1.getChrvDistrictNm().compareTo(f2.getChrvDistrictNm()));
		
		List<RangeMaster> rngList = rangeRepo.findAll();
		rngList.sort((f1,f2)->f1.getChrvRangeNm().compareTo(f2.getChrvRangeNm()));
		
		List<TehsilMaster> tehList = tehRepo.findAll();
		tehList.sort((f1,f2)->f1.getChrvTahasilNm().compareTo(f2.getChrvTahasilNm()));
		
		model.addAttribute("rlist", rlist);
		model.addAttribute("pList", pList);
		model.addAttribute("cirList", cirList);
		model.addAttribute("divList", divList);
		model.addAttribute("distList", distList);
		model.addAttribute("rngList", rngList);
		model.addAttribute("tehList", tehList);

		return "/UserMgmt/userc";
	}

	/**
	 * partial User View Page
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/partialUserCreation", method = RequestMethod.GET)
	public String partialUserCreation(Model model, @RequestParam(required = false) int roleId,
			@RequestParam(required = false) int positionId) {
		List<AutoUserInfoMaster> userList = new ArrayList<AutoUserInfoMaster>();
		//List<viewUserlist> userList=new ArrayList<>();
		userList = uservice.getRolePositionWiseUserList(roleId, positionId);
		model.addAttribute("userList", userList);
		model.addAttribute("positionId", positionId);
		model.addAttribute("roleId", roleId);
		return "/UserMgmt/partialUserCreation";

	}

	/**
	 * User edit in partial page
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/partialUserEdit", method = RequestMethod.GET)
	public String partialUserEdit(Model model, @RequestParam(required = false) String uId) {
		var emodel = autoUserInfoRepo.findBychrvUserId(uId);
		model.addAttribute("emodel", emodel);
		UserMgmtViewModel userModel = new UserMgmtViewModel();
		userModel.setAutouinfo(autoUserInfoRepo.findBychrvUserId(uId));
		userModel.setRoleList(roleMasterRepo.findAll());
		userModel.setPosList(positionRepo.findAll());
		userModel.setCirList(cirRepo.findAll());
		userModel.setDivList(divRepo.findAll().stream()
				.filter(a -> a.getCircleMaster().getIntId() == emodel.getCircleMaster().getIntId())
				.collect(Collectors.toList()));
		userModel.setDistList(distRepo.findAll());
		userModel.setRngList(rangeRepo.findAll().stream()
				.filter(a -> a.getDivisionMaster().getIntId() == emodel.getDivisionMaster().getIntId())
				.collect(Collectors.toList()));
		userModel.setTehList(tehRepo.findAll().stream()
				.filter(a -> a.getDistrictMaster().getIntId() == emodel.getDistrictMaster().getIntId())
				.collect(Collectors.toList()));
		model.addAttribute("autoUserInfoMaster", userModel);
		model.addAttribute("autouinfo", userModel.getAutouinfo());
		return "/UserMgmt/partialUserEdit";

	}

	/**
	 * Update User
	 * @version 1.0
	 * @author Madhu
	 */

	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	public @ResponseBody Integer updateUserCreationpublic(@ModelAttribute("autouinfo") AutoUserInfoMaster autouinfo,
			Model model) {
		Integer rstatus = 0;
		var userModel = autoUserInfoRepo.findBychrvUserId(autouinfo.getChrvUserId());
		userModel.setRoleMaster(autouinfo.getRoleMaster());
		userModel.setPositionMaster(autouinfo.getPositionMaster());
		userModel.setChrvNm(autouinfo.getChrvNm());
		userModel.setChrvEmail(autouinfo.getChrvEmail());
		userModel.setChrvContactNo(autouinfo.getChrvContactNo());

		if (autouinfo.getCircleMaster() != null) {
			userModel.setCircleMaster(autouinfo.getCircleMaster());
		}
		if (autouinfo.getDivisionMaster() != null) {
			userModel.setDivisionMaster(autouinfo.getDivisionMaster());
		}
		if (autouinfo.getRangeMaster() != null && autouinfo.getRangeMaster().getChrvRangeCd().length() > 1) {
			userModel.setRangeMaster(autouinfo.getRangeMaster());
		}
		if (autouinfo.getDistrictMaster() != null) {
			userModel.setDistrictMaster(autouinfo.getDistrictMaster());
		}
		if (autouinfo.getTehsilMaster() != null) {
			userModel.setTehsilMaster(autouinfo.getTehsilMaster());
		}
		var res = autoUserInfoRepo.save(userModel);
		rstatus = 9;

		return rstatus;

	}
	
	/**
	 * email validation func
	 * @version 1.0
	 * @author prasanjit
	 */
	@GetMapping("/emailValidate")
	@ResponseBody
	public String emailValidationFunc(@RequestParam String email) {
		boolean existsBychrvEmail = autoUserInfoRepo.existsBychrvEmail(email);
		String message="";
		if(existsBychrvEmail==true) {
			message="email already exist !";
		}
		else
		{
			message="email does'nt exist";
		}
		return message;
		
	}

	/**
	 * Create new Role
	 * @version 1.0
	 * @author Madhu
	 */

	@RequestMapping(value = "/addNewUser", method = RequestMethod.POST)
	@ResponseBody
	public Integer addNewUser(@RequestParam Integer roleId, 
							@RequestParam Integer posId,
							@RequestParam String name, 
							@RequestParam String mail, 
							@RequestParam String mobileNo,
							@RequestParam Integer cirId, 
							@RequestParam Integer divId, 
							@RequestParam String rngCode,
							@RequestParam Integer distId, 
							@RequestParam Integer tehId, 
							HttpServletResponse httpServletResponse,
							HttpServletRequest request, 
							RedirectAttributes redirectAttributes) 
	{

		var rlId = roleMasterRepo.findById(roleId).get();
		var positnid = positionRepo.findById(posId).get();
		var circleId = cirRepo.findById(cirId).get();
		var divsnId = divRepo.findById(divId).get();
		var rngcd = rangeRepo.findBychrvRangeCd(rngCode).get();
		var districtId = distRepo.findById(distId).get();
		var tehsilId = tehRepo.findById(tehId).get();
		//var user = autoUserInfoRepo.findBychrvNm(name).get();
		Integer rstatus = 0;
		Integer max = autoUserInfoRepo.getMaxId();
		boolean existUser = autoUserInfoRepo.existsBychrvEmail(mail);
		if (existUser == true) {
			rstatus = 10;
		} else {
			AutoUserInfoMaster autoUser = new AutoUserInfoMaster();
			autoUser.setChrvNm(name);
			autoUser.setChrvEmail(mail);
			try {
				autoUser.setChrvUserPwd(encService.encryptText(RandomNumberGenerator.RandomPassword()));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			autoUser.setChrvContactNo(mobileNo);
			autoUser.setRoleMaster(rlId);
			autoUser.setChrvRole(roleMasterRepo.findById(roleId).map(f->f.getChrvRoleNm()).get());
			autoUser.setPositionMaster(positnid);
			autoUser.setCircleMaster(circleId);
			autoUser.setDivisionMaster(divsnId);
			autoUser.setRangeMaster(rngcd);
			autoUser.setDistrictMaster(districtId);
			autoUser.setTehsilMaster(tehsilId);
			autoUser.setIntId(max + 1);
			autoUser.setIntUserSts(0);		

			/*if (autoUser.getRoleMaster().getIntID() == 5) {   // For CDLTP Team
				if (autoUser.getPositionMaster().getIntId() == 5) {  // For DGPS Survey
					autoUser.setChrvUserId(
							GenerateUserID(autoUser.getCircleMaster().getIntId(), autoUser.getDivisionMaster().getIntId(), 
									autoUser.getRangeMaster().getChrvRangeCd(), 5));
				} 
				else {
					autoUser.setChrvUserId(autoUser.getChrvEmail());
				}
			
			}
			else if (autoUser.getRoleMaster().getIntID() == 11) { // For Admin
			
				if (autoUser.getPositionMaster().getIntId() == 13) { // For Admin
					autoUser.setChrvUserId(autoUser.getChrvEmail());
				}
				else {
					autoUser.setChrvUserId(autoUser.getChrvEmail());
				}
			
			} else {
				autoUser.setChrvUserId(autoUser.getChrvEmail());
			
			}*/

			autoUser.setChrvUserId(autoUser.getChrvEmail());
			res = autoUserInfoRepo.save(autoUser);
			//UsersRole user = new UsersRole();
			//user.setId(15);
			//user.setPositionId(posId);
			//user.setUserId(res.getIntId());
			//usersRolesRepository.save(user);
			rstatus = 5;
			if (res != null) {
				if (autoUser.getChrvEmail() != null && !autoUser.getChrvEmail().isEmpty()) {
					try {
						String decrypt = encService.decrypt(autoUser.getChrvUserPwd());
						CustomUtility.sendEmail(new String[] { res.getChrvUserId() }, "User Credentials!",
								String.format("Dear " + res.getRoleMaster().getChrvRoleNm() + " User<br/><br/>User ID :"
										+ res.getChrvUserId() + "<br/>Password :"
										+ encService.decrypt(autoUser.getChrvUserPwd())
										+ "<br/>Portal URL : https://odishaflidss.co.in/ <br/>This is a system generated password. So Do not share with anyone.<br/>Thank You."));

					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		return rstatus;
	}

	public static String padLeftZeros(String str, int n) {
		return String.format("%1$" + n + "s", str).replace(' ', '0');
	}

	/// GET :Generate UserID
	/// Developed by :Madhu
	/// </summary>
	/// <param name="cid"></param>
	/// <param name="did"></param>
	/// <param name="rid"></param>
	/// <param name="posid"></param>
	/// <returns></returns>
	public String GenerateUserID(Integer cid, Integer did, String rid, Integer posid) {
		String _userID = null;
		// Circle,Division,Range Lavel
		if (cid != null && did != null && rid != null && !rid.isEmpty() && posid != null) {
			if (posid == 11) { // Range Level user					
				String max = autoUserInfoRepo.findAll().stream()
						.filter(m -> m.getCircleMaster().getIntId() == cid && m.getDivisionMaster().getIntId() == did
								&& m.getRangeMaster().getChrvRangeCd() == rid && m.getPositionMaster().getIntId() == 11)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = rid
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);

				} else {
					_userID = rid + "01";
				}
			} else if (posid == 14) {// RO User
				String max = autoUserInfoRepo.findAll().stream()
						.filter(m -> m.getCircleMaster().getIntId() == cid && m.getDivisionMaster().getIntId() == did
								&& m.getRangeMaster().getChrvRangeCd() == rid && m.getPositionMaster().getIntId() == 14)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = "RO " + rid
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "RO" + rid + "01";
				}
			} else if (posid == 15) { // RI User

				String max = autoUserInfoRepo.findAll().stream()
						.filter(m -> m.getCircleMaster().getIntId() == cid && m.getDivisionMaster().getIntId() == did
								&& m.getRangeMaster().getChrvRangeCd() == rid && m.getPositionMaster().getIntId() == 15)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = "RI " + rid
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "RI" + rid + "01";
				}
			}

		}
		// Circle & Division Lavel
		else if (cid != null && did != null && posid != null) {
			if (posid == 4) { // SLTP- Circle Divisional_co-ordinator										
				var did_code = divRepo.findAll().stream().filter(m -> m.getIntId() == did).findFirst()
						.map(p -> p.getChrvDivisionCode()).get();
				String max = autoUserInfoRepo.findAll().stream()
						.filter(m -> m.getCircleMaster().getIntId() == cid && m.getDivisionMaster().getIntId() == did
								&& m.getRangeMaster().getChrvRangeCd() == rid && m.getPositionMaster().getIntId() == 4)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = did_code + "CDC"
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = did_code + "CDC" + "01";
				}
			} else if (posid == 10) { // Divisional User

				var did_code = divRepo.findAll().stream().filter(m -> m.getIntId() == did).findFirst()
						.map(p -> p.getChrvDivisionCode()).get();
				String max = autoUserInfoRepo.findAll().stream()
						.filter(m -> m.getCircleMaster().getIntId() == cid && m.getDivisionMaster().getIntId() == did
								&& m.getRangeMaster().getChrvRangeCd() == rid && m.getPositionMaster().getIntId() == 10)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();
				if (max != null) {
					_userID = did_code
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = did_code + "01";
				}
			} else if (posid == 5) { // CDLTP-DGPS User
				var did_code = divRepo.findAll().stream().filter(m -> m.getIntId() == did).findFirst()
						.map(p -> p.getChrvDivisionCode());
				String max = autoUserInfoRepo.findAll().stream()
						.filter(m -> m.getCircleMaster().getIntId() == cid && m.getDivisionMaster().getIntId() == did
								&& m.getRangeMaster().getChrvRangeCd() == rid && m.getPositionMaster().getIntId() == 5)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();
				if (max != null) {
					_userID = "DG" + did_code
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "DG" + did_code + "01";
				}
			} else if (posid == 7) { // CDLTP-JVC User

				var did_code = divRepo.findAll().stream().filter(m -> m.getIntId() == did).findFirst()
						.map(p -> p.getChrvDivisionCode()).get();

				String max = autoUserInfoRepo.findAll().stream()
						.filter(m -> m.getCircleMaster().getIntId() == cid && m.getDivisionMaster().getIntId() == did
								&& m.getRangeMaster().getChrvRangeCd() == rid && m.getPositionMaster().getIntId() == 7)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = "JVC" + did_code
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "JVC" + did_code + "01";
				}
			}
			// Position Only
			else if (posid == 6) { // CDLTP-Lab Coordinator
				var did_code = divRepo.findAll().stream().filter(m -> m.getIntId() == did).findFirst()
						.map(p -> p.getChrvDivisionCode()).get();

				String max = autoUserInfoRepo.findAll().stream()
						.filter(m -> m.getCircleMaster().getIntId() == cid && m.getDivisionMaster().getIntId() == did
								&& m.getRangeMaster().getChrvRangeCd() == rid && m.getPositionMaster().getIntId() == 6)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = "LC" + did_code
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "LC" + did_code + "01";
				}
			} else if (posid == 18) { // DFO User									
				var did_code = divRepo.findAll().stream().filter(m -> m.getIntId() == did).findFirst()
						.map(p -> p.getChrvDivisionCode()).get();

				String max = autoUserInfoRepo.findAll().stream()
						.filter(m -> m.getCircleMaster().getIntId() == cid && m.getDivisionMaster().getIntId() == did
								&& m.getRangeMaster().getChrvRangeCd() == rid && m.getPositionMaster().getIntId() == 18)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = "DFO" + did_code
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "DFO" + did_code + "01";
				}
			} else if (posid == 20) { // ACF User										
				var did_code = divRepo.findAll().stream().filter(m -> m.getIntId() == did).findFirst()
						.map(p -> p.getChrvDivisionCode());

				String max = autoUserInfoRepo.findAll().stream()
						.filter(m -> m.getCircleMaster().getIntId() == cid && m.getDivisionMaster().getIntId() == did
								&& m.getRangeMaster().getChrvRangeCd() == rid && m.getPositionMaster().getIntId() == 20)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = "ACF" + did_code
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "ACF" + did_code + "01";
				}
			}
		} else if (posid != null) {
			if (posid == 1) { // FITGC
				String max = autoUserInfoRepo.findAll().stream().filter(m -> m.getPositionMaster().getIntId() == 1)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();
				if (max != null) {
					_userID = "FITGC"
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "FITGC" + "01";
				}
			} else if (posid == 2) {
				// PCCF
				String max = autoUserInfoRepo.findAll().stream().filter(m -> m.getPositionMaster().getIntId() == 2)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = "PCCF"
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "PCCF" + "01";
				}
			} else if (posid == 12) {
				// ORSAC					
				String max = autoUserInfoRepo.findAll().stream().filter(m -> m.getPositionMaster().getIntId() == 12)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = "ORSAC"
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "ORSAC" + "01";
				}
			} else if (posid == 13) {
				// Admin					
				String max = autoUserInfoRepo.findAll().stream().filter(m -> m.getPositionMaster().getIntId() == 13)
						.map(p -> p.getChrvUserId()).sorted().findFirst().get();

				if (max != null) {
					_userID = "Admin"
							+ padLeftZeros(Integer.toString(Integer.parseInt(max.substring(max.length() - 2)) + 1), 2);
				} else {
					_userID = "Admin" + "01";
				}
			}

		}

		return _userID;
	}

	/**
	 * Global Link View Page
	 * @version 1.0
	 * @author Madhu
	 */

	@RequestMapping(value = { "/addGlobalLink", "/addGlobalLink/{id}/{status}",
			"/addGlobalLink/{id}" }, method = RequestMethod.GET)
	public ModelAndView AddGlobalLink(@PathVariable(required = false) Integer id,
			@PathVariable(required = false) Integer status, @ModelAttribute("globalLink") UserMgmtViewModel umodel,
			Model model) {
		umodel = new UserMgmtViewModel();

		if (status != null) {
			model.addAttribute("status", status > 0 ? status : 0);
		}
		if (id != null && id > 0) {
			model.addAttribute("btnstatus", id);
			umodel.setEditGlobalLink(globalLinkRepo.findById(id).get());
			return new ModelAndView("/UserMgmt/addGlobalLink", "globalLink", umodel);
		} else {
			model.addAttribute("btnstatus", "");
			return new ModelAndView("/UserMgmt/addGlobalLink", "globalLink", umodel);
		}
	}

	/**
	 * Objective : Global Link Post Data.
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/addGlobalLink", method = RequestMethod.POST)
	public String AddDataGlobalLink(UserMgmtViewModel model, BindingResult ModelState, HttpServletRequest request,
			HttpSession session, RedirectAttributes redirectAttributes) {
		GlobalLinkMaster rstatus = null;

		try {
			if (!ModelState.hasErrors()) {
				var addModel = new GlobalLinkMaster();
				addModel.setIntGlinkId(globalLinkRepo.getMaxId() + 1);
				addModel.setChrvGlinkName(model.getEditGlobalLink().getChrvGlinkName());
				addModel.setIntPriorityOdr(model.getEditGlobalLink().getIntPriorityOdr());
				addModel.setChrvDesc(model.getEditGlobalLink().getChrvDesc());
				addModel.setChrvGlinkUrl(model.getEditGlobalLink().getChrvGlinkUrl());
				addModel.setLinkStyle(model.getEditGlobalLink().getLinkStyle());
				addModel.setIntActiveSts(0);
				addModel.setTmsCreatedOn(Timestamp.from(Instant.now()));
				addModel.setChrvIpAddress(request.getRemoteAddr());
				rstatus = globalLinkRepo.save(addModel);

			} else {
				redirectAttributes.addFlashAttribute("status", "3");
				return "redirect: /UserMgmt/addGlobalLink?status=3";
			}
		} catch (Exception ex) {
			throw ex;

			// Tracking User Activity
		}

		UserLogTable log = new UserLogTable();
		log.setChrvUserId((String) session.getAttribute("userID"));
		// log.setTmsLogDate(new Timestamp(new java.util.Date().getTime()));
		log.setTmsLogDate(Timestamp.from(Instant.now()));
		// log.setIntLogStatus(0);
		log.setChrvIpAddress(request.getRemoteAddr());
		log.setModuleM(modulerepository.getOne(5));
		log.setModuleWorkM(moduleworkrepository.getOne(15));
		userlogrepository.save(log);

		String sts = rstatus.getIntGlinkId() != null && rstatus.getIntGlinkId() > 0 ? "1" : "3";
		redirectAttributes.addFlashAttribute("status", sts);
		return "redirect:/UserMgmt/addGlobalLink";
	}

	/**
	 * Objective : Global Link Partial view page to view data. SDate :
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/_PartialViewGlobalLink", method = RequestMethod.GET)
	public String _PartialViewGlobalLink(Model model) {
		var viewModel = new UserMgmtViewModel();
		try {
			viewModel = new UserMgmtViewModel();
			viewModel.setGlobalLinkList(globalLinkRepo.findAllByOrderByChrvGlinkNameAsc());
			model.addAttribute("viewModel", viewModel);
		} catch (Exception ex) {

		}
		return "/UserMgmt/_PartialViewGlobalLink";
	}

	/**
	 * Objective : Global Link Update Status . SDate :
	 * 
	 * @version 1.0
	 * @author Madhu
	 */
	@PostMapping(value = "/UpdateGlobalLinkStatus")
	// @RequestMapping()
	public @ResponseBody String UpdateGlobalLinkStatus(@RequestParam(value = "slnoList[]") String[] slnoList,
			@RequestParam(name = "astatus") Integer astatus, HttpServletRequest request, HttpSession session) {
		List<GlobalLinkMaster> rstatus = null;
		List<GlobalLinkMaster> ulist = new ArrayList<GlobalLinkMaster>();
		if (slnoList != null && slnoList.length > 0) {

			for (var item : slnoList) {
				ulist.add(globalLinkRepo.getOne(Integer.parseInt(item)));
			}
		}
		try {
			if (astatus == 0)
				ulist.forEach(x -> x.setIntActiveSts(0));
			else
				ulist.forEach(x -> x.setIntActiveSts(1));
			rstatus = globalLinkRepo.saveAll(ulist);

		} catch (Exception ex) {
			throw ex;
		}

		// Tracking User Activity
		UserLogTable log = new UserLogTable();
		// log.setIntSlno(userlogrepository.getMaxId());
		log.setChrvUserId((String) session.getAttribute("userID"));
		// log.setTmsLogDate(new Timestamp(new java.util.Date().getTime()));
		log.setTmsLogDate(Timestamp.from(Instant.now()));
		// log.setIntLogStatus(0);
		log.setChrvIpAddress(request.getRemoteAddr());
		log.setModuleM(modulerepository.getOne(5));
		log.setModuleWorkM(moduleworkrepository.getOne(17));
		userlogrepository.save(log);

		String res = (!rstatus.isEmpty()) ? "2" : "3";
		return res;
	}

	/**
	 * Objective : Global Link Update. SDate :
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/updateGlobalLink", method = RequestMethod.POST)
	public @ResponseBody String updateGlobalLink(String Glink, String Desc, Integer Priority, String Url, String Style,
			Integer id, HttpServletRequest request, HttpSession session) {
		GlobalLinkMaster rstatus = null;
		try {
			var updateModel = globalLinkRepo.getOne(id);
			updateModel.setChrvGlinkName(Glink);
			updateModel.setChrvDesc(Desc);
			updateModel.setIntPriorityOdr(Priority);
			updateModel.setChrvGlinkUrl(Url);
			updateModel.setLinkStyle(Style);
			updateModel.setTmsUpdatedOn(Timestamp.from(Instant.now()));

			rstatus = globalLinkRepo.save(updateModel);

		} catch (Exception ex) {
			throw ex;
		}

		// Tracking User Activity
		UserLogTable log = new UserLogTable();
		log.setChrvUserId((String) session.getAttribute("userID"));
		// log.setTmsLogDate(new Timestamp(new java.util.Date().getTime()));
		log.setTmsLogDate(Timestamp.from(Instant.now()));
		// log.setIntLogStatus(0);
		log.setChrvIpAddress(request.getRemoteAddr());
		log.setModuleM(modulerepository.getOne(5));
		log.setModuleWorkM(moduleworkrepository.getOne(16));
		userlogrepository.save(log);

		return (rstatus != null && rstatus.getIntGlinkId() > 0) ? "2" : "3";
	}

	/**
	 * Objective : PrimaryLink add page. SDate : 16Dec2020
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = { "/addPrimaryLink", "/addPrimaryLink/{id}/{status}",
			"/addPrimaryLink/{id}" }, method = RequestMethod.GET)
	public ModelAndView AddPrimaryLink(@PathVariable(required = false) Integer id,
			@PathVariable(required = false) Integer status, @ModelAttribute("primaryLink") UserMgmtViewModel umodel,
			Model model) {
		umodel = new UserMgmtViewModel();

		if (status != null) {
			model.addAttribute("status", status > 0 ? status : 0);
		}
		if (id != null && id > 0) {
			model.addAttribute("btnstatus", id);

			umodel.setEditPrimaryLink(primaryLinkRepo.findById(id).get());
			umodel.setGlobalLinkList(globalLinkRepo.findAll().stream().filter(f -> f.getIntActiveSts() == 0)
					.collect(Collectors.toList()));

			return new ModelAndView("/UserMgmt/addPrimaryLink", "primaryLink", umodel);
		} else {
			model.addAttribute("btnstatus", "");

			umodel.setGlobalLinkList(globalLinkRepo.findAll());

			return new ModelAndView("/UserMgmt/addPrimaryLink", "primaryLink", umodel);
		}
	}

	/**
	 * Objective : Primary Link List 
	 * @version 1.0
	 * @author Madhu
	 */

	@RequestMapping(value = "/_PartialViewPrimaryLink", method = RequestMethod.GET)
	public String _PartialViewPrimaryLink(Model model) {
		var viewModel = new UserMgmtViewModel();
		try {
			viewModel = new UserMgmtViewModel();
			viewModel.setPrimaryLinkList(primaryLinkRepo.findAll());
			//primaryLinkRepo.findAll(Sort.by(Sort.Direction.ASC, "getGlobalLinkMaster().getIntGlinkId()", "chrvPlinkName"))
			//.stream().collect(Collectors.toList()));
			model.addAttribute("viewModel", viewModel);

		} catch (Exception ex) {

		}
		return "/UserMgmt/_PartialViewPrimaryLink";
	}

	/**
	 * Objective : Add Data To GlobalLink Table.
	 * @version 1.0
	 * @author Madhu
	 */
	@RequestMapping(value = "/addPrimaryLink", method = RequestMethod.POST)
	public String AddDataPrimaryLink(UserMgmtViewModel model, BindingResult ModelState, HttpServletRequest request,
			HttpSession session, RedirectAttributes redirectAttributes) {
		PrimaryLinkMaster rstatus = null;

		try {
			if (!ModelState.hasErrors()) {
				var addModel = new PrimaryLinkMaster();
				addModel.setIntPlinkId(primaryLinkRepo.getMaxId() + 1);
				addModel.setGlobalLinkMaster(globalLinkRepo
						.findById(model.getEditPrimaryLink().getGlobalLinkMaster().getIntGlinkId()).get());
				addModel.setChrvPlinkName(model.getEditPrimaryLink().getChrvPlinkName());
				addModel.setIntPriorityOdr(model.getEditPrimaryLink().getIntPriorityOdr());
				addModel.setChrvDesc(model.getEditPrimaryLink().getChrvDesc());
				addModel.setChrvPlinkUrl(model.getEditPrimaryLink().getChrvPlinkUrl());
				addModel.setLinkStyle(model.getEditPrimaryLink().getLinkStyle());
				addModel.setIntActiveSts(0);
				addModel.setTmsCreatedOn(Timestamp.from(Instant.now()));
				addModel.setChrvIpAddress(request.getRemoteAddr());

				rstatus = primaryLinkRepo.save(addModel);

			} else {
				redirectAttributes.addFlashAttribute("status", 3);
				return "redirect:/UserMgmt/addPrimaryLink";
			}
		} catch (Exception ex) {
			throw ex;

		}
		String sts = rstatus.getIntPlinkId() != null && rstatus.getIntPlinkId() > 0 ? "1" : "3";
		redirectAttributes.addFlashAttribute("status", sts);
		return "redirect:/UserMgmt/addPrimaryLink";
	}

	/**
	 * Objective :Update PrimaryLink(On AJAX Call).
	 * @version 1.0
	 * @author Thakur
	 */
	@RequestMapping(value = "/updatePrimaryLink", method = RequestMethod.POST)
	public @ResponseBody String updatePrimaryLink(String Plink, String Desc, Integer Priority, String Url, String Style,
			Integer GlinkId, Integer id, HttpServletRequest request, HttpSession session) {
		PrimaryLinkMaster rstatus = null;
		try {
			var updateModel = primaryLinkRepo.findById(id).get();
			if (updateModel != null) {
				updateModel.setGlobalLinkMaster(globalLinkRepo.findById(GlinkId).get());
				updateModel.setChrvPlinkName(Plink);
				updateModel.setChrvDesc(Desc);
				updateModel.setIntPriorityOdr(Priority);
				updateModel.setChrvPlinkUrl(Url);
				updateModel.setLinkStyle(Style);
				updateModel.setTmsUpdatedOn(Timestamp.from(Instant.now()));
			}

			rstatus = primaryLinkRepo.save(updateModel);

		} catch (Exception ex) {
			throw ex;
		}

		// Tracking User Activity
		UserLogTable log = new UserLogTable();
		log.setChrvUserId((String) session.getAttribute("userID"));
		// log.setTmsLogDate(new Timestamp(new java.util.Date().getTime()));
		log.setTmsLogDate(Timestamp.from(Instant.now()));
		// log.setIntLogStatus(0);
		log.setChrvIpAddress(request.getRemoteAddr());
		log.setModuleM(modulerepository.getOne(5));
		log.setModuleWorkM(moduleworkrepository.getOne(19));
		userlogrepository.save(log);

		return (rstatus != null && rstatus.getIntPlinkId() > 0) ? "2" : "3";
	}

	@PostMapping(value = "/UpdatePrimaryLinkStatus")
	public @ResponseBody String UpdatePrimaryLinkStatus(@RequestParam(value = "slnoList[]") String[] slnoList,
			@RequestParam(name = "astatus") Integer astatus, HttpServletRequest request, HttpSession session) {
		List<PrimaryLinkMaster> rstatus = null;
		List<PrimaryLinkMaster> ulist = new ArrayList<PrimaryLinkMaster>();
		if (slnoList != null && slnoList.length > 0) {

			for (var item : slnoList) {
				ulist.add(primaryLinkRepo.getOne(Integer.parseInt(item)));
			}
		}
		try {
			if (astatus == 0)
				ulist.forEach(x -> x.setIntActiveSts(0));
			else
				ulist.forEach(x -> x.setIntActiveSts(1));
			rstatus = primaryLinkRepo.saveAll(ulist);

		} catch (Exception ex) {
			throw ex;
		}

		// Tracking User Activity
		UserLogTable log = new UserLogTable();
		// log.setIntSlno(userlogrepository.getMaxId());
		log.setChrvUserId((String) session.getAttribute("userID"));
		// log.setTmsLogDate(new Timestamp(new java.util.Date().getTime()));
		log.setTmsLogDate(Timestamp.from(Instant.now()));
		// log.setIntLogStatus(0);
		log.setChrvIpAddress(request.getRemoteAddr());
		log.setModuleM(modulerepository.getOne(5));
		log.setModuleWorkM(moduleworkrepository.getOne(20));
		userlogrepository.save(log);

		String res = (!rstatus.isEmpty()) ? "2" : "3";
		return res;
	}

	@RequestMapping(value = "/AddSetPermission", method = RequestMethod.GET)
	public String indexSetPermission(Model model) {
		try {
			var viewModel = new UserMgmtViewModel();
			List<PrimaryLinkMaster> primaryLinkList = primaryLinkRepo.findByintActiveSts(0).stream()
					.filter(f -> f.getGlobalLinkMaster().getIntActiveSts() == 0).collect(Collectors.toList());
			viewModel.setPrimaryLinkList(primaryLinkList);
			model.addAttribute("SetPermission", new UserMgmtViewModel());
			List<RoleMaster> rolelist = roleMasterRepo.findAll().stream()
					.sorted(Comparator.comparing(RoleMaster::getChrvRoleNm)).collect(Collectors.toList());
			model.addAttribute("rolelist", rolelist);
		} catch (Exception ex) {
			throw ex;
		}
		return "/UserMgmt/AddSetPermission";
	}

	@RequestMapping(value = "/_PartialViewSetPermission", method = RequestMethod.GET)
	public String _PartialViewSetPermission(Model model, @RequestParam int rid, int pid) {
		var viewModel = new UserMgmtViewModel();
		model.addAttribute("rid", rid);
		model.addAttribute("pid", pid);
		try {
			viewModel = new UserMgmtViewModel();
			List<SetPermissionMaster> PermissionList = (setPermissionRepo.findAll().stream()
					.filter(f -> f.getIntActiveSts() == 0 && f.getRoleMaster().getIntID() == rid
							&& f.getPositionMaster().getIntId() == pid)
					.collect(Collectors.toList()));
			viewModel.setPermissionList(PermissionList);
			model.addAttribute("PermissionList", PermissionList);
		} catch (Exception ex) {
			throw ex;
		}
		return "/UserMgmt/_PartialViewSetPermission";
	}

	@RequestMapping(value = "/_PartialPermissionEdit", method = RequestMethod.GET)
	public String _PartialPermissionEdit(Model model, @RequestParam(required = false) Integer status, Integer rleid,
			Integer pid) {
		// ViewBag.dlist = _context.m_desination.OrderBy (x =>
		// x.chrv_designation_nm).ToList ();
		if (status != null)
			model.addAttribute("status", (int) status > 0 ? (int) status : 0);
		var viewModel = new UserMgmtViewModel();

		List<PrimaryLinkMaster> primaryLinkList = (primaryLinkRepo
				.findAll(Sort.by(Sort.Direction.ASC, "globalLinkMaster.chrvGlinkName", "chrvPlinkName")).stream()
				.filter(f -> f.getIntActiveSts() == 0).collect(Collectors.toList()));
		viewModel.setPrimaryLinkList(primaryLinkList);
		model.addAttribute("primaryLinkList", primaryLinkList);
		List<SetPermissionMaster> PermissionList = (setPermissionRepo.findAll().stream()
				.filter(f -> f.getIntActiveSts() == 0 && f.getRoleMaster().getIntID() == rleid
						&& f.getPositionMaster().getIntId() == pid)
				.collect(Collectors.toList()));
		viewModel.setPermissionList(PermissionList);
		model.addAttribute("PermissionList", PermissionList);
		List<PrivilegeMaster> privilageList = privilagerepository.findAll();

		viewModel.setPrivilageList(privilageList);
		model.addAttribute("privilageList", privilageList);

		Boolean answer = PermissionList.stream().filter(a -> a.getPrimaryLinkMaster().getIntPlinkId() == 12).findFirst()
				.isPresent();
		//System.out.println(answer);

		return "/UserMgmt/_PartialPermissionEdit";
	}

	@PostMapping(value = "/_SavePermissionInfo")
	public ResponseEntity<String> SavePermissionInfo(Integer status, int roleId, int pid, String permissionData,
			HttpServletRequest request) throws Exception {
		Integer rstatus = 0;
		List<SetPermissionMaster> data = setPermissionRepo.findAll().stream()
				.filter(f -> f.getPositionMaster().getIntId() == pid && f.getRoleMaster().getIntID() == roleId)
				.collect(Collectors.toList());
		
		//for delete all the records and regenerate it with updation
		if (!data.isEmpty())
			setPermissionRepo.deleteAll(data);

		// setPermissionRepo.saveAll(entities);
		// using (var transaction = _context.Database.BeginTransaction ()) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			TypeFactory typeFactory = objectMapper.getTypeFactory();
			List<RWPermissionViewModel> perm_data = objectMapper.readValue(permissionData,
					typeFactory.constructCollectionType(List.class, RWPermissionViewModel.class));
			List<SetPermissionMaster> permissionList = new ArrayList<SetPermissionMaster>();
			Integer id = setPermissionRepo.findAll().stream().mapToInt(m -> m.getIntPermissionId()).max().getAsInt()
					+ 1;
			for (RWPermissionViewModel p : perm_data) {
				SetPermissionMaster tpermission = new SetPermissionMaster();
				tpermission.setRoleMaster(roleMasterRepo.findById(roleId).get());
				tpermission.setPositionMaster(positionRepo.findById(pid).get());
				tpermission.setGlobalLinkMaster(globalLinkRepo.findById(Integer.parseInt(p.getModule())).get());
				tpermission.setPrimaryLinkMaster(primaryLinkRepo.findById(Integer.parseInt(p.getSubmodule())).get());
				tpermission.setPrivilegeMaster(privilagerepository.findById(Integer.parseInt(p.getRw())).get());
				tpermission.setIntActiveSts(0);
				tpermission.setTmsCreatedOn(Timestamp.from(Instant.now()));
				tpermission.setTmsUpdatedOn(Timestamp.from(Instant.now()));
				tpermission.setChrvIpAddress(request.getRemoteAddr());
				tpermission.setIntPermissionId(id);
				permissionList.add(tpermission);
				id = id + 1;
			}
			if (!permissionList.isEmpty()) {
				permissionList = setPermissionRepo.saveAll(permissionList);
			}
		} catch (Exception ex) {
			// transaction.Rollback();
			throw ex;

		}
		return new ResponseEntity<>("Updated Successfully!!", HttpStatus.OK);

	}

	/**
	 * Get User Profile
	 * @version 1.0
	 * @author Madhu
	 */

	@RequestMapping(value = "/generalUserInfo", method = RequestMethod.GET)
	public String userInfo(@RequestParam(required = false) Integer status, Model model, HttpSession session) {
		//session.setAttribute("userID", "Admin");
		//session.setAttribute((String) session.getAttribute("userID"), "");
		//var uid = session.getAttribute("userID").toString();
		AutoUserInfoMaster user = autoUserInfoRepo.findAll().stream()
				.filter(a -> a.getChrvUserId().equals(session.getAttribute("userID").toString())).findFirst().get();
		try {
			user.setChrvUserPwd(encService.decrypt(user.getChrvUserPwd()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String path = user.getChrvUserSign();
		if (path != null)
			model.addAttribute("digital_sign_path", path);
		else
			// model.digital_sign_path = "noImage.png";
			model.addAttribute("digital_sign_path", "noImage.png");
		// model.addAttribute("userlist", ulist);
		var viewModel = new RegistrationViewModelDetails();
		viewModel.setEditProfile(user);
		viewModel.setCircleList(cirRepo.findAll());
		viewModel.setDivisionList(divRepo.findAll());
		viewModel.setRangeList(rangeRepo.findAll());
		model.addAttribute("uInfo", viewModel);
		// TripleDESEncryptionService
		return "/UserMgmt/generalUserInfo";
	}

	@PostMapping("/edit_user")
	public ResponseEntity<String> editUser(@RequestParam("userId") Integer userId,
			@RequestParam("drpPos1") Integer posId) {

		System.out.println("userName : " + userId + "\nuserPositon : " + posId);
		Optional<PositionMaster> userPosition = positionRepo.findById(posId);
		UsersRole user = usersRolesRepository.getOne(userId);
		boolean flag = user.getPositionId() == posId;

		try {
			if (flag) {
				return new ResponseEntity<>("Data Successfully Updated", HttpStatus.OK);
			} else {
				user.setPositionId(posId);
				usersRolesRepository.save(user);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ResponseEntity<>("Data Successfully Updated", HttpStatus.CREATED);

	}

	//@RequestParam("userName") Integer userName, @RequestParam("userPosition") Integer posId
	@PostMapping("/user_access")
	public ResponseEntity<String> createRoleAccess(@RequestParam("userName") Integer userName,
			@RequestParam("userPosition") Integer posId) {

		UsersRole user = new UsersRole();
		user.setId(usersRolesRepository.getMaxId() + 1);
		user.setUserId(userName);
		user.setPositionId(posId);
		usersRolesRepository.save(user);
		return new ResponseEntity<>("Role has been Assigned To User Successfully", HttpStatus.CREATED);
	}

}
