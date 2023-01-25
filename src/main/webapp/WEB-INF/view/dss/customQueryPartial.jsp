<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
.teal-color {
	background-color: teal;
	color: white;
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
			<%-- <span>${divname}</span> --%>
				<c:choose>
					<c:when test="${landType==1}">
					<%-- <h4>Notified Forest Land Details of <span class="font-italic font-bold" id="spnDivision">${divname}</span>  Division</h4> --%>
					<div class="row" id="customData">
                                
                           <div class="col-md-4"></div>
                           <div class="col-md-8 text-right">
                              <%--  <c:if test='${selectedFields.contains("division")}'> --%>
                              		<span class="badge outline-badge-success badge-pill">
											<span>Land Type : </span><strong id='SpFltype'>NA</strong>	
									</span>
	                                <span class="badge outline-badge-success badge-pill">
											<span>Division : </span><strong id='Spdiv'>NA</strong>	
									</span>
								<%-- </c:if>
								<c:if test='${selectedFields.contains("range")}'> --%>
	                                <span class="badge outline-badge-success badge-pill">
											<span>Range : </span><strong id='Sprange'>NA</strong>	
									</span>
								<%-- </c:if> --%>
								<%-- <c:if test='${selectedFields.contains("district")}'>
										 <span class="badge outline-badge-success badge-pill">
											<span>District : </span><strong id='Spdist'>${distname}</strong>	
										</span>
								</c:if> --%>
								
                             </div>
                     </div>
						<table id="tblNfb" class="table table-bordered"
							style="width: 100%">
							<thead>
								<tr>
									<th>Sl No</th>

									<c:if test='${selectedFields.contains("division")}'>
										<th>Division</th>
									</c:if>

									<c:if test='${selectedFields.contains("range")}'>
										<th>Range</th>
									</c:if>
									<th>FB Name</th>

									<c:if test='${selectedFields.contains("nfbType")}'>
										<th>NFB Type</th>
									</c:if>

									<c:if test='${selectedFields.contains("notfNo")}'>
										<th>Notification No.</th>
									</c:if>

									<c:if test='${selectedFields.contains("notfDt")}'>
										<th>Notification Date</th>
									</c:if>

									<c:if test='${selectedFields.contains("nareaHa")}'>
										<th>Notified Area(Ha.)</th>
									</c:if>

									<c:if test='${selectedFields.contains("cmvHa")}'>
										<th>CMV Area(Ha.)</th>
									</c:if>

									<c:if test='${selectedFields.contains("jvHa")}'>
										<th>JV Area(Ha.)</th>
									</c:if>

									<c:if test='${selectedFields.contains("dgpsdHa")}'>
										<th>DGPS Area(Ha.)</th>
									</c:if>
									
									<th>Map View</th>

									<!-- <th>Action</th> -->
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${nfbList}" var="item" varStatus="Counter">
									<tr>
										<td class="text-center">${Counter.count}</td>
										

										<c:if test='${selectedFields.contains("division")}'>
											<td class="text-left">${item.chrvDivisionNm}</td>
										</c:if>

										<c:if test='${selectedFields.contains("range")}'>
											<td class="text-left">${item.chrvRangeNm}</td>
										</c:if>

										<td class="text-left">${item.nfbName}</td>

										<c:if test='${selectedFields.contains("nfbType")}'>
											<td class="text-center">${item.nfbType}</td>
										</c:if>

										<c:if test='${selectedFields.contains("notfNo")}'>
											<td class="text-left">${item.notfNo}</td>
										</c:if>

										<c:if test='${selectedFields.contains("notfDt")}'>
											<td class="text-left">${item.notfDt}</td>
										</c:if>

										<c:if test='${selectedFields.contains("nareaHa")}'>
											<td class="text-right">
											<fmt:formatNumber value="${item.nareaHa}" maxFractionDigits="3" minFractionDigits="3"></fmt:formatNumber>
											</td>
										</c:if>

										<c:if test='${selectedFields.contains("cmvHa")}'>
											<td class="text-right">
											<fmt:formatNumber value="${item.cmvHa}" maxFractionDigits="3" minFractionDigits="3"></fmt:formatNumber>
											</td>
										</c:if>

										<c:if test='${selectedFields.contains("jvHa")}'>
											<td class="text-right">
											<fmt:formatNumber value="${item.jvHa}" maxFractionDigits="3" minFractionDigits="3"></fmt:formatNumber>
											</td>
										</c:if>

										<c:if test='${selectedFields.contains("dgpsdHa")}'>
											<td class="text-right">
											 <fmt:formatNumber value="${item.dgpsfHa>0?item.dgpsfHa:item.dgpsdHa}" maxFractionDigits="3" minFractionDigits="3"></fmt:formatNumber>
											</td>
										</c:if>

									<td class='text-center'>
									

						<a href='/FLD/forestLandDetails?fbid=${item.intId}' target='_balnk' class="btn btn-sm btn-info waves-effect waves-light"><i class='fa fa-map'></i></a>	
								
						<%-- <div class='btn-group' role='group'>
                         <button id='btndefault' type='button' class='btn btn-sm btn-info waves-effect waves-light dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'><i class='fa fa-map'></i></button>
                         <div class='dropdown-menu' aria-labelledby='btndefault'>
                         <a href='/FLD/forestLandDetails?fbid=${item.intId}' target='_balnk' class='dropdown-item'><i class=''>&nbsp;</i>open in new tab</a>
                         <a href='/FLD/forestLandDetails?fbid=${item.intId}' class='dropdown-item'><i class=''>&nbsp;</i>open in in this tab</a>
                         </div></div> --%>
									
									
									<%-- <button type="button" class="btn btn-sm btn-success waves-effect waves-light"
								onclick="BindFBDetails(${item.intId}) "><i aria-hidden="true" class="fa fa-eye"
									id="btneye"></i></button>
							<button type="button" class="btn btn-sm btn-info waves-effect waves-light"
								onclick="MapView(${item.intId},'${item.nfbMaster.nfbName}') "><i aria-hidden="true"
									class="fa fa-map"></i></button> --%>
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
						<table id="tblDLCRev" class="table table-bordered"
							style="width: 100%">
							<thead>
								<tr>
									<th>Sl No</th>

									<c:if test='${selectedFields.contains("district")}'>
										<th>District</th>
									</c:if>
									<c:if test='${selectedFields.contains("division")}'>
										<th>Division</th>
									</c:if>

									<c:if test='${selectedFields.contains("tahasil")}'>
										<th>Tahasil</th>
									</c:if>

									<c:if test='${selectedFields.contains("range")}'>
										<th>Range</th>
									</c:if>

									<c:if test='${selectedFields.contains("ric")}'>
										<th>RI Circle</th>
									</c:if>

									<th>Village Name</th>

									<c:if test='${selectedFields.contains("publ_year")}'>
										<th>Publication Year</th>
									</c:if>

									<c:if test='${selectedFields.contains("khata_no")}'>
										<th>Khata No</th>
									</c:if>

									<c:if test='${selectedFields.contains("plot_no")}'>
										<th>ROR Plot No</th>
									</c:if>

									<c:if test='${selectedFields.contains("area_ac")}'>
										<th>ROR Area (Acre)</th>
									</c:if>

									<c:if test='${selectedFields.contains("ps")}'>
										<th>PS</th>
									</c:if>

									<c:if test='${selectedFields.contains("thanaNo")}'>
										<th>Thana No</th>
									</c:if>

									<c:if test='${selectedFields.contains("kissam")}'>
										<th>Kissam</th>
									</c:if>

									<c:if test='${selectedFields.contains("rorClass")}'>
										<th>ROR Clas</th>
									</c:if>

									<c:if test='${selectedFields.contains("landClass")}'>
										<th>Land Class</th>
									</c:if>

									<c:if test='${selectedFields.contains("dlc")}'>
										<th>Is DLC Forest?</th>
									</c:if>
									
									<th>Action</th>

									<!-- <th>Action</th> -->
								</tr>
							</thead>


							<tbody>
								<c:forEach items="${revenueList}" var="item" varStatus="Counter">
									<tr>

										<td class="text-center">${Counter.count}</td>

										<c:if test='${selectedFields.contains("district")}'>
											<td class="text-left">${item.chrvDistrictNm}</td>
										</c:if>

										<c:if test='${selectedFields.contains("division")}'>
											<td class="text-left">${item.chrvDivisionNm}</td>
										</c:if>

										<c:if test='${selectedFields.contains("tahasil")}'>
											<td>${item.getChrvTahasilNm()}</td>
										</c:if>

										<c:if test='${selectedFields.contains("range")}'>
											<td>${item.getChrvRangeNm()}</td>
										</c:if>

										<c:if test='${selectedFields.contains("ric")}'>
											<td class="text-left">${item.ric}</td>
										</c:if>

										<td class="text-left">${item.getVillage()}</td>


										<c:if test='${selectedFields.contains("publ_year")}'>
											<td class="text-right">${item.getPublYear() }</td>
										</c:if>

										<c:if test='${selectedFields.contains("khata_no")}'>
											<td class="text-right">${item.getKhataNo()}</td>
										</c:if>

										<c:if test='${selectedFields.contains("plot_no")}'>
											<td class="text-right">${item.getPlotNo()}</td>
										</c:if>

										<c:if test='${selectedFields.contains("area_ac")}'>
											<td class="text-right">${item.getAreaAc()}</td>
										</c:if>

										<c:if test='${selectedFields.contains("ps")}'>
											<td class="text-left">${item.ps}</td>
										</c:if>

										<c:if test='${selectedFields.contains("thanaNo")}'>
											<td class="text-right">${item.thanaNo}</td>
										</c:if>

										<c:if test='${selectedFields.contains("kissam")}'>
											<td class="text-left">${item.kissam}</td>
										</c:if>

										<c:if test='${selectedFields.contains("rorClass")}'>
											<td class="text-left">${item.rorClass}</td>
										</c:if>

										<c:if test='${selectedFields.contains("landClass")}'>
											<td class="text-left">${item.landClass}</td>
										</c:if>

										<c:if test='${selectedFields.contains("dlc")}'>
											<td class="text-right">${item.dlc==null?"N":item.dlc}</td>
										</c:if>
										
										<td class='text-center'>
										  <a href="/FLD/forestLandDetails?villcode=${item.villCode}&plotno=${item.plotNo}" target="_balnk" class="btn btn-sm btn-info waves-effect waves-light"><i aria-hidden="true"
												class="fa fa-map"></i></a>
												
												<!-- <div class='btn-group' role='group'>
                         <button id='btndefault' type='button' class='btn btn-sm btn-info waves-effect waves-light dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'><i class='fa fa-map'></i></button>
                         <div class='dropdown-menu' aria-labelledby='btndefault'>
                         <a href='/FLD/forestLandDetails?villcode=${item.villCode}&plotno=${item.plotNo}' target='_balnk' class='dropdown-item'><i class=''>&nbsp;</i>New Tab</a>
                         <a href='/FLD/forestLandDetails?villcode=${item.villCode}&plotno=${item.plotNo}' class='dropdown-item'><i class=''>&nbsp;</i>This Tab</a>
                         </div></div> -->
									
										</td>
										<%-- <td><button type="button" class="btn btn-sm btn-success bs-tooltip"
													onclick="BindRfDetails('${item.getVillCode()}','${item.getPlotNo() }') "><i
														aria-hidden="true" class="fa fa-eye" id="btneye"></i></button>
												<button type="button" class="btn btn-sm btn-info bs-tooltip"
													onclick="revMapView('${item.getVillage()}','${item.getVillCode()}','${item.getPlotNo()}') "><i
														aria-hidden="true" class="fa fa-map"></i></button>
											</td> --%>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<input type="hidden" value=${currentRecord } id="hdnCurrent" />
						<input type="hidden" value=${totalRecord } id="hdnTotal" />
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
				<h5 class="modal-title" id="rf_header">Revenue Forest Plot
					Details</h5>
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
<!-- <script src="/assets/js/libs/jquery-3.1.1.min.js"></script>
<script src="/bootstrap/js/bootstrap.min.js"></script>

<script src="/plugins/table/datatable/datatables.js"></script> -->

 <script type="text/javascript">
	var dtForest;
	init('tblNfb');
	init('tblDLCRev');
	function init(tableid) {
		if ($.fn.DataTable.isDataTable('#'+tableid)) {
			$("#"+tableid).dataTable().fnClearTable();
			$("#"+tableid).dataTable().fnDestroy();
		} else {
			dtForest = $('#'+tableid)
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
			        		    "dom": '<"row"<"col-md-12"<"row"<"col-md-6"B><"col-md-6"f> > ><"col-md-12"rt> <"col-md-12"<"row"<"col-md-5"i><"col-md-7"p>>> >',
			        		    buttons: {
			                        buttons: [
			                            { extend: 'pdf',
			                            
			                              exportOptions: 
			                              {
			                            	  columns: ':not(:last-child)'
			                              },
			                            className: 'btn btn-danger fa fa-file-pdf-o' },
			                            { extend: 'excel',
			                            	exportOptions: 
			                            	{
				                              columns: ':not(:last-child)'
				                            },
			                            	className: 'btn btn-success fa fa-file-excel-o' },
			                            { extend: 'print',
		                            		exportOptions: 
		                            		{
				                              columns: ':not(:last-child)'
				                            },
			                            	className: 'btn btn-warning fa fa-print' ,
				                            	customize: function ( win ) {
				                                    $(win.document.body)
				                                        .css( 'font-size', '10pt' )
				                                        .prepend(
				                                            $('#customData').text()
				                                    );
				                 				}	
			                            	}
			                        ]
			                    }
							});
		}
	}
	$(document).ready(function() {
		if($("#btnDivision").hasClass("btn-dark"))
			{
		     if($("#drpfltype").val()!=0 && $("#drpDivision").val() ==0 && $("#drpRngList").val() ==0)
			 {
				 //alert("fltype");
			 	var flName=$("#drpfltype option:selected").text();
			 	$("#SpFltype").text(flName);
			 }
			 
		     else if($("#drpfltype").val()!=0 && $("#drpDivision").val() !="" && $("#drpRngList").val() ==0)
			 {
				 //alert("div");
				var divname = $("#drpDivision option:selected").text();
				var flName=$("#drpfltype option:selected").text();
				$("#Spdiv").text(divname);
				$("#SpFltype").text(flName);
			 }
			 else if($("#drpfltype").val()!=0 && $("#drpDivision").val() !=0 && $("#drpRngList").val() !=0)
			 {
				 //alert("range");
				 var divname = $("#drpDivision option:selected").text();
				 var rangename = $("#drpRngList option:selected").text();
				 var flName=$("#drpfltype option:selected").text();
				 $("#Spdiv").text(divname);
				 $("#Sprange").text(rangename);
				 $("#SpFltype").text(flName);
			 }
			}
		}); 
</script>