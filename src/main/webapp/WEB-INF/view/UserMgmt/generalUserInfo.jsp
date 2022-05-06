<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.sparc.flidss.service.TripleDESEncryptionService"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

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
		<div class="row">
			<div class="col-lg-8 offset-md-2">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-12">
								<div class="logUser">
									<i class="fa fa-user"></i>
								</div>
								<form:form  modelAttribute="userForm">

									<div class="loginProfileBox">
										<div class="form-group row">
											<label for="input-10" class="col-md-3 col-form-label">Role</label>
											<div class="col-md-6">												
												<form:input path="editProfile.role.chrvRoleNm"
													id="txtRole"
													class="form-control text-box single-line" readonly="true" />
											</div>
										</div>
										<%
											String a = "${userInfo.getEditProfile().getIntFkCircle()}";
										%>
										<c:if
											test="${userInfo.getEditProfile().getIntFkCircle()!=null && userInfo.getEditProfile().getIntFkCircle()!=0}">
											<div class="form-group row">
												<label for="input-10" class="col-md-3 col-form-label">Circle</label>
												<div class="col-md-6">

													<c:forEach items="${userInfo.getCircleList() }"
														var="circle">
														<c:if
															test="${circle.intId==userInfo.editProfile.intFkCircle}">
															<input readonly="true" type="text" name="lname"
																value="${ circle.chrvCircleNm}"
																class="form-control text-box single-line" />
														</c:if>
													</c:forEach>
												</div>
											</div>
										</c:if>
										<%
											String b = "${userInfo.getEditProfile().getIntFkDivision()}";
										%>

										<c:if
											test="${userInfo.getEditProfile().getIntFkDivision()!=null && userInfo.getEditProfile().getIntFkDivision()!=0}">
											<div class="form-group row">
												<label for="input-10" class="col-md-3 col-form-label">Division</label>
												<div class="col-md-6">
													<c:forEach items="${userInfo.getDivisionList() }"
														var="division">
														<c:if
															test="${division.intId==userInfo.editProfile.intFkDivision}">
															<input readonly="true" type="text" name="lname"
																value="${division.chrvDivisionNm}"
																class="form-control text-box single-line">
														</c:if>
													</c:forEach>
												</div>
											</div>
										</c:if>

										<%
											String c = "${userInfo.getEditProfile().getChrvFkRange()}";
										%>

										<c:if
											test="${userInfo.getEditProfile().getChrvFkRange()!=null && userInfo.getEditProfile().getChrvFkRange()!=0}">
											<div class="form-group row">
												<label for="input-10" class="col-md-3 col-form-label">Range</label>
												<div class="col-md-6">
													<c:forEach items="${userInfo.getRangeList() }" var="range">
														<c:if
															test="${range.intId==userInfo.editProfile.ChrvFkRange}">
															<input readonly="true" type="text" name="lname"
																value="${range.chrvRangeNm}"
																class="form-control text-box single-line">
														</c:if>
													</c:forEach>
												</div>
											</div>
										</c:if>
										<div class="form-group row">
											<label for="input-10" class="col-md-3 col-form-label">User
												ID</label>
											<div class="col-md-6">
												<form:input path="editProfile.chrvUserId" readonly="true"
													type="text" class="form-control text-box single-line" />
											</div>
										</div>
										<div class="form-group row">
											<label for="input-10" class="col-md-3 col-form-label">Email
												ID</label>
											<div class="col-md-6">
												<form:input path="editProfile.chrvEmail" readonly="true"
													type="text" class="form-control text-box single-line"
													id="txtEmail" />
											</div>
											<div class="col-md-2">
												<button type="button" id="btnEmail"
													class="btn btn-warning waves-effect waves-light"
													title="Search">Reset</button>
											</div>
										</div>
										<div class="form-group row">
											<label for="input-10" class="col-md-3 col-form-label">Password</label>           
											<div class="col-md-6">
												<form:input id="txtPassword" type="password" readonly="true"
													name="lname"
													path="editProfile.chrvUserPwd"
													class="form-control text-box single-line" />
											</div>
											<div class="col-md-2">
												<button type="button" id="btnPassword"
													class="btn btn-warning waves-effect waves-light"
													title="Search">Reset</button>
											</div>
										</div>
										<div class="form-group row">
											<label for="input-10" class="col-md-3 col-form-label">Mobile</label>
											<div class="col-md-6">

												<form:input class="form-control" id="txtMobile"
													type="tel" readonly="true" path="editProfile.chrvContactNo" maxlength="10"
													 />
											</div>
											<div class="col-md-2">
												<button type="button" id="btnMobile"
													class="btn btn-warning waves-effect waves-light"
													title="Search" text="" pattern="[0-9]{3}-[0-9]{2}-[0-9]{3}">Reset</button>
											</div>
										</div>

										<div class="form-group row">
											<label for="input-10" class="col-md-3 col-form-label">Signature</label>
											<div class="col-md-6">

												<img width="100%" height="40"
													src="/images/digitalsign/${digital_sign_path}">

											</div>
											<div class="col-md-2">
												<input type="button" value="Reset" id="btnResetSignature"
													class="btn btn-warning waves-effect waves-light"> 
													<input type="submit" value="Update" id="btnUpdateSignature"
													class="btn btn-warning waves-effect waves-light">
													
											</div>
										</div>
									</div>
								</form:form>
							</div>
							<!--/loginProfileBox-->
						</div>
						<!--/col-md-12-->
					</div>
					<!--/row-->
				</div>
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

