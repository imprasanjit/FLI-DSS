
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!--<div class="apploader-base"><div class="apploader"></div></div>-->
<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive">
					<div id="divEdit">
						<div class="table-responsive" style="height: 350px">
							<form:form>
								<table id="example1" class="table table-bordered">
									<thead>
										<tr class="text-center">
											<th><input type="checkbox" name="chkAll" value="chkAll"
												id="selectAll">All</th>
											<th>Module</th>
											<th>Sub Module</th>
											<th>Read/Write</th>
											<th>Description</th>
										</tr>
									</thead>
									<tbody>
										<%
											int rw = 1;
										Boolean rs = true;
										%>
										<%--    <c:set var ="result" value="true" int rw=1;>
                                </c:set> --%>
										<!--   $"{bool result=true; int rw=1;}" -->
										<c:forEach var="item" items="${primaryLinkList}"
											varStatus="Counter">
											<tr>
												<c:choose>
													<c:when
														test='${PermissionList.stream().filter(p->p.getPrimaryLinkMaster().getIntPlinkId()==item.getIntPlinkId()).toList().isEmpty()==false}'>
														<td><input type="Checkbox" checked="${rs}"
															id="${item.intPlinkId}"
															value="${item.getGlobalLinkMaster().getIntGlinkId()}"
															onchange="SetPermissionList(event)" /></td>
													</c:when>
													<c:otherwise>
														<td><input type="Checkbox" id="${item.intPlinkId}"
															value="${item.getGlobalLinkMaster().getIntGlinkId()}"
															onchange="SetPermissionList(event)" /></td>
													</c:otherwise>
												</c:choose>
												<td id="${item.getGlobalLinkMaster().getIntGlinkId()}">${item.getGlobalLinkMaster().getChrvGlinkName()}</td>
												<td id="${item.intPlinkId}">${item.chrvPlinkName}</td>
												<td><c:choose>
														<c:when
															test='${PermissionList.stream().filter(p->p.getPrimaryLinkMaster().getIntPlinkId()==item.getIntPlinkId()).
															toList().isEmpty()==false}'>
															<c:set var="rws"
																value="${PermissionList.stream().filter(f->f.getPrimaryLinkMaster().getIntPlinkId()==item.getIntPlinkId()).
																map(m->m.getPrivilegeMaster().getPkIntId()).findFirst().get()}"></c:set>
															<select class="form-control single-select"
																id="drpprivilagelist" name="drpprivilagelist" required>
																<c:forEach items="${privilageList}" var="privlg">
																	<option value="${privlg.pkIntId}"
																		${privlg.pkIntId ==PermissionList.stream().filter(f->f.getPrimaryLinkMaster().getIntPlinkId()==item.getIntPlinkId()).
																		map(m->m.getPrivilegeMaster().getPkIntId()).findFirst().get() ? 'selected="selected"' : ''}>${privlg.chrvPrivilage}</option>
																</c:forEach>
															</select>

														</c:when>
														<c:otherwise>
															<select class="form-control single-select"
																id="drpprivilagelist" name="drpprivilagelist" required>
																<c:forEach items="${privilageList}" var="privlg">
																	<option value="${privlg.pkIntId}"
																		${privlg.pkIntId ==rw}>${privlg.chrvPrivilage}</option>
																</c:forEach>
															</select>

														</c:otherwise>
													</c:choose></td>
												<td text="center">${item.chrvDesc}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</form:form>
						</div>
						<hr>
						<div class="form-footer text-center">
							<button type="button" id="btnActive"
								class="btn btn-success waves-effect waves-light m-1">Set</button>
							<button type="reset" id="btninactive"
								class="btn btn-danger waves-effect waves-light m-1">Reset</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	//Variable for checklist
	var primaryList = new Array();
    var globalList = new Array();
    function SetPermissionList(event) {
        if (event.target.checked)
        { 
            primaryList.push(event.target.id);
            //Global Link list
            globalList.push(event.target.value);
        }
        else {
         primaryList.splice(primaryList.indexOf(event.target.id),1);
         globalList.splice(globalList.indexOf(event.target.value),1);
        }
    }
    //Check All
    $('#selectAll').click(function(e){
    	
        if($(this).prop('checked'))
        {
            $('tbody tr td input:checkbox',$(e.target).closest('table')).prop('checked',this.checked);
            $('#example1').find('tbody tr td input[type="checkbox"]:checked').each(function () {
                globalList.push($(this).val());
                primaryList.push($(this).attr("id"));
            });
        }
        else{
            $('tbody tr td input:checkbox',$(e.target).closest('table')).prop('checked',false);
            globalList=[];
            primaryList=[];
        }
    });

	//Save Permission Details to Database	
	$("#btnActive").click(
			function(event) {
				
				var TableData = new Array();
				$('#example1 tbody>tr').each(
						function(row, tr) {
							var checked = $(this)
									.find('input[type="checkbox"]').prop(
											'checked');
							console.log(checked);
							if (checked == true) {
								TableData[row] = {
									"module" : $(tr).find('td:eq(1)')
											.attr('id'),
									"submodule" : $(tr).find('td:eq(2)').attr(
											'id'),
									"rw" : $(tr).find('td:eq(3)')
											.find('select').val()
								}
							}
						});
				console.log(TableData);

				if ($('#drpRolelist').val() != 0
						&& $('#drpposilist').val() != 0) {
					TableData = TableData.filter(function(x) {
						return x !== null
					});

					//console.log("TableData: " + JSON.stringify(TableData));
					var tblData = (JSON.stringify(TableData));
					//console.log(tblData);
					//console.log(tblData);
					//console.log(TableData);
					$(".apploader-base").css("display", "block");
					$.ajax({
						
						url : '/UserMgmt/_SavePermissionInfo',
						//'@Url.Action("SavePermissionInfo", "Configuration")',
						data : {
							'roleId' : $('#drpRolelist').val(),
							'pid' : $('#drpposilist').val(),
							'permissionData' : tblData
						},
						type : "POST",
						success : function(result) {
							$(".apploader-base").css("display", "none");
							costumeNotification("Data Updated Successfully");
							setTimeout(function(){window.location.reload();}, 1000);
							// $('#btninactive').trigger('click');
							// Notify(result);
						},
						error: function (err) {
                  
				  costumeNotification("Sorry, Something went wrong");
				  setTimeout(function(){ window.location.reload();}, 1000);
			  }
					});

				} else {
					AlertNotify('Select designation and role.');
				}
			});
	//Reset on Button click
	$('#btninactive').click(function() {
		$('input[type="checkbox"]:checked').prop('checked', false);
		$('#example1 > tbody  > tr').each(function() {
			$(this).find('select').val("1");
		});
	});
</script>