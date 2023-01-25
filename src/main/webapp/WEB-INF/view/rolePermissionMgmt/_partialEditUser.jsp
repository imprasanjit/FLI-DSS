<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>


 <div class="modal fade" id="userCreationModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Edit User</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <form>
                            <div class="row form-group">
                                <div class="col-md-6">
                                    <label>Role</label>
                                    <select class="form-control" id="">
                                        <option selected="selected">Role</option>
                                        <option>2</option>
                                        <option>3</option>
                                        <option>4</option>
                                        <option>5</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label>Designation</label>
                                    <select class="form-control" id="">
                                        <option selected="selected">Designation</option>
                                        <option>2</option>
                                        <option>3</option>
                                        <option>4</option>
                                        <option>5</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-6">
                                    <label>Name</label>
                                    <input type="text" class="form-control" placeholder="Name">
                                </div>
                                <div class="col-md-6">
                                    <label>Email ID</label>
                                    <input type="email" class="form-control" placeholder="Email ID">
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-6">
                                    <label>Mobile No.</label>
                                    <input type="number" class="form-control" placeholder="Mobile No.">
                                </div>
                            </div>
                            <hr>
                            <div class="row form-group text-center">
                                <div class="col-md-12">
                                    <button type="submit" class="btn btn-success">Update</button>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>

    
    
<%@ include file="../shared/footer.jsp"%>