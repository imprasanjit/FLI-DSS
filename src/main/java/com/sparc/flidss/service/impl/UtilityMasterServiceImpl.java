package com.sparc.flidss.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.CircleMaster;
import com.sparc.flidss.model.common.DistrictDivisionLinkMaster;
import com.sparc.flidss.model.common.DistrictMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.ForestLandTypeMaster;
import com.sparc.flidss.model.common.NfbMaster;
import com.sparc.flidss.model.common.PositionMaster;
import com.sparc.flidss.model.common.RangeMaster;
import com.sparc.flidss.model.common.RasterMasterData;
import com.sparc.flidss.model.common.RiCircleMaster;
import com.sparc.flidss.model.common.TehsilMaster;
import com.sparc.flidss.model.common.VectorMasterData;
import com.sparc.flidss.model.common.VillageMaster;
import com.sparc.flidss.repository.common.AutoUserInfoRepository;
import com.sparc.flidss.repository.common.CircleMasterRepository;
import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;
import com.sparc.flidss.repository.common.DistrictMasterRepository;
import com.sparc.flidss.repository.common.DivisionMasterRepository;
import com.sparc.flidss.repository.common.ForestLandTypeRepository;
import com.sparc.flidss.repository.common.NfbMasterRepository;
import com.sparc.flidss.repository.common.PositionMasterRepository;
import com.sparc.flidss.repository.common.RangeMasterRepository;
import com.sparc.flidss.repository.common.RasterMasterDataRepository;
import com.sparc.flidss.repository.common.RiCircleRepository;
import com.sparc.flidss.repository.common.TehsilMasterRepository;
import com.sparc.flidss.repository.common.VectorMasterDataRepository;
import com.sparc.flidss.repository.common.VillageMasterRepository;
import com.sparc.flidss.service.TripleDESEncryptionService;
import com.sparc.flidss.service.UtilityMasterService;
import com.sparc.flidss.utility.CustomUtility;
import com.sparc.flidss.utility.ValueText;
import com.sparc.flidss.viewmodel.viewUserlist;
import com.sparc.flidss.viewmodel.progressmonitoring.IFrjvcCertifiedpointDetails;

/**
 * Get Common master tables, utility
 * 
 * @author Smita CDate 01 April 2021
 */

@Service
public class UtilityMasterServiceImpl implements UtilityMasterService {
	@Autowired
	private DistrictMasterRepository mDistRepo;
	@Autowired
	private CircleMasterRepository mCircleRepo;
	@Autowired
	private DivisionMasterRepository mDivisionRepo;
	@Autowired
	private RangeMasterRepository mrangeRepo;
	@Autowired
	private TehsilMasterRepository mTehsilRepo;
	@Autowired
	private VillageMasterRepository mVillageRepo;
	@Autowired
	private DistrictDivisionLinkMasterRepository mdistdivlinkRepo;
	@Autowired
	private ForestLandTypeRepository mForestLandTypeRepo;
	@Autowired
	PositionMasterRepository positionRepo;
	@Autowired
	AutoUserInfoRepository aUserInfoRepo;
	@Autowired
	VectorMasterDataRepository vectorMasterRepo;
	@Autowired
	RasterMasterDataRepository rasterMasterRepo;
	@Autowired
	private NfbMasterRepository nfbRepo;
	@Autowired
	private RiCircleRepository ricRepo;
	@Autowired
	private VillageMasterRepository villRepo;
	
	@Autowired
	private TripleDESEncryptionService encService;


	public List<DistrictMaster> GetDistrictList() {
		// TODO Auto-generated method stub
		return mDistRepo.findAll();
	}

	@Override
	public List<CircleMaster> GetCircleList() {
		// TODO Auto-generated method stub
		return mCircleRepo.findAll();
	}

