package com.sparc.flidss.viewmodel;

import java.util.List;

import com.sparc.flidss.model.common.NfbDetail;
import com.sparc.flidss.model.common.NfbMaster;
import com.sparc.flidss.model.common.RangeMaster;

public class ForestLandDetailsViewModel {
	private NfbMaster nfbMaster;
	private NfbDetail nfbDetail;
	private RangeMaster rangeMaster;
	private List <NfbMaster> nfbMasterList;
	private List <NfbDetail> nfbDetailList;
	public NfbMaster getNfbMaster() {
		return nfbMaster;
	}
	public void setNfbMaster(NfbMaster nfbMaster) {
		this.nfbMaster = nfbMaster;
	}
	public NfbDetail getNfbDetail() {
		return nfbDetail;
	}
	public void setNfbDetail(NfbDetail nfbDetail) {
		this.nfbDetail = nfbDetail;
	}
	public List<NfbMaster> getNfbMasterList() {
		return nfbMasterList;
	}
	public void setNfbMasterList(List<NfbMaster> nfbMasterList) {
		this.nfbMasterList = nfbMasterList;
	}
	public List<NfbDetail> getNfbDetailList() {
		return nfbDetailList;
	}
	public void setNfbDetailList(List<NfbDetail> nfbDetailList) {
		this.nfbDetailList = nfbDetailList;
	}
	public RangeMaster getRangeMaster() {
		return rangeMaster;
	}
	public void setRangeMaster(RangeMaster rangeMaster) {
		this.rangeMaster = rangeMaster;
	}
	
}
