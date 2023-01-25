package com.sparc.flidss.model.common;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;



@Entity
@Table(name="position_master")
@NamedQuery(name="PositionMaster.findAll", query="SELECT m FROM PositionMaster m")
public class PositionMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="int_id")
	private Integer intId;
	
	@Column(name="chrv_position_nm")
	private String chrvPositionNm;
	
	//bi-directional many-to-one association to MDesination
		@ManyToOne(optional=false)
		@JoinColumn(name="int_fk_role_id")
		private RoleMaster RoleMaster;

	public Integer getIntId() {
		return intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	/*
	 * public Integer getintFkRoleId() { 
	 * return intFkRoleId;
	 *  }
	 * 
	 * public void setintFkRoleId(Integer intFkRoleId) { this.intFkRoleId =
	 * intFkRoleId; }
	 */
	public String getChrvPositionNm() {
		return chrvPositionNm;
	}

	public void setChrvPositionNm(String chrvPositionNm) {
		this.chrvPositionNm = chrvPositionNm;
	}

	public RoleMaster getRoleMaster() {
		return this.RoleMaster;
	}

	public void setRoleMaster(RoleMaster RoleMaster) {
		this.RoleMaster = RoleMaster;
		
	}

	/*
	 * @Override public String toString() { return "PositionMaster [intId=" + intId
	 * + ", chrvPositionNm=" + chrvPositionNm + ", roleMaster=" + roleMaster + "]";
	 * }
	 */


	
}
