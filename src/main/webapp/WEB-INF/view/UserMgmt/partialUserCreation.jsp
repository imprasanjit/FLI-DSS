<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="widget-content widget-content-area">
	<div class="table-responsive">
		<table id="zero-config" class="table table-bordered"
			style="width: 100%">

			<thead>
				<tr>
					<th>Sl. No.</th>			
					<c:choose>
						<c:when test="${roleId==5 || roleId==6 || roleId==8 || roleId==9 || roleId==12}">
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
						<c:when test="${roleId==5 || roleId==6 || roleId==8 || roleId==9 || roleId==12}">
							<c:choose>
								<c:when test="${item.chrvNm==''}"><td>-</td></c:when>	
								<c:otherwise><td>${item.chrvNm}</td></c:otherwise>
							</c:choose>			
							<%-- <td>${item.chrvNm}</td> --%>
							<c:choose>
								<c:when test="${item.circleMaster.chrvCircle=='All'}"><td>-</td></c:when>	
								<c:otherwise><td>${item.circleMaster.chrvCircle}</td></c:otherwise>
							</c:choose>	
							<c:choose>
								<c:when test="${item.divisionMaster.chrvDivisionNm=='All'}"><td>-</td></c:when>	
								<c:otherwise><td>${item.divisionMaster.chrvDivisionNm}</td></c:otherwise>
							</c:choose>								
						</c:when>
					
						<c:otherwise>
							<td>${item.chrvNm}</td>
						</c:otherwise>
					</c:choose>
						<td>${item.roleMaster.chrvRoleNm }</td>
						<td>${item.positionMaster.chrvPositionNm }</td>
						<td>${item.chrvUserId}</td>						
						<td>${item.chrvContactNo}</td>
						<td><label class="switch s-icons s-outline s-outline-info">
								<input id='stscheck'type="checkbox" checked> <span
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
 <div class="modal fade" id="userCreationModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Edit User</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
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

		function TocheckSts(checkStatus){
if(checkStatus === 1){
checked = true;
}else{
	checked = false;
}
}
		</script>
		
        