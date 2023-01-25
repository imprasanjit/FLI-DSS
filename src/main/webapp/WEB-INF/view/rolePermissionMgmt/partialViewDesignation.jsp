<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="widget-content widget-content-area">
<div class="table-responsive">
	<table id="zero-config" class="table table-bordered"
		style="width: 100%">

		<thead>
			<tr class="text-center">
				<th>SlNo</th>
				<th>Designation</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${DList}" var="item" varStatus="Counter">
				<tr>
					<td class="text-center">${Counter.count}</td>
					<td class="text-left">${ item.chrvDesignationNm}</td>
					<td class="text-center"><a
						class="fa fa-edit badge badge-primary"
						href="/RolePermissionMgmt/addDesignation?id=${item.intId}"> </a></td>
					<!-- <td class="text-center">$Html.ActionLink(" ","AddDesignation","Configuration",new{id=item.int_id},new{@class="fa fa-edit badge badge-primary"})</td> -->
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</div>


