package com.sparc.flidss.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sparc.flidss.repository.common.custom.IPartialRepository;
import com.sparc.flidss.service.DashboardService;
import com.sparc.flidss.viewmodel.IGrflProgressCircleWise;
import com.sparc.flidss.viewmodel.IGrflProgressDivisionWise;
import com.sparc.flidss.viewmodel.IGrflProgressRangeWise;

@Service
public class DashboardServiceImpl implements DashboardService {

	@Autowired
	IPartialRepository partialRepo;
	
	@Override
	public List<IGrflProgressCircleWise> GetGrflProgressCircleWise() {
		
		return partialRepo.getGrflProgressCircleWise();
	}
	
	@Override
	public List<IGrflProgressCircleWise> GetGrflProgressCircleWise(Set<Integer> phase) {
		
		return partialRepo.getGrflProgressCircleWise(phase);
	}
	
	@Override
	public List<IGrflProgressDivisionWise> GetGrflProgressDivisionWise() {
		
		return partialRepo.getGrflProgressDivisionWise();
	}
	
	@Override
	public List<IGrflProgressDivisionWise> GetGrflProgressDivisionWise(Set<Integer> phase) {
		
		return partialRepo.getGrflProgressDivisionWise(phase);
	}
	

	@Override
	public List<IGrflProgressRangeWise> GetGrflProgressRangeWise() {
		
		return partialRepo.getGrflProgressRangewise();
	}

}
