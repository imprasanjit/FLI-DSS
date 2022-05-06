package com.sparc.flidss.service;

import java.util.List;
import java.util.Set;

import com.sparc.flidss.viewmodel.IGrflProgressCircleWise;
import com.sparc.flidss.viewmodel.IGrflProgressDivisionWise;
import com.sparc.flidss.viewmodel.IGrflProgressRangeWise;

public interface DashboardService {

	List<IGrflProgressCircleWise> GetGrflProgressCircleWise();

	List<IGrflProgressDivisionWise> GetGrflProgressDivisionWise();
	List<IGrflProgressDivisionWise> GetGrflProgressDivisionWise(Set<Integer> phase);
	//List<IGrflProgressDivisionWise> GetGrflProgressDivisionWise(Set<Integer> phase,Set<Integer> divid);
	
	List<IGrflProgressRangeWise> GetGrflProgressRangeWise();

	List<IGrflProgressCircleWise> GetGrflProgressCircleWise(Set<Integer> phase);

}
