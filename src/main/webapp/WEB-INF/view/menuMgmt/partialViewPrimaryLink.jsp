<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%-- <%@include file="../shared/header.jsp"%>

<%@include file="../shared/sidebar.jsp"%>
   
 
<div class="clearfix"></div>

<div class="content-wrapper">
	<div class="container-fluid">
	    --%>
	    
	<div class="row" id="divform">
    <div class="col-lg-12">
        <div class="card">  
        <div class="card-body">
            <div class="table-responsive">
                <table id="example" class="table table-bordered">
                    <thead>
                        <tr class="text-center">
                            <th width="5%"><input type="checkbox" name="chkAll" value="chkAll" id="selectAll">All</th>
                            <th>Global Link</th>
                            <th>Name</th>
                            <th>Description</th>
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
                    <td>${gll.MGlobalLink.chrvGlinkName}</td>
                    <td>${gll.chrvPlinkName}</td>
                    <td>${gll.chrvDesc}</td>
                    <c:choose>
                    <c:when test="${gll.intActiveSts==0}">
                    <td class="text-center"><span class="text-success">Active</span></td>
                    </c:when>
                    <c:otherwise>
                    <td class="text-center"><span class="text-danger">Inactive</span></td>
                    </c:otherwise>
                    </c:choose>
                   <td class="text-center">
                   
                   <a id="${gll.intPlinkId}" class="fa fa-edit badge badge-primary" href="/MenuMgmt/addPrimaryLink/${gll.intPlinkId}"  ><i class="fa fa-edit badge badge-primary"></i></a>
                   </td> 
                    
                    </tr>
                    </c:if>
                    </c:forEach>
                                       
                    </tbody>
                </table>
            </div>
        </div>
        <div class="form-footer container">
            <div class="col-md-12 mb-20 text-center"> 
                <button type="button" id="btnActive" class="btn btn-outline-success waves-effect waves-light m-1" title="Active" onclick="UpdateStatus(0);">Active</button>
                <button type="button" id="btninactive" class="btn btn-outline-danger waves-effect waves-light m-1" title="inactive" onclick="UpdateStatus(1);">Inactive</button>
                
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
            url:'/MenuMgmt/UpdatePrimaryLinkStatus', 
              beforeSend: function (request) {
                    request.setRequestHeader("RequestVerificationToken", $("[name='__RequestVerificationToken']").val());
                },
            data: { 'slnoList':checkedList,'astatus':sts},
            type: 'POST',
            dataType: "json",
            success: function (data) {
                    Notify(data);
                    updateprimaryinkView();
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
    
 


