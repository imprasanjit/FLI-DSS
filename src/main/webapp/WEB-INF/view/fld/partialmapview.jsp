<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<tl:eval expression="@environment.getProperty('api.geoserverurl')" var="geoserverUrl"></tl:eval>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css" type="text/css">
	<script src="https://unpkg.com/elm-pep"></script>
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <script src="https://cdn.polyfill.io/v3/polyfill.min.js?features=fetch,requestAnimationFrame,Element.prototype.classList,URL,TextDecoder"></script>
    <script src="https://unpkg.com/dom-to-image-more@2.8.0/dist/dom-to-image-more.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script src="https://unpkg.com/elm-pep"></script>

 <style>
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
<div class="widget-content widget-content-area" id="mapFullscreen">
					<div class="map-topbar">
					<a href="javascript:void(0)" onclick="openFullscreen();"
							class="btn btn-sm btn-info" role="button"
							data-toggle="collapse" title="Toggle fullscreen">					
						<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-maximize">
								<path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3"></path></svg>
					</a>
                        <button type="submit" class="btn btn-sm btn-info" id="btnZoom" title="Zoom In"><i class="fa fa-search-plus font-16"></i></button>
                        <button type="submit" class="btn btn-sm btn-info" id="btnZoomout" title="Zoom Out"><i class="fa fa-search-minus font-16"></i></button>
                        <!-- <button type="submit" class="btn btn-custom btn-secondary" id="btnmeasurePan" title="Pan"><img src="/assets/img/zoom/icon-pan.png" alt="pan"></button> -->
                       <!--  <button type="submit" class="btn btn-custom btn-secondary" id="btnmeasureLength" title="Length"><img src="/assets/img/zoom/icon-length.png" alt="pan"></button>
                        <button type="submit" class="btn btn-custom btn-secondary mr-3" id="btnmeasureArea" title="Area"><img src="/assets/img/zoom/icon-area.png" alt="pan"></button> -->
                    </div>
