package com.sparc.flidss.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Convert;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sparc.flidss.model.common.RevnueForestMaster;
import com.sparc.flidss.repository.common.RevnueForestMasterRepository;
import com.sparc.flidss.model.common.SacntuaryBoundary;
import com.sparc.flidss.service.DBService;
import com.sparc.flidss.viewmodel.AOIAnalysisViewModel;
import com.sparc.flidss.viewmodel.AOIViewModel;
import com.sparc.flidss.viewmodel.POIViewModel;
import com.sparc.flidss.viewmodel.INfbDetails;
import com.sparc.flidss.viewmodel.SP_NFBViewModel;
import com.sparc.flidss.viewmodel.UvwNfbDetails;
@Service
public class DBServiceImpl implements DBService{
	@PersistenceContext
	EntityManager em;
	@Override
	public List<Object[]> getLayerInfo(String layer,Integer distid,Integer divid,Integer tehsilid,String rangeCode) {
		String func_name=getFunctionName(layer);
		
		
		Query query1=em.createNativeQuery("SELECT * FROM public."+func_name+"(:p_int_district,:p_int_tahasil,:p_int_division,:p_chrv_range_cd)");
//		Query query1=em.createNativeQuery("	 SELECT row_to_json(f)::text As feature FROM public."+func_name+"(:p_int_district,:p_int_tahasil,:p_int_division,:p_chrv_range_cd)) As f ");
		query1.setParameter("p_int_district", distid);
		query1.setParameter("p_int_tahasil", tehsilid);
		query1.setParameter("p_int_division", divid);
		query1.setParameter("p_chrv_range_cd", rangeCode);
		@SuppressWarnings("unchecked")
		List<Object[]> resultList=query1.getResultList();
		return resultList;
	}
	public List<SP_NFBViewModel> getNFBLayer(String layer,Integer distid,Integer divid,String rangeCode)
	{
		String func_name=getFLFunctionName(layer);
		Query query1=em.createNativeQuery("SELECT * FROM public."+func_name+"(:distid,:divid,:rangecode)",SP_NFBViewModel.class);
		//Query query1=em.createNativeQuery("	 SELECT row_to_json(f)::text As feature FROM public."+func_name+"(:p_int_district,:p_int_tahasil,:p_int_division,:p_chrv_range_cd)) As f ");
		
		//Query query1=em.createNativeQuery("SELECT * FROM public.fn_get_fl_cmv_details(0,1,'')",SP_NFBViewModel.class);
		query1.setParameter("distid", distid);
		query1.setParameter("divid", divid);
		query1.setParameter("rangecode", rangeCode);
		@SuppressWarnings("unchecked")
		List<SP_NFBViewModel> resultList=query1.getResultList();
		return resultList;
	}
	String getFunctionName(String layer)
	{
		String funcName="";
		if(layer.equals("cmv"))
		{
			funcName="fn_get_cmv_details";
		}
		else if(layer.equals("mmv"))
		{
			funcName="fn_get_mmv_details";
		}
		else if(layer.equals("jv_draft"))
		{
			funcName="fn_get_jv_draft_details";
		}
		else if(layer.equals("jv_final"))
		{
			funcName="fn_get_jv_final_details";
		}
		else if(layer.equals("dgps_draft"))
		{
			funcName="fn_get_dgps_draft_details";
		}
		else if(layer.equals("dgps_final"))
		{
			funcName="fn_get_dgps_final_details";
		}
		return funcName;
	}
	String getFLFunctionName(String layer)
	{
		String funcName="";
		if(layer.equals("cmv"))
		{
			funcName="fn_get_fl_cmv_details";
		}
		else if(layer.equals("mmv"))
		{
			funcName="fn_get_fl_mmv_details";
		}
		else if(layer.equals("jv_draft"))
		{
			funcName="fn_get_fl_jv_draft_details";
		}
		else if(layer.equals("jv_final"))
		{
			funcName="fn_get_fl_jv_final_details";
		}
		else if(layer.equals("dgps_draft"))
		{
			funcName="fn_get_fl_dgps_draft_details";
		}
		else if(layer.equals("dgps_final"))
		{
			funcName="fn_get_dgps_final_details";
		}
		else if(layer.equals("nfb"))
		{
			funcName="fn_get_fl_all_details";
		}
		return funcName;
	}
	
