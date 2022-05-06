package com.sparc.flidss.model.common;



import java.io.Serializable;
import javax.persistence.*;

import java.sql.Timestamp;


/**
 * The persistent class for the m_set_permission database table.
 * 
 */
@Entity
@Table(name="set_permission_master")
@NamedQuery(name="SetPermissionMaster.findAll", query="SELECT m FROM SetPermissionMaster m")
public class SetPermissionMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="int_permission_id")
	private Integer intPermissionId;

	@Column(name="chrv_ip_address")
	private String chrvIpAddress;

	@Column(name="int_active_sts")
	private Integer intActiveSts;

	@Column(name="tms_created_on")
	private Timestamp tmsCreatedOn;

	@Column(name="tms_updated_on")
	private Timestamp tmsUpdatedOn;

	//bi-directional many-to-one association to MDesination
	@ManyToOne
	@JoinColumn(name="fk_int_role_id")
	private RoleMaster RoleMaster;

	//bi-directional many-to-one association to MGlobalLink
	@ManyToOne
	@JoinColumn(name="fk_int_glink_id")
	private GlobalLinkMaster GlobalLinkMaster;

	//bi-directional many-to-one association to MPosition
	@ManyToOne
	@JoinColumn(name="fk_int_pos_id")
	private PositionMaster PositionMaster;

	//bi-directional many-to-one association to MPrimaryLink
	@ManyToOne
	@JoinColumn(name="fk_int_plink_id")
	private PrimaryLinkMaster PrimaryLinkMaster;

	//bi-directional many-to-one association to MPrivilege
	@ManyToOne
	@JoinColumn(name="fk_int_rw_id")
	private PrivilegeMaster PrivilegeMaster;

	public SetPermissionMaster() {
	}

	public Integer getIntPermissionId() {
		return this.intPermissionId;
	}

	public void setIntPermissionId(Integer intPermissionId) {
		this.intPermissionId = intPermissionId;
	}

	public String getChrvIpAddress() {
		return this.chrvIpAddress;
	}

	public void setChrvIpAddress(String chrvIpAddress) {
		this.chrvIpAddress = chrvIpAddress;
	}

	public Integer getIntActiveSts() {
		return this.intActiveSts;
	}

	public void setIntActiveSts(Integer intActiveSts) {
		this.intActiveSts = intActiveSts;
	}

	public Timestamp getTmsCreatedOn() {
		return this.tmsCreatedOn;
	}

	public void setTmsCreatedOn(Timestamp tmsCreatedOn) {
		this.tmsCreatedOn = tmsCreatedOn;
	}

	public Timestamp getTmsUpdatedOn() {
		return this.tmsUpdatedOn;
	}

	public void setTmsUpdatedOn(Timestamp tmsUpdatedOn) {
		this.tmsUpdatedOn = tmsUpdatedOn;
	}

	public RoleMaster getRoleMaster() {
		return RoleMaster;
	}

	public void setRoleMaster(RoleMaster roleMaster) {
		RoleMaster = roleMaster;
	}

	public GlobalLinkMaster getGlobalLinkMaster() {
		return GlobalLinkMaster;
	}

	public void setGlobalLinkMaster(GlobalLinkMaster globalLinkMaster) {
		GlobalLinkMaster = globalLinkMaster;
	}

	public PositionMaster getPositionMaster() {
		return PositionMaster;
	}

	public void setPositionMaster(PositionMaster positionMaster) {
		PositionMaster = positionMaster;
	}

	public PrimaryLinkMaster getPrimaryLinkMaster() {
		return PrimaryLinkMaster;
	}

	public void setPrimaryLinkMaster(PrimaryLinkMaster primaryLinkMaster) {
		PrimaryLinkMaster = primaryLinkMaster;
	}

	public PrivilegeMaster getPrivilegeMaster() {
		return PrivilegeMaster;
	}

	public void setPrivilegeMaster(PrivilegeMaster privilegeMaster) {
		PrivilegeMaster = privilegeMaster;
	}

	@Override
	public String toString() {
		return "SetPermissionMaster [intPermissionId=" + intPermissionId + ", chrvIpAddress=" + chrvIpAddress
				+ ", intActiveSts=" + intActiveSts + ", tmsCreatedOn=" + tmsCreatedOn + ", tmsUpdatedOn=" + tmsUpdatedOn
				+ ", RoleMaster=" + RoleMaster + ", GlobalLinkMaster=" + GlobalLinkMaster + ", PositionMaster="
				+ PositionMaster + ", PrimaryLinkMaster=" + PrimaryLinkMaster + ", PrivilegeMaster=" + PrivilegeMaster
				+ "]";
	}

	

}