<div class="mapFilterBase col-md-3 col-sm-6 col-xs-12">
                                    <div id="accordion" class="mapFilter">
                                        <div class="map-tab-fix row m-0">
                                            <!-- <a id="" href="#collapseOne" class="text-dark col collapsed bs-tooltip" data-toggle="collapse" aria-expanded="true" aria-controls="collapseOne" title="Filter">
                                                <span class="d-block"><img src="/assets/img/icon-filter.png"></span>
                                            </a> -->

                                            <a id="a_layer" href="#collapseTwo" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="true" aria-controls="collapseTwo" title="Layers">
                                                <span class="d-block"><img src="/assets/img/icon-layers.png"></span>
                                            </a>
                                            <a id="a_legend" href="#collapseThree" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseThree" title="Legends">
                                                <span class="d-block"><img src="/assets/img/icon-legends.png"></span>
                                            </a>
                                            <a id="a_basemap" href="#collapseFour" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseFour" title="Basemap">
                                                <span class="d-block"><img src="/assets/img/icon-basemap.png"></span>
                                            </a>
                                            <a id="a_measure" href="#collapseFive" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseFive" title="Measurement">
                                                <span class="d-block"><img src="/assets/img/icon-measurement.png"></span>
                                             </a>
                                           <!--   <a id="a_info" href="#collapseSix" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseSix" title="Info">
                                                <span class="d-block"><img src="/assets/img/icon-info.png"></span>
                                            </a>

                                            <a id="a_reset" href="#collapseSeven" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseSeven" title="Reset">
                                                <span class="d-block"><img src="/assets/img/icon-reset.png"></span>
                                            </a>
                                            <a id="" href="#collapseEight" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseEight" title="Print">
                                                <span class="d-block"><img src="/assets/img/icon-print.png"></span>
                                            </a> -->
                                        </div>										
                                        <div class="clearfix"></div>
                                        <div class="mb-0">
                                            <div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordion">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="fixHeightRight">
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><span aria-hidden="true">x</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Layers</h6>
                                                                
                                                                <div id="accordion2">
                                                                    <a id="" href="#collapse1" class="collapsed" data-toggle="collapse" aria-expanded="true" aria-controls="collapse1">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-3">Administrartive Boundary<i class="fa fa-angle-down pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse1" class="collapse show" aria-labelledby="heading1" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" checked id="chkstateboundarylayer" onclick="viewLayer(this,'stateboundarylayer')">
                                                                                        <label class="custom-control-label" for="chkstateboundarylayer">State Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2"> 
                                                                                        <input type="checkbox" class="custom-control-input" id="chkdistrictboundarylayer" onclick="viewLayer(this,'districtboundarylayer')">  
                                                                                        <label class="custom-control-label" for="chkdistrictboundarylayer">District Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkalldivboundarylayer" onclick="viewLayer(this,'alldivboundarylayer')">
                                                                                        <label class="custom-control-label" for="chkalldivboundarylayer">Division Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2" id="divRange" >
                                                                                        <input type="checkbox" class="custom-control-input" id="chkallrnglayer" onclick="viewLayer(this,'allrnglayer')">
                                                                                        <label class="custom-control-label" for="chkallrnglayer">Range Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2" id="divTehsil" >
                                                                                        <input type="checkbox" class="custom-control-input" id="chktahasil_layer"  onclick="viewLayer(this,'tahasil_layer')">
                                                                                        <!-- onclick="viewLayer(this,'tahasil_layer')" -->
                                                                                        <label class="custom-control-label" for="chktahasil_layer">Tahasil Boundary</label>
                                                                                    </div> 
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2" id="divVillage" onclick="viewLayer(this,'village_layer')">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkvillage_layer" >
                                                                                        <!-- onclick="viewLayer(this,'village_layer')" -->
                                                                                        <label class="custom-control-label" for="chkvillage_layer">Village Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2" id="divCMV" >
                                                                                        <input type="checkbox" class="custom-control-input" id="chkcmv_layer" onclick="viewLayer(this,'cmv_layer')">
                                                                                        <label class="custom-control-label" for="chkcmv_layer">Notified Forest(CMV)</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2" id="divRev" >
                                                                                        <input type="checkbox" class="custom-control-input" id="chkrf_layer" onclick="viewLayer(this,'rf_layer')">
                                                                                        <label class="custom-control-label" for="chkrf_layer">Revenue Forest</label>
                                                                                    </div>
                                                                                     <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2" id="divDLC" >
                                                                                        <input type="checkbox" class="custom-control-input" id="chkdlc_layer" onclick="viewLayer(this,'dlc_layer')">
                                                                                        <label class="custom-control-label" for="chkdlc_layer">DLC Forest</label>
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
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree"><span aria-hidden="true">x</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Legends</h6> 
                                                                <div class="row">
                                                                    <div class="col-md-12 ml-1">     
                                                                        <div class="legendbox" id="stateboundarylayer_legend">
                                                                            <img src="/assets/img/state_boundary.png">
                                                                            <span>State Boundary</span> 
                                                                        </div>
                                                                        <div class="legendbox" id="districtboundarylayer_legend">
                                                                            <img src="/assets/img/district_boundary.png">
                                                                            <span>District Boundary</span>
                                                                        </div>
                                                                        <div class="legendbox" id="alldivboundarylayer_legend">
                                                                            <img src="/assets/img/division_boundary.png">
                                                                            <span>Division Boundary</span>
                                                                        </div>
                                                                        <div class="legendbox" id="allrnglayer_legend">
                                                                            <img src="/assets/img/range_boundary.png">
                                                                            <span>Range Boundary</span>
                                                                        </div>
                                                                        <div class="legendbox" id="tahasil_layer_legend">
                                                                            <img src="/assets/img/legend-04.png">
                                                                            <span>Tahasil Boundary</span>
                                                                        </div>
                                                                        <div class="legendbox" id="cmv_layer_legend">
                                                                            <img src="/assets/img/selected_FB.png">
                                                                            <span>Notified Forest Block</span>
                                                                        </div>
                                                                         <div class="legendbox" id="cmv_layer_adj_legend">
                                                                            <img src="/assets/img/notified_forest_FB_layer.png">
                                                                            <span>Adjacent Forest Block</span>
                                                                        </div>
                                                                        <div class="legendbox" id="village_layer_legend">
                                                                            <img src="/assets/img/village_boundary.png">
                                                                            <span>Village Boundary</span>
                                                                        </div>
                                                                        <div class="legendbox" id="rf_layer_legend">
                                                                            <img src="/assets/img/selected_FB.png">
                                                                            <span>Revenue Forest</span>
                                                                        </div>
                                                                        <div class="legendbox" id="dlc_layer_legend">
                                                                            <img src="/assets/img/legend-05.png">
                                                                            <span>DLC Forest</span>
                                                                        </div>
                                                                         <div class="legendbox" id="rf_layer_adj_legend">
                                                                            <img src="/assets/img/legend-03.png">
                                                                            <span>Adjacent Forest Plot</span>
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
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour"><span aria-hidden="true">x</span></button>
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
																				<a id="imagery_basemap"  class="basebox"><img src="/assets/img/icon-imagery.png"><h6>Imagery</h6></a>
																	    		</li>
																	    		<li>
																	    			<a id="street_basemap" class="basebox"><img src="/assets/img/icon-street.png"><h6>Street</h6></a>
																	    		</li>
																	    		<li>
																	    			<a id="osm_basemap" class="basebox"><img src="/assets/img/icon-osm.png" ><h6>OSM</h6></a>
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
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">x</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Measurement</h6>
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                             <div class="row">
																		   <div class="col-md-4 mt-2">
																					 <label for="type" class="font-12 pt-2">Measurement</label>
														                    </div>
														                    <div class="col-md-8 mt-2">
														                    <select id="type" class="form-control form-control-sm custom-adj mb-2">
														                    <option selected="selected">-- Select Type --</option>
																	        <option value="length">Length (LineString)</option>
																	        <option value="area">Area (Polygon)</option>
																	      </select>
																	      <button id="btnReset" type="button" class="btn btn-sm btn-warning">Reset</button>
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
										<!-- <div class="mb-0">
                                            <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordion">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="fixHeightRight">
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">x</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Info</h6>
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                            <div class="row">
																		   <div class="col-md-4 mt-2">
																					<label>Active Layer</label>
														                    </div>
														                    <div class="col-md-8 mt-2">
														                    <select id="ddlActiveLayer" class="form-control custom-adj">
																					
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
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseEight" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">x</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Export Map</h6>
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                            	<div class="row">
																			   <div class="col-md-6 mt-2">
																						<button type="button" id="btnExportpdf"  class="btn" data-toggle="modal" data-target="#printModal">Export PDF</button>
															                    </div>
															                    <div class="col-md-6 mt-2">
															                    <button type="button" id="btnExportImage" class="btn" class="btn" data-toggle="modal" data-target="#imgprintModal">Export Image</button>
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
                                        </div> -->
                                    </div><!--/accordion-->
                    
                                </div>
								
                                <div id="map" class="fixHeightLeft panel">
                                  
                                </div>                                

                            </div>
                            
