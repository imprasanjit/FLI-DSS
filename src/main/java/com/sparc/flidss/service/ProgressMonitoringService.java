package com.sparc.flidss.service;

import java.util.List;

import com.sparc.flidss.viewmodel.progressmonitoring.DRFLsummary;
import com.sparc.flidss.viewmodel.progressmonitoring.IFpcppointDetails;
import com.sparc.flidss.viewmodel.progressmonitoring.IFrjvcCertifiedpointDetails;
import com.sparc.flidss.viewmodel.progressmonitoring.IOrsacCertifiedpointDetails;
import com.sparc.flidss.viewmodel.progressmonitoring.UvwNfbSummary;
import com.sparc.flidss.viewmodel.reports.IFnDLCRevDetails;
import com.sparc.flidss.viewmodel.reports.IFnForestLandSummary;

public interface ProgressMonitoringService {

	List<DRFLsummary>getDrflSummary(String filter);
	List<UvwNfbSummary> getNfbSummary(String filter);
	UvwNfbSummary getNfbSummary(Integer fbId);
	List<IFrjvcCertifiedpointDetails> getFrjvcCertifiedPointDetails();
	List<IFrjvcCertifiedpointDetails> getFrjvcCertifiedPointDetailsFindByNfbId(Integer fbId);
	List<IOrsacCertifiedpointDetails> getOrsacCertifiedPointDetails();
	List<IFrjvcCertifiedpointDetails> getFrjvcCertifiedPointDetails(Integer fbid);
	List<IOrsacCertifiedpointDetails> getOrsacCertifiedPointDetails(Integer fbid);
	//List<IFnForestLandSummary> getForestlandSummary(String filter);
	List<IFnForestLandSummary> getForestlandSummary(Integer divId, String rngCode, Integer nfbid, String isRangeExist);
	List<IOrsacCertifiedpointDetails> getFscpPointDetails(Integer fbid);
	List<IFpcppointDetails> getFpcpPointDetails(Integer fbid);
	List<IFnDLCRevDetails> getDLCRevSummary(Integer distid, Integer tehid, String ricname, String villname,String Fields,String Types[]);
	//List<IFnDLCRevDetails> getDLCRevSummary(String filter);
}
