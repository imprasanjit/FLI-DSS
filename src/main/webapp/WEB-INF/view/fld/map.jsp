<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css" type="text/css">
<tl:eval expression="@environment.getProperty('api.geoserverurl')" var="geoserverUrl"></tl:eval>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/css/ol.css">
	<!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <script src="https://cdn.polyfill.io/v3/polyfill.min.js?features=fetch,requestAnimationFrame,Element.prototype.classList,URL,TextDecoder"></script>
    <script src="https://unpkg.com/dom-to-image-more@2.8.0/dist/dom-to-image-more.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script src="https://unpkg.com/elm-pep"></script>
    <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
<!-- <style>
	/* .ol-scale-bar{
		right: 0;
		left: auto;
	} */
	 .mapFilterBase {
 z-index:999 ! important;
 }
 .spInfo{
	color:red !important;
}
 .ol-tooltip {
        position: relative;
        background: rgba(0, 0, 0, 0.5);
        border-radius: 4px;
        color: white;
        padding: 4px 8px;
        opacity: 0.7;
        white-space: nowrap;
        font-size: 12px;
      }
      .ol-tooltip-measure {
        opacity: 1;
        font-weight: bold;
      }
      .ol-tooltip-static {
        background-color: #ffcc33;
        color: black;
        border: 1px solid white;
      }
      .ol-tooltip-measure:before,
      .ol-tooltip-static:before {
        border-top: 6px solid rgba(0, 0, 0, 0.5);
        border-right: 6px solid transparent;
        border-left: 6px solid transparent;
        content: "";
        position: absolute;
        bottom: -6px;
        margin-left: -7px;
        left: 50%;
      }
      .ol-tooltip-static:before {
        border-top-color: #ffcc33;
      }
      .ol-scale-bar{
          right: 8px;
          left: auto;
      }
      
    
      .close {
            color: white;
            float: right;
            font-size: 19px;
            font-weight: bold;
            opacity: 10.5;
        }
          .ol-popup {
            position: absolute;
            background-color: white;
            -webkit-filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));
            filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #cccccc;
            bottom: 12px;
            left: -50px;
            min-width: 320px;
        }
            .ol-popup:after, .ol-popup:before {
                top: 100%;
                border: solid transparent;
                content: " ";
                height: 0;
                width: 0;
                position: absolute;
                pointer-events: none;
            }

            .ol-popup:after {
                border-top-color: white;
                border-width: 10px;
                left: 48px;
                margin-left: -10px;
            }

            .ol-popup:before {
                border-top-color: #cccccc;
                border-width: 11px;
                left: 48px;
                margin-left: -11px;
            }

        .ol-popup-closer {
            text-decoration: none;
            position: absolute;
            top: 2px;
            right: 8px;
        }

            .ol-popup-closer:after {
			    content: "X";
			    background-color: rgba(255,0,0,0.475);
			    color: #fff;
			    padding: 0px 4px;
			    position: relative;
			    top: 6px;
			    border-radius: 2px;
			    transition: all 0.25s ease-in-out;
			    -moz-transition: all 0.25s ease-in-out;
			    -webkit-transition: all 0.25s ease-in-out;
			    -o-transition: all 0.25s ease-in-out;
			}
			.ol-popup-closer:hover:after{
				background-color: rgba(255,0,0,0.875);
			}

        #popup-content span {
            font-size: 13px;
        }
		#popup-content h5{
			color: #077b6d;
		    font-size: 14px;
		    font-weight: 600;
		}
        #popup-content p {
            line-height: 24px;
        }
        #popup-content .table a{
        	color: #077b6d;
        	text-decoration: underline;
        }
        #popup-content .table a:hover{
        	color: #077b6d;
        	text-decoration: none;
        }
        .chkColor{
        color: #fff !important;
    background-color: #b3d7ff !important;
    border-color: #b3d7ff !important;
        }
        .ol-unselectable .ol-zoom-in, .ol-unselectable .ol-zoom-out{
        	display: none;
        }
        .map-topbar{
        	margin-top: -12px;
        }
      
