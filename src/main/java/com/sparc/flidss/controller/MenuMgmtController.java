/*
 * package com.sparc.flidss.controller;
 * 
 * import java.sql.Timestamp; import java.time.Instant; import
 * java.util.ArrayList; import java.util.List; import
 * java.util.stream.Collectors;
 * 
 * import javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpSession;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.data.domain.Sort; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.validation.BindingResult; import
 * org.springframework.web.bind.annotation.ModelAttribute; import
 * org.springframework.web.bind.annotation.PathVariable; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.ResponseBody; import
 * org.springframework.web.servlet.ModelAndView; import
 * org.springframework.web.servlet.mvc.support.RedirectAttributes;
 * 
 * import com.sparc.flidss.model.MGlobalLink; import
 * com.sparc.flidss.model.TUserLog; import
 * com.sparc.flidss.repository.MGlobalLinkRepository; import
 * com.sparc.flidss.repository.MModuleRepository; import
 * com.sparc.flidss.repository.MModuleWorkRepository; import
 * com.sparc.flidss.repository.MPrimaryLinkRepository; import
 * com.sparc.flidss.repository.TUserLogRepository; import
 * com.sparc.flidss.viewmodel.MenuMgmtViewModel; import
 * com.sparc.flidss.model.MPrimaryLink;
 * 
 * 
 * @Controller public class MenuMgmtController {
 * 
 * @Autowired MModuleRepository modulerepository;
 * 
 * @Autowired MModuleWorkRepository moduleworkrepository;
 * 
 * @Autowired TUserLogRepository userlogrepository;
 * 
 * @Autowired MGlobalLinkRepository globalLinkRepo;
 * 
 * @Autowired MPrimaryLinkRepository primaryLinkRepo;
 * 
 * 
 * 
 *//**
	 * Objective : Global Link add page. SDate :10Feb2021
	 * 
	 * @version 1.0
	 * @author Thakur
	 */
/*
 * @RequestMapping(value = { "/MenuMgmt/addGlobalLink",
 * "/MenuMgmt/addGlobalLink/{id}/{status}", "/MenuMgmt/addGlobalLink/{id}" },
 * method = RequestMethod.GET) public ModelAndView
 * AddGlobalLink(@PathVariable(required = false) Integer id,
 * 
 * @PathVariable(required = false) Integer status,
 * 
 * @ModelAttribute("globalLink") MenuMgmtViewModel umodel, Model model) { umodel
 * = new MenuMgmtViewModel();
 * 
 * if (status != null) { model.addAttribute("status", status > 0 ? status : 0);
 * } if (id != null && id > 0) { model.addAttribute("btnstatus", id);
 * 
 * umodel.setEditGlobalLink(globalLinkRepo.findById(id).get());
 * 
 * return new ModelAndView("/menuMgmt/addGlobalLink", "globalLink", umodel); }
 * else { model.addAttribute("btnstatus", ""); return new
 * ModelAndView("/menuMgmt/addGlobalLink", "globalLink", umodel); } }
 * 
 *//**
	 * Objective : Global Link Post Data. SDate :10Feb2021
	 * 
	 * @version 1.0
	 * @author Thakur
	 */
/*
 * @RequestMapping(value = "/MenuMgmt/addGlobalLink", method =
 * RequestMethod.POST) public String AddDataGlobalLink(MenuMgmtViewModel model,
 * BindingResult ModelState, HttpServletRequest request, HttpSession session,
 * RedirectAttributes redirectAttributes) { MGlobalLink rstatus = null;
 * 
 * try { if (!ModelState.hasErrors()) { var addModel = new MGlobalLink();
 * addModel.setIntGlinkId(globalLinkRepo.getMaxId() + 1);
 * addModel.setChrvGlinkName(model.getEditGlobalLink().getChrvGlinkName());
 * addModel.setIntPriorityOdr(model.getEditGlobalLink().getIntPriorityOdr());
 * addModel.setChrvDesc(model.getEditGlobalLink().getChrvDesc());
 * addModel.setIntActiveSts(0);
 * addModel.setTmsCreatedOn(Timestamp.from(Instant.now()));
 * addModel.setChrvIpAddress(request.getRemoteAddr()); rstatus =
 * globalLinkRepo.save(addModel);
 * 
 * } else { redirectAttributes.addFlashAttribute("status", "3"); return
 * "redirect:/menuMgmt/addGlobalLink?status=3"; } } catch (Exception ex) { throw
 * ex;
 * 
 * // Tracking User Activity }
 * 
 * 
 * TUserLog log = new TUserLog(); log.setChrvUserId((String)
 * session.getAttribute("userID")); // log.setTmsLogDate(new Timestamp(new
 * java.util.Date().getTime()));
 * log.setTmsLogDate(Timestamp.from(Instant.now())); // log.setIntLogStatus(0);
 * log.setChrvIpAddress(request.getRemoteAddr());
 * log.setMModule(modulerepository.getOne(5));
 * log.setMModuleWork(moduleworkrepository.getOne(15));
 * userlogrepository.save(log);
 * 
 * String sts = rstatus.getIntGlinkId() != null && rstatus.getIntGlinkId() > 0 ?
 * "1" : "3"; redirectAttributes.addFlashAttribute("status", sts); return
 * "redirect:/menuMgmt/addGlobalLink"; }
 * 
 *//**
	 * Objective : Global Link Partial view page to view data. SDate : 10Feb2021
	 * 
	 * @version 1.0
	 * @author Thakur
	 */
