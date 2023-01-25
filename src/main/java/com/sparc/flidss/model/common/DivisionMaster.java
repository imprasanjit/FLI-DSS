package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the division_master database table.
 * 
 */
@Entity
@Table(name="division_master")
@NamedQuery(name="DivisionMaster.findAll", query="SELECT d FROM DivisionMaster d")
public class DivisionMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_division_nm")
	private String chrvDivisionNm;

	@Column(name="chrv_division_code")
	private String chrvDivisionCode;
	
	@Column(name="int_srid")
	private Integer intSrid;
	
	@Column(name="dec_nfb_area_skm")
	private Double decNfbAreaSkm;
	
	@Column(name="dec_no_of_fbs")
	private Integer decNoOfFbs;
	
	@Column(name="dec_revenue_land")
	private Double decRevenueLand;
	
	@Column(name="dec_deemedforest_area_skm")
	private Double decDeemedforestAreaSkm;
	
	/*
	 * //bi-directional many-to-one association to DistrictDivisionLinkMaster
	 * 
	 * @OneToMany(mappedBy="divisionMaster") private
	 * List<DistrictDivisionLinkMaster> districtDivisionLinkMasters;
	 */
	//bi-directional many-to-one association to CircleMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_circle")
	private CircleMaster circleMaster;

	public Integer getIntSrid() {
		return intSrid;
	}

	public void setIntSrid(Integer intSrid) {
		this.intSrid = intSrid;
	}

	public Double getDecNfbAreaSkm() {
		return decNfbAreaSkm;
	}

	public void setDecNfbAreaSkm(Double decNfbAreaSkm) {
		this.decNfbAreaSkm = decNfbAreaSkm;
	}

	public Integer getDecNoOfFbs() {
		return decNoOfFbs;
	}

	public void setDecNoOfFbs(Integer decNoOfFbs) {
		this.decNoOfFbs = decNoOfFbs;
	}

	public Double getDecRevenueLand() {
		return decRevenueLand;
	}

	public void setDecRevenueLand(Double decRevenueLand) {
		this.decRevenueLand = decRevenueLand;
	}

	public Double getDecDeemedforestAreaSkm() {
		return decDeemedforestAreaSkm;
	}

	public void setDecDeemedforestAreaSkm(Double decDeemedforestAreaSkm) {
		this.decDeemedforestAreaSkm = decDeemedforestAreaSkm;
	}



	//bi-directional many-to-one association to PhaseMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_dec_phase")
	private PhaseMaster phaseMaster;

	/*
	 * //bi-directional many-to-one association to NfbMaster
	 * 
	 * @OneToMany(mappedBy="divisionMaster") private List<NfbMaster> nfbMasters;
	 * 
	 * //bi-directional many-to-one association to RangeMaster
	 * 
	 * @OneToMany(mappedBy="divisionMaster") private List<RangeMaster> rangeMasters;
	 * 
	 * //bi-directional many-to-one association to RasterMasterData
	 * 
	 * @OneToMany(mappedBy="divisionMaster") private List<RasterMasterData>
	 * rasterMasterData;
	 * 
	 * //bi-directional many-to-one association to SchemaMaster
	 * 
	 * @OneToMany(mappedBy="divisionMaster") private List<SchemaMaster>
	 * schemaMasters;
	 * 
	 * //bi-directional many-to-one association to VectorMasterData
	 * 
	 * @OneToMany(mappedBy="divisionMaster") private List<VectorMasterData>
	 * vectorMasterData;
	 * 
	 * //bi-directional many-to-one association to VillageMaster
	 * 
	 * @OneToMany(mappedBy="divisionMaster") private List<VillageMaster>
	 * villageMasters;
	 * 
	 * //bi-directional many-to-one association to DataCatalogueMaster
	 * 
	 * @OneToMany(mappedBy="divisionMaster") private List<DataCatalogueMaster>
	 * dataCatalogueMasters;
	 * 
	 * //bi-directional many-to-one association to TehsilDivisionLinkMaster
	 * 
	 * @OneToMany(mappedBy="divisionMaster") private List<TehsilDivisionLinkMaster>
	 * tehsilDivisionLinkMasters;
	 * 
	 * //bi-directional many-to-one association to TehsilMaster
	 * 
	 * @OneToMany(mappedBy="divisionMaster") private List<TehsilMaster>
	 * tehsilMasters;
	 * 
	 */	public DivisionMaster() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvDivisionNm() {
		return this.chrvDivisionNm;
	}

	public void setChrvDivisionNm(String chrvDivisionNm) {
		this.chrvDivisionNm = chrvDivisionNm;
	}

	
	public String getChrvDivisionCode() {
		return chrvDivisionCode;
	}

	public void setChrvDivisionCode(String chrvDivisionCode) {
		this.chrvDivisionCode = chrvDivisionCode;
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
	 * districtDivisionLinkMaster.setDivisionMaster(this);
	 * 
	 * return districtDivisionLinkMaster; }
	 * 
	 * public DistrictDivisionLinkMaster
	 * removeDistrictDivisionLinkMaster(DistrictDivisionLinkMaster
	 * districtDivisionLinkMaster) {
	 * getDistrictDivisionLinkMasters().remove(districtDivisionLinkMaster);
	 * districtDivisionLinkMaster.setDivisionMaster(null);
	 * 
	 * return districtDivisionLinkMaster; }
	 */
	public CircleMaster getCircleMaster() {
		return this.circleMaster;
	}

	public void setCircleMaster(CircleMaster circleMaster) {
		this.circleMaster = circleMaster;
	}

	public PhaseMaster getPhaseMaster() {
		return this.phaseMaster;
	}

	public void setPhaseMaster(PhaseMaster phaseMaster) {
		this.phaseMaster = phaseMaster;
	}

	/*
	 * public List<NfbMaster> getNfbMasters() { return this.nfbMasters; }
	 * 
	 * public void setNfbMasters(List<NfbMaster> nfbMasters) { this.nfbMasters =
	 * nfbMasters; }
	 * 
	 * public NfbMaster addNfbMaster(NfbMaster nfbMaster) {
	 * getNfbMasters().add(nfbMaster); nfbMaster.setDivisionMaster(this);
	 * 
	 * return nfbMaster; }
	 * 
	 * public NfbMaster removeNfbMaster(NfbMaster nfbMaster) {
	 * getNfbMasters().remove(nfbMaster); nfbMaster.setDivisionMaster(null);
	 * 
	 * return nfbMaster; }
	 * 
	 * public List<RangeMaster> getRangeMasters() { return this.rangeMasters; }
	 * 
	 * public void setRangeMasters(List<RangeMaster> rangeMasters) {
	 * this.rangeMasters = rangeMasters; }
	 * 
	 * public RangeMaster addRangeMaster(RangeMaster rangeMaster) {
	 * getRangeMasters().add(rangeMaster); rangeMaster.setDivisionMaster(this);
	 * 
	 * return rangeMaster; }
	 * 
	 * public RangeMaster removeRangeMaster(RangeMaster rangeMaster) {
	 * getRangeMasters().remove(rangeMaster); rangeMaster.setDivisionMaster(null);
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
	 * rasterMasterData.setDivisionMaster(this);
	 * 
	 * return rasterMasterData; }
	 * 
	 * public RasterMasterData removeRasterMasterData(RasterMasterData
	 * rasterMasterData) { getRasterMasterData().remove(rasterMasterData);
	 * rasterMasterData.setDivisionMaster(null);
	 * 
	 * return rasterMasterData; }
	 * 
	 * public List<SchemaMaster> getSchemaMasters() { return this.schemaMasters; }
	 * 
	 * public void setSchemaMasters(List<SchemaMaster> schemaMasters) {
	 * this.schemaMasters = schemaMasters; }
	 * 
	 * public SchemaMaster addSchemaMaster(SchemaMaster schemaMaster) {
	 * getSchemaMasters().add(schemaMaster); schemaMaster.setDivisionMaster(this);
	 * 
	 * return schemaMaster; }
	 * 
	 * public SchemaMaster removeSchemaMaster(SchemaMaster schemaMaster) {
	 * getSchemaMasters().remove(schemaMaster);
	 * schemaMaster.setDivisionMaster(null);
	 * 
	 * return schemaMaster; }
	 * 
	 * public List<VectorMasterData> getVectorMasterData() { return
	 * this.vectorMasterData; }
	 * 
	 * public void setVectorMasterData(List<VectorMasterData> vectorMasterData) {
	 * this.vectorMasterData = vectorMasterData; }
	 * 
	 * public VectorMasterData addVectorMasterData(VectorMasterData
	 * vectorMasterData) { getVectorMasterData().add(vectorMasterData);
	 * vectorMasterData.setDivisionMaster(this);
	 * 
	 * return vectorMasterData; }
	 * 
	 * public VectorMasterData removeVectorMasterData(VectorMasterData
	 * vectorMasterData) { getVectorMasterData().remove(vectorMasterData);
	 * vectorMasterData.setDivisionMaster(null);
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
	 * getVillageMasters().add(villageMaster);
	 * villageMaster.setDivisionMaster(this);
	 * 
	 * return villageMaster; }
	 * 
	 * public VillageMaster removeVillageMaster(VillageMaster villageMaster) {
	 * getVillageMasters().remove(villageMaster);
	 * villageMaster.setDivisionMaster(null);
	 * 
	 * return villageMaster; }
	 * 
	 * public List<DataCatalogueMaster> getDataCatalogueMasters() { return
	 * this.dataCatalogueMasters; }
	 * 
	 * public void setDataCatalogueMasters(List<DataCatalogueMaster>
	 * dataCatalogueMasters) { this.dataCatalogueMasters = dataCatalogueMasters; }
	 * 
	 * public DataCatalogueMaster addDataCatalogueMaster(DataCatalogueMaster
	 * dataCatalogueMaster) { getDataCatalogueMasters().add(dataCatalogueMaster);
	 * dataCatalogueMaster.setDivisionMaster(this);
	 * 
	 * return dataCatalogueMaster; }
	 * 
	 * public DataCatalogueMaster removeDataCatalogueMaster(DataCatalogueMaster
	 * dataCatalogueMaster) { getDataCatalogueMasters().remove(dataCatalogueMaster);
	 * dataCatalogueMaster.setDivisionMaster(null);
	 * 
	 * return dataCatalogueMaster; }
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
	 * tehsilDivisionLinkMaster.setDivisionMaster(this);
	 * 
	 * return tehsilDivisionLinkMaster; }
	 * 
	 * public TehsilDivisionLinkMaster
	 * removeTehsilDivisionLinkMaster(TehsilDivisionLinkMaster
	 * tehsilDivisionLinkMaster) {
	 * getTehsilDivisionLinkMasters().remove(tehsilDivisionLinkMaster);
	 * tehsilDivisionLinkMaster.setDivisionMaster(null);
	 * 
	 * return tehsilDivisionLinkMaster; }
	 * 
	 * public List<TehsilMaster> getTehsilMasters() { return this.tehsilMasters; }
	 * 
	 * public void setTehsilMasters(List<TehsilMaster> tehsilMasters) {
	 * this.tehsilMasters = tehsilMasters; }
	 * 
	 * public TehsilMaster addTehsilMaster(TehsilMaster tehsilMaster) {
	 * getTehsilMasters().add(tehsilMaster); tehsilMaster.setDivisionMaster(this);
	 * 
	 * return tehsilMaster; }
	 * 
	 * public TehsilMaster removeTehsilMaster(TehsilMaster tehsilMaster) {
	 * getTehsilMasters().remove(tehsilMaster);
	 * tehsilMaster.setDivisionMaster(null);
	 * 
	 * return tehsilMaster; }
	 */
}