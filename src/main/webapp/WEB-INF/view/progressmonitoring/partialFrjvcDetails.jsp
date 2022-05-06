<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
.teal-color {
	background-color: teal;
	color: white;
}
</style>


<script type="text/javascript">

function ViewDetails(fid)
{
    ManageLoader(1);
    $.ajax({
    	async:false,
        url: '/ProgressMonitoring/frjvcCerPointDetailsview',
        data: {
            'nfbId':fid
        },
        contentType: 'application/html; charset=utf-8',
        type: 'GET',
        dataType: 'html',
        success: function(result) {
        	  $('#mbody1').empty();
              $('#mbody1').html(result);
              
              $('#morngNm').empty();
              $('#morngNm').append($('#mrngNm').val());
              $('#mofbType').empty();
              $('#mofbType').append($('#mfbType').val());
              $('#mofbNm').empty();
              $('#mofbNm').append($('#mfbNm').val());
              $('#modivNm').empty();
              $('#modivNm').append($('#mdivNm').val());
              
              $('#pillarDetailsModal').modal('toggle');
              ManageLoader(0);
        },
        error: function(errormessage) {
        	$(".apploader-base").css("display", "none");
         
        }
        
    });
}

</script>

<div class="col-md-12 layout-spacing">
	<div class="statbox widget box box-shadow" id="divfbtbl">

		<div class="widget-content widget-content-area">
			<div class="table-responsive">
				<c:choose>
					<c:when test="${landType==1}">
						<table id="tblNfb" class="table table-bordered"
							style="width: 100%">
							<thead>
								<tr>
									<th>Sl No</th>

						
									<th>NFB Name</th>

									
										<th>NFB Type</th>
									
										<th>Notified Area(Ha.)</th>
								

									<th>Start Date</th>
									<th>Last Date</th>
									<th>Existing Pillar</th>
									<th>Proposed Pillar</th>
									<th>Total Pillar</th>
									<th>JV Perimeter (Km.)</th>
									<th>JVA(Ha.)</th>
									<th>Difference (JVA-NFA)</th>
									<!-- <th>Difference (%)</th> -->
									<!-- <th>MOEF Category</th> -->
									<th>JV Report Submitted Dt.</th>
									<th>FRJVC Clearance Date</th>
									<!-- <th>JV Observation</th>
									<th>Surveyor Name</th> -->
									<th>Action</th>

								</tr>
							</thead>
							<tbody>
								<c:forEach items="${nfbList}" var="item" varStatus="Counter">
									<tr>
										<td class="text-center">${Counter.count}</td>



										<td class="text-left">${item.nfbName}</td>

										
											<td class="text-center">${item.nfbType}</td>
										

										
											<td class="text-right"><fmt:formatNumber
													value="${item.nareaHa}" maxFractionDigits="3"
													minFractionDigits="3"></fmt:formatNumber></td>
									

										<td class="text-center"><fmt:formatDate value="${item.jvSdate}" pattern="dd-MM-yyyy"/> </td>
										<td class="text-center"><fmt:formatDate value="${item.jvEdate}" pattern="dd-MM-yyyy"/> </td>
										<td align="right">${item.jvExistingPnts}</td>
										<td align="right">${item.jvProposePnts}</td>
										<td align="right">${item.jvExistingPnts+item.jvProposePnts}</td>
										
										
										<td align="right"><fmt:formatNumber value="${item.jvPerimeter}"
												maxFractionDigits="3" minFractionDigits="3"></fmt:formatNumber>
										</td>
				
											<td class="text-right"><fmt:formatNumber
													value="${item.jvHa}" maxFractionDigits="3"
													minFractionDigits="3"></fmt:formatNumber></td>
										
										<td align="right"><fmt:formatNumber value="${item.jvHa-item.nareaHa}"
												maxFractionDigits="3" minFractionDigits="3"></fmt:formatNumber>
										</td>
										<%-- <c:set var="average" value="${(item.jvHa+item.nareaHa)/2}"></c:set> --%>
										<!-- <td align="right"><fmt:formatNumber
												value="${((item.jvHa-item.nareaHa)/item.nareaHa)*100}"
												maxFractionDigits="3" minFractionDigits="3"></fmt:formatNumber>
										</td> -->

										<!-- <td>${item.jvCatg}</td> -->
										<td class="text-center"><fmt:formatDate value="${item.jvReportSubmitedDt}" pattern="dd-MM-yyyy"/> </td>
										<td class="text-center"><fmt:formatDate value="${item.frjvcClearDt}" pattern="dd-MM-yyyy"/></td>
										
										<td class='text-center'>

											<div class='btn-group' role='group'>
												<button id='btndefault' type='button'
													class='btn btn-sm btn-info waves-effect waves-light dropdown-toggle'
													data-toggle='dropdown' aria-haspopup='true'
													aria-expanded='false'>
													<i class='fa fa-eye'></i>
												</button>
												<div class='dropdown-menu' aria-labelledby='btndefault'>
												<a href='#' class="dropdown-item"  id="btnView" onclick="ViewDetails(${item.intId});"><i class="fa fa-info">&nbsp;</i>View Pillar Details</a>
													
														<a href='/ProgressMonitoring/pmMapView?fbid=${item.intId}' target="_blank" class='dropdown-item'><i class="fa fa-map-marker">&nbsp;</i>
														Map View</a>

														<!-- <a href='#?fbid=${item.intId}' class='dropdown-item'><i class=''>&nbsp;</i>FRJVC Report</a> -->
														<a href="/projectDocs/download/frjvc/${item.intFkDivision}/${item.chrvFkRangeCd}/${item.chrvFkRangeCd}-${item.intId}-JVR.pdf" target="_balnk" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>FRJVC Report</a>
												</div>
											</div>

										</td>

									</tr>
								</c:forEach>
							</tbody>
						</table>
						<input type="hidden" value="0" id="hdnTotal" />
						<input type="hidden" value="0" id="hdnCurrent" />
					</c:when>

					<c:otherwise>
				No records found!
				</c:otherwise>
				</c:choose>

			</div>
		</div>

	</div>
