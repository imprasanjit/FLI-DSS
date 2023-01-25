package com.sparc.flidss.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
import com.sparc.flidss.service.TripleDESEncryptionService;

public class DssUserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private AutoUserInfoRepository userRepository;
	@Autowired
	TripleDESEncryptionService encService;
	String authorizeRole = "";

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		AutoUserInfoMaster user = userRepository.findBychrvUserIdAndIntUserSts(username, 1).orElse(null);

		if (user == null) {
			throw new UsernameNotFoundException("Could not find user");
		}

		try {
			user.setChrvUserPwd(encService.decrypt(user.getChrvUserPwd()));
		} catch (Exception e) {

			e.printStackTrace();
		}

		DssUserDetails dssUserDetails = new DssUserDetails(user);

		// System.out.println(dssUserDetails);
		return dssUserDetails;
	}

}
