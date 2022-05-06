package com.sparc.flidss.model.common;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="users_roles")
public class UsersRole {
	
	
	@Id
	@Column(name="id")
	private int id;
	
	@Column(name= "user_id")
	private Integer userId;
	
	@Column(name="role_id")
	private Integer positionId;

	public UsersRole() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UsersRole(int id, Integer userId, Integer positionId) {
		super();
		this.id = id;
		this.userId = userId;
		this.positionId = positionId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getPositionId() {
		return positionId;
	}

	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}

	@Override
	public String toString() {
		return "UsersRole [id=" + id + ", userId=" + userId + ", positionId=" + positionId + "]";
	}

	
	

}
