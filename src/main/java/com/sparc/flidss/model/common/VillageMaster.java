package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the village_master database table.
 * 
 */
@Entity
@Table(name="village_master")
@NamedQuery(name="VillageMaster.findAll", query="SELECT v FROM VillageMaster v")
public class VillageMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="vill_code")
	private String villCode;

	@Column(name="block_name")
	private String blockName;

	@Column(name="gp_name")
	private String gpName;

	@Column(name="ps_name")
	private String psName;

	@Column(name="publ_year")
	private BigDecimal publYear;

	@Column(name="ric_id")
	private BigDecimal ricId;

	@Column(name="ric_name")
	private String ricName;

	@Column(name="thana_no")
	private String thanaNo;

	@Column(name="vill_name")
	private String villName;

	//bi-directional many-to-one association to DistrictMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_district")
	private DistrictMaster districtMaster;

	//bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_division")
	private DivisionMaster divisionMaster;

	//bi-directional many-to-one association to RangeMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="chrv_fk_range_cd")
	private RangeMaster rangeMaster;

	//bi-directional many-to-one association to TehsilMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_tehsil")
	private TehsilMaster tehsilMaster;

	public VillageMaster() {
	}

	public String getVillCode() {
		return this.villCode;
	}

	public void setVillCode(String villCode) {
		this.villCode = villCode;
	}

	public String getBlockName() {
		return this.blockName;
	}

	public void setBlockName(String blockName) {
		this.blockName = blockName;
	}

	public String getGpName() {
		return this.gpName;
	}

	public void setGpName(String gpName) {
		this.gpName = gpName;
	}

	public String getPsName() {
		return this.psName;
	}

	public void setPsName(String psName) {
		this.psName = psName;
	}

	public BigDecimal getPublYear() {
		return this.publYear;
	}

	public void setPublYear(BigDecimal publYear) {
		this.publYear = publYear;
	}

	public BigDecimal getRicId() {
		return this.ricId;
	}

	public void setRicId(BigDecimal ricId) {
		this.ricId = ricId;
	}

	public String getRicName() {
		return this.ricName;
	}

	public void setRicName(String ricName) {
		this.ricName = ricName;
	}

	public String getThanaNo() {
		return this.thanaNo;
	}

	public void setThanaNo(String thanaNo) {
		this.thanaNo = thanaNo;
	}

	public String getVillName() {
		return this.villName;
	}

	public void setVillName(String villName) {
		this.villName = villName;
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

	public RangeMaster getRangeMaster() {
		return this.rangeMaster;
	}

	public void setRangeMaster(RangeMaster rangeMaster) {
		this.rangeMaster = rangeMaster;
	}

	public TehsilMaster getTehsilMaster() {
		return this.tehsilMaster;
	}

	public void setTehsilMaster(TehsilMaster tehsilMaster) {
		this.tehsilMaster = tehsilMaster;
	}

}