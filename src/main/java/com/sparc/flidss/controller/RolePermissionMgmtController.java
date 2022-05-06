package com.sparc.flidss.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import com.sparc.flidss.viewmodel.RolePermissionMgmtViewModel;

import com.sparc.flidss.repository.common.DesignationRepository;
import com.sparc.flidss.model.common.DesignationMaster;


@Controller
@RequestMapping("/RolePermissionMgmt")
public class RolePermissionMgmtController {
	
	@Autowired DesignationRepository designationrepository;
	
		
	@RequestMapping("/desgCreation")
	public String desgCreation() {
		return "/rolePermissionMgmt/desgCreation";
	}
	
	@RequestMapping("/managePermission")
	public String managePermission() {
		return "/rolePermissionMgmt/managePermission";
	}
	
	/*
	 * @RequestMapping(value = "/addDesignation", method = RequestMethod.GET) public
	 * String designationList(Model model, @RequestParam(required = false) Integer
	 * status,
	 * 
	 * @RequestParam(required = false) Integer id) { try { var data = new
	 * RolePermissionMgmtViewModel(); if (status != null)
	 * model.addAttribute("status", (int) status > 0 ? (int) status : 0); if (id !=
	 * null) { model.addAttribute("btnstatus", id);
	 * 
	 * var viewModel = new RolePermissionMgmtViewModel();
	 * viewModel.setEditDesination(designationrepository.findById(id).get());
	 * model.addAttribute("Designation", viewModel); } else {
	 * model.addAttribute("Designation", new RolePermissionMgmtViewModel()); } }
	 * catch (Exception ex) { throw ex; } return
	 * "rolePermissionMgmt/addDesignation"; }
	 */
	@RequestMapping(value="/addDesignation", method=RequestMethod.GET)
	public String addDesignation(Model model,@RequestParam(required = false) Integer status,  @RequestParam(required = false) Integer id) {
		try {
			//var data=new RolePermissionMgmtViewModel();
			if(status != null)
				model.addAttribute("status", (int) status > 0 ? (int) status : 0);
			if (id != null) {
				model.addAttribute("btnstatus", id);
				var viewModel = new RolePermissionMgmtViewModel();
				viewModel.setEditDesignation(designationrepository.findById(id).get());
				model.addAttribute("Designation", viewModel);
			}
			
			else {
				model.addAttribute("Designation",new RolePermissionMgmtViewModel());
			}
		}
			catch (Exception ex) {
			throw ex;
		}
		return "/rolePermissionMgmt/addDesignation";
	}

	@RequestMapping(value = "/_partialViewDesignation", method = RequestMethod.GET)
	public String listDesignation(Model model) {
		try {
			List<DesignationMaster> dlist = designationrepository.findAll();
			model.addAttribute("DList", dlist);
			
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "rolePermissionMgmt/_partialViewDesignation";
	}

	@RequestMapping(value = "/_partialEditUser", method = RequestMethod.GET)
	public String EditUser(Model model) {
		try {
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "rolePermissionMgmt/_partialEditUser";
	}

	
	

}
