package com.sparc.flidss.repository.common;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sparc.flidss.model.common.SacntuaryBoundary;
import com.sparc.flidss.viewmodel.INfbFbwiseArea;
@Repository
public interface SacntuaryBoundaryRepository extends JpaRepository<SacntuaryBoundary, Integer> {
	@Query(value = "select a.gid,a.id,a.int_fk_division,a.sanc_code,a.sanc_name,a.noti_no,a.noti_date,a.area_sqkm,a.area_ha\r\n"
			+ ", ST_AsGeoJSON(ST_Transform(a.geom,4326))\\:\\:text as geom from public.sanctuary_boundary as a\r\n"
			+ "left join public.district_division_link_master as b on a.int_fk_division=b.int_fk_division\r\n"
			+ "where a.int_fk_division=:divId",nativeQuery = true)
	List<SacntuaryBoundary> getSancLayers(Integer divId);

}
