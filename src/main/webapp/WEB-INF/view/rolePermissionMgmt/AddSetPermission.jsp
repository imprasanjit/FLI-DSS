<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="../shared/header.jsp" %>
<%@ include file="../shared/sidebar.jsp" %>
 <div class="content-wrapper">
    <div class="container-fluid">
		<div class="row">
		    <div class="col-sm-6">
		        <h4 class="page-title">Configuration</h4>
		    </div>
		    <div class="col-sm-6">
		                <ol class="breadcrumb">
		                    <li class="breadcrumb-item"><a href="javaScript:void();">Home</a></li>
		                    <li class="breadcrumb-item active" aria-current="page">Set Permission</li>
		                </ol>
		    </div>
		</div>
		<div class="row">
		    <div class="col-lg-12">
		        <div class="card">
		            <div class="card-body">
		               <form:form method="post" modelAttribute="SetPermission" action="/">
		                    <h4 class="form-header text-uppercase">
		                        <i class="fa fa-folder-open-o"></i>
		                        Set Role Wise Permission
		                    </h4>
		                    <div class="row">
		                        <div class="col-sm-6">
		                            <div class="form-group row">
		                                <!-- @Html.LabelFor(m=>m.did, new { @class = "col-sm-4 col-form-label"}) -->
		                                <%-- <form:label path="did"></form:label> --%>
		                                <label>Designation</label>
		                                <div class="col-sm-8">
		                                    <form:select id="drpdesiglist" path="" name="drpdesiglist" class = "form-control single-select">
						                        <option value="">--Select--</option> 
						                        <c:forEach items="${dlist}" var="desig">
						                            <option   value="${desig.intId}"  >${desig.chrvDesignationNm}</option>
						                        </c:forEach>
					                       </form:select> 
		                                </div> 
		                            </div> 
		                        </div>
		                        <div class="col-sm-6">
		                            <div class="form-group row">
		                                <label>Position</label>
		                                <div class="col-sm-8">
		                                    <select class="form-control single-select" id="drpposilist" name="drpposilist" required>     
		                                    </select>
		                                </div>    
		                            </div>
		                        </div> 
		                    </div>  
		                    <hr>
		                    <div class="btn-group" id="btnType">
                                <button id="btnview" type="button" class="btn btn-success waves-effect waves-light font-10">View</button>
                                <button id="btnedit" type="button" class="btn btn-secondary waves-effect waves-light font-10">Edit</button>
                			</div>                
		             </form:form> 
		            </div>
		        </div>
		    </div>
		</div>
		<div id="divform">		
		</div>	
		</div>
</div>
<%@ include file="../shared/footer.jsp" %>
	<script>
		    var items = "<option value='0'>--Select--</option>";
		    $("#drpposilist").html(items);
		    //Bind Role wise position dropdownlist
		    $("#drpdesiglist").change(function () {
		        $('#divform').empty();
		         var did=$('#drpdesiglist').val();
		         if($('#drpdesiglist').val()!='')
		         {

		             $.ajax({
		                     url:'/api/Utility/GetPositionListById',
		                     data: { 'did':did},
		                     type: "GET",
		                     contentType: "application/json;charset=utf-8",
		                     dataType: "json",
		                     success: function (data) {
		                         $('#drpposilist').html('');
		                         var options = '';
		                         $('#drpposilist')
		                             .append($("<option></option>")
		                                 .attr("value", "0")
		                                 .text("--Select--"));
		                         $.each(data, function (a, b) {
		                       	  console.log(b);
		                             options += '<option value="' + b.intId + '">' + b.chrvPosNm + '</option>';
		                         });
		                               $('#drpposilist')
		                                 .append(options);
		                     },
		                     error: function (errormessage) {
		                         alert(errormessage.responseText);
		                     }
		                 }); 
		         	}              
		        });
			 //Designation Drop Down Change Event
		     /* $("#drpdesiglist").change(function () {
		         $('#divform').empty();
		      }); */
		     //View and Edit button on condition
			    $(document).ready(function(){
			        $('#drpposilist').on('change', function() 
			        {
			            if ( this.value != 0)
			            {
			                $("#btnType").show();
			                $("#btnview").trigger("click");
			            }
			            else
			            {
			                $("#btnType").hide();
			            }
			        });
			    });
		    //View Permission
		     $("#btnview").click(function()
		      {
		            if($('#drpdesiglist').val()!=0 && $('#drpposilist').val()!=0)
		            {
			                ManageLoader(1);
			                $.ajax({
			                    url:'/_PartialViewSetPermission',
			                    	//'@Url.Action("_PartialViewSetPermission","Configuration")',
			                    data: {'did':$('#drpdesiglist').val() ,'pid':$('#drpposilist').val()},
			                    contentType: 'application/html; charset=utf-8',
			                    type: 'GET',
			                    dataType: "html",
			                })
			                .success(function (result) {
			                $('#divform').empty();
			                $('#divform').html(result);
			                ManageLoader(0);
			                //Load Table
			                MergeCellsOfTable('example');
			                LoadCustomDataTableCustomButtonFunctions('example',
			                [{
			                extend: 'excel',
			                footer: true,
			                exportOptions: {
			                    columns: [0,1,2,3]
			                }
			            },
			            'print']
			                ); 
			                })
			                .error(function (xhr, status) {
			                    alert(status);
			                }) 
		            }
		            else
		            {
		                AlertNotify("Please select Designation and Role");
		            } 
		      });
		     //Edit Permission
		     $("#btnedit").click(function()
		      {
		            if($('#drpdesiglist').val()!=0 && $('#drpposilist').val()!=0)
		            {
		                ManageLoader(1);
		                $.ajax({
		                    url:' /_PartialPermissionEdit',
		                    	//'@Url.Action("_PartialPermissionEdit","Configuration")',
		                    data: {'did':$('#drpdesiglist').val() ,'pid':$('#drpposilist').val()},
		                    contentType: 'application/html; charset=utf-8',
		                    type: 'GET',
		                    dataType: "html",
		                })
		                .success(function (result) {
		                $('#divform').empty();
		                $('#divform').html(result);
		                ManageLoader(0);
		                //Load Table
		                LoadCustomDataTableCustomButtonFunctions('example1',
		                [{
		                extend: 'excel',
		                footer: true,
		                exportOptions: {
		                    columns: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
		                }
		            },
		            'print']
		                );
		                
		                })
		                .error(function (xhr, status) {
		                    alert(status);
		                }) 
		            }
		            else{
		                AlertNotify("Please select Designation and Role");
		            } 
		      });
		 </script>
		

