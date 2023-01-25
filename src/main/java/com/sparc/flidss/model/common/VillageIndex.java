package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the village_index database table.
 * 
 */
@Entity
@Table(name="village_index")
@NamedQuery(name="VillageIndex.findAll", query="SELECT v FROM VillageIndex v")
public class VillageIndex implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer gid;

	@Column(name="dist_name")
	private String distName;

	private String division;

	private Long geom;

	private String ps;

	@Column(name="publ_year")
	private Integer publYear;

	private String range;

	private String ric;

	private String tahasil;

	@Column(name="thana_no")
	private String thanaNo;

	@Column(name="vill_code")
	private String villCode;

	@Column(name="vill_name")
	private String villName;

	public VillageIndex() {
	}

	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	public String getDistName() {
		return this.distName;
	}

	public void setDistName(String distName) {
		this.distName = distName;
	}

	public String getDivision() {
		return this.division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public Long getGeom() {
		return this.geom;
	}

	public void setGeom(Long geom) {
		this.geom = geom;
	}

	public String getPs() {
		return this.ps;
	}

	public void setPs(String ps) {
		this.ps = ps;
	}

	public Integer getPublYear() {
		return this.publYear;
	}

	public void setPublYear(Integer publYear) {
		this.publYear = publYear;
	}

	public String getRange() {
		return this.range;
	}

	public void setRange(String range) {
		this.range = range;
	}

	public String getRic() {
		return this.ric;
	}

	public void setRic(String ric) {
		this.ric = ric;
	}

	public String getTahasil() {
		return this.tahasil;
	}

	public void setTahasil(String tahasil) {
		this.tahasil = tahasil;
	}

	public String getThanaNo() {
		return this.thanaNo;
	}

	public void setThanaNo(String thanaNo) {
		this.thanaNo = thanaNo;
	}

	public String getVillCode() {
		return this.villCode;
	}

	public void setVillCode(String villCode) {
		this.villCode = villCode;
	}

	public String getVillName() {
		return this.villName;
	}

	public void setVillName(String villName) {
		this.villName = villName;
	}

}