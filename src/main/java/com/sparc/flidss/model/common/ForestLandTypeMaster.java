package com.sparc.flidss.model.common;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;




@Entity
@Table(name="forest_land_type_master")
@NamedQuery(name="ForestLandTypeMaster.findAll", query="SELECT m FROM ForestLandTypeMaster m")
public class ForestLandTypeMaster implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="int_id")
	private Integer IntId;
	
	@Column(name="chrv_fb_land_type")
	private String chrvFbLandType;
	@Column(name="seq_no")
	private Integer SeqNo;

	public Integer getIntId() {
		return IntId;
	}

	public void setIntId(Integer intId) {
		IntId = intId;
	}

	public String getChrvFbLandType() {
		return chrvFbLandType;
	}

	public void setChrvFbLandType(String chrvFbLandType) {
		this.chrvFbLandType = chrvFbLandType;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Integer getSeqNo() {
		return SeqNo;
	}

	public void setSeqNo(Integer seqNo) {
		SeqNo = seqNo;
	}
	
}
