<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>



 <div id="content" class="main-content">
            <div class="layout-px-spacing">

                <div class="row layout-top-spacing">

                    <div class="col-md-12 layout-spacing">
                        
                        <div class="statbox widget box box-shadow">
                            <div class="widget-header">
                                <div class="row">
                                    <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                        <h4>Position Creation</h4>
                                        <a href="add_user.html" type="button"  data-toggle="modal" data-target="#addRoleModal" class="btn btn-sm btn-info btn-fix" ><i class="fa fa-plus">&nbsp;</i>Add position</a>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-content widget-content-area" id="txtrole">
                                <div class="table-responsive">
                                    <table id="zero-config" class="table table-bordered" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th>Sl. No.</th>
                                                <th>Role</th>  
                                                <th>Position</th>                                            
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:forEach items="${posList}" var="item" varStatus="Counter">
                                            <tr>
                                                <td>${item.intId}</td>
                                                <td>${item.roleMaster.chrvRoleNm}</td>
                                                <td>${item.chrvPositionNm}</td>                                                                                             
                                                <td><button type="button" class="btn btn-sm btn-info"  data-toggle="modal" data-target="#positionModal"  
                                                 onclick="BindRoleNm(${item.intId},'${item.chrvPositionNm}')"><i aria-hidden="true" class="fa fa-edit" ></i></button>
										<%-- '${item.roleMaster.chrvRoleNm}', --%>
										</td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>                    
                </div>
            </div>
</div>
  <!-- Modal for update position-->
       <div class="modal fade" id="positionModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Edit Position</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                        </button>
                    </div>
                    <div class="modal-body">                      
                        <form>
                        	<div class="row form-group">
                                <div class="col-md-3">
                                    <label>Role</label>                                   
                                </div>
                               		<div class="col-md-9">
									 <select class="form-control" id="drpRole" 
										name="drpRole">
										<option value="">--Select--</option>
										<c:forEach items="${rolelist}" var="role">
											<option value="${role.intID}" id="txtRoleNm">${role.chrvRoleNm}</option>
										</c:forEach>								
									</select> 
									<%-- <form:select  id="drpRole" path="editRoleNm.RoleMaster.intID"
												class="form-control single-select">
												<option value="">Select</option>
												 <form:options path="editRoleNm.RoleMaster.intID" items="${rolelist}"
											itemValue="intID" itemLabel="chrvRoleNm" />												
											</form:select>  --%>
									</div>
								</div>                                	                                                            
                            <div class="row form-group">
                                <div class="col-md-3">
                                    <label>Position</label>                                   
                                </div>
                                <div class="col-md-9">
                                    <input type="text" id="txtPositionName" class="form-control" placeholder="Name">
                                    <span id="lblError" style="color: red"></span>
                                     <input type="hidden" id="hdnPosnId" class="form-control" placeholder="Id">
                                </div>
                            </div>
                            <hr>
                            <div class="row text-center">
                                <div class="col-md-12">                                   
                                    <button type="button" id="btnUpdate" class="btn btn-success">Update</button>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
         <!-- Modal for add position-->
     <div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Add Role</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                       <form>
                       		<div class="row form-group">
                                <div class="col-md-3">
                                    <label>Role</label>                                   
                                </div>
                               		<div class="col-md-9">
									 <select class="form-control" id="drpRole1" path=""
										name="drpRole1">
										<option value="">--Select--</option>
										<c:forEach items="${rolelist}" var="role">
											<option value="${role.intID}" id="txtRoleNm">${role.chrvRoleNm}</option>
										</c:forEach>								
									</select>
									</div>
									</div>
                            <div class="row form-group">
                                <div class="col-md-3">
                                    <label>Position</label>
                                    
                                </div>
                                <div class="col-md-9">
                                    <input type="text" id="txtPositionName1" class="form-control" placeholder="Name">
                                    <span id="lblError1" style="color: red"></span>
                                      <input type="hidden" id="hdnIdPos1" class="form-control" placeholder="Id"> 
                                </div>
                            </div>
                            <hr>
                            <div class="row text-center">
                                <div class="col-md-12">
                                    <!-- <button type="button" id="btnSubmit" class="btn btn-success">Submit</button> -->
                                    <button type="button" id="btnSubmit" class="btn btn-success">Submit</button>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>        
<%@ include file="../shared/footer.jsp"%>

<script type="text/javascript">
//Bind Role  details
function BindRoleNm(pId,pName)
{   	
	//$("#drpRole").val(rolId);
	$("#hdnPosnId").val(pId);
	$("#txtPositionName").val(pName);
	
}

//Button To Update the Position
 $('#btnUpdate').click(function(){		
        $.ajax({
       url:'/UserMgmt/updatePosition',
       data: {'rId':$("#drpRole").val(),'positionNM':$("#txtPositionName").val(),'id':$("#hdnPosnId").val()},
       type: 'POST',
       dataType: "json",
       success: function (data) {
    	   viewNotification(data);                                    
           if(data==9)
           setTimeout(function(){ window.location.reload();}, 1000);                                                  
         }
     })      
   });  
//Button To Create the Role
 $('#btnSubmit').click(function(){
        $.ajax({
        url:'/UserMgmt/addPosition',    
        data: { 'rid':$("#drpRole1").val(),'newPosNM':$("#txtPositionName1").val()},
        type: 'POST',
        dataType: "json",
        success: function (data) {  
        	viewNotification(data);
        	if(data==5)
                setTimeout(function(){ window.location.reload();}, 1000);
              $('#btnSubmit').show();
              $("#txtPositionName1").val('');
              
          }
      })         
    }); 
//Validate Only Alphabet For Name
 $(function (chkAlphabet) {
 $("#txtPositionName1,#txtPositionName").keypress(function (e) {
     var keyCode = e.keyCode || e.which;

     $("#lblError").html("");
     $("#lblError1").html("");

     //Regex for Valid Characters i.e. Alphabets
     var regex = /^[A-Za-z ]+$/;

     //Validate TextBox value against the Regex.
     var isValid = regex.test(String.fromCharCode(keyCode));
     if (!isValid) {
         $("#lblError").html("Only Alphabets allowed.");
         $("#lblError1").html("Only Alphabets allowed.");
     }

     return isValid;
 });
 });
</script>

  
        