package com.sparc.flidss.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.sparc.flidss.model.common.NfbDetail;
import com.sparc.flidss.model.common.NfbMaster;
import com.sparc.flidss.model.common.RevnueForestMaster;
import com.sparc.flidss.model.common.SacntuaryBoundary;
import com.sparc.flidss.model.common.VectorMasterData;
import com.sparc.flidss.repository.common.NfbDetailsRepository;
import com.sparc.flidss.repository.common.NfbMasterRepository;
import com.sparc.flidss.repository.common.RevnueForestMasterRepository;
import com.sparc.flidss.repository.common.SacntuaryBoundaryRepository;
import com.sparc.flidss.repository.common.VectorMasterDataRepository;
import com.sparc.flidss.utility.ValueText;
import com.sparc.flidss.viewmodel.AOIAnalysisViewModel;
import com.sparc.flidss.viewmodel.AOIViewModel;
import com.sparc.flidss.viewmodel.INfbDetails;
import com.sparc.flidss.viewmodel.INfbDetailsV2;
import com.sparc.flidss.viewmodel.INfbDlcDivwiseArea;
import com.sparc.flidss.viewmodel.INfbFbwiseArea;
import com.sparc.flidss.viewmodel.INfbStatistics;
import com.sparc.flidss.viewmodel.POIViewModel;
import com.sparc.flidss.viewmodel.SP_NFBViewModel;
import com.sparc.flidss.viewmodel.UvwNfbDetails;