	@Override
	public List<DivisionMaster> GetDivisionList() {
		// TODO Auto-generated method stub
		return mDivisionRepo.findAll(Sort.by(Direction.ASC, "phaseMaster.intId").and(Sort.by(Direction.ASC, "chrvDivisionNm")));
	}

	@Override
	public List<DivisionMaster> GetDistrictwiseDivisionList(int distid) {

		List<DistrictDivisionLinkMaster> list = mdistdivlinkRepo.findAll();
		List<DivisionMaster> divList = new ArrayList<DivisionMaster>();
		divList = (distid == 0) ? list.stream().map(a -> a.getDivisionMaster()).collect(Collectors.toList())
				: list.stream().filter(a -> a.getDistrictMaster().getIntId() == distid).map(a -> a.getDivisionMaster())
						.collect(Collectors.toList());
		return divList;

	}

	@Override
	public List<RangeMaster> GetRangeList() {
		// TODO Auto-generated method stub
		return mrangeRepo.findAll();
	}

	@Override
	public List<RangeMaster> GetDivisionwiseRangeList(int divid) {
		// TODO Auto-generated method stub
		List<RangeMaster> rangeList = mrangeRepo.findAll().stream()
				.filter(a -> a.getDivisionMaster().getIntId() == divid).collect(Collectors.toList());
		return rangeList;
	}

	@Override
	public List<RangeMaster> GetDistwiseRangeList(int distid) {
		// TODO Auto-generated method stub
		List<DistrictDivisionLinkMaster> divList = mdistdivlinkRepo.findAll().stream()
				.filter(a -> a.getDistrictMaster().getIntId() == distid).collect(Collectors.toList());
		List<RangeMaster> rangeList = new ArrayList<RangeMaster>();
		for (DistrictDivisionLinkMaster item : divList) {
			List<RangeMaster> rngList = mrangeRepo.findAll().stream()
					.filter(a -> a.getDivisionMaster().getIntId() == item.getDivisionMaster().getIntId())
					.collect(Collectors.toList());
			rangeList.addAll(rngList);
		}
		// List<RangeMaster>
		// rangeList=mrangeRepo.findAll().stream().filter(a->a.getDivisionMaster().getIntId()==divid).collect(Collectors.toList());
		return rangeList;
	}

	@Override
	public List<TehsilMaster> GetTehsilList() {
		// TODO Auto-generated method stub
		return mTehsilRepo.findAll();
	}

	@Override
	public List<TehsilMaster> GetDistrictwiseTehsilList(int distid) {
		// TODO Auto-generated method stub
		List<TehsilMaster> tehsilList = mTehsilRepo.findAll().stream()
				.filter(a -> a.getDistrictMaster().getIntId() == distid).collect(Collectors.toList());
		return tehsilList;
	}

	@Override
	public List<TehsilMaster> GetDivisionwiseTehsilList(int divtid) {
		// TODO Auto-generated method stub
		List<TehsilMaster> tehsilList = mTehsilRepo.findAll().stream()
				.filter(a -> a.getDivisionMaster().getIntId() == divtid).collect(Collectors.toList());
		return tehsilList;
	}

	@Override
	public List<VillageMaster> GetVillageList() {
		// TODO Auto-generated method stub
		return mVillageRepo.findAll();
	}

	@Override
	public List<ForestLandTypeMaster> GetForestLandType() {
		// TODO Auto-generated method stub
		return mForestLandTypeRepo.findAll();
	}

	/*
	 * @Override public List<PositionMaster> GetRoleWisePositionList() { return
	 * positionRepo.findAll();
	 * 
	 * }
	 */

