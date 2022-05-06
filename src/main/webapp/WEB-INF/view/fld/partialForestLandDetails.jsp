<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.teal-color {
background-color:teal;
color:white;
}
</style>

		<div class="col-md-12 layout-spacing">
			<div class="statbox widget box box-shadow" id="divfbtbl">
				<!-- <div class="widget-header">
					<div class="row">
						<div class="col-xl-12 col-md-12 col-sm-12 col-12">
							<h4>Forest Land Details</h4>
						</div>
					</div>
				</div> -->
				<div class="widget-content widget-content-area">
					<div class="table-responsive">
					 <c:choose>
						<c:when test="${landType==1}"> 
						<table id="tblForestDetails" class="table table-bordered"
							style="width: 100%">
							<thead>
								<tr>
									<th>Sl No</th>
								<th>Range</th>
									 <th>FB Name</th>
									<th>NFB Type</th>
									<th>Notified Area(sq km)</th>
									<th>Notification No.</th>
									<th>Notification Date</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${nfbList}" var="item" varStatus="Counter">
									<tr>
										<td class="text-center">${Counter.count}</td>
										 <%-- <c:choose>
											<c:when test="${selection==1}">
												<td class="text-left">${item.tehsilMaster.chrvTahasilNm}</td>
											</c:when>
											<c:otherwise><td class="text-left">${item.rangeMaster.chrvRangeNm}</td></c:otherwise>
										</c:choose> --%>
										
								 <td class="text-left">${item.rangeMaster.chrvRangeNm}</td>
										<td class="text-left">${item.nfbName}</td>
										<td class="text-left">${item.nfbType}</td>
										<td class="text-left">${item.nareaSkqm}</td>
										<td class="text-left">${item.notfNo}</td>
										<td class="text-left">${item.notfDt}</td> 
										<td><button type="button" class="btn btn-sm btn-success waves-effect waves-light"  onclick="BindFBDetails(${item.intId}) "><i aria-hidden="true" class="fa fa-eye" id="btneye" ></i></button>
											 <button type="button" class="btn btn-sm teal-color  waves-effect waves-light"   onclick="MapView(${item.intId},'${item.nfbName}') "><i aria-hidden="true" class="fa fa-map" ></i></button>  
										<!-- data-toggle="modal" data-target="#modal-lg" -->
										</td>

									</tr>
								</c:forEach>
							</tbody>
						</table>
						<input type="hidden" value="0" id="hdnTotal" />
						<input type="hidden" value="0" id="hdnCurrent" />
						</c:when>
						<c:otherwise>
						<c:set var="totalRecord" value="${totalRev}" />
						<c:set var="currentRecord" value="${fn:length(revenueList)}" />
							<table id="tblForestDetails" class="table table-bordered"
							style="width: 100%">
							<thead>
								<tr>
									<th>Sl No</th>
								<th>Village Name</th>
								<c:choose>
								<c:when test="${fSelection==1 }">
									<th>Tahasil</th>
								</c:when>
								<c:otherwise>
									<th>Range</th>
								</c:otherwise>
								</c:choose>
									<th>Khata No</th>
									<th>ROR Plot No</th>
									<th>ROR Area (Acre)</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${revenueList}" var="item" varStatus="Counter">
									<tr>
										<td class="text-center">${Counter.count}</td>
										
								 <td class="text-left">${item.getVillage()}</td>
									
										<c:choose>
								<c:when test="${fSelection==1 }">
									<td>${item.getChrvTahasilNm()}</td>
								</c:when>
								<c:otherwise>
									<td>${item.getChrvRangeNm()}</td>
								</c:otherwise>
								</c:choose>
									<td class="text-left">${item.getKhataNo()}</td>
									<td class="text-left">${item.getPlotNo()}</td>
										<td class="text-left">${item.getAreaAc()}</td>
										<td><button type="button" class="btn btn-sm btn-success waves-effect waves-light"  onclick="BindRfDetails('${item.getVillCode()}','${item.getPlotNo() }') "><i aria-hidden="true" class="fa fa-eye" id="btneye" ></i></button>
											 <button type="button" class="btn btn-sm teal-color  waves-effect waves-light"   onclick="revMapView('${item.getVillage()}','${item.getVillCode()}','${item.getPlotNo()}') "><i aria-hidden="true" class="fa fa-map" ></i></button>  
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<input type="hidden" value=${currentRecord} id="hdnCurrent" />
						<input type="hidden" value=${totalRecord} id="hdnTotal" />
						</c:otherwise>
					</c:choose>
					
					</div>
				</div>
			</div>
		</div>


<div class="modal fade" id="nfbModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="nfb_header"></h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true" id="btnModalClose">&times;</button>
			</div>
			<div class="modal-body" id="mbody">
			<div id="modalDiv"></div>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>


<div class="modal fade" id="rfModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rf_header">Revenue Forest Plot Details</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true" id="btnModalClose">&times;</button>
			</div>
			<div class="modal-body" id="mbody">
			<div id="rfmodalDiv"></div>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>
 <script src="/assets/js/libs/jquery-3.1.1.min.js"></script>
     <script src="/plugins/table/datatable/datatables.js"></script>
      <script src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
var dtForest;
init();
function init()
{
	if ( $.fn.DataTable.isDataTable('#tblForestDetails') ) {
        $("#tblForestDetails").dataTable().fnClearTable();
        $("#tblForestDetails").dataTable().fnDestroy();
	}
	else{
		dtForest= $('#tblForestDetails').DataTable({
		    "oLanguage": {
		        "oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
		        "sInfo": "Showing page _PAGE_ of _PAGES_",
		        "sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
		        "sSearchPlaceholder": "Search...",
		       "sLengthMenu": "Results :  _MENU_",
		    },
		    "stripeClasses": [],
		    "lengthMenu": [5, 10, 20, 50],
		    "pageLength": 10 
		});
	}
}



</script>

	