package com.sparc.flidss.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;

import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.GlobalLinkMaster;
import com.sparc.flidss.model.common.PrimaryLinkMaster;
import com.sparc.flidss.model.common.UserProjectMaster;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
import com.sparc.flidss.repository.common.GlobalLinkRepository;
import com.sparc.flidss.repository.common.PrimaryLinkRepository;
import com.sparc.flidss.repository.common.SetPermissionRepository;
import com.sparc.flidss.repository.common.UserProjectMasterDetailsRepository;
import com.sparc.flidss.repository.common.UserProjectMasterRepository;
import com.sparc.flidss.service.TripleDESEncryptionService;
import com.sparc.flidss.utility.FileUploadUtil;
import com.sparc.flidss.utility.MailSender;
import com.sparc.flidss.viewmodel.LoginViewModel;

@Controller
@SessionAttributes({ "infoBox", "infoBoxFld", "infoBoxFli", "roleID", "roleNm", "userName", "distID", "divID", "cirID",
		"rngId", "rngCode", "posID", "posName", "userID", "PkUserId", "RPath", "gLinkList", "pLinkList",
		"dashboardLRoles", "pImage", "userMobile", "userEmail", "userAddress", "userProjList" })
public class HomeController {
	@Autowired
	AutoUserInfoRepository userrepository;
	@Autowired
	TripleDESEncryptionService encService;
	// @Autowired
	// RoleConfiguration roleConfig;
	String authorizeRole = "";
	@Autowired
	SetPermissionRepository permissionrepository;
	@Autowired
	GlobalLinkRepository globalrepository;
	@Autowired
	PrimaryLinkRepository primaryrepository;
	@Autowired
	AutoUserInfoRepository autoUserInfoRepository;
	@Autowired
	UserProjectMasterRepository userProjectRepo;
	@Autowired
	UserProjectMasterDetailsRepository userProjDetailsRepo;

	// @RequestMapping("/")
	// public ModelAndView login() {
	// return new ModelAndView("/home/index");
	// }

