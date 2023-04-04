<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

 <!-- BEGIN LOADER -->
    <div class="apploader-base"><div class="apploader"></div></div>
    <!--  END LOADER -->
 <style>
.disabled-link {
  pointer-events: none;
}
</style>
<!--  BEGIN CONTENT AREA  -->
<div id="content" class="main-content">

	<div class="layout-px-spacing">
		<div class="row layout-top-spacing">

			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">
					<div class="widget-header">
                        <div class="row">
                            <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                <h4>Geo-referenced Forest Land Details</h4>
                            </div>
                        </div>
                    </div>
                    
                   
                    			
					<div class="widget-content widget-content-area" id="tblParent">
					<!-- <strong>Date : </strong><span class="spDate"></span> -->
						<div class="table-responsive">
						
							<table id="dtCircle" class="table table-sm table-bordered table-condensed">
								<thead>
									<tr>
										<th width="7%">Sl. No.</th>
										<th>Circle</th>
										<th>Division</th>
										<th>Geo-referenced Notified Forest Block Area (in SqKm.)</th>
										<th>Geo-referenced DLC & Revenue Forest(as per RoR) Land Area (in SqKm.)</th>
										<th width="7%"><strong>Total</strong></th>
									</tr>
								</thead>
								<tbody>
								<c:set var="slno" value="0"></c:set>
								<c:set var="fbArea" value="0"></c:set>
								<c:set var="totalFb" value="0"></c:set>
								<c:set var="DlcRevArea" value="0"></c:set>
								<c:set var="TotalArea" value="0"></c:set>
								
								<c:forEach var="item" items="${nfbDlcDivArea}">
									<tr>
										<td>${slno=slno+1}</td>
										<td>${item.getChrv_circle()}</td>
										<td>${item.getChrv_division_nm()}</td>
										<td align='right'><a href="#" id="lnkNfa${item.getDiv_id()}" onclick="tblParentlnkNfa_Click(this,${item.getDiv_id()});"  class="text-primary"><u><fmt:formatNumber value='${item.getDgpsf_ha()*0.01}' pattern="0.00"></fmt:formatNumber> </u></a>
										(${item.getNo_of_fb()} FBs)
										</td>			
										<td class="text-right"> <a href="#" id="lnkDlcRev${item.getDiv_id()}" onclick="tblParentlnkDlcRev_Click(this,${item.getDiv_id()});" class="text-primary"><u><fmt:formatNumber value='${item.getDlcrev_area_ac()*0.00404686 }' pattern="0.00"></fmt:formatNumber></u></a></td>
										<td class="text-right"><fmt:formatNumber value='${item.getDgpsf_ha()*0.01 + item.getDlcrev_area_ac()*0.00404686 }' pattern="0.00"></fmt:formatNumber> </td>
									</tr>
									<c:set var="fbArea" value="${fbArea=fbArea+(item.getDgpsf_ha()*0.01)}"></c:set> 
									<c:set var="totalFb" value="${totalFb=totalFb+(item.getNo_of_fb())}"></c:set> 
									<c:set var="DlcRevArea" value="${DlcRevArea=DlcRevArea+((item.getDlcrev_area_ac()*0.00404686))}"></c:set>
									<c:set var="TotalArea" value="${TotalArea=TotalArea+(item.getDgpsf_ha()*0.01)+ ((item.getDlcrev_area_ac()*0.00404686))}"></c:set>
								</c:forEach>
								</tbody>
								
								<tfoot>
									<tr>
										<td colspan='2'></td>
										<td>Total</td>
										<td class="text-right"><b><fmt:formatNumber value='${fbArea}' pattern="0.00"></fmt:formatNumber> </b> (${totalFb} FBs)</td>
										<td class="text-right"><b><fmt:formatNumber value='${DlcRevArea}' pattern="0.00"></fmt:formatNumber> </b></td>
										<td class="text-right"><b><fmt:formatNumber value='${TotalArea}' pattern="0.00"></fmt:formatNumber> </b></td>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		
	</div>
	
	<div class="layout-px-spacing" id="nfa" style="display: none;">

		<div class="row layout-top-spacing">

			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">
					<div class="widget-header">
                        <div class="row">
                            <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                <h4>Notified Forest Land Details of <span class="font-italic font-bold" id="spnDivision">NA</span>  Division</h4>
                            	<!-- <div class="row">
                                	<div class="col-md-12">
                                		<strong>Division : </strong>
                                	</div>
                                	</div>  -->
                                <a href="#" id="tblNfaBack" class="btn btn-sm btn-info header-back"><i class="fa fa-chevron-left">&nbsp;</i>Back</a>
                            </div>
                        </div>
                    </div>
					<div class="widget-content widget-content-area">
					<!-- <div id="divFormStatistics"></div> -->
					<%-- <div class="widget-content widget-content-area" id="tblStatistics">
						<div class="table-responsive">
							<table id="" class="table table-sm table-bordered table-condensed">
								<thead>
									<tr>
										<th>Sl. No.</th>
										<th>Forest Type</th>
										<th>No of NFB</th>
										<th>Area</th>
									</tr>
								</thead>
								<tbody>									
									<c:set var="slno" value="0"></c:set>
									<c:forEach var="item" items="${nfbStatistics}">
										<tr>
											<td>${slno=slno+1}</td>
											<td>${item.getNFB_type()}</td>
											<td>${item.getno_of_fb()}</td>
											<td><fmt:formatNumber value='${(item.getfb_Area())}' pattern="0.00"></fmt:formatNumber></td>
											<td>${item.getfb_Area()}</td>
										</tr>
									</c:forEach>
								</tbody>
                    		</table>
                    	</div>
                    </div> --%>
						<div class="table-responsive">
							<table id="tblNfa" class="table table-bordered display nowrap" style="width: 100%">
							
								<thead>
								<tr style="border: none;">
								<th colspan="8">
									<div id="divFormStatistics"></div>
								</th>
								</tr>
									<tr>
										<th width="7%">Sl. No.</th>
										<th>Range</th>
										<th>FB Name</th>
										<th>FB Type</th>
										<th>Notification No.</th>
										<th>Notified Forest Block Area(SqKm.)</th>
										<th>Geo-referenced Notified Forest Block Area(SqKm.)</th>
										<th>View map/report</th>
									</tr>
								</thead>
								<tbody>
									<!-- <tr>
										<td>1</td>
										<td>Kansari</td>
										<td>RF</td>
										<td>Kaniha</td>
										<td>12.86</td>
										<td>
											<div class="btn-group" role="group">
                                                <button id="btndefault" type="button" class="btn btn-sm btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-eye"></i></button>
                                                <div class="dropdown-menu" aria-labelledby="btndefault">
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>FRJVC Report</a>
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>DGPS Map</a>
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>Coordinates</a>
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>Notification</a>
                                                </div>
                                            </div>
										</td>
									</tr>
									<tr>
										<td>2</td>
										<td>Kansari</td>
										<td>RF</td>
										<td>Kaniha</td>
										<td>12.86</td>
										<td>
											<div class="btn-group" role="group">
                                                <button id="btndefault" type="button" class="btn btn-sm btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-eye"></i></button>
                                                <div class="dropdown-menu" aria-labelledby="btndefault">
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>FRJVC Report</a>
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>DGPS Map</a>
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>Coordinates</a>
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>Notification</a>
                                                </div>
                                            </div>
										</td>
									</tr> -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		
	</div>
	
	<div class="layout-px-spacing" id="dlcRev" style="display: none;">

		<div class="row layout-top-spacing">

			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">
					<div class="widget-header">
                        <div class="row">
                            <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                <h4>Tahasil wise recorded forest details for <span class="font-italic" id="spnDivisionDlc">NA</span> Division </h4>
                               
								<div class="row" id="customDLC">
                                
                                	<div class="col-md-4"></div>
                                	<div class="col-md-8 text-right">
                                		<span class="badge outline-badge-success badge-pill">
											<span>DLC : </span><strong id='totalDlcForestTeh'></strong>
										</span>
                                		<span class="badge outline-badge-success badge-pill">
                                			<span>Revenue Forest(as per RoR) : </span><strong id='totalRevForestTeh'></strong>
                                		</span>

										<span class="badge outline-badge-success badge-pill">
											<span>Total Recorded Forest : </span><strong id='totalRecordedForestTeh'></strong>
										</span>
                                		
                                		<span class="badge outline-badge-primary badge-pill">
                                			<span>Common Revenue Forest & DLC : </span><strong id='totalBothTeh'></strong>
                                		</span>
                                	
                                	</div>
                                </div>
                                
                                <a href="#" id="tblDlcRevBack" class="btn btn-sm btn-info header-back"><i class="fa fa-chevron-left">&nbsp;</i>Back</a>
                            </div>
                        </div>
                    </div>
					<div class="widget-content widget-content-area">
						<div class="table-responsive">
							<table id="tblTehsilWiseDlcRev" class="table table-bordered" style="width: 100%">
									<!-- <div class="col-md-12 text-right" id="customDLC">
                                		<span class="badge outline-badge-success badge-pill">
											<span>DLC : </span><strong id='totalDlcArea'></strong>
										</span>
                                		<span class="badge outline-badge-success badge-pill">
                                			<span>Revenue Forest : </span><strong id='totalRevArea'></strong>
                                		</span>
                                	</div>                    -->
								<thead>
									<tr>
										<th width="5%">Sl. No.</th>
										<th>Tahsil</th>
										<th>DLC(SqKm)</th>
										<th>Revenue Forest(as per RoR)(SqKm)</th>
										<th>Total Recorded Forest(DLC & Revenue)(SqKm)</th>
										<th>Common Revenue Forest & DLC(SqKm)</th>
										<th width="7%">View report</th>
									</tr>
								</thead>
								<tbody>
								<!-- <c:forEach var="item" items="${DlcArea}">
									 
									<c:set var="DLCArea" value="${DLCArea=DLCArea+((item.dlc_area))}"></c:set>
								</c:forEach> -->
									<!-- <tr>
										<td>1</td>
										<td><a href="#" onclick="tblDlcRevLnkTahsil_Click(this);" class="text-primary"><u>Chhendipada</u></a></td>
										<td>200.73</td>
										<td>237.35</td>
										<td>
											<div class="btn-group" role="group">
                                                <button id="btndefault" type="button" class="btn btn-sm btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-eye"></i></button>
                                                <div class="dropdown-menu" aria-labelledby="btndefault">
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>DLC Forest</a>
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>Revenue Forest</a>
                                                </div>
                                            </div>
										</td>
									</tr>
									<tr>
										<td>2</td>
										<td><a href="#" class="text-primary"><u>Chhendipada</u></a></td>
										<td>200.73</td>
										<td>237.35</td>
										<td>
											<div class="btn-group" role="group">
                                                <button id="btndefault" type="button" class="btn btn-sm btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-eye"></i></button>
                                                <div class="dropdown-menu" aria-labelledby="btndefault">
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>DLC Forest</a>
                                                    <a href="javascript:void(0);" class="dropdown-item"><i class="fa fa-file-pdf-o">&nbsp;</i>Revenue Forest</a>
                                                </div>
                                            </div>
										</td>
									</tr> -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		
	</div>
	
	<div class="layout-px-spacing" id="dlcRevTeh" style="display: none;">

		<div class="row layout-top-spacing">

			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">
					<div class="widget-header">
                        <div class="row">
                            <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                            	<h4>Revenue village wise recorded forest land details for <span class="font-italic" id="spnTeh">NA</span> Tahasil of <span id="spnDivisionTeh">NA</span> Division
								</h4>
								

                            	<div class="row">

                                	<div class="col-md-4">

										<!-- <div class="form-group row" id="riDiv">
										
											<label class="col-md-2 col-form-label">RI Circle</label> 
											<div class="col-md-3">
												<select class="form-control form-control-sm" id="drpRic" name="drpRic">
													<option value="">--Select--</option>
												</select>
											</div>
												
											<label class="col-md-2 col-form-label">Village</label> 
											<div class="col-md-3">
												<select class="form-control form-control-sm" id="drpVill" name="drpVill">
													<option value="">--Select--</option>
												</select>
											</div>
											<div class="col-auto col-md-2">
												<button type="submit" class="btn btn-sm btn-primary mb-2">go..</button>
											  </div>
										</div> -->

									</div>
                                	<div class="col-md-8 text-right">
                                		<span class="badge outline-badge-success badge-pill">
											<span>DLC : </span><strong id='totalDlcForestVill'></strong>
										</span>
                                		<span class="badge outline-badge-success badge-pill">
                                			<span>Revenue Forest(as per RoR) : </span><strong id='totalRevForestVill'></strong>
                                		</span>

										<span class="badge outline-badge-success badge-pill">
											<span>Total Recorded Forest : </span><strong id='totalRecordedForestVill'></strong>
										</span>

										<span class="badge outline-badge-primary badge-pill">
                                			<span>Common Revenue Forest & DLC : </span><strong id='totalBothVill'></strong>
                                		</span>
                                	</div>
                                </div>
                            
                                <a href="#" id="tblDlcRevTehBack" class="btn btn-sm btn-info header-back"><i class="fa fa-chevron-left">&nbsp;</i>Back</a>
                            </div>
                        </div>
                    </div>
					<div class="widget-content widget-content-area">
						<div class="table-responsive">


							<table id="tblVillWiseDlcRev" class="table table-bordered" style="width: 100%">
							<!-- <div class="col-md-12 text-right">
                                		<span class="badge outline-badge-success badge-pill">
											<span>DLC : </span><strong id='totalDlcA'></strong>
										</span>
                                		<span class="badge outline-badge-success badge-pill">
                                			<span>Revenue Forest : </span><strong id='totalRevA'></strong>
                                		</span>
                                	</div>  -->
								<thead>
									<tr>
										<th width="7%">Sl. No.</th>
										<th>Village</th>
										<th>DLC(Acre)</th>
										<th>Revenue Forest(as per RoR)(Acre)</th>
										<th>Total Recorded Forest(Acre)</th>
										<th>Common Revenue Forest & DLC(Acre)</th>
									</tr>
								</thead>
								<tbody>
									<!-- <tr>
										<td>1</td>
										<td><a href="#" onclick="tblDlcRevTehLnkVill_Click(this);" class="text-primary"><u>Nalua</u></a></td>
										<td>200.65</td>
										<td>236.65</td>
									</tr>
									<tr>
										<td>2</td>
										<td><a href="#" class="text-primary"><u>Nalua</u></a></td>
										<td>200.65</td>
										<td>236.65</td>
									</tr> -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		
	</div>
	
	<div class="layout-px-spacing" id="dlcRevVill" style="display: none;">

		<div class="row layout-top-spacing">

			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">
					<div class="widget-header">
                        <div class="row">
                            <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                <h4>
                                 	Recorded forest land details for <span class="font-italic" id="spnVill">NA</span> Village under
                                 	<span id="spnTehVill">NA</span> Tahasil of <span id="spnDivisionVill">NA</span> Division
                                </h4>
                                <div class="row">
                                	<!-- <div class="col-md-4">
                                		
                                		<strong>Division : </strong>, <strong>Tahsil : </strong>, <strong>Village : </strong>
                                		
                                	</div> -->
                                	<div class="col-md-4"></div>
                                	<div class="col-md-8 text-right">
                                		<span class="badge outline-badge-success badge-pill">
											<span>DLC : </span><strong id='totalDlcForest'></strong>
										</span>
                                		<span class="badge outline-badge-success badge-pill">
                                			<span>Revenue Forest(as per RoR) : </span><strong id='totalRevForest'></strong>
                                		</span>
                                
										<span class="badge outline-badge-success badge-pill">
											<span>Total Recorded Forest : </span><strong id='totalRecordedForest'></strong>
										</span>

										<span class="badge outline-badge-primary badge-pill">
                                			<span>Common Revenue Forest & DLC : </span><strong id='totalBoth'></strong>
                                		</span>
                                	</div>
                                </div>
                                <a href="#" id="tblDlcRevVillBack" class="btn btn-sm btn-info header-back"><i class="fa fa-chevron-left">&nbsp;</i>Back</a>
                            </div>
                        </div>
                    </div>
					<div class="widget-content widget-content-area">
					  
						<div class="table-responsive">
							<table id="tblPlotWiseDlcRev" class="table table-sm table-bordered table-condensed">
								<thead>
									<tr>
										<th width="7%">Sl. No.</th>
										<th>Khata No.</th>
										<th>Plot No.</th>
										<th>Area(Acre)</th>
										<th>Kissam</th>
										<th>Recorded Forest Type</th>
										<th>View in Map</th>
									</tr>
								</thead>
								<tbody>
									<!-- <tr>
										<td>1</td>
										<td>145</td>
										<td>5462</td>
										<td>15.152</td>
										<td>Jungal</td>
										<td>205.35</td>
									</tr>
									<tr>
										<td>2</td>
										<td>145</td>
										<td>5462</td>
										<td>15.152</td>
										<td>Jungal</td>
										<td>205.35</td>
									</tr> -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		
	</div>

