<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>
<tl:eval expression="@environment.getProperty('api.geoserverurl')" var="geoserverUrl"></tl:eval>
<script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
<style>
  .disabled {
  /*/  pointer-events:none; //This makes it not clickablemultiselect-selected-text
    opacity:0.6;         //This grays it out to look disabled*/
    display:none;
}
/* .ol-scale-bar{
          right: 8px;
          left: auto;
      } */
</style>
<div class="apploader-base"><div class="apploader"></div></div>
<!--  BEGIN CONTENT AREA  -->
<div id="content" class="main-content">
	<div class="layout-px-spacing">

		<div class="row layout-top-spacing">

			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">
				
					<div class="widget-content widget-content-area">

						<form>
							<div class="row">
								<div class="col-md-2 mb-1 col-joint">									
									<div class="btn-group custom-btn-group" id="btnDivDist">
									  <button type="button" class="btn btn-dark" name="distdiv" value=1 id="btnDivision">Division</button>									 
									  <button type="button" class="btn btn-secondary" name="distdiv" value=2 id="btnDistrict">District</button>
									</div>
								</div>
							
								<div class="col-md-2 mb-1" id="distDiv" style="display:none;">
									<select class="form-control form-control-sm" id="drpDistrict"> 
									<option value="">--Select--</option>
										<c:forEach items="${distList}" var="dList">
											<option value="${dList.intId}">${dList.chrvDistrictNm}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-2 mb-1" id="divsnDiv" >									
									<select class="form-control form-control-sm" id="drpDivision" onchange="divListChange(this)">		
										<option value="">--Select--</option>
										<c:forEach items="${divList}" var="diviList">
											<option value="${diviList.intId}">${diviList.chrvDivisionNm}</option>
										</c:forEach>

									</select>
								</div>
								<div class="col-md-2 mb-1" id="flDiv">	
									
	                               <select class="form-control form-control-sm fav_clr" id="drpfltype" name="drpfltype" multiple="multiple">
	                                    <!-- <option value="" selected="selected">-- Forest Land Type --</option> -->
	                                     <option value="0" > Select All </option>
										<c:forEach items="${fLandType}" var="flType">
											<option value="${flType.intId}">${flType.chrvFbLandType}</option>
										</c:forEach>
	                                </select>
	                                <script type="text/javascript">
	                                    $(document).ready(function() {
	                                        $('#drpfltype').multiselect();
	                                        //$('#drpfltype').multiselect('select', 1);
	                                    });
	                                </script>								
								</div>
								<div class="col-md-2 mb-1">
									<button type="button" id="btnAdvance" class="btn btn-success btn-md" data-toggle="modal" data-target="#advanceFilterModal">Advance Filter</button>
								</div> 
								<div class="col-md-2 mb-1">
									<div class="btn-group custom-btn-group">
									   <button type="button"  class="btn" id="btnMapView" >Map</button>
									  <button type="button" class="btn btn-secondary" id="btnDataView" >Data</button>									 
									 
									</div>
								</div>
								<div class="col-md-2">
									<button type="button" class="btn btn-success" id="btnShow">Show</button>
								</div> 
							</div>
						</form>
						
					</div>
				</div>
			</div>
			
		</div>
		
		<div id="divformMap" style="width:100%;"></div>
		<div id="divforData" style="width:100%;"></div>
		<!-- <div id="divMap" style="width:100%;"></div> -->
	</div>
