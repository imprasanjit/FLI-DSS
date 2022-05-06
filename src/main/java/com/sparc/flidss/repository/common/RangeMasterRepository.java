package com.sparc.flidss.repository.common;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;


import com.sparc.flidss.model.common.RangeMaster;

public interface RangeMasterRepository extends JpaRepository<RangeMaster, String> {
	Optional<RangeMaster> findBychrvRangeCd(String chrvRangeCd);

}
