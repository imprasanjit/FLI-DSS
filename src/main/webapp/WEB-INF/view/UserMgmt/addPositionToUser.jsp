<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

<div class="apploader-base"><div class="apploader"></div></div>
<div id="content" class="main-content">
    <div class="layout-px-spacing">

        <div class="row layout-top-spacing">

            <div class="col-md-12 layout-spacing">
                
                <div class="statbox widget box box-shadow">
                    <div class="widget-header">
                        <div class="row">
                            <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                <h4>Set user-wise position</h4>
                                <a href="add_user.html" type="button"  data-toggle="modal" data-target="#addRoleModal" class="btn btn-sm btn-info btn-fix" 
                               ><i class="fa fa-plus">&nbsp;</i>Assign Role</a>
                            </div>
                        </div>
                    </div>
                    <div class="widget-content widget-content-area" id="txtrole">
                        <div class="table-responsive">
                            <table id="zero-config" class="table table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Sl.No</th>
                                        <th>User</th>  
                                        <th>Role</th>                                            
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${rusers}" var="item" varStatus="Counter">
                                    <tr>
                                        <td>${item.id}</td>
                                        <td>${item.userName}</td>
                                        <td>${item.userPosition}</td>                                                                                             
                                        <td><button type="button" class="btn btn-sm btn-info"  data-toggle="modal" data-target="#positionToUserModal" 
                                            onclick="BindUserNm('${item.userName}','${item.id}')"> <i aria-hidden="true" class="fa fa-edit"></i></button>
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
<div class="modal fade" id="positionToUserModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">Edit Position </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                </button>
            </div>
            <div class="modal-body">                      
                <form id="list-users">
                    <div class="row form-group">
                        <div class="col-md-3">
                            <label>User</label>
                        </div>
                        <div class="col-md-9">
                            <input type="text"  id="txtName1" class="form-control" readonly>
                            <h2></h2>
                            <span id="lblError1" style="color: red"></span>
                            
                              <input type="hidden" name="userId" id="hfIntUid" class="form-control" placeholder="Id"> 
                        </div>
                    </div>

                    <div class="row form-group">
                        <div class="col-md-3">
                            <label>Position</label>                                   
                        </div>
                        <div class="col-md-9">    
                            <select  class="form-control" id="drpPos" name="drpPos1">
                                <option value="">--Select--</option>
                                <c:forEach items="${rolelist}" var="role">
                                    <option  value="${role.intId}" id="txtRoleNm">${role.chrvPositionNm}</option>																																																										}</option>
                                </c:forEach>	
                            </select> 
                        </div>
                    </div>                                	                                                            
                    
                    <hr>
                    <div class="row text-center">
                        <div class="col-md-12">                                   
                            <button type="submit" id="btnUpdate" class="btn btn-success">Update</button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>
<!-- Modal for user's position-->
<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">Assign Role</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                </button>
            </div>
            <div class="modal-body">
                
               <form  id="add-user-to-role">
                <div class="row form-group">
                    <div class="col-md-3">
                        <label>User</label>                                   
                    </div>
                    <div class="col-md-9">    
                        <select class="form-control" id="drpName" name="userName">
                            <option selected="selected">--Select--</option>
                            <c:forEach items="${uroleList}" var="user">
                                <option value="${user.intId}" id="txtUserNm">${user.chrvNm}</option>																																																										}</option>
                            </c:forEach>	
                        </select> 
                    </div>
                </div>      
                            <div class="row form-group">
                                <div class="col-md-3">
                                    <label>Role</label>                                  
                                </div>
                                <div class="col-md-9">    
                                    <select class="form-control" id="ddlPosition" name="userPosition">
                                        <option value="">--Select--</option>
                                        <c:forEach items="${rolelist}" var="role">
                                            <option value="${role.intId}" id="txtRoleNm">${role.chrvPositionNm}</option>																																																										}</option>
                                        </c:forEach>	
                                    </select> 
                                </div>
                            </div>    
                    <hr>
                    <div class="row text-center">
                        <div class="col-md-12">
                            <!-- <button type="button" id="btnSubmit" class="btn btn-success">Submit</button> -->
                            <button type="submit" id="btnSubmit" class="btn btn-success">Submit</button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>
<%@ include file="../shared/footer.jsp"%>
<script src="assets/js/custom/notification.js"></script>               
<script type="text/javascript">
    //Bind Role  details
    function BindUserNm(userName, intUid)
    {   	
        //$("#drpRole").val(rolId);
       // $("#hdnIdPos1").val(userId);
        $("#txtName1").val(userName);
        $("#hfIntUid").val(intUid);
    }


        $(document).ready(function () {
            $("#add-user-to-role").on("submit", function (e) {
                e.preventDefault();
                
                $.ajax({
                    url: "/UserMgmt/user_access",
                    type: "POST",
                    data: {'userName':$("#drpName").val(),'userPosition':$("#ddlPosition").val()},
                    success: function (res) {
                        $(".apploader-base").css("display", "none");
                           costumeNotification("Role has been Assigned To User Successfully");
                           setTimeout(function(){window.location.reload();}, 1000);
                           
                    
                    },
                    error: function (err) {
                  
                        costumeNotification("Sorry, Something went wrong");
                        setTimeout(function(){ window.location.reload();}, 1000);
                    }
                 });
            });
        });


        $(document).ready(function () {
            $("#list-users").on("submit", function (e) {
                e.preventDefault();
                $.ajax({
                    url: "/UserMgmt/edit_user",
                    type: "POST",
                    data: {'userId':$("#hfIntUid").val(),'drpPos1':$("#drpPos").val()},
                    success: function (res) {
              console.log(res);
                           costumeNotification("Data Successfully Updated");
                           setTimeout(function(){window.location.reload();}, 1000);
                    
                    },
                    error: function (err) {
                        console.log(err);
                        costumeNotification("Sorry, Something went wrong");
                        setTimeout(function(){ window.location.reload();}, 1000);
                    }
                 });
            });
        });
       
    </script>
        

  
        