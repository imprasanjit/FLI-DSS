package com.sparc.flidss.security.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.GlobalLinkMaster;
import com.sparc.flidss.model.common.PrimaryLinkMaster;
import com.sparc.flidss.model.common.SetPermissionMaster;
import com.sparc.flidss.model.common.UsersRole;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
import com.sparc.flidss.repository.common.GlobalLinkRepository;
import com.sparc.flidss.repository.common.PrimaryLinkRepository;
import com.sparc.flidss.repository.common.SetPermissionRepository;
import com.sparc.flidss.repository.common.UsersRolesRepository;

@Service
public class SecurityUtility {
    @Autowired
	private AutoUserInfoRepository autoUserInfoRepository;	
	@Autowired
	private UsersRolesRepository usersRolesRepository;
	@Autowired
	private SetPermissionRepository setPermissionRepository;
	@Autowired
	private GlobalLinkRepository globalLinkRepository;
	@Autowired
	private PrimaryLinkRepository primaryLinkRepository;
	
	
	public String checkAuthority(int globalLinkId,int pLinkid) {
		String url="redirect:/login";//"/exceptionhandler/error_forbidden";
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(!principal.toString().equals("anonymousUser")) {
		String username = null;
		//String validGLink=null;
		
		if (principal instanceof UserDetails) {
			username = ((UserDetails)principal).getUsername();
		} else {
			username = principal.toString();
		}
		AutoUserInfoMaster loggedInUser = autoUserInfoRepository.findBychrvUserId(username);
		UsersRole user = usersRolesRepository.findByUserId(loggedInUser.getIntId());
		List<SetPermissionMaster> listPermisson = setPermissionRepository.getPermssion(user.getPositionId());

		GlobalLinkMaster gLink = new GlobalLinkMaster();
		//PrimaryLinkMaster pLink = new PrimaryLinkMaster();

		int t_count=0;
		int f_count=0;
		for(SetPermissionMaster x:listPermisson) {
			gLink  = x.getGlobalLinkMaster();
			int gId = gLink.getIntGlinkId();
			int counter = gId == globalLinkId ?  t_count++ : f_count++;		

		}
		if(t_count !=0) {

			if(globalLinkId ==1 || globalLinkId==2 || globalLinkId == 3|| globalLinkId == 7 || globalLinkId == 8) {

				gLink = globalLinkRepository.findByIntGlinkId(globalLinkId) ;
				url= gLink.getChrvGlinkUrl();
				return url;

			}else if(globalLinkId == 4 || globalLinkId == 5) {
				List<PrimaryLinkMaster> listPLink = primaryLinkRepository.getRecord(globalLinkId);
				for(PrimaryLinkMaster p_link:listPLink) {
					if(p_link.getIntPlinkId() == pLinkid) {
						url= p_link.getChrvPlinkUrl();
						return url;
					}
				}

			}

		}else if(f_count != 0) {
			return "redirect:/login";//"/exceptionhandler/error_forbidden";
		} 
		}
		return url;


	}

}