</div>

		<!--  ADVANCE FILTER MODAL  -->
        <div class="modal fade" id="advanceFilterModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Advance Filter</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="advModalClose">
                          <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <form action="">
                        	<div class="row">
                        		<div class="col-md-6 mb-2" id="rngDiv">
                        			<label>Range</label>
                        			<select class="form-control" id="drpRngList" name="drpRngList">
                        				<option value="">--Select--</option>
										
                        			</select>
                        		</div>
                        		
                        		<div class="col-md-6 mb-2" id="tehsilDiv">
                        			<label>Tehsil</label>
                        			<select class="form-control" id="drpTehList" name="drpTehList">
                        				<option value="">--Select--</option>
										
                        			</select>
                        		</div>
                        		<div class="col-md-6 mb-2" id="riDiv">
	                        			<label>RI Circle</label>
	                        			<select class="form-control" id="drpRic" name="drpRic">
	                        			<option value="">--Select--</option>
	                        				
	                        			</select>
                        		</div>
                        		<div class="col-md-6 mb-2" id="villDiv">
	                        			<label>Village</label>
	                        			<select class="form-control" id="drpVill" name="drpVill">
	                        			<option value="">--Select--</option>
	                        				
	                        			</select>
                        		</div>
                        		<div class="col-md-6 mb-2">
                        			<label>Area</label>
                        			<select class="form-control" id="ddlArea">
                        				
                        			</select>
                        		</div>
                        		
                        		<div class="col-md-6 mb-2">
                        			<label>Operator</label>
                        			<select class="form-control">
                        				<option selected="selected">-- Operator --</option>
										<option value="=="> == </option>
										<option value=">="> >= </option>
										<option value="<="> <= </option>
                        			</select>
                        		</div>
                        		
                        		<div class="col-md-6 mb-2">
                        			<label>Value</label>
                        			<input type="number" class="form-control" placeholder="Enter Value">
                        		</div>
                        		
                        	</div>                        	
                        	<hr>
                        	<div class="row form-group">
                        		<div class="col-md-12 text-center">
                        			<button type="button" class="btn btn-sm btn-success mr-1" id="btnApply">Apply</button>
                        			<button type="reset" class="btn btn-sm btn-warning">Clear</button>
                        		</div>
                        	</div>
                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
        
        <!--  VIEW MODAL  -->
        <div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">View Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <div class="table-responsive">
                        	<table class="table table-bordered">
                        		<tbody>
                        			
                        		</tbody>
                        	</table>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
	

<%@ include file="../shared/footer.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script> 
<script src="https://epsg.io/32645.js"></script>
<script src="/v5.3.0-dist/32644.js"></script> 
<script src="/assets/js/custom/layer_style.js"></script>  



<script type="text/javascript">
var status = 0;
var hdn_fid;
var geoserverUrl = '${geoserverUrl}';
$(document).ready(function() {
	forestlandmapview();
	fldDataview();
	
	 
	 $("#btnMapView").addClass("btn-dark");
    /* Set Page Header */
    $(".header-title-lg").text("FLI DSS (Forest Land Information)");
    /*  Show Forest Land Details in modal popup */
    if(${infoBoxFld!=null && infoBoxFld==true}){
        $('#infoModal').modal({
            backdrop: 'static',
            keyboard: false
        })
        $("#infoModal").modal('show');
    } else {
        $("#infoModal").modal('hide');
    }
    
    /* End  Show Forest Land Details in modal popup */
    

	  $(document).on('change', '.multiselect-container :checkbox:first', function() {
	  $('#drpfltype').multiselect(this.checked ? 'selectAll' : 'deselectAll').multiselect('refresh');
	  
	}); 	    
    //End of select all
    
    /* highlight on click */
    //change button class on click function
    $("#btnDivision").click(function () {
		    $("#btnDivision").addClass("btn-dark").removeClass("btn-secondary");
		    $("#btnDistrict").addClass("btn-secondary").removeClass("btn-dark");
			
		});
    
	    $("#btnDistrict").click(function () {
	    	$("#btnDistrict").addClass("btn-dark").removeClass("btn-secondary");
		    $("#btnDivision").addClass("btn-secondary").removeClass("btn-dark");   
	});
	    $("#btnDataView").click(function () {
		    $("#btnDataView").addClass("btn-dark").removeClass("btn-secondary");
		    $("#btnMapView").addClass("btn-secondary").removeClass("btn-dark");
		    $("#divformMap").hide();
		    $("#divforData").show();
		});
    
	    $("#btnMapView").click(function () {
	    	$("#btnMapView").addClass("btn-dark").removeClass("btn-secondary");
		    $("#btnDataView").addClass("btn-secondary").removeClass("btn-dark");    
		    //$("#flDiv").hide();
		    $("#divformMap").show();
		    $("#divforData").hide();
	});
 //end of change button class on click function 
	  
    /*  On change of Forest Type and Dist/Division */
    var value1="";
    $('#drpfltype').on('change', function() {
    	flTypeListChange();
    	
    	 value1=$('#drpfltype').val();
    	 BindCondn();  
    	
    	 $("#drpdistDivList").val($("#drpdistDivList option:first").val());
    	 $("#distId").val($("#distId option:first").val());
         $("#divId").val($("#divId option:first").val());
         clearSelectValue();
         if($("#drpDivision").val() != '')
     	{
     		BindRangeDivwise($("#drpDivision").val())
     	}
         if($("#drpDistrict").val() != '')
      	{
        	 distChange()
      	}
    });
      $('#drpdistDivList').on('change', function() {
    	  flTypeListChange();
        $("#distId").val($("#distId option:first").val());
        $("#divId").val($("#divId option:first").val());
        clearSelectValue();
        if (value1 == "") {
            $("#drpdistDivList").val($("#drpdistDivList option:first").val());
            viewNotification(4);
            return false;
        } 
    });  
    /* End  On change of Forest Type and Dist/Division */
});
/* on change by button click division */
	$("#btnDivision").click(function(){
	  $("#divsnDiv").show();
	  $("#distDiv").hide();
	  if($("#drpDivision").val() != '')
    	{
    		BindRangeDivwise($("#drpDivision").val())
    	}
	  if($("#btnDivision").hasClass("btn-dark"))
	  {
	  	  $("#rngDiv").hide();  
	  	  $("#tehsilDiv").show();
	  }
	});
