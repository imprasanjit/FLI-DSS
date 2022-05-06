package com.sparc.flidss.viewmodel;

import java.util.List;
import javax.validation.constraints.Size;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.CircleMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.PositionMaster;
import com.sparc.flidss.model.common.RangeMaster;
import com.sparc.flidss.model.common.RoleMaster;



public class RegistrationViewModelDetails {

	//private Integer yearid;
	private Integer roleId;
	private List<RoleMaster> role;
	
	private Integer positionId;
	private List<PositionMaster> positionList;

	private Integer circleId;
	private List<CircleMaster> circleList;
	
	private Integer divisionId;
	private List<DivisionMaster> divisionList;
	
	private String rangeCode;
	private List<RangeMaster> rangeList;

    //Add autouser
	private UserRegistrationViewModel addAutoUser;
	
	//@NotBlank(message = "Name is mandatory!")@Length(min = 4,max = 256)
	private String chrvName;
	//@NotBlank(message = "Email is mandatory!") @Email
	private String chrvEmail;
	private String charRole;
	
	//@NotBlank(message = "Contact number is mandatory!")
	@Size(min=10, max=10)
	private String chrvContactNo;
	
	private List<AutoUserInfoMaster> auserList;
    //Profile
	private AutoUserInfoMaster editProfile;
    
	
	
	
	
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public List<RoleMaster> getRole() {
		return role;
	}
	public void setRole(List<RoleMaster> role) {
		this.role = role;
	}
	public Integer getPositionId() {
		return positionId;
	}
	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	
	
	public List<PositionMaster> getPositionList() {
		return positionList;
	}
	public void setPositionList(List<PositionMaster> positionList) {
		this.positionList = positionList;
	}
	public Integer getCircleId() {
		return circleId;
	}
	public void setCircleId(Integer circleId) {
		this.circleId = circleId;
	}
	public List<CircleMaster> getCircleList() {
		return circleList;
	}
	public void setCircleList(List<CircleMaster> circleList) {
		this.circleList = circleList;
	}
	
	public Integer getDivisionId() {
		return divisionId;
	}
	public void setDivisionId(Integer divisionId) {
		this.divisionId = divisionId;
	}
	public List<DivisionMaster> getDivisionList() {
		return divisionList;
	}
	public void setDivisionList(List<DivisionMaster> divisionList) {
		this.divisionList = divisionList;
	}
	
	public String getRangeCode() {
		return rangeCode;
	}
	public void setRangeCode(String rangeCode) {
		this.rangeCode = rangeCode;
	}
	public List<RangeMaster> getRangeList() {
		return rangeList;
	}
	public void setRangeList(List<RangeMaster> rangeList) {
		this.rangeList = rangeList;
	}
	public UserRegistrationViewModel getAddAutoUser() {
		return addAutoUser;
	}
	public void setAddAutoUser(UserRegistrationViewModel addAutoUser) {
		this.addAutoUser = addAutoUser;
	}
	
	public String getChrvName() {
		return chrvName;
	}
	public void setChrvName(String chrvName) {
		this.chrvName = chrvName;
	}
	public String getChrvEmail() {
		return chrvEmail;
	}
	public void setChrvEmail(String chrvEmail) {
		this.chrvEmail = chrvEmail;
	}
	public String getCharRole() {
		return charRole;
	}
	public void setCharRole(String charRole) {
		this.charRole = charRole;
	}
	public String getChrvContactNo() {
		return chrvContactNo;
	}
	public void setChrvContactNo(String chrvContactNo) {
		this.chrvContactNo = chrvContactNo;
	}
	
	
	
	
	public List<AutoUserInfoMaster> getAuserList() {
		return auserList;
	}
	public void setAuserList(List<AutoUserInfoMaster> auserList) {
		this.auserList = auserList;
	}
	public AutoUserInfoMaster getEditProfile() {
		return editProfile;
	}
	public void setEditProfile(AutoUserInfoMaster editProfile) {
		this.editProfile = editProfile;
	}

    //[Display(Name = "Digital Sign")]
    //public IFormFile digital_sign { get; set; }
    //public string digital_sign_path { get; set; }
	
}