@Service
public class ForestLandDetailsService {


@Autowired private UtilityMasterService service;
@Autowired NfbMasterRepository nfbRepo;
@Autowired NfbDetailsRepository nfbdetailsRepo;
@Autowired SacntuaryBoundaryRepository sacnRepo;


/**
 * Get Notified Forest Block Lists
 * @param (selection, dist_id, div_id, tahasil_id, range_code, pageNo, pageSize)
 * @return List<RevnueForestMaster>
 * @author Created by- Smita
 * @CDate 20 April 2021
 */
public List<NfbMaster> getNFBList(Model model, Integer selection, Integer dist_id, Integer div_id, Integer tahasil_id, String range_code)
{
    try {
    	List<NfbMaster> nfbList=new ArrayList<NfbMaster>();
		if(selection==1)
		{
			List<ValueText> obj=new ArrayList<ValueText>();
			service.GetDistrictwiseDivisionList(dist_id).forEach(f->obj.add(new ValueText(f.getIntId(),f.getChrvDivisionNm())));
			for(var data :obj)
			{
				List<NfbMaster> nfbData=new ArrayList<NfbMaster>();
				if(range_code!=null && !range_code.equals(""))
				{
					nfbData=nfbRepo.findAll(Sort.by(Direction.ASC,"RangeMaster.chrvRangeCd")).stream().filter(a->a.getDivisionMaster().getIntId()==data.getValue() && a.getRangeMaster().getChrvRangeCd().equals(range_code)).collect(Collectors.toList());
							
				}
				else
				{
					nfbData=nfbRepo.findAll(Sort.by(Direction.ASC,"RangeMaster.chrvRangeCd")).stream().filter(a->a.getDivisionMaster().getIntId()==data.getValue()).collect(Collectors.toList());
				}
				nfbList.addAll(nfbData);
			}
		}
		else
		{
			List<NfbMaster> nfbData=new ArrayList<NfbMaster>();
			if(range_code!=null && !range_code.equals(""))
			{
				nfbData=nfbRepo.findAll(Sort.by(Direction.ASC,"RangeMaster.chrvRangeCd")).stream().filter(a->a.getDivisionMaster().getIntId()==div_id && a.getRangeMaster().getChrvRangeCd().equals(range_code)).collect(Collectors.toList());
			}
			else
			{
				nfbData=nfbRepo.findAll(Sort.by(Direction.ASC,"RangeMaster.chrvRangeCd")).stream().filter(a->a.getDivisionMaster().getIntId()==div_id).collect(Collectors.toList());
			}
			nfbList.addAll(nfbData);
		}
		return nfbList;
    }
    catch(Exception ex)
    {
    	throw ex;
    }
}

/**
 * Get Notified Forest Block Lists
 * @param (selection, dist_id, div_id, tahasil_id, range_code, pageNo, pageSize)
 * @return List<RevnueForestMaster>
 * @author Created by- Smita
 * @CDate 20 April 2021
 */
public List<NfbDetail> getNFBDetails(Model model, Integer selection, Integer dist_id, Integer div_id, Integer tahasil_id, String range_code)
{
    try {
    	List<NfbDetail> nfbList=new ArrayList<NfbDetail>();
		if(selection==1)
		{
			List<ValueText> obj=new ArrayList<ValueText>();
			service.GetDistrictwiseDivisionList(dist_id).forEach(f->obj.add(new ValueText(f.getIntId(),f.getChrvDivisionNm())));
			for(var data :obj)
			{
				List<NfbDetail> nfbData=new ArrayList<NfbDetail>();
				if(range_code!=null && !range_code.equals(""))
				{
					nfbData=nfbdetailsRepo.findAll(Sort.by(Direction.ASC,"NfbMaster.RangeMaster.chrvRangeCd")).stream().
							filter(a-> a.isDelete==false && a.getNfbMaster().getDivisionMaster().getIntId()==data.getValue()).collect(Collectors.toList());
							
				}
				else
				{
					nfbData=nfbdetailsRepo.findAll(Sort.by(Direction.ASC,"NfbMaster.RangeMaster.chrvRangeCd")).stream()
							.filter(a->a.isDelete==false && a.getDivisionMaster().getIntId()==data.getValue()).collect(Collectors.toList());
				}
				nfbList.addAll(nfbData);
			}
		}
		else
		{
			List<NfbDetail> nfbData=new ArrayList<NfbDetail>();
			if(range_code!=null && !range_code.equals(""))
			{
				nfbData=nfbdetailsRepo.findAll(Sort.by(Direction.ASC,"NfbMaster.RangeMaster.chrvRangeCd")).stream()
						.filter(a->a.isDelete==false && a.getDivisionMaster().getIntId()==div_id && a.getNfbMaster().getRangeMaster().getChrvRangeCd().equals(range_code)).collect(Collectors.toList());
			}
			else
			{
				nfbData=nfbdetailsRepo.findAll(Sort.by(Direction.ASC,"NfbMaster.RangeMaster.chrvRangeCd")).stream()
						.filter(a->a.isDelete==false && a.getDivisionMaster().getIntId()==div_id).collect(Collectors.toList());
			}
			nfbList.addAll(nfbData);
		}
		return nfbList;
    }
    catch(Exception ex)
    {
    	throw ex;
    }
}



/**
 * Get Notified Forest Block Details
 * @param (fid)
 * @return NfbDetail
 * @author Created by- Smita
 * @CDate 20 April 2021
 */
public NfbDetail getNFBDetails(Integer fid)
{
	try {
		NfbDetail nfbdetail=nfbdetailsRepo.findBynfbMaster(nfbRepo.findById(fid).get());
		if(nfbdetail!=null)
			return nfbdetail;
		else
			return new NfbDetail();
	}
	catch(Exception ex)
	{
		throw ex;
	}
}

@Autowired DBService dbService;
/**
 * Get Notified Forest Block Spatial Layers
 * @param (layer,distid, divid,rangeCode )
 * @return List<SP_NFBViewModel>
 * @author Created by- Smita
 * @CDate 20 April 2021
 */
public List<SP_NFBViewModel> getNFBLayers(String layer,Integer distid,Integer divid,String rangeCode)
{
	try {
		List<SP_NFBViewModel> objList=dbService.getNFBLayer(layer, distid, divid, rangeCode);
		if(objList.size()>0)
			return objList;
		else
			return new ArrayList<SP_NFBViewModel>();
	}
	catch(Exception ex)
	{
		throw ex;
	}
}

/**
 * Get Sanctuary Layers
 * @param (distid, divid)
 * @author Created by- Smruti
 * @CDate 11 October 2021
 */
/*
 * public List<SacntuaryBoundary> getSancLayers(Integer divid) { try {
 * List<SacntuaryBoundary> objList=dbService.getSancLayers( divid);
 * if(objList.size()>0) return objList; else return new
 * ArrayList<SacntuaryBoundary>(); } catch(Exception ex) { throw ex; } }
 */

@Autowired
RevnueForestMasterRepository rfMasterRepo;
	/**
	 * Get Revenue Village List
	 * @param (selection, dist_id, div_id, tahasil_id, range_code, pageNo, pageSize)
	 * @return List<RevnueForestMaster>
	 * @author Created by- Madhu , Updated By- Smita, 
	 * @CDate 20 April 2021
	 * @UDate 02 March 2021
	 */
    public List<RevnueForestMaster> getRevVillageList(Model model, Integer selection, Integer dist_id, Integer div_id, Integer tahasil_id, String range_code,Integer pageNo, Integer pageSize)
    {
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<RevnueForestMaster> pagedResult;
		/* Selection is based upon filter of location (District-1 / Division-2) */
        if(selection==1)
		{
			model.addAttribute("selection", selection);
			if(tahasil_id!=null && tahasil_id!=0)
			{	
				pagedResult=rfMasterRepo.getDist_TahsilwiseRevenueRecord(dist_id, tahasil_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDist_TahsilwiseTotalRecord(dist_id,tahasil_id));
			}
			else {
				pagedResult=rfMasterRepo.getDistwiseRevenueRecord(dist_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDistwiseTotalRecord(dist_id));
			}
		}
		else {
			if(range_code!=null && !range_code.equals(""))
			{			
				pagedResult=rfMasterRepo.getDiv_rangewiseRevenueRecord(div_id, range_code, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDiv_rangewiseTotalRecord(div_id,range_code));
			}
			else {
				pagedResult=rfMasterRepo.getDivwiseRevenueRecord(div_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDiviwiseTotalRecord(div_id));
			}
		}
        
        if(pagedResult.hasContent()) {
            return pagedResult.getContent();
        } else {
            return new ArrayList<RevnueForestMaster>();
        }
    }
    
