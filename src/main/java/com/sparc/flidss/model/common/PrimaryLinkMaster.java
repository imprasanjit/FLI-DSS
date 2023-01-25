package com.sparc.flidss.model.common;



import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;


/**
 * The persistent class for the m_primary_link database table.
 * 
 */
@Entity
@Table(name="primary_link_master")
@NamedQuery(name="PrimaryLinkMaster.findAll", query="SELECT m FROM PrimaryLinkMaster m")
public class PrimaryLinkMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="int_plink_id")
	private Integer intPlinkId;

	@Column(name="chrv_desc")
	private String chrvDesc;

	@Column(name="chrv_ip_address")
	private String chrvIpAddress;

	@Column(name="chrv_plink_name")
	private String chrvPlinkName;

	@Column(name="chrv_plink_url")
	private String chrvPlinkUrl;

	@Column(name="int_active_sts")
	private Integer intActiveSts;

	@Column(name="int_priority_odr")
	private Integer intPriorityOdr;

	@Column(name="tms_created_on")
	private Timestamp tmsCreatedOn;

	@Column(name="tms_updated_on")
	private Timestamp tmsUpdatedOn;

	//bi-directional many-to-one association to GlobalLinkMaster
	@ManyToOne
	@JoinColumn(name="fk_int_glink_id")
	private GlobalLinkMaster globalLinkMaster;
	@Column(name="linkStyle")
	private String linkStyle;

	//bi-directional many-to-one association to MSetPermission
	/*
	 * @OneToMany(mappedBy="MPrimaryLink") private List<MSetPermission>
	 * MSetPermissions;
	 * 
	 * //bi-directional many-to-one association to TUserWiseIssueTracker
	 * 
	 * @OneToMany(mappedBy="MPrimaryLink") private List<TUserWiseIssueTracker>
	 * TUserWiseIssueTrackers;
	 */

	public PrimaryLinkMaster() {
	}

	public Integer getIntPlinkId() {
		return this.intPlinkId;
	}

	public void setIntPlinkId(Integer intPlinkId) {
		this.intPlinkId = intPlinkId;
	}

	public String getChrvDesc() {
		return this.chrvDesc;
	}

	public void setChrvDesc(String chrvDesc) {
		this.chrvDesc = chrvDesc;
	}

	public String getChrvIpAddress() {
		return this.chrvIpAddress;
	}

	public void setChrvIpAddress(String chrvIpAddress) {
		this.chrvIpAddress = chrvIpAddress;
	}

	public String getChrvPlinkName() {
		return this.chrvPlinkName;
	}

	public void setChrvPlinkName(String chrvPlinkName) {
		this.chrvPlinkName = chrvPlinkName;
	}

	public String getChrvPlinkUrl() {
		return this.chrvPlinkUrl;
	}

	public void setChrvPlinkUrl(String chrvPlinkUrl) {
		this.chrvPlinkUrl = chrvPlinkUrl;
	}

	public Integer getIntActiveSts() {
		return this.intActiveSts;
	}

	public void setIntActiveSts(Integer intActiveSts) {
		this.intActiveSts = intActiveSts;
	}

	public Integer getIntPriorityOdr() {
		return this.intPriorityOdr;
	}

	public void setIntPriorityOdr(Integer intPriorityOdr) {
		this.intPriorityOdr = intPriorityOdr;
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

	public GlobalLinkMaster getGlobalLinkMaster() {
		return this.globalLinkMaster;
	}

	public void setGlobalLinkMaster(GlobalLinkMaster globalLinkMaster) {
		this.globalLinkMaster = globalLinkMaster;
	}

	public String getLinkStyle() {
		return linkStyle;
	}

	public void setLinkStyle(String linkStyle) {
		this.linkStyle = linkStyle;
	}
	

}