</div>


<%@ include file="../shared/footer.jsp"%>
<!-- var report="https://odishaforestlandsurvey.in/FRJVC_Certified_Reports/"+props.range_code+"-"+props.fb_id+"-JVR.pdf"; -->

<script type="text/javascript">

$(document).ready(function(){
	 $(".header-title-lg").text("ODISHA FLI-DSS (Forest Land Details)");
	
	$("#nfa").hide();
	$("#dlcRev").hide();
	$("#dlcRevTeh").hide();
	$("#dlcRevVill").hide();
});

function tblParentlnkNfa_Click(event,divid){
	$("#nfa").show(1000);
	
	$("#dlcRev").hide(1000);
	$("#tblParent").hide(1000);
	
	try{
		var currentRow=$(event).closest("tr");
		var col3=currentRow.find("td:eq(2)").text(); // Division Name @ column position 3
		$("#spnDivision").text("");
		$("#spnDivision").text(col3);
		
		getFbWiseNfbArea(divid);
		BindForestlandSummary(divid);
	}catch(error){
		console.log(error);
	}
	
}

$("#tblNfaBack").click(function(){
	$("#nfa").hide(1000);
	$("#tblParent").show(1000);
});

function tblParentlnkDlcRev_Click(event,divid){
	$("#dlcRev").show(1000);
	
	$("#nfa").hide(1000);
	$("#tblParent").hide(1000);
	
	try{
		var currentRow=$(event).closest("tr");
		var col3=currentRow.find("td:eq(2)").text(); // Division Name @ column position 3
		$("#spnDivisionDlc").text("");
		$("#spnDivisionDlc").text(col3);
		
		getDlcRevTehwiseArea(divid);
	}catch(error){
		console.log(error);
	}

}