</style> -->

<!--  BEGIN CONTENT AREA  -->
<div id="content" class="main-content">

	<div class="layout-px-spacing">

		<div class="row layout-top-spacing">
		
			<div class="col-md-3 layout-spacing">
                    <div class="statbox widget box box-shadow">                            
                        <div class="widget-content widget-content-area">
                        	
                        	<div id="accordion" class="mapFilter mapFilterBase2 fixHeightLeft">
                                <div class="map-tab-fix row m-0">
                                    <!-- <a id="" href="#collapseOne" class="text-dark col collapsed bs-tooltip" data-toggle="collapse" aria-expanded="true" aria-controls="collapseOne" title="Area of Interest">
                                        <span class="d-block"><img src="/assets/img/icon-filter.png"></span>
                                    </a> -->

                                    <a id="" href="#collapseTwo" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="true" aria-controls="collapseTwo" title="Layers">
                                        <span class="d-block"><img src="/assets/img/icon-layers.png"></span>
                                    </a>
                                    <a id="" href="#collapseThree" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseThree" title="Legends">
                                        <span class="d-block"><img src="/assets/img/icon-legends.png"></span>
                                    </a>
                                    <a id="" href="#collapseFour" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseFour" title="Basemap">
                                        <span class="d-block"><img src="/assets/img/icon-basemap.png"></span>
                                    </a>
                                    <!-- <a id="a_measure" href="#collapseFive" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseFive" title="Measurement">
                                        <span class="d-block"><img src="/assets/img/icon-measurement.png"></span>
                                    </a>
                                    <a id="a_info" href="#collapseSix" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseSix" title="Info">
                                        <span class="d-block"><img src="/assets/img/icon-info.png"></span>
                                    </a>
                                    <a id="a_measure" href="#collapseSeven" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseSeven" title="Swipe">
                                        <span class="d-block"><img src="/assets/img/icon-swipe.png"></span>
                                    </a>
                                    <a id="a_reset" href="#collapseEight" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseEight" title="Reset">
                                        <span class="d-block"><img src="/assets/img/icon-reset.png"></span>
                                    </a>            -->                         
                                </div>

                                <div class="clearfix"></div>

                                

                                <div class="mb-0">
                                    <div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordion">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="fixHeightRight">
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><span aria-hidden="true">�</span></button> -->
                                                    <div class="card-body custom-card-body">
                                                        <h6 class="mt-0 page-title mb-3">Layers</h6>
                                                        
                                                        <div id="accordion2">
                                                            <!-- <a id="" href="#collapse1" class="collapsed" data-toggle="collapse" aria-expanded="true" aria-controls="collapse1">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-3">Forest Land Boundary<i class="fa fa-angle-down pull-right"></i></h6>
                                                            </a> -->
                                                            <%-- <div id="collapse1" class="collapse show" aria-labelledby="heading1" data-parent="#accordion2">
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkNf" value="1">
                                                                                <label class="custom-control-label" for="chkNf">Notified Forest</label>
                                                                                <img src="/assets/img/forest-01.png" class="img-chk">
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkDlc">
                                                                                <label class="custom-control-label" for="chkDlc">DLC & Other Revenue Forest</label>
                                                                                 <img src="/assets/img/forest-02.png" class="img-chk">
                                                                            </div>
                                                                           <!--  <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox13">
                                                                                <label class="custom-control-label" for="checkbox13">Other Revenue Forest</label>
                                                                                 <img src="/assets/img/forest-03.png" class="img-chk">
                                                                            </div> -->
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox14">
                                                                                <label class="custom-control-label" for="checkbox14">Deemed Forest</label>
                                                                                <img src="/assets/img/forest-04.png" class="img-chk">
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox15">
                                                                                <label class="custom-control-label" for="checkbox15">Diverted Forest Land</label>
                                                                                <img src="/assets/img/forest-05.png" class="img-chk">
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox16">
                                                                                <label class="custom-control-label" for="checkbox16">Compensatory Afforestation Land</label>
                                                                                <img src="/assets/img/forest-06.png" class="img-chk">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div> --%>
                                                           <!--  <span class="spInfo">* Search District/ Division to View other Layers</span> -->
                                                            
                                                            <a id="" href="#collapse2" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse2">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Administrative Boundary<i class="fa fa-angle-right pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse2" class="collapse" aria-labelledby="heading2" data-parent="#accordion2">
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                        	<div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" value="StateBoundary" checked id="chkState">
                                                                                <label class="custom-control-label" for="chkState">State Boundary</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" value="DistrictBoundary" checked id="chkDistrict">
                                                                                <label class="custom-control-label" for="chkDistrict">District</label>
                                                                            </div>                                                                            
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                 <input type="checkbox" class="custom-control-input" id="chkDivision">
                                                                                 <label class="custom-control-label" for="chkDivision">Division Boundary</label>
                                                                             </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input"  id="chkRange">
                                                                                <label class="custom-control-label" for="chkRange">Range</label>
                                                                            </div> 
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input"  id="chkTehsil">
                                                                                <label class="custom-control-label" for="chkTehsil">Tehsil</label>
                                                                            </div>                                                                            
                                                                            <!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkBlock">
                                                                                <label class="custom-control-label" for="chkBlock">Block</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input"  id="chkvillage_layer">
                                                                                <label class="custom-control-label" for="chkvillage_layer">Village</label>
                                                                            </div> -->
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                           <%--  <a id="" href="#collapse3" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Protected Area<i class="fa fa-angle-right pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse3" class="collapse" aria-labelledby="heading3" data-parent="#accordion2">
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                           <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox31">
                                                                                <label class="custom-control-label" for="checkbox31">Sanctuary Boundary</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox32">
                                                                                <label class="custom-control-label" for="checkbox32">National Park</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox33">
                                                                                <label class="custom-control-label" for="checkbox33">Eco-sensitive Zone</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox34">
                                                                                <label class="custom-control-label" for="checkbox34">Notified Wildlife Corridor</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox35">
                                                                                <label class="custom-control-label" for="checkbox35">Conservation Reserve</label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>  
                                                            <a id="" href="#collapse4" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse4">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">FSI - Forest Cover Map<i class="fa fa-angle-right pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse4" class="collapse" aria-labelledby="heading4" data-parent="#accordion2">
                                                                <form>
                                                                    <div class="row form-group form-scroll border pt-2 pb-2">
                                                                        <div class="col-md-12">
                                                                           <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox41">
                                                                                <label class="custom-control-label" for="checkbox41">Forest Cover 2020</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox42">
                                                                                <label class="custom-control-label" for="checkbox42">Forest Cover 2018</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox43">
                                                                                <label class="custom-control-label" for="checkbox43">Forest Cover 2016</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox44">
                                                                                <label class="custom-control-label" for="checkbox44">Forest Cover 2014</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox45">
                                                                                <label class="custom-control-label" for="checkbox45">Forest Cover 2012</label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <a id="" href="#collapse5" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse5">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Hydrological Layers<i class="fa fa-angle-right pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse5" class="collapse" aria-labelledby="heading5" data-parent="#accordion2">
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                           <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox51">
                                                                                <label class="custom-control-label" for="checkbox51">Rivers</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox52">
                                                                                <label class="custom-control-label" for="checkbox52">Reservoirs</label>
                                                                            </div>                                                                            
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <a id="" href="#collapse6" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse6">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Transport Layers<i class="fa fa-angle-right pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse6" class="collapse" aria-labelledby="heading6" data-parent="#accordion2">
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                           <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox61">
                                                                                <label class="custom-control-label" for="checkbox61">Rail</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox62">
                                                                                <label class="custom-control-label" for="checkbox62">Road</label>
                                                                            </div>                                                                            
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>   
                                                              <a id="" href="#collapse7" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse7">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Source Map<i class="fa fa-angle-right pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse7" class="collapse" aria-labelledby="heading6" data-parent="#accordion2">
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                           <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkOsm">
                                                                                <label class="custom-control-label" for="chkOsm">SOI OSM Topo</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkSi">
                                                                                <label class="custom-control-label" for="chkSi">FSI</label>
                                                                            </div> 
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkWp">
                                                                                <label class="custom-control-label" for="chkWp">Working Plan</label>
                                                                            </div>                                                                            
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div> --%> 
                                                         </div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-0">
                                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="fixHeightRight">
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree"><span aria-hidden="true">�</span></button> -->
                                                    <div class="card-body custom-card-body">
                                                        <h6 class="mt-0 page-title mb-3">Legends</h6>
                                                        <div class="row">
                                                            <div class="col-md-12 ml-1">
                                                                <div class="legendbox">
                                                                    <img src="/assets/img/state_boundary.png">
                                                                    <span>State Boundary</span>
                                                                </div>
                                                                <div class="legendbox">
                                                                    <img src="/assets/img/district_boundary.png">
                                                                    <span>District Boundary</span>
                                                                </div>
                                                                <div class="legendbox">
                                                                    <img src="/assets/img/division_boundary.png">
                                                                    <span>Division Boundary</span>
                                                                </div>
                                                                <div class="legendbox">
                                                                    <img src="/assets/img/legend-04.png">
                                                                    <span>Tehsil Boundary</span>
                                                                </div>
                                                                <div class="legendbox">
                                                                    <img src="/assets/img/range_boundary.png">
                                                                    <span>Range Boundary</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-0">
                                    <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordion">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="fixHeightRight">
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour"><span aria-hidden="true">�</span></button> -->
                                                    <div class="card-body custom-card-body">
                                                        <h6 class="mt-0 page-title mb-3">Basemap</h6>
                                                        <form>
                                                            <div class="row form-group">
                                                                <div class="col-md-12">
                                                                       <div class="tab-box">
																	    	<ul class="basesection">
																	    		<li>
																	    			<a id="blank_basemap" class="basebox"><img src="/assets/img/icon-blank.png"><h6>Blank</h6></a>
																	    		</li>
																	    		<li>
																				<a id="imagery_basemap"  class="basebox" ><img src="/assets/img/icon-imagery.png"><h6>Imagery</h6></a>
																	    		</li>
																	    		<li>
																	    			<a id="street_basemap" class="basebox"><img src="/assets/img/icon-street.png"><h6>Street</h6></a>
																	    		</li>
																	    		<li>
																	    			<a id="osm_basemap" class="basebox"><img src="/assets/img/icon-osm.png"><h6>OSM</h6></a>
																	    		</li>
																	    	</ul>
																	    	<div class="clearfix"></div>
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

                                <div class="mb-0">
                                    <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordion">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="fixHeightRight">
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">�</span></button> -->
                                                    <div class="card-body custom-card-body">
                                                        <h6 class="mt-0 page-title mb-3">Measurement</h6>
                                                        <form>
                                                            <div class="row form-group">
                                                                <div class="col-md-12">
                                                                     <div class="row">
																	   <div class="col-md-4 mt-2">
																				 <label for="type" class="font-12">Measurement type &nbsp;</label>
													                    </div>
													                    <div class="col-md-8 mt-2">
													                    <select id="type" class="form-control form-control-sm custom-adj">
																        <option value="length">Length (LineString)</option>
																        <option value="area">Area (Polygon)</option>
																      </select>
																      <div id="helpTooltipElement"></div>
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
								<div class="mb-0">
                                    <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordion">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="fixHeightRight">
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">�</span></button> -->
                                                    <div class="card-body custom-card-body">
                                                        <h6 class="mt-0 page-title mb-3">Info</h6>
                                                        <form>
                                                            <div class="row form-group">
                                                                <div class="col-md-12">
                                                                    <div class="row">
																	   <div class="col-md-4 mt-2">
																				<label class="font-12 pt-2">Active Layer</label>
													                    </div>
													                    <div class="col-md-8 mt-2">
													                    <select id="ddlActiveLayer" class="form-control form-control-sm custom-adj">
																				
																				<option value="">Select Layer</option>
																				<option value="stateboundarylayer">State Boundary</option>
																				<option value="districtboundarylayer">District Boundary</option> 
																			</select>
													                    </div>
													                
																	</div>
																	<!-- <div class="row" id="activeNote">
																		<div class="col-md-12 mt-2">
																			<span style="color: red; font-size:14px;">Note:- Choose any Layer
																				to view Layer info</span>
																		</div>
																	</div> -->
																</div>
                                                                <div id="infodiv"></div>
                                                             	<div id="popup" class="ol-popup">
																    <a href="#" id="popup-closer" class="ol-popup-closer"></a>
																    <div id="popup-content"></div>
																</div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-0">
                                    <div id="collapseEight" class="collapse" aria-labelledby="headingEight" data-parent="#accordion">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="fixHeightRight">
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseEight" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">�</span></button> -->
                                                    <div class="card-body custom-card-body">
                                                        <h6 class="mt-0 page-title mb-3">Export Map</h6>
                                                        <form>
                                                            <div class="row form-group">
                                                                <div class="col-md-12">
                                                                    	<div class="row">
																		   <div class="col-md-12 text-center">
																					<button type="button" id="btnExportpdf"  class="btn btn-sm btn-warning" data-toggle="modal" data-target="#printModal">Export PDF</button>
														                    
														                    <button type="button" id="btnExportImage" class="btn btn-sm btn-warning" class="btn" data-toggle="modal" data-target="#imgprintModal">Export Image</button>
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
                            </div><!--/accordion-->
                    
                        	
                        </div>
                    </div>
                 </div>
                  
                 <div class="col-md-9 layout-spacing">
                    <div class="statbox widget box box-shadow">                            
                        <div class="widget-content widget-content-area">
                        	<div class="map-tool-icon" id="accordionInfo">
                        			<!-- <a href="#collapse51" class="collapsed bs-tooltip" data-toggle="collapse" aria-expanded="false" aria-controls="collapse51" title="Buffer Area"><img src="/assets/img/icon-buffer.png"></span></a> -->
                        			<!-- <a href="#collapse52" class="collapsed bs-tooltip" data-toggle="collapse" aria-expanded="false" aria-controls="collapse52" title="AOI Analysis"><img src="/assets/img/icon-filter.png"></span></a> -->
                        			<!-- <a href="#" class="bs-tooltip" title="Zoom to extent" id="mapFullscreen"><img src="/assets/img/icon-zoom-to-extent.png" onclick="openFullscreen();" ></span></a> -->
                        			<!-- <a href="#" class="bs-tooltip" title="Pan"><img src="/assets/img/icon-pan.png"></span></a> -->
                        			<a href="#" class="bs-tooltip" title="Zoom in" id="ZoomIN"><img src="/assets/img/icon-zoom-in.png"></span></a>
                        			<a href="#" class="bs-tooltip" title="Zoom out" id="ZoomOut"><img src="/assets/img/icon-zoom-out.png"></span></a>
                        			
                        			<div class="accordion-info-box">
                        			
	                        			<div id="collapse51" class="collapse" aria-labelledby="heading51" data-parent="#accordionInfo">
	                                        <div class="card">
	                                            <div class="card-body">
	                                                <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapse51" aria-expanded="false" aria-controls="collapse51"><span aria-hidden="true">�</span></button>
	                                                <div class="card-body custom-card-body">
	                                                   
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    
	                                    <div id="collapse52" class="collapse" aria-labelledby="heading52" data-parent="#accordionInfo">
	                                        <div class="card">
	                                            <div class="card-body">
	                                                
	                                            </div>
	                                        </div>
	                                    </div>
	                                    
	                                </div>
                                                    
                        			
                        		</div>
                               
                        	<div id="mymap" class="fixHeightLeft panel">
                        		<!-- <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834859.9797965377!2d82.19173433935192!3d20.176539522401498!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a226aece9af3bfd%3A0x133625caa9cea81f!2sOdisha!5e0!3m2!1sen!2sin!4v1564120416120!5m2!1sen!2sin" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe> -->
                            </div>
                        
                        </div>
                    </div>
                 </div>
		</div>
	</div>
