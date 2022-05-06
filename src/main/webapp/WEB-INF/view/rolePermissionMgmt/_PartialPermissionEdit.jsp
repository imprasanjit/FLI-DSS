<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<div class="row">
    <div class="col-lg-12">
        <div class="card">   
            <div class="card-body">
            <div class="table-responsive">
                    <div  id="divEdit" >
                        <div class="table-responsive" style="height:450px" >
                            <table id="example1" class="table table-bordered">
                                <thead>
                                    <tr class="text-center">
                                        <th><input type="checkbox" name="chkAll" value="chkAll" id="selectAll">All</th>
                                        <th>Module</th>
                                        <th>Sub Module</th>
                                        <th>Read/Write</th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%int rw=1; %>
                             <%--    <c:set var ="result" value="true" int rw=1;>
                                </c:set> --%>
                               <!--   $"{bool result=true; int rw=1;}" -->
                                	<c:forEach var ="item"  items = "${primaryLinkList}" varStatus="Counter">
                                	    <c:set var ="result" value="${PermissionList.stream().anyMatch(a->a.MPrimaryLink.intPlinkId==item.intPlinkId)}">
                                </c:set>
                           
	                                	<tr>
	                              
	                                	<c:choose>
	                                		 <c:when test='${result!=null}'>
	                                			 <td> <form:checkboxes path="result", id="${item.intPlinkId}", value="${item.MGlobalLink.intGlinkId}"/>  </td>
	                                		 	<!-- <td>@Html.CheckBoxFor(s =>(result), new { id = item.int_plink_id,value=item.fk_int_glink_id, onchange = "SetPermissionList(event)" })</td> -->
	                                         </c:when>
	                                         <c:otherwise>
	                                         <td>2</td>
	                                         	<!--  <td>@Html.CheckBoxFor(s =>(item.IsChecked), new { id = item.int_plink_id,value=item.fk_int_glink_id, onchange = "SetPermissionList(event)" })</td> -->
	                                         </c:otherwise> 
	                                        </c:choose>
	                                        <%-- <td id=@item.fk_int_glink_id>${@item.int_glink_id.chrv_glink_name}</td>
	                                        <td id=@item.int_plink_id>${@item.chrv_plink_name}</td>
	                                        <td>
	                                       	<c:when test='${PermissionList.stream().anyMatch(a->a.getMPrimaryLink().getIntPlinkId()==item.int_plink_id}'>
	                                        	 rw=PermissionList.Where(a=>a.fk_int_plink_id==item.int_plink_id).SingleOrDefault().fk_int_rw_id;
	                                            @Html.DropDownListFor(s => rw, new SelectList(Model.privilageList, "pk_int_id", "chrv_privilage"), new { @class = "form-control single-select",id="ddlrwlist",@required = true})
	                                        </c:when>
	                                        <c:otherwise>
	                                        	 @Html.DropDownListFor(s => rw, new SelectList(Model.privilageList, "pk_int_id", "chrv_privilage"), new { @class = "form-control single-select",id="ddlrwlist",@required = true})
	                                        </c:otherwise>
	                                       <!--  (Model.PermissionList.Any(a=>a.fk_int_plink_id==item.int_plink_id))
	                                        {
	                                            rw=Model.PermissionList.Where(a=>a.fk_int_plink_id==item.int_plink_id).SingleOrDefault().fk_int_rw_id;
	                                            @Html.DropDownListFor(s => rw, new SelectList(Model.privilageList, "pk_int_id", "chrv_privilage"), new { @class = "form-control single-select",id="ddlrwlist",@required = true})
	                                        }
	                                        else
	                                        {
	                                            @Html.DropDownListFor(s => rw, new SelectList(Model.privilageList, "pk_int_id", "chrv_privilage"), new { @class = "form-control single-select",id="ddlrwlist",@required = true})
	                                        } -->
	                                        </td>--%>
	                                        <td>${item.chrvDesc}</td>
	                                    </tr>
                                	</c:forEach>
                                </tbody>
                            </table>
                        </div>   
                            <hr>
                            <div class="form-footer text-center">                      
                            <button type="button" id="btnActive" class="btn btn-success waves-effect waves-light m-1">Set</button>
                            <button type="reset" id="btninactive" class="btn btn-danger waves-effect waves-light m-1">Reset</button>
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
            $('#example').find('tbody tr td input[type="checkbox"]:checked').each(function () {
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
    //Update Status
    /* function UpdateStatus(sts)
    {
        if($('#drpdesiglist').val()!=0 && $('#drpposilist').val()!=0)
        {
            $.ajax({
            url:'@Url.Action("AddPermissionStatus","Configuration")', 
            beforeSend: function (request) {
                        request.setRequestHeader("RequestVerificationToken", $("[name='__RequestVerificationToken']").val());
                    },
            data: {'designationid':$('#drpdesiglist').val(),'roleid':$('#drpposilist').val(),'globallist':globalList,'primarylist':primaryList,'rwid':$('#ddlrwlist').val(),'status':sts},
            type: 'POST',
            dataType: "json"
            })
            .success(function (result) {
                $('#btninactive').trigger('click');
                Notify(result);
            })
            .error(function (xhr, status) {
                
            }) 
        }
        else{
            AlertNotify('Select designation and role.');
        }
        
    } */
    //Save Permission Details to Database
        $("#btnActive").click(function (event) {
        var TableData = new Array();
        $('#example tbody>tr').each(function (row, tr) 
        {
            var checked = $(this).find('input[type="checkbox"]').prop('checked');
            if(checked==true)
            {
                  TableData[row] = 
                {
                 "module": $(tr).find('td:eq(1)').attr('id')
                , "submodule":$(tr).find('td:eq(2)').attr('id')
                , "rw": $(tr).find('td:eq(3)').find('select').val()
                }
            }
        });

 if($('#drpdesiglist').val()!=0 && $('#drpposilist').val()!=0)
    {
       TableData = TableData.filter(function(x) { return x !== null }); 

        //console.log("TableData: " + JSON.stringify(TableData));
        var tblData = (JSON.stringify(TableData));
        //console.log(tblData);
        //console.log(TableData);
            $.ajax({
            url: '@Url.Action("SavePermissionInfo", "Configuration")',
                            data: {'designationid':$('#drpdesiglist').val(),'roleid':$('#drpposilist').val(), 'permissionData': tblData },
            async: false,
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json"
            })
            .success(function (result) {
                    $('#btninactive').trigger('click');
                    Notify(result);
                })
                .error(function (xhr, status) {
                    
                }) 
    }
    else
    {
        AlertNotify('Select designation and role.');
    }
 });
</script>