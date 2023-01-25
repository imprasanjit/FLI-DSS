package com.sparc.flidss.repository.common;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.GlobalLinkMaster;
import com.sparc.flidss.model.common.PrimaryLinkMaster;



public interface PrimaryLinkRepository extends JpaRepository<PrimaryLinkMaster, Integer>{
	
	List<PrimaryLinkMaster> findByintActiveSts(Integer intActiveSts);

	@Query(value="SELECT COALESCE(max(int_plink_id),0) FROM primary_link_master",nativeQuery = true)
	Integer getMaxId();
	@Query(value="SELECT * FROM primary_link_master where fk_int_glink_id=:gId ",nativeQuery = true)
	 public List<PrimaryLinkMaster> getRecord (int gId);

}
