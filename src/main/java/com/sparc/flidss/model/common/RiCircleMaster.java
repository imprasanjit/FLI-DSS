package com.sparc.flidss.model.common;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity 
@Table(name="ricircle_master")
public class RiCircleMaster {
	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	public Integer getIntId() {
		return intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getRicName() {
		return ricName;
	}

	public void setRicName(String ricName) {
		this.ricName = ricName;
	}

	public Integer getRevCode() {
		return revCode;
	}

	public void setRevCode(Integer revCode) {
		this.revCode = revCode;
	}

	public String getTahName() {
		return tahName;
	}

	public void setTahName(String tahName) {
		this.tahName = tahName;
	}

	public Integer getTahCode() {
		return tahCode;
	}

	public void setTahCode(Integer tahCode) {
		this.tahCode = tahCode;
	}

	public TehsilMaster getTehsilMaster() {
		return tehsilMaster;
	}

	public void setTehsilMaster(TehsilMaster tehsilMaster) {
		this.tehsilMaster = tehsilMaster;
	}

	public String getDistName() {
		return distName;
	}

	public void setDistName(String distName) {
		this.distName = distName;
	}

	public Integer getDistCode() {
		return distCode;
	}

	public void setDistCode(Integer distCode) {
		this.distCode = distCode;
	}

	public Integer getDistId() {
		return distId;
	}

	public void setDistId(Integer distId) {
		this.distId = distId;
	}

	public Integer getDivtId() {
		return divtId;
	}

	public void setDivtId(Integer divtId) {
		this.divtId = divtId;
	}

	@Column(name="ric_name")
	private String ricName;

	@Column(name="rev_code")
	private Integer revCode;
	
	@Column(name="tah_name")
	private String tahName;
	
	@Column(name="tah_code")
	private Integer tahCode;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_tehsil")
	private TehsilMaster tehsilMaster;
	
	
	@Column(name="dist_name")
	private String distName;
	
	@Column(name="dist_code")
	private Integer distCode;
	
	@Column(name="dist_id")
	private Integer distId;
	
	@Column(name="div_id")
	private Integer divtId;
	
	

}
