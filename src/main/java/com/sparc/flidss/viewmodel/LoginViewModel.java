package com.sparc.flidss.viewmodel;

public class LoginViewModel {
	        private String chrv_user_id;

	        private String chrv_user_pwd;

	        private Integer int_eotp;

	        private Integer int_votp;
	        
	        private Boolean isOTPCheck;
	        
	        public String getChrv_user_id() {
				return chrv_user_id;
			}

			public LoginViewModel() {
				super();
				// TODO Auto-generated constructor stub
			}

			public void setChrv_user_id(String chrv_user_id) {
				this.chrv_user_id = chrv_user_id;
			}

			public String getChrv_user_pwd() {
				return chrv_user_pwd;
			}

			public void setChrv_user_pwd(String chrv_user_pwd) {
				this.chrv_user_pwd = chrv_user_pwd;
			}

			public Integer getInt_eotp() {
				return int_eotp;
			}

			public void setInt_eotp(Integer int_eotp) {
				this.int_eotp = int_eotp;
			}

			public Integer getInt_votp() {
				return int_votp;
			}

			public void setInt_votp(Integer int_votp) {
				this.int_votp = int_votp;
			}

			public Boolean getIsOTPCheck() {
				return isOTPCheck;
			}

			public void setIsOTPCheck(Boolean isOTPCheck) {
				this.isOTPCheck = isOTPCheck;
			}

			@Override
			public String toString() {
				return "LoginViewModel [chrv_user_id=" + chrv_user_id + ", chrv_user_pwd=" + chrv_user_pwd
						+ ", int_eotp=" + int_eotp + ", int_votp=" + int_votp + ", isOTPCheck=" + isOTPCheck + "]";
			}

			
			
			

			
}
