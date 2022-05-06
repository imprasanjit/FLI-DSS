package com.sparc.flidss.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.repository.common.CircleMasterRepository;
import com.sparc.flidss.repository.common.DivisionMasterRepository;
import com.sparc.flidss.service.DashboardService;
import com.sparc.flidss.service.UtilityChartService;
import com.sparc.flidss.utility.chart.DataLabels;
import com.sparc.flidss.utility.chart.Datum;
import com.sparc.flidss.utility.chart.Series;
import com.sparc.flidss.viewmodel.IGrflProgressCircleWise;
import com.sparc.flidss.viewmodel.IGrflProgressDivisionWise;
import com.sparc.flidss.viewmodel.IGrflProgressRangeWise;

@Service
public class UtilityChartServiceImpl implements UtilityChartService {
	@Autowired
	DashboardService dashboardService;
	@Autowired
	CircleMasterRepository circlerepo;
	@Autowired
	DivisionMasterRepository divRepo;

	@Override
	public List<Series> stackedDrilldownParent() {

		List<Series> obj = new ArrayList<Series>();

		Series series = new Series();
		series.setName("NFB");
		series.setColor("#17b341");
		series.setEnableMouseTracking(true);
		series.setShowInLegend(true);
		series.setDataLabels(new DataLabels(true));
		List<Datum> datumList = new ArrayList<Datum>();

		Series series2 = new Series();
		series2.setName("Land recorded as forest in DLC");
		series2.setColor("#2196f3");
		series2.setEnableMouseTracking(true);
		series2.setShowInLegend(true);
		series2.setDataLabels(new DataLabels(true));
		List<Datum> datumList2 = new ArrayList<Datum>();

		Series series3 = new Series();
		series3.setName("Revenue Forest(as per RoR)");
		series3.setColor("#8dbf42");
		series3.setEnableMouseTracking(true);
		series3.setShowInLegend(true);
		series3.setDataLabels(new DataLabels(true));
		List<Datum> datumList3 = new ArrayList<Datum>();

		List<IGrflProgressCircleWise> grflProgCircleWise = dashboardService.GetGrflProgressCircleWise();
		for (IGrflProgressCircleWise circle : grflProgCircleWise) {

			datumList.add(new Datum(circle.getChrv_circle(),"",circle.getPriority_wise_area_ha()!=null ? circle.getPriority_wise_area_ha().doubleValue()*0.01:0.0,
					circle.getChrv_circle() + "NFBDD"));

			datumList2.add(new Datum(circle.getChrv_circle(),"", circle.getDlc_area_ac()!=null?circle.getDlc_area_ac().doubleValue()/247:0.0,
					circle.getChrv_circle() + "DLCDD"));

			datumList3.add(new Datum(circle.getChrv_circle(),"", circle.getRev_area_ac()!=null?circle.getRev_area_ac().doubleValue()/247:0.0,
					circle.getChrv_circle() + "OREVDD"));
		}
		
		series2.setData(datumList2);
		obj.add(series2);
		
		series3.setData(datumList3);
		obj.add(series3);
		
		series.setData(datumList);
		obj.add(series);

		return obj;
	}
	
