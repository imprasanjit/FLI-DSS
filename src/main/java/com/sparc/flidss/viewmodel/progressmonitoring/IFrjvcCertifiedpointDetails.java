package com.sparc.flidss.viewmodel.progressmonitoring;

import java.sql.Timestamp;

public interface IFrjvcCertifiedpointDetails {

	public Integer getJv_pillar_id();
	public Integer getNfb_id();
	public Integer getPillar_no();
	public String getPillar_type();
	public Double getLatitude_dd();
	public Double getLongitude_dd();
	public String getPillar_condition();
	public String getPaint_status();
	public String getPillar_shifting_status();
	public String getPicture_path();
	public Timestamp getSurvey_date();
	public String getSurveyor_name();

}
