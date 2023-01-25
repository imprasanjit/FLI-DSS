package com.sparc.flidss.viewmodel;

import java.util.List;

import com.sparc.flidss.model.common.DatasetMaster;
import com.sparc.flidss.model.common.DatasetTag;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.utility.ValueText;

public class DataCatalougeViewModel {

	public DataCatalougeViewModel() {
		
	}
	public DataCatalougeViewModel(DatasetMaster datasetMaster, DatasetTag datasetTag) {
		super();
		this.datasetMaster = datasetMaster;
		this.datasetTag = datasetTag;
	}



	public DataCatalougeViewModel(DatasetMaster datasetMaster, DatasetTag datasetTag,
			List<DatasetMaster> datasetMasterList, List<DatasetTag> datasetTagList,
			List<ValueText> datasetMasterValueText, List<ValueText> datasetTagListValueText) {
		super();
		this.datasetMaster = datasetMaster;
		this.datasetTag = datasetTag;
		this.datasetMasterList = datasetMasterList;
		this.datasetTagList = datasetTagList;
		this.datasetMasterValueText = datasetMasterValueText;
		this.datasetTagValueText = datasetTagListValueText;
	}

	public DataCatalougeViewModel(List<ValueText> datasetMasterValueText, List<ValueText> datasetTagValueText) {
		super();
		this.datasetMasterValueText = datasetMasterValueText;
		this.datasetTagValueText = datasetTagValueText;
	}


	public DatasetMaster datasetMaster;
	public DatasetTag datasetTag;
	public List<DatasetMaster> datasetMasterList;
	public List<DatasetTag> datasetTagList;
	
	public List<ValueText> datasetMasterValueText;
	public List<ValueText> datasetTagValueText;
	public List<ValueText> divisionValueText;
	
	public DatasetMaster getDatasetMaster() {
		return datasetMaster;
	}
	public void setDatasetMaster(DatasetMaster datasetMaster) {
		this.datasetMaster = datasetMaster;
	}
	public DatasetTag getDatasetTag() {
		return datasetTag;
	}
	public void setDatasetTag(DatasetTag datasetTag) {
		this.datasetTag = datasetTag;
	}
	public List<DatasetMaster> getDatasetMasterList() {
		return datasetMasterList;
	}
	public void setDatasetMasterList(List<DatasetMaster> datasetMasterList) {
		this.datasetMasterList = datasetMasterList;
	}
	public List<DatasetTag> getDatasetTagList() {
		return datasetTagList;
	}
	public void setDatasetTagList(List<DatasetTag> datasetTagList) {
		this.datasetTagList = datasetTagList;
	}
	public List<ValueText> getDatasetMasterValueText() {
		return datasetMasterValueText;
	}
	public void setDatasetMasterValueText(List<ValueText> datasetMasterValueText) {
		this.datasetMasterValueText = datasetMasterValueText;
	}
	public List<ValueText> getDatasetTagValueText() {
		return datasetTagValueText;
	}
	public void setDatasetTagValueText(List<ValueText> datasetTagListValueText) {
		this.datasetTagValueText = datasetTagListValueText;
	}
	public List<ValueText> getDivisionValueText() {
		return divisionValueText;
	}
	public void setDivisionValueText(List<ValueText> divisionValueText) {
		this.divisionValueText = divisionValueText;
	}
	
	
	
}
