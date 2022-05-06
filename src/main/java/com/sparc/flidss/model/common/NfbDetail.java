package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * The persistent class for the nfb_details database table.
 * 
 */
@Entity
@Table(name = "nfb_details")
@NamedQuery(name = "NfbDetail.findAll", query = "SELECT n FROM NfbDetail n")
public class NfbDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name = "int_id")
	private Integer intId;
	// bi-directional many-to-one association to NfbMaster
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_nfb")
	private NfbMaster nfbMaster;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_division")
	private DivisionMaster divisionMaster;
	@Column(name = "cmv_ha")
	private BigDecimal cmvHa;

	@Column(name = "dgps_dmap")
	private String dgpsDmap;

	@Column(name = "dgps_fmap")
	private String dgpsFmap;

	@Column(name = "dgpsd_ha")
	private BigDecimal dgpsdHa;

	@Column(name = "dgpsf_ha")
	private BigDecimal dgpsfHa;

	@Column(name = "jv_catg")
	private String jvCatg;

	@Column(name = "jv_ha")
	private BigDecimal jvHa;

	@Column(name = "jv_rpt")
	private String jvRpt;

	@Column(name = "mmv_ha")
	private BigDecimal mmvHa;

	@Column(name = "jv_existing_pnts")
	public Integer jvExistingPnts;
	@Column(name = "jv_propose_pnts")
	public Integer jvProposePnts;
	@Column(name = "wp_year")
	public Integer wpYear;
	@Column(name = "wp_area")
	public Double wp_area;
	@Column(name = "no_of_peripheral_villages")
	public Integer noOfPeripheralVillages;
	@Column(name = "villages_settled_after1980")
	public Integer villagesSettledAfter1980;
	@Column(name = "villages_settled_before1980")
	public Integer villagesSettledBefore1980;
	@Column(name = "gis_executive_name")
	public String gisExecutiveName;
	@Column(name = "jv_sdate")
	public Timestamp jvSdate;
	@Column(name = "jv_edate")
	public Timestamp jvEdate;
	@Column(name = "surveyor_name")
	public String surveyorName;
	@Column(name = "existing_demarcation_perimeter")
	public BigDecimal existingDemarcationPerimeter;
	@Column(name = "new_demarcation_perimeter")
	public BigDecimal newDemarcationPerimeter;
	@Column(name = "jv_perimeter")
	public BigDecimal jvPerimeter;
	@Column(name = "jv_observation")
	public String jvObservation;
	@Column(name = "jv_report_submited_dt")
	public Timestamp jvReportSubmitedDt;
	@Column(name = "frjvc_clear_dt")
	public Timestamp frjvcClearDt;
	@Column(name = "dgps_sdate")
	public Timestamp dgpsSdate;
	@Column(name = "dgps_edate")
	public Timestamp dgpsEdate;
	@Column(name = "dgps_no_of_newpillarpoint")
	public Integer dgpsNoOfNewpillarpoint;
	@Column(name = "no_of_fscp")
	public Integer noOfFscp;
	@Column(name = "dgps_no_of_surveypoint")
	public Integer dgpsNoOfSurveypoint;
	@Column(name = "no_of_rtxobservation")
	public Integer noOfRtxobservation;
	@Column(name = "no_of_sbas_other")
	public Integer noOfSbasOther;
	@Column(name = "no_of_staticfile")
	public Integer noOfStaticfile;
	@Column(name = "no_of_jxlfile")
	public Integer noOfJxlfile;
	@Column(name = "orsac_clearence_dt")
	public Timestamp orsacClearenceDt;
	@Column(name = "draftmap_sub_dt")
	public Timestamp draftmapSubDt;
	@Column(name = "dfo_certification_dt")
	public Timestamp dfoCertificationDt;
	@Column(name = "fso_certification_dt")
	public Timestamp fsoCertificationDt;
	@Column(name = "finalmap_sub_dt")
	public Timestamp finalmapSubDt;
	@Column(name = "renotification_prop_dt")
	public Timestamp renotificationPropDt;

	@Column(name = "isdelete")
	public Boolean isDelete;

	public NfbDetail() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public NfbMaster getNfbMaster() {
		return this.nfbMaster;
	}

	public void setNfbMaster(NfbMaster nfbMaster) {
		this.nfbMaster = nfbMaster;
	}

	public DivisionMaster getDivisionMaster() {
		return divisionMaster;
	}

	public void setDivisionMaster(DivisionMaster divisionMaster) {
		this.divisionMaster = divisionMaster;
	}

	public BigDecimal getCmvHa() {
		return this.cmvHa;
	}

	public void setCmvHa(BigDecimal cmvHa) {
		this.cmvHa = cmvHa;
	}

	public String getDgpsDmap() {
		return this.dgpsDmap;
	}

	public void setDgpsDmap(String dgpsDmap) {
		this.dgpsDmap = dgpsDmap;
	}

	public String getDgpsFmap() {
		return this.dgpsFmap;
	}

	public void setDgpsFmap(String dgpsFmap) {
		this.dgpsFmap = dgpsFmap;
	}

	public BigDecimal getDgpsdHa() {
		return this.dgpsdHa;
	}

	public void setDgpsdHa(BigDecimal dgpsdHa) {
		this.dgpsdHa = dgpsdHa;
	}

	public BigDecimal getDgpsfHa() {
		return this.dgpsfHa;
	}

	public void setDgpsfHa(BigDecimal dgpsfHa) {
		this.dgpsfHa = dgpsfHa;
	}

	public String getJvCatg() {
		return this.jvCatg;
	}

	public void setJvCatg(String jvCatg) {
		this.jvCatg = jvCatg;
	}

	public BigDecimal getJvHa() {
		return this.jvHa;
	}

	public void setJvHa(BigDecimal jvHa) {
		this.jvHa = jvHa;
	}

	public String getJvRpt() {
		return this.jvRpt;
	}

	public void setJvRpt(String jvRpt) {
		this.jvRpt = jvRpt;
	}

	public BigDecimal getMmvHa() {
		return this.mmvHa;
	}

	public void setMmvHa(BigDecimal mmvHa) {
		this.mmvHa = mmvHa;
	}

	public Integer getJvExistingPnts() {
		return jvExistingPnts;
	}

	public void setJvExistingPnts(Integer jvExistingPnts) {
		this.jvExistingPnts = jvExistingPnts;
	}

	public Integer getJvProposePnts() {
		return jvProposePnts;
	}

	public void setJvProposePnts(Integer jvProposePnts) {
		this.jvProposePnts = jvProposePnts;
	}

	public Integer getWpYear() {
		return wpYear;
	}

	public void setWpYear(Integer wpYear) {
		this.wpYear = wpYear;
	}

	public Double getWp_area() {
		return wp_area;
	}

	public void setWp_area(Double wp_area) {
		this.wp_area = wp_area;
	}

	public Integer getNoOfPeripheralVillages() {
		return noOfPeripheralVillages;
	}

	public void setNoOfPeripheralVillages(Integer noOfPeripheralVillages) {
		this.noOfPeripheralVillages = noOfPeripheralVillages;
	}

	public Integer getVillagesSettledAfter1980() {
		return villagesSettledAfter1980;
	}

	public void setVillagesSettledAfter1980(Integer villagesSettledAfter1980) {
		this.villagesSettledAfter1980 = villagesSettledAfter1980;
	}

	public Integer getVillagesSettledBefore1980() {
		return villagesSettledBefore1980;
	}

	public void setVillagesSettledBefore1980(Integer villagesSettledBefore1980) {
		this.villagesSettledBefore1980 = villagesSettledBefore1980;
	}

	public String getGisExecutiveName() {
		return gisExecutiveName;
	}

	public void setGisExecutiveName(String gisExecutiveName) {
		this.gisExecutiveName = gisExecutiveName;
	}

	public Timestamp getJvSdate() {
		return jvSdate;
	}

	public void setJvSdate(Timestamp jvSdate) {
		this.jvSdate = jvSdate;
	}

	public Timestamp getJvEdate() {
		return jvEdate;
	}

	public void setJvEdate(Timestamp jvEdate) {
		this.jvEdate = jvEdate;
	}

	public String getSurveyorName() {
		return surveyorName;
	}

	public void setSurveyorName(String surveyorName) {
		this.surveyorName = surveyorName;
	}

	public BigDecimal getExistingDemarcationPerimeter() {
		return existingDemarcationPerimeter;
	}

	public void setExistingDemarcationPerimeter(BigDecimal existingDemarcationPerimeter) {
		this.existingDemarcationPerimeter = existingDemarcationPerimeter;
	}

	public BigDecimal getNewDemarcationPerimeter() {
		return newDemarcationPerimeter;
	}

	public void setNewDemarcationPerimeter(BigDecimal newDemarcationPerimeter) {
		this.newDemarcationPerimeter = newDemarcationPerimeter;
	}

	public BigDecimal getJvPerimeter() {
		return jvPerimeter;
	}

	public void setJvPerimeter(BigDecimal jvPerimeter) {
		this.jvPerimeter = jvPerimeter;
	}

	public String getJvObservation() {
		return jvObservation;
	}

	public void setJvObservation(String jvObservation) {
		this.jvObservation = jvObservation;
	}

	public Timestamp getJvReportSubmitedDt() {
		return jvReportSubmitedDt;
	}

	public void setJvReportSubmitedDt(Timestamp jvReportSubmitedDt) {
		this.jvReportSubmitedDt = jvReportSubmitedDt;
	}

	public Timestamp getFrjvcClearDt() {
		return frjvcClearDt;
	}

	public void setFrjvcClearDt(Timestamp frjvcClearDt) {
		this.frjvcClearDt = frjvcClearDt;
	}

	public Timestamp getDgpsSdate() {
		return dgpsSdate;
	}

	public void setDgpsSdate(Timestamp dgpsSdate) {
		this.dgpsSdate = dgpsSdate;
	}

	public Timestamp getDgpsEdate() {
		return dgpsEdate;
	}

	public void setDgpsEdate(Timestamp dgpsEdate) {
		this.dgpsEdate = dgpsEdate;
	}

	public Integer getDgpsNoOfNewpillarpoint() {
		return dgpsNoOfNewpillarpoint;
	}

	public void setDgpsNoOfNewpillarpoint(Integer dgpsNoOfNewpillarpoint) {
		this.dgpsNoOfNewpillarpoint = dgpsNoOfNewpillarpoint;
	}

	public Integer getNoOfFscp() {
		return noOfFscp;
	}

	public void setNoOfFscp(Integer noOfFscp) {
		this.noOfFscp = noOfFscp;
	}

	public Integer getDgpsNoOfSurveypoint() {
		return dgpsNoOfSurveypoint;
	}

	public void setDgpsNoOfSurveypoint(Integer dgpsNoOfSurveypoint) {
		this.dgpsNoOfSurveypoint = dgpsNoOfSurveypoint;
	}

	public Integer getNoOfRtxobservation() {
		return noOfRtxobservation;
	}

	public void setNoOfRtxobservation(Integer noOfRtxobservation) {
		this.noOfRtxobservation = noOfRtxobservation;
	}

	public Integer getNoOfSbasOther() {
		return noOfSbasOther;
	}

	public void setNoOfSbasOther(Integer noOfSbasOther) {
		this.noOfSbasOther = noOfSbasOther;
	}

	public Integer getNoOfStaticfile() {
		return noOfStaticfile;
	}

	public void setNoOfStaticfile(Integer noOfStaticfile) {
		this.noOfStaticfile = noOfStaticfile;
	}

	public Integer getNoOfJxlfile() {
		return noOfJxlfile;
	}

	public void setNoOfJxlfile(Integer noOfJxlfile) {
		this.noOfJxlfile = noOfJxlfile;
	}

	public Timestamp getOrsacClearenceDt() {
		return orsacClearenceDt;
	}

	public void setOrsacClearenceDt(Timestamp orsacClearenceDt) {
		this.orsacClearenceDt = orsacClearenceDt;
	}

	public Timestamp getDraftmapSubDt() {
		return draftmapSubDt;
	}

	public void setDraftmapSubDt(Timestamp draftmapSubDt) {
		this.draftmapSubDt = draftmapSubDt;
	}

	public Timestamp getDfoCertificationDt() {
		return dfoCertificationDt;
	}

	public void setDfoCertificationDt(Timestamp dfoCertificationDt) {
		this.dfoCertificationDt = dfoCertificationDt;
	}

	public Timestamp getFsoCertificationDt() {
		return fsoCertificationDt;
	}

	public void setFsoCertificationDt(Timestamp fsoCertificationDt) {
		this.fsoCertificationDt = fsoCertificationDt;
	}

	public Timestamp getFinalmapSubDt() {
		return finalmapSubDt;
	}

	public void setFinalmapSubDt(Timestamp finalmapSubDt) {
		this.finalmapSubDt = finalmapSubDt;
	}

	public Timestamp getRenotificationPropDt() {
		return renotificationPropDt;
	}

	public void setRenotificationPropDt(Timestamp renotificationPropDt) {
		this.renotificationPropDt = renotificationPropDt;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Boolean getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Boolean isDelete) {
		this.isDelete = isDelete;
	}

}