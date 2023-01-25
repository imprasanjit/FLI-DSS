package com.sparc.flidss.viewmodel.progressmonitoring;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import org.hibernate.annotations.Immutable;

@Entity(name = "recoded_forest_ca_land")
public class DRFLsummary {
	@Id
	@Column(name = "Int_id")
	Integer IntId;
	
	@Column(name = "div_id")
	Integer divid;
	
	@Column(name="range_id")
	Integer rangeid;
	
	@Column(name="tah_id")
	Integer tahid;
	
	@Column(name="vill_code")
	String villcode;
	
	@Column(name = "dist_name")
	String distname;
	
	@Column(name = "div_name")
	String divname;
	
	@Column(name = "range_name")
	String rangename;
	
	@Column(name="tahasil")
	String tahasil;
	
	@Column(name="ric")
	String ric;
	
	@Column(name="area_ac")
	Double areaAc;

	public Integer getIntId() {
		return IntId;
	}

	public void setIntId(Integer intId) {
		IntId = intId;
	}

	public Integer getDivid() {
		return divid;
	}

	public void setDivid(Integer divid) {
		this.divid = divid;
	}

	public Integer getRangeid() {
		return rangeid;
	}

	public void setRangeid(Integer rangeid) {
		this.rangeid = rangeid;
	}

	public Integer getTahid() {
		return tahid;
	}

	public void setTahid(Integer tahid) {
		this.tahid = tahid;
	}

	public String getVillcode() {
		return villcode;
	}

	public void setVillcode(String villcode) {
		this.villcode = villcode;
	}

	public String getDistname() {
		return distname;
	}

	public void setDistname(String distname) {
		this.distname = distname;
	}

	public String getDivname() {
		return divname;
	}

	public void setDivname(String divname) {
		this.divname = divname;
	}

	public String getRangename() {
		return rangename;
	}

	public void setRangename(String rangename) {
		this.rangename = rangename;
	}

	public String getTahasil() {
		return tahasil;
	}

	public void setTahasil(String tahasil) {
		this.tahasil = tahasil;
	}

	public String getRic() {
		return ric;
	}

	public void setRic(String ric) {
		this.ric = ric;
	}

	public Double getAreaAc() {
		return areaAc;
	}

	public void setAreaAc(Double areaAc) {
		this.areaAc = areaAc;
	}
	
	
	
}
