package com.sparc.flidss.viewmodel.progressmonitoring;

import java.sql.Timestamp;

public interface INfbDetails {
	public Integer getInt_id();
	public Double getCmv_ha();
	public String getDgps_dmap();
	public String getDgps_fmap();
	public Double getDgpsd_ha();
	public Double getDgpsf_ha();
	public String getJv_catg();
	public Double getJv_ha();
	public String getJv_rpt();
	public Double getMmv_ha();
	public Integer getInt_fk_division();
	public Integer getInt_fk_nfb();
	public Integer getJv_existing_pnts();
	public Integer getJv_propose_pnts();
	public Integer getWp_year();
	public Double getWp_area();
	public Integer getNo_of_peripheral_villages();
	public Integer getVillages_settled_after1980();
	public Integer getVillages_settled_before1980();
	public String getGis_executive_name();
	public Timestamp getJv_sdate();
	public Timestamp getJv_edate();
	public String getSurveyor_name();
	public Double getExisting_demarcation_perimeter();
	public Double getNew_demarcation_perimeter();
	public Double getJv_perimeter();
	public String getJv_observation();
	public Timestamp getJv_report_submited_dt();
	public Timestamp getFrjvc_clear_dt();
	public Timestamp getDgps_sdate();
	public Timestamp getDgps_edate();
	public Integer getDgps_no_of_newpillarpoint();
	public Integer getNo_of_fscp();
	public Integer getDgps_no_of_surveypoint();
	public Integer getNo_of_rtxobservation();
	public Integer getNo_of_sbas_other();
	public Integer getNo_of_staticfile();
	public Integer getNo_of_jxlfile();
	public Timestamp getOrsac_clearence_dt();
	public Timestamp getDraftmap_sub_dt();
	public Timestamp getDfo_certification_dt();
	public Timestamp getFso_certification_dt();
	public Timestamp getFinalmap_sub_dt();
	public Timestamp getRenotification_prop_dt();

}
