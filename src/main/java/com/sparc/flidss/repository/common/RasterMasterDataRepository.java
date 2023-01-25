package com.sparc.flidss.repository.common;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.RasterMasterData;


public interface RasterMasterDataRepository extends JpaRepository<RasterMasterData, Integer> {
	
	@Query(value="select * from public.vector_master_data where int_fk_division IN (:divList) AND int_fk_raster_master_layer_type=:type",nativeQuery=true)
	List<RasterMasterData> getDivisionRasterMapTypeLayerList(List<Integer> divList, Integer type);
	@Query(value="select * from public.raster_master_data where int_fk_division=:divId AND int_fk_raster_master_layer_type=:type",nativeQuery=true)
	RasterMasterData getAllDivLayers(Integer divId,Integer type);
	
}


