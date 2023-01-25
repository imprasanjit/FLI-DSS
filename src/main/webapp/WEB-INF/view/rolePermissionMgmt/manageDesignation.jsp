<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

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
                                        <h4>Designation Management</h4>
                                        <a href="add_user.html" type="button" class="btn btn-sm btn-info btn-fix"><i class="fa fa-plus">&nbsp;</i>Add Designation</a>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-content widget-content-area">
                                <div class="table-responsive">
                                    <table id="zero-config" class="table table-bordered" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th>Sl. No.</th>
                                                <th>Designation</th>
                                                <th>Status</th>
                                                <th>Action</th>                     
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>1</td>
                                                <td>System Architect</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <!-- <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button> -->
                                                </td>
                                            </tr>   
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                    
                </div>

            </div>
        </div>
        <!--  END CONTENT AREA  -->
<%@ include file="../shared/footer.jsp"%>