package com.sparc.flidss.repository.common;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.PrivilegeMaster;



public interface PrivilegeMasterRepository extends JpaRepository<PrivilegeMaster, Integer>{

	 

}
