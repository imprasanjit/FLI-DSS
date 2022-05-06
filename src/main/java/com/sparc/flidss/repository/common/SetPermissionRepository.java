package com.sparc.flidss.repository.common;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.SetPermissionMaster;


public interface SetPermissionRepository extends JpaRepository<SetPermissionMaster, Integer>{
	@Query(value = "SELECT * FROM set_permission_master where fk_int_pos_id =:posId", nativeQuery = true)
public List<SetPermissionMaster> getPermssion(int posId);
	 

}
