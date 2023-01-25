<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

 <!-- BEGIN LOADER -->
    <div class="apploader-base"><div class="apploader"></div></div>
    <!--  END LOADER -->

<div id="content" class="main-content">
	<div class="layout-px-spacing">

		<div class="row layout-top-spacing">

			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">
				
					<div class="widget-content widget-content-area">

						<form >
							<div class="form-row">
							
							<div class="col-md-2 mb-2">		
									<label>Division / District</label>							
									<div class="btn-group custom-btn-group id="btnDivDist"">
									  <button type="button" class="btn btn-dark" name="distdiv" value=1 id="btnDivision">Division</button>									 
									  <button type="button" class="btn btn-secondary" name="distdiv" value=2 id="btnDistrict">District</button>
									</div>
								</div>
							
								<div class="col-md-2 mb-2" id="distDiv" style="display:none;">
								<label>District <span class='text-danger'>*</span></label>
									<select class="form-control form-control-sm" id="drpDistrict"> 
									<option value="">--Select--</option>
										<c:forEach items="${distList}" var="dList">
											<option value="${dList.intId}">${dList.chrvDistrictNm}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-2 mb-2" id="divsnDiv" >
									<label>Division <span class='text-danger'>*</span></label>									
									<select class="form-control form-control-sm" id="drpDivision" onchange="divListChange(this)">
										<option value="">--Select--</option>
										<c:forEach items="${divList}" var="diviList">
											<option value="${diviList.intId}">${diviList.chrvDivisionNm}</option>
										</c:forEach>

									</select>
								</div>
							
								<div class="col-md-2 mb-2">
									<label>Forest Land Type <span class='text-danger'>*</span></label>
									<select id="drpfltype" class="form-control form-control-sm"> 
										<option selected="selected"  value="" >-- Select --</option>
										<option value="1">Notified Forest</option>
										<option value="2">DLC Forest</option>
										<option value="3">Other Revenue Forest</option>
										<option value="4">Deemed Forest</option>
									</select>
								</div>
								<div class="col-md-2 mb-2">
									<label>Display Fields</label>
									<select class="form-control form-control-sm" id="drpDisFields" multiple="multiple" > 
										  <!--<option>-- Select --</option>
										 
										 <c:forEach items="${customFieldsNfb}" var="customeFields">
										 
											<option value="${customeFields.strValue}" ${customeFields.isChecked==true?"selected":""}> ${customeFields.text}</option>
										</c:forEach> -->
										
										<!-- <option value="1">FB Name</option> 
										<option value="2">Division</option>
										<option value="3">District</option> -->
									</select>
									 <script type="text/javascript">
	                                    $(document).ready(function() {
	                                        $('#drpDisFields').multiselect();
	                                    });
	                                </script>
								</div>

								<!-- <div class="col mb-2">
									<label>Tehsil</label>
									<select class="form-control form-control-sm"> 
										<option selected="selected">-- Tehsil --</option>
										<option>1</option>
										<option>2</option>
									</select> -->
								<div class="col-md-2 mb-2" id="ranDiv">
									<label>Range</label>
									<!-- <select class="form-control form-control-sm"> 
										<option selected="selected">-- Range --</option>
										<option>1</option>
										<option>2</option>
									</select> -->
									<select class="form-control form-control-sm" id="drpRngList" name="drpRngList">
										<option value="">--Select--</option>
										<c:forEach items="${rngList}" var="rList">
											<option value="${rList.intId}">${rList.chrvRangeNm}</option>
										</c:forEach>
									</select>
								</div>		
							
								
							
							 	<div class="col-md-2 mb-1" id="tehDiv">
								<input type="hidden" id="hdn_tid"/>
									<label>Tahasil</label>
									<select class="form-control form-control-sm" id="drpTehList" name="drpTehList">
										<option value="">--Select--</option>
										<c:forEach items="${tehsList}" var="tehList">
											<option value="${tehList.intId}">${tehList.chrvTahasilNm}</option>
										</c:forEach>
									</select>
								</div>
								<!-- <div class="col-md-2 mb-1" id="villDiv">
									<label>Village</label>
									<select class="form-control form-control-sm"> 
										<option selected="selected">-- Village --</option>
										<option>1</option>
										<option>2</option>
									</select>
								</div> -->
								
								<%-- <div class="col-md-2 mb-1">
									<label>Condition</label>
									<select id="ddlCondn" class="form-control form-control-sm"> 
										<option selected="selected">-- Condition --</option>
									</select>
								</div>
								<div class="col-md-2 mb-1">
									<label>Operator</label>
									<select class="form-control form-control-sm" id="ddlOperator"> 
										<option selected="selected" value="">-- Operator --</option>
										<option value="=="> == </option>
										<option value=">="> >= </option>
										<option value="<="> <= </option>
									</select>
								</div>
								
								<div class="col-md-2 mb-1">
									<label>Value</label>
									<input type="number" id="txtValue" class="form-control form-control-sm">
								</div> --%>
								
						    <div class="col-md-2" style="margin-top:27px">
							  <button type="button" class="btn btn-link px-3"  data-toggle="modal" data-target="#customQueryModal">Advance Filter</button>
							</div>
							
							</div>
							
							
							
							<div class="text-center" style="margin-top:27px">
								    
									<button type="button" id="btnSearch" class="btn btn-success mr-1" >Show</button>
									<button type="button" id="btnSearch" class="btn btn-warning" onclick="location.href = '/DSS/customQuery';" >Reset</button>
								</div>
						</form>
						
					</div>
				</div>
			</div>
			
		</div>
	
		
        <div class="row layout-top-spacing">
        
                <span id="spnotif" class="text-primary" style="display:none;"></span>
                
            <div class="col-md-12 mb-1">
               <div class="statbox widget box box-shadow">                            
                   <div class="widget-content widget-content-area">
                   
                   <div id="divform"> </div>
                 
                   </div>
               </div>
           </div>
           
       </div>
	
	</div>
