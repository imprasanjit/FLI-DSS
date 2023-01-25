package com.sparc.flidss.utility.chart;
public class Datum{
    public String name;
    public String no_of_fbs;
    public Double y;
    public String drilldown;

	public Datum() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Datum(String name,String no_of_fbs ,Double y, String drilldown) {
		super();
		this.name = name;
		this.no_of_fbs=no_of_fbs;
		this.y = y;
		this.drilldown = drilldown;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getNo_of_fbs() {
		return no_of_fbs;
	}

	public void setNo_of_fbs(String no_of_fbs) {
		this.no_of_fbs = no_of_fbs;
	}

	public Double getY() {
		return y;
	}
	public void setY(Double y) {
		this.y = y;
	}
	public String getDrilldown() {
		return drilldown;
	}
	public void setDrilldown(String drilldown) {
		this.drilldown = drilldown;
	}
    
}