<!-- Map View div -->
<div id="popup" class="ol-popup">
    <a href="#" id="popup-closer" class="ol-popup-closer"></a>
    <div id="popup-content"></div>
</div>
<div id="map" class="fixHeightLeft2" height="100%" width="100%">
</div>
<!--End Map View div -->
<script type="text/javascript">

var stateboundarylayer,districtboundarylayer,alldivboundarylayer,allrnglayer,cmv_layer,cql_query,
plot_layer,dlc_layer,rf_layer,village_layer,tahasil_layer,tahasil_layer1,highlightOverlay;
tahasil_layer1=[];
var  layerOrderList=[
	{"layer":"plot_layer", "visibility":0,"minz":12,"maxz":18},
	{"layer":"dlc_layer", "visibility":0,"minz":10.17,"maxz":18.27},
	{"layer":"rf_layer", "visibility":0,"minz":9.17,"maxz":20.27},
	{"layer":"cmv_layer", "visibility":0,"minz":10.17,"maxz":14.27},
	{"layer":"village_layer", "visibility":0,"minz":5.17,"maxz":14},
	{"layer":"allrnglayer", "visibility":0,"minz":9.34,"maxz":11.01},
	{"layer":"tahasil_layer", "visibility":0,"minz":9,"maxz":13},
	{"layer":"alldivboundarylayer", "visibility":0,"minz":6.5,"maxz":11.68},
	{"layer":"districtboundarylayer", "visibility":0,"minz":6.4,"maxz":11.4},
	{"layer":"stateboundarylayer", "visibility":1,"minz":5.90,"maxz":8.18},
	{"layer":"highlightOverlay", "visibility":1,"minz":5.90,"maxz":18}];
	
try{
	
stateboundarylayer = new ol.layer.Image({
	source: new ol.source.ImageWMS({
    url: '${geoserverUrl}/CDLTP_State_District/wms',
    params: { 
    	'LAYERS': 'CDLTP_State_District:StateBoundary',    
    	'VERSION': '1.1.0'    
    },
    serverType: 'geoserver',
    visible:true,
    crossOrigin: 'anonymous',
    /* minResolution: 2482482,
    maxResolution: 8849780, */
    
})
});
}catch(error){}

try{
districtboundarylayer = new ol.layer.Image({
source: new ol.source.ImageWMS({
	 url: '${geoserverUrl}/FLI_DSS_DISTRICT/wms',
     params: {
     'LAYERS': 'FLI_DSS_DISTRICT:DistrictBoundary',
     'VERSION': '1.1.0'     
     },
    serverType: 'geoserver',
    crossOrigin: 'anonymous'
    
}),
visible:false
});
}catch(error){}

try{
alldivboundarylayer = new ol.layer.Image({
source: new ol.source.ImageWMS({
	url: '${geoserverUrl}/FLI_DSS_DIVISION/wms',
    params: {
    'LAYERS': 'FLI_DSS_DIVISION:Division',
    'VERSION': '1.1.0'
    //'CQL_FILTER':cql_query,
    },
    serverType: 'geoserver',
    crossOrigin: 'anonymous'
    
}),
visible:true
});
}catch(error){}

try{
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
}catch(error){}
/* //All Tahasil Layer
tahasil_layer  = new ol.layer.Image({
    source: new ol.source.ImageWMS({
    url: 'http://192.168.1.11:8080/CDLTP_ALL_TEHSIL/wms',
    params: {
    'LAYERS': 'CDLTP_ALL_TEHSIL:All_Tehesil_boundary',
    'VERSION': '1.1.0',
    },
    serverType: 'geoserver',
    	crossOrigin: 'anonymous'
}),
visible:false
});
//All Village Layer
village_layer  = new ol.layer.Image({
    source: new ol.source.ImageWMS({
    url: 'http://192.168.1.11:8080/CDLTP_ALL_TEHSIL/wms',
    params: {
    'LAYERS': 'CDLTP_ALL_TEHSIL:All_Tehesil_boundary',
    'VERSION': '1.1.0',
    },
    serverType: 'geoserver',
    	crossOrigin: 'anonymous'
}),
visible:false
}); */
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
 highlightOverlay =  new ol.layer.Vector({
  // style: (customize your highlight style here),
  source: source,
});
var selectClick = new ol.interaction.Select({
	  /* condition: new ol.events.condition.click, */
	});
var map = new ol.Map({
    layers: [baselayer,raster,googleLayerStreet,googleLayerSatellite,measureLayer,allrnglayer,alldivboundarylayer,districtboundarylayer,stateboundarylayer,highlightOverlay],
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
        zoom: 6.5,
        maxZoom: 20,
        minZoom: 5
    })
});
map.addInteraction(selectClick);

visibleLayer();
zoomtoLayer();