	@Override
	public List<Series> stackedDrilldownParent(Set<Integer> phase) {

		List<Series> obj = new ArrayList<Series>();

		Series series = new Series();
		series.setName("NFB");
		series.setColor("#17b341");
		series.setEnableMouseTracking(true);
		series.setShowInLegend(false);
		series.setDataLabels(new DataLabels(true));
		List<Datum> datumList = new ArrayList<Datum>();

		Series series2 = new Series();
		series2.setName("All Circle"); //series2.setName("Land recorded as forest in DLC");
		series2.setColor("#2196f3");
		series2.setEnableMouseTracking(true);
		series2.setShowInLegend(false);
		series2.setDataLabels(new DataLabels(true));
		List<Datum> datumList2 = new ArrayList<Datum>();

		Series series3 = new Series();
		series3.setName("Revenue Forest(as per RoR)");
		series3.setColor("#ffc107");
		series3.setEnableMouseTracking(true);
		series3.setShowInLegend(false);
		series3.setDataLabels(new DataLabels(true));
		List<Datum> datumList3 = new ArrayList<Datum>();

		List<IGrflProgressCircleWise> grflProgCircleWise = dashboardService.GetGrflProgressCircleWise(phase);
		for (IGrflProgressCircleWise circle : grflProgCircleWise) {

			datumList.add(new Datum(circle.getChrv_circle()+" "+ "Circle",circle.getNo_of_fbs(),circle.getDgpsf_ha()!=null ? circle.getDgpsf_ha().doubleValue()*0.01:0.0,
					circle.getChrv_circle() + "NFBDD"));

			datumList2.add(new Datum(circle.getChrv_circle()+" "+ "Circle","", circle.getDlc_area_ac()!=null && circle.getDlc_area_ac()>0 ?circle.getDlc_area_ac().doubleValue()*0.00404686:0.0,
					circle.getChrv_circle() + "DLCDD"));

			datumList3.add(new Datum(circle.getChrv_circle()+" "+ "Circle","", circle.getRev_area_ac()!=null && circle.getRev_area_ac()>0?circle.getRev_area_ac().doubleValue()*0.00404686:0.0,
					circle.getChrv_circle() + "OREVDD"));
		}
		
		series2.setData(datumList2);
		obj.add(series2);
		
		series3.setData(datumList3);
		obj.add(series3);
		
		series.setData(datumList);
		obj.add(series);

		return obj;
	}

