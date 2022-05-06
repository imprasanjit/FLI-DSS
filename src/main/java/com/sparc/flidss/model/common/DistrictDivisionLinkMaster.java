package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the district_division_link_master database table.
 * 
 */
@Entity
@Table(name="district_division_link_master")
@NamedQuery(name="DistrictDivisionLinkMaster.findAll", query="SELECT d FROM DistrictDivisionLinkMaster d")
public class DistrictDivisionLinkMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	private String district;

	private String division;

	//bi-directional many-to-one association to DistrictMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_district")
	private DistrictMaster districtMaster;

	//bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="int_fk_division")
	private DivisionMaster divisionMaster;

	//bi-directional many-to-one association to SchemaMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_schema")
	private SchemaMaster schemaMaster;

	public DistrictDivisionLinkMaster() {
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

}