function viewLayer(checkbox,layerName)
{
	
	try{
	//console.log(map.getView().getZoom());
	if ($(checkbox).prop("checked") == true) {
		   updateLayerOrder(layerName,1);
		   //console.log(layerName);
	}else{
		updateLayerOrder(layerName,0);
	}
	
	for(var i=0;i<layerOrderList.length;i++)
	   {
		$("#"+layerName+"_legend").hide();
		if(eval(layerOrderList[i].layer)!= "undefined")
			{
			//console.log(layerOrderList[i].layer);
			if(layerOrderList[i].layer=="tahasil_layer")
			{
				if(tahasil_layer1.length>0)
                {
           		 tahasil_layer1.forEach(function(item){
           			 map.removeLayer(item);
           			 //console.log(item);
                    });
                }
				else
				{
				map.removeLayer(eval(layerOrderList[i].layer));
				}
			}
			else
				{
				map.removeLayer(eval(layerOrderList[i].layer));
				}
			//map.removeLayer(eval(layerOrderList[i].layer));
			if(layerOrderList[i].visibility==1)
			{
				//console.log(layerOrderList[i].layer);
			if(layerOrderList[i].layer=="tahasil_layer")
			{
				if(tahasil_layer1.length>0)
                {
           		 tahasil_layer1.forEach(function(item){
           			 map.addLayer(item);   
                    });
                }
				else
				{
				map.addLayer(eval(layerOrderList[i].layer));
				}
			}
			else{
				map.addLayer(eval(layerOrderList[i].layer));
			}
			//	map.addLayer(eval(layerOrderList[i].layer));
				
				if(map.getView().getZoom()>=layerOrderList[i].minz && map.getView().getZoom()<=layerOrderList[i].maxz)
					{
					//console.log(layerOrderList[i].layer);
					eval(layerOrderList[i].layer).setVisible(true);
					
					$("#"+layerName+"_legend").show();
						if(layerName=="cmv_layer" || layerName=="rf_layer" || layerName=="dlc_layer")
						{
							$("#"+layerName+"_adj_legend").show();
							//console.log(layerName);
						}
						if($("#chk"+layerName).hasClass("chkColor")){
							$("#chk"+layerName).removeClass("chkColor");
						}
						/* 
						if(!$("#chk"+layerName).hasClass("custom-control-input")){
							$("#chk"+layerName).addClass("custom-control-input");
						} */
						
					}
				else
					{
					eval(layerOrderList[i].layer).setVisible(false);
					$("#chk"+layerName).addClass("chkColor");
					if(!$("#chk"+layerName).hasClass("chkColor")){
						$("#chk"+layerName).addClass("chkColor");
					}
					
					/* if($("#chk"+layerName).hasClass("custom-control-input")){
						$("#chk"+layerName).removeClass("custom-control-input");
					} */
					}
				
				   
				}
			}
		
	   } 
	}catch(error){}
}



map.getView().on('change:resolution', function() {
	$(".legendbox").hide();
	for(var i=0;i<layerOrderList.length;i++)
	   {
		
		if(eval(layerOrderList[i].layer)!= "undefined")
			{
			if(layerOrderList[i].visibility==1)
				{
				if(map.getView().getZoom()>=layerOrderList[i].minz && map.getView().getZoom()<=layerOrderList[i].maxz)
					{
					//#bbd8f7;
					eval(layerOrderList[i].layer).setVisible(true);
					//console.log(layerOrderList[i].layer);
					$("#"+layerOrderList[i].layer+"_legend").show();
					
					if(layerOrderList[i].layer=="cmv_layer" || layerOrderList[i].layer=="rf_layer" || layerOrderList[i].layer=="dlc_layer")
					{
						$("#"+layerOrderList[i].layer+"_adj_legend").show();
						//console.log(layerOrderList[i].layer);
					}
					if($("#chk"+layerOrderList[i].layer).hasClass("chkColor")){
					//		$("#chk"+layerOrderList[i].layer).removeClass("chkColor");
					}
					
					/* if(!$("#chk"+layerOrderList[i].layer).hasClass("custom-control-input")){
						$("#chk"+layerOrderList[i].layer).addClass("custom-control-input");
					} */
					}
				else
					{
					eval(layerOrderList[i].layer).setVisible(false);
					if(!$("#chk"+layerOrderList[i].layer).hasClass("chkColor")){
					//	$("#chk"+layerOrderList[i].layer).addClass("chkColor");
						$("#chk"+layerOrderList[i].layer).css('background-color','#FF0000');
					}
					
					/* if($("#chk"+layerOrderList[i].layer).hasClass("custom-control-input")){
						$("#chk"+layerOrderList[i].layer).removeClass("custom-control-input");
					} */
					}   
				}
			}
		
	   }
});
function updateLayerOrder(layerName, status)
{
	for(var i=0;i<layerOrderList.length;i++)
	   {
		var obj=layerOrderList[i];
		if(obj.layer==layerName)
			{
				obj.visibility=status;
			}
	   }
}

