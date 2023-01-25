<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>

<body onkeypress="return disableCtrlKeyCombination(event);" onkeydown="return disableCtrlKeyCombination(event);" >
	<div class="main-w3ls">
		<div class="left-content">
			<div class="w3ls-content text-center p-4">
				<h4 class="title-govt">
					<img src="/images/logo-odisha-govt-light.png" alt="image" class="" height="70">
					PCCF, Odisha
				</h4>
				<br><br>
				<hr>
				<br><br>
				<h1 class="title-log mt-5">FLI-DSS</h1>
				<div class="row">
					<div class="col-md-8 offset-md-2">
						<div class="log-box">
							<!-- <ul>
								<li><i class="fa fa-map-signs text-success">&nbsp;</i>Joint Verification</li>
								<li><i class="fa fa-map-signs text-success">&nbsp;</i>Demarcation</li>
								<li><i class="fa fa-map-signs text-success">&nbsp;</i>DGPS Survey</li>
								<li><i class="fa fa-map-signs text-success">&nbsp;</i>Geo-Referencing</li>
								<li><i class="fa fa-map-signs text-success">&nbsp;</i>Progress Monitoring</li>
							</ul> -->
						</div>
					</div>
				</div>
			</div>
			<!-- copyright -->
					<!-- //copyright -->
		</div>
		<div class="right-form-agile">
			<!-- content -->
			<div class="sub-main-w3">
				<h3 class="text-center">LOGIN</h3>
				 <form:form method="post" modelAttribute="loginForm" action="/">
					<div class="form-style-agile">
						<label>Email / Mobile No</label>
						<div class="pom-agile">
							<span class="fa fa-envelope-open"></span>
							<form:input path="chrv_user_id" type="text" id="txtuserid" placeholder="Email / Mobile No" required="required"/> 
						</div>
					</div>
					
					<c:if test = "${otpstatus ==1}">
						<div class="form-style-agile">
						         <form:checkbox path="isOTPCheck" id="isOTPCheck" /> 		
							<label>Get an OTP on your phone</label>
						</div>
					</c:if>
					
					<div class="form-style-agile" id="divPwd">
						<label>Password</label>
						<div class="pom-agile">
							<span class="fa fa-key"></span>
							<form:input path="chrv_user_pwd" type="password" id="txtPwd" placeholder="Password" required="required"/> 
						</div>
					</div>
					
					<c:if test = "${otpstatus ==1}">
						<div class="form-style-agile" id="divOTP" style="display:none;">
							<label>OTP</label>
							<div class="pom-agile">
								<span class="fa fa-custom fa-unlock"></span>
								<form:input path="int_eotp" type="number" placeholder="OTP"/>
								<input type="button"  class="btn btn-sm btn-custom btn-warning" value="Generate OTP" id="btnotp"> 
								<form:input path="int_votp" type="hidden"/>
							</div>
						</div>
					</c:if>
					<input type="submit"  value="Submit">
				</form:form>
				<h6 class="site-maintain">Site maintained by <a href="http://sparcindia.com/" target="_blank">SPARC Pvt. Ltd.</a></h6>
			</div>
		</div>
	</div>
	
	<!-- //content -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>	
	<!--notification js -->
	<script src="plugins/notifications/js/lobibox.min.js"></script>
	<script src="plugins/notifications/js/notifications.min.js"></script>
	<script src="plugins/notifications/js/notification-custom-script.js"></script>
	

	<!-- User defined Notification -->
	
	<c:if test = "${ErrorMsg !=null}">
		<script>
			AlertNotify("${ErrorMsg}");
		</script>
	</c:if>
	<script>
		$("#btnotp").click(function(){
			//|| $('#txtPwd').val()==''
			if($("#txtuserid").val()=='' )
			{
				AlertNotify('Email/ Mobile No should not be blank.');
			}
			else{

				$.ajax({
					url: '/sendotp',
					//data: {'uid': $("#txtuserid").val(),'pwd':$("#txtPwd").val()},
					data: {'uid': $("#txtuserid").val()},
					contentType:"application/json;charset=utf-8",
					type: 'GET',
					dataType:"json",
					})
					.success(function (result) {
						if(result!=2)
						{
							$('#int_votp').val(result);
							Notify(16);
						} 
						else //Mobile no is not registered
							AlertNotify('Contact technical partner to register your mobile no.');
					})
					.error(function (xhr, status) {
						alert(status);
					}) 
			}
		});

		//OTP Checkbox Click
		$('#isOTPCheck').change(function() {
        if(this.checked) {
			if($("#txtuserid").val()!="")
			{
				$("#divPwd").hide();
				$("#divOTP").show();
				$('#txtuserid').attr('readonly', true);
				$("#txtotp").attr("required", "required");
			}
			else{
				$('#txtuserid').removeAttr('readonly');
				$("#txtotp").removeAttr("required");
				$('#isOTPCheck').removeAttr('checked');
				AlertNotify('Give your Email Id or Mobile No.');
			}
			$("#txtPwd").removeAttr("required");
			
        }
		else{
			$("#txtotp").removeAttr("required");
			$('#txtuserid').removeAttr('readonly');
			$("#divOTP").hide();
			$("#divPwd").show();
			$("#txtPwd").attr("required", "required");
		}
    });
    </script>
</body>

</html>