$("#tblDlcRevBack").click(function(){
	$("#dlcRev").hide(1000);
	$("#tblParent").show(1000);
});

function tblDlcRevLnkTahsil_Click(event,tehid){
	$("#dlcRev").hide(1000);
	$("#dlcRevTeh").show(1000);
	
	try{
		var currentRow=$(event).closest("tr");
		var col2=currentRow.find("td:eq(1)").text(); // Tehsil Name @ column position 2
		$("#spnDivisionTeh").text($("#spnDivisionDlc").text());
		
		$("#spnTeh").text("");
		$("#spnTeh").text(col2);
		
		getDlcRevVillwiseArea(tehid);
	}catch(error){
		console.log(error);
	}	
	
}

$("#tblDlcRevTehBack").click(function(){
	$("#dlcRevTeh").hide(1000);
	$("#dlcRev").show(1000);
});

function tblDlcRevTehLnkVill_Click(event,villcode){
	
	$("#dlcRevTeh").hide(1000);
	$("#dlcRevVill").show(1000);
	
	try{
		var currentRow=$(event).closest("tr");
		var col2=currentRow.find("td:eq(1)").text(); // village Name @ column position 2
		
		$("#spnDivisionVill").text($("#spnDivisionDlc").text());
		$("#spnTehVill").text($("#spnTeh").text());
		
		$("#spnVill").text("");
		$("#spnVill").text(col2);
		
		getDlcRevPlotwiseArea(villcode.toString());
	}catch(error){
		console.log(error);
	}

}

