package com.sparc.flidss.service;

import java.util.List;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.CircleMaster;
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
import com.sparc.flidss.utility.ValueText;
import com.sparc.flidss.viewmodel.viewUserlist;
import com.sparc.flidss.viewmodel.progressmonitoring.IFrjvcCertifiedpointDetails;

public interface UtilityMasterService {
	List<DistrictMaster> GetDistrictList();

	List<CircleMaster> GetCircleList();

	List<DivisionMaster> GetDivisionList();

	List<DivisionMaster> GetDistrictwiseDivisionList(int distid);

	List<RangeMaster> GetRangeList();

	List<RangeMaster> GetDivisionwiseRangeList(int divid);

	List<RangeMaster> GetDistwiseRangeList(int distid);

	List<TehsilMaster> GetTehsilList();

	List<TehsilMaster> GetDistrictwiseTehsilList(int distid);

	List<TehsilMaster> GetDivisionwiseTehsilList(int divtid);

	List<VillageMaster> GetVillageList();

	List<ForestLandTypeMaster> GetForestLandType();

	List<PositionMaster> GetRoleWisePositionList(int roleid);

	/* List<PositionMaster> GetRoleWisePositionList(); */
	//List<viewUserlist> getRolePositionWiseUserList(int rid, int pid);
	List<AutoUserInfoMaster> getRolePositionWiseUserList(int rid, int pid);

	List<DivisionMaster> GetCircleWiseDivisionList(int cirId);

	List<VectorMasterData> GetdivWiseLayerList(int divid, int type);

	List<VectorMasterData> GetdistWiseLayerList(int distid, int type);

	List<VectorMasterData> GetdistWiseThLayerList(int distid, int tahasilid, int type);

	List<VectorMasterData> GetAllLayerList(int type);

	List<ValueText> getCustomQueryFieldsNFB();

	List<ValueText> getCustomQueryFieldsDLC();

	List<ValueText> getCustomQueryFieldsCALanBank();

	VectorMasterData GetAlldivLayer(Integer divid, Integer type);

	List<VectorMasterData> getDivLayerList(Integer divid, Integer type);

	List<RasterMasterData> GetdivWiseRasterLayerList(int divid, int type);

	RasterMasterData GetAllDivRLayer(Integer divid, Integer type);

	List<RasterMasterData> GetAllRasterList(int type);

	List<VectorMasterData> GetAllFlayerList(int distid, int type);

	List<VectorMasterData> GetAllFLLayer(int divid);

	VectorMasterData GetAlldisLayer(Integer type);

	List<NfbMaster> GetRangeWiseFBList(int divid, String rid);

	List<RiCircleMaster> GetTehsilWiseRIList(int tid);

	List<VillageMaster> GetRICircleWiseVillageList(int tid, String ricname);

	List<VectorMasterData> GetdivWiseLayerList(Integer[] divid, int type);

	List<VectorMasterData> GetdistWiseLayerList(Integer[] distid, Integer[] tehsilid, int type);

	List<DivisionMaster> GetPhaseWiseDivisionList(int phase);

}
