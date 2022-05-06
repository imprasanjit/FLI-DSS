package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.List;


/**
 * The persistent class for the nfb_master database table.
 * 
 */
@Entity
@Table(name="nfb_master")
@NamedQuery(name="NfbMaster.findAll", query="SELECT n FROM NfbMaster n")
public class NfbMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="jv_rpt")
	private String jvRpt;

	@Column(name="narea_ha")
	private BigDecimal nareaHa;

	@Column(name="narea_skqm")
	private BigDecimal nareaSkqm;

	@Column(name="nfb_name")
	private String nfbName;

	@Column(name="nfb_type")
	private String nfbType;

	@Column(name="notf_copy")
	private String notfCopy;

	@Column(name="notf_dt")
	private String notfDt;

	@Column(name="notf_no")
	private String notfNo;

	@Column(name="tmap_copy")
	private String tmapCopy;

	//bi-directional many-to-one association to NfbDetail
	/*
	 * @OneToMany(mappedBy="nfbMaster") private List<NfbDetail> nfbDetails;
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

	//bi-directional many-to-one association to RangeMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="chrv_fk_range_cd")
	private RangeMaster rangeMaster;

	//bi-directional many-to-one association to VectorMasterData
	/*
	 * @OneToMany(mappedBy="nfbMaster") private List<VectorMasterData>
	 * vectorMasterData;
	 */

	public NfbMaster() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getJvRpt() {
		return this.jvRpt;
	}

	public void setJvRpt(String jvRpt) {
		this.jvRpt = jvRpt;
	}

	public BigDecimal getNareaHa() {
		return this.nareaHa;
	}

	public void setNareaHa(BigDecimal nareaHa) {
		this.nareaHa = nareaHa;
	}

	public BigDecimal getNareaSkqm() {
		return this.nareaSkqm;
	}

	public void setNareaSkqm(BigDecimal nareaSkqm) {
		this.nareaSkqm = nareaSkqm;
	}

	public String getNfbName() {
		return this.nfbName;
	}

	public void setNfbName(String nfbName) {
		this.nfbName = nfbName;
	}

	public String getNfbType() {
		return this.nfbType;
	}

	public void setNfbType(String nfbType) {
		this.nfbType = nfbType;
	}

	public String getNotfCopy() {
		return this.notfCopy;
	}

	public void setNotfCopy(String notfCopy) {
		this.notfCopy = notfCopy;
	}

	public String getNotfDt() {
		return this.notfDt;
	}

	public void setNotfDt(String notfDt) {
		this.notfDt = notfDt;
	}

	public String getNotfNo() {
		return this.notfNo;
	}

	public void setNotfNo(String notfNo) {
		this.notfNo = notfNo;
	}

	public String getTmapCopy() {
		return this.tmapCopy;
	}

	public void setTmapCopy(String tmapCopy) {
		this.tmapCopy = tmapCopy;
	}

	/*
	 * public List<NfbDetail> getNfbDetails() { return this.nfbDetails; }
	 * 
	 * public void setNfbDetails(List<NfbDetail> nfbDetails) { this.nfbDetails =
	 * nfbDetails; }
	 * 
	 * public NfbDetail addNfbDetail(NfbDetail nfbDetail) {
	 * getNfbDetails().add(nfbDetail); nfbDetail.setNfbMaster(this);
	 * 
	 * return nfbDetail; }
	 */

	/*
	 * public NfbDetail removeNfbDetail(NfbDetail nfbDetail) {
	 * getNfbDetails().remove(nfbDetail); nfbDetail.setNfbMaster(null);
	 * 
	 * return nfbDetail; }
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

	public RangeMaster getRangeMaster() {
		return this.rangeMaster;
	}

	public void setRangeMaster(RangeMaster rangeMaster) {
		this.rangeMaster = rangeMaster;
	}

	/*
	 * public List<VectorMasterData> getVectorMasterData() { return
	 * this.vectorMasterData; }
	 * 
	 * public void setVectorMasterData(List<VectorMasterData> vectorMasterData) {
	 * this.vectorMasterData = vectorMasterData; }
	 * 
	 * public VectorMasterData addVectorMasterData(VectorMasterData
	 * vectorMasterData) { getVectorMasterData().add(vectorMasterData);
	 * vectorMasterData.setNfbMaster(this);
	 * 
	 * return vectorMasterData; }
	 * 
	 * public VectorMasterData removeVectorMasterData(VectorMasterData
	 * vectorMasterData) { getVectorMasterData().remove(vectorMasterData);
	 * vectorMasterData.setNfbMaster(null);
	 * 
	 * return vectorMasterData; }
	 */

}