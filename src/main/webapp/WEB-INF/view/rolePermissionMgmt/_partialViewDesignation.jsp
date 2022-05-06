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
                            
                            <div class="widget-content widget-content-area">
                                <div class="table-responsive">
                                    <table id="example" class="table table-bordered" style="width:100%">
                                        <thead>
                                            <tr>
                                                <th>Sl. No.</th>
                                                <th>Designation</th>
                                                <th>Status</th>
                                                <th>Action</th>                     
                                            </tr>
                                        </thead>
                                        <tbody>
                                           <c:forEach items="${DList}" var="item" varStatus="Counter">
                                           <tr>
												<td class="text-center">${Counter.count}</td>
												<td class="text-left">${item.chrvDesignationNm}</td>
												<td class="text-left">
                                                    <label class="switch s-icons s-outline s-outline-info">
                                                        <input type="checkbox" checked>
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
												<td class="text-center"><a
										class="btn btn-sm btn-success" data-toggle="modal"
										href="/addDesignation?id=${item.intId}"></a></td>
                                                <!-- <td class="text-left">
                                                    <button type="button" class="btn btn-sm btn-success" data-toggle="modal" data-target="#userCreationModal"><i class="fa fa-edit"></i></button> -->
                                                    <!-- <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button> -->
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
        <!--  END CONTENT AREA  -->
<%@ include file="../shared/footer.jsp"%>