package com.sparc.flidss.utility;

/**
 * Bind Select List
 * @author Thakur
 *
 */
public class ValueText {
private Integer value;
private String strValue;
private String text;
private Boolean isChecked;
private Boolean isNumeric=false;
public ValueText() {
	// TODO Auto-generated constructor stub
}

public ValueText(Integer value, String text) {
	this.value=value;
	this.text=text;
}

public ValueText(String value, String text) {
	this.strValue=value;
	this.text=text;
}
public ValueText(String value, String text,Boolean isChecked) {
	this.strValue=value;
	this.text=text;
	this.isChecked=isChecked;
}
public ValueText(String value, String text,Boolean isChecked, Boolean isNumeric) {
	this.strValue=value;
	this.text=text;
	this.isChecked=isChecked;
	this.isNumeric=isNumeric;
}

public ValueText(Integer value, String glink,String layer) {
	this.value=value;
	this.strValue=glink;
	this.text=layer;
}



public Integer getValue() {
	return value;
}

public void setValue(Integer value) {
	this.value = value;
}

public String getStrValue() {
	return strValue;
}

public void setStrValue(String strValue) {
	this.strValue = strValue;
}

public String getText() {
	return text;
}

public void setText(String text) {
	this.text = text;
}

public Boolean getIsChecked() {
	return isChecked;
}

public void setIsChecked(Boolean isChecked) {
	this.isChecked = isChecked;
}

public Boolean getIsNumeric() {
	return isNumeric;
}

public void setIsNumeric(Boolean isNumeric) {
	this.isNumeric = isNumeric;
}

}
