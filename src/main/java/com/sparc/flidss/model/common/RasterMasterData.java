package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * The persistent class for the raster_master_data database table.
 * 
 */
@Entity
@Table(name="raster_master_data")
@NamedQuery(name="RasterMasterData.findAll", query="SELECT r FROM RasterMasterData r")
public class RasterMasterData implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_grid_nm")
	private String chrvGridNm;

	@Column(name="chrv_layer_nm")
	private String chrvLayerNm;

	@Column(name="chrv_link")
	private String chrvLink;

	/*
	 * @Column(name="int_fk_raster_master_layer_type") private Integer
	 * intFkRasterMasterLayerType;
	 */

	//bi-directional many-to-one association to CircleMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_circle")
	private CircleMaster circleMaster;

	//bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_division")
	private DivisionMaster divisionMaster;

	//bi-directional many-to-one association to RangeMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="chrv_fk_range")
	private RangeMaster rangeMaster;
	
	//bi-directional many-to-one association to VectorMasterLayerType

		@ManyToOne(fetch=FetchType.LAZY)
		@JoinColumn(name="int_fk_raster_master_layer_type")
		@JsonIgnore
		private RasterMasterLayerType rasterMasterLayerType;

	public RasterMasterData() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvGridNm() {
		return this.chrvGridNm;
	}

	public void setChrvGridNm(String chrvGridNm) {
		this.chrvGridNm = chrvGridNm;
	}

	public String getChrvLayerNm() {
		return this.chrvLayerNm;
	}

	public void setChrvLayerNm(String chrvLayerNm) {
		this.chrvLayerNm = chrvLayerNm;
	}

	public String getChrvLink() {
		return this.chrvLink;
	}

	public void setChrvLink(String chrvLink) {
		this.chrvLink = chrvLink;
	}

	/*
	 * public Integer getIntFkRasterMasterLayerType() { return
	 * this.intFkRasterMasterLayerType; }
	 * 
	 * public void setIntFkRasterMasterLayerType(Integer intFkRasterMasterLayerType)
	 * { this.intFkRasterMasterLayerType = intFkRasterMasterLayerType; }
	 */

	public CircleMaster getCircleMaster() {
		return this.circleMaster;
	}

	public void setCircleMaster(CircleMaster circleMaster) {
		this.circleMaster = circleMaster;
	}

	public DivisionMaster getDivisionMaster() {
		return this.divisionMaster;
	}

	public void setDivisionMaster(DivisionMaster divisionMaster) {
		this.divisionMaster = divisionMaster;
	}

	public RangeMaster getRangeMaster() {
		return this.rangeMaster;
	}

	public void setRangeMaster(RangeMaster rangeMaster) {
		this.rangeMaster = rangeMaster;
	}

	public RasterMasterLayerType getRasterMasterLayerType() {
		return rasterMasterLayerType;
	}

	public void setRasterMasterLayerType(RasterMasterLayerType rasterMasterLayerType) {
		this.rasterMasterLayerType = rasterMasterLayerType;
	}

}