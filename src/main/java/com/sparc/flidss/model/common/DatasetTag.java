package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the dataset_tags database table.
 * 
 */
@Entity
@Table(name="dataset_tags")
@NamedQuery(name="DatasetTag.findAll", query="SELECT d FROM DatasetTag d")
public class DatasetTag implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_dataset_type")
	private String chrvDatasetType;

	@Column(name="chrv_desc")
	private String chrvDesc;

	@Column(name="chrv_scale")
	private Integer chrvScale;

	@Column(name="chrv_source")
	private String chrvSource;

	@Column(name="chrv_tag_nm")
	private String chrvTagNm;

	@Column(name="layer_name")
	private String layerName;

	/*
	 * //bi-directional many-to-one association to DataCatalogueMaster
	 * 
	 * @OneToMany(mappedBy="datasetTag") private List<DataCatalogueMaster>
	 * dataCatalogueMasters;
	 */
	//bi-directional many-to-one association to DatasetMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_dataset")
	private DatasetMaster datasetMaster;

	public DatasetTag() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvDatasetType() {
		return this.chrvDatasetType;
	}

	public void setChrvDatasetType(String chrvDatasetType) {
		this.chrvDatasetType = chrvDatasetType;
	}

	public String getChrvDesc() {
		return this.chrvDesc;
	}

	public void setChrvDesc(String chrvDesc) {
		this.chrvDesc = chrvDesc;
	}

	public Integer getChrvScale() {
		return this.chrvScale;
	}

	public void setChrvScale(Integer chrvScale) {
		this.chrvScale = chrvScale;
	}

	public String getChrvSource() {
		return this.chrvSource;
	}

	public void setChrvSource(String chrvSource) {
		this.chrvSource = chrvSource;
	}

	public String getChrvTagNm() {
		return this.chrvTagNm;
	}

	public void setChrvTagNm(String chrvTagNm) {
		this.chrvTagNm = chrvTagNm;
	}

	public String getLayerName() {
		return this.layerName;
	}

	public void setLayerName(String layerName) {
		this.layerName = layerName;
	}

	/*
	 * public List<DataCatalogueMaster> getDataCatalogueMasters() { return
	 * this.dataCatalogueMasters; }
	 * 
	 * public void setDataCatalogueMasters(List<DataCatalogueMaster>
	 * dataCatalogueMasters) { this.dataCatalogueMasters = dataCatalogueMasters; }
	 * 
	 * public DataCatalogueMaster addDataCatalogueMaster(DataCatalogueMaster
	 * dataCatalogueMaster) { getDataCatalogueMasters().add(dataCatalogueMaster);
	 * dataCatalogueMaster.setDatasetTag(this);
	 * 
	 * return dataCatalogueMaster; }
	 * 
	 * public DataCatalogueMaster removeDataCatalogueMaster(DataCatalogueMaster
	 * dataCatalogueMaster) { getDataCatalogueMasters().remove(dataCatalogueMaster);
	 * dataCatalogueMaster.setDatasetTag(null);
	 * 
	 * return dataCatalogueMaster; }
	 */
	public DatasetMaster getDatasetMaster() {
		return this.datasetMaster;
	}

	public void setDatasetMaster(DatasetMaster datasetMaster) {
		this.datasetMaster = datasetMaster;
	}

}