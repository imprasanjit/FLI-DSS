package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the data_catalogue_master database table.
 * 
 */
@Entity
@Table(name="data_catalogue_master")
@NamedQuery(name="DataCatalogueMaster.findAll", query="SELECT d FROM DataCatalogueMaster d")
public class DataCatalogueMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="tms_publish_date")
	private Timestamp tmsPublishDate;

	@Column(name="tms_updated_date")
	private Timestamp tmsUpdatedDate;

	//bi-directional many-to-one association to DatasetMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_dataset")
	private DatasetMaster datasetMaster;

	//bi-directional many-to-one association to DatasetTag
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_dataset_tag")
	private DatasetTag datasetTag;

	//bi-directional many-to-one association to DivisionMaster
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="int_fk_division")
	private DivisionMaster divisionMaster;

	public DataCatalogueMaster() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public Timestamp getTmsPublishDate() {
		return this.tmsPublishDate;
	}

	public void setTmsPublishDate(Timestamp tmsPublishDate) {
		this.tmsPublishDate = tmsPublishDate;
	}

	public Timestamp getTmsUpdatedDate() {
		return this.tmsUpdatedDate;
	}

	public void setTmsUpdatedDate(Timestamp tmsUpdatedDate) {
		this.tmsUpdatedDate = tmsUpdatedDate;
	}

	public DatasetMaster getDatasetMaster() {
		return this.datasetMaster;
	}

	public void setDatasetMaster(DatasetMaster datasetMaster) {
		this.datasetMaster = datasetMaster;
	}

	public DatasetTag getDatasetTag() {
		return this.datasetTag;
	}

	public void setDatasetTag(DatasetTag datasetTag) {
		this.datasetTag = datasetTag;
	}

	public DivisionMaster getDivisionMaster() {
		return this.divisionMaster;
	}

	public void setDivisionMaster(DivisionMaster divisionMaster) {
		this.divisionMaster = divisionMaster;
	}

}