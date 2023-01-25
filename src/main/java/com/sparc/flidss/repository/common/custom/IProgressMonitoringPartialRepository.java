package com.sparc.flidss.repository.common.custom;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sparc.flidss.model.common.CircleMaster;
//import com.sparc.flidss.service.impl.Types;
import com.sparc.flidss.viewmodel.progressmonitoring.*;
import com.sparc.flidss.viewmodel.reports.IFnDLCRevDetails;
import com.sparc.flidss.viewmodel.reports.IFnForestLandSummary;

@Repository
public interface IProgressMonitoringPartialRepository extends JpaRepository<CircleMaster, Integer> {

	@Query(value = "select * from public.frjvc_certifiedpoint_details",nativeQuery = true)
	List<IFrjvcCertifiedpointDetails> getFrjvcCertifiedPointDetails();
	
	@Query(value = "select * from public.frjvc_certifiedpoint_details where nfb_id=:fbid",nativeQuery = true)
	List<IFrjvcCertifiedpointDetails> getFrjvcCertifiedPointDetails(Integer fbid);
	

	@Query(value = "select * from public.frjvc_certifiedpoint_details where nfb_id=:nfbId order by pillar_no",nativeQuery = true)
	List<IFrjvcCertifiedpointDetails> getFrjvcCertifiedPointDetailsFindByNfbId(Integer nfbId);
	
	@Query(value = "select * from public.orsac_certifiedpoint_details",nativeQuery = true)
	List<IOrsacCertifiedpointDetails> getOrsacCertifiedPointDetails();
	
	@Query(value = "select n.int_fk_division as divid,n.chrv_fk_range_cd as rngcode,* from public.orsac_certifiedpoint_details b left join public.nfb_master n on b.nfb_id=n.int_id where b.nfb_id=:fbid",nativeQuery = true)
	List<IOrsacCertifiedpointDetails> getOrsacCertifiedPointDetails(Integer fbid);
	
	@Query(value = "select * from public.fn_forest_land_summary(:p_div_id,:p_rng_code,:p_fb_id ,:p_selection)",nativeQuery = true)
	List<IFnForestLandSummary> getForestlandSummary(@Param("p_div_id")Integer p_div_id,@Param("p_rng_code") String p_rng_code,@Param("p_fb_id")Integer p_fb_id,@Param("p_selection") String p_selection);
	
	@Query(value = "select a.*,b.int_fk_division as divid,b.chrv_fk_range_cd as rngcode from public.orsac_certifiedpoint_details  as a\r\n"
			+ "left join (select int_id,nfb_name,nfb_type,int_fk_division,chrv_fk_range_cd from public.uvw_nfb_detailsv2) as b on a.nfb_id=b.int_id\r\n"
			+ "where a.nfb_id=:fbid and pillar_type='FSCP'",nativeQuery = true)
	List<IOrsacCertifiedpointDetails> getFscpPointDetails(Integer fbid);
	
	@Query(value = "select b.*,n.int_id as nfbid,n.int_fk_division as divid,chrv_fk_range_cd as rngcode from public.fpcp_point b left join public.nfb_master n on b.chrv_fk_range=n.chrv_fk_range_cd where n.int_id=:fbid",nativeQuery = true)
	List<IFpcppointDetails> getFpcpPointDetails(Integer fbid);

	//@Query(value = "select * from public.fn_Rev_Dlc_Report_Details(:p_div_id,:p_teh_id,:p_ric_name ,:p_vill_name,:p_selection) where coalesce(dlc,'N') in (:p_types)",nativeQuery = true)
	//List<IFnDLCRevDetails> getDLCRevSummary(@Param("p_div_id")Integer p_div_id,@Param("p_teh_id")Integer p_teh_id,@Param("p_ric_name") String p_ric_name,@Param("p_vill_name") String p_vill_name,@Param("p_selection") String p_selection,@Param("p_types") List<String> p_types );
	
	@Query(value = "select * from public.fn_rev_dlc_report_details1(:p_div_id,:p_teh_id,:p_ric_name ,:p_vill_name,:p_selection,:p_types) where coalesce(dlc,'N') in (:p_types)",nativeQuery = true)
	List<IFnDLCRevDetails> getDLCRevSummary(@Param("p_div_id")Integer p_div_id,@Param("p_teh_id")Integer p_teh_id,@Param("p_ric_name") String p_ric_name,@Param("p_vill_name") String p_vill_name,@Param("p_selection") String p_selection,@Param("p_types") List<String> p_types );
}
