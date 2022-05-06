<%-- <%@page import="com.sparc.progressmonitoring.utility.CustomUtility"%> --%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<c:choose>
<c:when  test="${ PermissionList!=null}">
  <div class="row" id="divform">
          <div class="col-lg-12">
            <div class="card">   
              <div class="card-body">
                <div class="table-responsive">
                  <div id="div_excel"></div>
                <table id="example" class="table table-bordered">
                  <thead>
                    <tr class="text-center">
                        <th>Sl No</th>
		                <th>Menu</th>
		                <th>SubMenu</th>
		                <th>Read/Write</th>
		               <!--  <th>Action</th> -->
                    </tr>
                  </thead>
                  <tbody>
                     <c:forEach var ="item"  items = "${ PermissionList}" varStatus="Counter">
		              <tr>
		                <td>${Counter.count}</td>
		                <td>${item.MGlobalLink.chrvGlinkName}</td>
		                <td>${item.MPrimaryLink.chrvPlinkName}</td>
		                <td>${item.MPrivilege.chrvPrivilage}</td>
		                <!-- <td class="text-center">
		                   <button class="btn badge badge-success" data-toggle="modal" data-target="#modal-lg" id="btnView" onclick="BindEditDetails('@item.int_permission_id');">
		                            <i class="fa fa-edit"></i>
		                    </button>
		                     <button class="btn badge badge-danger" id="btnDelete">
		                            <i class="fa fa-trash"></i>
		                    </button>                       
		                </td>    -->
		              </tr>
		              </c:forEach>
                  </tbody>
              </table>
              </div>
              </div>
            </div>
          </div>
  </div><!-- End Row-->
  </c:when>
  <c:otherwise>
  	 <h5>No record available.</h5>
  </c:otherwise>
</c:choose>


 <script type="text/javascript">
           
</script>
