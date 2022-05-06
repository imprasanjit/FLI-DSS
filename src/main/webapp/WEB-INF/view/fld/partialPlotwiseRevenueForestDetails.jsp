<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<%-- /*<input id="hdnNFBName" type="hidden" value='${nfbdetail.nfbMaster.nfbName}' />*/ --%>
<div class="table-responsive">

	<table class="table table-sm table-bordered">
	<tbody>
	<tr>
		<td width="25%"><strong>District :</strong></td>
		<td width="25%">${rfModel.getChrvDistrictNm() }</td>
	</tr>
	<tr>
		<td width="25%"><strong>Division :</strong></td>
		<td width="25%">${rfModel.getChrvDivisionNm() }</td>
	</tr>
	<tr>
		<td><strong>Tahasil :</strong></td>
		<td>${rfModel.getChrvTahasilNm() }</td>
	</tr>			
	<tr>
		<td><strong>Range :</strong></td>
		<td>${rfModel.getChrvRangeNm() }</td>
	</tr>
	<tr>
		<td><strong>RI Circle :</strong></td>
		<td>${rfModel.getRic() }</td>
	</tr>
	<tr>
		<td><strong>PS :</strong></td>
		<td>${rfModel.getPs() }</td>
	</tr>
	<tr>
		<td><strong>Village :</td>
		<td>${rfModel.getVillage() }</td>
	</tr>
	<tr>
		<td><strong>Publication Year:</strong></td>
		<td>${rfModel.getPublYear() }</td>
	</tr>
	<tr>
		<td><strong>Khata No :</strong></td>
		<td>${rfModel.getKhataNo() }</td>
	</tr>
	<tr>
		<td><strong>Plot Code :</strong></td>
		<td>${rfModel.getPlotCode() }</td>
	</tr>
	<tr>
		<td><strong>PS :</strong></td>
		<td>${rfModel.getPs() }</td>
	</tr>
	<tr>
		<td><strong>Thana No :</strong></td>
		<td>${rfModel.getThanaNo() }</td>
	</tr>
	<tr>
		<td><strong>Kissam :</strong></td>
		<td>${rfModel.getKissam() }</td>
	</tr>
	<tr>
		<td><strong>ROR Class :</strong></td>
		<td>${rfModel.getRorClass() }</td>
	</tr>
	<tr>
		<td><strong>Land Class :</strong></td>
		<td>${rfModel.getLandClass() }</td>
	</tr>
	<tr>
		<td><strong>Is DLC Forest? :</strong></td>
		<td>${rfModel.getDlc() }</td>
	</tr>
	<tr>
		<td><strong>Area(Acre) :</strong></td>
		<td>${rfModel.getAreaAc() }</td>
	</tr>
	<tr>
		<td><strong>Calculated Area(Acre) :</strong></td>
		<td>${rfModel.getCAreaAc() }</td>
	</tr>
	<tr>
		<td><strong>% of Variation :</strong></td>
		<td>${rfModel.getVariation() }</td>
	</tr>
	<tr>
		<td><strong>FED :</strong></td>
		<td>${rfModel.getFedLand() }</td>
	</tr>
</tbody>
</table>
</div>


