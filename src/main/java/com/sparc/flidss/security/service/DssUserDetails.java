package com.sparc.flidss.security.service;
 
import java.util.*;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.PositionMaster;
import com.sparc.flidss.model.common.SetPermissionMaster;
import com.sparc.flidss.repository.common.SetPermissionRepository;

 
public class DssUserDetails implements UserDetails {
 
    private AutoUserInfoMaster user;
    //@Autowired
   // SetPermissionRepository authMenu;
     

    public DssUserDetails(AutoUserInfoMaster user) {
		this.user = user;
	}

	public DssUserDetails() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Set<PositionMaster> roles = user.getRoles();
        List<SimpleGrantedAuthority> authorities = new ArrayList<>();
        
        for (PositionMaster role : roles) {
            authorities.add(new SimpleGrantedAuthority(role.getChrvPositionNm()));
        }

//        for (PositionMaster role : roles) {
//            authorities.add(new SimpleGrantedAuthority(role.getChrvPositionNm()));
//			  for(SetPermissionMaster
//			  menu:authMenu.findAll().stream().filter(f->f.getPositionMaster().getIntId()==
//			  role.getIntId()).collect(Collectors.toList())) { authorities.add(new
//			  SimpleGrantedAuthority(menu.getGlobalLinkMaster().getChrvGlinkUrl())); }
//        }

        
         
        return authorities;
    }
 
    @Override
    public String getPassword() {
        return user.getChrvUserPwd();
    }
 
    @Override
    public String getUsername() {
        return user.getChrvUserId();
    }
 
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
 
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
 
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
 
    @Override
    public boolean isEnabled() {
    	if(user.getIntUserSts()==1)
        return true; 
    	else
    		return false;
    }

	@Override
	public String toString() {
		return "DssUserDetails [user=" + user + "]";
	}
 
    
}