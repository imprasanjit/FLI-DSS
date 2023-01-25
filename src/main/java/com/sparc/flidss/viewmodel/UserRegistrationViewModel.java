package com.sparc.flidss.viewmodel;

import com.sparc.flidss.model.common.PositionMaster;
import com.sparc.flidss.model.common.RoleMaster;

public class UserRegistrationViewModel {
	private Integer intId=null;
	private String chrvName;
	private Integer intFkRole;
	private RoleMaster RoleMaster;
	
	private Integer intFkPosition;
	private PositionMaster PositionMaster;
	
	private Integer intFkDist;
	private Integer intFkTehsil;
	private Integer intFkCircle;
	private Integer intFkDivision;
	private String chrvFkRange;
	private String chrvUserId;
	private String chrvUserPwd;
	private String chrvEmail;
	private String charRole;
	private String chrvContactNo;
	
	public Integer getIntId() {
		return intId;
	}
	public void setIntId(Integer intId) {
		this.intId = intId;
	}
	public String getChrvName() {
		return chrvName;
	}
	public void setChrvName(String chrvName) {
		this.chrvName = chrvName;
	}
	public Integer getIntFkRole() {
		return intFkRole;
	}
	public void setIntFkRole(Integer intFkRole) {
		this.intFkRole = intFkRole;
	}
	
	public RoleMaster getRoleMaster() {
		return RoleMaster;
	}
	public void setRoleMaster(RoleMaster roleMaster) {
		RoleMaster = roleMaster;
	}
	public Integer getIntFkPosition() {
		return intFkPosition;
	}
	public void setIntFkPosition(Integer intFkPosition) {
		this.intFkPosition = intFkPosition;
	}
	
	public PositionMaster getPositionMaster() {
		return PositionMaster;
	}
	public void setPositionMaster(PositionMaster positionMaster) {
		PositionMaster = positionMaster;
	}
	public Integer getIntFkDist() {
		return intFkDist;
	}
	public void setIntFkDist(Integer intFkDist) {
		this.intFkDist = intFkDist;
	}
	public Integer getIntFkTehsil() {
		return intFkTehsil;
	}
	public void setIntFkTehsil(Integer intFkTehsil) {
		this.intFkTehsil = intFkTehsil;
	}
	public Integer getIntFkCircle() {
		return intFkCircle;
	}
	public void setIntFkCircle(Integer intFkCircle) {
		this.intFkCircle = intFkCircle;
	}
	public Integer getIntFkDivision() {
		return intFkDivision;
	}
	public void setIntFkDivision(Integer intFkDivision) {
		this.intFkDivision = intFkDivision;
	}
	public String getChrvFkRange() {
		return chrvFkRange;
	}
	public void setChrvFkRange(String chrvFkRange) {
		this.chrvFkRange = chrvFkRange;
	}
	public String getChrvUserId() {
		return chrvUserId;
	}
	public void setChrvUserId(String chrvUserId) {
		this.chrvUserId = chrvUserId;
	}
	public String getChrvUserPwd() {
		return chrvUserPwd;
	}
	public void setChrvUserPwd(String chrvUserPwd) {
		this.chrvUserPwd = chrvUserPwd;
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



}

