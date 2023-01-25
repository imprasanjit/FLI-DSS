package com.sparc.flidss.model.common;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name="raster_master_layer_type")
@NamedQuery(name="RasterMasterLayerType.findAll", query="SELECT r FROM RasterMasterLayerType r")
public class RasterMasterLayerType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_type")
	private String chrvType;

	/*
	 * //bi-directional many-to-one association to RasterMasterData
	 * 
	 * @OneToMany(mappedBy="rasterMasterLayerType") private List<RasterMasterData>
	 * rasterMasterData;
	 */
	
	public RasterMasterLayerType() {
		
	}

	public Integer getIntId() {
		return intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvType() {
		return chrvType;
	}

	public void setChrvType(String chrvType) {
		this.chrvType = chrvType;
	}

	/*
	 * public List<RasterMasterData> getRasterMasterData() { return
	 * rasterMasterData; }
	 * 
	 * public void setRasterMasterData(List<RasterMasterData> rasterMasterData) {
	 * this.rasterMasterData = rasterMasterData; } public RasterMasterData
	 * addRaterMasterData(RasterMasterData rasterMasterData) {
	 * getRasterMasterData().add(rasterMasterData);
	 * rasterMasterData.setRasterMasterLayerType(this); return rasterMasterData; }
	 * 
	 * public RasterMasterData removeRasterMasterData(RasterMasterData
	 * rasterMasterData) { getRasterMasterData().remove(rasterMasterData);
	 * rasterMasterData.setRasterMasterLayerType(this); return rasterMasterData; }
	 */
}

