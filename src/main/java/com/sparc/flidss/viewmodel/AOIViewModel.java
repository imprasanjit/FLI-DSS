
package com.sparc.flidss.viewmodel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Immutable;
@Entity
@Immutable 
@Table(name = "AOIViewModel")
public class AOIViewModel {
	@Id
	private String grid_id;
	private Double area_geom;
	private Double area_grid;
	private Integer total_district;
	private Integer total_divisions;
	private Integer	total_tahasils;
	private Integer total_ranges;
	private Integer total_fbs;
	private Double area_fbs_ha;
	private Double area_fbs_sqkm;
	private Integer total_villages;
	private Integer total_plots;
	private Integer plots_rev;
	private Integer plots_dlc;
	private Integer plots_rev_dlc;
	private Double area_revplot_ha;
	private Double area_revplot_acre;
	private Double area_dlcplot_ha;
	private Double area_dlcplot_acre;
	private Double area_rev_dlc_ha;
	private Double area_rev_dlc_acre;
	private Integer total_pa;
	private Integer total_esz;
	private Integer total_wc;
	private Integer total_deemed;
	private Integer total_diverted;
	private Double area_pa_ha;
	private Double area_esz_ha;
	private Double area_wc_ha;
	private String dist_name;
	private String div_name;
	private Double nfb_area;
	private Double rf_area;
	private Double other_forest_area;
	private Double total_forest_area;
	private Double non_forest_area;
	private Double total_aoi_area;
	private Double area_of_plots;
	public Double getArea_of_plots() {
		return area_of_plots;
	}
	public void setArea_of_plots(Double area_of_plots) {
		this.area_of_plots = area_of_plots;
	}
	public Double getTotal_aoi_area() {
		return total_aoi_area;
	}
	public void setTotal_aoi_area(Double total_aoi_area) {
		this.total_aoi_area = total_aoi_area;
	}
	public Double getNfb_area() {
		return nfb_area;
	}
	public void setNfb_area(Double nfb_area) {
		this.nfb_area = nfb_area;
	}
	public Double getRf_area() {
		return rf_area;
	}
	public void setRf_area(Double rf_area) {
		this.rf_area = rf_area;
	}
	public Double getOther_forest_area() {
		return other_forest_area;
	}
	public void setOther_forest_area(Double other_forest_area) {
		this.other_forest_area = other_forest_area;
	}
	public Double getTotal_forest_area() {
		return total_forest_area;
	}
	public void setTotal_forest_area(Double total_forest_area) {
		this.total_forest_area = total_forest_area;
	}
	public Double getNon_forest_area() {
		return non_forest_area;
	}
	public void setNon_forest_area(Double non_forest_area) {
		this.non_forest_area = non_forest_area;
	}
	public String getDist_name() {
		return dist_name;
	}
	public void setDist_name(String dist_name) {
		this.dist_name = dist_name;
	}
	public String getDiv_name() {
		return div_name;
	}
	public void setDiv_name(String div_name) {
		this.div_name = div_name;
	}
	
	
	public String getRng_name() {
		return rng_name;
	}
	public void setRng_name(String rng_name) {
		this.rng_name = rng_name;
	}
	public String getGp_name() {
		return gp_name;
	}
	public void setGp_name(String gp_name) {
		this.gp_name = gp_name;
	}
	public String getVillg_name() {
		return villg_name;
	}
	public void setVillg_name(String villg_name) {
		this.villg_name = villg_name;
	}
	private String rng_name;
	private String tah_name;
	public String getTah_name() {
		return tah_name;
	}
	public void setTah_name(String tah_name) {
		this.tah_name = tah_name;
	}
	private String gp_name;
	private String villg_name;
	public Integer getTotal_pa() {
		return total_pa;
	}
	public void setTotal_pa(Integer total_pa) {
		this.total_pa = total_pa;
	}
	public Integer getTotal_esz() {
		return total_esz;
	}
	public void setTotal_esz(Integer total_esz) {
		this.total_esz = total_esz;
	}
	public Integer getTotal_wc() {
		return total_wc;
	}
	public void setTotal_wc(Integer total_wc) {
		this.total_wc = total_wc;
	}
	public Integer getTotal_deemed() {
		return total_deemed;
	}
	public void setTotal_deemed(Integer total_deemed) {
		this.total_deemed = total_deemed;
	}
	public Integer getTotal_diverted() {
		return total_diverted;
	}
	public void setTotal_diverted(Integer total_diverted) {
		this.total_diverted = total_diverted;
	}
	public Double getArea_pa_ha() {
		return area_pa_ha;
	}
	public void setArea_pa_ha(Double area_pa_ha) {
		this.area_pa_ha = area_pa_ha;
	}
	public Double getArea_esz_ha() {
		return area_esz_ha;
	}
	public void setArea_esz_ha(Double area_esz_ha) {
		this.area_esz_ha = area_esz_ha;
	}
	public Double getArea_wc_ha() {
		return area_wc_ha;
	}
	public void setArea_wc_ha(Double area_wc_ha) {
		this.area_wc_ha = area_wc_ha;
	}
	public Double getArea_deemed_ha() {
		return area_deemed_ha;
	}
	public void setArea_deemed_ha(Double area_deemed_ha) {
		this.area_deemed_ha = area_deemed_ha;
	}
	public Double getArea_diverted_ha() {
		return area_diverted_ha;
	}
	public void setArea_diverted_ha(Double area_diverted_ha) {
		this.area_diverted_ha = area_diverted_ha;
	}
	private Double area_deemed_ha;
	private Double area_diverted_ha;
	
