package com.sparc.flidss.viewmodel;

import javax.persistence.*;

import org.hibernate.annotations.Immutable;
@Entity
@Immutable 
@Table(name = "AOIAnalysisViewModel")
public class AOIAnalysisViewModel {
		@Id
		@GeneratedValue(strategy=GenerationType.AUTO)
		private String chrvId;
		private Integer div_id;
		private String  div_name;
		private Integer dist_id;
		private String  dist_name;
		private Integer tah_id;
		private String  tahasil;
		private String  range_code;
		private String  range_name;
		private Integer fb_id;
		private String  fb_name;
		private String  fb_type;
		private Double  nfb_area_ha;
		private String  vill_code;
		private String  village;
		private String khata_no;
		private String plot_no;
		public String getKhata_no() {
			return khata_no;
		}
		public void setKhata_no(String khata_no) {
			this.khata_no = khata_no;
		}
		private Double  plot_area_actual;
		private String  kissam;
		private String  land_class;
		private Double  plot_area_ac;
		private String forest_type;
		public String getLand_class() {
			return land_class;
		}
		public void setLand_class(String land_class) {
			this.land_class = land_class;
		}
		private String geom;
		
		
		public String getChrvId() {
			return chrvId;
		}
		public void setChrvId(String chrvId) {
			this.chrvId = chrvId;
		}
		public Integer getDiv_id() {
			return div_id;
		}
		public void setDiv_id(Integer div_id) {
			this.div_id = div_id;
		}
		public String getDiv_name() {
			return div_name;
		}
		public void setDiv_name(String div_name) {
			this.div_name = div_name;
		}
		public Integer getDist_id() {
			return dist_id;
		}
		public void setDist_id(Integer dist_id) {
			this.dist_id = dist_id;
		}
		public String getDist_name() {
			return dist_name;
		}
		public void setDist_name(String dist_name) {
			this.dist_name = dist_name;
		}
		public Integer getTah_id() {
			return tah_id;
		}
		public void setTah_id(Integer tah_id) {
			this.tah_id = tah_id;
		}
		public String getTahasil() {
			return tahasil;
		}
		public void setTahasil(String tahasil) {
			this.tahasil = tahasil;
		}
		public String getRange_code() {
			return range_code;
		}
		public void setRange_code(String range_code) {
			this.range_code = range_code;
		}
		public String getRange_name() {
			return range_name;
		}
		public void setRange_name(String range_name) {
			this.range_name = range_name;
		}
		public Integer getFb_id() {
			return fb_id;
		}
		public void setFb_id(Integer fb_id) {
			this.fb_id = fb_id;
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
		
		public Double getNfb_area_ha() {
			return nfb_area_ha;
		}
		public void setNfb_area_ha(Double nfb_area_ha) {
			this.nfb_area_ha = nfb_area_ha;
		}
		public String getVill_code() {
			return vill_code;
		}
		public void setVill_code(String vill_code) {
			this.vill_code = vill_code;
		}
		public String getVillage() {
			return village;
		}
		public void setVillage(String village) {
			this.village = village;
		}
		public String getPlot_no() {
			return plot_no;
		}
		public void setPlot_no(String plot_no) {
			this.plot_no = plot_no;
		}
		public String getKissam() {
			return kissam;
		}
		public void setKissam(String kissam) {
			this.kissam = kissam;
		}
		public Double getPlot_area_ac() {
			return plot_area_ac;
		}
		public void setPlot_area_ac(Double plot_area_ac) {
			this.plot_area_ac = plot_area_ac;
		}
		public String getForest_type() {
			return forest_type;
		}
		public void setForest_type(String forest_type) {
			this.forest_type = forest_type;
		}
		public String getGeom() {
			return geom;
		}
		public void setGeom(String geom) {
			this.geom = geom;
		}
		public Double getPlot_area_actual() {
			return plot_area_actual;
		}
		public void setPlot_area_actual(Double plot_area_actual) {
			this.plot_area_actual = plot_area_actual;
		}
		
}