</div>

<!-- Modal -->
        <div class="modal fade" id="customQueryModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Custom Query</h5>
                        <button type="button" id="btnCloseAdvFiler" class="close" data-dismiss="modal" aria-label="Close">
                          <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <div class="table-responsive">
                            <table id="faqs" class="table table-custom">
                               <tbody>
                                   <tr id="faqs-row0">
                                       <td width="40%">
                                       	   <label>Condition on</label>
                                           <select id="ddlQbFields1" class="form-control form-control-sm">
                                           	   <option selected="selected" value="">-- Select --</option>
                                           	   
                                           </select>
                                       </td>
                                       <td width="30%">
                                           <label>Operators</label>
                                           <select id="ddlQbOperators1" class="form-control form-control-sm">
                                           	   <option selected="selected" value="">-- Select --</option>
                                           	   <option value="="> == </option>
											   <option value=">="> >= </option>
										       <option value="<="> <= </option>
                                           </select>
                                       </td>
                                       <td width="20%">
                                       	   <label>Value</label>
                                           <input type="number" id="txtQbValue1" class="form-control form-control-sm" placeholder="">
                                       </td>
                                       <td width="5%"><button class="btn btn-danger btn-sm waves-effect waves-light mt-4"><i class="fa fa-trash"></i></button></td>
                                       <td width="5%"><div class="text-center"><button onclick="addfaqs();" class="btn btn-info btn-sm waves-effect waves-light mt-4"><i class="fa fa-plus"></i></button></div></td>
                                   </tr>
                               </tbody>
                           </table>
                           <div class="text-right">
                           <button type="button" class="btn btn-sm btn-success mr-1" id="btnApply">Apply</button>
                           <button type="reset" class="btn btn-sm btn-warning" id="btnClear">Clear</button>
                           </div>
                        </div>
                        
                        <script type="text/javascript">
					        var faqs_row = 1;
					        function addfaqs() {
					        html = '<tr id="faqs-row' + faqs_row + '">';
					        	
					            html += '<td width="40%"> <div class="row"><div class="col-md-4"><select class="form-control form-control-sm"><option value="and"> AND </option> <option value="or"> OR </option> </select></div> <div class="col-md-8"><select id=ddlQbFields'+(faqs_row+1)+' class="form-control form-control-sm"><option>1</option></select></div></div></td>';
					            html += '<td width="30%"><div class=""><select class="form-control form-control-sm"><option value="="> == </option> <option value=">="> >= </option> <option value="<="> <= </option></select></div></td>';
					            html += '<td width="20%"><div class=""><input class="form-control form-control-sm" type="number"></div></td>';
					            html += '<td width="5%"><button class="btn btn-danger btn-sm waves-effect waves-light" onclick="$(\'#faqs-row' + faqs_row + '\').remove();"><i class="fa fa-trash"></i></button></td>';
					
					            html += '</tr>';
					
					        $('#faqs tbody').append(html);
					        
					
					        faqs_row++;
					        
					        BindCondn(value1,'ddlQbFields'+faqs_row);
					        }
					        
					    </script>

                    </div>
                </div>
            </div>
        </div>

  <%@ include file="../shared/footer.jsp"%>
    
    <script src="/assets/js/apps/customQuery.js"></script>
    
 <script type="text/javascript">
 	let flag_division=0;
    let flag_Forest_Land_type=0;
  $(document).ready(function() {
		// 	 setSelectedtext();
	  $("#tehDiv").hide();
 	});
 

 //var nfinfo=["nfb_name","nfb_type","nareaHa","nfbName"],wpinfo=[""],dgpsinfo=[],selectedArr=[],selectedData=[],selectedHeader=[];
 //selectedData=selectedData.concat(nfinfo);  
 