</div>
<!--  END CONTENT AREA  -->

<div id="infoModal" class="modal fade modal-info-custom">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-body">
				<h5 class="title">About Forest Land Information</h5>
				<img src="assets/img/modal-forest-land-info.jpg"
					class="img-fluid img-thumbnail float-left mr-3 mb-1 w-50">
				<p>Forest land information facilitates map view of different
					types of forest lands (notified forests, revenue forests and other
					deemed forests) in a selected jurisdiction such as a District or
					Forest Division. User can also view the map with different overlays
					such as SOI topo maps, FSI forest cover maps, Satellite Image and
					other open-source web maps.</p>
				<div class="clearfix"></div>
				<hr>
				<div class="text-center">
					<div class="custom-control custom-checkbox checkbox-info mb-3">
						<input type="checkbox" class="custom-control-input"
							id="checkbox52"> <label class="custom-control-label"
							for="checkbox52">Don't show me again!</label>
					</div>
					<button type="button" class="btn btn-success" data-dismiss="modal">Launch
						Data Catalogue</button>
				</div>
			</div>
		</div>
	</div>
</div>
<style>
#popup-content span {
            font-size: 13px;
        }
		#popup-content h5{
			color: #077b6d;
		    font-size: 14px;
		    font-weight: 600;
		}
        #popup-content p {
            line-height: 24px;
        }
        #popup-content .table a{
        	color: #077b6d;
        	text-decoration: underline;
        }
        #popup-content .table a:hover{
        	color: #077b6d;
        	text-decoration: none;
        }
        
