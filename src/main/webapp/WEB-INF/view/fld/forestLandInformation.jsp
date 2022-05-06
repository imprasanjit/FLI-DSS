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

<!-- <script src="/assets/js/custom/layer_style.js"></script>   
<script src="/assets/js/apps/loadMap.js"></script>
<script src="/assets/js/apps/baseLayer.js"></script>
<script src="/assets/js/fld/allCommonBoundary.js"></script>
<script src="/assets/js/fld/analysis.js"></script>
<script src="/assets/js/fld/measurement.js"></script> -->

<style>
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
      
</style>

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
                                    <a id="a_measure" href="#collapseFive" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseFive" title="Measurement">
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
                                    </a>                                    
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
                                                            <a id="" href="#collapse1" class="collapsed" data-toggle="collapse" aria-expanded="true" aria-controls="collapse1">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-3">Forest Land Boundary<i class="fa fa-angle-down pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse1" class="collapse show" aria-labelledby="heading1" data-parent="#accordion2">
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
                                                            </div>
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
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkBlock">
                                                                                <label class="custom-control-label" for="chkBlock">Block</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input"  id="chkvillage_layer">
                                                                                <label class="custom-control-label" for="chkvillage_layer">Village</label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <a id="" href="#collapse3" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
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
                                                            </div> 
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
																	<div class="row" id="activeNote">
																		<div class="col-md-12 mt-2">
																			<span style="color: red; font-size:14px;">Note:- Choose any Layer
																				to view Layer info</span>
																		</div>
																	</div>
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
                        			<a href="#collapse51" class="collapsed bs-tooltip" data-toggle="collapse" aria-expanded="false" aria-controls="collapse51" title="Buffer Area"><img src="/assets/img/icon-buffer.png"></span></a>
                        			<a href="#collapse52" class="collapsed bs-tooltip" data-toggle="collapse" aria-expanded="false" aria-controls="collapse52" title="AOI Analysis"><img src="/assets/img/icon-filter.png"></span></a>
                        			<a href="#" class="bs-tooltip" title="Zoom to extent" id="mapFullscreen"><img src="/assets/img/icon-zoom-to-extent.png" onclick="openFullscreen();" ></span></a>
                        			<!-- <a href="#" class="bs-tooltip" title="Pan"><img src="/assets/img/icon-pan.png"></span></a> -->
                        			<a href="#" class="bs-tooltip" title="Zoom in" id="ZoomIN"><img src="/assets/img/icon-zoom-in.png"></span></a>
                        			<a href="#" class="bs-tooltip" title="Zoom out" id="ZoomOut"><img src="/assets/img/icon-zoom-out.png"></span></a>
                        			
                        			<div class="accordion-info-box">
                        			
	                        			<div id="collapse51" class="collapse" aria-labelledby="heading51" data-parent="#accordionInfo">
	                                        <div class="card">
	                                            <div class="card-body">
	                                                <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapse51" aria-expanded="false" aria-controls="collapse51"><span aria-hidden="true">�</span></button>
	                                                <div class="card-body custom-card-body">
	                                                    <h6 class="mt-0 page-title mb-3">Buffer Area</h6>
	                                                    <form>
		                                                    <div class="row mb-2">
		                                                    	<div class="col-md-1 mt-2">
		                                                    		<img src="/assets/img/fa-buffer.png" class="img-chk">
		                                                    	</div>
		                                                    	<div class="col-md-10">
		                                                    		<input type="number" class="form-control form-control-sm" placeholder="Enter Buffer Area (in mtr)">	
		                                                    	</div>
		                                                    	<div class="col-md-1 mt-1">
		                                                    		<i class="fa fa-check text-success"></i>
		                                                    	</div>
		                                                    </div>
		                                                    <div class="row">
		                                                    	<div class="col-md-12 text-center">
		                                                    		<button type="submit" class="btn btn-sm btn-success">Create Buffer Area</button>
		                                                    	</div>
		                                                    </div>
		                                                </form>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    
	                                    <div id="collapse52" class="collapse" aria-labelledby="heading52" data-parent="#accordionInfo">
	                                        <div class="card">
	                                            <div class="card-body">
	                                                <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapse52" aria-expanded="false" aria-controls="collapse51"><span aria-hidden="true">�</span></button>
	                                                <div class="card-body custom-card-body">
	                                                    <h6 class="mt-0 page-title mb-3">AOI Analysis</h6>
	                                                    <form>
		                                                    <div class="row mb-1">
		                                                    	<div class="col-md-1 mt-1">
		                                                    		<i class="fa fa-file"></i>
		                                                    	</div>
		                                                    	<div class="col-md-10">
		                                                    		<input type="file" class="form-control form-control-sm">
		                                                    	</div>
		                                                    	<div class="col-md-1 mt-1">
		                                                    		<i class="fa fa-check text-success"></i>
		                                                    	</div>
		                                                    	<div class="text-danger col-md-10 offset-md-1">
		                                                    	<small>Import File (SHP, KML)</small>
		                                                    	</div>
		                                                    </div>
	                                                    	<div class="row mb-1">
		                                                    	<div class="col-md-1 mt-1">
		                                                    		<i class="fa fa-map-marker"></i>
		                                                    	</div>
		                                                    	<div class="col-md-10">
		                                                    		<input type="file" class="form-control form-control-sm">
		                                                    	</div>
		                                                    	<div class="col-md-1 mt-1">
		                                                    		<i class="fa fa-check text-success"></i>
		                                                    	</div>
		                                                    	<div class="text-danger col-md-10 offset-md-1">
		                                                    	<small>Import Location Co-ordinates File</small>
		                                                    	</div>
		                                                    </div>
		                                                    <div class="row mb-1">
		                                                    	<div class="col-md-1 mt-1">
		                                                    		<img src="/assets/img/fa-polygon.png" class="img-chk">
		                                                    	</div>
		                                                    	<div class="col-md-10">
		                                                    		<button type="submit" class="btn btn-sm btn-info">Draw AOI</button>
		                                                    	</div>
		                                                    	<div class="col-md-1 mt-1">
		                                                    		<i class="fa fa-check text-success"></i>
		                                                    	</div>
		                                                    </div>
		                                                    <hr>
		                                                    <div class="row">
		                                                    	<div class="col-md-12 text-center">
		                                                    		<button type="submit" class="btn btn-sm btn-success mr-1">Process</button>
		                                                    		<button type="submit" class="btn btn-sm btn-danger">Cancel</button>
		                                                    	</div>
		                                                    </div>
	                                                    </form>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    
	                                </div>
                                                    
                        			
                        		</div>
                               
                        	<div id="map" class="fixHeightLeft panel">
                        		<!-- <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834859.9797965377!2d82.19173433935192!3d20.176539522401498!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a226aece9af3bfd%3A0x133625caa9cea81f!2sOdisha!5e0!3m2!1sen!2sin!4v1564120416120!5m2!1sen!2sin" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe> -->
                            </div>
                        
                        </div>
                    </div>
                 </div>

				<button id="queryBtn" class="btn btn-sm btn-query">
					<i class="fa fa-angle-left rotate"></i>
				</button>
				<div id="queryContent" class="query-content card" style="display:none">
					<div class="">
						
						<h6 class="mt-0 page-title mb-2">AOI Forest Information</h6>
						
						<div class="table-responsive">
							<h6>Notified Forest</h6>
							<table class="table table-sm table-bordered">
								<thead>
									<tr>
										<th>Sl. No.</th>
										<th>Division</th>
										<th>Range</th>
										<th>FB Name</th>
										<th>FB Type</th>
										<th>Area in Ha.</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>Angul</td>
										<td>Angul</td>
										<td>Badadanda Sahi</td>
										<td>RF</td>
										<td>294.622</td>
									</tr>
									<tr>
										<td>2</td>
										<td>Angul</td>
										<td>Angul</td>
										<td>Burti</td>
										<td>DPF</td>
										<td>2958.357</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="table-responsive">
							<h6>DLC</h6>
							<table class="table table-sm table-bordered">
								<thead>
									<tr>
										<th>Sl. No.</th>
										<th>District</th>
										<th>Tehsil</th>
										<th>Village</th>
										<th>Plot No.</th>
										<th>Kisham</th>
										<th>RoR Area in Acre</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>Angul</td>
										<td>Angul</td>
										<td>Guranga</td>
										<td>557</td>
										<td>Chhota Janggal</td>
										<td>0.08</td>
									</tr>
									<tr>
										<td>2</td>
										<td>Angul</td>
										<td>Angul</td>
										<td>Saharagoda</td>
										<td>23</td>
										<td>Janggal Dui</td>
										<td>2.26</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="table-responsive">
							<h6>Other Revenue Forest</h6>
							<table class="table table-sm table-bordered">
								<thead>
									<tr>
										<th>Sl. No.</th>
										<th>District</th>
										<th>Tehsil</th>
										<th>Village</th>
										<th>Plot No.</th>
										<th>Kisham</th>
										<th>RoR Area in Acre</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>Angul</td>
										<td>Angul</td>
										<td>Aradiha</td>
										<td>72</td>
										<td>Taila Dui</td>
										<td>0.4</td>
									</tr>
									<tr>
										<td>2</td>
										<td>Angul</td>
										<td>Angul</td>
										<td>Badakantakul</td>
										<td>678</td>
										<td>Bagayat Dui</td>
										<td>0.07</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="table-responsive">
							<h6>Deemed Forest</h6>
							<table class="table table-sm table-bordered">
								<thead>
									<tr>
										<th>Sl. No.</th>
										<th>District</th>
										<th>Tehsil</th>
										<th>Village</th>
										<th>Plot No.</th>
										<th>Area in Acre</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>2</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="table-responsive">
							<h6>Diverted Forest (Revenue)</h6>
							<table class="table table-sm table-bordered">
								<thead>
									<tr>
										<th>Sl. No.</th>
										<th>District</th>
										<th>Tehsil</th>
										<th>Village</th>
										<th>Plot No.</th>
										<th>Kisham</th>
										<th>Area in Acre</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>2</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="table-responsive">
							<h6>Diverted Forest (Notified)</h6>
							<table class="table table-sm table-bordered">
								<thead>
									<tr>
										<th>Sl. No.</th>
										<th>Division</th>
										<th>Range</th>
										<th>FB Name</th>
										<th>Area in Ha.</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>2</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
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
<!--  <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
<script src="https://epsg.io/32645.js"></script>
<script src="/v5.3.0-dist/32644.js"></script>
<script src="/assets/js/custom/layer_style.js"></script> -->
<!-- <script src="/assets/js/libs/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/reqwest/2.0.5/reqwest.min.js"></script>
<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
<script src="https://epsg.io/32645.js"></script>
<script src="/v5.3.0-dist/ol.js"></script> -->
<!-- <script src="/assets/js/apps/loadMap.js"></script> -->
<!-- <script src="/assets/js/apps/baseLayers.js"></script> -->
<!-- <script src="/assets/js/fld/allCommonBoundary.js"></script> -->
<!-- <script src="/assets/js/fld/analysis.js"></script> -->
<!-- <script src="https://epsg.io/32645.js"></script>
<script src="/v5.3.0-dist/32644.js"></script> -->
<script type="text/javascript">
var geoserverUrl = '${geoserverUrl}';
$(document).ready(function() {
    App.init();
    /* $("#infoModal").modal('show'); */
    $(".header-title-lg").text("FLI DSS (Forest Land Information)");
});
</script>

