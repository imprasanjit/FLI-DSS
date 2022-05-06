package com.sparc.flidss.utility.chart;

import java.util.List;

public class Series{
    public String name;
    public String id;
    public List<Datum> data;
    public Boolean showInLegend;
    public Boolean enableMouseTracking;
    public String color;
    public DataLabels dataLabels;

    public Series() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Series(String name, String id, List<Datum> data, Boolean showInLegend, Boolean enableMouseTracking,
			String color, DataLabels dataLabels) {
		super();
		this.name = name;
		this.id = id;
		this.data = data;
		this.showInLegend = showInLegend;
		this.enableMouseTracking = enableMouseTracking;
		this.color = color;
		this.dataLabels = dataLabels;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public List<Datum> getData() {
		return data;
	}

	public void setData(List<Datum> data) {
		this.data = data;
	}

	public Object getShowInLegend() {
		return showInLegend;
	}

	public void setShowInLegend(Boolean showInLegend) {
		this.showInLegend = showInLegend;
	}

	public Boolean getEnableMouseTracking() {
		return enableMouseTracking;
	}

	public void setEnableMouseTracking(Boolean enableMouseTracking) {
		this.enableMouseTracking = enableMouseTracking;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public DataLabels getDataLabels() {
		return dataLabels;
	}

	public void setDataLabels(DataLabels dataLabels) {
		this.dataLabels = dataLabels;
	}

	
    
}