</style>
<script type="text/javascript">
var geoserverUrl = '${geoserverUrl}';
$(document).ready(function() {
    App.init();
    $(".header-title-lg").text("FLI DSS (Forest Land Information)");
});
</script>

<script>
stateboundarylayer = new ol.layer.Image({
	source: new ol.source.ImageWMS({
    url: '${geoserverUrl}/FLI_DSS_STATE/wms',
    params: {
    'LAYERS': 'FLI_DSS_STATE:StateBoundary',
    'VERSION': '1.1.0'     
    },
    serverType: 'geoserver',
    visible:true,
    crossOrigin: 'anonymous',  
})
});

districtboundarylayer = new ol.layer.Image({
source: new ol.source.ImageWMS({
    url: '${geoserverUrl}/FLI_DSS_AllDivision/wms',
    params: {
    'LAYERS': 'FLI_DSS_AllDivision:district_boundary',
    'VERSION': '1.1.0'     
    },
    serverType: 'geoserver',
    crossOrigin: 'anonymous'
    
}),
visible:true
});
alldivboundarylayer = new ol.layer.Image({
source: new ol.source.ImageWMS({
    url: '${geoserverUrl}/FLI_DSS_DIVISION/wms',
    params: {
    'LAYERS': 'FLI_DSS_DIVISION:Division',
    'VERSION': '1.1.0'     
    },
    serverType: 'geoserver',
    crossOrigin: 'anonymous'
    
}),
visible:false
});

 allrnglayer  = new ol.layer.Image({
    source: new ol.source.ImageWMS({
    url: '${geoserverUrl}/FLI_DSS_RANGE/wms',
    params: {
    'LAYERS': 'FLI_DSS_RANGE:Range',
    'VERSION': '1.1.0',
    },
    serverType: 'geoserver',
    crossOrigin: 'anonymous'
}),
visible:false
}); 

   alltehasillayer = new ol.layer.Image({
     source: new ol.source.ImageWMS({
         url: '${geoserverUrl}/FLI_DSS_ALL_TAHASIL/wms',
         params: {
             'LAYERS': 'FLI_DSS_ALL_TAHASIL:Tehesil',
             'VERSION': '1.1.0',
         },
         serverType: 'geoserver',
         crossOrigin: 'anonymous'
     }),
     visible: false
   });

 //State Boundary Layer Checkbox Change Event
   $("#chkState").change(function() {
       if(this.checked) {    
           stateboundarylayer.setVisible(true);
           var option="<option value='stateboundarylayer'>State Boundary</option>";
           $("#ddlActiveLayer").append(option);
   } 
   else{
       stateboundarylayer.setVisible(false);
       $("#ddlActiveLayer option[value='stateboundarylayer']").remove();
   }
   });
     //District Boundary Layer Checkbox Change Event
      $("#chkDistrict").change(function() {
       if(this.checked) {    
       	districtboundarylayer.setVisible(true);
       	var option="<option value='districtboundarylayer'>District Boundary</option>";
           $("#ddlActiveLayer").append(option);
   }
   else{
   	districtboundarylayer.setVisible(false);
   	$("#ddlActiveLayer option[value='districtboundarylayer']").remove();
   } 
});
      //Division Boundary Layer Checkbox Change Event
      $("#chkDivision").change(function() {
       if(this.checked) {    
       	alldivboundarylayer.setVisible(true);
       	var option="<option value='alldivboundarylayer'>Division Boundary</option>";
           $("#ddlActiveLayer").append(option);
   }
   else{
   	alldivboundarylayer.setVisible(false);
   	$("#ddlActiveLayer option[value='alldivboundarylayer']").remove();
   } 
}); 
    //Range Boundary Layer Checkbox Change Event
      $("#chkRange").change(function() {    	  
       if(this.checked) {      	   
    	   allrnglayer.setVisible(true);
       	var option="<option value='allrnglayer'>Range Boundary</option>";
           $("#ddlActiveLayer").append(option);
   }
   else{
	   allrnglayer.setVisible(false);
   	$("#ddlActiveLayer option[value='allrnglayer']").remove();
   } 
}); 
      //Tehsil Boundary Layer Checkbox Change Event
      $("#chkTehsil").change(function() {    	 
       if(this.checked) {      	   
    	   alltehasillayer.setVisible(true);
       	var option="<option value='alltehasillayer'>Tehsil Boundary</option>";
           $("#ddlActiveLayer").append(option);
   }
   else{
	   alltehasillayer.setVisible(false);
   	$("#ddlActiveLayer option[value='alltehasillayer']").remove();
   } 
});
    
       

