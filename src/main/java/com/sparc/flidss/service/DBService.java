package com.sparc.flidss.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.ui.Model;

import com.sparc.flidss.model.common.NfbDetail;
import com.sparc.flidss.model.common.RevnueForestMaster;
import com.sparc.flidss.model.common.SacntuaryBoundary;
import com.sparc.flidss.viewmodel.AOIAnalysisViewModel;
import com.sparc.flidss.viewmodel.AOIViewModel;
import com.sparc.flidss.viewmodel.POIViewModel;
import com.sparc.flidss.viewmodel.SP_NFBViewModel;
import com.sparc.flidss.viewmodel.UvwNfbDetails;

public interface DBService {
		List<Object[]> getLayerInfo(String layer,Integer distid,Integer divid,Integer tehsilid,String rangeCode);
		List<SP_NFBViewModel> getNFBLayer(String layer,Integer distid,Integer divid,String rangeCode);

		List<POIViewModel> getPOI(String geom);
		List<AOIViewModel> getAOI(String geom,String bgeom);
		//List<NfbDetail> getNfbDetails(String filter);

		List<UvwNfbDetails> getNfbDetails(String filter);
		List<SacntuaryBoundary> getSancLayers(Integer divid);
		List<AOIAnalysisViewModel> getAOIAnalysis(String geom,String bgeom);
		
		
		List<RevnueForestMaster> getRevVillageList(Model model, Integer selection, Integer dist_id, Integer div_id,
				Integer tahasil_id, String range_code, Integer pageNo, Integer pageSize, String filter);
		List<RevnueForestMaster> getDLCVillageList(Model model, Integer selection, Integer dist_id, Integer div_id,
				Integer tahasil_id, String range_code, Integer pageNo, Integer pageSize, String filter);
		
}
