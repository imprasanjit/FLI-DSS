<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

<div class="clearfix"></div>

<div id="content" class="main-content">
	<div class="layout-px-spacing">

		<div class="row layout-top-spacing">

			<div class="col-md-12 layout-spacing">

				<div class="statbox widget box box-shadow">
					<div class="widget-header">
						<div class="row">
							<div class="col-lg-12">
								<h4>
									Set Role Wise Permission
								</h4>
								<!-- <div class="card"> -->
									<div class="card-body">
										<form:form   modelAttribute="SetPermission"
											action="/UserMgmt/SetPermission">
											
											<div class="row">
												<div class="col-md-12">
													<div class="form-group row">
														<div class="col-md-3">
															<label>Role</label>
															<form:select id="drpRolelist" path=""
																name="drpRolelist" class="form-control">
																<option value="">--Select--</option>
																<c:forEach items="${rolelist}" var="role">
																	<option value="${role.intID}">${role.chrvRoleNm}</option>
																</c:forEach>
															</form:select>
														</div>
														<div class="col-md-3">
															<label>Position</label>
															<select class="form-control"
																id="drpposilist" name="drpposilist" >
															</select>
														</div>
														<div class="col-md-6 mt-2">		
															<br>											
															<button id="btnview" type="button"
																class="btn btn-success waves-effect waves-light mr-1"><i class="fa fa-eye">&nbsp;</i>View</button>
															<button id="btnedit" type="button"
																class="btn btn-info waves-effect waves-light"><i class="fa fa-edit">&nbsp;</i>Edit</button>
														</div>
													</div>
												</div>
											</div>
											
										</form:form>
									</div>
								<!-- </div> -->
							</div>
						</div>
						<div id="divform"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../shared/footer.jsp"%>
<script>
var items = "<option value='0'>--Select--</option>";
$("#drpposilist").html(items);
$("#drpRolelist").change(function (){
    $.ajax({
        url:'/Utility/getRoleWisePositionList',
        data: { 'roleid':$('#drpRolelist').val() },
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
                options += '<option value="' + b.value + '">' + b.text + '</option>'; 
            });
              $('#drpposilist')
              .append(options); 
        },
        error: function(errormessage) {
            alert(errormessage.responseText);
        }
    });  
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
		    	  
		            if($('#drpRolelist').val()!=0 && $('#drpposilist').val()!=0)
		            {
			                //ManageLoader(1);
			                $.ajax({
			                    url:'/UserMgmt/_PartialViewSetPermission',
			                    	//'@Url.Action("_PartialViewSetPermission","Configuration")',
			                    data: {'rid':$('#drpRolelist').val() ,'pid':$('#drpposilist').val()},
			                    contentType: 'application/html; charset=utf-8',
			                    type: 'GET',
			                    dataType: "html",
			                
			                success:function (result) {
			                $('#divform').html(result);
			                //ManageLoader(0);
			                //Load Table
			               /*  MergeCellsOfTable('example');
			                LoadCustomDataTableCustomButtonFunctions('example',
			                [{
			                extend: 'excel',
			                footer: true,
			                exportOptions: {
			                    columns: [0,1,2,3]
			                }
			            },
			            'print']
			                ) */
			                },
			                error:function (xhr, status) {
			                    alert(status);
			                }
		            });
		            
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
		               // ManageLoader(1);
		                $.ajax({
		                    url:' /UserMgmt/_PartialPermissionEdit',
		                    	//'@Url.Action("_PartialPermissionEdit","Configuration")',
		                    data: {'rleid':$('#drpRolelist').val() ,'pid':$('#drpposilist').val()},
		                    contentType: 'application/html; charset=utf-8',
		                    type: 'GET',
		                    dataType: "html",
		               
		                success:function (result) {
		                $('#divform').empty();
		                $('#divform').html(result);
		                //ManageLoader(0);
		                //Load Table
		               /*  LoadCustomDataTableCustomButtonFunctions('example1',
		                [{
		                extend: 'excel',
		                footer: true,
		                exportOptions: {
		                    columns: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
		                }
		            },
		            'print']
		                ); */
		                
		                },
		                error:function (xhr, status) {
		                    alert(status);
		                } 
		            });
		            
		      }
		      else{
	                AlertNotify("Please select Designation and Role");
	            } 
		      });  
		 </script>


