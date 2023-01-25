package com.sparc.flidss.viewmodel;

public class viewUserlist {
	private String chrvNm;
	private String role;
	private String position;
	private String userId;
	private String password;
	private String contactNo;
	private Integer intUserSts;

	public String getRole() {
		return role;
	}

	public Integer getIntUserSts() {
		return intUserSts;
	}

	public void setIntUserSts(Integer intUserSts) {
		this.intUserSts = intUserSts;
	}

	public String getChrvNm() {
		return chrvNm;
	}

	public void setChrvNm(String chrvNm) {
		this.chrvNm = chrvNm;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}

}