$("#tblDlcRevVillBack").click(function(){
	$("#dlcRevVill").hide(1000);
	$("#dlcRevTeh").show(1000);
});


function getFbWiseNfbArea(divid){
	$(".apploader-base").css("display", "block");
	
	var dtForest;
	$.ajax({
        url: "/Utility/getNfbFbWiseArea",
        data: {
            'divid': divid
        },
        type: "GET",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(data) {
        	$(".apploader-base").css("display", "none");
        	
        	if ( $.fn.DataTable.isDataTable('#tblNfa') ) {
        	    $("#tblNfa").dataTable().fnClearTable();
        	    $("#tblNfa").dataTable().fnDestroy();
        	}
        	/* else{ */
        		dtForest= $('#tblNfa').DataTable({
        			columnDefs: [
        				{ targets: [0], width: "5%" },
        				{ targets: [3], className: "text-center" },
        				{ targets: [4], className: "text-center" },
        		        { targets: [5], className: "text-right" },
        		        { targets: [6], className: "text-right" },
        		        { targets: [7], className: "text-center" },
        		    ],
        		    "oLanguage": {
        		        "oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
        		        "sInfo": "Showing page _PAGE_ of _PAGES_",
        		        "sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
        		        "sSearchPlaceholder": "Search...",
        		       "sLengthMenu": "Results :  _MENU_",
        		    },

        		    "stripeClasses": [],
        		    //"lengthMenu": [5, 10, 20, 50],
        		    "pageLength": 10,
        		    "dom": '<"row"<"col-md-12"<"row"<"col-md-6"B><"col-md-6"f> > ><"col-md-12"rt> <"col-md-12"<"row"<"col-md-5"i><"col-md-7"p>>> >',
        		    "lengthMenu": [
        	            [ 10, 25, 50, -1 ],
        	            [ '10 rows', '25 rows', '50 rows', 'Show all' ]
        	        ],
        	        buttons: {
                        buttons: [
                        	//{extend: 'pageLength', className:'dt-buttons'},
                            { extend: 'pdf', exportOptions: 
                            {
                            	  columns: ':not(:last-child)'
                              },
                              className: 'btn btn-danger fa fa-file-pdf-o', title: 'Notified Forest Land Details of Angul Division', },
                            { extend: 'excel',exportOptions: 
                            {
                            	  columns: ':not(:last-child)'
                              },
                              className: 'btn btn-success fa fa-file-excel-o', title: 'Notified Forest Land Details of Angul Division', },
                            { extend: 'print',exportOptions: 
                            {
                            	  columns: ':not(:last-child)'
                              },
                              className: 'btn btn-warning fa fa-print', title: 'Notified Forest Land Details of Angul Division', 
                            	customize: function ( win ) {
                                    $(win.document.body)
                                        .css( 'font-size', '10pt' )
                                        .prepend(
                                            $('#customNfb').text()
                                    );
                 				}	
                            }
                        ]
                    },
        		});
        	//}
        	
        		var i=1;
                $.each(data, function(a, b) {
					var cmv="/projectDocs/download/cmv/"+b.div_id+"/"+b.chrv_range_cd+"/"+b.chrv_range_cd+"-"+b.int_id+"-CMV.pdf";
					var mmv="/projectDocs/download/mmv/"+b.div_id+"/"+b.chrv_range_cd+"/"+b.chrv_range_cd+"-"+b.int_id+"-MMV.pdf";
					var frjvc="/projectDocs/download/frjvc/"+b.div_id+"/"+b.chrv_range_cd+"/"+b.chrv_range_cd+"-"+b.int_id+"-JVR.pdf";
					var FSO="/projectDocs/download/fsoCertified/"+b.div_id+"/"+b.chrv_range_cd+"/"+b.chrv_range_cd+"_"+b.int_id+"_FSO.pdf";
					var reNotification="/projectDocs/download/reNotification/"+b.div_id+"/"+b.chrv_range_cd+"/"+b.chrv_range_cd+"_"+b.int_id+"_RN.pdf";
					
                	 dtForest.row.add([i++,b.chrv_range_nm,b.nfb_name,b.nfb_type,b.notf_no,(b.nfa_ha*0.01).toFixed(2),(b.dgpsf_ha*0.01).toFixed(2), 
                		 "<div class='btn-group' role='group'>"+
                         "<button id='btndefault' type='button' class='btn btn-sm btn-success dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'><i class='fa fa-eye'></i></button>"+
                         "<div class='dropdown-menu' aria-labelledby='btndefault'>"+
						 "<a href='/FLD/forestLandDetails?fbid="+b.int_id+"' target='_balnk' class='dropdown-item'><i class='fa fa-map-marker'></i> View in Map</a>"+
						 "<a onclick='fileOpen(\""+cmv+"\")' target='_balnk' class='dropdown-item'><i class='fa fa-file-pdf-o' style='color:red'>&nbsp;</i>CMV Report</a>"+
						 "<a onclick='fileOpen(\""+mmv+"\")' target='_balnk' class='dropdown-item'><i class='fa fa-file-pdf-o' style='color:red'>&nbsp;</i>MMV Report</a>"+
                         "<a onclick='fileOpen(\""+frjvc+"\")' target='_balnk' class='dropdown-item'><i class='fa fa-file-pdf-o' style='color:red'>&nbsp;</i>FRJVC Report</a>"+
                         "<a onclick='fileOpen(\""+FSO+"\")' target='_blank' class='dropdown-item'><i class='fa fa-file-pdf-o' style='color:red'>&nbsp;</i>FSO Certified Map</a>"+
                         //"<a href='javascript:void(0);' class='dropdown-item'><i class='fa fa-file-pdf-o'>&nbsp;</i>Boundary Coordinates</a>"+
                         "<a onclick='fileOpen(\""+reNotification+"\")' class='dropdown-item' target='_blank'><i class='fa fa-file-pdf-o' style='color:red'>&nbsp;</i>Re-Notification</a>"+
                         "</div></div>"
                     ]); 
                	 
                	 
                });	
                dtForest.draw(false);
                
                
        },
        error: function(errormessage) {
            console.log(errormessage.responseText);
        }
    });
}