	@Override
	public List<Series> stackedDrilldownChild() {
		List<Series> obj = new ArrayList<Series>();

		List<String> cirList = circlerepo.findAll().stream().map(f -> f.getChrvCircle()).collect(Collectors.toList());
		List<IGrflProgressDivisionWise> getGrflProgressDivisionWise = dashboardService.GetGrflProgressDivisionWise();
		List<IGrflProgressRangeWise> getGrflProgressRangeWise = dashboardService.GetGrflProgressRangeWise();
		
		for (String circleName : cirList) {

			/** Division Level **/
			Series series = new Series();
			series.setId(circleName + "NFBDD");
			series.setName("NFB");
			series.setColor("#17b341");
			series.setEnableMouseTracking(true);
			series.setShowInLegend(true);
			series.setDataLabels(new DataLabels(true));
			List<Datum> datumList = new ArrayList<Datum>();

			Series series3 = new Series();
			series3.setId(circleName + "DLCDD");
			series3.setName("DLC");	//series3.setName("Land recorded as forest in DLC");
			series3.setColor("#2196f3");
			series3.setEnableMouseTracking(true);
			series3.setShowInLegend(true);
			series3.setDataLabels(new DataLabels(true));

			List<Datum> datumList3 = new ArrayList<Datum>();
			Series series5 = new Series();
			series5.setShowInLegend(true);
			series5.setEnableMouseTracking(true);
			series5.setColor("#ffc107");
			series5.setDataLabels(new DataLabels(true));
			series5.setId(circleName + "OREVDD");
			series5.setName("Revenue Forest(as per RoR)");
			List<Datum> datumList5 = new ArrayList<Datum>();
			/** End of Division Level **/

			

			for (IGrflProgressDivisionWise grflDiv : getGrflProgressDivisionWise.stream()
					.filter(f -> f.getChrv_circle().equals(circleName)).collect(Collectors.toList())) {
				
				/** Range NFB **/
				Series series7 = new Series();
				series7.setShowInLegend(true);
				series7.setEnableMouseTracking(true);
				series7.setColor("#17b341");
				series7.setDataLabels(new DataLabels(true));
				List<Datum> datumList7 = new ArrayList<Datum>();

				/** Range DLC **/
				Series series8 = new Series();
				series8.setShowInLegend(true);
				series8.setEnableMouseTracking(true);
				series8.setColor("#2196f3");
				series8.setDataLabels(new DataLabels(true));
				List<Datum> datumList8 = new ArrayList<Datum>();

				/** Range Level Revenue Forest(as per RoR) **/
				Series series9 = new Series();
				series9.setShowInLegend(true);
				series9.setEnableMouseTracking(true);
			    series9.setColor("#ffc107");
				series9.setDataLabels(new DataLabels(true));
				List<Datum> datumList9 = new ArrayList<Datum>();

				datumList.add(new Datum(grflDiv.getChrv_division_nm(),"", grflDiv.getPriority_wise_area_ha()!=null?grflDiv.getPriority_wise_area_ha()*0.01:0.0,
						grflDiv.getDivid() + "_NFB_DIV"));// Division
				series7.setId(grflDiv.getDivid() + "_NFB_DIV");// set Range id as per Division Drill down
				series7.setName("NFB");// Range

				datumList3.add(new Datum(grflDiv.getChrv_division_nm(),"", grflDiv.getDlc_area_ac()!=null || grflDiv.getCommon_area_ac()!=null && grflDiv.getRev_area_ac()>0?(grflDiv.getDlc_area_ac()+grflDiv.getCommon_area_ac())/247.105381:0.0,
						grflDiv.getDivid() + "_DLC_DIV")); // Division
				series8.setId(grflDiv.getDivid() + "_DLC_DIV");// set Range id as per Division Drill down
				series8.setName("DLC");// Range	//series8.setName("Land recorded as forest in DLC");// Range

				datumList5.add(new Datum(grflDiv.getChrv_division_nm(),"", grflDiv.getRev_area_ac()!=null && grflDiv.getRev_area_ac()>0?grflDiv.getRev_area_ac()/247.105381:0.0,
						grflDiv.getDivid() + "_OREV_DIV")); // Division
				series9.setId(grflDiv.getDivid() + "_OREV_DIV");// set Range id as per Division Drill down
				series9.setName("Revenue Forest(as per RoR)"); // Range	//series9.setName("Revenue Forest"); // Range

				for (IGrflProgressRangeWise grflRan : getGrflProgressRangeWise.stream()
						.filter(f -> f.getDivid() == grflDiv.getDivid()).collect(Collectors.toList())) {
					
					datumList7.add(new Datum(grflRan.getChrv_range_nm(),grflRan.getNo_of_fbs(), grflRan.getPriority_wise_area_ha()!=null ?grflRan.getPriority_wise_area_ha()*0.01:0.0, "")); // NFB
					datumList8.add(new Datum(grflRan.getChrv_range_nm(),"", (grflRan.getDlc_area_ac()!=null || grflRan.getCommon_area_ac()!=null) && (grflRan.getDlc_area_ac()>0 || grflRan.getCommon_area_ac()>0) ? (grflRan.getDlc_area_ac()+grflRan.getCommon_area_ac()) /247.105381 :0.0, "")); // DLC
					datumList9.add(new Datum(grflRan.getChrv_range_nm(),"", grflRan.getRev_area_ac()!=null && grflRan.getRev_area_ac()>0?grflRan.getRev_area_ac()/247.105381:0.0, "")); // Other																				// Revenue
				}
				
				
				/** Range level **/
				series7.setData(datumList7);	
				obj.add(series7);
				
				series8.setData(datumList8);
				obj.add(series8);
				
				series9.setData(datumList9);
				obj.add(series9);
				/** End of Range level **/
			}

			/** Division Level **/
			series.setData(datumList);
			obj.add(series);
			series3.setData(datumList3);
			obj.add(series3);
			series5.setData(datumList5);
			obj.add(series5);
			/** End of Division Level **/

			
		}
		return obj;
	}
	
