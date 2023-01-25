package com.sparc.flidss.model.common;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * The persistent class for the vector_master_data database table.
 * 
 */
@Entity
@Table(name = "vector_master_data")
@NamedQuery(name = "VectorMasterData.findAll", query = "SELECT v FROM VectorMasterData v")
public class VectorMasterData implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name = "int_id")
	private Integer intId;

	@Column(name = "chrv_glink")
	private String chrvGlink;

	@Column(name = "chrv_str_layer_nm")
	private String chrvStrLayerNm;

	// bi-directional many-to-one association to CircleMaster

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_circle")
	@JsonIgnore
	private CircleMaster circleMaster;

	// bi-directional many-to-one association to DivisionMaster

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_division")
	@JsonIgnore
	private DivisionMaster divisionMaster;

	// bi-directional many-to-one association to NfbMaster

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_nfb")
	@JsonIgnore
	private NfbMaster nfbMaster;

	// bi-directional many-to-one association to RangeMaster

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "chrv_fk_range")
	@JsonIgnore
	private RangeMaster rangeMaster;

	// bi-directional many-to-one association to SchemaMaster

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_schema")
	@JsonIgnore
	private SchemaMaster schemaMaster;

	// bi-directional many-to-one association to VectorMasterLayerType

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_vector_master_layer_type")
	@JsonIgnore
	private VectorMasterLayerType vectorMasterLayerType;

	// bi-directional many-to-one association to TehsilMaster

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "int_fk_tehsil")
	@JsonIgnore
	private TehsilMaster tehsilMaster;
	@Column(name = "utm_zone")
	private Integer utmZone;

	public VectorMasterData() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvGlink() {
		return this.chrvGlink;
	}

	public void setChrvGlink(String chrvGlink) {
		this.chrvGlink = chrvGlink;
	}

	public String getChrvStrLayerNm() {
		return this.chrvStrLayerNm;
	}

	public void setChrvStrLayerNm(String chrvStrLayerNm) {
		this.chrvStrLayerNm = chrvStrLayerNm;
	}

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

	public NfbMaster getNfbMaster() {
		return this.nfbMaster;
	}

	public void setNfbMaster(NfbMaster nfbMaster) {
		this.nfbMaster = nfbMaster;
	}

	public RangeMaster getRangeMaster() {
		return this.rangeMaster;
	}

	public void setRangeMaster(RangeMaster rangeMaster) {
		this.rangeMaster = rangeMaster;
	}

	public SchemaMaster getSchemaMaster() {
		return this.schemaMaster;
	}

	public void setSchemaMaster(SchemaMaster schemaMaster) {
		this.schemaMaster = schemaMaster;
	}

	public VectorMasterLayerType getVectorMasterLayerType() {
		return this.vectorMasterLayerType;
	}

	public void setVectorMasterLayerType(VectorMasterLayerType vectorMasterLayerType) {
		this.vectorMasterLayerType = vectorMasterLayerType;
	}

	public TehsilMaster getTehsilMaster() {
		return this.tehsilMaster;
	}

	public void setTehsilMaster(TehsilMaster tehsilMaster) {
		this.tehsilMaster = tehsilMaster;
	}

	public Integer getUtmZone() {
		return utmZone;
	}

	public void setUtmZone(Integer utmZone) {
		this.utmZone = utmZone;
	}

}