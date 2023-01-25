package com.sparc.flidss.viewmodel;

import java.util.List;

import com.sparc.flidss.model.common.DesignationMaster;

public class RolePermissionMgmtViewModel {
	
	 private List<DesignationMaster> dlist;
	 private DesignationMaster editDesignation;
	public List<DesignationMaster> getDlist() {
		return dlist;
	}
	public void setDlist(List<DesignationMaster> dlist) {
		this.dlist = dlist;
	}
	public DesignationMaster getEditDesignation() {
		return editDesignation;
	}
	public void setEditDesignation(DesignationMaster editDesignation) {
		this.editDesignation = editDesignation;
	}

	
}
