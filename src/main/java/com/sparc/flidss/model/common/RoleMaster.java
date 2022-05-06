package com.sparc.flidss.model.common;

import java.io.Serializable;

import javax.persistence.*;

@Entity
@Table(name="role_master")
@NamedQuery(name="RoleMaster.findAll", query="Select r from RoleMaster r")
public class RoleMaster implements Serializable {
	private static final long serialVersionUID=1L;
	
	@Id
	@Column(name="int_id")
	private Integer intID;
	
	@Column(name="chrv_role_nm")
	private String chrvRoleNm;

	public Integer getIntID() {
		return intID;
	}

	public void setIntID(Integer intID) {
		this.intID = intID;
	}

	public String getChrvRoleNm() {
		return this.chrvRoleNm;
	}

	public void setChrvRoleNm(String chrvRoleNm) {
		this.chrvRoleNm = chrvRoleNm;
	}

	public RoleMaster() {
		
	}

	public RoleMaster(Integer intID, String chrvRoleNm) {
		super();
		this.intID = intID;
		this.chrvRoleNm = chrvRoleNm;
	}

	@Override
	public String toString() {
		return "RoleMaster [intID=" + intID + ", chrvRoleNm=" + chrvRoleNm + "]";
	}
		

}
