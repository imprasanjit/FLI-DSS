package com.sparc.flidss.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
import com.sparc.flidss.service.HomeService;
import com.sparc.flidss.service.TripleDESEncryptionService;
@Service
public class HomeServiceImpl implements HomeService {
	
	
	
	@Autowired
	private AutoUserInfoRepository aUserInfoRepo;

	@Override
	public boolean LoginUser(AutoUserInfoMaster user) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

//	@Override
//	public String LoginUser(String username, String password) {
//		
//		AutoUserInfoMaster user = autoUserInfoRepository.findBychrvUserId(username);
//		System.out.println(user);
//		if(user!=null) {
//			return "Success";
//		}
//		else {
//			return "Failure";
//		}
//		
//	}

	/*@Override
	public boolean LoginUser(AutoUserInfoMaster user) throws Exception {
		TripleDESEncryptionService abc = new TripleDESEncryptionService();
		 final String pswdEncrypt = abc.encryptText(user.getChrvUserPwd());
		AutoUserInfoMaster isValidUser = aUserInfoRepo.findByChrvUserIdAndChrvUserPwd(user.getChrvUserId(), pswdEncrypt);
		
		if(isValidUser!=null) {
			return true;
		}else {
			return false;
		}*/
		
		
	}
	