	String getfunction(String geom)
	{
		String funcName="";
		funcName="fn_poi_analysis_summary";
		
		
		return funcName;
	}
	String aoiSummaryfunction(String geom,String bgeom)
	{
		String funcName="";
		
		if(bgeom==null || bgeom=="") {
			funcName="fn_aoi_analysis_summary";
		}else {
			funcName="fn_buffered_aoi_analysis_summary";
		}
		
		return funcName;
	}
	String aoiAnalysisfunction(String geom)
	{
		String funcName="";
		funcName="";
		return funcName;
	}
	/*
	 * @Override public List<SP_NFBViewModel> getNFBLayerForFli() { // TODO
	 * Auto-generated method stub return null; }
	 */
	@Override
	public List<UvwNfbDetails> getNfbDetails(String filter) {
		filter=filter.replace("[", "").replace("]", "");
		String query="select * from uvw_nfb_detailsv2 where 1=1";
		query+=filter;
		Query query1=em.createNativeQuery(query);
		@SuppressWarnings("unchecked")
		List<Object[]> resultList=query1.getResultList();
		
		List<UvwNfbDetails> uvwNfb=new ArrayList<UvwNfbDetails>();
		
		for (Object[] col : resultList) {
		
			Integer getIntId=Integer.parseInt(col[0].toString());
			String getNfbName=col[1]!=null?col[1].toString():"";
			String getNfbType=col[2]!=null?col[2].toString():"";
			Double getNareaSkqm=col[3]!=null?Double.parseDouble(col[3].toString()):0;
			Double getNareaHa=col[4]!=null?Double.parseDouble(col[4].toString()):0;
			String getNotfNo=col[5]!=null?col[5].toString():"";
			String getNotfDt=col[6]!=null?col[6].toString():"";
			String getNotfCopy=col[7]!=null?col[7].toString():"";
			Double getDgpsfHa=col[8]!=null?Double.parseDouble(col[8].toString()):0;
			Double getDgpsdHa=col[9]!=null?Double.parseDouble(col[9].toString()):0;
			Double getJvHa=col[10]!=null?Double.parseDouble(col[10].toString()):0;
			String getJvRpt=col[11]!=null?col[11].toString():"";
			Double getCmvHa=col[12]!=null?Double.parseDouble(col[12].toString()):0;
			Double getMmvHa=col[13]!=null?Double.parseDouble(col[13].toString()):0;
			Integer getIntFkPhase=col[14]!=null?Integer.parseInt(col[14].toString()):0;
			Integer getIntFkCircle=col[15]!=null?Integer.parseInt(col[15].toString()):0;
			String getChrvCircle=col[16]!=null?col[16].toString():"";
			Integer getIntFkDivision=Integer.parseInt(col[17].toString());
			String getChrvDivision_nm=col[18]!=null?col[18].toString():"";
			String getChrvFkRangeCd=col[19]!=null?col[19].toString():"";
			String getChrvRange_nm=col[20]!=null?col[20].toString():"";
			
			UvwNfbDetails objField=new UvwNfbDetails();
			objField.setIntId(getIntId);
			objField.setNfbName(getNfbName);
			objField.setNfbType(getNfbType);
			objField.setNareaSkqm(getNareaSkqm);
			objField.setNareaHa(getNareaHa);
			objField.setNotfNo(getNotfNo);
			objField.setNotfDt(getNotfDt);
			objField.setNotfCopy(getNotfCopy);
			objField.setDgpsfHa(getDgpsfHa);
			objField.setDgpsdHa(getDgpsdHa);
			objField.setJvHa(getJvHa);
			objField.setJvRpt(getJvRpt);
			objField.setCmvHa(getCmvHa);
			objField.setMmvHa(getMmvHa);
			objField.setIntFkPhase(getIntFkPhase);
			objField.setIntFkCircle(getIntFkCircle);
			objField.setChrvCircle(getChrvCircle);
			objField.setIntFkDivision(getIntFkDivision);
			objField.setChrvDivision_nm(getChrvDivision_nm);
			objField.setChrvFkRangeCd(getChrvFkRangeCd);
			objField.setChrvRange_nm(getChrvRange_nm);
			
			uvwNfb.add(objField);
		  }
		
		return uvwNfb;
		
	}
	
	@Autowired
	RevnueForestMasterRepository rfMasterRepo;
	