    /**
     * @implNote Get DLC Village List
     * @param (selection, dist_id, div_id, tahasil_id, range_code, pageNo, pageSize)
     * @return List<RevnueForestMaster>
     * @author Smita, 
     * @CDate 17 May 2021
     */
    public List<RevnueForestMaster> getDLCVillageList(Model model, Integer selection, Integer dist_id, Integer div_id, Integer tahasil_id, String range_code,Integer pageNo, Integer pageSize)
    {
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<RevnueForestMaster> pagedResult;
		/* Selection is based upon filter of location (District-1 / Division-2) */
        if(selection==1)
		{
			model.addAttribute("selection", selection);
			if(tahasil_id!=null && tahasil_id!=0)
			{	
				pagedResult=rfMasterRepo.getDist_TahsilwiseDLCRecord(dist_id, tahasil_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDist_TahsilwiseDLCRecord(dist_id,tahasil_id));
			}
			else {
				pagedResult=rfMasterRepo.getDistwiseDLCRecord(dist_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDistwiseDLCRecord(dist_id));
			}
		}
		else {
			if(range_code!=null && !range_code.equals(""))
			{			
				pagedResult=rfMasterRepo.getDiv_rangewiseDLCRecord(div_id, range_code, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDiv_rangewiseDLCRecord(div_id,range_code));
			}
			else {
				pagedResult=rfMasterRepo.getDivwiseDLCRecord(div_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDiviwiseDLCRecord(div_id));
			}
		}
        
        if(pagedResult.hasContent()) {
            return pagedResult.getContent();
        } else {
            return new ArrayList<RevnueForestMaster>();
        }
    }
	