	@Override
	public List<PositionMaster> GetRoleWisePositionList(int roleid) {
		List<PositionMaster> posList = positionRepo.findAll().stream()
				.filter(a -> a.getRoleMaster().getIntID() == roleid).collect(Collectors.toList());
		return posList;
	}

//	@Override
//	public List<viewUserlist> getRolePositionWiseUserList(int rid, int pid) {
//		List<AutoUserInfoMaster> ulist = aUserInfoRepo.findAll().stream()
//				.filter(a -> a.getRoleMaster().getIntID() == rid && a.getPositionMaster().getIntId() == pid)
//				.collect(Collectors.toList());
//		
//		List<viewUserlist> list=new ArrayList<>();
//		for (AutoUserInfoMaster autoUserInfoMaster : ulist) {
//			viewUserlist userlist=new viewUserlist();			
//			userlist.setChrvNm(autoUserInfoMaster.getChrvNm());
//			userlist.setRole(autoUserInfoMaster.getRoleMaster().getChrvRoleNm());
//			userlist.setPosition(autoUserInfoMaster.getPositionMaster().getChrvPositionNm());
//			userlist.setUserId(autoUserInfoMaster.getChrvUserId());
//			try {
//				userlist.setPassword(encService.decrypt(autoUserInfoMaster.getChrvUserPwd()));
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			userlist.setContactNo(autoUserInfoMaster.getChrvContactNo());
//			list.add(userlist);
//		}
//		return list;
//	}
	@Override
	public List<AutoUserInfoMaster> getRolePositionWiseUserList(int rid, int pid) {
		
		//List<AutoUserInfoMaster> ulist = aUserInfoRepo.findRolePositionWiseUserList(rid, pid);
		
		List<AutoUserInfoMaster> ulist = aUserInfoRepo.findAll().stream()
				.filter(a -> a.getRoleMaster().getIntID() == rid && a.getPositionMaster().getIntId() == pid)
				.collect(Collectors.toList());
		return ulist;
	}

	@Override
	public List<DivisionMaster> GetCircleWiseDivisionList(int cirid) {
		List<DivisionMaster> cirWdivList = mDivisionRepo.findAll().stream()
				.filter(a -> a.getCircleMaster().getIntId() == cirid).collect(Collectors.toList());
		return cirWdivList;
	}
	@Override
	public List<DivisionMaster> GetPhaseWiseDivisionList(int phase) {
		List<DivisionMaster> cirWdivList = mDivisionRepo.findAll().stream()
				.filter(a -> a.getPhaseMaster().getIntPhase() == phase).collect(Collectors.toList());
		return cirWdivList;
	}

	@Override
	public List<VectorMasterData> GetdivWiseLayerList(int divid, int type) {
		List<VectorMasterData> divWvlist = vectorMasterRepo.findAll().stream().filter(
				a -> a.getDivisionMaster().getIntId() == divid && a.getVectorMasterLayerType().getIntId() == type)
				.collect(Collectors.toList());
		// TODO Auto-generated method stub
		return divWvlist;
	}
	
	@Override
	public List<VectorMasterData> GetdivWiseLayerList(Integer[] divid, int type) {
		Set<Integer> divids = CustomUtility.convertArrayToIntegerList(divid);
		List<VectorMasterData> divWvlist = vectorMasterRepo.findAll().stream().filter(
				a -> divids.contains(a.getDivisionMaster().getIntId()) && a.getVectorMasterLayerType().getIntId() == type)
				.collect(Collectors.toList());
		// TODO Auto-generated method stub
		return divWvlist;
	}
	 
	
	@Override
	public List<VectorMasterData> GetdistWiseLayerList(int distid, int type) { // TODO Auto-generated method stub
		List<DistrictDivisionLinkMaster> divlyrList = mdistdivlinkRepo.findAll().stream()
				.filter(a -> a.getDistrictMaster().getIntId() == distid).collect(Collectors.toList());
		List<VectorMasterData> vectorList = new ArrayList<VectorMasterData>();
		for (DistrictDivisionLinkMaster item : divlyrList) {
			List<VectorMasterData> vList = vectorMasterRepo.findAll().stream()
					.filter(a -> a.getDivisionMaster().getIntId() == item.getDivisionMaster().getIntId()
							&& a.getVectorMasterLayerType().getIntId() == type)
					.collect(Collectors.toList());
			vectorList.addAll(vList);
		}
		return vectorList;
	}
	
