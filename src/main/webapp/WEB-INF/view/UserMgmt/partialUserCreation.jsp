<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.sparc.flidss.service.TripleDESEncryptionService"%>

<div class="statbox widget box box-shadow">
	<div class="table-responsive">
		<table id="zero-config" class="table table-bordered"
			style="width: 100%">

			<thead>
				<tr>
					<th>Sl. No.</th>
					<c:choose>
						<c:when
							test="${roleId==5 || roleId==6 || roleId==8 || roleId==9 || roleId==12}">
							<th>Name</th>
							<th>Circle</th>
							<th>Division</th>
						</c:when>
						<c:otherwise>
							<th>Name</th>
						</c:otherwise>
					</c:choose>
					<th>Role</th>
					<th>Position</th>
					<th>User ID</th>
					<th>Password</th>
					<th>Contact No</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${userList}" var="item" varStatus="Counter">
					<tr>
						<td>${Counter.count}</td>
						<c:choose>
							<c:when
								test="${roleId==5 || roleId==6 || roleId==8 || roleId==9 || roleId==12}">
								<c:choose>
									<c:when test="${item.chrvNm==''}">
										<td>-</td>
									</c:when>
									<c:otherwise>
										<td>${item.chrvNm}</td>
									</c:otherwise>
								</c:choose>
								<%-- <td>${item.chrvNm}</td> --%>
								<c:choose>
									<c:when test="${item.circleMaster.chrvCircle=='All'}">
										<td>-</td>
									</c:when>
									<c:otherwise>
										<td>${item.circleMaster.chrvCircle}</td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${item.divisionMaster.chrvDivisionNm=='All'}">
										<td>-</td>
									</c:when>
									<c:otherwise>
										<td>${item.divisionMaster.chrvDivisionNm}</td>
									</c:otherwise>
								</c:choose>
							</c:when>

							<c:otherwise>
								<td>${item.chrvNm}</td>
							</c:otherwise>
						</c:choose>
						<td>${item.roleMaster.chrvRoleNm }</td>
						<td>${item.positionMaster.chrvPositionNm }</td>
						<td>${item.chrvUserId}</td>
						<td>${TripleDESEncryptionService.decryptPW(item.chrvUserPwd)}</td>
						<td>${item.chrvContactNo}</td>
						<td><label class="switch s-icons s-outline s-outline-info">
								<input id='stscheck' type="checkbox" checked> <span
								class="slider round"></span>
						</label></td>
						<td>
							<button type="button" class="btn btn-sm btn-success"
								onclick="BindUserDetails('${item.chrvUserId}')">
								<i class="fa fa-edit"></i>
							</button> <!-- '${item.chrvNm}','${item.chrvContactNo}, <button type="button" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button> -->
							<!-- data-toggle="modal" data-target="#userCreationModal" -->
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<!--  END CONTENT AREA  -->

<!--  Modal for edit user Details  -->
<div class="modal fade" id="userCreationModal" tabindex="-1"
	role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg"
		role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">Edit User</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
						width="24" height="24" viewBox="0 0 24 24" fill="none"
						stroke="currentColor" stroke-width="2" stroke-linecap="round"
						stroke-linejoin="round" class="feather feather-x">
						<line x1="18" y1="6" x2="6" y2="18"></line>
						<line x1="6" y1="6" x2="18" y2="18"></line></svg>
				</button>
			</div>
			<div class="modal-body" id=mbody>
				<div id="modalDiv"></div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var checkStatus = userList.intUserSts;

	function TocheckSts(checkStatus) {
		if (checkStatus === 1) {
			checked = true;
		} else {
			checked = false;
		}
	}
</script>

<!-- dataTable binding script	 -->
<script type="text/javascript">
	$('#zero-config')
			.DataTable(
					{
						"oLanguage" : {
							"oPaginate" : {
								"sPrevious" : '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>',
								"sNext" : '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>'
							},
							"sInfo" : "Showing page _PAGE_ of _PAGES_",
							"sSearch" : '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
							"sSearchPlaceholder" : "Search...",
							"sLengthMenu" : "Results :  _MENU_"
						},
						"stripeClasses" : [],
						"lengthMenu" : [ 5, 10, 20, 50 ],
						"pageLength" : 10,
						
						 //export button script start
						 dom: '<"row"<"col-md-12"<"row"<"col-md-6"B><"col-md-6"f> > ><"col-md-12"rt> <"col-md-12"<"row"<"col-md-5"i><"col-md-7"p>>> >',
						    buttons: {
						        buttons: [
						            /* { extend: 'pdf', 
						              className: 'btn btn-danger fa fa-file-pdf-o', title: 'Geo-referenced Forest Land Details', footer: true }, */
						            { extend: 'excel', 
						            	 
						                  className: 'btn btn-success fa fa-file-excel-o', title: 'FLI-DSS User List', footer: true },
						            { extend: 'print', 
						                	  
						                      className: 'btn btn-warning fa fa-print', title: 'FLI-DSS User List',footer: true  }
						        ]
						    }
						//export button script end
					});
</script>