function visibleLayer()
{
	$(".legendbox").hide();
	/* $("#stateboundarylayer_legend").show(); */
	// divRange divVillage divCMV divRev divDLC
	if($("#drpfltype").val()=="1")
		{
			$("#divTehsil").hide();
			$("#divVillage").hide();
			$("#divRev").hide();
			$("#divDLC").hide();
			
			if($("#drpdistDivList").val()==2)
			{
				updateLayerOrder("alldivboundarylayer",1);
				$('input[type="checkbox"][id="chkalldivboundarylayer"]').prop("checked", true);
				$("#alldivboundarylayer_legend").show();
			}
			else
				{
				updateLayerOrder("districtboundarylayer",1);
				$('input[type="checkbox"][id="chkdistrictboundarylayer"]').prop("checked", true);
				$("#districtboundarylayer_legend").show();
				}
			updateLayerOrder("cmv_layer",1);
			$('input[type="checkbox"][id="chkcmv_layer"]').prop("checked", true).trigger("change");
			$("#cmv_layer_legend").show();
		}
	else if($("#drpfltype").val()=="2")
		{
		$("#divRange").hide();
		$("#divCMV").hide();
		$("#divDLC").hide();
		if($("#drpdistDivList").val()==2)
		{
			updateLayerOrder("alldivboundarylayer",1);
			$('input[type="checkbox"][id="chkalldivboundarylayer"]').prop("checked", true);
			$("#alldivboundarylayer_legend").show();
		}
		else{
			updateLayerOrder("districtboundarylayer",1);
			$('input[type="checkbox"][id="chkdistrictboundarylayer"]').prop("checked", true);
			$("#districtboundarylayer_legend").show();
		}
		updateLayerOrder("rf_layer",1);
		$('input[type="checkbox"][id="chkrf_layer"]').prop("checked", true).change();
		$("#rf_layer_legend").show();
	  }
	else
	{
		$("#divRange").hide();
		$("#divCMV").hide();
		$("#divRev").hide();
		if($("#drpdistDivList").val()==2)
		{
			updateLayerOrder("alldivboundarylayer",1);
			$('input[type="checkbox"][id="chkalldivboundarylayer"]').prop("checked", true);
			$("#alldivboundarylayer_legend").show();
		}
		else{
			updateLayerOrder("districtboundarylayer",1);
			$('input[type="checkbox"][id="chkdistrictboundarylayer"]').prop("checked", true);
			$("#districtboundarylayer_legend").show();
		}
		updateLayerOrder("dlc_layer",1);
		$('input[type="checkbox"][id="chkdlc_layer"]').prop("checked", true).change();
		$("#dlc_layer_legend").show();
	  }
		updateLayerOrder("tahasil_layer",1);
		$('input[type="checkbox"][id="chktahasil_layer"]').prop("checked", true).change();
		$("#tahasil_layer_legend").show();
	}
/* 	if($("#drpdistDivList").val()==2)
		{
		
		
		$('input[type="checkbox"][id="chkDivision"]').prop("checked", true);
		$('input[type="checkbox"][id="chkCMV"]').prop("checked", true).trigger("change");
		$("#alldivboundarylayer_legend").show();
		$("#cmv_layer_legend").show();
		
		}
	else
		{
		updateLayerOrder("districtboundarylayer",1);
		updateLayerOrder("rf_layer",1);
		$('input[type="checkbox"][id="chkDistrict"]').prop("checked", true);
		$('input[type="checkbox"][id="chkRFFinal"]').prop("checked", true).change();
		$("#districtboundarylayer_legend").show();
		$("#rf_layer_legend").show();
		} */

