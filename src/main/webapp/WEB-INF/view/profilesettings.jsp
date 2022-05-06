<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ include file="shared/header.jsp"%>
<%@ include file="shared/sidebar.jsp"%>



    <!--  BEGIN CONTENT AREA  -->
    <div id="content" class="main-content">
        <div class="layout-px-spacing">

            <div class="row layout-top-spacing">

                <div class="col-md-6 offset-md-3 layout-spacing">
                    <div class="statbox widget box box-shadow">
                        <div class="widget-header">
                            <div class="row">
                                <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                    <h4>Profile Settings</h4>
                                </div>
                            </div>
                        </div>
                        <div class="widget-content widget-content-area">
                            
                            <form id="upload-form" class="general-info">
                                <div class="row">
                                    <div class="col-lg-12 mx-auto">
                                        <div class="row">
                                            <div class="col-xl-4 col-lg-4 col-md-4 offset-md-4">
                                                <div class="upload pr-md-4">
                                                    <input type="file" name = "image" id="input-file-max-fs" class="dropify" data-default-file="" data-max-file-size="2M" />
                                                    <p class="mt-2"><i class="flaticon-cloud-upload mr-1"></i> Upload Picture</p>
                                                </div>
                                            </div>
                                            <div class="col-xl-12 col-lg-12 col-md-12 mt-md-0 mt-4">
                                                <div class="form">
                                                    <div class="row">
                                                        <div class="col-sm-12 form-group">
                                                        	<label>Name</label>
                                                            <input type="text" name="username" value='${userName}' class="form-control" id="nameDiv" placeholder="Name" >
                                                            <span id="lblError" style="color: red"></span>
                                                        </div>
                                                        <!-- <div class="col-md-4 form-group">
                                                            <div class="flatpickr-dtpikr-base">
                                                                <div class="flatpickr-dtpikr">
                                                                    <input id="basicFlatpickr" value="" class="form-control flatpickr flatpickr-input active" type="text" placeholder="Select Date ...">
                                                                </div>
                                                            </div>
                                                        </div> -->
                                                        <div class="col-sm-12 form-group">
                                                        	<label>Mobile No.</label>
                                                            <input type="number" name="mobilenumber" value='${userMobile}'class="form-control" id="mobileDiv" placeholder="Mobile no.">
                                                            
                                                        </div>
                                                   
                                                        <div class="col-sm-12 form-group">
                                                        	<label>Mail ID</label>
                                                            <input type="text" name="email" value='${userEmail}' class="form-control" id="" placeholder="MailID" readonly>
                                                        </div>
                                                        <!-- <div class="col-md-4 form-group">
                                                            <select class="form-control" id="">
                                                                <option selected="selected">Designation</option>
                                                                <option>2</option>
                                                                <option>3</option>
                                                                <option>4</option>
                                                                <option>5</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-4 form-group">
                                                            <select class="form-control" id="">
                                                                <option selected="selected">Department</option>
                                                                <option>2</option>
                                                                <option>3</option>
                                                                <option>4</option>
                                                                <option>5</option>
                                                            </select>
                                                        </div> -->
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-12 form-group">
                                                        <label>Address</label>
                                                            <textarea class="form-control" value = '' name="address" placeholder="Address" rows="" id="txtAddress">${userAddress}</textarea>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12 text-center">
                                                            <button type="submit" class="btn btn-success" id="btnupdateProfile">Update</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>                        

                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
    <!--  END CONTENT AREA  -->


    <!-- BEGIN GLOBAL MANDATORY SCRIPTS -->
    <script src="bootstrap/js/popper.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script src="plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="assets/js/app.js"></script>
    <script src="assets/js/custom/notification.js"></script>
     <script>
        $(document).ready(function () {
            document.getElementById('input-file-max-fs').setAttribute("data-default-file","/assets/profile_img/"+'${pImage}');
            $("#upload-form").on("submit", function (e) {
                e.preventDefault();
                $.ajax({
                    url: "/profilesettings",
                    type: "POST",
                    data: new FormData(this),
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false,
                    cache: false,
                    success: function (res) {
                        
                        console.log(res);
                        costumeNotification("Profile Updated Successfully");
                        setTimeout(function(){window.location.reload();}, 1000);
                        
                    },
                    error: function (err) {
                        console.error(err);
                        costumeNotification("Sorry, Something went wrong");
                        setTimeout(function(){ window.location.reload();}, 1000);
                    }
                });
            });
        });
       
       
    </script>
    <script src="assets/js/custom.js"></script>
    <!-- END GLOBAL MANDATORY SCRIPTS -->

    <!-- BEGIN PAGE LEVEL PLUGINS/CUSTOM SCRIPTS -->
    <script src="plugins/apex/apexcharts.min.js"></script>
    <script src="assets/js/dashboard/dash_1.js"></script>
    <script src="assets/js/elements/tooltip.js"></script>
    <script src="assets/js/scrollspyNav.js"></script>
    <script src="plugins/flatpickr/flatpickr.js"></script>
    <script src="plugins/noUiSlider/nouislider.min.js"></script>
    <script src="plugins/flatpickr/custom-flatpickr.js"></script>
    <script src="plugins/noUiSlider/custom-nouiSlider.js"></script>
    <script src="plugins/bootstrap-range-Slider/bootstrap-rangeSlider.js"></script>
    <script src="plugins/dropify/dropify.min.js"></script>
    <script src="plugins/blockui/jquery.blockUI.min.js"></script>
    <script src="assets/js/users/account-settings.js"></script>
    <script src="plugins/bootstrap-select/bootstrap-select.min.js"></script>
    <script src="plugins/select2/select2.min.js"></script>
    <script src="plugins/select2/custom-select2.js"></script>
    <script src="plugins/notification/snackbar/snackbar.min.js"></script>
    <script src="assets/js/components/notification/custom-snackbar.js"></script>
    <script src="plugins/table/datatable/datatables.js"></script>
    <script src="plugins/table/datatable/button-ext/dataTables.buttons.min.js"></script>
    <script src="plugins/table/datatable/button-ext/jszip.min.js"></script>    
    <script src="plugins/table/datatable/button-ext/buttons.html5.min.js"></script>
    <script src="plugins/table/datatable/button-ext/buttons.print.min.js"></script>
    <script src="plugins/table/datatable/copy_csv_xls_pdf.swf"></script>
    <script src="plugins/table/datatable/pdfmake/pdfmake.min.js"></script>
    <script src="plugins/table/datatable/pdfmake/vfs_fonts.js"></script>
    <script>
        $('#zero-config').DataTable({
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
        $('#html5-extension').DataTable( {
            dom: '<"row"<"col-md-12"<"row"<"col-md-6"B><"col-md-6"f> > ><"col-md-12"rt> <"col-md-12"<"row"<"col-md-5"i><"col-md-7"p>>> >',
            buttons: {
                buttons: [
                    { extend: 'pdf', className: 'btn btn-danger fa fa-file-pdf-o' },
                    { extend: 'excel', className: 'btn btn-success fa fa-file-excel-o' },
                    { extend: 'print', className: 'btn btn-warning fa fa-print' }
                ]
            },
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
        } );
        $(".placeholder").select2({
            placeholder: "Make a Selection",
            allowClear: true
        });
        $(".tagging").select2({
            tags: true
        });
        // Get the Toast button
        var toastButton = document.getElementById("toast-btn");
        // Get the Toast element
        var toastElement = document.getElementsByClassName("toast")[0];

        toastButton.onclick = function() {
            $('.toast').toast('show');
        }
    </script>
    <!-- BEGIN PAGE LEVEL PLUGINS/CUSTOM SCRIPTS -->
<script type="text/javascript">
    //Validate Only Alphabet For Name
  $(function (chkAlphabet) {
  $("#nameDiv").keypress(function (e) {
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
//Mobile Number Validation of 10 Digit
  $(document).ready(function() {

	  $('#mobileDiv').on('keypress', function(e) {

	             var $this = $(this);
	             var regex = new RegExp("^[0-9\b]+$");
	             var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
	             // for 10 digit number only
	             if ($this.val().length > 9) {
	                 e.preventDefault();
	                 return false;
	             }
	             if (e.charCode < 54 && e.charCode > 47) {
	                 if ($this.val().length == 0) {
	                     e.preventDefault();
	                     return false;
	                 } else {
	                     return true;
	                 }

	             }
	             if (regex.test(str)) {
	                 return true;
	             }
	             e.preventDefault();
	             return false;
	         });

	    });

        
</script>
</body>

</html>