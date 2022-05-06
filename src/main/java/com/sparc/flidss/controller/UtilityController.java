package com.sparc.flidss.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sparc.flidss.model.common.DataCatalogueMaster;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
import com.sparc.flidss.repository.common.DatasetCatalogueMasterRepository;
import com.sparc.flidss.repository.common.DatasetMasterRepository;
import com.sparc.flidss.repository.common.DatasetTagRepository;
import com.sparc.flidss.repository.common.DistrictMasterRepository;
import com.sparc.flidss.repository.common.DivisionMasterRepository;
import com.sparc.flidss.repository.common.RangeMasterRepository;
import com.sparc.flidss.repository.common.TehsilMasterRepository;
import com.sparc.flidss.repository.common.custom.DatasetCatalougeMasterCustomRepo;
import com.sparc.flidss.service.ForestLandDetailsService;
import com.sparc.flidss.utility.CustomUtility;
import com.sparc.flidss.utility.DivisionCountDTO;
import com.sparc.flidss.utility.ValueText;
import com.sun.el.stream.Stream;

@RestController
@RequestMapping("/api/Utility")
public class UtilityController {
	@Autowired
	private RangeMasterRepository rngRepo;
	@Autowired
	private DistrictMasterRepository distRepo;
	@Autowired
	private DivisionMasterRepository divRepo;
	@Autowired
	private TehsilMasterRepository tehsilRepo;

	@Autowired
	private DatasetMasterRepository repoDatasetMaster;
	@Autowired
	private DatasetTagRepository repoDatasetTag;
	@Autowired
	private DatasetCatalogueMasterRepository repoDatasetCatalogueMaster;
	@Autowired
	DivisionMasterRepository repoDivisionMaster;
	@Autowired
	DatasetCatalougeMasterCustomRepo datasetCatalougeMasterCustomRepo;
	@Autowired
	ForestLandDetailsService vectorMaster;
	
	@Autowired
	AutoUserInfoRepository autoUserInfoRepository;

	/*
	 * @GetMapping("/getCircleValueText") public List<ValueText>
	 * getCircleValueText(@RequestParam Integer year) { List<ValueText> obj=new
	 * ArrayList<ValueText>();
	 * utilService.GetCircleList(year).forEach(f->obj.add(new
	 * ValueText(f.getIntId(),f.getChrvCircleNm())));; return obj; }
	 */

	/**
	 * @author Thakur Get All Designation
	 * @param id
	 * @return
	 */
	/*
	 * @GetMapping("/getAllDesignation") public List<MDesination>
	 * getAllDesignation() { return utilService.GetAllDesination(); }
	 * 
	 * @GetMapping("/getAllDesignationValueText") public List<ValueText>
	 * getAllDesignationValueText() { List<ValueText> obj=new
	 * ArrayList<ValueText>(); utilService.GetAllDesination().forEach(f->obj.add(new
	 * ValueText(f.getIntId(),f.getChrvDesignationNm()))); return obj; }
	 */

	/**
	 * @author Thakur Get Role Wise PositionList
	 * @param id
	 * @return
	 */
	/*
	 * @GetMapping("/GetPositionList/{id}") public List<MPosition>
	 * GetPositionList(@PathVariable int id) { List<MPosition> findAll =
	 * utilService.GetPositionList(id); return findAll; }
	 */

	/**
	 * @author Thakur Get All Position list
	 * @return
	 */
	/*
	 * @GetMapping("/GetAllPositionList") public List<MPositionDto>
	 * GetAllPositionList() { List<MPositionDto> findAll =
	 * mpositionRepo.GetAllPositionList(); return findAll; }
	 */

	// GET : Division Wise PositionList
	/*
	 * @GetMapping("/GetRangeListById") public List<RangeMaster>
	 * GetRangeListById(@RequestParam int rid) { List<RangeMaster> allRangeList =
	 * rngRepo.findAll().stream() .filter(x -> x.getRangeMaster().getIntId() ==
	 * rid).sorted(Comparator.comparing(RangeMaster::getChrvRangeNm))
	 * .collect(Collectors.toList()); return allRangeList; }
	 */

	// GET : Circle Wise DivisionList

	/**
	 * @author Thakur Get Circle Wise DivisionList
	 * @param cid
	 * @return
	 */
	/* 2 */

	/**
	 * GET : Phase wise DivisionList
	 * 
	 * @param year
	 * @param session
	 * @return
	 */