	@Override
	public List<Series> stackedDrilldownChild(Set<Integer> phase) {
		List<Series> obj = new ArrayList<Series>();

		List<String> cirList = circlerepo.findAll().stream().map(f -> f.getChrvCircle()).collect(Collectors.toList());
		List<IGrflProgressDivisionWise> getGrflProgressDivisionWise = dashboardService.GetGrflProgressDivisionWise(phase);
		List<IGrflProgressRangeWise> getGrflProgressRangeWise = dashboardService.GetGrflProgressRangeWise();
		
		for (String circleName : cirList) {

			/** Division Level **/
			Series series = new Series();
			series.setId(circleName + "NFBDD");
			series.setName("NFB");
			series.setColor("#17b341");
			series.setEnableMouseTracking(true);
			series.setShowInLegend(true);
			series.setDataLabels(new DataLabels(true));
			List<Datum> datumList = new ArrayList<Datum>();

			Series series3 = new Series();
			series3.setId(circleName + "DLCDD");
			series3.setName("DLC");	//series3.setName("Land recorded as forest in DLC");
			series3.setColor("#2196f3");
			series3.setEnableMouseTracking(true);
			series3.setShowInLegend(true);
			series3.setDataLabels(new DataLabels(true));

			List<Datum> datumList3 = new ArrayList<Datum>();
			Series series5 = new Series();
			series5.setShowInLegend(true);
			series5.setEnableMouseTracking(true);
			series5.setColor("#ffc107");
			series5.setDataLabels(new DataLabels(true));
			series5.setId(circleName + "OREVDD");
			series5.setName("Revenue Forest(as per RoR)");
			List<Datum> datumList5 = new ArrayList<Datum>();
			/** End of Division Level **/

			for (IGrflProgressDivisionWise grflDiv : getGrflProgressDivisionWise.stream()
					.filter(f -> f.getChrv_circle().equals(circleName)).collect(Collectors.toList())) {
				
				/** Range NFB **/
				Series series7 = new Series();
				series7.setShowInLegend(true);
				series7.setEnableMouseTracking(true);
				series7.setColor("#17b341");
				series7.setDataLabels(new DataLabels(true));
				List<Datum> datumList7 = new ArrayList<Datum>();

				/** Range DLC **/
				Series series8 = new Series();
				series8.setShowInLegend(true);
				series8.setEnableMouseTracking(true);
				series8.setColor("#2196f3");
				series8.setDataLabels(new DataLabels(true));
				List<Datum> datumList8 = new ArrayList<Datum>();

				/** Range Level Revenue Forest(as per RoR) **/
				Series series9 = new Series();
				series9.setShowInLegend(true);
				series9.setEnableMouseTracking(true);
			    series9.setColor("#ffc107");
				series9.setDataLabels(new DataLabels(true));
				List<Datum> datumList9 = new ArrayList<Datum>();

				datumList.add(new Datum(grflDiv.getChrv_division_nm()+" "+ "Division",grflDiv.getNo_of_fbs(), grflDiv.getDgpsf_ha()!=null?grflDiv.getDgpsf_ha()*0.01:0.0,
						grflDiv.getDivid() + "_NFB_DIV"));// Division
				series7.setId(grflDiv.getDivid() + "_NFB_DIV");// set Range id as per Division Drill down
				series7.setName("NFB");// Range

				/*datumList3.add(new Datum(grflDiv.getChrv_division_nm(),"", grflDiv.getDlc_area_ac()!=null && grflDiv.getRev_area_ac()>0?grflDiv.getDlc_area_ac()/247:0.0,
						grflDiv.getDivid() + "_DLC_DIV")); // Division*/
				
				datumList3.add(new Datum(grflDiv.getChrv_division_nm()+" "+ "Division","", (grflDiv.getDlc_area_ac()!=null || grflDiv.getCommon_area_ac()!=null) && (grflDiv.getRev_area_ac()>0 || grflDiv.getCommon_area_ac()>0) ?(grflDiv.getDlc_area_ac())*0.00404686:0.0,
						grflDiv.getDivid() + "_DLC_DIV")); // Division
				
				series8.setId(grflDiv.getDivid() + "_DLC_DIV");// set Range id as per Division Drill down
				series8.setName("DLC");// Range //series8.setName("Land recorded as forest in DLC");// Range

				datumList5.add(new Datum(grflDiv.getChrv_division_nm()+" "+ "Division","", grflDiv.getRev_area_ac()!=null && grflDiv.getRev_area_ac()>0?grflDiv.getRev_area_ac()*0.00404686:0.0,
						grflDiv.getDivid() + "_OREV_DIV")); // Division
				series9.setId(grflDiv.getDivid() + "_OREV_DIV");// set Range id as per Division Drill down
				series9.setName("Revenue Forest(as per RoR)"); // Range

				for (IGrflProgressRangeWise grflRan : getGrflProgressRangeWise.stream()
						.filter(f -> f.getDivid() == grflDiv.getDivid()).collect(Collectors.toList())) {
					
					datumList7.add(new Datum(grflRan.getChrv_range_nm(),grflRan.getNo_of_fbs(), grflRan.getDgpsf_ha()!=null ?grflRan.getDgpsf_ha()*0.01:0.0, "")); // NFB
					datumList8.add(new Datum(grflRan.getChrv_range_nm(),"", (grflRan.getDlc_area_ac()!=null || grflRan.getCommon_area_ac()!=null) && (grflRan.getDlc_area_ac()>0 || grflRan.getCommon_area_ac()>0) ? (grflRan.getDlc_area_ac())*0.00404686:0.0, "")); // DLC
					//datumList8.add(new Datum(grflRan.getChrv_range_nm(),"", grflRan.getDlc_area_ac()!=null &&grflRan.getDlc_area_ac()>0?grflRan.getDlc_area_ac()/247:0.0, "")); // DLC
					datumList9.add(new Datum(grflRan.getChrv_range_nm(),"", grflRan.getRev_area_ac()!=null && grflRan.getRev_area_ac()>0?grflRan.getRev_area_ac()*0.00404686:0.0, "")); // Other																				// Revenue
				}
				
				
				/** Range level **/
				series7.setData(datumList7);	
				obj.add(series7);
				
				series8.setData(datumList8);
				obj.add(series8);
				
				series9.setData(datumList9);
				obj.add(series9);
				/** End of Range level **/
			}

			/** Division Level **/
			series.setData(datumList);
			obj.add(series);
			series3.setData(datumList3);
			obj.add(series3);
			series5.setData(datumList5);
			obj.add(series5);
			/** End of Division Level **/

			
		}
		return obj;
	}

