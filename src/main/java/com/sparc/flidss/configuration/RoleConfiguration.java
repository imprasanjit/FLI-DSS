package com.sparc.flidss.configuration;


import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties("role")
public class RoleConfiguration {
	 String[] MapViewEditRoles;
	 String[] LandingAsContactPageRoles;
	 String[] LandingAsDashboardPageRoles;
	 String[] DigitalSignature;
	 String[] AdminOnly;
	 String[] DashboardMapNotView;
	 String[] RegisterUser;
	 String[] UserIdNotChangeRole;
	 String[] userIDNotChange;
	 String[] SetOtp;
	public String[] getMapViewEditRoles() {
		return MapViewEditRoles;
	}
	public void setMapViewEditRoles(String[] mapViewEditRoles) {
		MapViewEditRoles = mapViewEditRoles;
	}
	public String[] getLandingAsContactPageRoles() {
		return LandingAsContactPageRoles;
	}
	public void setLandingAsContactPageRoles(String[] landingAsContactPageRoles) {
		LandingAsContactPageRoles = landingAsContactPageRoles;
	}
	public String[] getLandingAsDashboardPageRoles() {
		return LandingAsDashboardPageRoles;
	}
	public void setLandingAsDashboardPageRoles(String[] landingAsDashboardPageRoles) {
		LandingAsDashboardPageRoles = landingAsDashboardPageRoles;
	}
	public String[] getDigitalSignature() {
		return DigitalSignature;
	}
	public void setDigitalSignature(String[] digitalSignature) {
		DigitalSignature = digitalSignature;
	}
	public String[] getAdminOnly() {
		return AdminOnly;
	}
	public void setAdminOnly(String[] adminOnly) {
		AdminOnly = adminOnly;
	}
	public String[] getDashboardMapNotView() {
		return DashboardMapNotView;
	}
	public void setDashboardMapNotView(String[] dashboardMapNotView) {
		DashboardMapNotView = dashboardMapNotView;
	}
	public String[] getRegisterUser() {
		return RegisterUser;
	}
	public void setRegisterUser(String[] registerUser) {
		RegisterUser = registerUser;
	}
	public String[] getUserIdNotChangeRole() {
		return UserIdNotChangeRole;
	}
	public void setUserIdNotChangeRole(String[] userIdNotChangeRole) {
		UserIdNotChangeRole = userIdNotChangeRole;
	}
	public String[] getUserIDNotChange() {
		return userIDNotChange;
	}
	public void setUserIDNotChange(String[] userIDNotChange) {
		this.userIDNotChange = userIDNotChange;
	}
	public String[] getSetOtp() {
		return SetOtp;
	}
	public void setSetOtp(String[] setOtp) {
		SetOtp = setOtp;
	}
	
}