//Base layer 
var baselayer = new ol.layer.Tile({
    source: new ol.source.OSM(),
    visible:false,
    crossOrigin: 'anonymous'
    });

var raster = new ol.layer.Image({
    title: 'OSM',
    type: 'base',
    visible: false,
    source: new ol.source.BingMaps({
        imagerySet: 'AerialWithLabels',
        key: 'voi3DlahFqo0MOrFalC2~6BX9iFreRSXk_hCsSHtZ0A~AuXzxBFu7NJaGwZO6oX2bEbHUKwhiif5YTYYqOZvgRiSl3Rt2zrcB6Addylvwat9'
    }),
    visible:false,
});

var googleLayerSatellite =new ol.layer.Tile({
    title: "Google Satellite",
    source: new ol.source.TileImage({ url: 'https://mt1.google.com/vt/lyrs=s&hl=pl&&x={x}&y={y}&z={z}', crossOrigin: 'anonymous'}),
    visible:false
});
var googleLayerStreet =new ol.layer.Tile({
    title: "Google Street",
    source: new ol.source.TileImage({ url: 'https://mt1.google.com/vt/lyrs=r&hl=pl&&x={x}&y={y}&z={z}', crossOrigin: 'anonymous'}),
    visible:false
});
var source = new ol.source.Vector();
var measureLayer = new ol.layer.Vector({
    source: source,
    style: new ol.style.Style({
	    fill: new ol.style.Fill({
	      color: 'rgba(255, 255, 255, 0.2)',
	    }),
	    stroke: new ol.style.Stroke({
	      color: '#ffcc33',
	      width: 2,
	    }),
	    image: new ol.style.Circle({
	      radius: 7,
	      fill: new ol.style.Fill({
	        color: '#ffcc33',
	      }),
	    }),
	  }),
});
var parser = new ol.format.WMSGetFeatureInfo();
var parser = new ol.format.WMSGetFeatureInfo();
 var highlightOverlay =  new ol.layer.Vector({
  // style: (customize your highlight style here),
  source: source,
}); 
 var selectClick = new ol.interaction.Select({
	  /* condition: new ol.events.condition.click, */
	});
 
 
