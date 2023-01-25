package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the tehsil_master database table.
 * 
 */
@Entity
@Table(name="tehsil_master")
@NamedQuery(name="TehsilMaster.findAll", query="SELECT t FROM TehsilMaster t")
public class TehsilMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_tahasil_nm")
	private String chrvTahasilNm;

	//bi-directional many-to-one association to TehsilDivisionLinkMaster
	/*
	 * @OneToMany(mappedBy="tehsilMaster") private List<TehsilDivisionLinkMaster>
	 * tehsilDivisionLinkMasters;
	 */

	//bi-directional many-to-one association to DistrictMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_district")
	private DistrictMaster districtMaster;

	//bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_division")
	private DivisionMaster divisionMaster;

	//bi-directional many-to-one association to VectorMasterData
	/*
	 * @OneToMany(mappedBy="tehsilMaster") private List<VectorMasterData>
	 * vectorMasterData;
	 * 
	 * //bi-directional many-to-one association to VillageMaster
	 * 
	 * @OneToMany(mappedBy="tehsilMaster") private List<VillageMaster>
	 * villageMasters;
	 */

	public TehsilMaster() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvTahasilNm() {
		return this.chrvTahasilNm;
	}

	public void setChrvTahasilNm(String chrvTahasilNm) {
		this.chrvTahasilNm = chrvTahasilNm;
	}

	/*
	 * public List<TehsilDivisionLinkMaster> getTehsilDivisionLinkMasters() { return
	 * this.tehsilDivisionLinkMasters; }
	 * 
	 * public void setTehsilDivisionLinkMasters(List<TehsilDivisionLinkMaster>
	 * tehsilDivisionLinkMasters) { this.tehsilDivisionLinkMasters =
	 * tehsilDivisionLinkMasters; }
	 

	public TehsilDivisionLinkMaster addTehsilDivisionLinkMaster(TehsilDivisionLinkMaster tehsilDivisionLinkMaster) {
		getTehsilDivisionLinkMasters().add(tehsilDivisionLinkMaster);
		tehsilDivisionLinkMaster.setTehsilMaster(this);

		return tehsilDivisionLinkMaster;
	}

	public TehsilDivisionLinkMaster removeTehsilDivisionLinkMaster(TehsilDivisionLinkMaster tehsilDivisionLinkMaster) {
		getTehsilDivisionLinkMasters().remove(tehsilDivisionLinkMaster);
		tehsilDivisionLinkMaster.setTehsilMaster(null);

		return tehsilDivisionLinkMaster;
	}*/

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

	/*
	 * public List<VectorMasterData> getVectorMasterData() { return
	 * this.vectorMasterData; }
	 * 
	 * public void setVectorMasterData(List<VectorMasterData> vectorMasterData) {
	 * this.vectorMasterData = vectorMasterData; }
	 */

	/*
	 * public VectorMasterData addVectorMasterData(VectorMasterData
	 * vectorMasterData) { getVectorMasterData().add(vectorMasterData);
	 * vectorMasterData.setTehsilMaster(this);
	 * 
	 * return vectorMasterData; }
	 * 
	 * public VectorMasterData removeVectorMasterData(VectorMasterData
	 * vectorMasterData) { getVectorMasterData().remove(vectorMasterData);
	 * vectorMasterData.setTehsilMaster(null);
	 * 
	 * return vectorMasterData; }
	 * 
	 * public List<VillageMaster> getVillageMasters() { return this.villageMasters;
	 * }
	 * 
	 * public void setVillageMasters(List<VillageMaster> villageMasters) {
	 * this.villageMasters = villageMasters; }
	
	public VillageMaster addVillageMaster(VillageMaster villageMaster) {
		getVillageMasters().add(villageMaster);
		villageMaster.setTehsilMaster(this);

		return villageMaster;
	}

	public VillageMaster removeVillageMaster(VillageMaster villageMaster) {
		getVillageMasters().remove(villageMaster);
		villageMaster.setTehsilMaster(null);

		return villageMaster;
	} */


}