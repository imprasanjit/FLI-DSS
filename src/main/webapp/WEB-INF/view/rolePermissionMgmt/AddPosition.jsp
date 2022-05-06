<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

<!--  BEGIN CONTENT AREA  -->
  <div id="content" class="main-content">
  <div class="layout-px-spacing">
     <div class="row layout-top-spacing">
     
     <div class="col-md-12 layout-spacing">
                        
                        <div class="statbox widget box box-shadow">
                            <div class="widget-header">
                                <div class="row">
                                    <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                        <h4>Configuration</h4>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-content widget-content-area">
     
		<form:form method="post" modelAttribute="Position">
							<h6 class="form-header text-uppercase">
								<i class="fa fa-folder-open-o"></i> Add Position
							</h6>
							<div class="row">
								<div class="col-sm-12">
									<div class="form-group row">

										<!--  @Html.LabelFor(m=>m.editPosition.int_designation_id, new { @class = "col-sm-2 col-form-label"}) -->
										<label class="col-sm-2 col-form-label">Designation</label>
										<div class="col-sm-4">
										
											<form:select id="drpDesignation" path="editPosition.MDesination.intId"
												class="form-control single-select">
												<option value="">Select</option>
												 <form:options path="editPosition.MDesination.intId" items="${designationList}"
											itemValue="intId" itemLabel="chrvDesignationNm" />
												<%-- <c:forEach items="${designationList}" var="desig">
													<option value="${desig.intId}">${desig.chrvDesignationNm}</option>
												</c:forEach> --%>
											</form:select>
											<!--  @Html.DropDownListFor(m => m.editPosition.int_designation_id, new SelectList(@ViewBag.designationList, "int_id", "chrv_designation_nm"), "--Select--", new { @class = "form-control" ,@id="drpDesignation"}) -->
										</div>
										<!--  @Html.LabelFor(m=>m.editPosition.chrv_pos_nm, new { @class = "col-sm-2 col-form-label"}) -->
										<label class="col-sm-2 col-form-label">Position</label>
										<div class="col-sm-4">

											<form:input path="editPosition.chrvPosNm" id="txtPosition"
												placeholder="Position" required="required"
												class="form-control"></form:input>
											<!-- @Html.EditorFor(m=>m.editPosition.chrv_pos_nm,new { htmlAttributes =  new { @class = "form-control",@required="required",@id="txtPosition",@placeholder = "Position"}}) -->
											<span id="lblError" style="color: red"></span>
										</div>
									</div>
								</div>
							</div>
							<hr>
							<div class="form-footer text-center">

								<input type="submit" id="btnsubmit"
									class="btn btn-success waves-effect waves-light m-1"
									value="Add">
								<button type="button" id="btnUpdate"
									class="btn btn-success waves-effect waves-light m-1"
									title="Update">Update</button>
								<button type="button" id="btnReset" 
									class="btn btn-warning waves-effect waves-light m-1"
									title="Reset">Reset</button>

								<!--  @Html.ActionLink("Reset","AddPosition","Configuration",new{id=""},new{@class="btn btn-warning waves-effect waves-light m-1"})    -->
							</div>
						</form:form>
		
		<div id="divform"></div>
	</div>
</div>
</div>
</div>
</div>
</div>

<%@ include file="../shared/footer.jsp"%>

<!-- <script>
		    var items = "<option value='0'>--Select--</option>";
		    $("#drpposilist").html(items);
		    //Bind Role wise position dropdownlist
		    $("#drpdesiglist").change(function () {
		        $.ajax({
		            url:'@Url.Action("GetPositionList","Utility")',
		            data: { 'id':$('#drpdesiglist').val() },
		            type: "GET",
		            contentType: "application/json;charset=utf-8",
		            dataType: "json",
		            success: function (data) {
		                $('#drpposilist').html('');
		                var options = '';
		                $('#drpposilist').append($("<option></option>").attr("value", "0").text("--Select--"));
		                $.each(data, function (a, b) {
		                    options += '<option value="' + b.value + '">' + b.text + '</option>';
		                });
		                $('#drpposilist').append(options);   
		            },
		            error: function (errormessage) {
		                alert(errormessage.responseText);
		            }
		        });  
		    });
 </script> -->

<script>
   $(document).ready(function () {
        //Bind Position View on page Load
        updatePositionView(); 
    }); 
     if("${btnstatus}"!="")
    {
        $('#btnsubmit').hide();
    }
    else
    {
         $('#btnUpdate').hide();
    }  
    //Load Position Table
    function updatePositionView()
    {
        $.ajax({
                url: '/RolePermissionMgmt/PartialViewPosition',
                contentType: 'application/html; charset=utf-8',
                type: 'GET',
                dataType: "html",
            })
            .success(function (result) {
              $('#divform').empty();
              $('#divform').html(result);
              //Load Table
              MergeCellsOfTable('example');
            })
            .error(function (xhr, status) {
                alert(status);
            }) 
    }
    //Button To Update the data of Position
    $('#btnUpdate').click(function(){
        $.ajax({
        url:'/RolePermissionMgmt/updatePosition', 
     /*     beforeSend: function (request) {
                    request.setRequestHeader("RequestVerificationToken", $("[name='__RequestVerificationToken']").val());
                }, */
        data: { 'designationId':$("#drpDesignation").val(),'positionNm':$("#txtPosition").val(),'id':"${btnstatus}"},
        type: 'POST',
        dataType: "json",
        success: function (data) {
              Notify(data);
              updatePositionView();
              $('#btnUpdate').hide();
              $('#btnsubmit').show();
              $("#txtPosition").val('');
              $("#drpDesignation").val('');
          }
      })         
    }); 
    //Validate Only Alphbet
       $(function () {
        $("#txtPosition").keypress(function (e) {
            var keyCode = e.keyCode || e.which;
 
            $("#lblError").html("");
 
            //Regex for Valid Characters i.e. Alphabets.
            var regex = /^[A-Za-z- ]+$/;
 
            //Validate TextBox value against the Regex.
            var isValid = regex.test(String.fromCharCode(keyCode));
            if (!isValid) {
                $("#lblError").html("Only Alphabets allowed.");
            }
 
            return isValid;
        });
        //Reset Designation and Position
        $("#btnReset").on("click", function () {
            $('#drpDesignation option').prop('selected', function() {
               $('#txtPosition').val('');
                return this.defaultSelected;
            });
        });
    });
 </script>