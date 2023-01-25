package com.sparc.flidss.viewmodel.progressmonitoring;

import java.sql.Timestamp;

public interface IOrsacCertifiedpointDetails {

	public Integer getDgps_pillar_id();
	public Integer getJv_pillar_id();
	public Integer getNfb_id();
	public String getPillar_no();
	public String getPillar_type();
	public String getObserved_static_file_path();
	//public Timestamp getDur_of_obs_mmss();
	public String getForwad_image_path();
	public String getBackward_image_path();
	public String getInward_image_path();
	public String getOutward_image_path();
	public String getDevice_image_path();
	public String getSurvayer_name();
	public Timestamp getSurvey_date();
	public String getForest_representative_name();
	//public Timestamp getUtm_zone();
	public Double getNorthing();
	public Double getEasting();
	public Double getElevation();
	public Double getLatitude();
	public Double getLongitude();
	public Double getEllisoid_height();
	public Double getHorizonental_prec_m();
	public Double getVertical_prec_m();
	public String getPdop();
	public String getSolution_type();
	public Integer getReference_map_pillar_number();
	public Integer getDivid();
	public String  getRngcode();
	public Integer getFso_pillar_type();
}