	/**
	 * Start of District Level Chart (Show all Division under a particular District)
	 */
	@Override
	public List<Series> stackedDrilldownDivision(Set<Integer> phase,Set<Integer> divid) {

		List<Series> obj = new ArrayList<Series>();

		Series series = new Series();
		series.setName("NFB");
		series.setColor("#17b341");
		series.setEnableMouseTracking(true);
		series.setShowInLegend(true);
		series.setDataLabels(new DataLabels(true));
		List<Datum> datumList = new ArrayList<Datum>();

		Series series2 = new Series();
		series2.setName("DLC"); //series2.setName("Land recorded as forest in DLC");
		series2.setColor("#2196f3");
		series2.setEnableMouseTracking(true);
		series2.setShowInLegend(true);
		series2.setDataLabels(new DataLabels(true));
		List<Datum> datumList2 = new ArrayList<Datum>();

		Series series3 = new Series();
		series3.setName("Revenue Forest(as per RoR)"); //series3.setName("Revenue Forest");
		series3.setColor("#ffc107");
		series3.setEnableMouseTracking(true);
		series3.setShowInLegend(true);
		series3.setDataLabels(new DataLabels(true));
		List<Datum> datumList3 = new ArrayList<Datum>();

		List<IGrflProgressDivisionWise> grflProgDiv = dashboardService.GetGrflProgressDivisionWise(phase).stream().filter(f->divid.contains(f.getDivid())).collect(Collectors.toList());
		for (IGrflProgressDivisionWise div : grflProgDiv) {
			datumList.add(new Datum(div.getChrv_division_nm(),"",div.getDgpsf_ha()!=null ? div.getDgpsf_ha().doubleValue()*0.01:0.0,
					div.getChrv_division_nm() + "NFBDD"));

			datumList2.add(new Datum(div.getChrv_division_nm(),"", (div.getDlc_area_ac()!=null && div.getCommon_area_ac()!=null) && (div.getDlc_area_ac()>0 || div.getCommon_area_ac()>0) ?(div.getDlc_area_ac()+div.getCommon_area_ac())/247.105381:0.0,
					div.getChrv_division_nm() + "DLCDD"));

			datumList3.add(new Datum(div.getChrv_division_nm(),"", div.getRev_area_ac()!=null?div.getRev_area_ac().doubleValue()/247.105381:0.0,
					div.getChrv_division_nm() + "OREVDD"));
		}
		
		series2.setData(datumList2);
		obj.add(series2);
		
		series3.setData(datumList3);
		obj.add(series3);
		
		series.setData(datumList);
		obj.add(series);

		return obj;
	}
	