	@Override
	public List<VectorMasterData> GetdistWiseLayerList(Integer[] distid,Integer[] tehsilid, int type) { // TODO Auto-generated method stub
		Set<Integer> distids = CustomUtility.convertArrayToIntegerList(distid);
		Set<Integer> tehsilids = CustomUtility.convertArrayToIntegerList(tehsilid);
		
		List<DistrictDivisionLinkMaster> divlyrList = mdistdivlinkRepo.findAll().stream()
				.filter(a -> distids.contains(a.getDistrictMaster().getIntId())).collect(Collectors.toList());
		
		List<VectorMasterData> vectorList = new ArrayList<VectorMasterData>();
		for (DistrictDivisionLinkMaster item : divlyrList) {
			List<VectorMasterData> vList = vectorMasterRepo.findAll().stream()
					.filter(a -> a.getDivisionMaster().getIntId() == item.getDivisionMaster().getIntId()
					&& (!tehsilids.isEmpty()? tehsilids.contains(a.getTehsilMaster().getIntId()):true)
							&& a.getVectorMasterLayerType().getIntId() == type)
					.collect(Collectors.toList());
			vectorList.addAll(vList);
		}
		return vectorList;
	}

	@Override
	public List<VectorMasterData> GetAllFlayerList(int distid, int type) {
		// TODO Auto-generated method stub
		List<DistrictDivisionLinkMaster> divlyrList = mdistdivlinkRepo.findAll().stream()
				.filter(a -> a.getDistrictMaster().getIntId() == distid).collect(Collectors.toList());
		List<VectorMasterData> vectorList = new ArrayList<VectorMasterData>();
		for (DistrictDivisionLinkMaster item : divlyrList) {

			List<VectorMasterData> allForestLand = vectorMasterRepo.findAll().stream()
					.filter(a -> a.getDivisionMaster().getIntId() == item.getDivisionMaster().getIntId())
					.collect(Collectors.toList());

			List<VectorMasterData> dgpsFinal = allForestLand.stream()
					.filter(a -> a.getVectorMasterLayerType().getIntId() == 28).collect(Collectors.toList());

			List<VectorMasterData> dgpsDraft = allForestLand.stream()
					.filter(a -> a.getVectorMasterLayerType().getIntId() == 25).collect(Collectors.toList());

			List<VectorMasterData> jv = allForestLand.stream()
					.filter(a -> a.getVectorMasterLayerType().getIntId() == 26).collect(Collectors.toList());

			List<VectorMasterData> cmv = allForestLand.stream()
					.filter(a -> a.getVectorMasterLayerType().getIntId() == 16).collect(Collectors.toList());

			List<VectorMasterData> mmv = allForestLand.stream()
					.filter(a -> a.getVectorMasterLayerType().getIntId() == 17).collect(Collectors.toList());

			List<Integer> finalDivIds = dgpsFinal.stream()
					.map(m -> m.getDivisionMaster() != null && m.getDivisionMaster().getIntId() != null
							? m.getDivisionMaster().getIntId()
							: 0)
					.collect(Collectors.toList());

			List<VectorMasterData> listDgpsDraft = dgpsDraft.stream()
					.filter(f -> finalDivIds.contains(f.getDivisionMaster().getIntId())).collect(Collectors.toList());

			vectorList.addAll(dgpsFinal);
			vectorList.addAll(listDgpsDraft);
		}
		return vectorList;
	}

	@Override
	public VectorMasterData GetAlldivLayer(Integer divid, Integer type) {
		// TODO Auto-generated method stub
		VectorMasterData divWv = vectorMasterRepo.getAllDivLayers(divid, type);
		return divWv;
	}

