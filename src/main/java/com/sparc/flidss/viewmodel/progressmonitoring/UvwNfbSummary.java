package com.sparc.flidss.viewmodel.progressmonitoring;

import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import org.hibernate.annotations.Immutable;



@Immutable
@Entity(name = "uvw_nfb_summary")
public class UvwNfbSummary {

	@Id
	@Column(name = "Int_id")
	Integer IntId;
	@Column(name = "nfb_name")
	String NfbName;
	@Column(name = "nfb_type")
	String NfbType;
	@Column(name = "nareaha")
	Double NareaHa;
	@Column(name = "notf_no")
	String NotfNo;
	@Column(name = "notf_dt")
	String NotfDt;
	@Column(name = "notf_copy")
	String NotfCopy;
	@Column(name = "dgpsfha")
	Double DgpsfHa;
	@Column(name="jv_catg")
	String JvCatg;
	@Column(name = "dgpsdha")
	Double DgpsdHa;
	@Column(name = "jvha")
	Double JvHa;
	@Column(name = "Jv_rpt")
	String JvRpt;
	@Column(name = "cmvha")
	Double CmvHa;
	@Column(name = "mmv_ha")
	Double MmvHa;
	@Column(name = "int_fk_phase")
	Integer IntFkPhase;
	@Column(name = "int_fk_circle")
	Integer IntFkCircle;
	@Column(name = "chrv_circle")
	String chrvCircle;
	@Column(name = "int_fk_division")
	Integer IntFkDivision;
	@Column(name = "chrv_division_nm")
	String chrvDivisionNm;
	@Column(name = "chrv_fk_range_cd")
	String ChrvFkRangeCd;
	@Column(name = "chrv_range_nm")
	String chrvRangeNm;
	@Column(name = "int_fk_district")
	Integer intFkDistrict;
	@Column(name = "district")
	String district;
	
	
	@Column(name="jv_existing_pnts")
	public Integer jvExistingPnts;
	@Column(name="jv_propose_pnts")
	public Integer jvProposePnts;
	@Column(name="wp_year")
	public Integer wpYear;
	@Column(name="wp_area")
	public Double wpArea;
	@Column(name="no_of_peripheral_villages")
	public Integer noOfPeripheralVillages;
	@Column(name="villages_settled_after1980")
	public Integer villagesSettledAfter1980;
	@Column(name="villages_settled_before1980")
	public Integer villagesSettledBefore1980;
	@Column(name="gis_executive_name")
	public String gisExecutiveName;
	@Column(name="jv_sdate")
	public Timestamp jvSdate;
	@Column(name="jv_edate")
	public Timestamp jvEdate;
	@Column(name="surveyor_name")
	public String surveyorName;
	@Column(name="existing_demarcation_perimeter")
	public BigDecimal existingDemarcationPerimeter;
	@Column(name="new_demarcation_perimeter")
	public BigDecimal newDemarcationPerimeter;
	@Column(name="jv_perimeter")
	public BigDecimal jvPerimeter;
	@Column(name="jv_observation")
	public String jvObservation;
	@Column(name="jv_report_submited_dt")
	public Timestamp jvReportSubmitedDt;
	@Column(name="frjvc_clear_dt")
	public Timestamp frjvcClearDt;
	@Column(name="dgps_sdate")
	public Timestamp dgpsSdate;
	@Column(name="dgps_edate")
	public Timestamp dgpsEdate;
	@Column(name="dgps_no_of_newpillarpoint")
	public Integer dgpsNoOfNewpillarpoint;
	@Column(name="no_of_fscp")
	public Integer noOfFscp;
	@Column(name="dgps_no_of_surveypoint")
	public Integer dgpsNoOfSurveypoint;
	@Column(name="no_of_rtxobservation")
	public Integer noOfRtxobservation;
	@Column(name="no_of_sbas_other")
	public Integer noOfSbasOther;
	@Column(name="no_of_staticfile")
	public Integer noOfStaticfile;
	@Column(name="no_of_jxlfile")
	public Integer noOfJxlfile;
	@Column(name="orsac_clearence_dt")
	public Timestamp orsacClearenceDt;
	@Column(name="draftmap_sub_dt")
	public Timestamp draftmapSubDt;
	@Column(name="dfo_certification_dt")
	public Timestamp dfoCertificationDt;
	@Column(name="fso_certification_dt")
	public Timestamp fsoCertificationDt;
	@Column(name="finalmap_sub_dt")
	public Timestamp finalmapSubDt;
	@Column(name="renotification_prop_dt")
	public Timestamp renotificationPropDt;
	/*
	 * @Column(name="nooffb") public Integer noofFb;
	 * 
	 * 
	 * public Integer getNoofFb() { return noofFb; }
	 * 
	 * 
	 * 
	 * public void setNoofFb(Integer noofFb) { this.noofFb = noofFb; }
	 */



