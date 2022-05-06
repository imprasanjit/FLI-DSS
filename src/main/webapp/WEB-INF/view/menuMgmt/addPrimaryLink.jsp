<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@include file="../shared/header.jsp"%>

<%@include file="../shared/sidebar.jsp"%>


<!--  BEGIN CONTENT AREA  -->
  <div id="content" class="main-content">
  <div class="layout-px-spacing">
     <div class="row layout-top-spacing">
     
     <div class="col-md-12 layout-spacing">
                        
                        <div class="statbox widget box box-shadow">
                            <div class="widget-header">
                                <div class="row">
                                    <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                        <h4>Configuration</h4>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-content widget-content-area">
     

<!-- <div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body"> -->
            <tl:form method="post" action="/MenuMgmt/addPrimaryLink" modelAttribute="primaryLink">
                 
                    <h6 class="form-header text-uppercase">
                        <i class="fa fa-folder-open-o"></i>
                        Add Primary Link
                        <!-- @Html.ActionLink("Back","GlobalLinkView","Configuration",null,new{@class="btn btn-outline-dark btn-sm btn-round waves-effect waves-light m-1 float-right"})   -->
                    </h6>
                    <div class="row">
                        <div class="col-sm-6">
                        
                        <div class="form-group row">
                                <label class="col-sm-4 col-form-label">Global Link</label>
                                <div class="col-sm-8">
                                <tl:select path="editPrimaryLink.MGlobalLink.intGlinkId" id="drpGloballinklist" required="required" class="form-control form-control-sm single-select">
                                <tl:option value="0">--Select--</tl:option>
                                <tl:options items="${primaryLink.globalLinkList}" itemValue="intGlinkId" itemLabel="chrvGlinkName" />
                                </tl:select>
                                </div> 
                            </div> 
                            
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label">URL</label>
                                <div class="col-sm-8">
                                <tl:input path="editPrimaryLink.chrvPlinkUrl" type="text" id="txtUrl" 
										required="required" placeholder="Controller/Action" class="form-control form-control-sm" />
                                    <span id="lblUrl" style="color: red"></span>
                                </div>    
                            </div>
                            
                            <div class="form-group row">
                            <label class="col-sm-4 col-form-label">Priority</label>
                                <div class="col-sm-8">
                                <tl:input path="editPrimaryLink.intPriorityOdr" type="text" id="txtPri" maxlength="2"
										required="required" placeholder="Priority" class="form-control form-control-sm" />
                                    <span id="lblPri" style="color: red"></span>
                                </div>    
                            </div>
                        </div> 
                        <div class="col-sm-6">
                        
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label">Name</label>
                                <div class="col-sm-8">
                                <tl:input path="editPrimaryLink.chrvPlinkName" type="text" id="txtPLink"
										required="required" placeholder="Name" class="form-control form-control-sm" />
                                    <span id="lblError" style="color: red"></span>
                                </div> 
                            </div> 
                            
                            <div class="form-group row">
                            <label class="col-sm-4 col-form-label">Description</label>
                                <div class="col-sm-8">
                                <tl:textarea path="editPrimaryLink.chrvDesc" id="txtDesc" placeholder = "Description" required="required" class="form-control" cssStyle="height:88px;"/>
                                <span id="lblDescError" style="color: red"></span>
                                </div>    
                            </div>
                        </div>
                    </div>  
                    <hr>   
                    <div class="form-footer text-center">
                        
                        <button type="button" id="btnUpdate" class="btn btn-success waves-effect waves-light m-1" title="Update">Update</button>
                        <input type="submit" id="btnsubmit" class="btn btn-success waves-effect waves-light m-1" value="Add">
                        <a href="/MenuMgmt/addPrimaryLink" class="btn btn-warning waves-effect waves-light m-1">Reset</a>
                        
                        
                    </div>
                </tl:form> 
 <!--            </div>
        </div>
    </div>