	@Override
	public List<VectorMasterData> GetAllLayerList(int type) {
		// TODO Auto-generated method stub

		List<VectorMasterData> vList = vectorMasterRepo.findAll().stream()
				.filter(a -> a.getVectorMasterLayerType().getIntId() == type).collect(Collectors.toList());

		return vList;
	}
	
	@Override
	public List<VectorMasterData> getDivLayerList(Integer divid,Integer type) {
		// TODO Auto-generated method stub

		List<VectorMasterData> vList = vectorMasterRepo.findAll().stream()
				.filter(a -> a.getDivisionMaster().getIntId()==divid && a.getVectorMasterLayerType().getIntId() == type).collect(Collectors.toList());

		return vList;
	}
	

	@Override
	public List<VectorMasterData> GetdistWiseThLayerList(int distid, int tahasilid, int type) {
		// TODO Auto-generated method stub
		List<DistrictDivisionLinkMaster> divTahlyrList = mdistdivlinkRepo.findAll().stream()
				.filter(a -> a.getDistrictMaster().getIntId() == distid).collect(Collectors.toList());
		List<VectorMasterData> vectorTahList = new ArrayList<VectorMasterData>();
		for (DistrictDivisionLinkMaster item : divTahlyrList) {
			List<VectorMasterData> vtList = vectorMasterRepo.findAll().stream()
					.filter(a -> a.getDivisionMaster().getIntId() == item.getDivisionMaster().getIntId()
							&& (a.getTehsilMaster() != null ? a.getTehsilMaster().getIntId() : 0) == tahasilid
							&& (a.getVectorMasterLayerType() != null ? a.getVectorMasterLayerType().getIntId()
									: 0) == type)
					.collect(Collectors.toList());
			vectorTahList.addAll(vtList);
		}
		return vectorTahList;
	}

	@Override
	public List<ValueText> getCustomQueryFieldsNFB() {
		List<ValueText> obj = new ArrayList<ValueText>();
		//ValueText(String value, String text,Boolean isChecked, Boolean isNumeric)
		obj.add(new ValueText("nfbName", "FB Name", true,false));
		obj.add(new ValueText("nfbType", "FB Type", true,false));
		obj.add(new ValueText("nareaHa", "Notified Aera(Ha.)", true, true));
		obj.add(new ValueText("notfNo", "Notification No.", false,false));
		obj.add(new ValueText("notfDt", "Notification Date", false,false));
		obj.add(new ValueText("dgpsdHa", "DGPS Area(Ha.)", true, true));
		obj.add(new ValueText("jvHa", "JV Area(Ha.)", false, true));
		obj.add(new ValueText("cmvHa", "CMV Area(Ha.)", false, true));
		// obj.add(new ValueText("int_fk_phase",""));

		// obj.add(new ValueText("circle","Circle",false));
		obj.add(new ValueText("division", "Division", true,false));
		obj.add(new ValueText("range", "Range", true,false));

		return obj;
	}

	@Override
	public List<ValueText> getCustomQueryFieldsDLC() {
		List<ValueText> obj = new ArrayList<ValueText>();

		obj.add(new ValueText("district", "District", true,false));
		obj.add(new ValueText("division", "Division", false,false));
		obj.add(new ValueText("range", "Range", false, false));
		obj.add(new ValueText("tahasil", "Tahsil", true,false));
		obj.add(new ValueText("village", "Village", true));
		obj.add(new ValueText("khata_no", "Khata no.", true, false));
		obj.add(new ValueText("plot_no", "ROR Plot no.", true, false));
		obj.add(new ValueText("area_ac", "ROR Area(Acre)", true, true));
		obj.add(new ValueText("ric", "RI Circle", false, false));
		obj.add(new ValueText("publ_year", "Publication Year", false, true));
		obj.add(new ValueText("ps", "PS", false, false));
		obj.add(new ValueText("thanaNo", "Thana No.", false, false));
		obj.add(new ValueText("kissam", "Kissam", false, false));
		obj.add(new ValueText("rorClass", "ROR Class", false, false));
		obj.add(new ValueText("landClass", "Land Class", false, false));
		obj.add(new ValueText("dlc", "Is DLC Forest", false, false));
		return obj;
	}
	
