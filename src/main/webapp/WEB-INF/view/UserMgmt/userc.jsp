<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>


<body class="alt-menu sidebar-noneoverflow">
	
	<div id="content" class="main-content">
		<div class="layout-px-spacing">

			<div class="row layout-top-spacing">

				<div class="col-md-12 layout-spacing">

					<div class="statbox widget box box-shadow">
						<div class="widget-header">
							<div class="row">
								<div class="col-xl-12 col-md-12 col-sm-12 col-12">
									<h4>User Creation</h4>
									<a href="add_user.html" type="button"
										class="btn btn-sm btn-info btn-fix"  data-toggle="modal" data-target="#addUserModal" ><i class="fa fa-plus">&nbsp;</i>Add
										User</a>
								</div>
							</div>
						</div>
						<div class="widget-content widget-content-area">
							<div class="">
								<div class="form-group row">
									<div class="col-md-3">
										<label>Role</label>									
										<select class="form-control" id="drprole" name="drprole">
											<option value="">--Select--</option>
											<c:forEach items="${rlist}" var="item">
												<option value="${item.intID}" id="txtRoleNm">${item.chrvRoleNm }</option>
											</c:forEach>
										</select>										
									</div>
									<div class="col-md-3">
										<label>Position</label>									
										<select class="form-control" id="drpposilist"
											name="drpposilist">
											<option value="">--Select--</option>
											<c:forEach items="${pList}" var="item">
												<option value="${item.intId}" id="txtRoleNm">${item.chrvPositionNm }</option>
											</c:forEach>
										</select>

									</div>									
									<div class="col-md-6 mt-2">
										<br>
										<button type="button" id="btnsearch" title="Search"
											class="btn btn-success waves-effect waves-light">
											<i aria-hidden="true" class="fa fa-search">&nbsp;</i>Search
										</button>
									</div>
								</div>
							</div>
						</div>						
					</div>
					<div id="divform" class="mt-3"></div>
				</div>
			</div>
		</div>
	</div>

<!--  END CONTENT AREA  -->	

<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Add Role</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                       <form id="userformNu">
                       		<div class="row form-group">
                                <div class="col-md-2">
                                    <label>Role</label>                                   
                                </div>
                               		<div class="col-md-4">
									 <select class="form-control" id="drpRoleModalNU" 
										name="drpRoleModalNU">
										<option value="">--Select--</option>
										<c:forEach items="${rlist}" var="role">
											<option value="${role.intID}" id="txtRoleNm">${role.chrvRoleNm}</option>
										</c:forEach>								
									</select>
									</div>
									
                                <div class="col-md-2">
                                    <label>Position</label>
                                    
                                </div>
                                <div class="col-md-4">
                                   <select class="form-control" id="drpPosModalNU" 
										name="drpPosModalNU">
										<option value="">--Select--</option>
										<c:forEach items="${pList}" var="pos">
											<option value="${pos.intId}" id="txtRoleNm">${pos.chrvPositionNm}</option>
										</c:forEach>								
									</select>
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-2">
                                    <label>Name</label>
                                    
                                </div>
                                <div class="col-md-4">
                                    <input type="text" id="nameDiv" class="form-control" placeholder="Name" required="required">
                                    <span id="lblError" style="color: red"></span>
                                       <input type="hidden" id="hdnIdnameDiv" class="form-control" placeholder="Id"> 
                                </div>
                            
                                <div class="col-md-2">
                                    <label>Email</label>
                                    
                                </div>
                                <div class="col-md-4">
                                    <input type="email" id="emailDiv" class="form-control" placeholder="Email" required="required">
                                      <!-- <input type="hidden" id="hdnIdPos1" class="form-control" placeholder="Id">  -->
                                </div>
                            </div>
                             <div class="row form-group">
                                <div class="col-md-2">
                                    <label>Mobile No</label>
                                    
                                </div>
                                <div class="col-md-4">
                                    <input type="text" id="mobileDiv" class="form-control" placeholder="Mobile No">
                                      <!-- <input type="hidden" id="hdnIdPos1" class="form-control" placeholder="Id">  -->
                                </div>
                            </div>
						<div id="divforestNu">
							<div class="form-group row">
								
									<div class="col-md-2">
										<label>Circle</label>
									</div>
									<div class="col-md-4">
										<select class="form-control" id="drpNewUserCircle" name="drpNewUserCircle">
											<option value="">--Select--</option>
											<c:forEach items="${cirList}" var="item">
												<option value="${item.intId}" id="txtRoleNm">${item.chrvCircle}</option>
											</c:forEach>
										</select>
									</div>
								
									<div class="col-md-2">
										<label>Division</label>
									</div>
									<div class="col-md-4">
										<select class="form-control" id="drpNewUserDivision" name="drpNewUserDivision">
											<option value="">--Select--</option>
											<c:forEach items="${divList}" var="item">
												<option value="${item.intId}" id="txtRoleNm">${item.chrvDivisionNm}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						
						<div class="row form-group" id="drpDivRngNu">
									<div class="col-md-2">
										<label>Range</label>
									</div>
									<div class="col-md-4">
										<select class="form-control" id="drpNewUserRange" name="drpNewUserRange">
											<option value="">--Select--</option>
											<c:forEach items="${rngList}" var="item">
												<option value="${item.chrvRangeCd}" id="txtRoleNm">${item.chrvRangeNm}</option>
											</c:forEach>
										</select>
									</div>
								</div>
					<div class="row form-group" id="divDistTehNU">								
									<div class="col-md-2">
										<label>District</label>
									</div>
									<div class="col-md-4">
										<select class="form-control" id="drpNewUserDistrict" name="drpNewUserDistrict">
											<option value="">--Select--</option>
											<c:forEach items="${distList}" var="item">
												<option value="${item.intId}" id="txtRoleNm">${item.chrvDistrictNm}</option>
											</c:forEach>
										</select>
									</div>
								
									<div class="col-md-2">
										<label>Tehsil</label>
									</div>
									<div class="col-md-4">
										<select class="form-control" id="drpNewUserTeh" name="drpNewUserTeh">
											<option value="">--Select--</option>
											<c:forEach items="${tehList}" var="item">
												<option value="${item.intId}" id="txtRoleNm">${item.chrvTahasilNm}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								
						<hr>
                            <div class="row text-center">
                                <div class="col-md-12">                                   
                                    <button type="submit" id="btnSubmit" class="btn btn-success">Submit</button>                                   
                                </div>
                            </div>
                        </form>

		
                    </div>
                </div>
            </div>
        </div>