	@PostMapping("/login_success_url")
	public String logIn(Model model) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = null;
		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
		} else {
			username = principal.toString();
		}
		AutoUserInfoMaster loggedInUser = autoUserInfoRepository.findBychrvUserId(username);

		setSession(loggedInUser, model);
		
		// System.out.println("LoggedIn user:" + loggedInUser.getProfileImage());

		StringBuilder redirectUrl = new StringBuilder();
		Integer roleId = loggedInUser.getRoleMaster().getIntID();

		// District Level
		if (roleId == 10) {
			redirectUrl.append("redirect:/DistDashboard");
		}
		//circle level
		else if (roleId == 12) {
			redirectUrl.append("redirect:/Dashboard");
		}
		// Division Level
		else if (roleId == 8) {
			redirectUrl.append("redirect:/DivDashboard");
		}
		//Range level
		else if (roleId == 9) {
			redirectUrl.append("redirect:/Dashboard");
		}
		// for 11.Administrator/ 6.SLTP// 4.ORSAC// 3.PCCF// 2.FITGC
		else if (roleId == 11 || roleId == 6 || roleId == 4 || roleId == 3 || roleId == 2) {
			redirectUrl = new StringBuilder();
			redirectUrl.append("redirect:/Dashboard");
		} else {

		}

		return redirectUrl.toString();
	}

	@PostMapping("/login_failure_url")
	public String loginFailureHandler(HttpServletRequest req, HttpServletResponse res) {
		// System.out.println("Login failure handler....");
		return "/exceptionhandler/error_login";
	}

	@GetMapping("/access-denied")
	public String getAccessDenied() {
		return "/exceptionhandler/error_forbidden";
	}

	@GetMapping(value = { "/", "/login" })
	public String index(Model model) {
		model.addAttribute("infoBox", true);
		model.addAttribute("infoBoxFld", true);
		model.addAttribute("infoBoxFli", true);
		model.addAttribute("loginForm", new LoginViewModel());
		model.addAttribute("ErrorMsg", (String) model.asMap().get("ErrorMsg"));
		return "home/index";
	}

	@RequestMapping(value = "/403")
	public @ResponseBody String notAuthorize() {
		return "you are not authorize!";
	}

	/*
	 * // @RequestMapping(value = { "/login", "/", "/Home/index" }, method = //
	 * RequestMethod.POST)
	 * 
	 * @RequestMapping(value = "/dsf", method = RequestMethod.POST) public String
	 * LogIn(@ModelAttribute("loginForm") LoginViewModel info, BindingResult result,
	 * Model model, RedirectAttributes redirectAttributes, HttpServletRequest
	 * request) throws Exception { String redirectUrl = "redirect:/"; try {
	 * 
	 * info.setIsOTPCheck(info.getIsOTPCheck() != null ? info.getIsOTPCheck() :
	 * false); Boolean isAuthenticated = false; AutoUserInfoMaster user =
	 * userrepository.findBychrvUserIdAndIntUserSts(info.getChrv_user_id(), 1)
	 * .orElse(null); List<AutoUserInfoMaster> contactList =
	 * userrepository.findBychrvContactNo(info.getChrv_user_id()); if
	 * (result.hasErrors()) { return "redirect:/"; } if (user != null ||
	 * contactList.size() > 0) { if (info.getIsOTPCheck() == false) {
	 * 
	 * if (user != null && user.getChrvUserPwd() != null) { if
	 * (user.getChrvUserPwd().equals(encService.encryptText(info.getChrv_user_pwd())
	 * )) { //setSession(user, model); redirectUrl = "redirect:GIS/dataCatalogue"; }
	 * 
	 * else if (user != null && user.getChrvUserPwd() != null) { if
	 * (!user.getChrvUserPwd().equals(encService.encryptText(info.getChrv_user_pwd()
	 * ))) { redirectAttributes.addFlashAttribute("ErrorMsg", "Invalid Password.");
	 * return "redirect:/"; } } else { if (contactList.size() > 0 &&
	 * !contactList.get(0).getChrvUserPwd()
	 * .equals(encService.encryptText(info.getChrv_user_pwd()))) {
	 * redirectAttributes.addFlashAttribute("ErrorMsg", "Invalid Password."); return
	 * "redirect:/"; } else { user = contactList.size() > 0 ? contactList.get(0) :
	 * null; } } } else { if (info.getInt_eotp() == null || info.getInt_eotp() == 0)
	 * { redirectAttributes.addFlashAttribute("ErrorMsg", "Provide OTP."); return
	 * "redirect:/"; } else { if (info.getInt_eotp() != info.getInt_votp()) {
	 * redirectAttributes.addFlashAttribute("ErrorMsg", "Invalid OTP."); return
	 * "redirect:/"; } } }
	 * 
	 * 
	 * TUserLog log = new TUserLog(); log.setChrvUserId(user.getChrvUserId());
	 * log.setTmsLogDate(new Timestamp(new java.util.Date().getTime()));
	 * log.setIntLogStatus(0); log.setChrvIpAddress(request.getRemoteAddr());
	 * log.setMModule(modulerepository.getOne(1));
	 * log.setMModuleWork(moduleworkrepository.getOne(1));
	 * userlogrepository.save(log);
	 * 
	 * setSession(user, model);
	 * 
	 * 
	 * if
	 * (Arrays.asList(roleConfig.getAdminOnly()).contains(model.getAttribute("posID"
	 * ).toString())) { authorizeRole = "Admin"; } else { authorizeRole = "User"; }
	 * 
	 * 
	 * 
	 * Role Wise login if
	 * (Arrays.asList(roleConfig.getLandingAsContactPageRoles()).contains(model.
	 * getAttribute("posID").toString())) { return "redirect:contactdetails"; }
	 * else{
	 * 
	 * return "redirect:GIS/dataCatalogue"; }
	 * 
	 * } else { redirectAttributes.addFlashAttribute("ErrorMsg",
	 * "Invalid attempts!"); return "redirect:/"; } } else {
	 * redirectAttributes.addFlashAttribute("ErrorMsg",
	 * "Provide Valid Email ID/ Mobile No"); return "redirect:/"; }
	 * 
	 * } catch (Exception ex) { return "redirect:/"; }
	 * 
	 * return redirectUrl; }
	 */

	public void setSession(AutoUserInfoMaster user, Model model) {
		try {

			model.addAttribute("roleID", user.getRoleMaster().getIntID().toString());
			model.addAttribute("roleNm", user.getRoleMaster().getChrvRoleNm().toString());
			model.addAttribute("userName", user.getChrvNm().toString());
			model.addAttribute("distID",
					(user.getDistrictMaster() != null ? user.getDistrictMaster().getIntId() : null));
			model.addAttribute("divID",
					(user.getDivisionMaster() == null) ? "" : user.getDivisionMaster().getIntId().toString());
			model.addAttribute("cirID",
					(user.getCircleMaster() == null) ? "" : user.getCircleMaster().getIntId().toString());
			model.addAttribute("rngCode",
					(user.getRangeMaster() == null) ? "" : user.getRangeMaster().getChrvRangeCd());
			model.addAttribute("rngId", (user.getRangeMaster() == null) ? "" : user.getRangeMaster().getChrvRangeCd());
			model.addAttribute("posID", user.getPositionMaster().getIntId().toString());
			model.addAttribute("posName", user.getPositionMaster().getChrvPositionNm().toString());
			model.addAttribute("userID", user.getChrvUserId().toString());
			model.addAttribute("PkUserId", user.getIntId().toString());
			model.addAttribute("RPath", "");
			if (user.getProfileImage() == null || user.getProfileImage() == "") {
				user.setProfileImage("profile-default.png");
				autoUserInfoRepository.save(user);
				model.addAttribute("pImage", user.getProfileImage());
			}
			model.addAttribute("pImage", user.getProfileImage());
			model.addAttribute("userMobile", user.getChrvContactNo());
			model.addAttribute("userEmail", user.getChrvEmail());
			model.addAttribute("userAddress", user.getChrvAddress());
			List<GlobalLinkMaster> glinklist = new ArrayList<GlobalLinkMaster>();
			List<PrimaryLinkMaster> plinklist = new ArrayList<PrimaryLinkMaster>();

			List<GlobalLinkMaster> collectGL = permissionrepository.findAll().stream()
					.filter(a -> a.getPositionMaster() == user.getPositionMaster() && a.getIntActiveSts() == 0)
					.map(a -> a.getGlobalLinkMaster()).distinct()
					.sorted(Comparator.comparing(GlobalLinkMaster::getIntPriorityOdr)).collect(Collectors.toList());

			glinklist.addAll(collectGL);

			// List<Integer>
			// glist=collectGL.stream().map(m->m.getIntGlinkId()).collect(Collectors.toList());

			// List<GlobalLinkMaster> activeGlobalLinkList =
			// globalrepository.findAll().stream().filter(f->
			// glist.contains(f.getIntGlinkId())).collect(Collectors.toList());
			// for(GlobalLinkMaster item:activeGlobalLinkList) {
			// glinklist.add(item);
			// }

//			for (Integer item : glist) {
//				glinklist.add(globalrepository.findAll().stream()
//						.filter(a -> a.getIntGlinkId() == item && a.getIntActiveSts() == 0).findAny().get());
//			}

			List<PrimaryLinkMaster> collectPL = permissionrepository.findAll().stream()
					.filter(a -> a.getPrimaryLinkMaster() != null && a.getPositionMaster() != null
							&& a.getPositionMaster() == user.getPositionMaster() && a.getIntActiveSts() == 0)
					.map(a -> a.getPrimaryLinkMaster())
					.sorted(Comparator.comparing(PrimaryLinkMaster::getIntPriorityOdr)).collect(Collectors.toList());

			List<Integer> plist = collectPL.stream().map(m -> m.getIntPlinkId()).collect(Collectors.toList());

			for (Integer item : plist) {
				if (primaryrepository.findAll().stream()
						.filter(a -> a.getIntPlinkId() != null && a.getIntPlinkId() == item && a.getIntActiveSts() == 0)
						.findAny().isPresent()) {
					plinklist.add(primaryrepository.findAll().stream().filter(
							a -> a.getIntPlinkId() != null && a.getIntPlinkId() == item && a.getIntActiveSts() == 0)
							.findAny().get());
				}
			}

//			model.addAttribute("gLinkList", glinklist.stream()
//					.sorted(Comparator.comparing(GlobalLinkMaster::getIntPriorityOdr)).collect(Collectors.toList()));
			model.addAttribute("gLinkList", glinklist);

			model.addAttribute("pLinkList", plinklist);

			List<UserProjectMaster> userProjects = userProjectRepo.findAllByUser(user);
			List<UserProjectMaster> collect = userProjects.stream().filter(f->(f.getDeletedStatus()!=null?f.getDeletedStatus():0)==1).collect(Collectors.toList());
			model.addAttribute("userProjList", collect);
			// userProjects.stream().filter(f->f.get))

			// List<SetPermissionMaster> collect =
			// permissionrepository.findAll().stream().collect(Collectors.toList());
			// List<PrivilegeMaster> collect2 =
			// collect.stream().map(f->f.getPrivilegeMaster()).collect(Collectors.toList());
			// collect2.stream().filter(f->f.getChrvPrivilage());

			// model.addAttribute("dashboardLRoles",
			// roleConfig.getLandingAsDashboardPageRoles());

			/*
			 * for(GlobalLinkMaster glink :glinklist) {
			 * if(plinklist.stream().filter(a->a.getGlobalLinkMaster().getIntGlinkId()==
			 * glink.getIntGlinkId()).count()==1 &&
			 * glink.getChrvGlinkName()==plinklist.stream().filter(a->a.getGlobalLinkMaster(
			 * ).getIntGlinkId()==glink.getIntGlinkId()).map(a->a.getChrvPlinkName()).
			 * collect(Collectors.toList()).get(0)) {
			 * 
			 * } }
			 * 
			 * for(GlobalLinkMaster glink :glinklist) {
			 * 
			 * String orElse =
			 * plinklist.stream().filter(f->f.getGlobalLinkMaster().getIntGlinkId()==glink.
			 * getIntGlinkId()).map(m->m.getChrvPlinkUrl()).findFirst().orElse(null);
			 * 
			 * if(plinklist.stream().filter(a->a.getGlobalLinkMaster().getIntGlinkId()==
			 * glink.getIntGlinkId()).count()==1 &&
			 * glink.getChrvGlinkName()==plinklist.stream().filter(a->a.getGlobalLinkMaster(
			 * ).getIntGlinkId()==glink.getIntGlinkId()).map(a ->
			 * a.getChrvPlinkName()).collect(Collectors.toList()).get(0)) {
			 * 
			 * } }
			 */
		} catch (Exception ex) {
			throw ex;
		}
	}

	@PostMapping("/login_user")
	public String forgotPassword(HttpServletRequest request, Model model) throws Exception {

		String userEmail = request.getParameter("email").trim().toLowerCase();
		AutoUserInfoMaster user = autoUserInfoRepository.findBychrvEmail(userEmail);
		String msg = null;
		String url = null;

		if (user != null) {
			try {
				String password = new TripleDESEncryptionService().decrypt(user.getChrvUserPwd());
				//System.out.println("ForgotPassword mail: " + userEmail);
				String emailSubject = "Password Reset Request";
				String emailBody = "Dear " + user.getChrvNm() + ",\n" + " \nPlease find the password : " + "\""
						+ new TripleDESEncryptionService().decrypt(user.getChrvUserPwd()) + "\"";
				MailSender mailSend = new MailSender();
				msg = mailSend.sendEmail(userEmail, emailSubject, emailBody);

			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
			}
			url = msg.equals("OK") ? "/home/success_forgotpassword" : "/exceptionhandler/failure_forgotpassword";
			;

		} else {
			return "/exceptionhandler/failure_forgotpassword";
		}

		return url;
	}

	@GetMapping("/changepassword")
	public String showChangePassword() {
		return "/changepassword";
	}

	@GetMapping("/profilesettings")
	public String showProfileSettings(Model model) {

		return "/profilesettings";
	}

	@PostMapping("/changepassword")
	public ResponseEntity<String> changePassword(HttpServletRequest request) throws Exception {

		String encodeOldPassword = new TripleDESEncryptionService().encryptText(request.getParameter("oldPassword"));
		String encodeNewPassword = new TripleDESEncryptionService().encryptText(request.getParameter("newPassword"));
		String encodeconfirmPassword = new TripleDESEncryptionService()
				.encryptText(request.getParameter("confirmPassword"));
		System.out.println("oldpassword :" + encodeOldPassword + "\n" + "newPassword: " + encodeNewPassword + "\n"
				+ "confirmPassword" + encodeconfirmPassword);

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = null;
		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
		} else {
			username = principal.toString();
		}

		AutoUserInfoMaster loggedInUser = autoUserInfoRepository.findBychrvUserId(username);

		if (encodeOldPassword.equals(loggedInUser.getChrvUserPwd())
				&& encodeNewPassword.equals(encodeconfirmPassword)) {

			loggedInUser.setChrvUserPwd(encodeNewPassword);
			//System.out.println(loggedInUser);
			autoUserInfoRepository.save(loggedInUser);
			return new ResponseEntity<>("Password Updated Successfully!!", HttpStatus.OK);

		} else {
			return new ResponseEntity<>("Invalid Password !!", HttpStatus.BAD_REQUEST);
		}

	}

	@PostMapping("/profilesettings")
	public ResponseEntity<String> updateProfile(HttpServletRequest request,
			@RequestParam("image") MultipartFile multipartFile, Model model) throws IOException {
		String defaultFileName = "profile-default.png";
		String newName = request.getParameter("username");
		// String newMail= request.getParameter("email");
		String newContactNumber = request.getParameter("mobilenumber");
		String newAddress = request.getParameter("address");

		System.out.println("\nnewContactNumber : " + newContactNumber + "\nnewAddress : " + newAddress);
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = null;
		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
		} else {
			username = principal.toString();
		}

		AutoUserInfoMaster loggedInUser = autoUserInfoRepository.findBychrvUserId(username);
		String imageFile = loggedInUser.getProfileImage();
		System.out.println("loggedInUser : " + loggedInUser);
		System.out.println("InputFile :" + multipartFile.getOriginalFilename());
		String fileName = "";
		if (!multipartFile.getOriginalFilename().isBlank()) {

			fileName = StringUtils.cleanPath(loggedInUser.getChrvUserId() + "_" + multipartFile.getOriginalFilename());
			System.out.println("fileName : " + fileName);
		}

		loggedInUser.setChrvNm(newName);
		// loggedInUser.setChrvEmail(newMail);
		loggedInUser.setChrvContactNo(newContactNumber);
		loggedInUser.setChrvAddress(newAddress);

		try {
			//System.out.println("File name: " + fileName.length());
			//System.out.println("imageFile name: " + imageFile.length());
			if (!fileName.isBlank() && fileName != imageFile) {
				loggedInUser.setProfileImage(fileName);
				FileUploadUtil.saveFile(fileName, multipartFile);
			} else if (imageFile == null || imageFile == "") {
				loggedInUser.setProfileImage(defaultFileName);
			}

			autoUserInfoRepository.save(loggedInUser);
			setSession(loggedInUser, model);
			return new ResponseEntity<>("Profile Updated Successfully!!", HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("Sorry, Something went wrong !!", HttpStatus.BAD_REQUEST);
		}

	}
}
