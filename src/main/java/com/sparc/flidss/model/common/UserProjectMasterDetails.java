package com.sparc.flidss.model.common;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="user_project_master_details")
public class UserProjectMasterDetails {
	@Id
	@Column(name = "int_id")
	private Integer intId;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="fk_user_project_master")
	private UserProjectMaster userProjectMaster;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="fk_layers_master")
	private LayersMaster layers;
	
	
	private Timestamp doc= new Timestamp(System.currentTimeMillis());


	public Integer getIntId() {
		return intId;
	}


	public void setIntId(Integer intId) {
		this.intId = intId;
	}


	public UserProjectMaster getUserProjectMaster() {
		return userProjectMaster;
	}


	public void setUserProjectMaster(UserProjectMaster userProjectMaster) {
		this.userProjectMaster = userProjectMaster;
	}


	public LayersMaster getLayers() {
		return layers;
	}


	public void setLayers(LayersMaster layers) {
		this.layers = layers;
	}


	public Timestamp getDoc() {
		return doc;
	}


	public void setDoc(Timestamp doc) {
		this.doc = doc;
	}
	
	
}