function zoomtoLayer()
{
	if($("#drpfltype").val()=="1"){
		var jsonObj = {};
		var arr=[];
		var cmvList=${layer};
		cmvList.forEach(function(data) 
		    {
			var jsonData = {};
		        jsonData["geometry"] =JSON.parse(data.geom);
		       	jsonData["type"]="Feature";
		     let cmvProp = JSON.parse(JSON.stringify(data))
		      delete cmvProp['geom'];
		      jsonData["properties"]=cmvProp;
      		jsonData["properties"]=cmvProp;
		      
			  arr.push(jsonData);
		    });
		jsonObj["features"]=arr;
			jsonObj["type"]="FeatureCollection";
			var _myStroke = new ol.style.Stroke({
			   color : 'rgba(255,0,0,1.0)',
			   width : 1    
			});
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
 		
	        cmv_layer = new ol.layer.Vector({
	    	  source: vectorSource,
	    	 style:nfb_style
	        ,
	    	  });
 			viewLayer($("input[id='chkcmv_layer']"), "cmv_layer");
	      cmv_layer.setVisible(true);
	   map.getView().fit(cmv_layer.getSource().getExtent(), (map.getSize()));
	}
	else if($("#drpfltype").val()=="2"){
		var rfList=${layer};
		//console.log(rfList);
		if(rfList!=null) {
			addRFLayer(rfList);
		}
	}
	else if($("#drpfltype").val()=="3"){
		var dlcList=${layer};
		//console.log(dlcList[0]);
		if(dlcList!=null) {
			addDLCLayer(dlcList);
		}
	}
	
}
function addRFLayer(rfList)
{
	var village_code="${village_code}";
	var layerquery="(land_class='Govt. Forest' OR land_class='Private Forest') and vill_code='"+village_code+"' ";
	if(rfList.length>0) {
		var url=rfList[0].chrvGlink+'?service=WFS&version=1.0.0&request=GetFeature&typeName='+rfList[0].chrvStrLayerNm+'&maxFeatures=1000&outputFormat=application%2Fjson&CQL_FILTER='+layerquery;
		ol.proj.proj4.register(proj4);
		//console.log(rfList[0].chrvStrLayerNm);
		var features;
		jQuery.getJSON(url, function(data) {
		  features = new ol.format.GeoJSON().readFeatures( data,{
    	      dataProjection: new ol.proj.get('EPSG:32645') || new ol.proj.get('EPSG:32644'),
    	      featureProjection: new ol.proj.get('EPSG:3857')
    	    } );    
		if(features.length>0)
			{
			var vectorSource = new ol.source.Vector({
				features:features,
	            wrapX: false,
	            });

	            rf_layer = new ol.layer.Vector({
	            source: vectorSource,
	            style:rf_style,
	            });
			
	            map.addLayer(rf_layer);
	            viewLayer($("input[id='chkrf_layer']"), "rf_layer");
	            rf_layer.setVisible(true);
	            map.getView().fit(rf_layer.getSource().getExtent(), (map.getSize()));
			}
		else{
			if(rfList.length==0)
				{
				alert("Feature Layer is not found");
				return;
				}
			rfList.shift();
       		addRFLayer(rfList);
		}
		
		});   
         
	}
}
function addDLCLayer(dlcList)
{
	var village_code="${village_code}";
	var layerquery="(land_class='Govt. Forest' OR land_class='Private Forest') and vill_code='"+village_code+"' ";
	if(dlcList.length>0) {
		var url=dlcList[0].chrvGlink+'?service=WFS&version=1.0.0&request=GetFeature&typeName='+dlcList[0].chrvStrLayerNm+'&maxFeatures=1000&outputFormat=application%2Fjson&CQL_FILTER='+layerquery;
		
		//console.log('DLC Url: '+url);
		ol.proj.proj4.register(proj4);
		console.log(dlcList[0].chrvStrLayerNm);
		var features;
		jQuery.getJSON(url, function(data) {
		  features = new ol.format.GeoJSON().readFeatures( data,{
    	      dataProjection: new ol.proj.get('EPSG:32645') || new ol.proj.get('EPSG:32644'),
    	      featureProjection: new ol.proj.get('EPSG:3857')
    	    } );    
		if(features.length>0)
			{
			var vectorSource = new ol.source.Vector({
				features:features,
	            wrapX: false,
	            });

				dlc_layer = new ol.layer.Vector({
	            source: vectorSource,
	            style:dlc_style,
	            });
			
	            map.addLayer(dlc_layer);
	            viewLayer($("input[id='chkdlc_layer']"), "dlc_layer");
	            dlc_layer.setVisible(true);
	            map.getView().fit(dlc_layer.getSource().getExtent(), (map.getSize()));
			}
		else{
			if(dlcList.length==0)
				{
				alert("DLC Layer is not found");
				return;
				}
			dlcList.shift();
			addDLCLayer(dlcList);
		}
		
		});   
         
	}
}
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
			   // helpTooltipElement.parentNode.removeChild(helpTooltipElement);
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
			   // measureTooltipElement.parentNode.removeChild(measureTooltipElement);
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
			 $("#btnReset").click(function () {
				// map.removeOverlay(helpTooltip);
				 //map.removeOverlay(measureTooltip);
				  $("div.measure_tooltip").remove();
	            // map.removeInteraction(draw);
	             measureLayer.getSource().clear(); 
			 });
			//click Tehsil Boundary   
			$(document).ready(function() {
			    //$("#chktahasil_layer").change(function (event) { 
						  /*  if(!$("#chktahasil_layer").is(":checked"))
			               { 
				              	tahasil_layer.setVisible(false);
				              	//map.removeLayer(eval(tahasil_layer));
				                if(tahasil_layer1.length>0)
				                {
				                	tahasil_layer1.forEach(function(item){
				                        map.removeLayer(item);
				                    });
				                }
			               } */
			              /*  else
			               { */
			            	  if($('#distId').val()!=0 || $('#distId').val()!="" || $('#divId').val()!=0 || $('#divId').val()!="")
				 		      {	
					    		
			            		var paramdist = ($("#drpdistDivList").val() == 1 ? $("#distId").val() : 0);
			      				var paramdivision = ($("#drpdistDivList").val() == 2 ? $("#divId").val() : 0);
			      				//var paramtahasil=$("#drpTehList").val();				
					    		$.ajax({	    			
					    			url:'/Utility/getDivisionVectorMapTypeLayerList',
					    			data: {'distid': paramdist,'divid': paramdivision,'type':19},
						            type: "GET",
						            contentType: "application/json;charset=utf-8",
						            dataType: "json",
						            success :function (obj) {	
						            	//console.log(obj);
						                    if(obj!=null)
						                    {	
						                        var myStringArray = obj;
						                    	var arrayLength = obj.length;	
						                		for (var i = 0; i < arrayLength; i++) {  
						                    	tehLayernm=obj[i].text;
						                    	
					                             if($("#drpTehList").val()!="")
					                             {
					                                var query="tah_id="+$( "#drpTehList option:selected" ).val();
		
					                                 if(obj[i].value==$("#drpTehList option:selected" ).val()){
					                                  	 tahasil_layer= new ol.layer.Image({
						                                     source: new ol.source.ImageWMS({
						                                     url: obj[i].strValue,
						                                     params: {
						                                     'LAYERS': tehLayernm,
						                                     'VERSION': '1.1.0',
						                                     'CQL_FILTER': query     
						                                     },
						                                     serverType: 'geoserver'
						                                     })  
						                             });
					                                  	map.addLayer(tahasil_layer);
					                                  	if($("#chktahasil_layer").is(":checked"))
					                                  		{
					                                  		tahasil_layer.setVisible(true);
					                                  		}
						                            	
					                                  	 break;
					                                 }
					                                 
					                             }   
					                             else
					                             {
					                            	 tahasil_layer= new ol.layer.Image({
					                                     source: new ol.source.ImageWMS({
					                                     url: obj[i].strValue,
					                                     params: {
					                                     'LAYERS':tehLayernm,
					                                     'VERSION': '1.1.0'     
					                                     },
					                                     serverType: 'geoserver'
					                                     })  
					                             });
					                            	 tahasil_layer1.push(tahasil_layer);
					                            	 //console.log(i);
					                            	 //console.log(arrayLength-1);
					                            	 if(i==arrayLength-1){
					                            		 if(tahasil_layer1.length>0)
						                                 {
						                            		 tahasil_layer1.forEach(function(item){
						                            			 map.addLayer(item);
						                            			 if($("#chktahasil_layer").is(":checked"))
						                            				 {
						                            				 	item.setVisible(true);
						                            				 }
						                                         
						                                     });
						                                     
						                                 }
					                            	 }
					                            	
					                             }
						                    	} 
				                            }
				                            else
				                            {
				                                AlertNotify("Tahasil Boundary of "+$( "#drpTehList option:selected" ).text()+" tahasil is not available.")
				                            }
					                },
					            
						            error :function (xhr, status) 
						            {
						                    
						            }
						            });
					 			}
							    else
							    {
							    	viewNotification(2);
									return false;
							        //alert('Select division or  district.');
							    }
		          			//}
				 		}); 
 		
 		
		 //click Village Boundary
		  //$(document).ready(function() {
		   $("#chkvillage_layer").change(function (event) {
			   if(!$("#chkvillage_layer").is(":checked"))
               {
              	 village_layer.setVisible(false);
               }
               else
               {
				   if($('#distId').val()!=0 || $('#distId').val()!="" || $('#divId').val()!=0 || $('#divId').val()!="")
		    		{
			    		map.removeLayer(village_layer);
			    		var paramdist = ($("#drpdistDivList").val() == 1 ? $("#distId").val() : 0);
	    				var paramdivision = ($("#drpdistDivList").val() == 2 ? $("#divId").val() : 0);
	    				//var paramtahasil=($("#drpTehList").val()==""|| $("#drpTehList").val()==null)?0:$("#drpTehList").val();
	    				villLayernm="";
			    		//alert(paramdist);
			    		$.ajax({
				           	url:'/Utility/getDivisionVectorMapTypeLayerList',
				            data: {'distid': paramdist,'divid': paramdivision,'type':14},
				            type: "GET",
				            contentType: "application/json;charset=utf-8",
				            dataType: "json",
				            success :function (obj) {
				                    //console.log(obj);
				                    //console.log(obj.text);
				                    if(obj!=null)
				                    {	
				                    	villLayernm=obj[0].text;
				                    	
				                    	 var query="";
			                             if($("#drpTehList").val()!="")
			                             {
			                                 //query="tahasil="+"'"+$( "#drpTehList option:selected" ).text()+"'";
			                                query="tah_id="+$( "#drpTehList option:selected" ).val();
			                                 //console.log(query);
			                             }
				                             if(query!="")
				                             {
				                            	
				                            	 //console.log(query);
				                            	 
				                            	 village_layer= new ol.layer.Image({
				                                     source: new ol.source.ImageWMS({
				                                     url: obj[0].strValue,
				                                     params: {
				                                     'LAYERS': obj[0].text,
				                                     'VERSION': '1.1.0',
				                                     'CQL_FILTER': query     
				                                     },
				                                     serverType: 'geoserver'
				                                     })  
				                             });
			                             }
			                             else{
			                            	 village_layer= new ol.layer.Image({
			                                     source: new ol.source.ImageWMS({
			                                     url: obj[0].strValue,
			                                     params: {
			                                     'LAYERS': obj[0].text,
			                                     'VERSION': '1.1.0'     
			                                     },
			                                     serverType: 'geoserver'
			                                     })  
			                             });
			                             }
			                            //console.log(tahasil_layer);
			                            if(village_layer!=null)
			                            {
				                              map.addLayer(village_layer);
				                             /* if($("#chkvillage_layer").is(":checked"))
				                             {
				                            	 village_layer.setVisible(true);
				                             }
				                             else
				                             {
				                                  village_layer.setVisible(false);
				                             } */
			                                 
			                            }
			                            else{
			                                AlertNotify("Village Boundary of "+$( "#drpTehList option:selected" ).text()+" tahasil is not available.")
			                            }
				                    }
				                    
				                },
				            error :function (xhr, status) 
				            {
				                    
				            }
				            });
		    		}
				    else
				    {
				    	viewNotification(2);
						return false;
				        //alert('Select division or  district.');
				    }
                }
			 }); 
		 
			
			 //overlay
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
		            overlay.setPosition(undefined);
		            closer.blur();
		            return false;
		        };

		        
		        var activeTabL;
		        $('#a_measure').click(function(){
		        	//alert("measure");
		        	activeTabL="measurementTab";
		        });
				$('#a_layer').click(function(){
					//alert("layer");
		        	activeTabL="layerTab";
		        });
				$(document).ready(function(){
					activeTabL="layerTab";
				});
			 //map onclick event
             map.on('click', function(evt) {
            	/* if($(this).attr('id')=="a_measure")
            	{  */
	                 content.innerHTML = '';
	                 var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature, layer) {
	                     return feature;
	                 });     
	                 if (feature) {
	                	 //console.log(feature);
	                     var coord = feature.getGeometry().getCoordinates();
	                     var props = feature.getProperties();
	                    // console.log(props);	              
	                    if(activeTabL == "layerTab")
	                    {
		                     if($("#drpfltype").val()=="1")
		                   	 {
		                     	//https://odishaforestlandsurvey.in
			                     //http://14.98.253.212/sltp
			                     var report="https://odishaforestlandsurvey.in/FRJVC_Certified_Reports/"+props.range_code+"-"+props.fb_id+"-JVR.pdf";
			                   	 content.innerHTML = "<h5>NFB Details</h5>"
			                            +"<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr><td><strong>Division :</strong></td><td>"+props.division_name+"</td></tr>"
			                            +"<tr><td><strong>Range :</strong></td><td>"+props.range_name+"</td></tr>"
			                            +"<tr><td><strong>Forest Block :</strong></td><td>"+props.fb_name+"</td></tr>"
			                            +"<tr><td><strong>CMV Area(Sq KM) :</strong></td><td>"+props.area_sqkm+"</td></tr>"
			                            +"<tr><td><strong>CMV Perimeter :</strong></td><td>"+props.perimeter+"</td></tr>"
			                            +"<tr><td><strong>FRJVC Report :</strong></td><td><a href='"+report+"' target='_blank'><span>View</span></a></td></tr></table></div>";
			                   	overlay.setPosition(evt.coordinate);
		                   	 }
		                     else if($("#drpfltype").val()=="2")
		                   	 {
		                    	 content.innerHTML = "Revenue Details"
		                             +"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr><td><strong>Division :</strong></td><td>"+props.div_name+"</td></tr>"
		                             +"<tr><td><strong>Tahasil :</strong></td><td>"+props.tahasil+"</td></tr>"
		                             +"<tr><td><strong>Village Name :</strong></td><td>"+props.village+"</td></tr>"
		                             +"<tr><td><strong>Publish Year :</strong></td><td>"+props.publ_year+"</td></tr>"
		                             +"<tr><td><strong>Khata No :</strong></td><td>"+props.khata_no+"</td></tr>"
		                             +"<tr><td><strong>Plot No :</strong></td><td>"+props.plot_no+"</td></tr>"
		                             +"<tr><td><strong>ROR Area(acre) :</strong></td><td>"+props.area_ac+"</td></tr>"
		                             +"<tr><td><strong>ROR Kissam :</strong></td><td>"+props.kissam+"</td></tr>"
		                             +"<tr><td><strong>DLC Forest :</strong></td><td>"+props.dlc+"</td></tr>"
		                             +"<tr><td><strong>Rev Forest :</strong></td><td>Y</td></tr>"
		                             +"<tr><td><strong>Land Type :</strong></td><td>"+props.land_class+"</td></tr></table></div>";
		                    	 overlay.setPosition(evt.coordinate);
		                   	 }
		                     else if($("#drpfltype").val()=="3")
		                   	 {
		                    	 content.innerHTML = "DLC Details"
		                             +"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr><td><strong>Division :</strong></td><td>"+props.div_name+"</td></tr>"
		                             +"<tr><td><strong>Tahasil :</strong></td><td>"+props.tahasil+"</td></tr>"
		                             +"<tr><td><strong>Village Name :</strong></td><td>"+props.village+"</td></tr>"
		                             +"<tr><td><strong>Publish Year :</strong></td><td>"+props.publ_year+"</td></tr>"
		                             +"<tr><td><strong>Khata No :</strong></td><td>"+props.khata_no+"</td></tr>"
		                             +"<tr><td><strong>Plot No :</strong></td><td>"+props.plot_no+"</td></tr>"
		                             +"<tr><td><strong>Area(acre) :</strong></td><td>"+props.area_ac+"</td></tr>"
		                             +"<tr><td><strong>Kissam :</strong></td><td>"+props.kissam+"</td></tr>"
		                             +"<tr><td><strong>Land Type :</strong></td><td>"+props.land_class+"</td></tr>"
		                             +"<tr><td><strong>DLC :</strong></td><td>"+props.dlc+"</td></tr></table></div>";
		                    	 overlay.setPosition(evt.coordinate);
		                   	 }      
	                    }
	                 } 
	                 else{
	                     overlay.setPosition(undefined);                        
	                 }
            	/* } */
             }); 
