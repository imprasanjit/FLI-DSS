package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the circle_master database table.
 * 
 */
@Entity
@Table(name="circle_master")
@NamedQuery(name="CircleMaster.findAll", query="SELECT c FROM CircleMaster c")
public class CircleMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_circle")
	private String chrvCircle;

	@Column(name="chrv_consultant_nm")
	private String chrvConsultantNm;

	
	
	
	//bi-directional many-to-one association to DivisionMaster
	/*
	 * @OneToMany(mappedBy="circleMaster") private List<DivisionMaster>
	 * divisionMasters;
	 * 
	 * //bi-directional many-to-one association to NfbMaster
	 * 
	 * @OneToMany(mappedBy="circleMaster") private List<NfbMaster> nfbMasters;
	 * 
	 * //bi-directional many-to-one association to RangeMaster
	 * 
	 * @OneToMany(mappedBy="circleMaster") private List<RangeMaster> rangeMasters;
	 * 
	 * //bi-directional many-to-one association to RasterMasterData
	 * 
	 * @OneToMany(mappedBy="circleMaster") private List<RasterMasterData>
	 * rasterMasterData;
	 * 
	 * //bi-directional many-to-one association to VectorMasterData
	 * 
	 * @OneToMany(mappedBy="circleMaster") private List<VectorMasterData>
	 * vectorMasterData;
	 */

	public CircleMaster() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvCircle() {
		return this.chrvCircle;
	}

	public void setChrvCircle(String chrvCircle) {
		this.chrvCircle = chrvCircle;
	}

	public String getChrvConsultantNm() {
		return this.chrvConsultantNm;
	}

	public void setChrvConsultantNm(String chrvConsultantNm) {
		this.chrvConsultantNm = chrvConsultantNm;
	}

	/*
	 * public List<DivisionMaster> getDivisionMasters() { return
	 * this.divisionMasters; }
	 * 
	 * public void setDivisionMasters(List<DivisionMaster> divisionMasters) {
	 * this.divisionMasters = divisionMasters; }
	 * 
	 * public DivisionMaster addDivisionMaster(DivisionMaster divisionMaster) {
	 * getDivisionMasters().add(divisionMaster);
	 * divisionMaster.setCircleMaster(this);
	 * 
	 * return divisionMaster; }
	 * 
	 * public DivisionMaster removeDivisionMaster(DivisionMaster divisionMaster) {
	 * getDivisionMasters().remove(divisionMaster);
	 * divisionMaster.setCircleMaster(null);
	 * 
	 * return divisionMaster; }
	 * 
	 * public List<NfbMaster> getNfbMasters() { return this.nfbMasters; }
	 * 
	 * public void setNfbMasters(List<NfbMaster> nfbMasters) { this.nfbMasters =
	 * nfbMasters; }
	 * 
	 * public NfbMaster addNfbMaster(NfbMaster nfbMaster) {
	 * getNfbMasters().add(nfbMaster); nfbMaster.setCircleMaster(this);
	 * 
	 * return nfbMaster; }
	 * 
	 * public NfbMaster removeNfbMaster(NfbMaster nfbMaster) {
	 * getNfbMasters().remove(nfbMaster); nfbMaster.setCircleMaster(null);
	 * 
	 * return nfbMaster; }
	 * 
	 * public List<RangeMaster> getRangeMasters() { return this.rangeMasters; }
	 * 
	 * public void setRangeMasters(List<RangeMaster> rangeMasters) {
	 * this.rangeMasters = rangeMasters; }
	 * 
	 * public RangeMaster addRangeMaster(RangeMaster rangeMaster) {
	 * getRangeMasters().add(rangeMaster); rangeMaster.setCircleMaster(this);
	 * 
	 * return rangeMaster; }
	 * 
	 * public RangeMaster removeRangeMaster(RangeMaster rangeMaster) {
	 * getRangeMasters().remove(rangeMaster); rangeMaster.setCircleMaster(null);
	 * 
	 * return rangeMaster; }
	 * 
	 * public List<RasterMasterData> getRasterMasterData() { return
	 * this.rasterMasterData; }
	 * 
	 * public void setRasterMasterData(List<RasterMasterData> rasterMasterData) {
	 * this.rasterMasterData = rasterMasterData; }
	 * 
	 * public RasterMasterData addRasterMasterData(RasterMasterData
	 * rasterMasterData) { getRasterMasterData().add(rasterMasterData);
	 * rasterMasterData.setCircleMaster(this);
	 * 
	 * return rasterMasterData; }
	 * 
	 * public RasterMasterData removeRasterMasterData(RasterMasterData
	 * rasterMasterData) { getRasterMasterData().remove(rasterMasterData);
	 * rasterMasterData.setCircleMaster(null);
	 * 
	 * return rasterMasterData; }
	 * 
	 * public List<VectorMasterData> getVectorMasterData() { return
	 * this.vectorMasterData; }
	 * 
	 * public void setVectorMasterData(List<VectorMasterData> vectorMasterData) {
	 * this.vectorMasterData = vectorMasterData; }
	 * 
	 * public VectorMasterData addVectorMasterData(VectorMasterData
	 * vectorMasterData) { getVectorMasterData().add(vectorMasterData);
	 * vectorMasterData.setCircleMaster(this);
	 * 
	 * return vectorMasterData; }
	 * 
	 * public VectorMasterData removeVectorMasterData(VectorMasterData
	 * vectorMasterData) { getVectorMasterData().remove(vectorMasterData);
	 * vectorMasterData.setCircleMaster(null);
	 * 
	 * return vectorMasterData; }
	 */

}