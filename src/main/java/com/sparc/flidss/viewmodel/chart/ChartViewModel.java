package com.sparc.flidss.viewmodel.chart;

import java.util.List;

import com.sparc.flidss.model.common.CircleMaster;

public class ChartViewModel {
	
private List<ChartSeries> series;
private List<String> circle;

public List<ChartSeries> getSeries() {
	return series;
}

public void setSeries(List<ChartSeries> series) {
	this.series = series;
}

public List<String> getCircle() {
	return circle;
}

public void setCircle(List<String> circle) {
	this.circle = circle;
}



}