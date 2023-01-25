package com.sparc.flidss.model.common;

import java.io.Serializable;
import java.math.BigInteger;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "rev_forest_master")
@NamedQuery(name = "RevnueForestMaster.findAll", query = "select n from RevnueForestMaster n")
public class RevnueForestMaster implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name = "gid")
	private Integer gId;

	@Column(name = "int_id")
	private BigInteger IntId;

	@Column(name = "vill_code")
	private String VillCode;

	@Column(name = "chrv_district_nm")
	private String ChrvDistrictNm;

	@Column(name = "chrv_division_nm")
	private String ChrvDivisionNm;

	@Column(name = "chrv_range_nm")
	private String ChrvRangeNm;

	@Column(name = "chrv_tahasil_nm")
	private String ChrvTahasilNm;

	@Column(name = "ric")
	private String Ric;

	@Column(name = "ps")
	private String Ps;

	@Column(name = "thana_no")
	private String ThanaNo;

	@Column(name = "village")
	private String Village;

	@Column(name = "publ_year")
	private Integer PublYear;

	@Column(name = "khata_no")
	private String KhataNo;

	@Column(name = "plot_no")
	private String PlotNo;

	@Column(name = "rplot_no")
	private String RPlotNo;

	@Column(name = "area_ac")
	private Double AreaAc;

	@Column(name = "plot_code")
	private String PlotCode;

	@Column(name = "kissam")
	private String Kissam;

	@Column(name = "ror_class")
	private String RorClass;

	@Column(name = "land_class")
	private String landClass;

	@Column(name = "dlc")
	private String Dlc;

	@Column(name = "fed_land")
	private String FedLand;

	@Column(name = "carea_ac")
	private Double CAreaAc;

	@Column(name = "variation")
	private String Variation;

	// bi-directional many-to-one association to DivisionMaster

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_division")
	private DivisionMaster divisionMaster;

	// bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_district")
	private DistrictMaster districtMaster;

	// bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "chrv_range_cd")
	private RangeMaster rangeMaster;

	// bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_tehsil")
	private TehsilMaster tehsilMaster;

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public BigInteger getIntId() {
		return IntId;
	}

	public void setIntId(BigInteger intId) {
		this.IntId = intId;
	}

	public String getVillCode() {
		return VillCode;
	}

	public void setVillCode(String villCode) {
		this.VillCode = villCode;
	}

	public String getChrvDistrictNm() {
		return ChrvDistrictNm;
	}

	public void setChrvDistrictNm(String chrvDistrictNm) {
		this.ChrvDistrictNm = chrvDistrictNm;
	}

	public String getChrvDivisionNm() {
		return ChrvDivisionNm;
	}

	public void setChrvDivisionNm(String chrvDivisionNm) {
		this.ChrvDivisionNm = chrvDivisionNm;
	}

	public String getChrvRangeNm() {
		return ChrvRangeNm;
	}

	public void setChrvRangeNm(String chrvRangeNm) {
		this.ChrvRangeNm = chrvRangeNm;
	}

	public String getChrvTahasilNm() {
		return ChrvTahasilNm;
	}

	public void setChrvTahasilNm(String chrvTahasilNm) {
		this.ChrvTahasilNm = chrvTahasilNm;
	}

	public String getRic() {
		return Ric;
	}

	public void setRic(String ric) {
		this.Ric = ric;
	}

	public String getPs() {
		return Ps;
	}

	public void setPs(String ps) {
		this.Ps = ps;
	}

	public String getThanaNo() {
		return ThanaNo;
	}

	public void setThanaNo(String thanaNo) {
		this.ThanaNo = thanaNo;
	}

	public String getVillage() {
		return Village;
	}

	public void setVillage(String village) {
		this.Village = village;
	}

	public Integer getPublYear() {
		return PublYear;
	}

	public void setPublYear(Integer publYear) {
		this.PublYear = publYear;
	}

	public String getKhataNo() {
		return KhataNo;
	}

	public void setKhataNo(String khataNo) {
		this.KhataNo = khataNo;
	}

	public String getPlotNo() {
		return PlotNo;
	}

	public void setPlotNo(String plotNo) {
		this.PlotNo = plotNo;
	}

	public String getRPlotNo() {
		return RPlotNo;
	}

	public void setRPlotNo(String rPlotNo) {
		this.RPlotNo = rPlotNo;
	}

	public Double getAreaAc() {
		return AreaAc;
	}

	public void setAreaAc(Double areaAc) {
		this.AreaAc = areaAc;
	}

	public String getPlotCode() {
		return PlotCode;
	}

	public void setPlotCode(String plotCode) {
		this.PlotCode = plotCode;
	}

	public String getKissam() {
		return Kissam;
	}

	public void setKissam(String kissam) {
		this.Kissam = kissam;
	}

	public String getRorClass() {
		return RorClass;
	}

	public void setRorClass(String rorClass) {
		this.RorClass = rorClass;
	}

	public String getLandClass() {
		return this.landClass;
	}

	public void setLandClass(String landClass) {
		this.landClass = landClass;
	}

	public String getDlc() {
		return this.Dlc;
	}

	public void setDlc(String dlc) {
		this.Dlc = dlc;
	}

	public String getFedLand() {
		return this.FedLand;
	}

	public void setFedLand(String fedLand) {
		this.FedLand = fedLand;
	}

	public Double getCAreaAc() {
		return CAreaAc;
	}

	public void setCAreaAc(Double cAreaAc) {
		this.CAreaAc = cAreaAc;
	}

	public String getVariation() {
		return Variation;
	}

	public void setVariation(String variation) {
		this.Variation = variation;
	}

	public DivisionMaster getDivisionMaster() {
		return divisionMaster;
	}

	public void setDivisionMaster(DivisionMaster divisionMaster) {
		this.divisionMaster = divisionMaster;
	}

	public DistrictMaster getDistrictMaster() {
		return districtMaster;
	}

	public void setDistrictMaster(DistrictMaster districtMaster) {
		this.districtMaster = districtMaster;
	}

	public RangeMaster getRangeMaster() {
		return rangeMaster;
	}

	public void setRangeMaster(RangeMaster rangeMaster) {
		this.rangeMaster = rangeMaster;
	}

	public TehsilMaster getTehsilMaster() {
		return tehsilMaster;
	}

	public void setTehsilMaster(TehsilMaster tehsilMaster) {
		this.tehsilMaster = tehsilMaster;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
