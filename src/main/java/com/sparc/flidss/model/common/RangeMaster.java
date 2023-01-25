package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;



/**
 * The persistent class for the range_master database table.
 * 
 */
@Entity
@Table(name="range_master")
@NamedQuery(name="RangeMaster.findAll", query="SELECT r FROM RangeMaster r")
public class RangeMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="chrv_range_cd")
	private String chrvRangeCd;

	@Column(name="chrv_frjvc_filepath")
	private String chrvFrjvcFilepath;

	@Column(name="chrv_range_nm")
	private String chrvRangeNm;

	@Column(name="int_id")
	private Integer intId;

	@Column(name="int_total_fbs")
	private Integer intTotalFbs;

	//bi-directional many-to-one association to NfbMaster
	/*
	 * @OneToMany(mappedBy="rangeMaster") private List<NfbMaster> nfbMasters;
	 */

	//bi-directional many-to-one association to CircleMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_circle")
	private CircleMaster circleMaster;

	//bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_division")
	private DivisionMaster divisionMaster;

	//bi-directional many-to-one association to PhaseMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_phase")
	private PhaseMaster phaseMaster;

	//bi-directional many-to-one association to RasterMasterData
	/*
	 * @OneToMany(mappedBy="rangeMaster") private List<RasterMasterData>
	 * rasterMasterData;
	 * 
	 * //bi-directional many-to-one association to VectorMasterData
	 * 
	 * @OneToMany(mappedBy="rangeMaster") private List<VectorMasterData>
	 * vectorMasterData;
	 * 
	 * //bi-directional many-to-one association to VillageMaster
	 * 
	 * @OneToMany(mappedBy="rangeMaster") private List<VillageMaster>
	 * villageMasters;
	 */

	public RangeMaster() {
	}

	public String getChrvRangeCd() {
		return this.chrvRangeCd;
	}

	public void setChrvRangeCd(String chrvRangeCd) {
		this.chrvRangeCd = chrvRangeCd;
	}

	public String getChrvFrjvcFilepath() {
		return this.chrvFrjvcFilepath;
	}

	public void setChrvFrjvcFilepath(String chrvFrjvcFilepath) {
		this.chrvFrjvcFilepath = chrvFrjvcFilepath;
	}

	public String getChrvRangeNm() {
		return this.chrvRangeNm;
	}

	public void setChrvRangeNm(String chrvRangeNm) {
		this.chrvRangeNm = chrvRangeNm;
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public Integer getIntTotalFbs() {
		return this.intTotalFbs;
	}

	public void setIntTotalFbs(Integer intTotalFbs) {
		this.intTotalFbs = intTotalFbs;
	}

	/*
	 * public List<NfbMaster> getNfbMasters() { return this.nfbMasters; }
	 * 
	 * public void setNfbMasters(List<NfbMaster> nfbMasters) { this.nfbMasters =
	 * nfbMasters; }
	 * 
	 * public NfbMaster addNfbMaster(NfbMaster nfbMaster) {
	 * getNfbMasters().add(nfbMaster); nfbMaster.setRangeMaster(this);
	 * 
	 * return nfbMaster; }
	 * 
	 * public NfbMaster removeNfbMaster(NfbMaster nfbMaster) {
	 * getNfbMasters().remove(nfbMaster); nfbMaster.setRangeMaster(null);
	 * 
	 * return nfbMaster; }
	 */

	public CircleMaster getCircleMaster() {
		return this.circleMaster;
	}

	public void setCircleMaster(CircleMaster circleMaster) {
		this.circleMaster = circleMaster;
	}

	public DivisionMaster getDivisionMaster() {
		return this.divisionMaster;
	}

	public void setDivisionMaster(DivisionMaster divisionMaster) {
		this.divisionMaster = divisionMaster;
	}

	public PhaseMaster getPhaseMaster() {
		return this.phaseMaster;
	}

	public void setPhaseMaster(PhaseMaster phaseMaster) {
		this.phaseMaster = phaseMaster;
	}
	/*
	 * public List<RasterMasterData> getRasterMasterData() { return
	 * this.rasterMasterData; }
	 * 
	 * public void setRasterMasterData(List<RasterMasterData> rasterMasterData) {
	 * this.rasterMasterData = rasterMasterData; }
	 * 
	 * public RasterMasterData addRasterMasterData(RasterMasterData
	 * rasterMasterData) { getRasterMasterData().add(rasterMasterData);
	 * rasterMasterData.setRangeMaster(this);
	 * 
	 * return rasterMasterData; }
	 * 
	 * public RasterMasterData removeRasterMasterData(RasterMasterData
	 * rasterMasterData) { getRasterMasterData().remove(rasterMasterData);
	 * rasterMasterData.setRangeMaster(null);
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
	 * vectorMasterData.setRangeMaster(this);
	 * 
	 * return vectorMasterData; }
	 * 
	 * public VectorMasterData removeVectorMasterData(VectorMasterData
	 * vectorMasterData) { getVectorMasterData().remove(vectorMasterData);
	 * vectorMasterData.setRangeMaster(null);
	 * 
	 * return vectorMasterData; }
	 * 
	 * public List<VillageMaster> getVillageMasters() { return this.villageMasters;
	 * }
	 * 
	 * public void setVillageMasters(List<VillageMaster> villageMasters) {
	 * this.villageMasters = villageMasters; }
	 * 
	 * public VillageMaster addVillageMaster(VillageMaster villageMaster) {
	 * getVillageMasters().add(villageMaster); villageMaster.setRangeMaster(this);
	 * 
	 * return villageMaster; }
	 * 
	 * public VillageMaster removeVillageMaster(VillageMaster villageMaster) {
	 * getVillageMasters().remove(villageMaster);
	 * villageMaster.setRangeMaster(null);
	 * 
	 * return villageMaster; }
	 */

	public RangeMaster getRangeMaster() {
		// TODO Auto-generated method stub
		return null;
	}



}