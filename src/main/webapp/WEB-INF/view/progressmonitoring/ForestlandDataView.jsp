    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.teal-color {
background-color:teal;
color:white;
}
  .disabled {
  /*/  pointer-events:none; //This makes it not clickable
    opacity:0.6;         //This grays it out to look disabled*/
    display:none;
}
</style>

		<div class="col-md-12 layout-spacing">
			<div class="statbox widget box box-shadow" id="divfbtbl">
				<div class="widget-content widget-content-area">
				
					<ul class="nav nav-tabs  mb-3 pb-0" id="simpletab" role="tablist">
					    <li id="li1" class="nav-item">
					        <a class="nav-link fltab active" id="tab1" style="display: none;" data-toggle="tab" href="#nfb" role="tab" aria-controls="nfb" aria-selected="false">Notified</a>
					    </li>
					    <li id="li2" class="nav-item">
					        <a class="nav-link fltab" id="tab2" style="display: none;" data-toggle="tab" href="#rev" role="tab" aria-controls="rev" aria-selected="false">DLC & Other Revenue </a>
					    </li>
					    <li id="li3" class="nav-item">
					        <a class="nav-link fltab" id="tab3" style="display: none;" data-toggle="tab" href="#fra" role="tab" aria-controls="fra" aria-selected="false">FRA</a>
					    </li>
					    <li id="li4" class="nav-item">
					        <a class="nav-link fltab" id="tab4" style="display: none;" data-toggle="tab" href="#caf" role="tab" aria-controls="caf" aria-selected="false">CAF Land</a>
					    </li>
					    <li id="li5" class="nav-item">
					        <a class="nav-link fltab" id="tab5" style="display: none;" data-toggle="tab" href="#df" role="tab" aria-controls="df" aria-selected="false">Diverted Forest</a>
					    </li>
					</ul>
					<div class="tab-content col-md-12 mb-2" id="simpletabContent">
					<!-- NFB Tab Start -->
					    <div class="tab-pane fade ctab" id="nfb" role="tabpanel" aria-labelledby="nfb-tab">
					    
						    <div class="loader-base" id="loaderNfb"><div class="loader"></div></div>
						    <div class="table-responsive">
								<table id="tblForestDetails" class="table table-bordered"
									style="width: 100%">
									<thead>
										<tr>
											<th>Sl No</th>
										    <th>Forest Land Type</th>
										    <th>Range Name</th>
											<th>NFB Name</th>
											<th>NFB Type</th>
											<th>Area in ha.</th>
											<th>Area in Acre</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody class="tbody" id="addTbody">
										
									</tbody>
								</table>
							</div>
							 <p class="p-1 mt-1"><strong>Note :</strong></p>
		                     <small>
		                     	<ul class="custom-list-alpha">
		                      	<li>DGPS Final</li>
		                      	<li>DGPS Draft (ORSAC)</li>
		                      	<li>FRJVC Notified Forest Boundary</li>
		                      	<li>CMV</li>
		                      </ul>
		                      <p class="pl-1">
		                      	* For Notified Forest Block computed area is based on WGS84 datum & UTM projection.<br>
		                      	* For DLC & Revenue Forest area is as per RoR (Record of Right).
		                      </p>
		                     </small> 
					    </div>
					    <!-- NFB Tab End -->
					    
					    <!-- DLC Tab Start -->
					    <div class="tab-pane fade ctab" id="rev" role="tabpanel" aria-labelledby="rev-tab">
					    
					    <div class="loader-base" id="loaderRev"><div class="loader"></div></div>
							    <div class="table-responsive">
									<table id="tblRevDetails" class="table table-bordered"
										style="width: 100%">
										<thead>
											<tr>
												<th>Sl No</th>
											    <th>Forest Land Type</th>
											    <th>Tahasil</th>
											    <th>RI Circle</th>
												<th>Village</th>
												<th>Plot No</th>
												<th>Area in ha.</th>
												<th>Area in Acre</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody class="tbody" id="addRevBody">
											
										</tbody>
									</table>
								</div>
								 <p class="p-1 mt-1"><strong>Note :</strong></p>
			                     <small>
			                     	<ul class="custom-list-alpha">
			                      	<li>DGPS Final</li>
			                      	<li>DGPS Draft (ORSAC)</li>
			                      	<li>FRJVC Notified Forest Boundary</li>
			                      	<li>CMV</li>
			                      </ul>
			                      <p class="pl-1">
			                      	* For Notified Forest Block computed area is based on WGS84 datum & UTM projection.<br>
			                      	* For DLC & Revenue Forest area is as per RoR (Record of Right).
			                      </p>
			                     </small>	    
					    </div>
					    <!-- DLC Tab End -->
					    
					    <!-- FRA Tab Start -->
					    <div class="tab-pane fade ctab" id="fra" role="tabpanel" aria-labelledby="fra-tab">
					        <div class="table-responsive">
									<table id="tblFraDetails" class="table table-bordered"
										style="width: 100%">
										<thead>
											<tr>
												<th>Sl No</th>
											    <th>FRA</th>
												<th></th>
												<th></th>
												<th></th>
												<th></th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody class="tbody" id="addFraBody">
											
										</tbody>
									</table>
								</div>
					    </div>
					    <!-- FRA Tab End -->
					    
					    <!-- CAF Tab Start -->
					    <div class="tab-pane fade ctab" id="caf" role="tabpanel" aria-labelledby="caf-tab">
					        <div class="table-responsive">
									<table id="tblCafDetails" class="table table-bordered"
										style="width: 100%">
										<thead>
											<tr>
												<th>Sl No</th>
											    <th>DRFL Land</th>
												<th></th>
												<th></th>
												<th></th>
												<th></th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody class="tbody" id="addCafBody">
											
										</tbody>
									</table>
								</div>
					    </div>
					    <!-- CAF Tab End -->
					    
					    <!-- Diverted Forest Tab Start -->
					    <div class="tab-pane fade ctab" id="df" role="tabpanel" aria-labelledby="df-tab">
					        <div class="table-responsive">
									<table id="tblDfDetails" class="table table-bordered"
										style="width: 100%">
										<thead>
											<tr>
												<th>Sl No</th>
											    <th>Diverted Forest</th>
												<th></th>
												<th></th>
												<th></th>
												<th></th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody class="tbody" id="addDivertedBody">
											
										</tbody>
									</table>
								</div>
					    </div>
					    <!-- Diverted Forest Tab End -->
					</div>	
				</div>
			</div>
		</div>


