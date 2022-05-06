<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>


<!--  BEGIN CONTENT AREA  -->
        <div id="content" class="main-content">
        
            <div class="layout-px-spacing">

                <div class="row layout-top-spacing">

                    <div class="col-md-12 layout-spacing">
                        
                        <div class="statbox widget box box-shadow">
                            <div class="widget-header">
                                <div class="row">
                                    <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                        <h4>Designation Management</h4>
                                        <a href="add_user.html" type="button" class="btn btn-sm btn-info btn-fix"><i class="fa fa-plus">&nbsp;</i>Add Designation</a>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-content widget-content-area">
                                <div class="table-responsive">
                                   
                                </div>
                            </div>
                        </div>

                    </div>
                    
                </div>

            </div>
        </div>
        <!--  END CONTENT AREA  -->
<%@ include file="../shared/footer.jsp"%>

<script>
	$(document).ready(function() {
		//Bind Designation View on page Load
		updateDesignationView()
	});
	if ("${btnstatus}" != "") {
		$('#btnsubmit').hide();
	} else {
		$('#btnUpdate').hide();
	}
	//Load Designation Table
	function updateDesignationView() {
		$.ajax({
			url : '/_partialViewDesignation',
			contentType : 'application/html; charset=utf-8',
			type : 'GET',
			dataType : "html",
		}).success(function(result) {

			$('#divform').empty();
			$('#divform').html(result);
			//Load Table
			//MergeCellsOfTable('example');
			LoadCustomDataTableCustomButtonFunctions('example', [ '' ]);

		}).error(function(xhr, status) {
			alert(status);
		})
	}
	
	//Validate Only Alphbet
	$(function() {
		$("#txtDesignation").keypress(function(e) {
			var keyCode = e.keyCode || e.which;

			$("#lblError").html("");

			//Regex for Valid Characters i.e. Alphabets.
			var regex = /^[A-Za-z ]+$/;

			//Validate TextBox value against the Regex.
			var isValid = regex.test(String.fromCharCode(keyCode));
			if (!isValid) {
				$("#lblError").html("Only Alphabets allowed.");
			}

			return isValid;
		});

		//Reset Designation
		$("#btnReset").on("click", function() {

			$('#txtDesignation').val('');
			return this.defaultSelected;

		});
	});
</script>