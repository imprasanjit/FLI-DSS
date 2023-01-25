package com.sparc.flidss.repository.common;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sparc.flidss.model.common.UserProjectMaster;
import com.sparc.flidss.model.common.UserProjectMasterDetails;
@Repository
public interface UserProjectMasterDetailsRepository extends JpaRepository<UserProjectMasterDetails,Integer> {
	
	@Query(value = "SELECT max(int_id) FROM user_project_master_details", nativeQuery = true)
	Integer getMaxId();

	
	public List<UserProjectMasterDetails> findAllByUserProjectMaster(UserProjectMaster userPM);
}
