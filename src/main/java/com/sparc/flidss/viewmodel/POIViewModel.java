package com.sparc.flidss.viewmodel;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Immutable;
@Entity
@Immutable 
@Table(name = "POIViewModel")
public class POIViewModel implements Serializable{
	@Id

	private Integer cid;
	private Integer dist_id;
	private Integer div_id;
	private String range_code;
	private Integer tah_id;
	private String vill_code;
	private Integer fb_id;
	@Column
    private String circle_name;
	@Column
    private String district_name;
	@Column
    private String division_name;
	@Column
    private String range_name;
	@Column
	private String tahasil_name;
	@Column
	private String ri_circle;
	public String getRi_circle() {
		return ri_circle;
	}
	public void setRi_circle(String ri_circle) {
		this.ri_circle = ri_circle;
	}
	@Column
	private String gp_name;
	@Column
	private String village_name;
	@Column
	private String fb_name;
	@Column
    private String fb_type;
	@Column
    private Double area_ha;
	@Column
    private Double area_sqkm;
	@Column
    private Double area_acre;
	@Column
	private String nearest_fb;
	@Column
	private Double distance_from_fb;
	@Column
	private String land_type;
	@Column
	private String khata_no;
	@Column
	private Integer plot_no;
	@Column
	private String kissam;
	@Column
    private Double perimeter;
	@Column
	private String pa;
	@Column
	private String nearest_pa;
	@Column
	private Double dist_from_pa;
	private String esz;
	@Column
	private String nearest_esz;
	@Column
	private Double dist_from_esz;
	@Column
	private String deemed_forest_involved;
	@Column
	private Double deemed_area;
	@Column
	private String diverted_forest;
	@Column
	private Double diverted_area;
	@Column
	private String wc;
	@Column
	private Double wc_area;

	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}
	public Integer getDist_id() {
		return dist_id;
	}
	public void setDist_id(Integer dist_id) {
		this.dist_id = dist_id;
	}
	public Integer getDiv_id() {
		return div_id;
	}
	public void setDiv_id(Integer div_id) {
		this.div_id = div_id;
	}
	public String getRange_code() {
		return range_code;
	}
	public void setRange_code(String range_code) {
		this.range_code = range_code;
	}
	public Integer getTah_id() {
		return tah_id;
	}
	public void setTah_id(Integer tah_id) {
		this.tah_id = tah_id;
	}
	public String getVill_code() {
		return vill_code;
	}
	public void setVill_code(String vill_code) {
		this.vill_code = vill_code;
	}
	public Integer getFb_id() {
		return fb_id;
	}
	public void setFb_id(Integer fb_id) {
		this.fb_id = fb_id;
	}
	public String getCircle_name() {
		return circle_name;
	}
	public void setCircle_name(String circle_name) {
		this.circle_name = circle_name;
	}
	public String getDistrict_name() {
		return district_name;
	}
	public void setDistrict_name(String district_name) {
		this.district_name = district_name;
	}
	public String getDivision_name() {
		return division_name;
	}
	public void setDivision_name(String division_name) {
		this.division_name = division_name;
	}
	public String getRange_name() {
		return range_name;
	}
	public void setRange_name(String range_name) {
		this.range_name = range_name;
	}
	public String getTahasil_name() {
		return tahasil_name;
	}
	public void setTahasil_name(String tahasil_name) {
		this.tahasil_name = tahasil_name;
	}
	public String getGp_name() {
		return gp_name;
	}
	public void setGp_name(String gp_name) {
		this.gp_name = gp_name;
	}
	public String getVillage_name() {
		return village_name;
	}
	public void setVillage_name(String village_name) {
		this.village_name = village_name;
	}
	public String getFb_name() {
		return fb_name;
	}
	public void setFb_name(String fb_name) {
		this.fb_name = fb_name;
	}
	public String getFb_type() {
		return fb_type;
	}
	public void setFb_type(String fb_type) {
		this.fb_type = fb_type;
	}
	public Double getArea_ha() {
		return area_ha;
	}
	public void setArea_ha(Double area_ha) {
		this.area_ha = area_ha;
	}
	public Double getArea_sqkm() {
		return area_sqkm;
	}
	public void setArea_sqkm(Double area_sqkm) {
		this.area_sqkm = area_sqkm;
	}
	public Double getArea_acre() {
		return area_acre;
	}
	public void setArea_acre(Double area_acre) {
		this.area_acre = area_acre;
	}
	public String getNearest_fb() {
		return nearest_fb;
	}
	public void setNearest_fb(String nearest_fb) {
		this.nearest_fb = nearest_fb;
	}
	public Double getDistance_from_fb() {
		return distance_from_fb;
	}
	public void setDistance_from_fb(Double distance_from_fb) {
		this.distance_from_fb = distance_from_fb;
	}
	public String getLand_type() {
		return land_type;
	}
	public void setLand_type(String land_type) {
		this.land_type = land_type;
	}
	public String getKhata_no() {
		return khata_no;
	}
	public void setKhata_no(String khata_no) {
		this.khata_no = khata_no;
	}
	public Integer getPlot_no() {
		return plot_no;
	}
	public void setPlot_no(Integer plot_no) {
		this.plot_no = plot_no;
	}
	public String getKissam() {
		return kissam;
	}
	public void setKissam(String kissam) {
		this.kissam = kissam;
	}
	public Double getPerimeter() {
		return perimeter;
	}
	public void setPerimeter(Double perimeter) {
		this.perimeter = perimeter;
	}
	public String getPa() {
		return pa;
	}
	public void setPa(String pa) {
		this.pa = pa;
	}
	public String getNearest_pa() {
		return nearest_pa;
	}
	public void setNearest_pa(String nearest_pa) {
		this.nearest_pa = nearest_pa;
	}
	public Double getDist_from_pa() {
		return dist_from_pa;
	}
	public void setDist_from_pa(Double dist_from_pa) {
		this.dist_from_pa = dist_from_pa;
	}
	public String getEsz() {
		return esz;
	}
	public void setEsz(String esz) {
		this.esz = esz;
	}
	public String getNearest_esz() {
		return nearest_esz;
	}
	public void setNearest_esz(String nearest_esz) {
		this.nearest_esz = nearest_esz;
	}
	public Double getDist_from_esz() {
		return dist_from_esz;
	}
	public void setDist_from_esz(Double dist_from_esz) {
		this.dist_from_esz = dist_from_esz;
	}
	
	
	public String getDeemed_forest_involved() {
		return deemed_forest_involved;
	}
	public void setDeemed_forest_involved(String deemed_forest_involved) {
		this.deemed_forest_involved = deemed_forest_involved;
	}
	public Double getDeemed_area() {
		return deemed_area;
	}
	public void setDeemed_area(Double deemed_area) {
		this.deemed_area = deemed_area;
	}
	public String getDiverted_forest() {
		return diverted_forest;
	}
	public void setDiverted_forest(String diverted_forest) {
		this.diverted_forest = diverted_forest;
	}
	public Double getDiverted_area() {
		return diverted_area;
	}
	public void setDiverted_area(Double diverted_area) {
		this.diverted_area = diverted_area;
	}
	public String getWc() {
		return wc;
	}
	public void setWc(String wc) {
		this.wc = wc;
	}
	public Double getWc_area() {
		return wc_area;
	}
	public void setWc_area(Double wc_area) {
		this.wc_area = wc_area;
	}
	
	
}
