<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

<!-- BEGIN LOADER -->
<div class="apploader-base">
	<div class="apploader"></div>
</div>
<!--  END LOADER -->
<div id="content" class="main-content">
	<div class="layout-px-spacing">

		<div class="row layout-top-spacing">

			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">

					<div class="widget-content widget-content-area">
					<form>
							<div class="row">
								<div class="col-md-1">
									<label class="mt-2">District</label>
								</div>
					
								<div class="col-md-2">								
									
									<select class="form-control form-control-sm" id="drpDistrict" onchange="distListChange(this)">
										<option value="0">--Select--</option>
										<c:forEach items="${distList}" var="districtList">
											<option value="${districtList.intId}">${districtList.chrvDistrictNm}</option>
										</c:forEach>									
									</select>	
								</div>
								
								<div class="col-md-1">							
									<label class="mt-2">Tehsil</label>
									
								</div>
								<div class="col-md-2">
									<select class="form-control form-control-sm" id="drpTehList" onchange="tehListChange(this)">										
										<option selected="selected" value="0">-- All --</option>
										
									</select>																		
								</div>
								
								<div class="col-md-1">							
									<label class="mt-2">RI</label>
									
								</div>
								<div class="col-md-2">
									<select class="form-control form-control-sm" id="drpRIList" >										
										<option selected="selected" value="">-- All --</option>
										
									</select>																		
								</div>
								
								<div class="col-md-1">							
									<label class="mt-2">Village</label>
									
								</div>
								<div class="col-md-2">
									<select class="form-control form-control-sm" id="drpVillList">										
										<option selected="selected" value="">-- All --</option>
										
									</select>																		
								</div>
								
								<div class="col-md-3">
									<button type="button" class="btn btn-success"><i class="fa fa-search">&nbsp;</i>Search</button>
								</div>
			
							</div>
						</form>
					
					</div>
				</div>
			</div>
		</div>
		<div class="row layout-top-spacing">
			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">
					<div class="widget-content widget-content-area">
					
						<div class="row">
							<div class="col-md-12 text-right">
								<p><small class="text-danger">Drag to arrange the order.</small></p>
							</div>
						</div>
					
						<div class='parent ex-1'>
                            <div class="row">

                                <div class="col-sm-6">
                                    <div id='left-defaults' class='dragula widget-header'>
                                    
                                    	<h4>Selection</h4>
                                    	<div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="" >
                                                        <h6 class="fields" id="resFbName">DLC</h6>  
                                                         <input type="hidden" value="Dlc">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                         <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="" >
                                                        <h6 class="fields" id="resFbName">Revenue Forest</h6>  
                                                         <input type="hidden" value="RevForest">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="" >
                                                        <h6 class="fields" id="resFbName">Both</h6>  
                                                         <input type="hidden" value="both">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> -->
                                    	 <!-- <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Type</h6>   
                                                         <input type="hidden" value="Type">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> -->
                                          

                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div id='right-defaults' class='dragula widget-header'>
                                    
                                    	<h4>Result</h4>
                                    <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="" >
                                                        <h6 class="fields" id="resFbName">District</h6>  
                                                         <input type="hidden" value="Dist">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                       <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="" >
                                                        <h6 class="fields" id="resFbName">Tahsil</h6>  
                                                         <input type="hidden" value="Tahsil">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                         <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">RI Circle</h6>   
                                                         <input type="hidden" value="RICircle">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="" >
                                                        <h6 class="fields" id="resFbName">Village</h6>  
                                                         <input type="hidden" value="Vill">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Khata No</h6>     
                                                        <input type="hidden" value="KhaNo">                                                    
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                         <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Plot No</h6>  
                                                        <input type="hidden" value="Plotno">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                       
                                         <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="" >
                                                        <h6 class="fields" id="resFbName">Kissam</h6>  
                                                         <input type="hidden" value="Kissam">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> -->
                                     </div>
                                </div>
                              </div>
                              <hr>
                              <div class="row">
								<div class="col-md-12 text-center mb-2">
									<button type="button" class="btn btn-warning" onclick="generateReport_click();"><i class="fa fa-file-o">&nbsp;</i>Generate Report</button>
									<button type="button" class="btn btn-success"><i class="fa fa-file-o">&nbsp;</i>View Report</button>
								</div>
							</div>
						</div>
					
						
					</div>
				</div>
			</div>
		</div>
	
	</div>
</div>
<%@ include file="../shared/footer.jsp"%>
<script>
/* On change of District */
function distListChange(e) {
	var districtid = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
   districtWiseTehsil(districtid);
}
function tehListChange(e){
	//alert($('#drpDistrict').val());
	var tahasil_id = ($("#drpTehList").val() == null || $("#drpTehList").val() == "") ? 0 : $("#drpTehList").val();
	//rangeWiseNfb($('#drpDistrict').val(),e.value)
	tehsilWiseRI(tahasil_id);
}