<script>
var wp_raster1=[],village_layer,village_layer1,dlc_layer,dlc_layer1
,stateboundarylayer,districtboundarylayer,alldivboundarylayer,allrnglayer,alltehasillayer,osm_raster,osm_raster1,si_raster,si_raster1,wp_raster,dgpspillarLayer
,layerOrderList=[];
layerOrderList=[
	"si_raster",
	"dlc_layer",
	"nf_layer",	
	"village_layer",
	"allrnglayer",
	"alltehasillayer",
	"alldivboundarylayer",
	"districtboundarylayer",
	"stateboundarylayer",
	"wp_raster","dgpspillarLayer"];
	
village_layer1=[];
dlc_layer1=[];
osm_raster1=[];
si_raster1=[];
var nfb_layer;
var nfb_layer1=[];
var rf_layer;
var layerinfo;
var propArray=[];


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
    /* minResolution: 2482482,
    maxResolution: 8849780, */
    
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
//title: 'RangeBoundary',
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
     //title: "TahasilBoundary",
     visible: false
   });
/*    nfb_layer = new ol.layer.Vector({
   	  source: vectorSource,
   	 style:nfb_survey_style
       
   	  }); */
  
 //Load All Raster Layer
/*  $.ajax({
				url: '/Utility/getAllRasterList',
				data: {
					'type': 3
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {	
					
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";								
							var addRasterLayer = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
							if (wp_raster != null) {	
								wp_raster1.push(addRasterLayer); */
								/*map.addLayer(wp_raster);
								if ($("#chkWp").is(":checked")) {
									wp_raster.setVisible(true);
									wp_raster1.push(wp_raster);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(wp_raster1.length>0)
		                                 {
	                            			 wp_raster1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									//alert("false");
									wp_raster.setVisible(false);
									map.removeLayer(wp_raster);									
								}*/

							/* } else {
								AlertNotify("WP is not available.")
							}
						}
						wp_raster1.setVisible(true);
					}
				},
				error: function (xhr, status) {

				}
			}); */
 //end
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
    //Notified Boundary Layer Checkbox Change Event
       $("#chkNf").change(function() {    	 
       if(this.checked) {  
    	  	var option="<option value='1'>Notified Forest</option>";
            $("#ddlActiveLayer").append(option);   	      	   
    	   if(nfb_layer!=undefined){
    		   nfb_layer.setVisible(true);
    	   }
    	   
     
   }
   else{
	   nfb_layer.setVisible(false);
   	$("#ddlActiveLayer option[value='1']").remove();
   } 
}); 
       //DLC & Rev Boundary Layer Checkbox Change Event
      $("#chkDlc").change(function() {    	 
       if(this.checked) {  
    	   var option="<option value='dlc_layer'>DLC & Revnue Forest</option>";
           $("#ddlActiveLayer").append(option);   	       	   
    	   if(dlc_layer!=undefined){
    		   dlc_layer.setVisible(true);
    	   }
    	   
       	
   }
   else{
	   dlc_layer.setVisible(false);
   	$("#ddlActiveLayer option[value='dlc_layer']").remove();
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
 //console.log(wp_raster);
 var map = new ol.Map({
	    layers: [baselayer,raster,googleLayerStreet,googleLayerSatellite,measureLayer,alltehasillayer,allrnglayer,alldivboundarylayer,districtboundarylayer,stateboundarylayer,highlightOverlay],
	/*     controls: ol.control.defaults().extend([
	     new ol.control.ScaleLine({
	    	 units: "metric",
	    	    bar: true,
	    	    steps: 4,
	    	    text: true,
	    	    minWidth: 140,
	    	    maxwidth:150
	    })/* ,
	    new ol.control.FullScreen(), */
	   /*  mousePositionControl]), */ 
	    
	    target: 'map',
	    view: new ol.View({
	        center: ol.proj.fromLonLat([84.6525554,20.1664539]),
	        zoom: 6.89,
	        maxZoom: 20,
	        minZoom: 5
	    })
	});
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
//Map on Single Click 
 map.on('singleclick', function(evt) { 
	 var divContent="";	
	// highlightOverlay.removeFeatures(highlightOverlay.getSource().getFeatureById('StateBoundary.1'));
	 highlightOverlay.getSource().clear();

	 /* var features = highlightOverlay.getSource().getFeatures();
	    features.forEach((feature) => {
	    	highlightOverlay.getSource().removeFeature(feature);
	    }); */
	
	 if($("#a_info").hasClass("collapsed")){		 
		 $("#a_info").click();
	 }
	
	 if($("#ddlActiveLayer").val()=="")
		 {		 
    		 if($("#a_info").attr('aria-expanded')=='false'){
    		 	$("#activeNote").show();
    		 }
		 }
	 else
		 {
		
		 $("#activeNote").hide();
		
		 if($("#a_measure").attr('aria-expanded')=='false'){			 
			 //console.log(evt.pixel)
             var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature, layer) {
                 return feature;
             });
			 
             if (feature) 
             {       
            	 //alert("if feature");           	 
             	/* if($("#a_info").attr('aria-expanded')=='false'){
             		$("#a_info").click();
             	} */             		
             	var coord = feature.getGeometry().getCoordinates();
                 var props = feature.getProperties();
                 console.log(props);
                 var content1 = "Layer Details"
                 	+"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-bordered'>"
                     +"<tr><td>Forest Block</td><td>"+props.fb_name+"</td></tr>"  
                     +"<tr><td>FB Type</td><td>"+props.fb_type+"</td></tr>"                           
                     +"<tr><td>District</td><td>"+props.district_name+"</td></tr>"
                     +"<tr><td>Division</td><td>"+props.division_name+"</td></tr>"
                     +"<tr><td>Range</td><td>"+props.range_name+"</td></tr>"
                     +"<tr><td>Area(Ha)</td><td>"+props.area_ha+"</td></tr>"
                     +"<tr><td>Area(Sq KM)</td><td>"+props.area_sqkm+"</td></tr>"
                     +"<tr><td>Perimeter(mtr)</td><td>"+props.perimeter+"</td></tr>"
                     +"<tr><td>Survey Type</td><td>"+props.surveytype+"</td></tr></table></div>"
                    //overlay.setPosition(evt.coordinate); 
                     $("#infodiv").html(content1);
             } 
             else 
             {   
         		    ///alert("nf_layer");        		   
            	 $("#infodiv").html(""); 
             	 var view = map.getView();
             	 var url="";
             	
             	 divContent="State Boundary </br><div class='table-responsive my-table-sm'><table class='table table-bordered'>";
             	 if($("#ddlActiveLayer").val()=="stateboundarylayer")
         		 {             		 
         		 url = stateboundarylayer.getSource().getFeatureInfoUrl(evt.coordinate,view.getResolution(), view.getProjection(),
                	      {'INFO_FORMAT': 'application/vnd.ogc.gml'});
             		getInfo(url,divContent);
             		
         		 }
             	 else if($("#ddlActiveLayer").val()=="districtboundarylayer")
         		 {             		 
             		 divContent="District Boundary </br><div class='table-responsive my-table-sm'><table class='table table-bordered'>";
         		url = districtboundarylayer.getSource().getFeatureInfoUrl(evt.coordinate,view.getResolution(), view.getProjection(),
                	      {'INFO_FORMAT': 'application/vnd.ogc.gml'});
         		getInfo(url,divContent);
         		console.log('url '+url)
         		 }
             	 else if($("#ddlActiveLayer").val()=="alldivboundarylayer")
            		 {
             		 divContent="Division Boundary </br><div class='table-responsive my-table-sm'><table class='table table-bordered'>";
            			url = alldivboundarylayer.getSource().getFeatureInfoUrl(evt.coordinate,
                   	      view.getResolution(), view.getProjection(),
                   	      {'INFO_FORMAT': 'application/vnd.ogc.gml'});
            			getInfo(url,divContent);
                  
            		 }
             	else if($("#ddlActiveLayer").val()=="allrnglayer")
		       		 {
		        		 divContent="Range Boundary </br><div class='table-responsive my-table-sm'><table class='table table-bordered'>";
		       			url = allrnglayer.getSource().getFeatureInfoUrl(evt.coordinate,
		              	      view.getResolution(), view.getProjection(),
		              	      {'INFO_FORMAT': 'application/vnd.ogc.gml'});
		       			getInfo(url,divContent);
		             
		       		 }
             	else if($("#ddlActiveLayer").val()=="alltehasillayer")
          		 {
           		 divContent="Tahsil Boundary </br><div class='table-responsive my-table-sm'><table class='table table-bordered'>";
          			url = alltehasillayer.getSource().getFeatureInfoUrl(evt.coordinate,
                 	      view.getResolution(), view.getProjection(),
                 	      {'INFO_FORMAT': 'application/vnd.ogc.gml'});
          			getInfo(url,divContent);
                
          		 }
             /* 	 else if($("#ddlActiveLayer").val()=="1")
         		 {
             		// console.log("source"+nfb_layer.getSource());
          		 divContent="Notified Boundary </br><div class='table-responsive my-table-sm'><table class='table table-bordered'>";
         			url = nfb_layer.getSource().getFeatureInfoUrl(evt.coordinate,
                	      view.getResolution(), view.getProjection(),
                	      {'INFO_FORMAT': 'application/vnd.ogc.gml'});
         			getInfo(url,divContent);              
         		 } */ 
              	 else if($("#ddlActiveLayer").val()=="dlc_layer")
         		 {
              		// alert('inside dlcLayer');
              		 
             		// console.log("source"+nfb_layer.getSource());
          		 divContent="DLC & Revnue Forest </br><div class='table-responsive my-table-sm'><table class='table table-bordered'>";
         			url = dlc_layer.getSource().getFeatureInfoUrl(evt.coordinate,
                	      view.getResolution(), view.getProjection(),
                	      {'INFO_FORMAT': 'application/vnd.ogc.gml'});
         			//alert('url: '+url);
         			console.log(url);
         			getInfo(url,divContent);              
         		 }  
              }
 			}
		 }    	    	
     });
                    
 function getInfo(url,divContent)
 {
	 //alert("ok");
	 //alert(url);
	 console.log(url);
	  $.ajax(url).then(function(response) {
	    var features = parser.readFeatures(response);
	    highlightOverlay.getSource().clear();
	    highlightOverlay.getSource().addFeatures(features);
	    
	    console.log(features[0].getProperties());
	    var props=features[0].getProperties();
	 for(var key in props) {
		    if((key!='the_geom')&& (key!='geom'))
			 {
				divContent+="<tr><td>"+key+"</td><td>"+props[key]+"</td></tr>"
			 }
       //alert("Key: " + key + " value: " + props[key]); 
    }
	divContent+="</table></div>"
	 $("#infodiv").html(divContent); 
	//$("#a_info").click();
 
 });
 } 
   
  
 var sketch;
	var helpTooltipElement;
	var helpTooltip;
	var measureTooltipElement;

	var measureTooltip;

	var continuePolygonMsg = 'Click to continue measure the polygon';

	var continueLineMsg = 'Click to continue measure the line';
	//createHelpTooltip();
	// createMeasureTooltip();
	var pointerMoveHandler = function (evt) {
		  if (evt.dragging) {
		    return;
		  }
	var helpMsg = 'Click to start measure';
	if (sketch) {
	    var geom = sketch.getGeometry();
	    if (geom instanceof ol.geom.Polygon) {
	      helpMsg = continuePolygonMsg;
	    } else if (geom instanceof ol.geom.LineString) {
	      helpMsg = continueLineMsg;
	    }
	  }
	
	 helpTooltipElement.innerHTML = helpMsg;
	  helpTooltip.setPosition(evt.coordinate);

	  helpTooltipElement.classList.remove('hidden');
	};		
		var typeSelect = document.getElementById('type');
		var draw;
		var formatLength = function (line) {
			  var length = ol.sphere.getLength(line);
			  var output;
			  if (length > 100) {
			    output = Math.round((length / 1000) * 100) / 100 + ' ' + 'km';
			  } else {
			    output = Math.round(length * 100) / 100 + ' ' + 'm';
			  }
			  return output;
			};
			
			var formatArea = function (polygon) {
				  var area =  ol.sphere.getArea(polygon);
				  var output;
				  if (area > 10000) {
				    output = Math.round((area / 1000000) * 100) / 100 + ' ' + 'km<sup>2</sup>';
				  } else {
				    output = Math.round(area * 100) / 100 + ' ' + 'm<sup>2</sup>';
				  }
				  return output;
				};
				function addInteraction() {
					  var type = typeSelect.value == 'area' ? 'Polygon' : 'LineString';
					  draw = new ol.interaction.Draw({
					    source: source,
					    type: type,
					    style: new ol.style.Style({
					      fill: new ol.style.Fill({
					        color: 'rgba(255, 255, 255, 0.2)',
					      }),
					      stroke: new ol.style.Stroke({
					        color: 'rgba(0, 0, 0, 0.5)',
					        lineDash: [10, 10],
					        width: 2,
					      }),
					      image: new ol.style.Circle({
					        radius: 5,
					        stroke: new ol.style.Stroke({
					          color: 'rgba(0, 0, 0, 0.7)',
					        }),
					        fill: new ol.style.Fill({
					          color: 'rgba(255, 255, 255, 0.2)',
					        }),
					      }),
					    }),
					  });
					  map.addInteraction(draw);
					  createMeasureTooltip();
					  createHelpTooltip();

					  var listener;
					  draw.on('drawstart', function (evt) {
					    // set sketch
					    sketch = evt.feature;

					    /** @type {import("../src/ol/coordinate.js").Coordinate|undefined} */
					    var tooltipCoord = evt.coordinate;

					    listener = sketch.getGeometry().on('change', function (evt) {
					      var geom = evt.target;
					      var output;
					      if (geom instanceof ol.geom.Polygon) {
					        output = formatArea(geom);
					        tooltipCoord = geom.getInteriorPoint().getCoordinates();
					      } else if (geom instanceof ol.geom.LineString) {
					        output = formatLength(geom);
					        tooltipCoord = geom.getLastCoordinate();
					      }
					      measureTooltipElement.innerHTML = output;
					      measureTooltip.setPosition(tooltipCoord);
					    });
					  });

					  draw.on('drawend', function () {
					  //  measureTooltipElement.className = 'ol-tooltip ol-tooltip-static';
					 //   measureTooltip.setOffset([0, -7]);
					    // unset sketch
					  //  sketch = null;
					    // unset tooltip so that a new one can be created
					    measureTooltipElement = null;
					    createMeasureTooltip();
					     ol.Observable.unByKey(listener);
					  });
					}
			 function createHelpTooltip() {
				  if (helpTooltipElement) {
				    helpTooltipElement.parentNode.removeChild(helpTooltipElement);
				  }
				  helpTooltipElement = document.createElement('div');
				  helpTooltipElement.className = 'ol-tooltip hidden';
				  helpTooltip = new ol.Overlay({
				    element: helpTooltipElement,
				    offset: [15, 0],
				    positioning: 'center-left',
				  });
				  map.addOverlay(helpTooltip);
				}
			 function createMeasureTooltip() {
				  if (measureTooltipElement) {
				    measureTooltipElement.parentNode.removeChild(measureTooltipElement);
				  } 
				  measureTooltipElement = document.createElement('div');
				  measureTooltipElement.className = 'ol-tooltip ol-tooltip-measure measure_tooltip';
				  measureTooltip = new ol.Overlay({
				    element: measureTooltipElement,
				    offset: [0, -15],
				    positioning: 'bottom-center',
				  });
				  map.addOverlay(measureTooltip);
				}
			 typeSelect.onchange = function () {
				  map.removeInteraction(draw);
				  addInteraction();
				};				
				 $(".feature").click(function () {
					 map.removeOverlay(overlay);
					 map.removeOverlay(helpTooltip);
					 map.removeOverlay(measureTooltip);
					  $("div.measure_tooltip").remove();
		             map.removeInteraction(draw);
		             measureLayer.getSource().clear(); 

		               if($(this).attr('id')=="a_measure")
		            	   {
		            	   map.on('pointermove', pointerMoveHandler);
			                map.getViewport().addEventListener('mouseout', function () {
			          		  helpTooltipElement.classList.add('hidden');
			          		});
			                addInteraction();
		            	   }		                		                
		        });
				 
  /* Measurement End */
 
//Onchange of chkvillage_layer,add/remove village layer.
   $("#chkvillage_layer").change(function (event) {		
			 if(!$("#chkvillage_layer").is(":checked"))
             { 				 
            	map.removeLayer(eval(village_layer));
              if(village_layer1.length>0)
              {
            	  village_layer1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getAllLayerList',
				data: {
					'type': 14
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {					
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";	
							//village_layer1=obj[i].text;
							village_layer = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
							if (village_layer != null) {
								map.addLayer(village_layer);
								//map.moveMarkersToTop (village_layer);
								//map.setMap(village_layer);
								if ($("#chkvillage_layer").is(":checked")) {
									village_layer.setVisible(true);
									village_layer1.push(village_layer);
	                            	 if(i==arrayLength-1){
	                            		 if(village_layer1.length>0)
		                                 {
	                            			 village_layer1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									village_layer.setVisible(false);
									map.removeLayer(village_layer);									
								}

							} else {
								AlertNotify("village Boundary is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
		});
  
 //Bind NFB Layers by function
		  $("#chkNf").click(function (event) {		   
			 
			 LoadFBLayer();
		 }); 				 
//Bind NFB Layers				
		function LoadFBLayer()
		{
			if(!$("#chkNf").is(":checked"))
            { 				 
           	map.removeLayer(eval(nfb_layer));
             if(nfb_layer1.length>0)
             {
            	 nfb_layer1.forEach(function(item){
                     map.removeLayer(item);
                 });
             }
            }			
			else{			
				layerinfo="";
				//propArray="";
				var paramdist = 0;
				var paramdivision =1 ;
				//alert(${divisionList});
				var flType=$("#chkNf").val();				
				var divList=[1,10,20,22,31,35,36,43,44,48,50];				
				$.each(divList,function(index,data){					
					paramdivision=data;				
				//console.log(flType);				
				$.ajax({
					
		            url: "/LoadLayersForFli",
		            data: {
		                'landType': flType,
		                'distid': paramdist,
		                'divid': paramdivision,
		                'rangeCode':""
		            },
		            type: "GET",
		            contentType: "application/json;charset=utf-8",
		            dataType: "json",
		            success: function(result) {		            	
		        			var jsonObj = {};
		        			var arr=[];		        			
		        			var i=1;
		        			result.forEach(function(data) 
		        			    {
			        				var jsonData = {};
			        			        jsonData["geometry"] =JSON.parse(data.geom);
			        			       	jsonData["type"]="Feature";
			        			     let cmvProp = JSON.parse(JSON.stringify(data))
			        			      delete cmvProp['geom'];
			        			      jsonData["properties"]=cmvProp;
			        				  arr.push(jsonData);			        				 
			        			    });
		        			jsonObj["features"]=arr;
		        				jsonObj["type"]="FeatureCollection";
		        				 ol.proj.proj4.register(proj4);
		        				var format = new ol.format.GeoJSON({
		        					projection: 'EPSG:3857'
		        					});
		        			   var vectorSource = new ol.source.Vector({
		        	    	 features:format.readFeatures(jsonObj,{
		        	    	      dataProjection: new ol.proj.get('EPSG:4326'),
		        	    	      featureProjection: new ol.proj.get('EPSG:3857')
		        	    	    }), 
		        			        wrapX: false,
		        			       crossOrigin: 'anonymous'
		        			        });		        			  
		        				if($("#chkNf").val()=="1")
		                		{
		        					//alert("if");
		        					if($("#chkNf").is(":checked"))
		        						{
		        						nfb_layer = new ol.layer.Vector({
				              		    	  source: vectorSource,
				              		    	 style:nfb_survey_style
				              		        
				              		    	  });
				              		        map.addLayer(nfb_layer);
				              		      nfb_layer1.push(nfb_layer);
				              		      nfb_layer.setVisible(true);
		        						}
		        					else
		        						{
		        						map.removeLayer(nfb_layer1);
		        						}
		        					
		                		}//close of if		        						        			   		        		   		        		
		        	
		            },  //close of success
		            error: function(errormessage) {
		                alert(errormessage.responseText);
		            }
		        });  //close of ajax
				
	 }); //close of $.each function
				
			}			
		}
 //Onchange of chkDlc,add/remove village layer.
   $("#chkDlc").change(function (event) {		   
			 if(!$("#chkDlc").is(":checked"))
             { 				 
            	map.removeLayer(dlc_layer);
              if(dlc_layer1.length>0)
              {
            	  dlc_layer1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getAllLayerList',
				data: {
					'type': 24
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {					
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";								
							dlc_layer = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//style:dlc_style
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver',
									
								})
							});
							if (dlc_layer != null) {
								map.addLayer(dlc_layer);
								if ($("#chkDlc").is(":checked")) {
									dlc_layer.setVisible(true);
									dlc_layer1.push(dlc_layer);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(dlc_layer1.length>0)
		                                 {
	                            			 dlc_layer1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									dlc_layer.setVisible(false);
									map.removeLayer(dlc_layer);									
								}

							} else {
								AlertNotify("DLC Boundary is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
		});
 //Onchange of OSM,add/remove village layer.
   $("#chkOsm").change(function (event) {	  
			 if(!$("#chkOsm").is(":checked"))
             { 				 
            	map.removeLayer(eval(osm_raster));
              if(osm_raster1.length>0)
              {
            	  osm_raster1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getAllRasterList',
				data: {
					'type': 1
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {	
					//console.log(obj);
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";								
							osm_raster = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
							if (osm_raster != null) {								
								map.addLayer(osm_raster);
								if ($("#chkOsm").is(":checked")) {
									osm_raster.setVisible(true);
									osm_raster1.push(osm_raster);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(osm_raster1.length>0)
		                                 {
	                            			 osm_raster1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									//alert("false");
									osm_raster.setVisible(false);
									map.removeLayer(osm_raster);									
								}

							} else {
								AlertNotify("OSM is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
		});
 //Onchange of SI,add/remove village layer.
   $("#chkSi").change(function (event) {	  
			 if(!$("#chkSi").is(":checked"))
             { 				 
            	map.removeLayer(eval(si_raster));
              if(si_raster1.length>0)
              {
            	  si_raster1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getAllRasterList',
				data: {
					'type': 2
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {	
					//console.log(obj);
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";								
							si_raster = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
							if (si_raster != null) {								
								map.addLayer(si_raster);
								if ($("#chkSi").is(":checked")) {
									si_raster.setVisible(true);
									si_raster1.push(si_raster);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(si_raster1.length>0)
		                                 {
	                            			 si_raster1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									//alert("false");
									si_raster.setVisible(false);
									map.removeLayer(si_raster);									
								}

							} else {
								AlertNotify("SI is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
		});
 //Onchange of WP,add/remove village layer.
   $("#chkWp").change(function (event) {	   
			 if(!$("#chkWp").is(":checked"))
             { 				 
            	map.removeLayer(eval(wp_raster));
              if(wp_raster1.length>0)
              {
            	  wp_raster1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getAllRasterList',
				data: {
					'type': 3
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {	
					//console.log(obj);
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";								
							wp_raster = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
							if (wp_raster != null) {								
								map.addLayer(wp_raster);
								if ($("#chkWp").is(":checked")) {
									wp_raster.setVisible(true);
									wp_raster1.push(wp_raster);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(wp_raster1.length>0)
		                                 {
	                            			 wp_raster1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									//alert("false");
									wp_raster.setVisible(false);
									map.removeLayer(wp_raster);									
								}

							} else {
								AlertNotify("WP is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
		});
 
 
   
 
 //DGPS  
 $("#checkbox61").change(function (event) {	
    var points=[];
    var data; //${dgpsPillarListJson};
    
    $.ajax({
        url: 'http://localhost:8080/api/DGPSSurvey/_PartialDGPSMapView',
        data: {'fbid':1200},
        contentType: "application/json;charset=utf-8",
        type: 'GET',
        dataType: "json",
    	success:function (result) {
   	 
 		 console.log('dgps call the api: ');
 		 data=result.dgpsPillarList;
 		   $.each(data, function (a, b) {
 		       var feature=  new ol.Feature({
 		           geometry: new ol.geom.Point(ol.proj.transform([b.decLongitude,b.decLatitude], 'EPSG:4326', 'EPSG:3857')),
 		           fbid :b.mforestBlkSurveyDetail!=null ? b.mforestBlkSurveyDetail.intId:0,
 		           //plr_cd:  b.tpillarDetail!=null? b.tpillarDetail.intPkSlno:0,
 		           plr_no:((b.intSubPlrNo==0 || b.intSubPlrNo==null )?  b.intPlrNo : b.intPlrNo+"_"+b.intSubPlrNo),
 		           latitude: b.decLatitude,
 		           longitude: b.decLongitude,
 		           rtxAccuracy: b.decRtxAccuracy,
 		           /* fpic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_f_pic_name),
 		           bpic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_b_pic_name),
 		           ipic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_i_pic_name),
 		           opic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_o_pic_name), */
 		           //wpic:'${pillarPath}'+getFileNameFromURL(b.chrvDivPicName),
 		           point_type:"DGPS"
 		       }); 
 		       points.push(feature);  
 		       
 		   });
 		   
 		  console.log('after success Points data are: '+points);


 		    dgpspillarLayer = new ol.layer.Vector({
 		        source: new ol.source.Vector({
 		            features: points 
 		        }),
 		        style:function(feature, resolution){
 		                var acceptedStyle=new ol.style.Style({
 		                            image: new ol.style.Circle({
 		                            radius: 6,
 		                            stroke: new ol.style.Stroke({
 		                                color: 'white',
 		                                width: 2
 		                            }),
 		                            fill: new ol.style.Fill({
 		                                    color: 'orange'
 		                            })
 		                            }),
 		                            text: new ol.style.Text({
 		                            font: 'bold 12px Calibri,sans-serif',
 		                            fill: new ol.style.Fill({ color: '#000' }),
 		                            stroke: new ol.style.Stroke({
 		                                color: '#fff', width: 2
 		                            }),
 		                            textAlign: 'top',
 		                            textBaseline: 'bottom',
 		                            text:feature.get('plr_no').toString()
 		                            })
 		                        });
 		            var verifyStyle=new ol.style.Style({
 		                    image: new ol.style.Circle({
 		                    radius: 5,
 		                    fillOpacity: 0.4,
 		                    fill: new ol.style.Fill({color: '#14abef'}),
 		                    stroke: new ol.style.Stroke({
 		                    color: '#14abef', width: 1
 		                    })
 		                    }),
 		                    text: new ol.style.Text({
 		                    font: 'bold 12px Calibri,sans-serif',
 		                    fill: new ol.style.Fill({ color: '#000' }),
 		                    stroke: new ol.style.Stroke({
 		                        color: '#fff', width: 2
 		                    }),
 		                    textAlign: 'top',
 		                    textBaseline: 'bottom',
 		                    text:feature.get('plr_no').toString()
 		                    })
 		                });
 		            var defaultStyle=new ol.style.Style({
 		                    image: new ol.style.Circle({
 		                    radius: 5,
 		                    fillOpacity: 0.4,
 		                    fill: new ol.style.Fill({color: '#1f7a1f'}),
 		                    stroke: new ol.style.Stroke({
 		                    color: '#1f7a1f', width: 1
 		                    })
 		                    }),
 		                    text: new ol.style.Text({
 		                    font: 'bold 12px Calibri,sans-serif',
 		                    fill: new ol.style.Fill({ color: '#000' }),
 		                    stroke: new ol.style.Stroke({
 		                        color: '#fff', width: 2
 		                    }),
 		                    textAlign: 'top',
 		                    textBaseline: 'bottom',
 		                    text:feature.get('plr_no').toString()
 		                    })
 		                });
 		            if(true)
 		            {
 		                return [acceptedStyle];
 		            } 
 		            else
 		            {
 		                return [acceptedStyle];
 		            }
 		        }
 		    });
 		  
 		   if(dgpspillarLayer!=null)
 		  	{   
 		    	try{
 		    		map.addLayer(dgpspillarLayer);
 		    	      dgpspillarLayer.setVisible(true);
 		    	}catch(error){
 		    		alert(error);
 		    	}	
 		      
 		  	} 
 		    else{
 		    	alert('dgpspillarLayer is null');
 		    }
   	 	
    }
    ,error:function (xhr, status) {
        alert(status);
    }
    
    });

    

 
 });
    
  //end of DGPS Point
 
 
 
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