/* End */
/* on change by button click district */
	$("#btnDistrict").click(function(){
		  $("#distDiv").show();
		  $("#divsnDiv").hide();
		});
		

/*On change of District */
//Bind District wise Range dropdownlist
$("#drpDistrict").change(function() { 
	distChange();
	$("#chkDist").prop('checked', false);
	$("#chkDist" ).trigger( "click");
	$("#chkDist").prop('checked', true);
});
function distChange()
{
	clearSelectValue();
    $('#divform').empty();
    var drpDistrict = $('#drpDistrict').val();
    if ($('#drpDistrict').val() != '') {
        var url = "";
        if ($("#drpfltype").val() == 1) {
            url = "/Utility/getDistwiseRange";
        } else {
            url = "/Utility/getDistwiseTahasil";
        }
        $.ajax({
        	async: false,
            url: url,
            data: {
                'distid': drpDistrict
            },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(data) {
                var options = '';
                if ($("#drpfltype").val() == 1) {
                	
                    $('#drpRngList').html('');
                    $('#drpRngList').append($("<option></option>").attr("value", "").text("--Select--"));
                    $.each(data, function(a, b) {
                        options += '<option value="' + b.strValue + '">' + b.text + '</option>';
                    });
                    $('#drpRngList').append(options);
                    
                  //Range for DGPS Checkbox
                    $('#drpRng').html('');
                    $('#drpRng').append($("<option></option>").attr("value", "").text("--Select--"));
                    $('#drpRng').append(options);
                    
                } else {
                    
                    $('#drpTehList').html('');
                    $('#drpTehList').append($("<option></option>").attr("value", "").text("--Select--"));
                    $.each(data, function(a, b) {
                        options += '<option value="' + b.value + '">' + b.text + '</option>';
                    });
                    $('#drpTehList').append(options);
                }
            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });
    }
}
/*End On change of District */
function flTypeListChange() {
	 clearSelectValue();
	    $('#divform').empty();
};

/* On change of Division */
function divListChange(e) {
	//alert("rng");
    clearSelectValue();
    $('#divform').empty();
    if($(e).val() != '' && $(e).val() !=0)
    	{
    	$("#chkDivision").prop('checked', false);
    	
    		//getDivLayer($(e).val());
    		
    		$("#chkDivision" ).trigger( "click");
    		$("#chkDivision").prop('checked', true);
    		
    		BindRangeDivwise($(e).val())
    		
    		
    	}
}

function BindRangeDivwise(e)
{
	if (e != '') {
		if ($("#drpfltype").val() == 1) {
            url = "/Utility/getDivwiseRange";
        } else {
            url = "/Utility/getDivwiseTahasil";
        }
        $.ajax({
        	 async: false,
            url: url,
            data: {
                'divid': e
            },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(data) {
            	//alert('runnig...');
            	//Range For Advance Filter
                $('#drpRngList').html('');
            	
                
                if ($("#drpfltype").val() == 1) {
                var options = '';	
                $('#drpRngList').append($("<option></option>").attr("value", "").text("--Select--"));
                $.each(data, function(a, b) {
                    options += '<option value="' + b.strValue + '">' + b.text + '</option>';

                });
                $('#drpRngList').append(options);
                
                
                //Range for DGPS Checkbox
                $('#drpRng').html('');
                $('#drpRng').append($("<option></option>").attr("value", "").text("--Select--"));
                $('#drpRng').append(options);
              }
              
              else
              	{
            	  var optionsrange = '';	
            	  $('#drpRngList').append($("<option></option>").attr("value", "").text("--Select--"));
                  $.each(data, function(a, b) {
                	  optionsrange += '<option value="' + b.strValue + '">' + b.text + '</option>';
                  });
                  $('#drpRngList').append(optionsrange);
                  
                  
                  var optionstehsil = '';	
	           	   $('#drpTehList').html('');
	                  $('#drpTehList').append($("<option></option>").attr("value", "").text("--Select--"));
	                  $.each(data, function(a, b) {
	                	  optionstehsil += '<option value="' + b.value + '">' + b.text + '</option>';
	                  });
	                  $('#drpTehList').append(optionstehsil);
              	}

            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });	
	}
}
//Clear Dropdownlist
function clearSelectValue() {

    $('#drpRngList').html('');
    $('#drpTehList').html('');
    $('#drpRngList').append($("<option></option>").attr("value", "").text("--Select--"));
    $('#drpTehList').append($("<option></option>").attr("value", "").text("--Select--"));

}
//Bind Area Type on change of forest land type
function BindCondn() {
	var fltype=$("#drpfltype").val();
    if (fltype!= ' '|| fltype!=0) {
        $.ajax({
            url: '/Utility/getAreaType',
            data: {'forestLandType':fltype},
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(data) {    
                $('#ddlArea').html('');
                var options = '';
                $('#ddlArea').append($("<option></option>").attr("value", "").text("--Select--"));
                
                
                $.each(data, function(a, b) {
                    //if(b.isNumeric){
                        options += '<option value="' + b.strValue + '"  >' + b.text+ '</option>';
                    //}
                });
                $('#ddlArea').append(options);
               

               // setSelectedtext();

            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });
    }
}
//End of Area Type on change


//On check of don't show message in modal
$("#chkDontShow").click(function() {
    if ($("#chkDontShow").is(":checked")) {
        $.ajax({
            url: '/api/Utility/dontShowAgain',
            data: {
                'sessionName': 'infoBoxFld'
            },
            contentType: 'application/html; charset=utf-8',
            type: 'GET',
            dataType: "html",
        })
    }
});

//Check if a button is clicked or not
$("#btnDataView").click(function(){
    $(this).data('clicked', true);
});
$("#btnMapView").click(function(){
    $(this).data('clicked', true);
});
$("#btnDistrict").click(function(){
    $(this).data('clicked', true);
});
$("#btnDivision").click(function(){
    $(this).data('clicked', true);
});


//Button Show 
 $("#btnShow").click(function() 
	{	 
	 $("#gdtab").show();
	 	if($("#drpDistrict").val()!=0 || $("#drpDivision").val()!=0 && $("#drpfltype").val()!=0)
		 {
	 		  if(/* $('#btnDataView').data('clicked') && */ $("#btnDataView").hasClass("btn-dark")) 
	 		 	{
		 			
	 			 	LoadFBLayer();
	 		    	 //fldDataview();
	 			}
	 	 		else if(/* $('#btnMapView').data('clicked') && */ $("#btnMapView").hasClass("btn-dark"))
	 	 		{
	 	 			//forestlandmapview();
	 	 			LoadFBLayer();
	 	 			
	 			}
		 }
	 	else
	 	{
	 		
	 		viewNotification(11);
	 		LoadFBLayer();
	 	}	 
	 	
    }); 
	
		$("#btnAdvance").click(function()
		{
			//on selection of district
			 if($("#drpfltype").val() == 1 && $("#btnDistrict").hasClass("btn-dark"))
			 {
				  //alert("rng");
			 	  $("#rngDiv").show();  
			 	  $("#tehsilDiv").hide();
			 	  $("#riDiv").hide();
			 	  $("#villDiv").hide();
			 	 
			 }
			 else if($("#drpfltype").val() == 1 && $("#btnDivision").hasClass("btn-dark"))
			 {
				 //alert("rng");
			 	  $("#rngDiv").show();  
			 	  $("#tehsilDiv").hide();
			 	  $("#riDiv").hide();
			 	  $("#villDiv").hide();
			 }
			 else if($("#drpfltype").val() == 2 && $("#btnDivision").hasClass("btn-dark"))
			 {
				 //alert("rng");
				  $("#rngDiv").show();  
			 	  $("#tehsilDiv").show();
			 	  $("#riDiv").hide();
			 	  $("#villDiv").hide();
			 }
			 else if($("#drpfltype").val() == 2 && $("#btnDistrict").hasClass("btn-dark"))
			 {
				 //alert("tehsil");
				  $("#rngDiv").hide();  
			 	  $("#tehsilDiv").show();
			 	  $("#riDiv").show();
			 	  $("#villDiv").show();
			 }
			 else if($("#drpfltype").val()[0]==1 && $("#drpfltype").val()[1]==2)
			 {
				  $("#rngDiv").show();  
			 	  $("#tehsilDiv").show();
			 	  $("#riDiv").show();
			 	  $("#villDiv").show();
			 }
		});
			
//end


//Button Apply
$("#btnApply").click(function() {
	 $('#advanceFilterModal').modal('hide');
	 $('.modal-backdrop').remove();
});


/* Add RF Data-apply paggination technique*/
function addRevForestPaggination(totalRecord, pageSize) {
    var pageNo = 1;
    status = 1;
    if (totalRecord > pageSize) {
        totalRecord = totalRecord - pageSize;
        var len = Math.ceil(parseInt(totalRecord) / pageSize);
        let index = 0;
        let counter = parseInt(pageSize) + 1;
        getRevForestData(index, len, pageNo, pageSize, counter);
    }
}
/* End- Add RF Data-apply paggination technique*/
    
/* View NFB Details in modal popup*/
function BindFBDetails(fid) {
    $.ajax({
        url: '/ProgressMonitoring/partialFbWiseForestLandDetails',
        data: {
            'fid': fid
        },
        contentType: "application/json; charset=utf-8",
        type: 'GET',
        dataType: "html",

        success: function(result) {
            $('#modalDiv').empty();
            $('#modalDiv').html(result);
            $('#nfb_header').text("FB Name: " + $("#hdnNFBName").val());
            //$('#nfbModal').modal('toggle');
            $('#nfbModal').modal('show');

        },
        error: function(errormessage) {
            alert(errormessage.responseText);
        }
    });
}
/* END- View NFB Details in modal popup*/

/* View Map View of NFB Details */
function MapView(fid, nfbname) {
	   $("#divforData").hide();
	    $("#divformMap").show();
	    return;
   
}
/* End- View Map View of NFB Details */

/* View Map View */
function forestlandmapview() {
	    var paramdist = $("#drpDistrict").val();
	    var paramdivision = $("#drpDivision").val();

	    $("#divforData").hide();
	    $("#divformMap").show();
	    $(".apploader-base").css("display", "block");
	    $.ajax({
	        async:false,
	    	url: '/ProgressMonitoring/forestlandmapview',
	        data: {
	            'distid': paramdist,
	            'divid': paramdivision
	        },
	        contentType: "application/json; charset=utf-8",
	        type: 'GET',
	        dataType: "html",
	
	        success: function(result) {
	            $('#divformMap').html(result);
	            $(".apploader-base").css("display", "none");
	        },
	        error: function(errormessage) {
	            alert(errormessage.responseText);
	        }
	    });
	//}
}
/* End- View Map View  */

/* View Map View */

function fldDataview() {
    if($('#drpfltype').val() != "")
    {	
	    $.ajax({
	        async:false,
	    	url: '/ProgressMonitoring/ForestlandDataView',
	        data: {
	        },
	        contentType: "application/json; charset=utf-8",
	        type: 'GET',
	        dataType: "html",
	
	        success: function(result) {
	            $('#modalDiv').empty();
	            $('#divforData').html(result);
	            $(".apploader-base").css("display", "none");
	        },
	        error: function(errormessage) {
	            alert(errormessage.responseText);
	        }
	    });
    }
    else
    	{
    	  //viewNotification(11);
    	}
}
/* End- View Map View  */

/* On click of back button */
function back() {
	$('#divforData').show();
	$("#divformMap").hide();
    //$('#map').hide();
}
/* End- On click of back button */


/* Bind RF/DLC Plot Details in a modal popup */
function BindRfDetails(village_code, plot_no) {
	$.ajax({
        url: '/plotwiseRevenueForestDetails',
        data: {
            'villageCode': village_code,
            'plotNo': plot_no
        },
        contentType: "application/json; charset=utf-8",
        type: 'GET',
        dataType: "html",

        success: function(result) {
            $('#rfmodalDiv').empty();
            $('#rfmodalDiv').html(result);
            if($("#drpfltype").val()==2)
            	$('#rf_header').text("Revenue Forest Plot Details");
            else
            	$('#rf_header').text("DLC Forest Plot Details");
            $('#rfModal').modal('show');

        },
        error: function(errormessage) {
            alert(errormessage.responseText);
        }
    });
}
/* End Bind RF/DLC Plot Details in a modal popup */

/* Start Map View of RF/DLC Plot Details */
function revMapView(village, village_code, plot_no) {
    var paramdist = ($("#drpDistrict").val()==0 ? 0 : $("#drpDistrict").val());
    var paramdivision = ($("#drpDivision").val() == 0 ?  0 :$("#drpDivision").val());
    $("#map_header").text("Map View of Revenue Forest Plot: " + plot_no + " (" + village + ")");
    $("#hdn_plot_no").val(plot_no);
     hdn_plot_no=plot_no;
    $("#hdn_tid").val($("#drpTehList").val());
    //$('#map').show();
    $("#divforData").hide();
    $("#divformMap").empty();
    $('#divform').hide();
    $(".apploader-base").css("display", "block");
    $.ajax({
        url: '/partialrevMapview',
        data: {
        	'land_type': $("#drpfltype").val(),
        	'distid': paramdist,
            'divid': paramdivision,
            'village_code': village_code
        },
        contentType: "application/json; charset=utf-8",
        type: 'GET',
        dataType: "html",

        success: function(result) {
            $('#modalDiv').empty();
            $('#divMap').html(result);
            $(".apploader-base").css("display", "none");
        },
        error: function(errormessage) {
            alert(errormessage.responseText);
        }
    });
} 
/* End Map View of RF/DLC Plot Details */

/* Bind RI Circle  dropdownlist Tehsilwise */
       $("#drpTehList").change(function () {
          $.ajax({
        	  url: '/Utility/getTehsilWiseRICircle',
              data: {'tid':$('#drpTehList').val() },
              type: "GET",
              contentType: "application/json;charset=utf-8",
              dataType: "json",
              success: function (data) {
            	  //console.log(data);
                  $('#drpRic').html('');
                  var options = '';
                  $('#drpRic')
                      .append($("<option></option>")
                          .attr("value", "")
                          .text("--Select--"));
                  $.each(data, function (a, b) {
                      options += '<option value="' + b.value + '">'+b.text + '</option>';
      
                  });
                  $('#drpRic').append(options);
              },
              error: function (errormessage) {
                  alert(errormessage.responseText);
              }
          });  
    }); 
/* End of RI Circle */
 
 /* Bind Village dropdownlist RI Circle Wise */
       $("#drpRic").change(function () {
    	var ric = $("#drpRic option:selected").text();
    	   $.ajax({
        	  url: '/Utility/getRICircleWiseVillage',
              data: {'tid':$('#drpTehList').val(),'ricname':ric},
              type: "GET",
              contentType: "application/json;charset=utf-8",
              dataType: "json",
              success: function (data) {
            	  console.log(data);
                  $('#drpVill').html('');
                  var options = '';
                  $('#drpVill')
                      .append($("<option></option>")
                          .attr("value", "")
                          .text("--Select--"));
                  $.each(data, function (a, b) {
                      options += '<option value="' + b.strValue + '">'+b.text+'</option>';
      
                  });
                  $('#drpVill').append(options);
              },
              error: function (errormessage) {
                  alert(errormessage.responseText);
              }
          });  
    }); 
/* End of RI Circle */



</script>