function districtWiseTehsil(districtid){
	//alert(districtid);
 if ($(districtid).val() != '') {
        $.ajax({
            url: '/Utility/getDistwiseTahasil',
            data: {
                'distid': districtid
            },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(data) {
                $('#drpTehList').html('');
                var options = '';
                $('#drpTehList').append($("<option></option>").attr("value", "").text("--All--"));
                $.each(data, function(a, b) {
                    options += '<option value="' + b.value + '">' + b.text + '</option>';

                });
                $('#drpTehList').append(options);

            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });
    }
}
function tehsilWiseRI(tahasil_id){
	//alert(tahasil_id);
	 if (tahasil_id != '') {
	        $.ajax({
	            url: '/Utility/getTehsilWiseRICircle',
	            data: {
	                
	                'tid' : tahasil_id
	            },
	            type: "GET",
	            contentType: "application/json;charset=utf-8",
	            dataType: "json",
	            success: function(data) {
	                $('#drpRIList').html('');
	                var options = '';
	                $('#drpRIList').append($("<option></option>").attr("value", "").text("--All--"));
	                $.each(data, function(a, b) {
	                    options += '<option value="' + b.value + '">' + b.text + '</option>';

	                });
	                $('#drpRIList').append(options);

	            },
	            error: function(errormessage) {
	                alert(errormessage.responseText);
	            }
	        });
	    }
	}
/* function rICircleWiseVillage(tid,ricname){
	 if (rid != '') {
	        $.ajax({
	            url: '/Utility/getRICircleWiseVillage',
	            data: {
	                'tid': tid,
	                'ricname' : ricname
	            },
	            type: "GET",
	            contentType: "application/json;charset=utf-8",
	            dataType: "json",
	            success: function(data) {
	                $('#drpVillList').html('');
	                var options = '';
	                $('#drpVillList').append($("<option></option>").attr("value", "").text("--All--"));
	                $.each(data, function(a, b) {
	                    options += '<option value="' + b.value + '">' + b.strValue + '</option>';

	                });
	                $('#drpVillList').append(options);

	            },
	            error: function(errormessage) {
	                alert(errormessage.responseText);
	            }
	        });
	    }
	} */
/* Bind Village dropdownlist RI Circle Wise */
$("#drpRIList").change(function () {
	var ric = $("#drpRIList option:selected").text();
	 $.ajax({
 	  url: '/Utility/getRICircleWiseVillage',
 	   async:false,
       data: {'tid':$('#drpTehList').val(),'ricname':ric},
       type: "GET",
       contentType: "application/json;charset=utf-8",
       dataType: "json",
       success: function (data) {
     	  console.log(data);
           $('#drpVillList').html('');
           var options = '';
           $('#drpVillList')
               .append($("<option></option>")
                   .attr("value", "")
                   .text("--Select--"));
           $.each(data, function (a, b) {
               options += '<option value="' + b.strValue + '">'+b.text+'</option>';

           });
           $('#drpVillList').append(options);
       },
       error: function (errormessage) {
           alert(errormessage.responseText);
       }
   });  
}); 
/* End of RI Circle */

</script>

 <script type="text/javascript"> 
 	function generateReport_click() { 
		
		$(".apploader-base").css("display", "block");
		
 		var selectedFields=new Array();
 		var x = document.getElementById("right-defaults").querySelectorAll("h6"); 
 		var fields = document.getElementById("right-defaults").querySelectorAll("input[type=hidden]");
 		for(var i=0; i<fields.length;i++){ 
 			//alert(fields[i].value); -->
			selectedFields.push(fields[i].value); 
 		}
		console.log(selectedFields); 
		
		dist_id = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
		t_id = ($("#drpTehList").val() == null || $("#drpTehList").val() == "") ? 0 : $("#drpTehList").val();
        ricname = ($("#drpRIList").val() == null || $("#drpRIList").val() == "") ? "" : $("#drpRIList").val(); 
        Villname = ($("#drpVillList").val() == null || $("#drpVillList").val() == "") ? "" : $("#drpVillList").val(); 
        alert(dist_id);
 		 $.ajax({ 
 	            url: '/DLCRevenuereport/DLC&RevenueReports', 
 	            data: { 
 	                'distid': dist_id,
 	                'tehid': t_id, 
 	                'ricname':ricname,
 	               'Villname':Villname,
 	                'fields':selectedFields 
 	            }, 
 	            contentType: 'application/html; charset=utf-8',
 	            type: 'GET', 
 	            dataType: 'html', 
 	            success: function(result) { 
 	            	$(".apploader-base").css("display", "none"); 
 	            	costumeNotification("PDF report has been successfully generated."); 
 	            },
	            error: function(errormessage) { 
 	            	$(".apploader-base").css("display", "none"); 
 	            	costumeNotification("Unable to generate PDF report! Please try again!"); 
 	            } 
	            
 	        }); 
		
 	} 
 </script>

                                        
                                    	
					