    @Autowired VectorMasterDataRepository vectorRepo;  
    /**
     * Get Division wise Vector Layer List
     * @param (fid)
     * @return List<VectorMasterData>
     * @author Created by- Smita
     * @CDate 20 April 2021
     */
    public List<VectorMasterData> getDIvisionwiseVectorLayerList(Integer distid,Integer divid,Integer type)
    {
    	try {
    		List<Integer> obj=new ArrayList<Integer>();
			if(distid!=0)
				{
				service.GetDistrictwiseDivisionList(distid).forEach(f->obj.add(f.getIntId()));
				}
			else {
				obj.add(divid);
			}
			List<VectorMasterData> vectorList=vectorRepo.getDivisionVectorMapTypeLayerList(obj, type);
			if(vectorList.size()>0)
				return vectorList;
			else
				return new ArrayList<VectorMasterData>();
    	}
    	catch(Exception ex)
    	{
    		throw ex;
    	}
    }
    @Autowired VectorMasterDataRepository dlcRepo;  
    /**
     * Get Division wise Vector Layer List
     * @param (fid)
     * @return List<VectorMasterData>
     * @author Created by- Smita
     * @CDate 20 April 2021
     */
    public List<VectorMasterData> getDIvisionwiseDLCLayerList(Integer distid,Integer divid)
    {
    	try {
    		List<Integer> obj=new ArrayList<Integer>();
			if(distid!=0)
				{
				service.GetDistrictwiseDivisionList(distid).forEach(f->obj.add(f.getIntId()));
				}
			else {
				obj.add(divid);
			}
			List<VectorMasterData> DLCList=dlcRepo.getDivisionVectorMapTypeLayerList(obj, 23);
			if(DLCList.size()>0)
				return DLCList;
			else
				return new ArrayList<VectorMasterData>();
    	}
    	catch(Exception ex)
    	{
    		throw ex;
    	}
    }
    