</script>
<script>
	//tab 1
	$('#collapseTwo').on('shown.bs.collapse', function () {
		if ( $('.fixHeightRight').height() != 0)
	          $( '.fixHeightRight' ).animate({ height: '0px' } );			  
	    else
	          $( '.fixHeightRight' ).animate({ height: '100%' } );			  
		//$('.fixHeightRight').css("height","0px");		
		});
	//tab 2
	$('#collapseThree').on('shown.bs.collapse', function () {
		if ( $('.fixHeightRight').height() != 0)
	          $( '.fixHeightRight' ).animate({ height: '0px' } );			  
	    else
	          $( '.fixHeightRight' ).animate({ height: '100%' } );			  	
		});
	//tab 3
	$('#collapseFour').on('shown.bs.collapse', function () {
		if ( $('.fixHeightRight').height() != 0)
	          $( '.fixHeightRight' ).animate({ height: '0px' } );			  
	    else
	          $( '.fixHeightRight' ).animate({ height: '100%' } );			  	
		});
	//tab 4
	$('#collapseFive').on('shown.bs.collapse', function () {
		if ( $('.fixHeightRight').height() != 0)
	          $( '.fixHeightRight' ).animate({ height: '0px' } );			  
	    else
	          $( '.fixHeightRight' ).animate({ height: '100%' } );			  	
		});
	//Zoom In and Zoom Out
	  $('#btnZoom').click(function(){
	        
	        $('.ol-zoom-in').trigger("click");
	    });
	     $('#btnZoomout').click(function(){
	        
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

