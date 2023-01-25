package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the vector_master_layer_type database table.
 * 
 */
@Entity
@Table(name="vector_master_layer_type")
@NamedQuery(name="VectorMasterLayerType.findAll", query="SELECT v FROM VectorMasterLayerType v")
public class VectorMasterLayerType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="chrv_type")
	private String chrvType;

	//bi-directional many-to-one association to VectorMasterData
	@OneToMany(mappedBy="vectorMasterLayerType")
	private List<VectorMasterData> vectorMasterData;

	public VectorMasterLayerType() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvType() {
		return this.chrvType;
	}

	public void setChrvType(String chrvType) {
		this.chrvType = chrvType;
	}

	public List<VectorMasterData> getVectorMasterData() {
		return this.vectorMasterData;
	}

	public void setVectorMasterData(List<VectorMasterData> vectorMasterData) {
		this.vectorMasterData = vectorMasterData;
	}

	public VectorMasterData addVectorMasterData(VectorMasterData vectorMasterData) {
		getVectorMasterData().add(vectorMasterData);
		vectorMasterData.setVectorMasterLayerType(this);

		return vectorMasterData;
	}

	public VectorMasterData removeVectorMasterData(VectorMasterData vectorMasterData) {
		getVectorMasterData().remove(vectorMasterData);
		vectorMasterData.setVectorMasterLayerType(null);

		return vectorMasterData;
	}

}