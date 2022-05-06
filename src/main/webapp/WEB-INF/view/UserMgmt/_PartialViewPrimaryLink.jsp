<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>




	<div class="row" id="divform">
    <div class="col-lg-12">
        <div class="card">  
        <div class="card-body">
	        <div class="btn-float-datatable text-right pr-3">
	        	<button type="button" id="btnActive" class="btn btn-sm btn-success waves-effect waves-light mr-1" title="Active" onclick="UpdateStatus(0);">Active</button>
                <button type="button" id="btninactive" class="btn btn-sm btn-danger waves-effect waves-light" title="inactive" onclick="UpdateStatus(1);">Inactive</button>
	        </div>
            <div class="table-responsive">
                <table id="tbl_primary_link" class="table table-bordered">
                    <thead>
                        <tr class="text-center">
                            <th width="6%"><input type="checkbox" name="chkAll" value="chkAll" id="selectAll">&nbsp;All</th>
                             <th>Global Link</th> 
                            <th>Name</th>
                            <th>Description</th>
                            <th>URL</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${viewModel.primaryLinkList}" var="gll">
                    <c:if test="${gll!=null }">
                    <tr>
                    
                    <td>
                     <input type="checkbox" id="${gll.intPlinkId}" onchange = "SetCheckedList(event)">
                    </td>
                    <td>${gll.getGlobalLinkMaster().getChrvGlinkName()}</td> 
                    <td>${gll.chrvPlinkName}</td>
                    <td>${gll.chrvDesc}</td>
                    <td>${gll.chrvPlinkUrl}</td>
                    <c:choose>
                    <c:when test="${gll.intActiveSts==0}">
                    <td class="text-center"><span class="badge-outline badge-pill badge-success">Active</span></td>
                    </c:when>
                    <c:otherwise>
                    <td class="text-center"><span class="badge-outline badge-pill badge-secondary">Inactive</span></td>
                    </c:otherwise>
                    </c:choose>
                   <td class="text-center">
                   
                   <a id="${gll.intPlinkId}" class="btn btn-sm btn-info" href="/UserMgmt/addPrimaryLink/${gll.intPlinkId}"  ><i class="fa fa-edit"></i></a>
                   </td> 
                    
                    </tr>
                    </c:if>
                    </c:forEach>
                                       
                    </tbody>
                </table>
            </div>
        </div>
        
        <div>
        <br>
        </div>
        </div>
    </div>
</div><!-- End Row-->

<%--</div>
</div>

 <%@include file="../shared/footer.jsp"%>	
 --%>

    
<script>
    /* Variable for checklist */
    var checkedList = new Array();
    function SetCheckedList(event) {
        if (event.target.checked)
        { 
            if(checkedList.length>0)
            {
                if(checkedList.includes(event.target.id))
                {}
                else{
                     checkedList.push(event.target.id);
                }
            }
            else{
                checkedList.push(event.target.id);
            }
        }
        else {
         checkedList.splice(checkedList.indexOf(event.target.id),1);
        }
    }
   
</script>

<script type="text/javascript">

/* Update Status */
function UpdateStatus(sts)
{
    if(checkedList.length>0)
    {
        $.ajax({
            url:'/UserMgmt/UpdatePrimaryLinkStatus', 
              beforeSend: function (request) {
                    request.setRequestHeader("RequestVerificationToken", $("[name='__RequestVerificationToken']").val());
                },
            data: { 'slnoList':checkedList,'astatus':sts},
            type: 'POST',
            dataType: "json",
            success: function (data) {
            	setTimeout(function(){ window.location.reload();}, 100);
                    Notify(data);
                    updateglobalinkView();
            }
            ,
           /*  error: function (errormessage) {
                alert(errormessage.responseText);
            } */
        }); 
    }
    else
    {
        AlertNotify('Check Global link Check Box.');
    }
    
}

/* Check All */
$('#selectAll').click(function(e){
    if($(this).prop('checked'))
    {
        $('tbody tr td input:checkbox',$(e.target).closest('table')).prop('checked',this.checked);
        $('#example').find('tbody tr td input[type="checkbox"]:checked').each(function () {
            checkedList.push($(this).attr("id")); 
            //checkedList.push($(this).val());
        });
    }
    else
    {
        $('tbody tr td input:checkbox',$(e.target).closest('table')).prop('checked',false);
        checkedList=[];
        checkedList=[];
    }
});


</script> 
<script src="/plugins/table/datatable/datatables.js"></script>
<script type="text/javascript">
    var dtForest;
    init();
    function init()
    {
        if ( $.fn.DataTable.isDataTable('#tbl_primary_link') ) {
            $("#tbl_primary_link").dataTable().fnClearTable();
            $("#tbl_primary_link").dataTable().fnDestroy();
        }
        else{
            dtForest= $('#tbl_primary_link').DataTable({
                "oLanguage": {
                    "oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
                    "sInfo": "Showing page _PAGE_ of _PAGES_",
                    "sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
                    "sSearchPlaceholder": "Search...",
                   "sLengthMenu": "Results :  _MENU_",
                },
                "stripeClasses": [],
                "lengthMenu": [5, 10, 20, 50],
                "pageLength": 10 
            });
        }
    }
 </script>   
    
 


