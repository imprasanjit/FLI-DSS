package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the dataset_master database table.
 * 
 */
@Entity
@Table(name="dataset_master")
@NamedQuery(name="DatasetMaster.findAll", query="SELECT d FROM DatasetMaster d")
public class DatasetMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_dataset_nm")
	private String chrvDatasetNm;

	/*
	 * //bi-directional many-to-one association to DataCatalogueMaster
	 * 
	 * @OneToMany(mappedBy="datasetMaster") private List<DataCatalogueMaster>
	 * dataCatalogueMasters;
	 * 
	 * //bi-directional many-to-one association to DatasetTag
	 * 
	 * @OneToMany(mappedBy="datasetMaster") private List<DatasetTag> datasetTags;
	 */

	public DatasetMaster() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvDatasetNm() {
		return this.chrvDatasetNm;
	}

	public void setChrvDatasetNm(String chrvDatasetNm) {
		this.chrvDatasetNm = chrvDatasetNm;
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
	 * dataCatalogueMaster.setDatasetMaster(this);
	 * 
	 * return dataCatalogueMaster; }
	 * 
	 * public DataCatalogueMaster removeDataCatalogueMaster(DataCatalogueMaster
	 * dataCatalogueMaster) { getDataCatalogueMasters().remove(dataCatalogueMaster);
	 * dataCatalogueMaster.setDatasetMaster(null);
	 * 
	 * return dataCatalogueMaster; }
	 * 
	 * public List<DatasetTag> getDatasetTags() { return this.datasetTags; }
	 * 
	 * public void setDatasetTags(List<DatasetTag> datasetTags) { this.datasetTags =
	 * datasetTags; }
	 * 
	 * public DatasetTag addDatasetTag(DatasetTag datasetTag) {
	 * getDatasetTags().add(datasetTag); datasetTag.setDatasetMaster(this);
	 * 
	 * return datasetTag; }
	 * 
	 * public DatasetTag removeDatasetTag(DatasetTag datasetTag) {
	 * getDatasetTags().remove(datasetTag); datasetTag.setDatasetMaster(null);
	 * 
	 * return datasetTag; }
	 */
}