	@Override
	public List<Series> stackedDrilldownChildRange(Set<Integer> phase,Set<Integer> divid) {
		List<Series> obj = new ArrayList<Series>();

		List<DivisionMaster> division = divRepo.findAll().stream().filter(f->divid.contains(f.getIntId())).collect(Collectors.toList());
		//List<IGrflProgressDivisionWise> getGrflProgressDivisionWise = dashboardService.GetGrflProgressDivisionWise(phase);
		List<IGrflProgressRangeWise> getGrflProgressRangeWise = dashboardService.GetGrflProgressRangeWise();
		
		for (DivisionMaster div : division) {

			/** Range Level **/
			Series series = new Series();
			series.setId(div.getChrvDivisionNm() + "NFBDD");
			series.setName("NFB");
			series.setColor("#17b341");
			series.setEnableMouseTracking(true);
			series.setShowInLegend(true);
			series.setDataLabels(new DataLabels(true));
			List<Datum> datumList = new ArrayList<Datum>();

			Series series3 = new Series();
			series3.setId(div.getChrvDivisionNm() + "DLCDD");
			series3.setName("DLC"); //series3.setName("Land recorded as forest in DLC");
			series3.setColor("#2196f3");
			series3.setEnableMouseTracking(true);
			series3.setShowInLegend(true);
			series3.setDataLabels(new DataLabels(true));

			List<Datum> datumList3 = new ArrayList<Datum>();
			Series series5 = new Series();
			series5.setShowInLegend(true);
			series5.setEnableMouseTracking(true);
			series5.setColor("#ffc107");
			series5.setDataLabels(new DataLabels(true));
			series5.setId(div.getChrvDivisionNm() + "OREVDD");
			series5.setName("Revenue Forest(as per RoR) Forest"); //series5.setName("Revenue Forest");
			List<Datum> datumList5 = new ArrayList<Datum>();
			
			for (IGrflProgressRangeWise grflRan : getGrflProgressRangeWise.stream()
					.filter(f -> f.getDivid() == div.getIntId()).collect(Collectors.toList())) {
				
				datumList.add(new Datum(grflRan.getChrv_range_nm(),grflRan.getNo_of_fbs(), grflRan.getDgpsf_ha()!=null ?grflRan.getDgpsf_ha()*0.01:0.0, "")); // NFB
				datumList3.add(new Datum(grflRan.getChrv_range_nm(),"", (grflRan.getDlc_area_ac()!=null || grflRan.getCommon_area_ac()!=null) && (grflRan.getDlc_area_ac()>0 || grflRan.getCommon_area_ac()>0) ?(grflRan.getDlc_area_ac()+grflRan.getCommon_area_ac())/247.105381:0.0, "")); // DLC
				datumList5.add(new Datum(grflRan.getChrv_range_nm(),"", grflRan.getRev_area_ac()!=null && grflRan.getRev_area_ac()>0?grflRan.getRev_area_ac()/247.105381:0.0, "")); // Other																				// Revenue
			}
			
			series.setData(datumList);
			series5.setData(datumList5);
			series3.setData(datumList3);
			
			
			obj.add(series3);
			obj.add(series5);
			obj.add(series);
			
			/** End of Division Level **/

		}
		return obj;
	}
	
	/** End of District Level Chart*/
} // End of Class
