package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the schema_master database table.
 * 
 */
@Entity
@Table(name="schema_master")
@NamedQuery(name="SchemaMaster.findAll", query="SELECT s FROM SchemaMaster s")
public class SchemaMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_name")
	private String chrvName;

	//bi-directional many-to-one association to DistrictDivisionLinkMaster
	@OneToMany(mappedBy="schemaMaster")
	private List<DistrictDivisionLinkMaster> districtDivisionLinkMasters;

	//bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_division")
	private DivisionMaster divisionMaster;

	//bi-directional many-to-one association to VectorMasterData
	@OneToMany(mappedBy="schemaMaster")
	private List<VectorMasterData> vectorMasterData;

	//bi-directional many-to-one association to TehsilDivisionLinkMaster
	@OneToMany(mappedBy="schemaMaster")
	private List<TehsilDivisionLinkMaster> tehsilDivisionLinkMasters;

	public SchemaMaster() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvName() {
		return this.chrvName;
	}

	public void setChrvName(String chrvName) {
		this.chrvName = chrvName;
	}

	public List<DistrictDivisionLinkMaster> getDistrictDivisionLinkMasters() {
		return this.districtDivisionLinkMasters;
	}

	public void setDistrictDivisionLinkMasters(List<DistrictDivisionLinkMaster> districtDivisionLinkMasters) {
		this.districtDivisionLinkMasters = districtDivisionLinkMasters;
	}

	public DistrictDivisionLinkMaster addDistrictDivisionLinkMaster(DistrictDivisionLinkMaster districtDivisionLinkMaster) {
		getDistrictDivisionLinkMasters().add(districtDivisionLinkMaster);
		districtDivisionLinkMaster.setSchemaMaster(this);

		return districtDivisionLinkMaster;
	}

	public DistrictDivisionLinkMaster removeDistrictDivisionLinkMaster(DistrictDivisionLinkMaster districtDivisionLinkMaster) {
		getDistrictDivisionLinkMasters().remove(districtDivisionLinkMaster);
		districtDivisionLinkMaster.setSchemaMaster(null);

		return districtDivisionLinkMaster;
	}

	public DivisionMaster getDivisionMaster() {
		return this.divisionMaster;
	}

	public void setDivisionMaster(DivisionMaster divisionMaster) {
		this.divisionMaster = divisionMaster;
	}

	public List<VectorMasterData> getVectorMasterData() {
		return this.vectorMasterData;
	}

	public void setVectorMasterData(List<VectorMasterData> vectorMasterData) {
		this.vectorMasterData = vectorMasterData;
	}

	public VectorMasterData addVectorMasterData(VectorMasterData vectorMasterData) {
		getVectorMasterData().add(vectorMasterData);
		vectorMasterData.setSchemaMaster(this);

		return vectorMasterData;
	}

	public VectorMasterData removeVectorMasterData(VectorMasterData vectorMasterData) {
		getVectorMasterData().remove(vectorMasterData);
		vectorMasterData.setSchemaMaster(null);

		return vectorMasterData;
	}

	public List<TehsilDivisionLinkMaster> getTehsilDivisionLinkMasters() {
		return this.tehsilDivisionLinkMasters;
	}

	public void setTehsilDivisionLinkMasters(List<TehsilDivisionLinkMaster> tehsilDivisionLinkMasters) {
		this.tehsilDivisionLinkMasters = tehsilDivisionLinkMasters;
	}

	public TehsilDivisionLinkMaster addTehsilDivisionLinkMaster(TehsilDivisionLinkMaster tehsilDivisionLinkMaster) {
		getTehsilDivisionLinkMasters().add(tehsilDivisionLinkMaster);
		tehsilDivisionLinkMaster.setSchemaMaster(this);

		return tehsilDivisionLinkMaster;
	}

	public TehsilDivisionLinkMaster removeTehsilDivisionLinkMaster(TehsilDivisionLinkMaster tehsilDivisionLinkMaster) {
		getTehsilDivisionLinkMasters().remove(tehsilDivisionLinkMaster);
		tehsilDivisionLinkMaster.setSchemaMaster(null);

		return tehsilDivisionLinkMaster;
	}

}