	@Override
	public List<ValueText> getCustomQueryFieldsCALanBank() {
		List<ValueText> obj = new ArrayList<ValueText>();

		obj.add(new ValueText("district", "District", true,false));
		obj.add(new ValueText("division", "Division", false,false));
		obj.add(new ValueText("range", "Range", false, false));
		obj.add(new ValueText("tahasil", "Tahsil", true,false));
		obj.add(new ValueText("village", "Village", true));
		obj.add(new ValueText("khata_no", "Khata no.", true, false));
		obj.add(new ValueText("plot_no", "ROR Plot no.", true, false));
		obj.add(new ValueText("area_ac", "ROR Area(Acre)", true, true));
		obj.add(new ValueText("carea_ac", "GIS Area(Acre)", false, false));
		obj.add(new ValueText("ric", "RI Circle", false, false));
		obj.add(new ValueText("publ_year", "Publication Year", false, false));
		obj.add(new ValueText("ps", "PS", false, false));
		obj.add(new ValueText("thanaNo", "Thana No.", false, false));
		obj.add(new ValueText("kissam", "Kissam", false, false));
		obj.add(new ValueText("rorClass", "ROR Class", false, false));
		obj.add(new ValueText("landClass", "Land Class", false, false));
		obj.add(new ValueText("dlc", "Is DLC Forest", false, false));
		obj.add(new ValueText("slope_deg", "Slop (e.g 0-15, 15-30 )", false, true));
		return obj;
	}

	@Override
	public List<RasterMasterData> GetdivWiseRasterLayerList(int divid, int type) {
		List<RasterMasterData> divWrlist = rasterMasterRepo.findAll().stream().filter(
				a -> a.getDivisionMaster().getIntId() == divid && a.getRasterMasterLayerType().getIntId() == type)
				.collect(Collectors.toList());
		// TODO Auto-generated method stub
		return divWrlist;
	}

	@Override
	public RasterMasterData GetAllDivRLayer(Integer divid, Integer type) {
		// TODO Auto-generated method stub
		RasterMasterData divWr = rasterMasterRepo.getAllDivLayers(divid, type);
		return divWr;
	}

	@Override
	public List<RasterMasterData> GetAllRasterList(int type) {
		// TODO Auto-generated method stub

		List<RasterMasterData> rList = rasterMasterRepo.findAll().stream()
				.filter(a -> a.getRasterMasterLayerType().getIntId() == type).collect(Collectors.toList());

		return rList;
	}

	@Override
	public List<VectorMasterData> GetAllFLLayer(int divid) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public VectorMasterData GetAlldisLayer( Integer type) {
		VectorMasterData divWv = vectorMasterRepo.getAllDisLayers(type);
		return divWv;
	}
	@Override
	public List<NfbMaster> GetRangeWiseFBList(int divid,String rid) {
		// TODO Auto-generated method stub
		List<NfbMaster> fbList = nfbRepo.getRangewiseFB(divid, rid);
		return fbList;
	}
	@Override
	public List<RiCircleMaster> GetTehsilWiseRIList(int tid) {
		// TODO Auto-generated method stub
		List<RiCircleMaster> riList = ricRepo.findAll().stream()
				.filter(a -> a.getTehsilMaster().getIntId()== tid )
				.collect(Collectors.toList());
		return riList;
	}
	@Override
	public List<VillageMaster> GetRICircleWiseVillageList(int tid,String ricname) {
		// TODO Auto-generated method stub
		List<VillageMaster> villList = villRepo.findAll().stream()
				.filter(a -> a.getTehsilMaster().getIntId()== tid && a.getRicName().equals(ricname) )
				.collect(Collectors.toList());
		return villList;
	}
	
}