<script type="text/javascript">
$(document).ready(function () {
    $("#btnUpdateSignature").hide();
    $("#txtSign").hide();
      //Type Number only
      $("#txtMobile").keydown(function(event) {
      // Allow only backspace and delete
      if ( event.keyCode == 46 || event.keyCode == 8 ) {
          // let it happen, don't do anything
      }
      else {
          // Ensure that it is a number and stop the keypress
          if (event.keyCode < 48 || event.keyCode > 57 ) {
              event.preventDefault(); 
          }   
      }
  });
  });
$('#btnMobile').click(function(){
    if($('#btnMobile').text()=='Reset')
    {
      document.getElementById('txtMobile').removeAttribute('readonly');
      $('#btnMobile').text('Update');
    }
    else
    {
      if($('#btnMobile').text()=='Update')
      {
        $.ajax({
          url:'/UserMgmt/generalUserInfo', 
          /* beforeSend: function (request) {
                      request.setRequestHeader("RequestVerificationToken", $("[name='__RequestVerificationToken']").val());
                  }, */
          data: { 'value':$("#txtMobile").val(),'type':"contact_no"},
          type: 'POST',
          dataType: "json",
          success: function (data) {
                Notify(data);
                 $("#btnMobile").text('Reset');
                 $("#txtMobile").attr("readonly","readonly");
            }
        }) 
      }
      else
      {
        $("#btnMobile").text('Reset');
        $("#txtMobile").attr("readonly","readonly");
      }
    }
});
$('#btnEmail').click(function(){
    if($('#btnEmail').text()=='Reset')
    {
      document.getElementById('txtEmail').removeAttribute('readonly');
      $('#btnEmail').text('Update');
    }
    else
    {
      if($('#btnEmail').text()=='Update' && $('#txtEmail').val()!='${userInfo.editProfile.chrvEmail}')
      {
        $.ajax({
          url:''/UserMgmt/generalUserInfo'', 
        /*   beforeSend: function (request) {
                      request.setRequestHeader("RequestVerificationToken", $("[name='__RequestVerificationToken']").val());
                  }, */
          data: { 'value':$("#txtEmail").val(),'type':"email"},
          type: 'POST',
          dataType: "json",
          success: function (data) {
                Notify(data);
                 $("#btnEmail").text('Reset');
                 $("#txtEmail").attr("readonly","readonly");
            }
        }) 
      }
      else
      {
        $("#btnEmail").text('Reset');
        $("#txtEmail").attr("readonly","readonly");
      }
    }
});
//test
$('#btnPassword').click(function(){
      if($('#btnPassword').text()=='Reset')
      {
        $("#txtPassword").prop("type", "text");
        document.getElementById('txtPassword').removeAttribute('readonly');
        $('#btnPassword').text('Update');
      }
      else
      {
        //if($('#btnPassword').text()=='Update' && $("#txtPassword").val()!='@CustomUtility.Decrypt(@Model.editProfile.chrv_user_pwd)')
        	 if($('#btnPassword').text()=='Update' && $("#txtPassword").val()!='${userInfo.editProfile.chrvUserPwd}')
        {
          $.ajax({
            url:''/UserMgmt/generalUserInfo'',
           /*  beforeSend: function (request) {
                        request.setRequestHeader("RequestVerificationToken", $("[name='__RequestVerificationToken']").val());
                    }, */
            data: { 'value':$("#txtPassword").val(),'type':"password"},
            type: 'POST',
            dataType: "json",
            success: function (data) {
                  Notify(data);
                   $("#btnPassword").text('Reset');
                   $("#txtPassword").attr("readonly","readonly");
                    $("#txtPassword").attr("type","password");
              }
          }) 
        }
        else
        {
          $("#btnPassword").text('Reset');
          $("#txtPassword").attr("readonly","readonly");
           $("#txtPassword").attr("type","password");
        }
      }
});
$('#btnResetSignature').click(function(){
    $("#btnUpdateSignature").show();
    $("#btnResetSignature").hide();
    $("#txtSign").show();
  });
  $('#btnUpdateSignature').click(function(){
      var ex = $("#txtSign")[0].files.length;
      var existingext = $("#txtSign").val().split('.').pop();
      if(existingext=="png" || existingext=="jpg" || existingext=="jpeg")
      {
        /*if(ex === 0) 
        {
          AlertNotify("No file selected.");
          event.preventDefault();
        }*/
         if(ex != 0) 
        {
          event.stopPropagation();
        }
      }
      else
      {
        AlertNotify("No file selected!...");
        event.preventDefault();
      } 
  });
</script>