//HOW TO ADD A MAP OBJECT TO A WEB PAGE

//https://openlayers.org/en/latest/doc/quickstart.html

//var select = new ol.interaction.Select();
 //map.addInteraction(select);
//select.on('select', function(e) {

//});
 var map = new ol.Map({
	    layers: [baselayer,raster,googleLayerStreet,googleLayerSatellite,measureLayer,alltehasillayer,allrnglayer,alldivboundarylayer,districtboundarylayer,stateboundarylayer,highlightOverlay],
	    target: 'mymap',
	    view: new ol.View({
	        center: ol.proj.fromLonLat([84.6525554,20.1664539]),
	        zoom: 6.89,
	        maxZoom: 20,
	        minZoom: 5
	    })
	});
 /* 
 var aa = map.getGeometry().getExtent();
 var oo = ol.extent.getCenter(aa);
 console.log("The center is :  "+oo); */
 
 map.addInteraction(selectClick);
 var container = document.getElementById('popup');
 var content = document.getElementById('popup-content');
 var closer = document.getElementById('popup-closer');
 var overlay  = new ol.Overlay({
     element: container,
     positioning: 'bottom-center',
     stopEvent: true,
     autoPan: true,
     autoPanAnimation: {
         duration: 250
     }
 });
 map.addOverlay(overlay);
 closer.onclick = function() {
     //overlay.setPosition(undefined);
     closer.blur();
     return false;
 };
 var scaleLine = new ol.control.ScaleLine({bar: true, text: true, minWidth: 140,steps:4});
 map.addControl(scaleLine); 

 //Base map Click 
   $("#blank_basemap").click(function(){
   	    baselayer.setVisible(false);
        googleLayerSatellite.setVisible(false);
        googleLayerStreet.setVisible(false);
        
   });
   $("#imagery_basemap").click(function(){
  	 baselayer.setVisible(false);
    googleLayerSatellite.setVisible(true);
    googleLayerStreet.setVisible(false);
     
  });
   $("#street_basemap").click(function(){
  	 baselayer.setVisible(false);
    googleLayerSatellite.setVisible(false);
    googleLayerStreet.setVisible(true);
  });
   $("#osm_basemap").click(function(){
    googleLayerSatellite.setVisible(false);
    googleLayerStreet.setVisible(false);
    baselayer.setVisible(true);
  });
 
   //End Base map click
 //Zoom In and Zoom Out
	$('#ZoomIN').click(function(){	      
	      $('.ol-zoom-in').trigger("click");
	  });
	   $('#ZoomOut').click(function(){
	      
	      $('.ol-zoom-out').trigger("click");
	  });
	   
	   <!-- Full Screen -->
	var elem = document.getElementById("mapFullscreen");
	function openFullscreen() {
		$(".fixHeightLeft").toggleClass("intro");
		if (elem.requestFullscreen) {
			elem.requestFullscreen();
		}else if (elem.webkitRequestFullscreen) {   /* Safari */
			elem.webkitRequestFullscreen();
		}else if (elem.msRequestFullscreen) {   /* IE 11 */
			elem.msRequestFullscreen();
		}
	}
	</script>


<%@ include file="../shared/footer.jsp"%>
