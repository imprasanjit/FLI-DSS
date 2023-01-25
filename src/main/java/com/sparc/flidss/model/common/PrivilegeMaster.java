package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the m_privilege database table.
 * 
 */
@Entity
@Table(name="privilege_master")
@NamedQuery(name="PrivilegeMaster.findAll", query="SELECT m FROM PrivilegeMaster m")
public class PrivilegeMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="pk_int_id")
	private Integer pkIntId;

	@Column(name="chrv_privilage")
	private String chrvPrivilage;

	@Column(name="int_rw_status")
	private Integer intRwStatus;

	//bi-directional many-to-one association to MSetPermission
	@OneToMany(mappedBy="PrivilegeMaster")
	private List<SetPermissionMaster> SetPermissionMaster;

	public PrivilegeMaster() {
	}

	public Integer getPkIntId() {
		return this.pkIntId;
	}

	public void setPkIntId(Integer pkIntId) {
		this.pkIntId = pkIntId;
	}

	public String getChrvPrivilage() {
		return this.chrvPrivilage;
	}

	public void setChrvPrivilage(String chrvPrivilage) {
		this.chrvPrivilage = chrvPrivilage;
	}

	public Integer getIntRwStatus() {
		return this.intRwStatus;
	}

	public void setIntRwStatus(Integer intRwStatus) {
		this.intRwStatus = intRwStatus;
	}

	public List<SetPermissionMaster> getSetPermissionMaster() {
		return SetPermissionMaster;
	}

	public void setSetPermissionMaster(List<SetPermissionMaster> setPermissionMaster) {
		SetPermissionMaster = setPermissionMaster;
	}

	public SetPermissionMaster addSetPermissionMaster(SetPermissionMaster SetPermissionMaster) {
		getSetPermissionMaster().add(SetPermissionMaster);
		SetPermissionMaster.setPrivilegeMaster(this);

		return SetPermissionMaster;
	}

	public SetPermissionMaster removeSetPermissionMaster(SetPermissionMaster SetPermissionMaster) {
		getSetPermissionMaster().remove(SetPermissionMaster);
		SetPermissionMaster.setPrivilegeMaster(null);

		return SetPermissionMaster;
	}

}
