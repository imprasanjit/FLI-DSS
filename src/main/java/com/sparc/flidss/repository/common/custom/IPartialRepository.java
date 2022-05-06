package com.sparc.flidss.repository.common.custom;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.CircleMaster;
import com.sparc.flidss.viewmodel.IGrflProgressCircleWise;
import com.sparc.flidss.viewmodel.IGrflProgressDivisionWise;
import com.sparc.flidss.viewmodel.IGrflProgressRangeWise;
import com.sparc.flidss.viewmodel.IRecordedForestCaLand;

public interface IPartialRepository extends JpaRepository<CircleMaster, Integer> {

	@Query(value = "select * from uvw_grfl_progress_circlewise order by chrv_circle", nativeQuery = true)
	List<IGrflProgressCircleWise> getGrflProgressCircleWise();

	@Query(value = "select * from fn_grfl_progress_circlewise(:phase)", nativeQuery = true)
	List<IGrflProgressCircleWise> getGrflProgressCircleWise(Set<Integer> phase);

	/*
	 * @Procedure(procedureName = "public.fn_grfl_progress_circlewise")
	 * List<IGrflProgressCircleWise> getGrflProgressCircleWise(@Param("p_int_phase")
	 * Integer[] p_int_phase);
	 */

	@Query(value = "select * from uvw_grfl_progress_divisionewise order by chrv_division_nm", nativeQuery = true)
	List<IGrflProgressDivisionWise> getGrflProgressDivisionWise();
	
	
	@Query(value = "select * from uvw_grfl_progress_divisionewise where int_fk_dec_phase in(:phase) order by chrv_division_nm", nativeQuery = true)
	List<IGrflProgressDivisionWise> getGrflProgressDivisionWise(Set<Integer> phase);

	@Query(value = "select * from uvw_grfl_progress_rangewise order by chrv_range_nm", nativeQuery = true)
	List<IGrflProgressRangeWise> getGrflProgressRangewise();
	
	@Query(value = "select * from uvw_grfl_progress_rangewise where int_fk_dec_phase in(:phase) order by chrv_range_nm", nativeQuery = true)
	List<IGrflProgressRangeWise> getGrflProgressRangewise(Set<Integer> phase);

	@Query(value = "select vill_code,village,div_id,div_name,tah_id,tahasil,dist_id,dist_name,ps,thana_no,ric,sum(area_ac) as area_ac,sum(total_area) as total_area \r\n"
			+ "from public.recoded_forest_ca_land where div_id=1 and total_area>12.35 and area_ac>12.35 and wgt_cd<=25 group by vill_code,div_id,div_name,tah_id,tahasil,dist_id,dist_name,village,ps,thana_no,ric order by tahasil,ric,village", nativeQuery = true)
	List<IRecordedForestCaLand> getRecodedForestCaLandMaster();

	@Query(value = "select * from public.recoded_forest_ca_land where div_id=1 and total_area>12.35 and area_ac>12.35 and wgt_cd<=25 order by Khata_no,cast(plot_no as integer),Area_ac", nativeQuery = true)
	List<IRecordedForestCaLand> getRecodedForestCaLandDetails();

}
