package com.sparc.flidss.repository.common;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.RoleMaster;


public interface RoleMasterRepository extends JpaRepository<RoleMaster, Integer> {
	Optional<RoleMaster> findBychrvRoleNm(String chrvRoleNm);
	@Query(value="SELECT max(int_id) FROM role_master",nativeQuery = true)
	Integer getMaxId();

}
