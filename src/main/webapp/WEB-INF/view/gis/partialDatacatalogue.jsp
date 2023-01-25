<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<!-- <div class="widget-content widget-content-area"> -->
<!-- <p class="pl-3 pr-3"><span class="badge badge-pills badge-primary mb-1" id="sFilterHeader">Data Info, </span> <span class="badge badge-pills badge-primary mb-1">Data Structure</span></p> -->
<div class="table-responsive">
	<div class="data-catalogue-select text-right pull-right pr-2">All <input type="checkbox" name="All" id="chkAll"></div>
	<table id="zero-config1" class="table no-border table-hr"
		style="width: 100%">

		<thead>
			<tr>
				<th>
					Filter Result
				</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${model}">
				<tr>
					<td>
						<div class="col-md-12">
							<div class="card component-card_1 component-max-hgt">
								<div class="card-body">
									<div class="widget-header">
										<div class="row">
											<div class="col-xl-12 col-md-12 col-sm-12 col-12">
												<%-- <h4 class="pt-1 pl-0 pr-0">${item.divisionMaster.chrvDivisionNm}&nbsp;
													${item.datasetTag.chrvTagNm}</h4> --%>
													<h4 class="pt-1 pl-0 pr-0">${item.name}</h4>
												<div class="custom-data-select">
													<!-- <button type="submit" class="btn btn-sm btn-success"
														data-toggle="modal" data-target="#selectionMapModal">
														<i class="fa fa-eye"></i>
													</button> -->
													
													<div
														class="custom-control custom-checkbox checkbox-info ml-1 mr-1">
															<div class="form-check text-right">
																<input class="form-check-input" type="checkbox"
																	id="chkProjectLayer_${item.id}"
																	value='${item.id}'
																	name='${item.name}'
																	onchange="SetCheckedList(this,event)" />
																  <label class="" for="chkProjectLayer_${item.id}"></label>
																 
													
														
														</div>

													</div>
												</div>
											</div>
										</div>
									</div>
									<div>
										 <p>${item.desc}</p>
									</div>
								</div>
							</div>
						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<script src="/assets/js/libs/jquery-3.1.1.min.js"></script>
<script src="/plugins/table/datatable/datatables.js"></script>
<script type="text/javascript">
//check All
$(document).ready(function (event) {

        $("#chkAll").click(function () {
            $(".form-check-input").attr('checked', this.checked);
        });
    });
// $("#chkAll").click(function(){
//         $("input[type=checkbox]").prop('checked', $(this).prop('checked'));
// });


	$('#zero-config1')
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
							"sLengthMenu" : "Result Per Page :  _MENU_",
						},
						"stripeClasses" : [],
						"lengthMenu" : [ 5, 10, 20, 50 ],
						"pageLength" : 20
					});
	 

</script>
