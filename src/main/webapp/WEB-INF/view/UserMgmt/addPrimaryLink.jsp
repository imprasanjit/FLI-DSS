<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

<div class="clearfix"></div>

<div id="content" class="main-content">
	<div class="layout-px-spacing">

		<div class="row layout-top-spacing">

			<div class="col-md-12 layout-spacing">

				<div class="statbox widget box box-shadow">
					<div class="widget-header">
						<div class="row">
							<div class="col-lg-12">
								<h4 class="form-header text-uppercase">
                        
			                        Add Primary Link
			                        <!-- @Html.ActionLink("Back","GlobalLinkView","Configuration",null,new{@class="btn btn-outline-dark btn-sm btn-round waves-effect waves-light m-1 float-right"})   -->
			                    </h4>
								<!-- <div class="card"> -->
									<div class="card-body">
            
                    <tl:form  action="/UserMgmt/addPrimaryLink" modelAttribute="primaryLink">
                    <div class="row">
                        <div class="col-md-12">
                        
	                        <div class="form-group row">
	                        	<div class="col-md-3">
	                                <label>Global Link</label>
	                                
	                                <tl:select path="editPrimaryLink.GlobalLinkMaster.intGlinkId" id="drpGloballinklist" required="required" class="form-control">
	                                <tl:option value="0">--Select--</tl:option>
	                                <tl:options items="${primaryLink.globalLinkList}" itemValue="intGlinkId" itemLabel="chrvGlinkName" />
	                                </tl:select>
	                            </div> 
	                            <div class="col-md-3">
	                            	<label>Name</label>
	                                
	                                <tl:input path="editPrimaryLink.chrvPlinkName" type="text" id="txtPLink"
											required="required" placeholder="Name" class="form-control" />
	                                    <span id="lblError" style="color: red"></span>
	                            </div> 
	                            <div class="col-md-3">
	                            	<label>URL</label>                                
	                                <tl:input path="editPrimaryLink.chrvPlinkUrl" type="text" id="txtUrl" 
											required="required" placeholder="Controller/Action" class="form-control" />
	                                    <span id="lblUrl" style="color: red"></span>
	                            </div>    
	                            <div class="col-md-3">
	                            	<label>Priority</label>                                
	                                <tl:input path="editPrimaryLink.intPriorityOdr" type="text" id="txtPri" maxlength="2"
											required="required" placeholder="Priority" class="form-control" />
	                                    <span id="lblPri" style="color: red"></span>
	                            </div>    
                            </div>
                        </div> 
                        <div class="col-md-12">                        	
                            <div class="form-group row">
                            	<div class="col-md-6">
	                            	<label>Description</label>                                
	                                <tl:textarea path="editPrimaryLink.chrvDesc" id="txtDesc" placeholder = "Description" required="required" class="form-control"/>
	                                <span id="lblDescError" style="color: red"></span>
                                </div>    
                            	<div class="col-md-6">
	                            	<label>Style</label>                                
	                                <tl:textarea path="editPrimaryLink.linkStyle" id="txtStyl" placeholder = "Link Style" required="required" class="form-control"/>                                
                                </div>    
                            </div>
                        </div>
                    </div>  
                    <hr>   
                    <div class="text-center">
                        
                        <button type="button" id="btnUpdate" class="btn btn-success waves-effect waves-light m-1" title="Update">Update</button>
                        <input type="submit" id="btnsubmit" class="btn btn-info waves-effect waves-light m-1" value="Add">
                        <a href="/UserMgmt/addPrimaryLink" class="btn btn-warning waves-effect waves-light m-1">Reset</a>
                        
                        
                    </div>
                </tl:form> 
            </div>
            </div>
           <!--  </div> -->
            </div>
            </div>
        </div>
    </div>
</div>
<div id="divform">

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
                url: '/UserMgmt/_PartialViewPrimaryLink',
                contentType: 'application/html; charset=utf-8',
                type: 'GET',
                dataType: "html",
            
                success:function (result) {
                    
                    $('#divform').empty();
                    $('#divform').html(result);
                    //Load Table
                    //LoadCustomDataTableCustomButtonFunctions('example',['']);
                   // MergeCellsOfTable(example);
                  },
                  error: function (xhr, status) {
                      alert(status);
                  }
          });
          }
    
       
        //Validate Only Alphabet
        $(function () {
        $("#txtPLink").keypress(function (e) {
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

Button To Update the data of Primary Link
<script type="text/javascript">

   $('#btnUpdate').click(function(){
       $.ajax({
       url:'/UserMgmt/updatePrimaryLink', 
        beforeSend: function (request) {
                   request.setRequestHeader("RequestVerificationToken", $("[name='__RequestVerificationToken']").val());
               },
       data: { 'Plink':$("#txtPLink").val(),'Priority':$("#txtPri").val(),'Desc':$("#txtDesc").val(),
    	   		'Url':$("#txtUrl").val(),'Style':$("#txtStyl").val(),'GlinkId':$("#drpGloballinklist").val(),'id':"${btnstatus}"},
       type: 'POST',
       dataType: "json",
       success: function (data) {
    	   setTimeout(function(){ window.location.reload();}, 100);
             Notify(data);
             updateprimaryinkView();
             $('#btnUpdate').hide();
             $('#btnsubmit').show();
             $("#txtPLink").val('');
             $("#txtPri").val('');
             $("#txtDesc").val('');
             $("#txtUrl").val('');
             $("#txtStyl").val('');
             $("#drpGloballinklist").val('');
         }
     })         
   });   
</script>
 
 
 
