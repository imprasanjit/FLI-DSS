package com.sparc.flidss.viewmodel.progressmonitoring;

import java.sql.Timestamp;

public interface IFpcppointDetails {

	public Integer getInt_id();
	public Integer setInt_id();
	public Double getDec_northing();
	public Double getDec_longitude();
	public Double getDec_latitude();
	public Double getDec_ellipse_height();
	public Double getDec_elevation_height();
	public Double getDec_easting();
	public String getChrv_utmZone();
	public String getChrv_location();
	public String getChrv_fk_range();
	public String getChrv_file_path();
	public Integer getNfbid();
	public Integer getDivid();
	
}
