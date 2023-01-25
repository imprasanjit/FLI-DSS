package com.sparc.flidss.viewmodel;

import javax.persistence.*;

import org.hibernate.annotations.Immutable;

@Entity
@Immutable 
@Table(name = "SP_NFBViewModel")
public class SP_NFBViewModel {
	@Id
	private Integer row_num;
	private Integer fb_id;
	private Integer div_id;
	

	private String range_code;
	 private String fb_name;
	 @Column
    private String fb_type;
	 @Column
    private String range_name;
	 @Column
    private String division_name;
	 @Column
    private String district_name;
	 @Column
    private Double area_ha;
	 @Column
    private Double area_sqkm;
	 @Column
    private Double perimeter;
	 @Column
    private String geom;
	 @Column
	 private String surveytype;
	 @Column
	 private String colorcode;
	 @Column
	 private Integer colortag;
	 @Column
	 private Double nfa_ha;
	 
	 
	 
	public Integer getRow_num() {
		return row_num;
	}

	public void setRow_num(Integer row_num) {
		this.row_num = row_num;
	}

	public Double getNfa_ha() {
		return nfa_ha;
	}

	public void setNfa_ha(Double nfa_ha) {
		this.nfa_ha = nfa_ha;
	}

	public SP_NFBViewModel() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Integer getColortag() {
		return colortag;
	}

	public void setColortag(Integer colortag) {
		this.colortag = colortag;
	}

	public Integer getFb_id() {
		return fb_id;
	}
	public void setFb_id(Integer fb_id) {
		this.fb_id = fb_id;
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

	public String getRange_name() {
		return range_name;
	}

	public void setRange_name(String range_name) {
		this.range_name = range_name;
	}

	public String getDivision_name() {
		return division_name;
	}

	public void setDivision_name(String division_name) {
		this.division_name = division_name;
	}

	public String getDistrict_name() {
		return district_name;
	}

	public void setDistrict_name(String district_name) {
		this.district_name = district_name;
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

	public Double getPerimeter() {
		return perimeter;
	}

	public void setPerimeter(Double perimeter) {
		this.perimeter = perimeter;
	}

	public String getGeom() {
		return geom;
	}

	public void setGeom(String geom) {
		this.geom = geom;
	}

	public String getSurveytype() {
		return surveytype;
	}

	public void setSurveytype(String surveytype) {
		this.surveytype = surveytype;
	}

	public String getColorcode() {
		return colorcode;
	}

	public void setColorcode(String colorcode) {
		this.colorcode = colorcode;
	}
	
}