<div class="modal fade" id="nfbModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
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
<!-- Modal for Map -->
<div class="modal fade" id="mapModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="map_header"></h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true" id="btnModalClose">&times;</button>
			</div>
			<div class="modal-body" id="mbody">
			<div id="MapModalDiv"></div>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>
<!-- End of Modal Map -->

<div class="modal fade" id="rfModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
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

$(document).ready(function(){
	var revStatus="0";
 var fltypeArray=$("#drpfltype").val();
	$("#tab1").hide();
	$("#tab2").hide();
	$("#tab3").hide();
	$("#tab4").hide();
	$("#tab5").hide();

		for(var i=fltypeArray.length-1;i>=0;i--)
		{
			
			if(i<6){
				if(fltypeArray[i]!=0){
					
					$("#tab"+fltypeArray[i]).show();
					$(".fltab").removeClass("active");
					/* $("#tab"+fltypeArray[i]).addClass("nav-link");
					
					
					$("#nfb").removeClass("tab-pane fade show active ctab");
					$("#rev").removeClass("tab-pane fade show active ctab");
					$("#fra").removeClass("tab-pane fade show active ctab");
					$("#caf").removeClass("tab-pane fade show active ctab");
					$("#df").removeClass("tab-pane fade show active ctab");  */
					
					
					
					//nav-link active
					
					if(fltypeArray[i]==1){
						
						$("#tab1").toggleClass("active");
						$("#nfb").toggleClass("show active");
						$("#tab"+fltypeArray[i]).addClass("active");
					}
					else if(fltypeArray[i]==2){
						
						$("#tab2").toggleClass("active");
						$("#rev").toggleClass("show active");
						$("#tab"+fltypeArray[i]).addClass("active");
					}
					else if(fltypeArray[i]==3){
						$("#tab3").toggleClass("active");
						$("#fra").toggleClass("show active");
						$("#tab"+fltypeArray[i]).addClass("active");
					}
					else if(fltypeArray[i]==4){
						$("#tab4").toggleClass("active");
						$("#caf").toggleClass("show active");
						$("#tab"+fltypeArray[i]).addClass("active");
					}
					else if(fltypeArray[i]==5){
						$("#tab5").toggleClass("active");
						$("#df").toggleClass("show active");
						$("#tab"+fltypeArray[i]).addClass("active");
					}
					
				}
				
			}		
		}

		nfbData();

		revData();
	
	});
	
//init();
//Datatable For NFB
var dtForest;
function nfbData()
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
//Datatable for Revenue
var dtRev;
function revData()
{
	if ( $.fn.DataTable.isDataTable('#tblRevDetails') ) {
        $("#tblRevDetails").dataTable().fnClearTable();
        $("#tblRevDetails").dataTable().fnDestroy();
	}
	else{
		dtRev= $('#tblRevDetails').DataTable({
		    "oLanguage": {
		        "oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
		        "sInfo": "Showing page _PAGE_ of _PAGES_",
		        "sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
		        "sSearchPlaceholder": "Search...",
		       "sLengthMenu": "Results :  _MENU_"
		    },
		    "stripeClasses": [],
		    "lengthMenu": [5, 10, 20, 50],
		    "pageLength": 10
		});
	}

}



//Datatable for FRA
function fraData()
{
	if ( $.fn.DataTable.isDataTable('#tblFraDetails') ) {
        $("#tblFraDetails").dataTable().fnClearTable();
        $("#tblFraDetails").dataTable().fnDestroy();
	}
	else{
		dtRev= $('#tblFraDetails').DataTable({
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


//Datatable for CAF
function cafData()
{
	if ( $.fn.DataTable.isDataTable('#tblCafDetails') ) {
        $("#tblCafDetails").dataTable().fnClearTable();
        $("#tblCafDetails").dataTable().fnDestroy();
	}
	else{
		dtRev= $('#tblCafDetails').DataTable({
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

//Datatable for Diverted Forest
function dfData()
{
	if ( $.fn.DataTable.isDataTable('#tblDfDetails') ) {
        $("#tblDfDetails").dataTable().fnClearTable();
        $("#tblDfDetails").dataTable().fnDestroy();
	}
	else{
		dtRev= $('#tblCafDetails').DataTable({
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

	