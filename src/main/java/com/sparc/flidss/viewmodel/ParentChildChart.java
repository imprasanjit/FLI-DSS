package com.sparc.flidss.viewmodel;

import java.util.List;

import com.sparc.flidss.utility.chart.Series;

public class ParentChildChart {

	List<Series> Parent;
	List<Series> child;

	public List<Series> getParent() {
		return Parent;
	}

	public void setParent(List<Series> parent) {
		Parent = parent;
	}

	public List<Series> getChild() {
		return child;
	}

	public void setChild(List<Series> child) {
		this.child = child;
	}

}
