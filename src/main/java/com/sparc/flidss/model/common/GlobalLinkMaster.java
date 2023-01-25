package com.sparc.flidss.model.common;
import java.beans.Transient;
import java.io.Serializable;
import javax.persistence.*;

import org.hibernate.annotations.AccessType;
import org.springframework.data.annotation.AccessType.Type;

import java.sql.Timestamp;
import java.util.List;

/**
 * The persistent class for the global_link_master database table.
 * 
 */
@Entity
@Table(name="global_link_master")
//@NamedQuery(name="GlobalLinkMaster.findAll", query="SELECT m FROM GlobalLinkMaster m")
public class GlobalLinkMaster implements Serializable {
		private static final long serialVersionUID = 1L;

		@Id
		@Column(name="int_glink_id")
		private Integer intGlinkId;

		@Column(name="chrv_desc")
		private String chrvDesc;

		@Column(name="chrv_glink_name")
		private String chrvGlinkName;

		@Column(name="chrv_ip_address")
		private String chrvIpAddress;

		@Column(name="int_active_sts")
		private Integer intActiveSts;

		@Column(name="int_priority_odr")
		private Integer intPriorityOdr;

		@Column(name="tms_created_on")
		private Timestamp tmsCreatedOn;

		@Column(name="tms_updated_on")
		private Timestamp tmsUpdatedOn;
		
		@Column(name="linkstyle")
		private String linkStyle;
		
		@Column(name="chrv_glink_url")
		private String chrvGlinkUrl;
		
		/*
		 * @org.springframework.data.annotation.AccessType(Type.PROPERTY)
		 * 
		 * @javax.persistence.Transient private boolean isChecked; public boolean
		 * isChecked() { return isChecked; }
		 * 
		 * public void setChecked(boolean isChecked) { this.isChecked = isChecked; }
		 */

		/*
		 * //bi-directional many-to-one association to MPrimaryLink
		 * 
		 * @OneToMany(mappedBy="MGlobalLink") private List<MPrimaryLink> MPrimaryLinks;
		 * 
		 * //bi-directional many-to-one association to MSetPermission
		 * 
		 * @OneToMany(mappedBy="MGlobalLink") private List<MSetPermission>
		 * MSetPermissions;
		 * 
		 * //bi-directional many-to-one association to TUserWiseIssueTracker
		 * 
		 * @OneToMany(mappedBy="MGlobalLink") private List<TUserWiseIssueTracker>
		 * TUserWiseIssueTrackers;
		 */

		

		public GlobalLinkMaster() {
		}

		public Integer getIntGlinkId() {
			return this.intGlinkId;
		}

		public void setIntGlinkId(Integer intGlinkId) {
			this.intGlinkId = intGlinkId;
		}

		public String getChrvDesc() {
			return this.chrvDesc;
		}

		public void setChrvDesc(String chrvDesc) {
			this.chrvDesc = chrvDesc;
		}

		public String getChrvGlinkName() {
			return this.chrvGlinkName;
		}

		public void setChrvGlinkName(String chrvGlinkName) {
			this.chrvGlinkName = chrvGlinkName;
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

		public String getLinkStyle() {
			return linkStyle;
		}

		public void setLinkStyle(String linkStyle) {
			this.linkStyle = linkStyle;
		}

		public String getChrvGlinkUrl() {
			return chrvGlinkUrl;
		}

		public void setChrvGlinkUrl(String chrvGlinkUrl) {
			this.chrvGlinkUrl = chrvGlinkUrl;
		}

		@Override
		public String toString() {
			return "GlobalLinkMaster [intGlinkId=" + intGlinkId + ", chrvDesc=" + chrvDesc + ", chrvGlinkName="
					+ chrvGlinkName + ", chrvIpAddress=" + chrvIpAddress + ", intActiveSts=" + intActiveSts
					+ ", intPriorityOdr=" + intPriorityOdr + ", tmsCreatedOn=" + tmsCreatedOn + ", tmsUpdatedOn="
					+ tmsUpdatedOn + ", linkStyle=" + linkStyle + ", chrvGlinkUrl=" + chrvGlinkUrl + "]";
		}
		

		/*
		 * public List<MPrimaryLink> getMPrimaryLinks() { return this.MPrimaryLinks; }
		 * 
		 * public void setMPrimaryLinks(List<MPrimaryLink> MPrimaryLinks) {
		 * this.MPrimaryLinks = MPrimaryLinks; }
		 */

		/*
		 * public MPrimaryLink addMPrimaryLink(MPrimaryLink MPrimaryLink) {
		 * getMPrimaryLinks().add(MPrimaryLink); MPrimaryLink.setMGlobalLink(this);
		 * 
		 * return MPrimaryLink; }
		 */

		/*
		 * public MPrimaryLink removeMPrimaryLink(MPrimaryLink MPrimaryLink) {
		 * getMPrimaryLinks().remove(MPrimaryLink); MPrimaryLink.setMGlobalLink(null);
		 * 
		 * return MPrimaryLink; }
		 */

		/*
		 * public List<MSetPermission> getMSetPermissions() { return
		 * this.MSetPermissions; }
		 * 
		 * public void setMSetPermissions(List<MSetPermission> MSetPermissions) {
		 * this.MSetPermissions = MSetPermissions; }
		 */

		/*
		 * public MSetPermission addMSetPermission(MSetPermission MSetPermission) {
		 * getMSetPermissions().add(MSetPermission);
		 * MSetPermission.setMGlobalLink(this);
		 * 
		 * return MSetPermission; }
		 * 
		 * public MSetPermission removeMSetPermission(MSetPermission MSetPermission) {
		 * getMSetPermissions().remove(MSetPermission);
		 * MSetPermission.setMGlobalLink(null);
		 * 
		 * return MSetPermission; }
		 */

		/*
		 * public List<TUserWiseIssueTracker> getTUserWiseIssueTrackers() { return
		 * this.TUserWiseIssueTrackers; }
		 * 
		 * public void setTUserWiseIssueTrackers(List<TUserWiseIssueTracker>
		 * TUserWiseIssueTrackers) { this.TUserWiseIssueTrackers =
		 * TUserWiseIssueTrackers; }
		 */

		/*
		 * public TUserWiseIssueTracker addTUserWiseIssueTracker(TUserWiseIssueTracker
		 * TUserWiseIssueTracker) {
		 * getTUserWiseIssueTrackers().add(TUserWiseIssueTracker);
		 * TUserWiseIssueTracker.setMGlobalLink(this);
		 * 
		 * return TUserWiseIssueTracker; }
		 * 
		 * public TUserWiseIssueTracker
		 * removeTUserWiseIssueTracker(TUserWiseIssueTracker TUserWiseIssueTracker) {
		 * getTUserWiseIssueTrackers().remove(TUserWiseIssueTracker);
		 * TUserWiseIssueTracker.setMGlobalLink(null);
		 * 
		 * return TUserWiseIssueTracker; }
		 */

	}