function getDlcRevTehwiseArea(divid){
	$(".apploader-base").css("display", "block");
	var dtForest;
	$.ajax({
        url: "/Utility/getDlcRevTehwiseArea",
        data: {
            'divid': divid
        },
        type: "GET",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(data) {
        	$(".apploader-base").css("display", "none");
        	
        	if ( $.fn.DataTable.isDataTable('#tblTehsilWiseDlcRev') ) {
        	    $("#tblTehsilWiseDlcRev").dataTable().fnClearTable();
        	    $("#tblTehsilWiseDlcRev").dataTable().fnDestroy();
        	}
        	/* else{ */
        		dtForest= $('#tblTehsilWiseDlcRev').DataTable({
        			autoWidth: false,
        			columnDefs: [
        		        { targets: [0], width:'7%'},
        		        { targets: [1], className: "text-center"},
        				{ targets: [2], className: "text-right" },
        		        { targets: [3], className: "text-right" },
						{ targets: [4], className: "text-right" },
						{ targets: [5], className: "text-right" },
						{ targets: [6], className: "text-center" },
        		    ],
        		    "oLanguage": {
        		        "oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
        		        "sInfo": "Showing page _PAGE_ of _PAGES_",
        		        "sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
        		        "sSearchPlaceholder": "Search...",
        		       "sLengthMenu": "Results :  _MENU_",
        		    },
        		    "stripeClasses": [],
        		    "lengthMenu": [5, 10, 20, 50],
        		    "pageLength": 10,
        		    "dom": '<"row"<"col-md-12"<"row"<"col-md-6"B><"col-md-6"f> > ><"col-md-12"rt> <"col-md-12"<"row"<"col-md-5"i><"col-md-7"p>>> >',
        	        buttons: {
                        buttons: [
                        	//{extend: 'pageLength', className:'dt-buttons'},
                            { extend: 'pdf', exportOptions: 
                            {
                            	  columns: ':not(:last-child)'
                              },
                              className: 'btn btn-danger fa fa-file-pdf-o', title: 'Tahasil wise recorded forest details', },
                            { extend: 'excel',exportOptions: 
                            {
                            	  columns: ':not(:last-child)'
                              },
                              className: 'btn btn-success fa fa-file-excel-o', title: 'Tahasil wise recorded forest details', },
                            { extend: 'print',exportOptions: 
                            {
                            	  columns: ':not(:last-child)'
                              },
                              className: 'btn btn-warning fa fa-print', title: 'Tahasil wise recorded forest details',
                            	customize: function ( win ) {
                                    $(win.document.body)
                                        .css( 'font-size', '10pt' )
                                        .prepend(
                                            $('#customDLC').text()
                                    );
                 				}	
                            }
                        ]
                    }
        		});
        	/* } */
        		let revForestArea=0;
        		let DlcForest=0;
				let Common=0;
        		let i=1;
                $.each(data, function(a, b) {
                	 revForestArea+=b.rev_area*0.00404686;
                	 DlcForest+=b.dlc_area*0.00404686;
					 Common+=b.common_area*0.00404686;
					 var DLC="/projectDocs/download/revDLC/"+b.int_fk_district+"/"+b.int_fk_tehsil+"/"+b.int_fk_district+"_"+b.int_fk_tehsil+"_DLC.pdf";
					 var ROR="/projectDocs/download/revDLC/"+b.int_fk_district+"/"+b.int_fk_tehsil+"/"+b.int_fk_district+"_"+b.int_fk_tehsil+"_ROR.pdf"
                	 dtForest.row.add([i++,"<a href='#' onclick='tblDlcRevLnkTahsil_Click(this,"+b.int_fk_tehsil+");' class='text-primary'><u>"+b.chrv_tahasil_nm+"</u></a>" 
                		 , (b.dlc_area*0.00404686+b.common_area*0.00404686).toFixed(2),(b.rev_area*0.00404686).toFixed(2), (b.dlc_area*0.00404686+b.common_area*0.00404686+b.rev_area*0.00404686).toFixed(2), (b.common_area*0.00404686).toFixed(2),
                		 "<div class='btn-group' role='group'>"+
                         "<button id='btndefault' type='button' class='btn btn-sm btn-success dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'><i class='fa fa-eye'></i></button>"+
                         "<div class='dropdown-menu' aria-labelledby='btndefault'>"+
                         "<a onclick='fileOpen(\""+DLC+"\")' class='dropdown-item' target='_blank'><i class='fa fa-file-pdf-o'>&nbsp;</i>DLC</a>"+
                         "<a onclick='fileOpen(\""+ROR+"\")' class='dropdown-item' target='_blank'><i class='fa fa-file-pdf-o'>&nbsp;</i>Rev.</a>"+
                         "</div></div>"
                     ]);  
                });
                dtForest.draw(false);

				$("#totalRevForestTeh").text((revForestArea).toFixed(2)+' SqKm');
                $("#totalDlcForestTeh").text((DlcForest+Common).toFixed(2)+' SqKm');
				$("#totalBothTeh").text(Common.toFixed(2)+' SqKm');
				$("#totalRecordedForestTeh").text((revForestArea+DlcForest+Common).toFixed(2)+' SqKm');
           
           
        },
        error: function(errormessage) {
        	console.log(errormessage.responseText);
        }
    });
}

