package com.sparc.flidss.repository.common;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Page;

import com.sparc.flidss.model.common.RevnueForestMaster;
import com.sparc.flidss.viewmodel.IDlcRevPlotArea;
import com.sparc.flidss.viewmodel.IDlcRevTehwiseArea;
import com.sparc.flidss.viewmodel.IDlcRevVillArea;
import com.sparc.flidss.viewmodel.INfbFbwiseArea;


public interface RevnueForestMasterRepository extends PagingAndSortingRepository<RevnueForestMaster, String> {
	
	  @Query(value="select count(*) from public.rev_forest_master where int_fk_district=:distid and (land_class='Private Forest' or land_class='Govt. Forest')",nativeQuery=true)
	  Integer getDistwiseTotalRecord(Integer distid);
	 
	  @Query(value="select count(*) from public.rev_forest_master where int_fk_division=:divid and (land_class='Private Forest' or land_class='Govt. Forest')",nativeQuery=true)
	  Integer getDiviwiseTotalRecord(Integer divid);
	  
	  @Query(value="select count(*) from public.rev_forest_master where int_fk_district=:distid and int_fk_tehsil=:tehsilid and (land_class='Private Forest' or land_class='Govt. Forest')",nativeQuery=true)
	  Integer getDist_TahsilwiseTotalRecord(Integer distid,Integer tehsilid);
	  
	  @Query(value="select count(*) from public.rev_forest_master where int_fk_division=:divid and chrv_range_cd=:range_code and (land_class='Private Forest' or land_class='Govt. Forest')",nativeQuery=true) 
	  Integer getDiv_rangewiseTotalRecord(Integer divid, String range_code);
	  
	  @Query(value="select * from public.rev_forest_master where vill_code=:vill_code and plot_no=:plot_no",nativeQuery=true) 
	  RevnueForestMaster getRFDetails(String vill_code, String plot_no);
	  
	  Page<RevnueForestMaster> findBylandClassIn(List<String> landclassList,Pageable pageable);


	  @Query(value="select * from public.rev_forest_master where int_fk_district=:distid and (land_class='Private Forest' or land_class='Govt. Forest') order by chrv_tahasil_nm,village,khata_no,plot_no",nativeQuery=true)
	  Page<RevnueForestMaster> getDistwiseRevenueRecord(Integer distid,Pageable pageable);
	 
	  @Query(value="select * from public.rev_forest_master where int_fk_division=:divid and (land_class='Private Forest' or land_class='Govt. Forest') order by chrv_range_nm,village,khata_no,plot_no",nativeQuery=true)
	  Page<RevnueForestMaster> getDivwiseRevenueRecord(Integer divid,Pageable pageable);
	  
	  @Query(value="select * from public.rev_forest_master where int_fk_district=:distid and int_fk_tehsil=:tehsilid and (land_class='Private Forest' or land_class='Govt. Forest') order by chrv_tahasil_nm,village,khata_no,plot_no",nativeQuery=true)
	  Page<RevnueForestMaster> getDist_TahsilwiseRevenueRecord(Integer distid,Integer tehsilid,Pageable pageable);
	  
	  @Query(value="select * from public.rev_forest_master where int_fk_division=:divid and chrv_range_cd=:range_code and (land_class='Private Forest' or land_class='Govt. Forest') order by chrv_range_nm,village,khata_no,plot_no",nativeQuery=true) 
	  Page<RevnueForestMaster> getDiv_rangewiseRevenueRecord(Integer divid, String range_code,Pageable pageable);
	  
	  @Query(value="select * from public.rev_forest_master where int_fk_district=:distid and dlc is not null order by chrv_tahasil_nm,village,khata_no,plot_no",nativeQuery=true)
	  Page<RevnueForestMaster> getDistwiseDLCRecord(Integer distid,Pageable pageable);
	 
	  @Query(value="select * from public.rev_forest_master where int_fk_division=:divid and dlc is not null order by chrv_range_nm,village,khata_no,plot_no",nativeQuery=true)
	  Page<RevnueForestMaster> getDivwiseDLCRecord(Integer divid,Pageable pageable);
	  
	  @Query(value="select * from public.rev_forest_master where int_fk_district=:distid and int_fk_tehsil=:tehsilid and dlc is not null order by chrv_tahasil_nm,village,khata_no,plot_no",nativeQuery=true)
	  Page<RevnueForestMaster> getDist_TahsilwiseDLCRecord(Integer distid,Integer tehsilid,Pageable pageable);
	  
