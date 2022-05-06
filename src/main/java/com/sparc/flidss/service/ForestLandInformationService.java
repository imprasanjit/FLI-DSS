package com.sparc.flidss.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sparc.flidss.viewmodel.SP_NFBViewModel;
/**
 * @author Smita
 * @CDate 10 April 2021
 */
@Service
public class ForestLandInformationService {
	
	@Autowired DBService dbService;
	
	/**
	 * @implNote ForestLand Layer List from Post GIS
	 * @return List<Object[]>
	 * @param (layer ,distid ,divid ,tehsilid ,rangeCode)
	 * @author Smita
	 * @CDate 20 April 2021
	 */
	public List<Object[]> getLayerInfo(String layer, Integer distid, Integer divid, Integer tehsilid, String rangeCode) {
		try {
			List<Object[]> objList=new ArrayList<Object[]>();
			objList=dbService.getLayerInfo(layer, distid, divid, tehsilid, rangeCode);
			return objList;
		}
		catch(Exception ex) {
			throw ex;
		}
	}
	
	/**
	 * Get Notified Forest Block Spatial Layers
	 * @param (layer,distid, divid,rangeCode )
	 * @return List<SP_NFBViewModel>
	 * @author Created by- Smita
	 * @CDate 20 April 2021
	 */
	
	/*
	 * public List<SP_NFBViewModel> getNFBLayerForFli() { try {
	 * List<SP_NFBViewModel> objList = dbService.getNFBLayerForFli("nfb"); if
	 * (objList.size() > 0) return objList; else return new
	 * ArrayList<SP_NFBViewModel>(); } catch (Exception ex) { throw ex; } }
	 */
}