	public UvwNfbSummary() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public Integer getIntId() {
		return IntId;
	}



	public void setIntId(Integer intId) {
		IntId = intId;
	}



	public String getNfbName() {
		return NfbName;
	}



	public void setNfbName(String nfbName) {
		NfbName = nfbName;
	}



	public String getNfbType() {
		return NfbType;
	}



	public void setNfbType(String nfbType) {
		NfbType = nfbType;
	}


	public Double getNareaHa() {
		return NareaHa;
	}



	public void setNareaHa(Double nareaHa) {
		NareaHa = nareaHa;
	}



	public String getNotfNo() {
		return NotfNo;
	}



	public void setNotfNo(String notfNo) {
		NotfNo = notfNo;
	}



	public String getNotfDt() {
		return NotfDt;
	}



	public void setNotfDt(String notfDt) {
		NotfDt = notfDt;
	}



	public String getNotfCopy() {
		return NotfCopy;
	}



	public void setNotfCopy(String notfCopy) {
		NotfCopy = notfCopy;
	}



	public Double getDgpsfHa() {
		return DgpsfHa;
	}



	public void setDgpsfHa(Double dgpsfHa) {
		DgpsfHa = dgpsfHa;
	}



	public Double getDgpsdHa() {
		return DgpsdHa;
	}



	public void setDgpsdHa(Double dgpsdHa) {
		DgpsdHa = dgpsdHa;
	}


	public String getJvCatg() {
		return JvCatg;
	}



	public void setJvCatg(String jvCatg) {
		this.JvCatg = jvCatg;
	}



	public Double getJvHa() {
		return JvHa;
	}



	public void setJvHa(Double jvHa) {
		JvHa = jvHa;
	}



	public String getJvRpt() {
		return JvRpt;
	}



	public void setJvRpt(String jvRpt) {
		JvRpt = jvRpt;
	}



	public Double getCmvHa() {
		return CmvHa;
	}



	public void setCmvHa(Double cmvHa) {
		CmvHa = cmvHa;
	}



	public Double getMmvHa() {
		return MmvHa;
	}



	public void setMmvHa(Double mmvHa) {
		MmvHa = mmvHa;
	}



	public Integer getIntFkPhase() {
		return IntFkPhase;
	}



	public void setIntFkPhase(Integer intFkPhase) {
		IntFkPhase = intFkPhase;
	}



	public Integer getIntFkCircle() {
		return IntFkCircle;
	}



	public void setIntFkCircle(Integer intFkCircle) {
		IntFkCircle = intFkCircle;
	}



	public String getChrvCircle() {
		return chrvCircle;
	}



	public void setChrvCircle(String chrvCircle) {
		this.chrvCircle = chrvCircle;
	}



	public Integer getIntFkDivision() {
		return IntFkDivision;
	}



	public void setIntFkDivision(Integer intFkDivision) {
		IntFkDivision = intFkDivision;
	}



	public String getChrvDivisionNm() {
		return chrvDivisionNm;
	}



	public void setChrvDivisionNm(String chrvDivisionNm) {
		this.chrvDivisionNm = chrvDivisionNm;
	}



	public String getChrvFkRangeCd() {
		return ChrvFkRangeCd;
	}



	public void setChrvFkRangeCd(String chrvFkRangeCd) {
		ChrvFkRangeCd = chrvFkRangeCd;
	}



	public String getChrvRangeNm() {
		return chrvRangeNm;
	}



	public void setChrvRangeNm(String chrvRangeNm) {
		this.chrvRangeNm = chrvRangeNm;
	}



	public Integer getIntFkDistrict() {
		return intFkDistrict;
	}



	public void setIntFkDistrict(Integer intFkDistrict) {
		this.intFkDistrict = intFkDistrict;
	}



	public String getDistrict() {
		return district;
	}



	public void setDistrict(String district) {
		this.district = district;
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
	public Double getWpArea() {
		return wpArea;
	}
	public void setWpArea(Double wpArea) {
		this.wpArea = wpArea;
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
	
	
}