	  @Query(value="select * from public.rev_forest_master where int_fk_division=:divid and chrv_range_cd=:range_code and dlc is not null order by chrv_range_nm,village,khata_no,plot_no",nativeQuery=true) 
	  Page<RevnueForestMaster> getDiv_rangewiseDLCRecord(Integer divid, String range_code,Pageable pageable);

	  @Query(value="select count(*) from public.rev_forest_master where int_fk_district=:distid and dlc is not null",nativeQuery=true)
	  Integer getDistwiseDLCRecord(Integer distid);
	 
	  @Query(value="select count(*) from public.rev_forest_master where int_fk_division=:divid and dlc is not null",nativeQuery=true)
	  Integer getDiviwiseDLCRecord(Integer divid);
	  
	  @Query(value="select count(*) from public.rev_forest_master where int_fk_district=:distid and int_fk_tehsil=:tehsilid and dlc is not null",nativeQuery=true)
	  Integer getDist_TahsilwiseDLCRecord(Integer distid,Integer tehsilid);
	  
	  @Query(value="select count(*) from public.rev_forest_master where int_fk_division=:divid and chrv_range_cd=:range_code and dlc is not null",nativeQuery=true) 
	  Integer getDiv_rangewiseDLCRecord(Integer divid, String range_code);
	  
	  @Query(value = "select * from uvw_dlc_rev_tehwise_area where int_fk_division=:divId",nativeQuery = true)
	   List<IDlcRevTehwiseArea> getDlcRevTehwiseArea(Integer divId);
	  
	  @Query(value = "select * from uvw_dlc_rev_vill_area where int_fk_tehsil=:tehid",nativeQuery = true)
	   List<IDlcRevVillArea> getDlcRevVillwiseArea(Integer tehid);
	  
	  @Query(value = "select int_id,vill_code,village,khata_no,plot_no,kissam,int_fk_tehsil,chrv_tahasil_nm,int_fk_district, int_fk_division,area_ac"
	  		+ ",case when recorded_forest_type in('Govt. Forest under DLC','Private Forest under DLC') then 'DLC' when recorded_forest_type in('Common under DLC & Revenue Govt.','Common under DLC & Revenue Private') then 'Revenue Forest & DLC'else 'Revenue Forest' end as isdlc from uvw_dlc_rev_details where vill_code=:vill",nativeQuery = true)
	   List<IDlcRevPlotArea> getDlcRevPlotwiseArea(String vill);
	  
	  @Query(value = "select sum(area_ac*0.00404686) from public.rev_forest_master where coalesce(land_class,'') ilike '%Forest%'",nativeQuery = true)
	  Double getTotalRevArea();	
	  
	  @Query(value = "select coalesce(sum(area_ac*0.00404686),0.0) from public.rev_forest_master where int_fk_division in(select int_id from division_master where int_fk_dec_phase in(:phase)) and coalesce(land_class,'') ilike '%Forest%' and dlc='N'",nativeQuery = true)
	  Double getTotalRevArea(Set<Integer> phase);	
	  
	  @Query(value = "select count(distinct int_fk_tehsil||vill_code||khata_no||rplot_no) from public.rev_forest_master where coalesce(land_class,'') ilike '%Forest%'",nativeQuery = true)
	  Integer getTotalRevPlots();
	  
	  @Query(value = "select coalesce(count(distinct int_fk_tehsil||vill_code||khata_no||rplot_no),0) from public.rev_forest_master where int_fk_division in(select int_id from division_master where int_fk_dec_phase in(:phase)) and coalesce(land_class,'') ilike '%Forest%' and dlc='N'",nativeQuery = true)
	  Integer getTotalRevPlots(Set<Integer> phase);
	  
	  @Query(value = "select coalesce(count(distinct int_fk_tehsil||vill_code||khata_no||rplot_no),0) from public.rev_forest_master where int_fk_division in(select int_id from division_master where int_fk_dec_phase in(:phase)) and coalesce(land_class,'') ilike '%Forest%' and dlc='Y'",nativeQuery = true)
	  Integer getTotalDLCPlots(Set<Integer> phase);
	  @Query(value = "select coalesce(sum(area_ac*0.00404686),0.0) from public.rev_forest_master where int_fk_division in(select int_id from division_master where int_fk_dec_phase in(:phase)) and coalesce(land_class,'') ilike '%Forest%' and dlc='Y'",nativeQuery = true)
	  Double getTotalDLCArea(Set<Integer> phase);
}