	@Override
	public List<RevnueForestMaster> getRevVillageList(Model model, Integer selection, Integer dist_id, Integer div_id, Integer tahasil_id, String range_code,Integer pageNo, Integer pageSize,String filter)
    {
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<RevnueForestMaster> pagedResult=null;
		/* Selection is based upon filter of location (District-1 / Division-2) */
        if(selection==1)
		{
			model.addAttribute("selection", selection);
			if(dist_id!=null && dist_id>0)
			{	
				pagedResult=getDist_TahsilwiseRevenueRecord(dist_id, tahasil_id, paging,filter);
				model.addAttribute("totalRev",rfMasterRepo.getDist_TahsilwiseTotalRecord(dist_id,tahasil_id));
			}
			
		}
		
		else if(selection==2) {
			if (div_id!=null && div_id>0) {
				pagedResult = getDiv_rangewiseRevenueRecord(div_id, range_code, paging,filter);
				model.addAttribute("totalRev", rfMasterRepo.getDiv_rangewiseTotalRecord(div_id, range_code));
			} 
		  }
		 
        
        if(pagedResult.hasContent()) {
            return pagedResult.getContent();
        } else {
            return new ArrayList<RevnueForestMaster>();
        }
    }
	
	@Override
	public List<RevnueForestMaster> getDLCVillageList(Model model, Integer selection, Integer dist_id, Integer div_id, Integer tahasil_id, String range_code,Integer pageNo, Integer pageSize,String filter){
		Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<RevnueForestMaster> pagedResult=null;
		/* Selection is based upon filter of location (District-1 / Division-2) */
        if(selection==1)
		{
			model.addAttribute("selection", selection);
			if(dist_id!=null && dist_id>0)
			{	
				pagedResult=getDist_TahsilwiseDLCRecord(dist_id, tahasil_id, paging,filter);
				model.addAttribute("totalRev",rfMasterRepo.getDist_TahsilwiseTotalRecord(dist_id,tahasil_id));
			}
			
		}
		
		else if(selection==2) {
			if (div_id!=null && div_id>0) {
				pagedResult = getDiv_rangewiseDLCRecord(div_id, range_code, paging,filter);
				model.addAttribute("totalRev", rfMasterRepo.getDiv_rangewiseTotalRecord(div_id, range_code));
			} 
		  }
		 
        
        if(pagedResult.hasContent()) {
            return pagedResult.getContent();
        } else {
            return new ArrayList<RevnueForestMaster>();
        }
	}
	
	
	private Page<RevnueForestMaster> getDist_TahsilwiseRevenueRecord(Integer distid,Integer tehsilid,Pageable pageable,String filter){
		Page<RevnueForestMaster> page=null;
		try {
			String query="select * from public.rev_forest_master where int_fk_district=:distid and int_fk_tehsil=cast((case when :tehsilid>0 then :tehsilid else int_fk_tehsil end) as integer)  and (land_class='Private Forest' or land_class='Govt. Forest') and (dlc is null or dlc!='Y')";
			query+=filter;
			query+=" order by chrv_tahasil_nm,village,khata_no,plot_no";
			Query query1=em.createNativeQuery(query,RevnueForestMaster.class);
			query1.setParameter("distid", distid);
			query1.setParameter("tehsilid", tehsilid);
			
			@SuppressWarnings("unchecked")
			//List<Object[]> resultList=query1.getResultList();
			List<RevnueForestMaster> resultList=query1.getResultList();
			
			
			 page = new PageImpl<>(resultList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return page;
	}
	
	//Other Revenue
	private Page<RevnueForestMaster> getDiv_rangewiseRevenueRecord(Integer divid, String range_code,Pageable pageable,String filter){
		Page<RevnueForestMaster> page=null;
		try {
			String query="select * from public.rev_forest_master where int_fk_division=:divid and chrv_range_cd=cast((case when :range_code!='' then :range_code else chrv_range_cd end) as character varying)  and (land_class='Private Forest' or land_class='Govt. Forest') and (dlc is null or dlc!='Y')";
			query+=filter;
			query+=" order by chrv_tahasil_nm,village,khata_no,plot_no";
			Query query1=em.createNativeQuery(query,RevnueForestMaster.class);
			query1.setParameter("divid", divid);
			query1.setParameter("range_code", range_code);
			
			@SuppressWarnings("unchecked")
			//List<Object[]> resultList=query1.getResultList();
			List<RevnueForestMaster> resultList=query1.getResultList();
			
			
			 page = new PageImpl<>(resultList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		return page;
	}
	
	private Page<RevnueForestMaster> getDist_TahsilwiseDLCRecord(Integer distid, Integer tehsilid,Pageable pageable,String filter){
		Page<RevnueForestMaster> page=null;
		try {
			String query="select * from public.rev_forest_master where int_fk_district=:distid and int_fk_tehsil=cast((case when :tehsilid>0 then :tehsilid else int_fk_tehsil end) as integer) and (dlc is not null or dlc='Y')";
			query+=filter;
			query+=" order by chrv_tahasil_nm,village,khata_no,plot_no";
			Query query1=em.createNativeQuery(query,RevnueForestMaster.class);
			query1.setParameter("distid", distid);
			query1.setParameter("tehsilid", tehsilid);
			
			@SuppressWarnings("unchecked")
			//List<Object[]> resultList=query1.getResultList();
			List<RevnueForestMaster> resultList=query1.getResultList();
			
			
			 page = new PageImpl<>(resultList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		return page;
	}
	
	private Page<RevnueForestMaster> getDiv_rangewiseDLCRecord(Integer divid, String range_code,Pageable pageable,String filter){
		Page<RevnueForestMaster> page=null;
		try {
			String query="select * from public.rev_forest_master where int_fk_division=:divid and chrv_range_cd=cast((case when :range_code!='' then :range_code else chrv_range_cd end) as character varying) and (dlc is not null or dlc='Y')";
			query+=filter;
			query+=" order by chrv_tahasil_nm,village,khata_no,plot_no";
			Query query1=em.createNativeQuery(query,RevnueForestMaster.class);
			query1.setParameter("divid", divid);
			query1.setParameter("range_code", range_code);
			
			@SuppressWarnings("unchecked")
			//List<Object[]> resultList=query1.getResultList();
			List<RevnueForestMaster> resultList=query1.getResultList();
			
			
			 page = new PageImpl<>(resultList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		return page;
	}
	
	/*
	 * public List<SacntuaryBoundary> getSancLayers(Integer divid) {
	 * 
	 * Query query1=em.createNativeQuery("SELECT * FROM public.sanctuary_boundary"
	 * );
	 * 
	 * //query1.setParameter("distid", distid); query1.setParameter("divid", divid);
	 * 
	 * @SuppressWarnings("unchecked") List<SacntuaryBoundary>
	 * resultList=query1.getResultList(); return resultList; }
	 */
	@Override
	public List<SacntuaryBoundary> getSancLayers(Integer divid) {
		// TODO Auto-generated method stub
		return null;
	}
	public List<POIViewModel> getPOI(String geom)
	{
		String func_name=getfunction(geom);
		//String query="SELECT * FROM public."+func_name+"('"+geom+"')";
		//Query query1=em.createNativeQuery(query,POIViewModel.class);
		
		/*
		 * Query
		 * query2=em.createNativeQuery("SELECT * FROM public."+func_name+"(:p_geom)");
		 * // Query query1=em.
		 * createNativeQuery("	 SELECT row_to_json(f)::text As feature FROM public."
		 * +func_name+"(:p_int_district,:p_int_tahasil,:p_int_division,:p_chrv_range_cd)) As f "
		 * ); query2.setParameter("p_geom", geom);
		 * 
		 * @SuppressWarnings("unchecked") var result1 = query2.getResultList();
		 */
		Query query1=em.createNativeQuery("SELECT * FROM public."+func_name+"(:p_geom)",POIViewModel.class);
		query1.setParameter("p_geom", geom);
		var result = query1.getResultList();
		List<POIViewModel> resultList = query1.getResultList();
		return resultList;
	}
	public List<AOIViewModel> getAOI(String geom,String bgeom)
	{
		String func_name=aoiSummaryfunction(geom,bgeom);
		Query query1;
		if(bgeom==null || bgeom=="") {
			query1=em.createNativeQuery("SELECT * FROM public."+func_name+"(:p_geom)",AOIViewModel.class);
			query1.setParameter("p_geom", geom);
		}
		else {
			query1=em.createNativeQuery("SELECT * FROM public."+func_name+"(:p_geom,:p_buffergeom)",AOIViewModel.class);
			query1.setParameter("p_geom", geom);
			query1.setParameter("p_buffergeom", bgeom);
		}
		@SuppressWarnings("unchecked")
		List<AOIViewModel> resultList = query1.getResultList();
		return resultList;
	}
	public List<AOIAnalysisViewModel> getAOIAnalysis(String geom,String bgeom)
	{
		Query query1;
		String func_name1="fn_aoi_analysis";
	
		if(bgeom==null || bgeom=="") {
			func_name1="fn_aoi_analysis";
			query1=em.createNativeQuery("SELECT * FROM public."+func_name1+"(:p_geom)",AOIAnalysisViewModel.class);
			query1.setParameter("p_geom", geom);
		}
		else {
			func_name1="fn_buffered_aoi_analysis";
			query1=em.createNativeQuery("SELECT * FROM public."+func_name1+"(:p_geom,:p_buffergeom)",AOIAnalysisViewModel.class);
			query1.setParameter("p_geom", geom);
			query1.setParameter("p_buffergeom", bgeom);
		}
		@SuppressWarnings("unchecked")
		List<AOIAnalysisViewModel> resultList = query1.getResultList();
		return resultList;
	}
	

	
	
}
