package com.sparc.flidss.repository.common;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sparc.flidss.model.common.UsersRole;

@Repository
public interface UsersRolesRepository extends JpaRepository<UsersRole, Integer>{
	
	@Query(value = "SELECT max(id) FROM users_roles", nativeQuery = true)
	Integer getMaxId();
	
	
	public UsersRole findByUserId(int uId);
	

}