	  public Integer getPlots_rev_dlc() {
		return plots_rev_dlc;
	}
	public void setPlots_rev_dlc(Integer plots_rev_dlc) {
		this.plots_rev_dlc = plots_rev_dlc;
	}
	public Double getArea_dlcplot_ha() {
		return area_dlcplot_ha;
	}
	public void setArea_dlcplot_ha(Double area_dlcplot_ha) {
		this.area_dlcplot_ha = area_dlcplot_ha;
	}
	public Double getArea_dlcplot_acre() {
		return area_dlcplot_acre;
	}
	public void setArea_dlcplot_acre(Double area_dlcplot_acre) {
		this.area_dlcplot_acre = area_dlcplot_acre;
	}
	public Double getArea_rev_dlc_ha() {
		return area_rev_dlc_ha;
	}
	public void setArea_rev_dlc_ha(Double area_rev_dlc_ha) {
		this.area_rev_dlc_ha = area_rev_dlc_ha;
	}
	public Double getArea_rev_dlc_acre() {
		return area_rev_dlc_acre;
	}
	public void setArea_rev_dlc_acre(Double area_rev_dlc_acre) {
		this.area_rev_dlc_acre = area_rev_dlc_acre;
	}
	public String getGrid_id() 
	  { 
		  return grid_id;
	  }
	  public void setGrid_id(String grid_id) 
	  { 
		  this.grid_id = grid_id; 
	  }
	 
	public Double getArea_geom() {
		return area_geom;
	}
	public void setArea_geom(Double area_geom) {
		this.area_geom = area_geom;
	}
	public Double getArea_grid() {
		return area_grid;
	}
	public void setArea_grid(Double area_grid) {
		this.area_grid = area_grid;
	}
	public Integer getTotal_district() {
		return total_district;
	}
	public void setTotal_district(Integer total_district) {
		this.total_district = total_district;
	}
	public Integer getTotal_divisions() {
		return total_divisions;
	}
	public void setTotal_divisions(Integer total_divisions) {
		this.total_divisions = total_divisions;
	}
	public Integer getTotal_tahasils() {
		return total_tahasils;
	}
	public void setTotal_tahasils(Integer total_tahasils) {
		this.total_tahasils = total_tahasils;
	}
	public Integer getTotal_ranges() {
		return total_ranges;
	}
	public void setTotal_ranges(Integer total_ranges) {
		this.total_ranges = total_ranges;
	}
	public Integer getTotal_fbs() {
		return total_fbs;
	}
	public void setTotal_fbs(Integer total_fbs) {
		this.total_fbs = total_fbs;
	}
	public Double getArea_fbs_ha() {
		return area_fbs_ha;
	}
	public void setArea_fbs_ha(Double area_fbs_ha) {
		this.area_fbs_ha = area_fbs_ha;
	}
	public Double getArea_fbs_sqkm() {
		return area_fbs_sqkm;
	}
	public void setArea_fbs_sqkm(Double area_fbs_sqkm) {
		this.area_fbs_sqkm = area_fbs_sqkm;
	}
	public Integer getTotal_villages() {
		return total_villages;
	}
	public void setTotal_villages(Integer total_villages) {
		this.total_villages = total_villages;
	}
	public Integer getTotal_plots() {
		return total_plots;
	}
	public void setTotal_plots(Integer total_plots) {
		this.total_plots = total_plots;
	}
	public Integer getPlots_rev() {
		return plots_rev;
	}
	public void setPlots_rev(Integer plots_rev) {
		this.plots_rev = plots_rev;
	}
	public Integer getPlots_dlc() {
		return plots_dlc;
	}
	public void setPlots_dlc(Integer plots_dlc) {
		this.plots_dlc = plots_dlc;
	}
	public Double getArea_revplot_ha() {
		return area_revplot_ha;
	}
	public void setArea_revplot_ha(Double area_revplot_ha) {
		this.area_revplot_ha = area_revplot_ha;
	}
	public Double getArea_revplot_acre() {
		return area_revplot_acre;
	}
	public void setArea_revplot_acre(Double area_revplot_acre) {
		this.area_revplot_acre = area_revplot_acre;
	}
	
}
