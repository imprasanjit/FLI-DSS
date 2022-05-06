package com.sparc.flidss.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sparc.flidss.repository.common.custom.IPartialRepository;
import com.sparc.flidss.service.RecordedForestCaLandService;
import com.sparc.flidss.viewmodel.IRecordedForestCaLand;

@Service
public class RecordedForestCaLandServiceImpl implements RecordedForestCaLandService {
	@Autowired
	IPartialRepository partialRepo;
	
	@Override
	public List<IRecordedForestCaLand> getRecodedForestCaLandMaster() {
		// TODO Auto-generated method stub
		
		return partialRepo.getRecodedForestCaLandMaster();
	}
	
	@Override
	public List<IRecordedForestCaLand> getRecodedForestCaLandDetails() {
		// TODO Auto-generated method stub
		
		return partialRepo.getRecodedForestCaLandDetails();
	}
	

}