function fileOpen(e) {
	//alert(e)
	//var baseURL="https://odishaforestgeodss.in";
	var baseURL="http://localhost:8080";
	$.ajax({
	    url:baseURL+ e,
	    type:'HEAD',
	    error: function()
	    {	
	        //alert("file not avilable");
	        costumeNotification("File not Available");
	        return false;
	    },
	    success: function()
	    {
	    	 //window.location.href=baseURL+ e;
	    	window.open(baseURL+ e, '_blank');
	    }
	});
}


function getDlcRevVillwiseArea(tehid){
	$(".apploader-base").css("display", "block");
	var dtForest;
	$.ajax({
        url: "/Utility/getDlcRevVillwiseArea",
        data: {
            'tehid': tehid
        },
        type: "GET",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(data) {
        	$(".apploader-base").css("display", "none");
        	
        	if ( $.fn.DataTable.isDataTable('#tblVillWiseDlcRev') ) {
        	    $("#tblVillWiseDlcRev").dataTable().fnClearTable();
        	    $("#tblVillWiseDlcRev").dataTable().fnDestroy();
        	}
        	/* else{ */
        		dtForest= $('#tblVillWiseDlcRev').DataTable({
        			columnDefs: [
        				{ targets: [0], width:'7%'},
						{ targets: [1], width:'20%', className: "text-center" },
        		        { targets: [2], className: "text-right" },
        		        { targets: [3], className: "text-right" },
						{ targets: [4], className: "text-right" },
						{ targets: [5], className: "text-right" },
        		    ],
        		    "oLanguage": {
        		        "oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
        		        "sInfo": "Showing page _PAGE_ of _PAGES_",
        		        "sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
        		        "sSearchPlaceholder": "Search...",
        		       "sLengthMenu": "Results :  _MENU_",
        		    },
        		    "stripeClasses": [],
        		    "lengthMenu": [5, 10, 20, 50],
        		    "pageLength": 10,
        		    "dom": '<"row"<"col-md-12"<"row"<"col-md-6"B><"col-md-6"f> > ><"col-md-12"rt> <"col-md-12"<"row"<"col-md-5"i><"col-md-7"p>>> >',
        	        buttons: {
                        buttons: [
                        	//{extend: 'pageLength', className:'dt-buttons'},
                            { extend: 'pdf',
                            	
                                className: 'btn btn-danger fa fa-file-pdf-o' },
                            { extend: 'excel',
                                	
                                    className: 'btn btn-success fa fa-file-excel-o' },
                            { extend: 'print',
                              className: 'btn btn-warning fa fa-print' }
                        ]
                    } 
        		});
        	/* } */
        	
        		let i=1;
        		let revForestArea=0;
        		let DlcForest=0;
				let Common=0;
                $.each(data, function(a, b) {
                	revForestArea+=b.rev_area;
               	    DlcForest+=b.dlc_area;
					Common+=b.common_area;

					let villcode=b.vill_code.toString();
                	 dtForest.row.add([i++,"<a href='#' onclick=tblDlcRevTehLnkVill_Click(this,'" + villcode + "'); class='text-primary'><u>"+b.village+"</u></a>" 
                		 ,(b.dlc_area).toFixed(2),(b.rev_area).toFixed(2),(b.dlc_area+b.rev_area).toFixed(2),b.common_area.toFixed(2)
                     ]); 
                });
                dtForest.draw(false);
                $("#totalRevForestVill").text((revForestArea).toFixed(2)+' Acre');
                $("#totalDlcForestVill").text((DlcForest).toFixed(2)+' Acre');
				$("#totalBothVill").text(Common.toFixed(2)+' Acre');
				$("#totalRecordedForestVill").text((revForestArea+DlcForest+Common).toFixed(2)+' Acre');
           
        },
        error: function(errormessage) {
        	console.log(errormessage.responseText);
        }
    });
}