</div>


<div class="modal fade" id="pillarDetailsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md" style="max-width:90%;overflow:auto">
      <div class="modal-content">
        <div class="modal-header">
           <h5 class="modal-title f-12" id="modalHeader">
             <strong>
             Pillar Details of <i><span id="mofbNm"></span> <span id="mofbType"></span></i>,  
             <i><span id="morngNm"></span></i> Range, 
             <i><span id="modivNm"></span></i> Division
             </strong>
          </h5>
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span>&times;</span></button>
        </div>
        <div class="modal-body p-0" id="mbody1">
         
        </div>
       
      </div>
    </div>
  </div>



<script type="text/javascript">

function ViewDetails2(fid)
{
alert('testing..');
    ManageLoader(1);
    $.ajax({
        url: '/ProgressMonitoring/frjvcCerPointDetailsview',
        data: { 'nfbId':fid},
        contentType: 'application/html; charset=utf-8',
        type: 'GET',
        dataType: "html",
    }
    ,success:function (result) {
        $('#mbody1').empty();
        $('#mbody1').html(result);
        /* $('#morngNm').empty();
        $('#morngNm').append($('#mrngNm').val());
        $('#mofbType').empty();
        $('#mofbType').append($('#mfbType').val());
        $('#mofbNm').empty();
        $('#mofbNm').append($('#mfbNm').val());
        $('#modivNm').empty();
        $('#modivNm').append($('#mdivNm').val());
        $('#stotal').empty();
        $('#svalid').empty();
        $('#sivalid').empty();
        $('#stotal').append($('#hTotal').val());
        $('#svalid').append($('#hvTotal').val());
        $('#sivalid').append($('#hiTotal').val()); */
        $('#pillarDetailsModal').modal('toggle');
        ManageLoader(0);
        //LoadCustomDataTableCustomButtonFunctions('example',['excel', 'print']);
    }
    ,error:function (xhr, status) {
        alert(status);
    }) ; 
}

</script>

 <script>
  //Close the report
  $('#closeButton').on('click', function(e) { 
       $('#divrform').empty();
    });
</script>  



<script type="text/javascript">
	var dtForest;
	init('tblNfb');
	init('tblDLCRev');
	function init(tableid) {
		if ($.fn.DataTable.isDataTable('#' + tableid)) {
			$("#" + tableid).dataTable().fnClearTable();
			$("#" + tableid).dataTable().fnDestroy();
		} else {
			dtForest = $('#' + tableid)
					.DataTable(
							{
								"oLanguage" : {
									"oPaginate" : {
										"sPrevious" : '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>',
										"sNext" : '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>'
									},
									"sInfo" : "Showing page _PAGE_ of _PAGES_",
									"sSearch" : '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
									"sSearchPlaceholder" : "Search...",
									"sLengthMenu" : "Results :  _MENU_",
								},
								"stripeClasses" : [],
								"lengthMenu" : [ 5, 10, 20, 50 ],
								"pageLength" : 10,
								"dom" : '<"row"<"col-md-12"<"row"<"col-md-6"B><"col-md-6"f> > ><"col-md-12"rt> <"col-md-12"<"row"<"col-md-5"i><"col-md-7"p>>> >',
								buttons : {
									buttons : [
											{
												extend : 'pdf',
												className : 'btn btn-danger fa fa-file-pdf-o'
											},
											{
												extend : 'excel',
				
												className : 'btn btn-success fa fa-file-excel-o'
											},
											{
												extend : 'print',
												className : 'btn btn-warning fa fa-print'
											} ]
								}
							});
		}
	}
</script>