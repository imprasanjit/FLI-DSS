package com.sparc.flidss.service.impl;

import java.sql.Types;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sparc.flidss.repository.common.NfbDetailsRepository;
import com.sparc.flidss.repository.common.custom.IProgressMonitoringPartialRepository;
import com.sparc.flidss.service.ProgressMonitoringService;
import com.sparc.flidss.utility.CustomUtility;
import com.sparc.flidss.viewmodel.SP_NFBViewModel;
import com.sparc.flidss.viewmodel.progressmonitoring.DRFLsummary;
import com.sparc.flidss.viewmodel.progressmonitoring.IFpcppointDetails;
import com.sparc.flidss.viewmodel.progressmonitoring.IFrjvcCertifiedpointDetails;
import com.sparc.flidss.viewmodel.progressmonitoring.IOrsacCertifiedpointDetails;
import com.sparc.flidss.viewmodel.progressmonitoring.UvwNfbSummary;
import com.sparc.flidss.viewmodel.reports.IFnDLCRevDetails;
import com.sparc.flidss.viewmodel.reports.IFnForestLandSummary;

@Service
public class ProgressMonitoringServiceImpl implements ProgressMonitoringService {

	@PersistenceContext
	EntityManager em;

	@Autowired
	IProgressMonitoringPartialRepository repo;

	@Override
	public List<IFrjvcCertifiedpointDetails> getFrjvcCertifiedPointDetails() {
		// TODO Auto-generated method stub

		return repo.getFrjvcCertifiedPointDetails();
	}

	@Override
	public List<IFrjvcCertifiedpointDetails> getFrjvcCertifiedPointDetailsFindByNfbId(Integer nfbId) {
		// TODO Auto-generated method stub

		return repo.getFrjvcCertifiedPointDetailsFindByNfbId(nfbId);
	}

	@Override
	public List<IFrjvcCertifiedpointDetails> getFrjvcCertifiedPointDetails(Integer fbid) {
		// TODO Auto-generated method stub

		return repo.getFrjvcCertifiedPointDetails(fbid);
	}

	@Override
	public List<IOrsacCertifiedpointDetails> getOrsacCertifiedPointDetails(Integer fbid) {
		// TODO Auto-generated method stub

		return repo.getOrsacCertifiedPointDetails(fbid);
	}
	@Override
	public List<IOrsacCertifiedpointDetails> getFscpPointDetails(Integer fbid) {
		// TODO Auto-generated method stub

		return repo.getFscpPointDetails(fbid);
	}
	@Override
	public List<IFpcppointDetails> getFpcpPointDetails(Integer fbid) {
		// TODO Auto-generated method stub
		return repo.getFpcpPointDetails(fbid);
	}
	

	@Override
	public List<IOrsacCertifiedpointDetails> getOrsacCertifiedPointDetails() {
		// TODO Auto-generated method stub
		return repo.getOrsacCertifiedPointDetails();
	}

	@Override
	public List<UvwNfbSummary> getNfbSummary(String filter) {

		String query = "select * from uvw_nfb_summary where 1=1 and orsac_clearence_dt IS NOT NULL";
		query += filter;
		query +=" order by chrv_range_nm,nfb_name";
		Query query1 = em.createNativeQuery(query, UvwNfbSummary.class);
		@SuppressWarnings("unchecked")
		List<UvwNfbSummary> uvwNfb = query1.getResultList();

		return uvwNfb;

	}

	@Override
	public UvwNfbSummary getNfbSummary(Integer fbId) {
		String query = "select * from uvw_nfb_summary where int_id=:fbId order by chrv_range_nm,nfb_name";

		Query query1 = em.createNativeQuery(query, UvwNfbSummary.class);
		query1.setParameter("fbId", fbId);
		@SuppressWarnings("unchecked")
		List<UvwNfbSummary> uvwNfb = query1.getResultList();

		if (!uvwNfb.isEmpty()) {
			return uvwNfb.get(0);
		} else {
			return null;
		}
	
	}

	/*
	 * @Override public List<IFnForestLandSummary> getForestlandSummary(Integer
	 * divId, String rngCode, Integer nfbid, String[] fields) { //String
	 * query="select * from public.fn_forest_land_summary(:p_div_id,:p_rng_code,:p_fb_id,:p_selection)"
	 * ;
	 * 
	 * //query+=filter; //Query
	 * query1=em.createNativeQuery(filter,IFnForestLandSummary.class);
	 * 
	 * query1.setParameter("p_div_id",divId); query1.setParameter("p_rng_code",
	 * rngCode); query1.setParameter("p_fb_id", nfbid);
	 * query1.setParameter("p_selection",selection);
	 * 
	 * //@SuppressWarnings("unchecked") //List<IFnForestLandSummary>
	 * fnNfb=query1.getResultList();
	 * 
	 * return repo.getForestlandSummary(divId,rngCode,nfbid,fields); }
	 */

	@Override
	public List<IFnForestLandSummary> getForestlandSummary(Integer divId, String rngCode, Integer nfbid,
			String isRangeExist) {
		// TODO Auto-generated method stub
		return repo.getForestlandSummary(divId, rngCode, nfbid, isRangeExist);
		
	}

	
	  @Override public List<IFnDLCRevDetails> getDLCRevSummary(Integer
	  distid,Integer tehid,String ricname,String Villname,String Fields,String Types[]) { 
		  // TODO Auto-generated method stub 
		  List<String> convertArrayToStringList = CustomUtility.convertArrayToStringList(Types);
	  return repo.getDLCRevSummary(distid,tehid,ricname,Villname,Fields,convertArrayToStringList);
	  
	  }

	@Override
	public List<DRFLsummary> getDrflSummary(String filter) {
		// TODO Auto-generated method stub
		return null;
	}
	 
	/*
	 * @Override public List<IFnDLCRevDetails> getDLCRevSummary(String filter) {
	 * String query = "select * from uvw_dlc_rev_report_details where 1=1"; query +=
	 * filter; Query query1 = em.createNativeQuery(query, IFnDLCRevDetails.class);
	 * 
	 * @SuppressWarnings("unchecked") List<IFnDLCRevDetails> uvwRevDLC =
	 * query1.getResultList(); return uvwRevDLC; }
	 */
}