/*
 * @RequestMapping(value = "/MenuMgmt/_PartialViewGlobalLink", method =
 * RequestMethod.GET) public String _PartialViewGlobalLink(Model model) { var
 * viewModel = new MenuMgmtViewModel(); try { viewModel = new
 * MenuMgmtViewModel();
 * viewModel.setGlobalLinkList(globalLinkRepo.findAllByOrderByChrvGlinkNameAsc()
 * ); model.addAttribute("viewModel", viewModel); } catch (Exception ex) {
 * 
 * } return "menuMgmt/partialViewGlobalLink"; }
 * 
 *//**
	 * Objective : Global Link Update Status . SDate :10Feb2021
	 * 
	 * @version 1.0
	 * @author Thakur
	 */
/*
 * @PostMapping(value = "/MenuMgmt/UpdateGlobalLinkStatus") // @RequestMapping()
 * public @ResponseBody String UpdateGlobalLinkStatus(@RequestParam(value =
 * "slnoList[]") String[] slnoList,
 * 
 * @RequestParam(name = "astatus") Integer astatus, HttpServletRequest request,
 * HttpSession session) { List<MGlobalLink> rstatus = null; List<MGlobalLink>
 * ulist = new ArrayList<MGlobalLink>(); if (slnoList != null && slnoList.length
 * > 0) {
 * 
 * for (var item : slnoList) {
 * ulist.add(globalLinkRepo.getOne(Integer.parseInt(item))); } } try { if
 * (astatus == 0) ulist.forEach(x -> x.setIntActiveSts(0)); else ulist.forEach(x
 * -> x.setIntActiveSts(1)); rstatus = globalLinkRepo.saveAll(ulist);
 * 
 * } catch (Exception ex) { throw ex; }
 * 
 * 
 * // Tracking User Activity TUserLog log = new TUserLog(); //
 * log.setIntSlno(userlogrepository.getMaxId()); log.setChrvUserId((String)
 * session.getAttribute("userID")); // log.setTmsLogDate(new Timestamp(new
 * java.util.Date().getTime()));
 * log.setTmsLogDate(Timestamp.from(Instant.now())); // log.setIntLogStatus(0);
 * log.setChrvIpAddress(request.getRemoteAddr());
 * log.setMModule(modulerepository.getOne(5));
 * log.setMModuleWork(moduleworkrepository.getOne(17));
 * userlogrepository.save(log);
 * 
 * String res = (!rstatus.isEmpty()) ? "2" : "3"; return res; }
 * 
 *//**
	 * Objective : Global Link Update. SDate :10Feb2021
	 * 
	 * @version 1.0
	 * @author Thakur
	 */
