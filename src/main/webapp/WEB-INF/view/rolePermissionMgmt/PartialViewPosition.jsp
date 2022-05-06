<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

		<div class="row" id="divform">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<div class="table-responsive" style="height: 450px">
							<table id="example" class="table table-bordered">
								<thead>
									<tr class="text-center">
										<th>SlNo</th>
										<th>Designation</th>
										<th>Position</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${PList}" var="item" varStatus="Counter">
										<tr>
											<td>${Counter.count}</td>
											<td>${item.MDesination.chrvDesignationNm}</td>
											<td>${item.chrvPosNm}</td>
											<td class="text-center"><!-- <a 
													class="fa fa-edit badge badge-primary" title=""></a> -->
													<a class="fa fa-edit badge badge-primary" href="/RolePermissionMgmt/AddPosition?id=${item.intId}"> </a>
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
	