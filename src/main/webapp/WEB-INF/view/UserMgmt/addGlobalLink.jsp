
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
												Add Global Link												
											</h4>
								<!-- <div class="card"> -->
									<div class="card-body">
										<tl:form action="/UserMgmt/addGlobalLink"
											modelAttribute="globalLink">

											
											<div class="row">
												<div class="col-md-12">
													<div class="form-group row">
														<div class="col-md-4">
															<label>Name</label>
															
																<tl:input path="editGlobalLink.chrvGlinkName" type="text"
																	id="txtGLink" required="required" placeholder="Name"
																	class="form-control" />
																<span id="lblError" style="color: red"></span>
														</div>
													
														<div class="col-md-4">
														<label>Priority</label>
														
															<tl:input path="editGlobalLink.intPriorityOdr"
																type="text" id="txtPri" maxlength="2"
																required="required" placeholder="Priority"
																class="form-control" />
															<span id="lblPri" style="color: red"></span>
														</div>
													
														<div class="col-md-4">
														<label>URL</label>														
															<tl:input path="editGlobalLink.chrvGlinkUrl" id="txtUrl"
																placeholder="Controller/Action" required="required"
																class="form-control" />
															<span id="lblDescError" style="color: red"></span>
														</div>
													</div>
												</div>
												<div class="col-md-12">
													<div class="form-group row">
													<div class="col-md-6">
														<label>Description</label>
														
															<tl:textarea path="editGlobalLink.chrvDesc" id="txtDesc"
																placeholder="Description" required="required"
																class="form-control" cssStyle="height:60px;"/>
															<span id="lblDescError" style="color: red"></span>
														</div>
														
														<div class="col-md-6">
														<label>Style</label>
														
															<tl:textarea path="editGlobalLink.linkStyle" id="txtStyl"
																placeholder="Link Style" required="required"
																class="form-control" cssStyle="height:60px;"/>
															<span id="lblStylcError" style="color: red"></span>
														</div>
													</div>
												</div>
											</div>
											<hr>
											<div class="text-center">

												<button type="button" id="btnUpdate"
													class="btn btn-success waves-effect waves-light m-1"
													title="Update">Update</button>
												<input type="submit" id="btnsubmit"
													class="btn btn-info waves-effect waves-light m-1"
													value="Add">
													 <a href="/UserMgmt/addGlobalLink"
													class="btn btn-warning waves-effect waves-light m-1">Reset</a>
											</div>
										</tl:form>
									</div>
								<!-- </div> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="divform"></div>


	</div>
</div>

<%@ include file="../shared/footer.jsp"%>


<c:if test="${status !=null}">
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
        updateglobalinkView() 
    });
   
    //Load Global Link Table
    function updateglobalinkView()
    {
    	
        $.ajax({
                url: '/UserMgmt/_PartialViewGlobalLink',
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

<!-- Button  To Update the data of Global Link -->
 <script type="text/javascript">

   $('#btnUpdate').click(function(){
     $.ajax({
     url:'/UserMgmt/updateGlobalLink', 
      beforeSend: function (request) {
                 request.setRequestHeader("RequestVerificationToken", $("[name='__RequestVerificationToken']").val());
             },
     data: { 'Glink':$("#txtGLink").val(),'Priority':$("#txtPri").val(),'Desc':$("#txtDesc").val(),
    	 	'Url':$("#txtUrl").val(),'Style':$("#txtStyl").val(),'id':"${btnstatus}"},
     type: 'POST',
     dataType: "json",
     success: function (data) {
    	 
    	 setTimeout(function(){ window.location.reload();}, 100);
           Notify(data);          
           updateglobalinkView();
           
           $('#btnUpdate').hide();
           $('#btnsubmit').show();
           $("#txtGLink").val('');
           $("#txtPri").val('');
           $("#txtDesc").val('')
           
       }
   })         
 }); 
</script> 
