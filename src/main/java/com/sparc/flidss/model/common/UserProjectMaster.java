package com.sparc.flidss.model.common;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="user_project_master")
public class UserProjectMaster {
	@Id
	@Column(name="int_id")
	private Integer intId;
	private String projectName;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="fk_user_id")
	private AutoUserInfoMaster user;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="fk_div_id")
	private DivisionMaster division;

	private Timestamp doc=new Timestamp(System.currentTimeMillis());

	public Integer getIntId() {
		return intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public AutoUserInfoMaster getUser() {
		return user;
	}

	public void setUser(AutoUserInfoMaster user) {
		this.user = user;
	}

	public DivisionMaster getDivision() {
		return division;
	}

	public void setDivision(DivisionMaster division) {
		this.division = division;
	}

	public Timestamp getDoc() {
		return doc;
	}

	public void setDoc(Timestamp doc) {
		this.doc = doc;
	}
	
}
