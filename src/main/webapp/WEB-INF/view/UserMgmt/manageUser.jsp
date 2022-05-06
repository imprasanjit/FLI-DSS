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
                                        <h4>User Creation</h4>
                                        <a href="add_user.html" type="button" class="btn btn-sm btn-info btn-fix"><i class="fa fa-plus">&nbsp;</i>Add User</a>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-content widget-content-area">
                                <div class="table-responsive">
                                    <table id="zero-config" class="table table-bordered" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th>Sl. No.</th>
                                                <th>Role</th>
                                                <th>Designation</th>
                                                <th>Name</th>
                                                <th>Mobile</th>
                                                <th>Email ID</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>1</td>
                                                <td>System Architect</td>
                                                <td>System Architect</td>
                                                <td>Tarini Prasad</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>2</td>
                                                <td>Accountant</td>
                                                <td>Accountant</td>
                                                <td>Ashton Cox</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>3</td>
                                                <td>Junior Technical</td>
                                                <td>Junior Technical</td>
                                                <td>Sanny Limb</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox">
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>4</td>
                                                <td>Senior Javascript Developer</td>
                                                <td>Senior Javascript Developer</td>
                                                <td>Cedric Kelly</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>5</td>
                                                <td>Accountant</td>
                                                <td>Accountant</td>
                                                <td>Airi Satou</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox">
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>6</td>
                                                <td>Integration Specialist</td>
                                                <td>Integration Specialist</td>
                                                <td>Brielle Williamson</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox">
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>7</td>
                                                <td>Sales Assistant</td>
                                                <td>Sales Assistant</td>
                                                <td>Herrod Chandler</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>8</td>
                                                <td>Integration Specialist</td>
                                                <td>Integration Specialist</td>
                                                <td>Rhona Davidson</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>9</td>
                                                <td>Javascript Developer</td>
                                                <td>Javascript Developer</td>
                                                <td>Colleen Hurst</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>10</td>
                                                <td>Software Engineer</td>
                                                <td>Software Engineer</td>
                                                <td>Sonya Frost</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox">
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>11</td>
                                                <td>Office Manager</td>
                                                <td>Office Manager</td>
                                                <td>Jena Gaines</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox">
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>12</td>
                                                <td>Support Lead</td>
                                                <td>Support Lead</td>
                                                <td>Quinn Flynn</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>13</td>
                                                <td>Regional Director</td>
                                                <td>Regional Director</td>
                                                <td>Charde Marshall</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>14</td>
                                                <td>Senior Marketing Designer</td>
                                                <td>Senior Marketing Designer</td>
                                                <td>Haley Kennedy</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox">
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>15</td>
                                                <td>Regional Director</td>
                                                <td>Regional Director</td>
                                                <td>Tatyana Fitzpatrick</td>
                                                <td>9583109860</td>
                                                <td>tarini@gmail.com</td>
                                                <td>
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button>
                                                    <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
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