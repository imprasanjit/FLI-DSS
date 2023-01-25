package com.sparc.flidss.repository.common;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.GlobalLinkMaster;





public interface GlobalLinkRepository extends JpaRepository<GlobalLinkMaster, Integer>{
	
	  
	@Query(value="SELECT COALESCE(max(int_glink_id),0) FROM global_link_master",nativeQuery = true)
	Integer getMaxId();
	
	public List<GlobalLinkMaster> findAllByOrderByChrvGlinkNameAsc();
	public GlobalLinkMaster findByIntGlinkId (Integer gId);
	@Query(value="select gl.int_glink_id from global_link_master as gl where gl.int_active_sts = 0 order by int_priority_odr",nativeQuery = true)
	public List<Integer> getAllActiveLinkId();

}
