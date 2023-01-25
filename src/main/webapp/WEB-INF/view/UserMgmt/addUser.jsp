<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
                                        <h4>Add User</h4>
                                        <a href="user_creation.html" type="button" class="btn btn-sm btn-info btn-fix"><i class="fa fa-chevron-left">&nbsp;</i>Back</a>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-content widget-content-area">
                                
                                <form>
                                    <div class="row">
                                        <div class="col-md-2 form-group mb-0">
                                            <select class="form-control" id="">
                                                <option selected="selected">Role</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 form-group mb-0">
                                            <select class="form-control" id="">
                                                <option selected="selected">Designation</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 form-group mb-0">
                                            <input type="text" class="form-control" placeholder="Name">
                                        </div>
                                        <div class="col-md-2 form-group mb-0">
                                            <input type="email" class="form-control" placeholder="Email ID">
                                        </div>
                                        <div class="col-md-2 form-group mb-0">
                                            <input type="number" class="form-control" placeholder="Mobile No.">
                                        </div>
                                        <div class="col-md-2 form-group mb-0">
                                            <button type="submit" class="btn btn-success">Create</button>
                                        </div>
                                    </div>
                                </form>                           

                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <!--  END CONTENT AREA  -->


 <%@ include file="../shared/footer.jsp"%>