function getDlcRevPlotwiseArea(villcode){
	$(".apploader-base").css("display", "block");
	var dtForest;
	$.ajax({
        url: "/Utility/getDlcRevPlotwiseArea",
        data: {
            'villcode': villcode.toString()
        },
        type: "GET",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(data) {
			
        	$(".apploader-base").css("display", "none");
        	
        	if ( $.fn.DataTable.isDataTable('#tblPlotWiseDlcRev') ) {
        	    $("#tblPlotWiseDlcRev").dataTable().fnClearTable();
        	    $("#tblPlotWiseDlcRev").dataTable().fnDestroy();
        	}
        	/* else{ */
        		dtForest= $('#tblPlotWiseDlcRev').DataTable({
        			autoWidth: false,
        			columnDefs: [
        				{ targets: [0], width:'7%'},
        				{ targets: [1], className: "text-center"},
        				{ targets: [2], className: "text-center"},
        		        { targets: [3], className: "text-right"},
        				{ targets: [4], className: "text-center"},
						{ targets: [5], className: "text-center"},
						{ targets: [6], className: "text-center"},
        		    ],
        		    "oLanguage": {
        		        "oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
        		        "sInfo": "Showing page _PAGE_ of _PAGES_",
        		        "sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
        		        "sSearchPlaceholder": "Search...",
        		       "sLengthMenu": "Results :  _MENU_",
        		    },
        		    "stripeClasses": [],
        		    "lengthMenu": [5, 10, 20, 50],
        		    "pageLength": 10 ,
        		    "dom": '<"row"<"col-md-12"<"row"<"col-md-6"B><"col-md-6"f> > ><"col-md-12"rt> <"col-md-12"<"row"<"col-md-5"i><"col-md-7"p>>> >',
        	        buttons: {
                        buttons: [
                        	//{extend: 'pageLength', className:'dt-buttons'},
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
                                    className: 'btn btn-warning fa fa-print' }
                        ]
                    }
        		});
        	/* } */
        	
        		var i=1;
        		var revForestArea=0;
        		var DlcForest=0;
        		var totalBoth=0;
        		var totalRecordedForest=0;
                $.each(data, function(a, b) {
					 if(b.isDlc=='Revenue Forest'){
						 revForestArea+=b.area_ac;
					 }
					 else if(b.isDlc=='DLC'){
						 DlcForest+=b.area_ac;
					 }
					 else if(b.isDlc=='Revenue Forest & DLC'){
						 totalBoth+=b.area_ac;
					 }
                	 dtForest.row.add([i++, b.khata_no, b.plot_no, b.area_ac.toFixed(2),b.kissam,b.isDlc,"<a href=/FLD/forestLandDetails?villcode="+b.vill_code+"&plotno="+b.plot_no+" target=_balnk class='btn btn-sm btn-info waves-effect waves-light'><i class='fa fa-map'></i></a>"]); 
                	 
                });
                
                dtForest.draw(false);
                
                $("#totalRevForest").text((revForestArea).toFixed(2)+' Acre');
                $("#totalDlcForest").text((DlcForest+totalBoth).toFixed(2)+' Acre');
                $("#totalBoth").text(totalBoth.toFixed(2)+' Acre');
                $("#totalRecordedForest").text((DlcForest+revForestArea+totalBoth).toFixed(2)+' Acre');
                
        },
        error: function(errormessage) {
        	console.log(errormessage.responseText);
        }
    });
	
}

