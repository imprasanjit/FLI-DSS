      </div>
    <!-- END MAIN CONTAINER -->
  <!-- BEGIN GLOBAL MANDATORY SCRIPTS -->
  
  
    <script src="/bootstrap/js/popper.min.js"></script>
    <script src="/bootstrap/js/bootstrap.min.js"></script>
    <script src="/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="/assets/js/app.js"></script>
    
   <!--  <script>
        $(document).ready(function() {
            App.init();
        });
    </script> -->
    
    <script src="/assets/js/custom.js"></script>
    <!-- END GLOBAL MANDATORY SCRIPTS -->

    <!-- BEGIN PAGE LEVEL /plugins/CUSTOM SCRIPTS -->
    <script src="/plugins/apex/apexcharts.min.js"></script>
    <!-- <script src="/assets/js/dashboard/dash_1.js"></script> -->
    <script src="/assets/js/elements/tooltip.js"></script>
    <script src="/assets/js/scrollspyNav.js"></script>
   <!--  <script src="/plugins/flatpickr/flatpickr.js"></script> -->
  <!--   <script src="/plugins/noUiSlider/nouislider.min.js"></script> -->
  <!--   <script src="/plugins/flatpickr/custom-flatpickr.js"></script> -->
   <!--  <script src="/plugins/noUiSlider/custom-nouiSlider.js"></script> -->
    <script src="/plugins/bootstrap-range-Slider/bootstrap-rangeSlider.js"></script>
    <script src="/plugins/dropify/dropify.min.js"></script>
    <script src="/plugins/blockui/jquery.blockUI.min.js"></script>
    <script src="/assets/js/users/account-settings.js"></script>
    <script src="/plugins/bootstrap-select/bootstrap-select.min.js"></script>
    <script src="/plugins/select2/select2.min.js"></script>
    <script src="/plugins/select2/custom-select2.js"></script>
    <script src="/plugins/notification/snackbar/snackbar.min.js"></script>
     <script src="/assets/js/custom/notification.js"></script>
      <script src="/assets/js/custom/utility.js"></script>
      <script src="/plugins/drag-and-drop/dragula/dragula.min.js"></script>
    <script src="/plugins/drag-and-drop/dragula/custom-dragula.js"></script>
    <!-- <script src="/assets/js/components/notification/custom-snackbar.js"></script> -->
    <script src="/plugins/table/datatable/datatables.js"></script>
    <script src="/plugins/table/datatable/button-ext/dataTables.buttons.min.js"></script>
    <script src="/plugins/table/datatable/button-ext/jszip.min.js"></script>    
    <script src="/plugins/table/datatable/button-ext/buttons.html5.min.js"></script>
    <script src="/plugins/table/datatable/button-ext/buttons.print.min.js"></script>
    <!-- <script src="/plugins/table/datatable/copy_csv_xls_pdf.swf"></script> -->
    <script src="/plugins/table/datatable/pdfmake/pdfmake.min.js"></script>
    <script src="/plugins/table/datatable/pdfmake/vfs_fonts.js"></script>
    <script src="/plugins/Chart.js/Chart.min.js"></script>
    <script src="/plugins/Chart.js/chartjs-script.js"></script>
    
  	<!-- Highchart -->
  	<script src="assets/js/highchart/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="https://code.highcharts.com/modules/export-data.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>
	<script src="https://code.highcharts.com/modules/data.js"></script>
	<script src="https://code.highcharts.com/modules/drilldown.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>
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
       /*  // Get the Toast button
    /*     var toastButton = document.getElementById("toast-btn");
        // Get the Toast element
        var toastElement = document.getElementsByClassName("toast")[0];

        toastButton.onclick = function() {
            $('.toast').toast('show');
        } */
    </script>

</body>

</html>