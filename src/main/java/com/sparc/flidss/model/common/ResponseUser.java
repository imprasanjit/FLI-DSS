package com.sparc.flidss.model.common;


public class ResponseUser {
	private int id;
	private String userName;
	private String userPosition;
	public ResponseUser() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ResponseUser(int id, String userName, String userPosition) {
		super();
		this.id = id;
		this.userName = userName;
		this.userPosition = userPosition;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPosition() {
		return userPosition;
	}
	public void setUserPosition(String userPosition) {
		this.userPosition = userPosition;
	}
	@Override
	public String toString() {
		return "ResponseUser [id=" + id + ", userName=" + userName + ", userPosition=" + userPosition + "]";
	}
	
}