/* Bind Forest Land Summary*/
function BindForestlandSummary(divid) {
    $.ajax({
        url: '/partialForestLandSummary',
        data: {
            'divid': divid
        },
        contentType: "application/json; charset=utf-8",
        type: 'GET',
        dataType: "html",

        success: function(result) {
            $('#divFormStatistics').empty();
            $('#divFormStatistics').html(result);
        },
        error: function(errormessage) {
            alert(errormessage.responseText);
        }
    });
}
</script>

<script type="text/javascript">
$('#dtCircle').DataTable( {
    dom: '<"row"<"col-md-12"<"row"<"col-md-6"B><"col-md-6"f> > ><"col-md-12"rt> <"col-md-12"<"row"<"col-md-5"i><"col-md-7"p>>> >',
    buttons: {
        buttons: [
            { extend: 'pdf', 
              className: 'btn btn-danger fa fa-file-pdf-o', title: 'Geo-referenced Forest Land Details', footer: true },
            { extend: 'excel', 
            	 
                  className: 'btn btn-success fa fa-file-excel-o', title: 'Geo-referenced Forest Land Details', footer: true },
            { extend: 'print', 
                	  
                      className: 'btn btn-warning fa fa-print', title: 'Geo-referenced Forest Land Details',footer: true  }
        ]
    },
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
} );

//Adding Date

 $(document).ready(function() {
var today = new Date();
$(".spDate").text(formatDate(today));

}); 
function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;

    return [day, month, year].join('-');
} 

</script>

