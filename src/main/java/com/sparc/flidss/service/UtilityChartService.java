package com.sparc.flidss.service;

import java.util.List;
import java.util.Set;

import com.sparc.flidss.utility.chart.Series;

public interface UtilityChartService {

	List<Series> stackedDrilldownChild();

	List<Series> stackedDrilldownParent();

	List<Series> stackedDrilldownParent(Set<Integer> phase);
	List<Series> stackedDrilldownChild(Set<Integer> phase);

	/**
	 * Start of District Level Chart (Show all Division under a particular District)
	 */
	List<Series> stackedDrilldownDivision(Set<Integer> phase, Set<Integer> divid);

	List<Series> stackedDrilldownChildRange(Set<Integer> phase,Set<Integer> divid);
	
	

}