//Button search
$("#btnSearch").click(function() {
	$('#divform').empty();
	let div = $('#drpDivision').val();
    let flt= $('#drpfltype').val();
    let dst= $("#drpDistrict").val();
if ((div == '' || dst=='') && flt == ''){
	costumeNotification("Please select Division & Forest Land Type")
}else{

	
    //$('#divform').empty();
    var selection, dist_id, div_id, tahasil_id, range_code;
    status = 0;
    if ($('#drpfltype').val() != "")

    {
         selection=($("#drpDistrict").val()==null || $("#drpDistrict").val()=="")?2:1; 
        
        div_id = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();
        range_code = ($("#drpRngList").val() == null || $("#drpRngList").val() == "") ? "" : $("#drpRngList").val();
        dist_id = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
        
        tahasil_id = ($("#drpTehList").val() == null || $("#drpTehList").val() == "") ? 0 : $("#drpTehList").val();
        
        
        var condn,operator,opvalue;
        condn = ''; //($("#ddlCondn").val()==null || $("#ddlCondn").val()=="")?"":$("#ddlCondn").val();
        operator=''; //($("#ddlOperator").val()==null || $("#ddlOperator").val()=="")?"":$("#ddlOperator").val();
        opvalue=-1; //($("#txtValue").val()==null || $("#txtValue").val()=="")?-1:$("#txtValue").val();
        
        $(".apploader-base").css("display", "block");
        $.ajax({
            url: '/ProgressMonitoring/nfbSummaryPartial2',
            data: {
                'land_type': $("#drpfltype").val(),
                'selection': selection,
                'dist_id': dist_id,
                'div_id': div_id,
                'tahasil_id': tahasil_id,
                'range_code': range_code,
                'info': JSON.stringify($("#spnotif").text()),
                'condn':condn,
                'operator':operator,
                'opvalue':opvalue,
                'cq':cquery
            },
            contentType: 'application/html; charset=utf-8',
            type: 'GET',
            dataType: 'html',
            success: function(result) {
            	 $(".apploader-base").css("display", "none");
            	 
                $('#divform').show();
                //$('#map').hide();
                $('#divform').empty();
                $('#divform').html(result);
                
                //$('#drpDisFields').multiselect("refresh");
                
                
            },
            error: function(errormessage) {
            	$(".apploader-base").css("display", "none");
               // alert(errormessage.responseText);
            }
            
        });
    } else {
        //AlertNotify("Please cdltp type.");
    }
}});
</script>

<script type="text/javascript">



var cquery="";
$("#btnApply").click(function() {
	cquery="";
	//var res=$('#faqs').parent().parent().parent().find("input").val();
	var table=$('#faqs');
	
	  table.find('tr').each(function (i, el) {
	        var $tds = $(this).find('td');
	            //test = $tds.eq(0).text(),
	            
	        var logicl='';
	        var condn;
	            if(i!=0){
	            	logicl=$tds.eq(0).find("select").val();
	            	condn=$tds.eq(0).find(".col-md-8").find("select").val();
	            }
	            else{
	            	condn=$tds.eq(0).find("select").val();
	            }
	         	    
	        var operators=$tds.eq(1).find("select").val();
	        var val=$tds.eq(2).find("input").val();
	        //alert(logicl+' '+condn+' '+operators+'  '+val);
	        cquery+=' '+logicl+' '+condn+' '+operators+' '+val;
	       
	    });

	  $("#btnCloseAdvFiler").trigger('click');
});

$("#btnClear").click(function(){
	cquery="";
	
	var table=$('#faqs');
	  table.find('tr').each(function (i, el) {
		  if(i!=0){
			  el.remove();
		  }
		  else{
			  $("#ddlQbFields1").val('');
			  $("#ddlQbOperators1").val('');
			  $("#txtQbValue1").val('');
		  }
		  //$('#faqs-row2').remove();
	  });
	
	  $("#btnCloseAdvFiler").trigger('click');
	
});

</script>


    
    