</div> -->
<div id="divform">

</div>              
	
	
	</div>
</div>   
 </div>
 </div>
 </div>
 </div>


<%@include file="../shared/footer.jsp"%>


<c:if test = "${status !=null}">
		<script>
			Notify("${status}");
		</script>
	</c:if>


<script type="text/javascript">
if(${btnstatus!=''})
{
    $('#btnsubmit').hide();
}
else
{
     $('#btnUpdate').hide();
}
</script>

<script>
      $(document).ready(function () {
        //Bind Global Link View on page Load
        updateprimaryinkView() 
    });
   
    //Load Global Link Table
    function updateprimaryinkView()
    {
        $.ajax({
                url: '/MenuMgmt/_PartialViewPrimaryLink',
                contentType: 'application/html; charset=utf-8',
                type: 'GET',
                dataType: "html",
            })
            .success(function (result) {
            
              $('#divform').empty();
              $('#divform').html(result);
              //Load Table
              LoadCustomDataTableCustomButtonFunctions('example',['']);
              MergeCellsOfTable(example);
            })
            .error(function (xhr, status) {
                alert(status);
            }) 
    }
    
       
        //Validate Only Alphabet
        $(function () {
        $("#txtGLink").keypress(function (e) {
            var keyCode = e.keyCode || e.which;
 
            $("#lblError").html("");
 
            //Regex for Valid Characters i.e. Alphabets
            var regex = /^[A-Za-z ]+$/;
 
            //Validate TextBox value against the Regex.
            var isValid = regex.test(String.fromCharCode(keyCode));
            if (!isValid) {
                $("#lblError").html("Only Alphabets allowed.");
            }
 
            return isValid;
        });
    });
    //Validate Only Alphanumeric
       $(function () {
        $("#txtDesc").keypress(function (e) {
            var keyCode = e.keyCode || e.which;
 
            $("#lblDescError").html("");
 
            //Regex for Valid Characters i.e. Alphabets and Numbers.
            var regex = /^[A-Za-z0-9,. ]+$/;
 
            //Validate TextBox value against the Regex.
            var isValid = regex.test(String.fromCharCode(keyCode));
            if (!isValid) {
                $("#lblDescError").html("Only Alphabets and Numbers allowed.");
            }
 
            return isValid;
        });
    });
     //Validate Only Number
       $(function () {
        $("#txtPri").keypress(function (e) {
            var keyCode = e.keyCode || e.which;
 
            $("#lblPri").html("");
 
            //Regex for Valid Characters i.e. Alphabets and Numbers.
            var regex = /^[0-9]+$/;
 
            //Validate TextBox value against the Regex.
            var isValid = regex.test(String.fromCharCode(keyCode));
            if (!isValid) {
                $("#lblPri").html("Only Numbers allowed.");
            }
 
            return isValid;
        });
    });
 </script>

<!-- Button To Update the data of Primary Link -->
<script type="text/javascript">

   $('#btnUpdate').click(function(){
       $.ajax({
       url:'/MenuMgmt/updatePrimaryLink', 
        beforeSend: function (request) {
                   request.setRequestHeader("RequestVerificationToken", $("[name='__RequestVerificationToken']").val());
               },
       data: { 'Plink':$("#txtPLink").val(),'Priority':$("#txtPri").val(),'Desc':$("#txtDesc").val(),'Url':$("#txtUrl").val(),'GlinkId':$("#drpGloballinklist").val(),'id':"${btnstatus}"},
       type: 'POST',
       dataType: "json",
       success: function (data) {
             Notify(data);
             updateprimaryinkView();
             $('#btnUpdate').hide();
             $('#btnsubmit').show();
             $("#txtPLink").val('');
             $("#txtPri").val('');
             $("#txtDesc").val('');
             $("#txtUrl").val('');
             $("#drpGloballinklist").val('');
         }
     })         
   });   
</script>
 
 
 
