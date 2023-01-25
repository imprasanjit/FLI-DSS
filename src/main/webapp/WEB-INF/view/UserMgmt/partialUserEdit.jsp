<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



	<form:form modelAttribute="autouinfo" action="/UserMgmt/updateUser" id="userform">
		<div class="row form-group">
			<div class="col-md-6">
				<form:label path="RoleMaster.intID" >Role</form:label>
				<form:select id="drpRoleEditModal" path="RoleMaster.intID"
					class="form-control single-select">
					<form:option value="" >Select</form:option>
					<form:options items="${autoUserInfoMaster.rolList}" 
						itemValue="intID" itemLabel="chrvRoleNm" />
				</form:select>
				<div class="col-md-6" style="display: none">
				<form:label path="chrvUserId">User ID</form:label>
				<!-- <input type="hidden" id="hdnId" class="form-control" placeholder="Id"> -->
				 <form:hidden  class="form-control"
					path="chrvUserId" placeholder="User Id" id="userIdModal" value="${emodel.chrvUserId}"/>
			</div>
			</div>
			
			 <div class="col-md-6">
				<form:label path="PositionMaster.intId">Position</form:label>
				<form:select id="drpPosEditModal"
					path="PositionMaster.intId"
					class="form-control single-select">
					<form:option value="" >Select</form:option>
					<form:options items="${autoUserInfoMaster.posList}" itemValue="intId" itemLabel="chrvPositionNm" />
						
				</form:select>
			</div>
		</div> 
		   <div class="row form-group">
			<div class="col-md-6">
				<form:label path="chrvNm">Name</form:label> 
				<form:input type="text" class="form-control"
					path="chrvNm" placeholder="Name" id="nameModal"  value="${emodel.chrvNm}"/>
					
			</div>
			<div class="col-md-6">
				<form:label path="chrvEmail">Email ID</form:label>
				 <form:input type="email" class="form-control"
					path="chrvEmail" placeholder="Email ID" id="mailModal"/>
			</div>
		</div>

		<div class="row form-group">
			<div class="col-md-6">
				<form:label path="chrvContactNo">Mobile No.</form:label>
				 <form:input type="number" class="form-control"
					path="chrvContactNo" placeholder="Mobile No." id="numberModal"/>
			</div>
		</div> 
		<div id="divforest">
			<div class="form-group row">
				<form:label for="input-14" class="col-sm-2 col-form-label" path="CircleMaster.intId">Circle</form:label>
				<div class="col-sm-4">
					<form:select id="drpCirEditModal"
						path="CircleMaster.intId"
						class="form-control single-select">
						<form:option value="" >Select</form:option>
						<form:options 
							items="${autoUserInfoMaster.cirList}" itemValue="intId" itemLabel="chrvCircle" />
					</form:select>
				</div>
				<label for="input-15" class="col-sm-2 col-form-label" id="lblDivs">Division</label>
				<div class="col-sm-4" id="drpDivs">
					<form:select id="drpDivEditModal"
						path="DivisionMaster.intId"
						class="form-control single-select">
						<form:option value="">Select</form:option>
						<form:options 
							items="${autoUserInfoMaster.divList}" itemValue="intId" itemLabel="chrvDivisionNm" />
					</form:select>
				</div>
			</div>
		</div>
		 <div>
			<div class="form-group row" id="divrange">
				<form:label for="input-15" class="col-sm-2 col-form-label" path="RangeMaster.chrvRangeCd">Range</form:label>
				<div class="col-sm-4">
					<form:select id="drpRngEditModal"
						path="RangeMaster.chrvRangeCd"
						class="form-control single-select">
						<form:option value="">Select</form:option>
						<form:options 
							items="${autoUserInfoMaster.rngList}" itemValue="chrvRangeCd" itemLabel="chrvRangeNm" />
					</form:select>					
				</div>
			</div>
		</div> 
		 <div class="form-group row" id="divDistTeh">
			<form:label for="input-14" class="col-sm-2 col-form-label" path="DistrictMaster.intId">District</form:label>
			<div class="col-sm-4">
				<form:select id="drpDistEditModal"
						path="DistrictMaster.intId"
						class="form-control single-select">
						<form:option value="">Select</form:option>
						<form:options 
							items="${autoUserInfoMaster.distList}" itemValue="intId" itemLabel="chrvDistrictNm" />
					</form:select>				
			</div>
			<form:label for="input-15" class="col-sm-2 col-form-label" path="TehsilMaster.intId">Tehasil</form:label>
			<div class="col-sm-4">
				<form:select id="drpTehEditModal"
						path="TehsilMaster.intId"
						class="form-control single-select">
						<option value="">Select</option>
						<form:options 
							items="${autoUserInfoMaster.tehList}" itemValue="intId" itemLabel="chrvTahasilNm" /> 
				</form:select>		
			</div>
		</div> 
		<hr>
		<div class="row form-group text-center">
			<div class="col-md-12">
				<button type="submit" class="btn btn-success" id="btnUpdate" >Update</button>
			</div>
		</div> 
		<script >divHideShow();
		</script>
	 </form:form> 
	
