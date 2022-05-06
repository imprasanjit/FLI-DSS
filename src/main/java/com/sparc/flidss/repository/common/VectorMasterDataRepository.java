package com.sparc.flidss.repository.common;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.VectorMasterData;

public interface VectorMasterDataRepository extends JpaRepository<VectorMasterData, Integer> {
	
	@Query(value="select * from public.vector_master_data where int_fk_division IN (:divList) AND int_fk_vector_master_layer_type=:type",nativeQuery=true)
	List<VectorMasterData> getDivisionVectorMapTypeLayerList(List<Integer> divList, Integer type);
	@Query(value="select * from public.vector_master_data where int_fk_division=:divId AND int_fk_vector_master_layer_type=:type",nativeQuery=true)
	VectorMasterData getAllDivLayers(Integer divId,Integer type);
	@Query(value="select * from public.vector_master_data where int_fk_vector_master_layer_type=:type",nativeQuery=true)
	VectorMasterData getAllDisLayers(Integer type);
}
