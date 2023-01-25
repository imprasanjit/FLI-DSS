package com.sparc.flidss.service;

import java.util.List;

import com.sparc.flidss.viewmodel.IRecordedForestCaLand;

public interface RecordedForestCaLandService {

	List<IRecordedForestCaLand> getRecodedForestCaLandMaster();

	List<IRecordedForestCaLand> getRecodedForestCaLandDetails();
}
