package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the tehsil_division_link_master database table.
 * 
 */
@Entity
@Table(name="tehsil_division_link_master")
@NamedQuery(name="TehsilDivisionLinkMaster.findAll", query="SELECT t FROM TehsilDivisionLinkMaster t")
public class TehsilDivisionLinkMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	private String district;

	private String division;

	private String tahasil;

	//bi-directional many-to-one association to DistrictMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_district")
	private DistrictMaster districtMaster;

	//bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_division")
	private DivisionMaster divisionMaster;

	//bi-directional many-to-one association to SchemaMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_schema")
	private SchemaMaster schemaMaster;

	//bi-directional many-to-one association to TehsilMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_tehsil")
	private TehsilMaster tehsilMaster;

	public TehsilDivisionLinkMaster() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getDistrict() {
		return this.district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getDivision() {
		return this.division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getTahasil() {
		return this.tahasil;
	}

	public void setTahasil(String tahasil) {
		this.tahasil = tahasil;
	}

	public DistrictMaster getDistrictMaster() {
		return this.districtMaster;
	}

	public void setDistrictMaster(DistrictMaster districtMaster) {
		this.districtMaster = districtMaster;
	}

	public DivisionMaster getDivisionMaster() {
		return this.divisionMaster;
	}

	public void setDivisionMaster(DivisionMaster divisionMaster) {
		this.divisionMaster = divisionMaster;
	}

	public SchemaMaster getSchemaMaster() {
		return this.schemaMaster;
	}

	public void setSchemaMaster(SchemaMaster schemaMaster) {
		this.schemaMaster = schemaMaster;
	}

	public TehsilMaster getTehsilMaster() {
		return this.tehsilMaster;
	}

	public void setTehsilMaster(TehsilMaster tehsilMaster) {
		this.tehsilMaster = tehsilMaster;
	}

}