	@GetMapping("/getDivision")
	@ResponseBody
	public List<ValueText> getDivision(@RequestParam Integer id) {
		List<ValueText> list = new ArrayList<ValueText>();
		try {
			
			 divRepo.findAll().stream().filter(p -> p.getPhaseMaster().getIntPhase() == id)
					.forEach(e->list.add(new ValueText(e.getPhaseMaster().getIntPhase(),e.getChrvDivisionNm())));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	/*=======================================*/
	@GetMapping("/getRange")
	@ResponseBody
	public List<ValueText> getRange(@RequestParam Integer id) {
		List<ValueText> list = new ArrayList<ValueText>();
		/*
		 * rngRepo.findAll().stream().filter(r->r.getIntId()==id);
		 * System.out.println(rngRepo.findAll().stream().filter(r->r.getIntId()==id));
		 */
		
		 try { rngRepo.findAll().stream().filter(e->e.getPhaseMaster().getIntPhase()==id)
			 .forEach(e->list.add(new ValueText(e.getRangeMaster().getIntId(),e.getChrvRangeNm())));
			 }
		 catch
		 (Exception e) { e.printStackTrace(); }
		
		return list;
	}
	//===============================================================================

	
	/*
	 * @GetMapping("/GetYearWiseDivList")
	 * 
	 * @ResponseBody public List<ValueText> GetYearWiseDivList(@RequestParam int
	 * year, HttpSession session) { try { var divlist = new ArrayList<ValueText>();
	 * List<MDivision> divisionList = new ArrayList<MDivision>();
	 * 
	 * if (!session.getAttribute("divID").toString().equals("0")) { divisionList =
	 * mDivisionRepo.findAll().stream().filter(a -> a.getMPhase().getIntPhaseid() ==
	 * year && a.getMCircle().getIntId() ==
	 * Integer.parseInt(session.getAttribute("cirID").toString()) && a.getIntId() ==
	 * Integer.parseInt(session.getAttribute("divID").toString()))
	 * .collect(Collectors.toList()); } else if
	 * (!session.getAttribute("cirID").toString().equals("0")) { divisionList =
	 * mDivisionRepo.findAll().stream() .filter(a -> a.getMPhase().getIntPhaseid()
	 * == year && a.getIntId() ==
	 * Integer.parseInt(session.getAttribute("divID").toString()))
	 * .collect(Collectors.toList()); }
	 * 
	 * else { divisionList = mDivisionRepo.findAll().stream().filter(a ->
	 * a.getMPhase().getIntPhaseid() == year) .collect(Collectors.toList()); } for
	 * (MDivision d : divisionList) { ValueText item = new ValueText();
	 * item.setText(d.getChrvDivisionNm()); item.setValue(d.getIntId());
	 * divlist.add(item); } return divlist; } catch (Exception ex) { throw ex; } }
	 */

	/*
	 * @Autowired private MRangeRepository rangeRepo;
	 */

	/**
	 * @author Thakur Get Range List by Division id
	 * @param id
	 * @return
	 */
	/*
	 * @GetMapping("/GetRangeList")
	 * 
	 * @ResponseBody public List<MRange> GetRangeList(@RequestParam int id) { var
	 * rangelist = rangeRepo.findAll(Sort.by(Direction.ASC, "chrvRangeNm")).stream()
	 * .filter(f -> f.getMDivision().getIntId() ==
	 * id).distinct().collect(Collectors.toList()); // var
	 * rangelist=_context.m_range.Where(c =>c.int_fk_division == //
	 * id).Include(c=>c.division_id).OrderBy(c=>c.chrv_range_nm).Select(a => new //
	 * SelectListItem { Text = a.chrv_range_nm, Value = //
	 * a.chrv_range_cd}).Distinct().ToList(); return rangelist; }
	 */

	@GetMapping("/dontShowAgain")
	public void dontShowAgain(HttpSession session, @RequestParam String sessionName) {

		session.setAttribute(sessionName, sessionName);
	}

	@GetMapping("/getDatasetValueText")
	public List<ValueText> getDatasetValueText(@RequestParam(required = false, value = "divid[]") String[] divid) {
		List<ValueText> datasetList = new ArrayList<ValueText>();
		try {
			List<String> strdivid = CustomUtility.convertArrayToStringList(divid);
			repoDatasetMaster.findAll().forEach(f -> datasetList.add(new ValueText(f.getIntId(),
					f.getChrvDatasetNm() + " (" + (repoDatasetCatalogueMaster.findAll().stream()
							.filter(cf -> cf.getDatasetMaster().getIntId() == f.getIntId() && (!strdivid.isEmpty()
									? strdivid.contains(cf.getDivisionMaster().getIntId().toString())
									: true))
							.map(m -> m.getDatasetMaster().getIntId()).count()) + ")")));
			// repoDatasetMaster.findAll().forEach(f->datasetList.add(new
			// ValueText(f.getIntId(),f.getChrvDatasetNm())));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return datasetList;
	}

	@GetMapping("/getDatasetTagValueText")
	public List<ValueText> getDatasetTagValueText(@RequestParam(required = false) Integer id) {
		List<ValueText> datasetList = new ArrayList<ValueText>();
		try {
			repoDatasetTag.findAll().stream()
					.filter(f -> f.getDatasetMaster().getIntId() == (id != null ? id : f.getDatasetMaster().getIntId()))
					.forEach(f -> datasetList.add(new ValueText(f.getIntId(),
							f.getChrvTagNm() + "("
									+ (repoDatasetCatalogueMaster.findAll().stream()
											.filter(cf -> cf.getDatasetTag().getIntId() == f.getIntId())
											.map(m -> m.getDatasetTag().getIntId()).count())
									+ ")")));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return datasetList;
	}

	@GetMapping("/getDatasetTagValueTexts")
	public List<ValueText> getDatasetTagValueText(@RequestParam(required = false, value = "dsids[]") String[] dsids,
			@RequestParam(required = false, value = "divids[]") String[] divids) {
		List<ValueText> datasetList = new ArrayList<ValueText>();
		try {
			List<String> strdsids = CustomUtility.convertArrayToStringList(dsids);
			List<String> strdivids = CustomUtility.convertArrayToStringList(divids);

			repoDatasetTag.findAll().stream().filter(f -> strdsids.contains(f.getDatasetMaster().getIntId().toString()))
					.forEach(
							f -> datasetList.add(new ValueText(f.getIntId(),
									f.getChrvTagNm() + "(" + (repoDatasetCatalogueMaster.findAll().stream()
											.filter(cf -> (!strdivids.isEmpty()
													? strdivids.contains(cf.getDivisionMaster().getIntId().toString())
													: true) && cf.getDatasetTag().getIntId() == f.getIntId())
											.map(m -> m.getDatasetTag().getIntId()).count()) + ")")));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return datasetList;
	}

	@GetMapping("/getDataCatalogueMasterList")
	public List<DataCatalogueMaster> getDataCatalogueMasterList(@RequestParam(required = false) Integer id) {
		var res = repoDatasetCatalogueMaster.findAll().stream()
				.filter(f -> f.getDatasetMaster().getIntId() == (id != null ? id : f.getDatasetMaster().getIntId()))
				.collect(Collectors.toList());
		return res;
	}

	@GetMapping("/getDataSourceList")
	public List<ValueText> getDataSourceList(@RequestParam(required = false, value = "tagid[]") String[] tagid,
			@RequestParam(required = false, value = "dsid[]") String[] dsid) {
		List<ValueText> dataSourceList = new ArrayList<ValueText>();

		try {
			List<String> strtagid = CustomUtility.convertArrayToStringList(tagid);
			List<String> strdtSetId = CustomUtility.convertArrayToStringList(dsid);
			List<String> collect = repoDatasetTag.findAll().stream()
					.filter(f -> !strtagid.isEmpty() ? strtagid.contains(f.getIntId().toString())
							: true || !strdtSetId.isEmpty()
									? strdtSetId.contains(f.getDatasetMaster().getIntId().toString())
									: true)
					.map(m -> m.getChrvSource()).distinct().collect(Collectors.toList());
			for (String s : collect) {
				dataSourceList.add(new ValueText(s, s
				/*
				 * + " (" + repoDatasetCatalogueMaster.findAll().stream() .filter(f ->
				 * f.getDatasetTag().getChrvSource().equals(s)) .map(m ->
				 * m.getDatasetTag().getChrvSource()).count() + ")"
				 */

				));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return dataSourceList;
	}

	@GetMapping("/getDivisionCountPerDataSet")
	public List<DivisionCountDTO> getDivisionCountPerDataSet(
			@RequestParam(required = false, value = "dsid[]") String[] dsid) {
		Set<Integer> convertArrayToIntegerList = CustomUtility.convertArrayToIntegerList(dsid);
		List<DivisionCountDTO> divisionCountPerDataSet2 = datasetCatalougeMasterCustomRepo
				.getDivisionCountPerDataSet(convertArrayToIntegerList);
		return divisionCountPerDataSet2;
	}

}
