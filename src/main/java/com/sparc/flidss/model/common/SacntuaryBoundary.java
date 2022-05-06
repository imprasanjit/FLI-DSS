package com.sparc.flidss.model.common;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import org.springframework.data.geo.Polygon;

import com.fasterxml.jackson.annotation.JsonSubTypes.Type;

@Entity
@Table(name="sanctuary_boundary")
public class SacntuaryBoundary implements Serializable {
	private static final long serialVersionUID = 1L; 
	
	@Id
	@Column(name="gid")
	Integer gid;
	@Column(name="id")
	Double id;
	@Column(name="int_fk_division")
	Integer intFkDivision;
	@Column(name="sanc_code")
	String sancCode;
	@Column(name="sanc_name")
	String sancName;
	@Column(name="noti_no")
	String notiNo;
	@Column(name="noti_date")
	String notiDate;
	@Column(name="area_sqkm")
	Double areaSqkm;
	@Column(name="area_ha")
	Double areaHa;
	//@org.hibernate.annotations.Type(type = "org.hibernate.spatial.GeometryType")
	@Column(name="geom")
	String geom;
	
	
	public SacntuaryBoundary() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Integer getGid() {
		return gid;
	}


	public void setGid(Integer gid) {
		this.gid = gid;
	}


	public Double getId() {
		return id;
	}


	public void setId(Double id) {
		this.id = id;
	}


	public Integer getIntFkDivision() {
		return intFkDivision;
	}


	public void setIntFkDivision(Integer intFkDivision) {
		this.intFkDivision = intFkDivision;
	}


	public String getSancCode() {
		return sancCode;
	}


	public void setSancCode(String sancCode) {
		this.sancCode = sancCode;
	}


	public String getSancName() {
		return sancName;
	}


	public void setSancName(String sancName) {
		this.sancName = sancName;
	}


	public String getNotiNo() {
		return notiNo;
	}


	public void setNotiNo(String notiNo) {
		this.notiNo = notiNo;
	}


	public String getNotiDate() {
		return notiDate;
	}


	public void setNotiDate(String notiDate) {
		this.notiDate = notiDate;
	}


	public Double getAreaSqkm() {
		return areaSqkm;
	}


	public void setAreaSqkm(Double areaSqkm) {
		this.areaSqkm = areaSqkm;
	}


	public Double getAreaHa() {
		return areaHa;
	}


	public void setAreaHa(Double areaHa) {
		this.areaHa = areaHa;
	}


	
	  public String getGeom() { return geom; }
	  
	  
	  public void setGeom(String geom) { this.geom = geom; }
	 
	

}