/*
 * @RequestMapping(value = "/MenuMgmt/updateGlobalLink", method =
 * RequestMethod.POST) public @ResponseBody String updateGlobalLink(String
 * Glink, String Desc, Integer Priority, Integer id, HttpServletRequest request,
 * HttpSession session) { MGlobalLink rstatus = null; try { var updateModel =
 * globalLinkRepo.getOne(id); updateModel.setChrvGlinkName(Glink);
 * updateModel.setChrvDesc(Desc); updateModel.setIntPriorityOdr(Priority);
 * updateModel.setTmsUpdatedOn(Timestamp.from(Instant.now()));
 * 
 * rstatus = globalLinkRepo.save(updateModel);
 * 
 * } catch (Exception ex) { throw ex; }
 * 
 * 
 * // Tracking User Activity TUserLog log = new TUserLog();
 * log.setChrvUserId((String) session.getAttribute("userID")); //
 * log.setTmsLogDate(new Timestamp(new java.util.Date().getTime()));
 * log.setTmsLogDate(Timestamp.from(Instant.now())); // log.setIntLogStatus(0);
 * log.setChrvIpAddress(request.getRemoteAddr());
 * log.setMModule(modulerepository.getOne(5));
 * log.setMModuleWork(moduleworkrepository.getOne(16));
 * userlogrepository.save(log);
 * 
 * 
 * return (rstatus != null && rstatus.getIntGlinkId() > 0) ? "2" : "3"; }
 * 
 * 
 *//**
	 * Objective : PrimaryLink add page. SDate : 11Feb2021
	 * 
	 * @version 1.0
	 * @author Thakur
	 */
/*
 * @RequestMapping(value = { "/MenuMgmt/addPrimaryLink",
 * "/MenuMgmt/addPrimaryLink/{id}/{status}", "/MenuMgmt/addPrimaryLink/{id}" },
 * method = RequestMethod.GET) public ModelAndView
 * AddPrimaryLink(@PathVariable(required = false) Integer id,
 * 
 * @PathVariable(required = false) Integer status,
 * 
 * @ModelAttribute("primaryLink") MenuMgmtViewModel umodel, Model model) {
 * umodel = new MenuMgmtViewModel();
 * 
 * if (status != null) { model.addAttribute("status", status > 0 ? status : 0);
 * } if (id != null && id > 0) { model.addAttribute("btnstatus", id);
 * 
 * umodel.setEditPrimaryLink(primaryLinkRepo.findById(id).get());
 * umodel.setGlobalLinkList(globalLinkRepo.findAll());
 * 
 * return new ModelAndView("/menuMgmt/addPrimaryLink", "primaryLink", umodel); }
 * else { model.addAttribute("btnstatus", "");
 * 
 * umodel.setGlobalLinkList(globalLinkRepo.findAll());
 * 
 * return new ModelAndView("/menuMgmt/addPrimaryLink", "primaryLink", umodel); }
 * }
 * 
 *//**
	 * Objective : Add Data To PrimaryLink Table SDate : 11Feb2021
	 * 
	 * @version 1.0
	 * @author Thakur
	 */
/*
 * @RequestMapping(value = "/MenuMgmt/addPrimaryLink", method =
 * RequestMethod.POST) public String AddDataPrimaryLink(MenuMgmtViewModel model,
 * BindingResult ModelState, HttpServletRequest request, HttpSession session,
 * RedirectAttributes redirectAttributes) { MPrimaryLink rstatus = null;
 * 
 * try { if (!ModelState.hasErrors()) { var addModel = new MPrimaryLink();
 * addModel.setIntPlinkId(primaryLinkRepo.getMaxId() + 1);
 * addModel.setMGlobalLink(
 * globalLinkRepo.findById(model.getEditPrimaryLink().getMGlobalLink().
 * getIntGlinkId()).get());
 * addModel.setChrvPlinkName(model.getEditPrimaryLink().getChrvPlinkName());
 * addModel.setIntPriorityOdr(model.getEditPrimaryLink().getIntPriorityOdr());
 * addModel.setChrvDesc(model.getEditPrimaryLink().getChrvDesc());
 * addModel.setChrvPlinkUrl(model.getEditPrimaryLink().getChrvPlinkUrl());
 * addModel.setIntActiveSts(0);
 * addModel.setTmsCreatedOn(Timestamp.from(Instant.now()));
 * addModel.setChrvIpAddress(request.getRemoteAddr());
 * 
 * rstatus = primaryLinkRepo.save(addModel);
 * 
 * } else { redirectAttributes.addFlashAttribute("status", 3); return
 * "redirect:/MenuMgmt/addPrimaryLink"; } } catch (Exception ex) { throw ex;
 * 
 * } String sts = rstatus.getIntPlinkId() != null && rstatus.getIntPlinkId() > 0
 * ? "1" : "3"; redirectAttributes.addFlashAttribute("status", sts); return
 * "redirect:/MenuMgmt/addPrimaryLink"; }
 * 
 *//**
	 * Objective :Update PrimaryLink(On AJAX Call). SDate : 11Feb2021
	 * 
	 * @version 1.0
	 * @author Thakur
	 */