    @Autowired RevnueForestMasterRepository revForestRepo;
    /**
     * Get Revenue Forest Plot/DLC Forest Plot Details
     * @param (villageCode, plotNo)
     * @return RevnueForestMaster
     * @author Created by- Smita
     * @CDate 20 April 2021
     */
    public RevnueForestMaster getRFDetails(String villageCode, String plotNo)
    {
    	try {
    		RevnueForestMaster rfMaster=revForestRepo.getRFDetails(villageCode, plotNo);
    		if(rfMaster!=null)
    			return rfMaster;
    		else
    			return new RevnueForestMaster();
    	}
    	catch(Exception ex)
    	{
    		throw ex;
    	}
    }
    /**
     * Get Notified Forest Block Lists
     * @param (dist_id, div_id,pageNo, pageSize)
     * @author Created by- Smruti
     * @CDate 19 Aug 2021
     */
    public List<NfbMaster> getNFBData(Model model, Integer dist_id, Integer div_id, Integer tahasil_id, String range_code)
    {
        try {
        	List<NfbMaster> nfbList=new ArrayList<NfbMaster>();
    		if(dist_id!=0)
    		{
    			List<ValueText> obj=new ArrayList<ValueText>();
    			service.GetDistrictwiseDivisionList(dist_id).forEach(f->obj.add(new ValueText(f.getIntId(),f.getChrvDivisionNm())));
    			for(var data :obj)
    			{
    				List<NfbMaster> nfbData=new ArrayList<NfbMaster>();
    				
    				if(range_code!=null && !range_code.equals(""))
    				{
    					//nfbData=nfbRepo.findAll(Sort.by(Direction.ASC,"RangeMaster.chrvRangeCd")).stream().filter(a->a.getDivisionMaster().getIntId()==data.getValue()).collect(Collectors.toList());
    					nfbData=nfbRepo.findAll(Sort.by(Direction.ASC,"RangeMaster.chrvRangeCd")).stream().filter(a->a.getDivisionMaster().getIntId()==data.getValue() && a.getRangeMaster().getChrvRangeCd().equals(range_code)).collect(Collectors.toList());		
    				}
    				else
    				{
    					nfbData=nfbRepo.findAll(Sort.by(Direction.ASC,"RangeMaster.chrvRangeCd")).stream().filter(a->a.getDivisionMaster().getIntId()==data.getValue()).collect(Collectors.toList());
    				}
    				nfbList.addAll(nfbData);
    			}
    		}
    		else
    		{
    			List<NfbMaster> nfbData=new ArrayList<NfbMaster>();
    			if(range_code!=null && !range_code.equals(""))
    			{
    				//nfbData=nfbRepo.findAll(Sort.by(Direction.ASC,"RangeMaster.chrvRangeCd")).stream().filter(a->a.getDivisionMaster().getIntId()==div_id).collect(Collectors.toList());
    				nfbData=nfbRepo.findAll(Sort.by(Direction.ASC,"RangeMaster.chrvRangeCd")).stream().filter(a->a.getDivisionMaster().getIntId()==div_id && a.getRangeMaster().getChrvRangeCd().equals(range_code)).collect(Collectors.toList());
    			}
    			else
    			{
    				nfbData=nfbRepo.findAll(Sort.by(Direction.ASC,"RangeMaster.chrvRangeCd")).stream().filter(a->a.getDivisionMaster().getIntId()==div_id).collect(Collectors.toList());
    			}
    			nfbList.addAll(nfbData);
    		}
    		return nfbList;
        }
        catch(Exception ex)
        {
        	throw ex;
        }
    }
    /**
	 * Get Revenue Village List
	 * @param (selection, dist_id, div_id,pageNo, pageSize)
	 * @return List<RevnueForestMaster>
	 * @author Created by- Smruti, 
	 * @CDate 20 Aug 2021
	 */
    public List<RevnueForestMaster> getRevVillageData(Model model, Integer dist_id, Integer div_id,Integer tahasil_id, String range_code,Integer pageNo, Integer pageSize)
    {
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<RevnueForestMaster> pagedResult;
        if(dist_id!=0)
		{
			if(tahasil_id!=null && tahasil_id!=0)
			{	
				pagedResult=rfMasterRepo.getDist_TahsilwiseRevenueRecord(dist_id, tahasil_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDist_TahsilwiseTotalRecord(dist_id,tahasil_id));
			}
			 else {
				pagedResult=rfMasterRepo.getDistwiseRevenueRecord(dist_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDistwiseTotalRecord(dist_id));
			}
		}
		else {
			if(range_code!=null && !range_code.equals(""))
			{			
				pagedResult=rfMasterRepo.getDiv_rangewiseRevenueRecord(div_id, range_code, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDiv_rangewiseTotalRecord(div_id,range_code));
			}
			else {
				pagedResult=rfMasterRepo.getDivwiseRevenueRecord(div_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDiviwiseTotalRecord(div_id));
			}
		}
        
        if(pagedResult.hasContent()) {
            return pagedResult.getContent();
        } else {
            return new ArrayList<RevnueForestMaster>();
        }
    }
    
