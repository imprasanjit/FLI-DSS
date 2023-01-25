package com.sparc.flidss.repository.common;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sparc.flidss.model.common.PositionMaster;

@Repository
public interface PositionMasterRepository extends JpaRepository<PositionMaster, Integer> {
	Optional<PositionMaster> findBychrvPositionNm(String chrvPositionNm);

	@Query(value = "SELECT max(int_id) FROM position_master", nativeQuery = true)
	Integer getMaxId();

	@Query(value = "select * from position_master order by chrv_position_nm;", nativeQuery = true)
	public List<PositionMaster> getAll();

}