/*
 * @RequestMapping(value = "/MenuMgmt/updatePrimaryLink", method =
 * RequestMethod.POST) public @ResponseBody String updatePrimaryLink(String
 * Plink, String Desc, Integer Priority, String Url, Integer GlinkId, Integer
 * id, HttpServletRequest request, HttpSession session) { MPrimaryLink rstatus =
 * null; try { var updateModel = primaryLinkRepo.findById(id).get(); if
 * (updateModel != null) {
 * updateModel.setMGlobalLink(globalLinkRepo.findById(GlinkId).get());
 * updateModel.setChrvPlinkName(Plink); updateModel.setChrvDesc(Desc);
 * updateModel.setIntPriorityOdr(Priority); updateModel.setChrvPlinkUrl(Url);
 * updateModel.setTmsUpdatedOn(Timestamp.from(Instant.now())); }
 * 
 * rstatus = primaryLinkRepo.save(updateModel);
 * 
 * } catch (Exception ex) { throw ex; }
 * 
 * try { // Tracking User Activity TUserLog log = new TUserLog();
 * log.setChrvUserId((String) session.getAttribute("userID"));
 * log.setTmsLogDate(Timestamp.from(Instant.now())); // log.setIntLogStatus(0);
 * log.setChrvIpAddress(request.getRemoteAddr());
 * log.setMModule(modulerepository.getOne(5));
 * log.setMModuleWork(moduleworkrepository.getOne(19));
 * userlogrepository.save(log); } catch (Exception e) { // TODO Auto-generated
 * catch block e.printStackTrace(); }
 * 
 * return (rstatus != null && rstatus.getIntPlinkId() > 0) ? "2" : "3"; }
 * 
 * @PostMapping(value = "/MenuMgmt/UpdatePrimaryLinkStatus")
 * public @ResponseBody String UpdatePrimaryLinkStatus(@RequestParam(value =
 * "slnoList[]") String[] slnoList,
 * 
 * @RequestParam(name = "astatus") Integer astatus, HttpServletRequest request,
 * HttpSession session) { List<MPrimaryLink> rstatus = null; List<MPrimaryLink>
 * ulist = new ArrayList<MPrimaryLink>(); if (slnoList != null &&
 * slnoList.length > 0) {
 * 
 * for (var item : slnoList) {
 * ulist.add(primaryLinkRepo.getOne(Integer.parseInt(item))); } } try { if
 * (astatus == 0) ulist.forEach(x -> x.setIntActiveSts(0)); else ulist.forEach(x
 * -> x.setIntActiveSts(1)); rstatus = primaryLinkRepo.saveAll(ulist);
 * 
 * } catch (Exception ex) { throw ex; }
 * 
 * // Tracking User Activity try { TUserLog log = new TUserLog();
 * log.setChrvUserId((String) session.getAttribute("userID"));
 * log.setTmsLogDate(Timestamp.from(Instant.now())); // log.setIntLogStatus(0);
 * log.setChrvIpAddress(request.getRemoteAddr());
 * log.setMModule(modulerepository.getOne(5));
 * log.setMModuleWork(moduleworkrepository.getOne(20));
 * userlogrepository.save(log); } catch (Exception e) { // TODO Auto-generated
 * catch block e.printStackTrace(); }
 * 
 * String res = (!rstatus.isEmpty()) ? "2" : "3"; return res; }
 * 
 *//**
	 * Objective : Primary Link List SDate : 11Feb2021
	 * 
	 * @version 1.0
	 * @author Thakur
	 *//*
		 * 
		 * @RequestMapping(value = "/MenuMgmt/_PartialViewPrimaryLink", method =
		 * RequestMethod.GET) public String _PartialViewPrimaryLink(Model model) { try {
		 * var viewModel = new MenuMgmtViewModel(); viewModel.setPrimaryLinkList(
		 * primaryLinkRepo.findAll(Sort.by(Sort.Direction.ASC, "MGlobalLink.intGlinkId",
		 * "chrvPlinkName")) .stream().collect(Collectors.toList()));
		 * model.addAttribute("viewModel", viewModel);
		 * 
		 * } catch (Exception ex) {
		 * 
		 * } return "menuMgmt/partialViewPrimaryLink"; }
		 * 
		 * 
		 * }
		 */