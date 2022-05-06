<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no">
    <title>ODISHA FLI-DSS</title>
    <link rel="icon" type="image/x-icon" href="/assets/img/favicon.ico"/>
    <link href="/assets/css/loader.css" rel="stylesheet" type="text/css" />
    <!-- <script src="/assets/js/loader.js"></script> -->

    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700" rel="stylesheet">
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/plugins.css" rel="stylesheet" type="text/css" />
    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL /plugins/CUSTOM STYLES -->
   <!--  <link href="/plugins/apex/apexcharts.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/dashboard/dash_1.css" rel="stylesheet" type="text/css" /> -->
    <!-- END PAGE LEVEL /plugins/CUSTOM STYLES -->

    <!-- Font Awesome -->
    <link rel="stylesheet" href="/fonts/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">

    <!--  BEGIN CUSTOM STYLE FILE  -->
    <link href="/assets/css/elements/miscellaneous.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/elements/breadcrumb.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/components/cards/card.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/elements/custom-pagination.css" rel="stylesheet" type="text/css" />
    <link href="/plugins/table/datatable/datatables.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/plugins/table/datatable/custom_dt_html5.css">
    <link rel="stylesheet" type="text/css" href="/plugins/table/datatable/dt-global_style.css">
    <link href="/plugins/table/datatable/dt-global_style.css" rel="stylesheet" type="text/css">
    <link href="/assets/css/elements/tooltip.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/scrollspyNav.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/forms/switches.css" rel="stylesheet" type="text/css" />
    <link href="/plugins/flatpickr/flatpickr.css" rel="stylesheet" type="text/css" />
    <link href="/plugins/noUiSlider/nouislider.min.css" rel="stylesheet" type="text/css" />
    <link href="/plugins/flatpickr/custom-flatpickr.css" rel="stylesheet" type="text/css" />
    <link href="/plugins/noUiSlider/custom-nouiSlider.css" rel="stylesheet" type="text/css" />
    <link href="/plugins/bootstrap-range-Slider/bootstrap-slider.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/components/tabs-accordian/custom-accordions.css" rel="stylesheet" type="text/css" />
    <link href="/plugins/dropify/dropify.min.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/users/account-setting.css" rel="stylesheet" type="text/css" />
    <link href="/plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
    <link href="/plugins/select2/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="/plugins/notification/snackbar/snackbar.min.css" rel="stylesheet" type="text/css" />
    <!--  END CUSTOM STYLE FILE  -->

    <!-- BEGIN GLOBAL MANDATORY SCRIPTS -->
    <script src="/assets/js/libs/jquery-3.1.1.min.js"></script>
    <!-- <script>
        $(document).ready(function(){
            //$("#infoModal").modal('show');
            $('#infoModal').modal({
                backdrop: 'static',
                keyboard: false
            })
        });
    </script> -->

</head>
<body class="alt-menu sidebar-noneoverflow custom-page">
    <!-- BEGIN LOADER -->
    <!-- <div id="load_screen"> <div class="loader"> <div class="loader-content">
        <div class="spinner-grow align-self-center"></div>
    </div></div></div> -->
    <!--  END LOADER -->

 

    <!--  BEGIN NAVBAR  -->
    <div class="header-container fixed-top">
        <header class="header navbar navbar-expand-sm expand-header row">
            <a href="javascript:void(0);" class="sidebarCollapse" data-placement="bottom"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-menu"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg></a>

            <!-- <h4 class="header-title-lg">FLIDSS (Forest Land Information)</h4>
            <h4 class="header-title-sm">FLIDSS</h4> -->

            <form class="col-md-10">
                <div class="row form-group">
                    <div class="col-md-4 mt-3 pl-4">
                        <div class="form-check form-check-inline custom-adj">
                            <div class="custom-control custom-radio classic-radio-info">
                                <input type="radio" id="hRadiodist" checked name="classicRadio" class="custom-control-input">
                                <label class="custom-control-label" for="hRadiodist">Select District</label>
                            </div>
                        </div>
                        <div class="form-check form-check-inline custom-adj">
                            <div class="custom-control custom-radio classic-radio-info">
                                <input type="radio" id="hRadiodiv" name="classicRadio" class="custom-control-input">
                                <label class="custom-control-label" for="hRadiodiv">Select Division</label>
                            </div>
                        </div>
                    </div>
					<div class="col-md-6 dvselection" id="selectedDistDiv">
					<div class="row">
					   <div class="col-md-6 mt-2">
								<select id="ddldist" class="form-control custom-adj"
								required="required">
								
								<option value="">Select District</option>
								<c:forEach items="${districtList}" var="item">
									<option value="${item.intId}">${item.chrvDistrictNm}</option>
								</c:forEach>
							</select>
	                    </div>
	                    <div class="col-md-6 mt-2">
	                        <select id="ddlTehsil" class="form-control custom-adj">
	                            <option selected="selected">Select Tahasil</option>
	                        </select>
	                    </div>
					</div>
	                    </div>
                  <div class="col-md-6 dvselection" id="selectdivisionDiv" style="display:none;">
                  <div class="row">
                      <div class="col-md-6 mt-2">
	                        		<select id="ddldivision" class="form-control custom-adj"
								required="required">
								
								<option value="">Select Division</option>
								<c:forEach items="${divisionList}" var="item">
									<option value="${item.intId}">${item.chrvDivisionNm}</option>
								</c:forEach>
							</select>
	                        
	                    </div>
	                    <div class="col-md-6 mt-2">
	                        <select id="ddlRange" class="form-control custom-adj">
	                            <option selected="selected">Select Range</option>
	                        </select>
	                    </div>
                  </div>
	                
                    </div>
                     <div class="col-md-2 mt-2">
                        <button id="btnSearch" type="button" class="btn btn-success custom-adj"><i class="fa fa-search">&nbsp;</i>Search</button>
                    </div> 
                </div>
            </form>

            <ul class="navbar-item flex-row ml-auto">

                <li class="nav-item dropdown user-profile-dropdown  order-lg-0 order-1">
                    <a href="javascript:void(0);" class="nav-link dropdown-toggle user" id="userProfileDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user-check"><path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="8.5" cy="7" r="4"></circle><polyline points="17 11 19 13 23 9"></polyline></svg>
                    </a>
                    <div class="dropdown-menu position-absolute e-animated e-fadeInUp" aria-labelledby="userProfileDropdown">
                        <div class="user-profile-section">                            
                            <div class="media mx-auto">
                                <img src="/assets/img/profile-1.jpg" class="img-fluid mr-2" alt="profile image">
                                <div class="media-body">
                                    <h5>Tarini Prasad</h5>
                                    <p>UI / UX Designer</p>
                                </div>
                            </div>
                        </div>
                        <div class="dropdown-item">
                            <a href="profile_settings.html">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg> <span>Profile Settings</span>
                            </a>
                        </div>
                        <div class="dropdown-item">
                            <a href="change_password.html">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-lock"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg> <span>Change Password</span>
                            </a>
                        </div>
                        <div class="dropdown-item">
                            <a href="/logout">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-log-out"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg> <span>Log Out</span>
                            </a>
                        </div>
                    </div>
                </li>
            </ul>
        </header>
    </div>
    <!--  END NAVBAR  -->