<%@ include file="../shared/footer.jsp"%>


	<script type="text/javascript">
  //Insert default item "Select" in dropdownlist on load
    $(document).ready(function () {
        var items = "<option value='0'>--Select--</option>";
        $("#drpposilist").html(items);
        
    }); 
  
  //Bind Role wise position dropdownlist for partialUserEdit
  $("#drprole").change(function (){
        $.ajax({
            url:'/Utility/getRoleWisePositionList',
            data: { 'roleid':$('#drprole').val() },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function (data) {
                $('#drpposilist').html('');
                var options = '';
                $.each(data, function (a, b) {
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
//Button Search Click Event
  $('#btnsearch').click(function(){	  
    if($('#drprole').val()!='' && $('#drpposilist').val()!='')
    {  
      $.ajax({
              url: '/UserMgmt/partialUserCreation',
              data:{'roleId':$('#drprole').val(),'positionId':$('#drpposilist').val()},
              contentType: 'application/html; charset=utf-8',
              type: 'GET',
              dataType: "html",          
          success: function (result) {       	  
            $('#divform').empty();
            $('#divform').html(result);         
          },
          error: function(errormessage) {
              alert(errormessage.responseText);
          }      
    });  
  }
  else{
	  AlertNotify("Please select Position and role."); 
    }
  });

//Insert default item "Select" in dropdownlist on load
  $(document).ready(function () {
      var items = "<option value='0'>Select</option>";
      $("#drpdivisionlist").html(items);
      $("#drpcirclelist").html(items);
      $("#drprangelist").html(items);
      
  });
 
  /* Bind User Details in modal popup for partialUserEdit page*/
  function BindUserDetails(uId) {
	    $.ajax({
	        url: '/UserMgmt/partialUserEdit',
	        data: {
	            'uId': uId
	            //name:$("#nameModal").val(name),	
	   // contNum:$("#numberModal").val(contNum)
	        },
	        contentType: "application/json; charset=utf-8",
	        type: 'GET',
	        dataType: "html",

	        success: function(result) {
	            $('#modalDiv').empty();
	            $('#modalDiv').html(result);
	            $('#userCreationModal').modal('show');
	            

	        },
	        error: function(errormessage) {
	            alert(errormessage.responseText);
	        }
	    });
	}
  
  //On change of role for partialUserEdit Page
  function divHideShow(){	  	 
	  if ($('#drpRoleEditModal').val() == 12) {
          $("#divforest").show();
         $("#drpDivs").hide();
          $("#divrange").hide();
          $("#divDistTeh").hide();
      } else if($('#drpRoleEditModal').val() == 7) {
    	  $("#divforest").hide();
          $("#drpDivs").hide();
           $("#divrange").hide();
           $("#divDistTeh").show();
      }  
      else if($('#drpRoleEditModal').val() == 9) {
    	  $("#divforest").show();
    	  $("#divrange").show();
          $("#drpDivs").show();           
           $("#divDistTeh").hide();
      }  
      else if(($('#drpRoleEditModal').val() == 5) || ($('#drpRoleEditModal').val() == 6) || ($('#drpRoleEditModal').val() == 8)) {
    	  $("#divforest").show();
    	  $("#divrange").hide();
          $("#drpDivs").show();           
           $("#divDistTeh").hide();
      } 
      else{
    	  $("#divforest").hide();
          $("#drpDivs").hide();
           $("#divrange").hide();
           $("#divDistTeh").hide();
      }
  };


//Bind Role wise position dropdownlist For New User
  $("#drpRoleModalNU").change(function () {
        $.ajax({
            url:'/Utility/getRoleWisePositionList',
            data: { 'roleid':$('#drpRoleModalNU').val() },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function (data) {
                $('#drpPosModalNU').html('');
                var options = '';
                $.each(data, function (a, b) {
                    options += '<option value="' + b.value + '">' + b.text + '</option>';
    
                });
                  $('#drpPosModalNU')
                  .append(options); 
                  divHideShowForNewUser();
            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });  
  });
  //On change of role for New User
 // $("#drpRoleModalNU").change(function (){  
	 function divHideShowForNewUser(){
	  if ($('#drpRoleModalNU').val() == 12) {
          $("#divforestNu").show();
         $("#drpNewUserDivision").hide();
          $("#drpDivRngNu").hide();
          $("#divDistTehNewUser").hide();
      } 	
	  else if($('#drpRoleModalNU').val() == 7) {
    	  $("#divforestNu").hide();
          $("#drpNewUserDivision").hide();
           $("#drpDivRngNu").hide();
           $("#divDistTehNU").show();
      }  
      else if($('#drpRoleModalNU').val() == 9) {
    	  $("#divforestNu").show();
    	  $("#drpDivRngNu").show();
          $("#drpNewUserDivision").show();           
           $("#divDistTehNU").hide();
      }  
      else if(($('#drpRoleModalNU').val() == 5) || ($('#drpRoleModalNU').val() == 6) || ($('#drpRoleModalNU').val() == 8)) {
    	  $("#divforestNu").show();
    	  $("#drpDivRngNu").hide();
          $("#drpNewUserDivision").show();           
           $("#divDistTehNU").hide();
      } 
      else{
    	  $("#divforestNu").hide();
          $("#drpNewUserDivision").hide();
           $("#drpDivRngNu").hide();
           $("#divDistTehNU").hide();
      }
  };
//Bind Circle wise Division dropdownlist for New User
  $("#drpNewUserCircle").change(function () {
	  	  
  $.ajax({
        url:'/Utility/getCircleWiseDivisionList',
        data: { 'cirid':$('#drpNewUserCircle').val() },
        type: "GET",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (data) {
            $('#drpNewUserDivision').html('');
            var options = '';
            options += '<option value=0>All</option>';
            $.each(data, function (a, b) {
                options += '<option value="' + b.value + '">' + b.text + '</option>';

            });
              $('#drpNewUserDivision')
              .append(options); 
        },
        error: function(errormessage) {
            alert(errormessage.responseText);
        }
    });  
});
//Validate Only Alphabet For Name
  $(function (chkAlphabet) {
  $("#nameDiv").keypress(function (e) {
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
  $(document).ready(function() {

	  $('#mobileDiv').on('keypress', function(e) {

	             var $this = $(this);
	             var regex = new RegExp("^[0-9\b]+$");
	             var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
	             // for 10 digit number only
	             if ($this.val().length > 9) {
	                 e.preventDefault();
	                 return false;
	             }
	             if (e.charCode < 54 && e.charCode > 47) {
	                 if ($this.val().length == 0) {
	                     e.preventDefault();
	                     return false;
	                 } else {
	                     return true;
	                 }

	             }
	             if (regex.test(str)) {
	                 return true;
	             }
	             e.preventDefault();
	             return false;
	         });

	    });
//Button To Create the New User
  $('#btnSubmit').click(function(){
	 
	  var cirId, divId, rngCode, distId, tehId;
	  cirId =($("#drpNewUserCircle").val() == null || $("#drpNewUserCircle").val() == "") ? 0 : $("#drpNewUserCircle").val();
		       divId =($("#drpNewUserDivision").val() == null || $("#drpNewUserDivision").val() == "") ? 0 : $("#drpNewUserDivision").val();
		       rngCode= ($("#drpNewUserRange").val() == null || $("#drpNewUserRange").val() == "") ? "All0" : $("#drpNewUserRange").val();
		       distId = ($("#drpNewUserDistrict").val() == null || $("#drpNewUserDistrict").val() == "") ? 0 : $("#drpNewUserDistrict").val();
		      tehId = ($("#drpNewUserTeh").val() == null || $("#drpNewUserTeh").val() == "") ? 0 : $("#drpNewUserTeh").val();
		      
		       $.ajax({          	 
         url:"/UserMgmt/addNewUser",    
         data: {         	 
        	 'roleId':$("#drpRoleModalNU").val(),
        	 'posId':$("#drpPosModalNU").val(),
        	 'name':$("#nameDiv").val(),
        	 'mail':$("#emailDiv").val(),
        	 'mobileNo':$("#mobileDiv").val(),        
        	 'cirId':cirId,
        	 'divId':divId,
        	 'rngCode':rngCode,
        	 'distId':distId,
        	 'tehId':tehId
        	 },
        	 type: 'POST',
         dataType: "json",
         success: function (data) {  
         	viewNotification(data);
         	if(data==5)
                 setTimeout(function(){ window.location.reload();}, 500);
               $('#btnSubmit').show();
               
               //divHideShowForNewUser();
               //$("#nameDiv").val('');              
           }
       })         
     }); 
   </script>
