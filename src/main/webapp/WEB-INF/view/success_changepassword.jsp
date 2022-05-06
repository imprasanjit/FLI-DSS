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
                                    <h4>Change Password</h4>
                                </div>
                            </div>
                        </div>
                        <div class="widget-content widget-content-area">
                            <div class="alert alert-success text-center">
                                Your password has been updated successfully.
                             </div >
                            <form method="POST" action="/changepassword" onsubmit="return validate()">
                                <div class="row">
                                    <div class="col-md-12 form-group">
                                    	<labeL>Old Password</labeL>
                                        <input name="oldPassword" type="password" class="form-control" placeholder="Old Password">
                                    </div>
                                 
                                    <div class="col-md-12 form-group">
                                    	<label>New Password</label>
                                        <!-- <input name="newPassword" type="password" id="password" class="form-control bs-tooltip" placeholder="New Password" title="Hi, I am a Tooltip" onkeyup="check_pass(this.value)" required> -->
                                       <input name="newPassword" type="password" id="password" class="form-control" placeholder="min 8 character with alphabet, numeric, #, @, mixup man" onchange="check_pass(this.value)" required>
                                       <span id="passalert" style="color: red"></span>
                                    </div>
                             
                                    <div class="col-md-12 form-group">
                                    	<label>Confirm Password</label>
                                        <input name="confirmPassword" type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" onkeyup="check(this)" required>
                                        <span id="alert" style="color: red"></span>
                                    </div>
                                 
                                    <div class="col-md-12 text-center">
                                        <button type="submit" id="submit" class="btn btn-success" >Update</button>
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
    <script>
        $(document).ready(function() {
            App.init();
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

var password = document.getElementById('password');
var flag_confirmpswd =1; // no error
flag_password=1;
function check(e){
if(e.value.length > 0){
   if(e.value != password.value) {
       document.getElementById('alert').innerText = "confirm password doesn't match";
       flag_confirmpswd=0;
   }else{
    document.getElementById('alert').innerText = "";
    flag_confirmpswd=1;

   }
}else{
    document.getElementById('alert').innerText = "Please enter confirm password";
    flag_confirmpswd=0;
   }
}
function validate(){
    if(flag_confirmpswd == 1 && flag_password == 1){
        return true;
    }else{
        return false;
    }
}

function check_pass(password){

    var regix = new RegExp(/^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[a-zA-Z!#$@^%&? "])[a-zA-Z0-9!#$@^%&?]{8,20}$/);

if(regix.test(password) == false ) {
    document.getElementById('passalert').
    innerText = "password must be a minimum of 8 characters including number, Upper, Lower And one special character";
    flag_password=0;
}else{
    document.getElementById('passalert').
    innerText = ""
    flag_password=1;
}

}

</script>
</body>

</html>