<script>
//divHideShow();
//Bind Role wise position dropdownlist
$("#drpRoleEditModal").change(function () {
      $.ajax({
          url:'/Utility/getRoleWisePositionList',
          data: { 'roleid':$('#drpRoleEditModal').val() },
          type: "GET",
          contentType: "application/json;charset=utf-8",
          dataType: "json",
          success: function (data) {
              $('#drpPosEditModal').html('');
              var options = '';
              $.each(data, function (a, b) {
                  options += '<option value="' + b.value + '">' + b.text + '</option>';
  
              });
                $('#drpPosEditModal')
                .append(options); 
                divHideShow();
          },
          error: function(errormessage) {
              alert(errormessage.responseText);
          }
      });  
});
	  
//Bind Circle wise Division dropdownlist
	  $("#drpCirEditModal").change(function () {
		  	  
	  $.ajax({
            url:'/Utility/getCircleWiseDivisionList',
            data: { 'cirid':$('#drpCirEditModal').val() },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function (data) {
                $('#drpDivEditModal').html('');
                var options = '';
                options += '<option value=0>All</option>';
                $.each(data, function (a, b) {
                    options += '<option value="' + b.value + '">' + b.text + '</option>';
    
                });
                  $('#drpDivEditModal')
                  .append(options); 
            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });  
  });
	//Bind Division wise Range dropdownlist
	  $("#drpDivEditModal").change(function () {
		  	  
	  $.ajax({
            url:'/Utility/getDivwiseRange',
            data: { 'divid':$('#drpDivEditModal').val() },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function (data) {
                $('#divrange').html('');
                var options = '';
                options += '<option value=0>All</option>';
                $.each(data, function (a, b) {
                    options += '<option value="' + b.value + '">' + b.text + '</option>';
    
                });
                  $('#divrange')
                  .append(options); 
            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });  
  });//Bind District wise Tehsil dropdownlist
	  $("#drpDistEditModal").change(function () {
	  	  
		  $.ajax({
	            url:'/Utility/getDistwiseTahasil',
	            data: { 'distid':$('#drpDistEditModal').val() },
	            type: "GET",
	            contentType: "application/json;charset=utf-8",
	            dataType: "json",
	            success: function (data) {
	                $('#drpTehEditModal').html('');
	                var options = '';
	                options += '<option value=0>All</option>';
	                $.each(data, function (a, b) {
	                    options += '<option value="' + b.value + '">' + b.text + '</option>';
	    
	                });
	                  $('#drpTehEditModal')
	                  .append(options); 
	            },
	            error: function(errormessage) {
	                alert(errormessage.responseText);
	            }
	        });  
	  });
//Button To Update the data of User
$("#userform").submit(function(e) {

    e.preventDefault(); // avoid to execute the actual submit of the form.

    var form = $(this);
    var url = "/UserMgmt/updateUser";
    
    $.ajax({
           type: "POST",
           url: url,
           data: form.serialize(), // serializes the form's elements.
           success: function(data)
           {
        	   viewNotification(data);
        	   $('#userCreationModal').modal('hide');
        	   setTimeout(function(){ $('#btnsearch').trigger("click"); }, 1000);        	                
           }
         });    
});
//Validate Only Alphabet For Name
$(function () {
$("#nameModal").keypress(function (e) {
    var keyCode = e.keyCode || e.which;

    $("#lblError").html("");

    //Regex for Valid Characters i.e. Alphabets
    var regex = /^[A-Za-z ]+$/;

    //Validate TextBox value against the Regex.
    var isValid = regex.test(String.fromCharCode(keyCode));
    if (!isValid) {
        $("#lblError").html("Only Alphabets allowed.");
    }

    return isValid;
});
});
//Mobile Number Validation of 10 Digit
$('#numberModal').keypress(function(){
if (this.value.length >= 10)
return false;
});
</script>