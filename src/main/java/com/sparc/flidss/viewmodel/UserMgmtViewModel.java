package com.sparc.flidss.viewmodel;

import java.util.List;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.CircleMaster;
import com.sparc.flidss.model.common.DistrictMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.GlobalLinkMaster;
import com.sparc.flidss.model.common.PositionMaster;
import com.sparc.flidss.model.common.PrimaryLinkMaster;
import com.sparc.flidss.model.common.PrivilegeMaster;
import com.sparc.flidss.model.common.RangeMaster;
import com.sparc.flidss.model.common.RoleMaster;
import com.sparc.flidss.model.common.SetPermissionMaster;
import com.sparc.flidss.model.common.TehsilMaster;




public class UserMgmtViewModel {
	private AutoUserInfoMaster autouinfo;
	private List<AutoUserInfoMaster> auserList;
	
	private RoleMaster editRoleNm;
	private List<RoleMaster> rolList;
	
	private PositionMaster positionMaster;
	private List<PositionMaster> posList;
	
	private CircleMaster circleMaster;
	private List<CircleMaster> cirList;
	
	private DivisionMaster divisionMaster;
	private List<DivisionMaster> divList;
	
	private DistrictMaster districtMaster;
	private List<DistrictMaster> distList;
	
	private RangeMaster rangeMaster;
	private List<RangeMaster> rngList;
	
	private TehsilMaster tehsilMaster;
	private List<TehsilMaster> tehList;
	/* private List<AutoUserInfoMaster> aUserInfoList; */
	
	private GlobalLinkMaster editGlobalLink;
	private List<GlobalLinkMaster> globalLinkList;
	
	
	private PrimaryLinkMaster editPrimaryLink;
	
	private List<PrimaryLinkMaster> primaryLinkList;
	
	private List<SetPermissionMaster> PermissionList;
	 private List<PrivilegeMaster> privilageList;
	
	public AutoUserInfoMaster getAutouinfo() {
		return autouinfo;
	}

	public void setAutouinfo(AutoUserInfoMaster autouinfo) {
		this.autouinfo = autouinfo;
	}

	public List<AutoUserInfoMaster> getAuserList() {
		return auserList;
	}

	public void setAuserList(List<AutoUserInfoMaster> auserList) {
		this.auserList = auserList;
	}

	
	public RoleMaster getEditRoleNm() {
		return editRoleNm;
	}

	
	public void setEditRoleNm(RoleMaster editRoleNm) {
		this.editRoleNm = editRoleNm;
	}

	public List<RoleMaster> getRoleList() {
		return rolList;
	}

	public void setRoleList(List<RoleMaster> roleList) {
		this.rolList = roleList;
	}

	public List<RoleMaster> getRolList() {
		return rolList;
	}

	public void setRolList(List<RoleMaster> rolList) {
		this.rolList = rolList;
	}

	public PositionMaster getPositionMaster() {
		return positionMaster;
	}

	public void setPositionMaster(PositionMaster positionMaster) {
		this.positionMaster = positionMaster;
	}

	public List<PositionMaster> getPosList() {
		return posList;
	}

	public void setPosList(List<PositionMaster> posList) {
		this.posList = posList;
	}

	public CircleMaster getCircleMaster() {
		return circleMaster;
	}

	public void setCircleMaster(CircleMaster circleMaster) {
		this.circleMaster = circleMaster;
	}

	public List<CircleMaster> getCirList() {
		return cirList;
	}

	public void setCirList(List<CircleMaster> cirList) {
		this.cirList = cirList;
	}

	public DivisionMaster getDivisionMaster() {
		return divisionMaster;
	}

	public void setDivisionMaster(DivisionMaster divisionMaster) {
		this.divisionMaster = divisionMaster;
	}

	public List<DivisionMaster> getDivList() {
		return divList;
	}

	public void setDivList(List<DivisionMaster> divList) {
		this.divList = divList;
	}

	public DistrictMaster getDistrictMaster() {
		return districtMaster;
	}

	public void setDistrictMaster(DistrictMaster districtMaster) {
		this.districtMaster = districtMaster;
	}

	public List<DistrictMaster> getDistList() {
		return distList;
	}

	public void setDistList(List<DistrictMaster> distList) {
		this.distList = distList;
	}

	public RangeMaster getRangeMaster() {
		return rangeMaster;
	}

	public void setRangeMaster(RangeMaster rangeMaster) {
		this.rangeMaster = rangeMaster;
	}

	public List<RangeMaster> getRngList() {
		return rngList;
	}

	public void setRngList(List<RangeMaster> rngList) {
		this.rngList = rngList;
	}

	public TehsilMaster getTehsilMaster() {
		return tehsilMaster;
	}

	public void setTehsilMaster(TehsilMaster tehsilMaster) {
		this.tehsilMaster = tehsilMaster;
	}

	public List<TehsilMaster> getTehList() {
		return tehList;
	}

	public void setTehList(List<TehsilMaster> tehList) {
		this.tehList = tehList;
	}

	public GlobalLinkMaster getEditGlobalLink() {
		return editGlobalLink;
	}

	public void setEditGlobalLink(GlobalLinkMaster editGlobalLink) {
		this.editGlobalLink = editGlobalLink;
	}

	public List<GlobalLinkMaster> getGlobalLinkList() {
		return globalLinkList;
	}

	public void setGlobalLinkList(List<GlobalLinkMaster> globalLinkList) {
		this.globalLinkList = globalLinkList;
	}

	
	
	public PrimaryLinkMaster getEditPrimaryLink() {
		return editPrimaryLink;
	}

	public void setEditPrimaryLink(PrimaryLinkMaster editPrimaryLink) {
		this.editPrimaryLink = editPrimaryLink;
	}

	public List<PrimaryLinkMaster> getPrimaryLinkList() {
		return primaryLinkList;
	}

	public void setPrimaryLinkList(List<PrimaryLinkMaster> primaryLinkList) {
		this.primaryLinkList = primaryLinkList;
	}

	public List<SetPermissionMaster> getPermissionList() {
		return PermissionList;
	}

	public void setPermissionList(List<SetPermissionMaster> permissionList) {
		PermissionList = permissionList;
	}

	public List<PrivilegeMaster> getPrivilageList() {
		return privilageList;
	}

	public void setPrivilageList(List<PrivilegeMaster> privilageList) {
		this.privilageList = privilageList;
	}

	
	}