    /**
     * @implNote Get DLC Village List
     * @param (selection, dist_id, div_id, pageNo, pageSize)
     * @return List<RevnueForestMaster>
     * @author Smruti, 
     * @CDate 20 Aug 2021
     */
    public List<RevnueForestMaster> getDLCVillageData(Model model, Integer dist_id, Integer div_id,Integer pageNo, Integer pageSize)
    {
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<RevnueForestMaster> pagedResult;
        if(dist_id!=0)
		{
			//model.addAttribute("selection", selection);
			/*if(tahasil_id!=null && tahasil_id!=0)
			{	
				pagedResult=rfMasterRepo.getDist_TahsilwiseDLCRecord(dist_id, tahasil_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDist_TahsilwiseDLCRecord(dist_id,tahasil_id));
			}
			else {*/
				pagedResult=rfMasterRepo.getDistwiseDLCRecord(dist_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDistwiseDLCRecord(dist_id));
			//}
		}
		else {
			/*if(range_code!=null && !range_code.equals(""))
			{			
				pagedResult=rfMasterRepo.getDiv_rangewiseDLCRecord(div_id, range_code, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDiv_rangewiseDLCRecord(div_id,range_code));
			}
			else {*/
				pagedResult=rfMasterRepo.getDivwiseDLCRecord(div_id, paging);
				model.addAttribute("totalRev",rfMasterRepo.getDiviwiseDLCRecord(div_id));
			//}
		}
        
        if(pagedResult.hasContent()) {
            return pagedResult.getContent();
        } else {
            return new ArrayList<RevnueForestMaster>();
        }
    }
    
    public List<INfbDlcDivwiseArea> getNfbDlcDivWiseArea() {
    	return nfbdetailsRepo.getNfbDlcDivWiseArea();
    }
    
    public List<INfbFbwiseArea> getNfbFbwiseArea(Integer divId) {
    	return nfbdetailsRepo.getNfbFbWiseArea(divId);
    }
	/*
	 * public List<SacntuaryBoundary> getSancLayers(Integer divId) { return
	 * sacnRepo.getSancLayers(divId); }
	 */
    /**
     * Get POI
     * @param (geom )
     * @return List<POIViewModel>
     * @author Created by- Smruti
     * @CDate 21 Oct 2021
     */
    public List<POIViewModel> getPOI(String geom)
    {
    	try {
    		List<POIViewModel> objList=dbService.getPOI(geom);
    		if(objList.size()>0)
    			return objList;
    		else
    			return new ArrayList<POIViewModel>();
    	}
    	catch(Exception ex)
    	{
    		throw ex;
    	}
    }
    /**
     * Get AOI
     * @param (geom )
     * @return List<AOIViewModel>
     * @author Created by- Smruti
     * @CDate 21 Oct 2021
     */
    public List<AOIViewModel> getAOI(String geom,String bgeom)
    {
    	try {
    		List<AOIViewModel> objList=dbService.getAOI(geom,bgeom);
    		if(objList.size()>0)
    			return objList;
    		else
    			return new ArrayList<AOIViewModel>();
    	}
    	catch(Exception ex)
    	{
    		throw ex;
    	}
    }
    
    /**
     * Get AOI Analysis
     * @param (geom )
     * @return List<AOIViewModel>
     * @author Created by- Smruti
     * @CDate 28 Oct 2021
     */
    public List<AOIAnalysisViewModel> getAOIAnalysis(String geom,String bgeom)
    {
    	try {
    		List<AOIAnalysisViewModel> objList=dbService.getAOIAnalysis(geom,bgeom);
    		if(objList.size()>0)
    			return objList;
    		else
    			return new ArrayList<AOIAnalysisViewModel>();
    	}
    	catch(Exception ex)
    	{
    		throw ex;
    	}
    }


	public List<INfbStatistics> getINfbStatistics(Integer divid) {
    	return nfbdetailsRepo.getNFBStatistics(divid);
    }
	
	public List<INfbDetailsV2> getMaxNareaFb(Integer divid,String rangeCode){
		return nfbdetailsRepo.getMaxNareaFb(divid, rangeCode);
	}
	public List<INfbDetailsV2> getMinNareaFb(Integer divid,String rangeCode){
		return nfbdetailsRepo.getMinNareaFb(divid, rangeCode);
	}
	public Double getAvgNarea(Integer divid,String rangeCode) {
		return nfbdetailsRepo.getAvgNarea(divid, rangeCode);
	}
}





