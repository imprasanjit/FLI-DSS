package com.sparc.flidss.repository.common;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.DistrictDivisionLinkMaster;
import com.sparc.flidss.model.common.NfbMaster;

public interface NfbMasterRepository extends JpaRepository<NfbMaster,Integer> {
	//Optional<NfbMaster> findBynfbMaster(NfbMaster nfbmaster);	
	@Query(value ="select * from nfb_master where int_fk_division=:divid and chrv_fk_range_cd=:rid", nativeQuery=true)
	List<NfbMaster> getRangewiseFB(Integer divid,String rid);
}
