package com.sparc.flidss.repository.common;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.sparc.flidss.model.common.NfbDetail;
import com.sparc.flidss.model.common.NfbMaster;
import com.sparc.flidss.viewmodel.INfbDetails;
import com.sparc.flidss.viewmodel.INfbDetailsV2;
import com.sparc.flidss.viewmodel.INfbDlcDivwiseArea;
import com.sparc.flidss.viewmodel.INfbFbwiseArea;
import com.sparc.flidss.viewmodel.INfbStatistics;
import com.sparc.flidss.viewmodel.UvwNfbDetails;

public interface NfbDetailsRepository extends JpaRepository<NfbDetail, Integer> {
	
	NfbDetail findBynfbMaster(NfbMaster nfbmaster);
	
//	@Query(value = "select * from public.nfb_details where orsac_clearence_dt is not null and isdelete=false", nativeQuery = true)
//	List<NfbDetail> getAllData();

	@Query(value = "select int_fk_circle,chrv_circle,div_id,chrv_division_nm,int_fk_dec_phase,chrv_consultant_nm,priority_wise_area_ha,nfa_ha,dgpsd_ha,dgpsf_ha,dlcrev_area_ac,no_of_fb from uvw_nfb_dlc_divwise_area", nativeQuery = true)
	List<INfbDlcDivwiseArea> getNfbDlcDivWiseArea();

	@Query(value = "select * from public.uvw_nfb_fbwise_area where div_id=:divId", nativeQuery = true)
	List<INfbFbwiseArea> getNfbFbWiseArea(Integer divId);

	@Query(value = "select * from nfb_details :filter and isdelete=false", nativeQuery = true)
	List<NfbDetail> getNfbDetails(String filter);//where int_fk_division=1

	@Query(value = "select * from public.nfb_details where isdelete=false and int_fk_nfb=:nfbId", nativeQuery = true)
	List<NfbDetail> getNfbDetails(Integer nfbId);

	@Query(value = "select * from public.uvw_nfb_statistics where divid=:divid", nativeQuery = true)
	List<INfbStatistics> getNFBStatistics(Integer divid);

	@Query(value = "select * from uvw_nfb_detailsv2 \r\n"
			+ "where int_fk_division=(case when :divid>0 then :divid else int_fk_division end) and chrv_fk_range_cd=coalesce(cast(:rangeCode as text),chrv_fk_range_cd) and nareaha=(select max(nareaha) from uvw_nfb_detailsv2 where nareaha>0 and chrv_fk_range_cd=coalesce(cast(:rangeCode as text),chrv_fk_range_cd) and int_fk_division=(case when :divid>0 then :divid else int_fk_division end))", nativeQuery = true)
	List<INfbDetailsV2> getMaxNareaFb(Integer divid, String rangeCode);

	@Query(value = "select * from uvw_nfb_detailsv2 \r\n"
			+ "where int_fk_division=(case when :divid>0 then :divid else int_fk_division end) and chrv_fk_range_cd=coalesce(cast(:rangeCode as text),chrv_fk_range_cd) and nareaha=(select min(nareaha) from uvw_nfb_detailsv2 where nareaha>0 and chrv_fk_range_cd=coalesce(cast(:rangeCode as text),chrv_fk_range_cd) and int_fk_division=(case when :divid>0 then :divid else int_fk_division end))", nativeQuery = true)
	List<INfbDetailsV2> getMinNareaFb(Integer divid, String rangeCode);

	@Query(value = "select avg(nareaha) maxnarea_ha from uvw_nfb_detailsv2\r\n"
			+ "where int_fk_division=(case when :divid>0 then :divid else int_fk_division end) and chrv_fk_range_cd=coalesce(cast(:rangeCode as text),chrv_fk_range_cd)", nativeQuery = true)
	Double getAvgNarea(Integer divid, String rangeCode);

	//	@Query(value = "select count(int_id) from public.nfb_details where orsac_clearence_dt notnull and isdelete='false'",nativeQuery = true)
	//	Integer getOrsacCertification();
	//	
	//	@Query(value = "select count(int_id) from public.nfb_details where fso_certification_dt notnull and isdelete='false'",nativeQuery = true)
	//	Integer getFsoCertification();
	//	
	//	@Query(value = "select count(int_id) from public.nfb_details where renotification_prop_dt notnull and isdelete='false'",nativeQuery = true)
	//	Integer getOrsacReNtification();
	//	
	//	@Query(value = "select sum(dgpsf_ha*0.01) from public.nfb_details where orsac_clearence_dt notnull and isdelete='false'",nativeQuery = true)
	//	Double getOrsacCertificationVal();
	//	
	//	@Query(value = "select sum(dgpsf_ha*0.01) from public.nfb_details where fso_certification_dt notnull and isdelete='false'",nativeQuery = true)
	//	Double getOrsacFsoCertificationVal();
	//	
	//	@Query(value = "select sum(dgpsf_ha*0.01) from public.nfb_details where renotification_prop_dt notnull and isdelete='false'",nativeQuery = true)
	//	Double getOrsacReNotificationVal();

	//total count
	/*	@Query(value = "select count(*) from public.nfb_details d\r\n"
				+ "join public.nfb_master b on b.int_id=d.int_fk_nfb\r\n"
				+ "where d.orsac_clearence_dt  notnull and d.isdelete='false' and b.int_fk_phase=:phase", nativeQuery = true)
		Integer getOrsacCertification(Set<Integer> phase);
	
		@Query(value = "select count(*) from public.nfb_details d\r\n"
				+ "join public.nfb_master b on b.int_id=d.int_fk_nfb\r\n"
				+ "where d.fso_certification_dt  notnull and d.isdelete='false' and b.int_fk_phase=:phase", nativeQuery = true)
		Integer getFsoCertification(Set<Integer> phase);
	
		@Query(value = "select count(*) from public.nfb_details d\r\n"
				+ "join public.nfb_master b on b.int_id=d.int_fk_nfb\r\n"
				+ "where d.renotification_prop_dt  notnull and d.isdelete='false' and b.int_fk_phase=:phase", nativeQuery = true)
		Integer getOrsacReNtification(Set<Integer> phase);
	
		//DGPS area calculation
		@Query(value = "select coalesce(sum(dgpsf_ha*0.01),0.00) from public.nfb_details d\r\n"
				+ "join public.nfb_master b on b.int_id=d.int_fk_nfb\r\n"
				+ "where d.orsac_clearence_dt  notnull and d.isdelete='false' and b.int_fk_phase in(:phase)", nativeQuery = true)
		Double getOrsacCertificationVal(Set<Integer> phase);
	
		@Query(value = "select coalesce(sum(dgpsf_ha*0.01),0.00) from public.nfb_details d\r\n"
				+ "join public.nfb_master b on b.int_id=d.int_fk_nfb\r\n"
				+ "where d.fso_certification_dt  notnull and d.isdelete='false' and b.int_fk_phase in(:phase)", nativeQuery = true)
		Double getOrsacFsoCertificationVal(Set<Integer> phase);
	
		@Query(value = "select coalesce(sum(dgpsf_ha*0.01),0.00) from public.nfb_details d\r\n"
				+ "join public.nfb_master b on b.int_id=d.int_fk_nfb\r\n"
				+ "where d.renotification_prop_dt  notnull and d.isdelete='false' and b.int_fk_phase in(:phase)", nativeQuery = true)
		Double getOrsacReNotificationVal(Set<Integer> phase);*/

}
