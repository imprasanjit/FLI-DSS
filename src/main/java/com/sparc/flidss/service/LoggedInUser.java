package com.sparc.flidss.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
@Service
public class LoggedInUser {
	@Autowired
	AutoUserInfoRepository autoUserInfoRepository;
	
	public AutoUserInfoMaster getUser() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = null;
		if (principal instanceof UserDetails) {
			username = ((UserDetails)principal).getUsername();
		} else {
			username = principal.toString();
		}
		AutoUserInfoMaster loggedInUser = autoUserInfoRepository.findBychrvUserId(username);
		return loggedInUser;
	}
	
	
}
	
