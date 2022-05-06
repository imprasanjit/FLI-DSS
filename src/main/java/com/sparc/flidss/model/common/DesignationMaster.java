package com.sparc.flidss.model.common;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="designation_master")
@NamedQuery(name="DesignationMaster.findAll", query="SELECT m FROM DesignationMaster m")
public class DesignationMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_designation_nm")
	private String chrvDesignationNm;
	
	@Column(name="int_status")
	private Integer intstatus;

	public Integer getIntId() {
		return intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvDesignationNm() {
		return chrvDesignationNm;
	}

	public void setChrvDesignationNm(String chrvDesignationNm) {
		this.chrvDesignationNm = chrvDesignationNm;
	}

	public Integer getIntstatus() {
		return intstatus;
	}

	public void setInt_status(Integer intstatus) {
		this.intstatus = intstatus;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}