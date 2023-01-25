package com.sparc.flidss.model.common;

import java.io.Serializable;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="auto_user_info_master")
//@NamedQuery(name="AutoUserInfoMaster.findAll", query="Select r from AutoUserInfoMaster r")

public class AutoUserInfoMaster implements Serializable {
	private static final long serialVersionUID=1L;

	
	@Id
	@Column(name="int_id")
	private Integer intId;
	
	@Column(name="chrv_name")
	private String chrvNm;
		
	@Column(name="chrv_user_id")
	private String chrvUserId;
	@JsonIgnore
	@Column(name="chrv_user_pwd")
	private String chrvUserPwd;
	
	@Column(name="chrv_email")
	private String chrvEmail;
	
	@Column(name="chrv_role")
	private String chrvRole;
	
	@Column(name="chrv_contact_no")
	private String chrvContactNo;
		
	@Column(name="int_user_sts")
	private Integer intUserSts;
	
	@Column(name="chrv_user_sign")
	private String chrvUserSign;

	//bi-directional many-to-one association to MDesination
			@ManyToOne(optional=false)
			@JoinColumn(name="int_fk_role")
			private RoleMaster roleMaster;

	//bi-directional many-to-one association to PositionMaster
			@ManyToOne(optional=false)
			@JoinColumn(name="int_fk_position")
			private PositionMaster positionMaster;
	//bi-directional many-to-one association to CircleMaster
			@ManyToOne(optional=false)
			@JoinColumn(name="int_fk_circle" ,nullable = true)
			private CircleMaster circleMaster;
	//bi-directional many-to-one association to DivisionMaster
			
			@ManyToOne(optional=false)
			@JoinColumn(name="int_fk_division" ,nullable = true)
			private DivisionMaster divisionMaster;
	//bi-directional many-to-one association to RangeMaster
			@ManyToOne(optional=false)
			@JoinColumn(name="chrv_fk_range" ,nullable = true)
			private RangeMaster rangeMaster;
	//bi-directional many-to-one association to DistrictMaster
			@ManyToOne(optional=false)
			@JoinColumn(name="int_fk_dist" ,nullable = true)
			private DistrictMaster districtMaster;
	//bi-directional many-to-one association to TehsilMaster
			@ManyToOne(optional=false)
			@JoinColumn(name="int_fk_tehsil" ,nullable = true)
			private TehsilMaster tehsilMaster;
			
			@Column(name="chrv_image",nullable = true)
		    private String profileImage;
			
			@Column(name ="chrv_address",nullable = true)
			private String chrvAddress;
			
			@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
		    @JoinTable(
		            name = "users_roles",
		            joinColumns = @JoinColumn(name = "user_id"),
		            inverseJoinColumns = @JoinColumn(name = "role_id")
		            )
		    private Set<PositionMaster> roles = new HashSet<>();			
			
			
	
	public Integer getIntId() {
		return intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public String getChrvNm() {
		return chrvNm;
	}

	public void setChrvNm(String chrvNm) {
		this.chrvNm = chrvNm;
	}
	

	public String getChrvUserId() {
		return chrvUserId;
	}

	public void setChrvUserId(String chrvUserId) {
		this.chrvUserId = chrvUserId;
	}

	public String getChrvUserPwd() {
		return chrvUserPwd;
	}

	public void setChrvUserPwd(String chrvUserPwd) {
		this.chrvUserPwd = chrvUserPwd;
	}

	public String getChrvEmail() {
		return chrvEmail;
	}

	public void setChrvEmail(String chrvEmail) {
		this.chrvEmail = chrvEmail;
	}

	public String getChrvRole() {
		return chrvRole;
	}

	public void setChrvRole(String chrvRole) {
		this.chrvRole = chrvRole;
	}

	public String getChrvContactNo() {
		return chrvContactNo;
	}

	public void setChrvContactNo(String chrvContactNo) {
		this.chrvContactNo = chrvContactNo;
	}
	
	public Integer getIntUserSts() {
		return intUserSts;
	}

	public void setIntUserSts(Integer intUserSts) {
		this.intUserSts = intUserSts;
	}

	public String getChrvUserSign() {
		return chrvUserSign;
	}

	public void setChrvUserSign(String chrvUserSign) {
		this.chrvUserSign = chrvUserSign;
	}

	public RoleMaster getRoleMaster() {
		return this. roleMaster;
	}

	public void setRoleMaster(RoleMaster roleMaster) {
		this.roleMaster = roleMaster;
	}

	

	public CircleMaster getCircleMaster() {
		return circleMaster;
	}

	public void setCircleMaster(CircleMaster circleMaster) {
		this.circleMaster = circleMaster;
	}

	public DivisionMaster getDivisionMaster() {
		return divisionMaster;
	}

	public void setDivisionMaster(DivisionMaster divisionMaster) {
		this.divisionMaster = divisionMaster;
	}

	public RangeMaster getRangeMaster() {
		return rangeMaster;
	}

	public void setRangeMaster(RangeMaster rangeMaster) {
		this.rangeMaster = rangeMaster;
	}

	public DistrictMaster getDistrictMaster() {
		return districtMaster;
	}

	public void setDistrictMaster(DistrictMaster districtMaster) {
		this.districtMaster = districtMaster;
	}

	public TehsilMaster getTehsilMaster() {
		return tehsilMaster;
	}

	public void setTehsilMaster(TehsilMaster tehsilMaster) {
		this.tehsilMaster = tehsilMaster;
	}
	

	public Set<PositionMaster> getRoles() {
		return roles;
	}

	public void setRoles(Set<PositionMaster> roles) {
		this.roles = roles;
	}
	
	

	@Override
	public String toString() {
		return "AutoUserInfoMaster [intId=" + intId + ", chrvNm=" + chrvNm + ", chrvUserId=" + chrvUserId
				+ ", chrvUserPwd=" + chrvUserPwd + ", chrvEmail=" + chrvEmail + ", chrvRole=" + chrvRole
				+ ", chrvContactNo=" + chrvContactNo + ", intUserSts=" + intUserSts + ", chrvUserSign=" + chrvUserSign
				+ ", roleMaster=" + roleMaster + ", positionMaster=" + positionMaster + ", circleMaster=" + circleMaster
				+ ", divisionMaster=" + divisionMaster + ", rangeMaster=" + rangeMaster + ", districtMaster="
				+ districtMaster + ", tehsilMaster=" + tehsilMaster + "]";
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getChrvAddress() {
		return chrvAddress;
	}

	public void setChrvAddress(String chrvAddress) {
		this.chrvAddress = chrvAddress;
	}

	public PositionMaster getPositionMaster() {
		return positionMaster;
	}

	public void setPositionMaster(PositionMaster positionMaster) {
		this.positionMaster = positionMaster;
	}
	
	
}
