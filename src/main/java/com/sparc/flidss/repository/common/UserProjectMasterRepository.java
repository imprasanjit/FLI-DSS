package com.sparc.flidss.repository.common;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.UserProjectMaster;
@Repository
public interface UserProjectMasterRepository extends JpaRepository<UserProjectMaster, Integer> {

	@Query(value = "SELECT max(int_id) FROM user_project_master", nativeQuery = true)
	Integer getMaxId();

	
	public UserProjectMaster findByIntId(Integer projId);
	public List<UserProjectMaster> findAllByUser(AutoUserInfoMaster user);
}
