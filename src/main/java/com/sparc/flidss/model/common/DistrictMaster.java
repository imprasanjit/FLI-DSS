package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the district_master database table.
 * 
 */
@Entity
@Table(name="district_master")
@NamedQuery(name="DistrictMaster.findAll", query="SELECT d FROM DistrictMaster d")
public class DistrictMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_district_nm")
	private String chrvDistrictNm;

	
	//bi-directional many-to-one association to DistrictDivisionLinkMaster
	/*
	 * @OneToMany(mappedBy="districtMaster") private
	 * List<DistrictDivisionLinkMaster> districtDivisionLinkMasters;
	 * 
	 * //bi-directional many-to-one association to VillageMaster
	 * 
	 * @OneToMany(mappedBy="districtMaster") private List<VillageMaster>
	 * villageMasters;
	 * 
	 * //bi-directional many-to-one association to TehsilDivisionLinkMaster
	 * 
	 * @OneToMany(mappedBy="districtMaster") private List<TehsilDivisionLinkMaster>
	 * tehsilDivisionLinkMasters;
	 * 
	 * //bi-directional many-to-one association to TehsilMaster
	 * 
	 * @OneToMany(mappedBy="districtMaster") private List<TehsilMaster>
	 * tehsilMasters;
	 */

	public DistrictMaster() {
		
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvDistrictNm() {
		return this.chrvDistrictNm;
	}

	public void setChrvDistrictNm(String chrvDistrictNm) {
		this.chrvDistrictNm = chrvDistrictNm;
	}
	

	/*
	 * public List<DistrictDivisionLinkMaster> getDistrictDivisionLinkMasters() {
	 * return this.districtDivisionLinkMasters; }
	 * 
	 * public void setDistrictDivisionLinkMasters(List<DistrictDivisionLinkMaster>
	 * districtDivisionLinkMasters) { this.districtDivisionLinkMasters =
	 * districtDivisionLinkMasters; }
	 * 
	 * public DistrictDivisionLinkMaster
	 * addDistrictDivisionLinkMaster(DistrictDivisionLinkMaster
	 * districtDivisionLinkMaster) {
	 * getDistrictDivisionLinkMasters().add(districtDivisionLinkMaster);
	 * districtDivisionLinkMaster.setDistrictMaster(this);
	 * 
	 * return districtDivisionLinkMaster; }
	 * 
	 * public DistrictDivisionLinkMaster
	 * removeDistrictDivisionLinkMaster(DistrictDivisionLinkMaster
	 * districtDivisionLinkMaster) {
	 * getDistrictDivisionLinkMasters().remove(districtDivisionLinkMaster);
	 * districtDivisionLinkMaster.setDistrictMaster(null);
	 * 
	 * return districtDivisionLinkMaster; }
	 * 
	 * public List<VillageMaster> getVillageMasters() { return this.villageMasters;
	 * }
	 * 
	 * public void setVillageMasters(List<VillageMaster> villageMasters) {
	 * this.villageMasters = villageMasters; }
	 * 
	 * public VillageMaster addVillageMaster(VillageMaster villageMaster) {
	 * getVillageMasters().add(villageMaster);
	 * villageMaster.setDistrictMaster(this);
	 * 
	 * return villageMaster; }
	 * 
	 * public VillageMaster removeVillageMaster(VillageMaster villageMaster) {
	 * getVillageMasters().remove(villageMaster);
	 * villageMaster.setDistrictMaster(null);
	 * 
	 * return villageMaster; }
	 * 
	 * public List<TehsilDivisionLinkMaster> getTehsilDivisionLinkMasters() { return
	 * this.tehsilDivisionLinkMasters; }
	 * 
	 * public void setTehsilDivisionLinkMasters(List<TehsilDivisionLinkMaster>
	 * tehsilDivisionLinkMasters) { this.tehsilDivisionLinkMasters =
	 * tehsilDivisionLinkMasters; }
	 * 
	 * public TehsilDivisionLinkMaster
	 * addTehsilDivisionLinkMaster(TehsilDivisionLinkMaster
	 * tehsilDivisionLinkMaster) {
	 * getTehsilDivisionLinkMasters().add(tehsilDivisionLinkMaster);
	 * tehsilDivisionLinkMaster.setDistrictMaster(this);
	 * 
	 * return tehsilDivisionLinkMaster; }
	 * 
	 * public TehsilDivisionLinkMaster
	 * removeTehsilDivisionLinkMaster(TehsilDivisionLinkMaster
	 * tehsilDivisionLinkMaster) {
	 * getTehsilDivisionLinkMasters().remove(tehsilDivisionLinkMaster);
	 * tehsilDivisionLinkMaster.setDistrictMaster(null);
	 * 
	 * return tehsilDivisionLinkMaster; }
	 * 
	 * public List<TehsilMaster> getTehsilMasters() { return this.tehsilMasters; }
	 * 
	 * public void setTehsilMasters(List<TehsilMaster> tehsilMasters) {
	 * this.tehsilMasters = tehsilMasters; }
	 * 
	 * public TehsilMaster addTehsilMaster(TehsilMaster tehsilMaster) {
	 * getTehsilMasters().add(tehsilMaster); tehsilMaster.setDistrictMaster(this);
	 * 
	 * return tehsilMaster; }
	 * 
	 * public TehsilMaster removeTehsilMaster(TehsilMaster tehsilMaster) {
	 * getTehsilMasters().remove(tehsilMaster);
	 * tehsilMaster.setDistrictMaster(null);
	 * 
	 * return tehsilMaster; }
	 */

}