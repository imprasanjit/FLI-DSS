package com.sparc.flidss.repository.common;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.DistrictDivisionLinkMaster;

public interface DistrictDivisionLinkMasterRepository extends JpaRepository<DistrictDivisionLinkMaster, Integer> {
	
	@Query(value ="select * from district_division_link_master where int_fk_division=:divid", nativeQuery=true)
	List<DistrictDivisionLinkMaster> getDivisionMaster(Integer divid);
	
	@Query(value ="select * from district_division_link_master where int_fk_district=:distid", nativeQuery=true)
	List<DistrictDivisionLinkMaster> findByDistId(Integer distid);
	
}

