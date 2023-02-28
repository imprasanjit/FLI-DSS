<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>
<link rel="stylesheet" href="/assets/css/apps/aoiAnalysis.css"
	type="text/css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css"
	type="text/css">
<tl:eval expression="@environment.getProperty('api.geoserverurl')"
	var="geoserverUrl"></tl:eval>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/css/ol.css">
<!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
<script
	src="https://cdn.polyfill.io/v3/polyfill.min.js?features=fetch,requestAnimationFrame,Element.prototype.classList,URL,TextDecoder"></script>
<script
	src="https://unpkg.com/dom-to-image-more@2.8.0/dist/dom-to-image-more.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script src="https://unpkg.com/elm-pep"></script>
<script src="https://unpkg.com/shpjs@latest/dist/shp.js"
	type="text/javascript">
</script>



<style>
/* .ol-scale-bar{
		right: 0;
		left: auto;
	} */
$
(
"
#modalDiv ").printThis( {
	debug: false, importCSS: true, importStyle: true, printContainer: true,
		loadCSS: "../css/style.css", pageTitle: "My Modal", removeInline: false,
		printDelay: 333, header: null, formValues: true
}

)
;
 
	 
.mapFilterBase {
	z-index: 999 ! important;
}

.spInfo {
	color: red !important;
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

.ol-tooltip-measure:before, .ol-tooltip-static:before {
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

.ol-scale-bar {
	right: 8px;
	left: auto;
}

.ol-popup {
	position: absolute;
	background-color: white;
	-webkit-filter: drop-shadow(0 1px 4px rgba(0, 0, 0, 0.2));
	filter: drop-shadow(0 1px 4px rgba(0, 0, 0, 0.2));
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
	background-color: rgba(255, 0, 0, 0.475);
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

.ol-popup-closer:hover:after {
	background-color: rgba(255, 0, 0, 0.875);
}

#popup-content span {
	font-size: 13px;
}

#popup-content h5 {
	color: #077b6d;
	font-size: 14px;
	font-weight: 600;
}

#popup-content p {
	line-height: 24px;
}

#popup-content .table a {
	color: #077b6d;
	text-decoration: underline;
}

#popup-content .table a:hover {
	color: #077b6d;
	text-decoration: none;
}

.chkColor {
	color: #fff !important;
	background-color: #b3d7ff !important;
	border-color: #b3d7ff !important;
}
/* .ol-unselectable .ol-zoom-in, .ol-unselectable .ol-zoom-out{
        	display: none;
        } */
.map-topbar {
	margin-top: -12px;
}
</style>
<div class="apploader-base">
	<div class="apploader"></div>
</div>
<!-- <script type="text/javascript">    
$(document).ready(function() {
	            alert("ii")
					 $(document).ajaxSend(function() {
						$("#loaderId").show();
					}).ajaxComplete(function() {
						$("#loaderId").hide();
					}); 
}
</script> -->
<!--  BEGIN CONTENT AREA  -->
<div id="content" class="main-content noprint">

	<div class="layout-px-spacing">

		<div class="row layout-top-spacing">

			<div class="col-md-3 layout-spacing">
				<div class="statbox widget box box-shadow">
					<div class="widget-content widget-content-area">

						<div id="accordion" class="mapFilter mapFilterBase2 fixHeightLeft">
							<div class="map-tab-fix row m-0">
								<a id="aoiTab" href="#collapseOne"
									class="text-dark col collapsed bs-tooltip"
									data-toggle="collapse" aria-expanded="true"
									aria-controls="collapseOne" title="Area of Interest"> <span
									class="d-block"><img src="/assets/img/icon-filter.png"></span>
								</a> <a id="layerTab" href="#collapseTwo"
									class="text-dark col collapsed bs-tooltip feature"
									data-toggle="collapse" aria-expanded="false"
									aria-controls="collapseTwo" title="Layers"> <span
									class="d-block"><img src="/assets/img/icon-layers.png"></span>
								</a>
							</div>

							<div class="clearfix"></div>

							<div class="mb-0">
								<div id="collapseOne" class="collapse show"
									aria-labelledby="headingOne" data-parent="#accordion">
									<div class="card">
										<div class="card-body">
											<div class="fixHeightRight">
												<!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><span aria-hidden="true">�</span></button> -->
												<div class="card-body custom-card-body">
													<h6 class="mt-0 page-title mb-3">Area of Interest</h6>

													<div>
														<div
															class="custom-control custom-radio custom-control-inline">
															<input type="radio" id="radioLocation" name="radiobutton"
																class="custom-control-input" value="loc"
																onclick="show1();" checked> <label
																class="custom-control-label" for="radioLocation">Location</label>
														</div>
														<div
															class="custom-control custom-radio custom-control-inline">
															<input type="radio" id="radioArea" name="radiobutton"
																class="custom-control-input" value="area"
																onclick="show2();"> <label
																class="custom-control-label" for="radioArea">Area</label>
														</div>
													</div>

													<div id="locationDiv" style="display: none"
														class="mb-2 border-light pl-1 pr-1 pt-2 pb-2">
														<div class="row">
															<div class="col-md-12">
																<label><strong>Enter Coordinates(Degree Decimal)</strong></label>
															</div>
															<div class="col-md-12 mb-2">
																<input type="number"
																	class="form-control form-control-sm" id="latitude"
																	placeholder="Latitude">
															</div>
															<div class="col-md-12 mb-2">
																<input type="number"
																	class="form-control form-control-sm" id="longitude"
																	placeholder="Longitude">
															</div>
															<!-- 	<div class="col-md-12 text-center text-dark mb-2">
				                                            		-- OR --
				                                            	</div> -->
															<div class="col-md-12 text-center">
																<button type="button" id="btnShowMap"
																	class="btn btn-sm btn-info">Show on Map</button>
																<button type="button" id="btnClear"
																	class="btn btn-sm btn-danger">Clear</button>
															</div>
														</div>
													</div>

													<div id="areaDiv" style="display: none"
														class="mb-2 border-light pl-1 pr-1 pt-2 pb-2">
														<div class="row">
															<div class="col-md-12 mb-1 border-light p-1">
																<button type="button" id="btndrawPoly"
																	class="btn btn-sm btn-info">Draw Polygon</button>

															</div>
															<div class="col-md-12 mb-1 border-light p-1">
																<button type="button" id="btnimportPoly"
																	class="btn btn-sm btn-info">Import Polygon</button>
															</div>
															<div class="col-md-12 border-light p-1 mb-1"
																id="divImport">
																<div class="col-md-12">
																	<label>Import Polygon</label>
																</div>
																<ul class="nav nav-tabs  mb-3 pb-0" id="simpletab"
																	role="tablist">
																	<li class="nav-item"><a class="nav-link active"
																		id="kml-tab" data-toggle="tab" href="#kml" role="tab"
																		aria-controls="kml" aria-selected="true">KML</a></li>
																	<!-- <li class="nav-item" style="display: none;"><a
																		class="nav-link" id="shp-tab" data-toggle="tab"
																		href="#shp" role="tab" aria-controls="shp"
																		aria-selected="false">SHP</a></li> -->
																	<li class="nav-item"><a class="nav-link"
																		id="file-tab" data-toggle="tab" href="#file"
																		role="tab" aria-controls="file" aria-selected="false">Coordinates
																			File</a></li>
																</ul>
																<div class="tab-content col-md-12 mb-2"
																	id="simpletabContent">
																	<div class="tab-pane fade show active" id="kml"
																		role="tabpanel" aria-labelledby="kml-tab">
																		<div class="row">
																			<div class="col-md-10">
																				<input type="file" id="upldkml"
																					class="form-control form-control-sm" accept=".kml"
																					placeholder="Import Polygon">
																			</div>
																			<div class="col-md-2">
																			
																				<!-- <span class="btn btn-sm btn-warning bs-tooltip" title="Your information here"><i class="fa fa-info"></i></span> -->
																			</div>
																		</div>
																	</div>
																	<div class="tab-pane fade" id="shp" role="tabpanel"
																		aria-labelledby="shp-tab">
																		<div class="row">
																			<!-- <div class="col-md-10">
																				<input type="file" id="upldshp"
																					class="form-control form-control-sm"
																					placeholder="Import Polygon">
																			</div> -->
																			<div class="col-md-2">
																				<span class="btn btn-sm btn-warning bs-tooltip"
																					title="Your information here"><i
																					class="fa fa-info"></i></span>
																			</div>
																		</div>
																	</div>
																	<div class="tab-pane fade" id="file" role="tabpanel"
																		aria-labelledby="file-tab">
																		<div class="row">
																			<div class="col-md-9">
																			
																			<input type="file" id="upldfile"
																					class="form-control form-control-sm" 
																					placeholder="Import Coordinates">
																			</div>
																			<div class="col-md-3">
																				<!-- <span class="btn btn-sm btn-warning bs-tooltip" title="Your information here"><i class="fa fa-info"></i></span> -->
																				<a href='/assets/download/Format_Coordinates.xlsx'
																					download target='_balnk' title="Downlaod Format"
																					class='btn btn-sm btn-success bs-tooltip'><i
																					class='fa fa-file-excel-o'></i></a>
																				<!-- <span class="btn btn-sm btn-success" ><i class="fa fa-file-excel-o"></i></span> -->
																			</div>
																		</div>
																	</div>
																</div>
															</div>

															<div class="col-md-12 border-light pt-2 mb-2">
																<div class="row">
																	<div class="col-md-5">
																		<label><strong>Buffer Zone</strong></label>
																	</div>
																	<div class="col-md-7">
																		<input type="number" id="txtbuffer"
																			class="form-control form-control-sm" min="1" max="10"
																			placeholder="Enter in Kms">
																	</div>
																	<div class="col-md-12 text-danger">
																		<small>Maximum range upto 10kms</small>
																	</div>
																</div>
															</div>
															<div class="col-md-12 text-center">
																<button type="button" id="btnShowMapArea"
																	class="btn btn-sm btn-info">Show on Map</button>
																<button type="button" id="btnClearArea"
																	class="btn btn-sm btn-danger">Clear</button>
															</div>
														</div>
													</div>

													<div class="row">
														<div class="col-md-12 text-center">
															<span style="display: none"
															id="poiDiv">
																<button type="button" id="btnpoiAnalysis"
																	class="btn btn-sm btn-success">PoI Analysis</button>
															</span>
															<span style="display: none"
																id="aoiDiv">
																<button type="button" id="btnaoiAnalysis"
																	class="btn btn-sm btn-success">AoI Analysis</button>
															</span>
															<span style="display: none"
																id="kmlDiv">
																<button type="button" id="btnaoiKML"
																	class="btn btn-sm btn-warning"><i class="fa fa-download">&nbsp;</i> KML</button>
															</span>
														</div>
														
													</div>

												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="mb-0">
								<div id="collapseTwo" class="collapse"
									aria-labelledby="headingTwo" data-parent="#accordion">
									<div class="card">
										<div class="card-body">
											<div class="fixHeightRight">
												<!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><span aria-hidden="true">�</span></button> -->
												<div class="card-body custom-card-body">
													<h6 class="mt-0 page-title mb-3">Layers</h6>

													<div id="accordion2">
														<a id="" href="#collapse1" class="collapsed"
															data-toggle="collapse" aria-expanded="true"
															aria-controls="collapse1">
															<h6 class="mt-0 header-title map-title-secondary mb-3">
																Forest Land Boundary<i
																	class="fa fa-angle-down pull-right"></i>
															</h6>
														</a>
														<div id="collapse1" class="collapse show"
															aria-labelledby="heading1" data-parent="#accordion2">
															<form>
																<div class="row form-group">
																	<div class="col-md-12">
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk" id="chkNf"
																				value="1"> <label
																				class="custom-control-label" for="chkNf">Notified
																				Forest</label> <img src="/assets/img/forest-01.png"
																				class="img-chk">
																		</div>																																									
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk" id="chkDlc">
																			<label class="custom-control-label" for="chkDlc">DLC
																				Forest</label> <img src="/assets/img/dlc_forest.png"
																								class="img-chk">
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk" id="chkRev">
																			<label class="custom-control-label" for="chkRev">Other
																				Revenue Forest</label> <img src="/assets/img/rev_forest.png"
																								class="img-chk">
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk"
																				id="checkDeemed"> <label
																				class="custom-control-label" for="checkDeemed">Deemed
																				Forest</label> <img src="/assets/img/forest-04.png"
																				class="img-chk">
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk"
																				id="checkDiverted"> <label
																				class="custom-control-label" for="checkDiverted">Diverted
																				Forest Land</label> <img src="/assets/img/forest-05.png"
																				class="img-chk">
																		</div>
																		<!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input layerchk" id="checkbox16">
                                                                                <label class="custom-control-label" for="checkbox16">Compensatory Afforestation Land</label>
                                                                                <img src="/assets/img/forest-06.png" class="img-chk">
                                                                            </div> -->
																	</div>
																</div>
															</form>
														</div>
														<!--  <span class="spInfo">* Search District/ Division to View other Layers</span> -->

														<a id="" href="#collapse2" class="collapsed"
															data-toggle="collapse" aria-expanded="false"
															aria-controls="collapse2">
															<h6 class="mt-0 header-title map-title-secondary mb-4">
																Administrative Boundary<i
																	class="fa fa-angle-right pull-right"></i>
															</h6>
														</a>
														<div id="collapse2" class="collapse"
															aria-labelledby="heading2" data-parent="#accordion2">
															<form>
																<div class="row form-group">
																	<div class="col-md-12">
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk"
																				value="StateBoundary" checked id="chkState">
																			<label class="custom-control-label" for="chkState">State
																				</label> <img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_STATE/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_STATE:StateBoundary"
																				class="img-chk2" />
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk"
																				value="DistrictBoundary" checked id="chkDistrict">
																			<label class="custom-control-label" for="chkDistrict">District</label>
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_AllDivision/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_AllDivision:district_boundary"
																				class="img-chk2" />
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk"
																				id="chkDivision"> <label
																				class="custom-control-label" for="chkDivision">Division</label> <img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Angul_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Angul_vector:division_boundary"
																				class="img-chk2" />
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk" id="chkRange">
																			<label class="custom-control-label" for="chkRange">Range</label>
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Angul_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Angul_vector:range_boundary"
																				class="img-chk2" />
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk" id="chkTehsil">
																			<label class="custom-control-label" for="chkTehsil">Tehsil</label>
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Angul_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Angul_vector:tahasil_boundary"
																				class="img-chk2" />
																		</div>
																		<!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkBlock">
                                                                                <label class="custom-control-label" for="chkBlock">Block</label>
                                                                            </div> -->
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk"
																				id="chkvillage_layer"> <label
																				class="custom-control-label" for="chkvillage_layer">Village</label>
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Angul_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Angul_vector:village_boundary"
																				class="img-chk2" />
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk"
																				id="chkBeat"> <label
																				class="custom-control-label" for="chkBeat">Beat</label>
																			<img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Angul_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Angul_vector:beat_boundary"
																							class="img-chk2" />
																		</div>
																	</div>
																</div>
															</form>
														</div>
														<a id="" href="#collapse3" class="collapsed"
															data-toggle="collapse" aria-expanded="false"
															aria-controls="collapse3">
															<h6 class="mt-0 header-title map-title-secondary mb-4">
																Protected Area<i class="fa fa-angle-right pull-right"></i>
															</h6>
														</a>
														<div id="collapse3" class="collapse"
															aria-labelledby="heading3" data-parent="#accordion2">
															<form>
																<div class="row form-group">
																	<div class="col-md-12">
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk" id="checkSanc">
																			<label class="custom-control-label" for="checkSanc">Sanctuary
																				Boundary</label>
																		</div>
																		<!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input layerchk" id="checkNP">
                                                                                <label class="custom-control-label" for="checkNP">National Park</label>
                                                                            </div> -->
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk" id="checkESZ">
																			<label class="custom-control-label" for="checkESZ">Eco-sensitive
																				Zone</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox"
																				class="custom-control-input layerchk" id="checkWC">
																			<label class="custom-control-label" for="checkWC">Wildlife
																				Corridor</label>
																		</div>
																		<!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input  layerchk" id="checkCR">
                                                                                <label class="custom-control-label" for="checkCR">Conservation Reserve</label>
                                                                            </div> -->
																	</div>
																</div>
															</form>
														</div>
														<%-- <a id="" href="#collapse4" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse4">
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
                                                            </div> --%>
														<a id="" href="#collapse5" class="collapsed"
															data-toggle="collapse" aria-expanded="false"
															aria-controls="collapse5">
															<h6 class="mt-0 header-title map-title-secondary mb-4">
																Hydrological Layers<i
																	class="fa fa-angle-right pull-right"></i>
															</h6>
														</a>
														<div id="collapse5" class="collapse"
															aria-labelledby="heading5" data-parent="#accordion2">
															<form>
																<div class="row form-group">
																	<div class="col-md-12">
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				id="checkRiver"> <label
																				class="custom-control-label" for="checkRiver">Rivers</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				id="checkReservoir"> <label
																				class="custom-control-label" for="checkReservoir">Reservoirs</label>
																		</div>
																	</div>
																</div>
															</form>
														</div>
														<a id="" href="#collapse6" class="collapsed"
															data-toggle="collapse" aria-expanded="false"
															aria-controls="collapse6">
															<h6 class="mt-0 header-title map-title-secondary mb-4">
																Transport Layers<i class="fa fa-angle-right pull-right"></i>
															</h6>
														</a>
														<div id="collapse6" class="collapse"
															aria-labelledby="heading6" data-parent="#accordion2">
															<form>
																<div class="row form-group">
																	<div class="col-md-12">
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				id="checkRail"> <label
																				class="custom-control-label" for="checkRail">Rail</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				id="checkRoad"> <label
																				class="custom-control-label" for="checkRoad">Road</label>
																		</div>
																	</div>
																</div>
															</form>
														</div>
														<%--  <a id="" href="#collapse7" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse7">
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
                                                            </div>  --%>
													</div>

												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

						</div>
						<!--/accordion-->


					</div>
				</div>
			</div>

			<div class="col-md-9 layout-spacing">
				<div class="statbox widget box box-shadow">
					<div class="widget-content widget-content-area">
						<div id="popup" class="ol-popup">
							<a href="#" id="popup-closer" class="ol-popup-closer"></a>
							<div id="popup-content"></div>
						</div>
						<div id="map" class="fixHeightLeft panel">
							<div class="map-radio-hang p-2">
								<div class="custom-control custom-radio">
									<input type="radio" id="rdosm_basemap" name="radio-map" checked
										class="custom-control-input"> <label
										class="custom-control-label" for="rdosm_basemap">OSM</label>
								</div>
								<div class="custom-control custom-radio">
									<input type="radio" id="rdimagery_basemap" name="radio-map"
										class="custom-control-input"> <label
										class="custom-control-label" for="rdimagery_basemap">Satellite</label>
								</div>
								<div class="custom-control custom-radio">
									<input type="radio" id="rdblank_basemap" name="radio-map"
										class="custom-control-input"> <label
										class="custom-control-label" for="rdblank_basemap">Muted</label>
								</div>
							</div>							
							<!-- <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834859.9797965377!2d82.19173433935192!3d20.176539522401498!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a226aece9af3bfd%3A0x133625caa9cea81f!2sOdisha!5e0!3m2!1sen!2sin!4v1564120416120!5m2!1sen!2sin" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe> -->
						</div>
						<img alt="Compass" src="/assets/img/compass.png" style="position:absolute;left:35px;top:0">
					</div>
				</div>
			</div>

			<button id="queryBtn" class="btn btn-sm btn-query"
				style="display: none">
				<i class="fa fa-angle-left rotate"></i>
			</button>
			<div id="queryContent" class="query-content card"
				style="display: none">

				<div class="" id="poiSummaryDiv">

					<div class="custom-print-dss">
						<div class="row layout-top-spacing">
							<!-- <div class="col-md-1">										
									<img src="../assets/img/odisha-logo.png" class="" alt="logo" height="60px" width="55px">																			
								</div> -->
							<div class="col-md-8" style="text: center;">
								<h4 style="text-align: right;">Forest Land Information</h4>
								<!-- <br> -->
								<h5 style="text-align: right;">Point of Interest(PoI)
									Summary</h5>
							</div>
							<div class="col-md-4 text-right">
								<br> <strong>Date : </strong><span class="spDate"></span>
							</div>
						</div>
					</div>
					 <h6 class="mt-0 page-title mb-2" style="float: none">PoI Summary Information</h6>
					<!-- <h6 class="mt-0 page-title mb-2">PoI Analysis Report</h6> -->
				

				 <div id="accordion5">
					<a id="" href="#collapse10" class="icon-header"
							data-toggle="collapse" aria-expanded="true"
							aria-controls="collapse10">
							<h6 class="mt-0 header-title map-title-secondary mb-3">
								Location<i class="fa pull-right fa-angle-down"></i>
							</h6>
						</a>
					<div id="collapse10" class="collapse show" aria-labelledby="heading10"
						data-parent="#accordion5">
							<div class="table-responsive">

						<!-- <h6>PoI Coordinate</h6> -->
						<table class="table table-sm table-bordered">
							<tbody>
								<tr>
									<td width="60%"><strong>Latitude : </strong> </td>
									<td width="40%"><span id="sp_lat"
										class="sp_poianalysis"></span></td>
									
								</tr>
								<tr>
									<td><strong>Longitude : </strong></td>
									<td> <span id="sp_lon"
										class="sp_poianalysis"></span></td>
								</tr>
							</tbody>
						</table>
					</div>
						</div>
						</div>
						<a id="" href="#collapse11" class="icon-header"
							data-toggle="collapse" aria-expanded="false"
							aria-controls="collapse11">
							<h6 class="mt-0 header-title map-title-secondary mb-3">
								District:<span id="sp_district_name" class="sp_poianalysis"></span><i class="fa pull-right fa-angle-down"></i>
							</h6>
						</a>
						
						<div id="collapse11" class="collapse"
							aria-labelledby="heading11" data-parent="#accordion5" style="">
							<div class="table-responsive">

								<!-- <h6>POI Summary Information</h6> -->
								<table class="table table-sm table-bordered">
									
									<tbody>
										<tr>
											<td width="60%"><strong>Tehsil : </strong> </td>
											<td width="40%"><span id="sp_tahasil_name" class="sp_poianalysis"></span></td>
										</tr>
										<tr>
										<td><strong>RI Circle : </strong> </td>
											<td><span id="sp_ri_circle" class="sp_poianalysis"></span></td>
										</tr>
										<tr>
											<td><strong>Village : </strong> </td>
											<td><span id="sp_village_name" class="sp_poianalysis"></span></td>
										</tr>
										
										<!-- <tr>
											<td><strong>GP : </strong> </td>
											<td><span id="sp_gp_name" class="sp_poianalysis"></span></td>
											<td></td>
										</tr> -->
									</tbody>
								</table>
							</div>


						</div>
					
					<a id="" href="#collapse11-1" class="icon-header"
							data-toggle="collapse" aria-expanded="false"
							aria-controls="collapse11-1">
							<h6 class="mt-0 header-title map-title-secondary mb-3">
								Division:<span id="sp_division_name" class="sp_poianalysis"></span><i class="fa pull-right fa-angle-down"></i>
							</h6>
						</a>
						
						<div id="collapse11-1" class="collapse"
							aria-labelledby="heading11-1" data-parent="#accordion5" style="">
							<div class="table-responsive">

								<table class="table table-sm table-bordered">
									
									<tbody>
										<tr>
											<td width="60%"><strong>Circle : </strong> </td>
											<td width="40%"><span id="sp_circle_name" class="sp_poianalysis"></span></td>
										</tr>
										<tr>
											<td><strong>Range : </strong> </td>
											<td><span id="sp_range_name" class="sp_poianalysis"></span></td>
										</tr>
										
									</tbody>
								</table>
							</div>


						</div>
					<a id="" href="#collapse12" class="collapsed icon-header"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="collapse12">
						<h6 class="mt-0 header-title map-title-secondary mb-4">
							Other Revenue Forest:<span id="sp_area_acre" class="sp_poianalysis"></span><i class="fa fa-angle-right pull-right"></i>
						</h6>
					</a>
					<div id="collapse12" class="collapse" aria-labelledby="heading12"
						data-parent="#accordion5">
						<div class="table-responsive">
							<!-- <h6>Revenue Forest Details</h6> -->
							<table class="table table-sm table-bordered">
								<tbody>
									<tr>
										<td width="60%"><strong>Land Type : </strong> </td>
										<td width="40%"><span id="sp_land_type"
											class="sp_poianalysis"></span></td>
										
									</tr>
									<tr>
										<td><strong>Kissam : </strong> </td>
										<td><span id="sp_kissam" class="sp_poianalysis"></span></td>
									</tr>
									<tr>
										<td><strong>Khata No. : </strong> </td>
										<td><span id="sp_khata_no"
											class="sp_poianalysis"></span></td>										
									</tr>
									<tr>
										<td><strong>Plot No. : </strong> </td>
										<td><span id="sp_plot_no"
											class="sp_poianalysis"></span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<a id="" href="#collapse13" class="collapsed icon-header"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="collapse13">
						<h6 class="mt-0 header-title map-title-secondary mb-4">
							Notified Forest : <span id="sp_fb_name"
											class="sp_poianalysis"></span>&nbsp; <span id="sp_fb_type"
											class="sp_poianalysis"></span><i class="fa fa-angle-right pull-right"></i>
						</h6>
					</a>
					<div id="collapse13" class="collapse" aria-labelledby="heading13"
						data-parent="#accordion5">
						<div class="table-responsive">
							<!-- <h6>Forest Block Details</h6> -->
							<table class="table table-sm table-bordered">
								<tbody>
								<tr>
										<td width="60%"><strong>Area (Ha.) : </strong> </td>
										<td width="40%"><span id="sp_area_ha"
											class="sp_poianalysis"></span></td>
										
									</tr>
									<tr>
										
										<td><strong>Nearest Forest Block : </strong></td>
										<td> <span
											id="sp_nearest_fb" class="sp_poianalysis"></span></td>

									</tr>
									<tr>
										
										<td><strong>Distance from Nearest Forest Block(Km) : </strong> </td>
										<td><span id="sp_distance_from_fb"
											class="sp_poianalysis"></span></td>
									</tr>
									
								</tbody>
							</table>
						</div>
					</div>
					<a id="" href="#collapse14" class="collapsed icon-header"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="collapse14">
						<h6 class="mt-0 header-title map-title-secondary mb-4">
							Sanctuary Name : <span id="sp_nearest_pa" class="sp_poianalysis"></span><i class="fa fa-angle-right pull-right"></i>
						</h6>
					</a>
					<div id="collapse14" class="collapse" aria-labelledby="heading14"
						data-parent="#accordion5">
						<div class="table-responsive">
							<!-- <h6>Nearest Sanctuary Details</h6> -->
							<table class="table table-sm table-bordered">
								<tbody>
									<tr>
										<td width="60%"><strong>Area (Ha.) : </strong> </td>
										<td width="40%"><span id="sp_sanc_area" class="sp_poianalysis"></span> </td>
									</tr>
									<tr>	
										<td><strong>Distance from Sanctuary Boundary(Km) : </strong> </td>
										<td><span id="sp_dist_from_pa" class="sp_poianalysis"></span> </td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<a id="" href="#collapse15" class="collapsed icon-header"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="collapse15">
						<h6 class="mt-0 header-title map-title-secondary mb-4">
							ESZ : <span
											id="sp_nearest_esz" class="sp_poianalysis"></span><i class="fa fa-angle-right pull-right"></i>
						</h6>
					</a>
					<div id="collapse15" class="collapse" aria-labelledby="heading15"
						data-parent="#accordion5">
						<div class="table-responsive">
							<!-- <h6>Nearest ESZ Details</h6> -->
							<table class="table table-sm table-bordered">
								<tbody>
									<tr>
										<td width="60%"><strong>Distance from ESZ(Km) : </strong> </td>
										<td width="40%"><span
											id="sp_dist_from_esz" class="sp_poianalysis"></span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<a id="" href="#collapse16" class="collapsed icon-header"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="collapse16">
						<h6 class="mt-0 header-title map-title-secondary mb-4">
							Wild life Corridor : <span id="sp_wc"
											class="sp_poianalysis"></span><i class="fa fa-angle-right pull-right"></i>
						</h6>
					</a>
					<div id="collapse16" class="collapse" aria-labelledby="heading16"
						data-parent="#accordion5">
						<div class="table-responsive">
							<!-- <h6>Nearest Wild life Corridor Details</h6> -->
							<table class="table table-sm table-bordered">
								<tbody>
									<tr>
										
										<td width="60%"><strong>Area(Ha.) : </strong> </td>
										<td width="40%"><span id="sp_wc_area"
											class="sp_poianalysis"></span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<a id="" href="#collapse17" class="collapsed icon-header"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="collapse17">
						<h6 class="mt-0 header-title map-title-secondary mb-4">
							Deemed Forest : <span
											id="sp_deemed_forest_involved" class="sp_poianalysis"></span><i class="fa fa-angle-right pull-right"></i>
						</h6>
					</a>
					<div id="collapse17" class="collapse" aria-labelledby="heading17"
						data-parent="#accordion5">
						<div class="table-responsive">
							<!-- <h6>Deemed Forest Details</h6> -->
							<table class="table table-sm table-bordered">
								<tbody>
									<tr>
										
										<td width="60%"><strong>Area(Ha.) : </strong> </td>
										<td width="40%"><span
											id="sp_deemed_area" class="sp_poianalysis"></span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<a id="" href="#collapse18" class="collapsed icon-header"
						data-toggle="collapse" aria-expanded="false"
						aria-controls="collapse18">
						<h6 class="mt-0 header-title map-title-secondary mb-4">
							Diverted Forest Project Name : <span
											id="sp_diverted_forest" class="sp_poianalysis"></span><i class="fa fa-angle-right pull-right"></i>
						</h6>
					</a>
					<div id="collapse18" class="collapse" aria-labelledby="heading18"
						data-parent="#accordion5">
						<div class="table-responsive">
							<!-- <h6>Diverted Forest Details</h6> -->
							<table class="table table-sm table-bordered">
								<tbody>
									<tr>
										
										<td width="60%"><strong>Diverted Area(Ha.) : </strong> </td>
										<td width="40%"><span
											id="sp_diverted_area" class="sp_poianalysis"></span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 text-center">
							<!-- <button type="submit" id="poiDownload" class="btn btn-sm btn-warning noprint" data-toggle="modal" data-target="#poiModal"><i class="fa fa-download">&nbsp;</i>Download</button> -->
							<button type="button" id="btnpoiPrint"
								class="btn btn-sm btn-warning noprint"
								onclick="PrintPOISummary('printpoicontent');">
								<i class="fa fa-print">&nbsp;</i> Print
							</button>
						</div>
					</div>
				</div>


				<!-- <div class="row">
							<div class="col-md-12 text-center form-group">
								<button type="submit" class="btn btn-sm btn-info">View Details</button>
							</div>
						</div> -->
				<div id="FSIDiv" style="display: none">
					<div class="table-responsive">
						<h6>FSI Forest Details</h6>
						<table class="table table-sm table-bordered">
							<tbody>
								<tr>
									<td><strong>2020 : </strong> <span><u>1452</u></span></td>
									<td><strong>2018 : </strong> <span><u>8451</u></span></td>
								</tr>
								<tr>
									<td><strong>2014 : </strong> <span><u>1452</u></span></td>
									<td><strong>2012 : </strong> <span><u>8451</u></span></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div id="aoiSummaryDiv">

					<div class="custom-print-dss">
						<div class="row layout-top-spacing">
							<!-- <div class="col-md-1">										
										<img src="../assets/img/odisha-logo.png" class="" alt="logo" height="60px" width="55px">																			
									</div> -->
							<div class="col-md-8" style="text: right;">
								<h4 style="text-align: right;">Forest Land Information</h4>
								<!-- <br> -->
								<h5 style="text-align: right;">Area of Interest(AoI)
									Summary</h5>
							</div>
							<div class="col-md-4 text-right">
								<br> <strong>Date : </strong><span class="spDate"></span>
							</div>
						</div>
					</div>
					<h6 class="mt-0 page-title mb-2" style="float: none">AoI Summary Information</h6>
					
					<!-- <h6 class="mt-0 mb-2" style="float: none">AOI Summary</h6> -->
					<div class="table-responsive">
						<table class="table table-bordered table-sm">
							<tbody>
								<tr>
									<td width="60%">AoI Area</td>
									<td><span id="sp_area_geom"></span> (Ha.)</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<h6 class="mt-0 mb-2" style="float: none">Forest Land Involvement</h6>
					<div class="table-responsive">
						<table class="table table-bordered table-sm">
							<tbody>
								<tr>
									<td width="60%">Notified Forest Area</td>
									<td><span id="sp_nfb_area"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>Recorded Forest Area</td>
									<td><span id="sp_rf_area"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>Other Forest Area</td>
									<td><span id="sp_other_forest_area"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>Total Forest Area</td>
									<td><span id="sp_total_forest_area"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>Non-Forest Area</td>
									<td><span id="sp_non_forest_area"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>Total AoI Area</td>
									<td><span id="sp_total_aoi_area"></span> (Ha.)</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<h6 class="mt-0 mb-2" style="float: none">AoI Details</h6>
					<div class="table-responsive">
						<table class="table table-bordered table-sm">
							<tbody>
								<tr>
									<td width="60%">No. of Divisions</td>
									<td><span id="sp_total_divisions"></span></td>
								</tr>
								<tr>
									<td>No. of Ranges</td>
									<td><span id="sp_total_ranges"></span></td>
								</tr>
								<tr>
									<td>No. of Notified Forest Block</td>
									<td><span id="sp_total_fbs"></span></td>
								</tr>
								<tr>
									<td>Area of Notified Forest Block</td>
									<td><span id="sp_area_fbs_ha"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>No. of Sanctuary</td>
									<td><span id="sp_total_pa"></span></td>
								</tr>
								<tr>
									<td>Area in Sanctuary</td>
									<td><span id="sp_area_pa_ha"></span></td>
								</tr>
								<tr>
									<td>No. of ESZ</td>
									<td><span id="sp_total_esz"></span></td>
								</tr>
								<tr>
									<td>Area in ESZ</td>
									<td><span id="sp_area_esz_ha"></span></td>
								</tr>
								<tr>
									<td>No. of District</td>
									<td><span id="sp_total_district"></span></td>
								</tr>
								<tr>
									<td>No. of Tahasil</td>
									<td><span id="sp_total_tahasils"></span></td>
								</tr>
								<tr>
									<td>No. of Villages</td>
									<td><span id="sp_total_villages"></span></td>
								</tr>
								<tr>
									<td>No. of Plots</td>
									<td><span id="sp_total_plots"></span></td>
								</tr>
								<tr>
									<td>Area of Plots</td>
									<td><span id="sp_area_of_plots"></span> (Ha.)</td>
								</tr>

								<tr>
									<td>No. of DLC Forest Plots</td>
									<td><span id="sp_plots_dlc"></span></td>
								</tr>
								<tr>
									<td>Area of DLC Forest Plots</td>
									<td><span id="sp_area_dlcplot_acre"></span> (Ha.)</td>
								</tr>

								<tr>
									<td>No. of Other Revenue Forest Plots</td>
									<td><span id="sp_plots_rev"></span></td>
								</tr>
								<tr>
									<td>Area of Other Revenue Forest Plots</td>
									<td><span id="sp_area_revplot_acre"></span> (Ha.)</td>
								</tr>
								
							</tbody>
						</table>
					</div>

					<div id="accordion4">
						<!-- <a id="" href="#collapse21" class="icon-header"
							data-toggle="collapse" aria-expanded="true"
							aria-controls="collapse21">
							<h6 class="mt-0 header-title map-title-secondary mb-3">
								Revenue Administration<i class="fa pull-right fa-angle-down"></i>
							</h6>
						</a> -->
						<!-- <div id="collapse21" class="collapse show"
							aria-labelledby="heading21" data-parent="#accordion4" style="">
							<div class="table-responsive">

								<table class="table table-sm table-bordered">
									<thead>
										<tr>

											<th>Type</th>
											<th>No(s)</th>
											<th>Name</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td width="40%"><strong>District </strong></td>
											<td width="15%"><span id="sp_total_district"></span></td>
											<td width="45%"><span id="sp_dist_name"></span></td>
										</tr>
										<tr>
											<td><strong>Tehsil </strong></td>
											<td><span id="sp_total_tahasils"></span></td>
											<td><span id="sp_tah_name"></span></td>
										</tr>
										<tr>
											<td><strong>Village</strong></td>
											<td><span id="sp_total_villages"></span></td>
											<td>
												<div>
													<span>Names...</span>
													<div id="show-more">
														<a href="javascript:void(0)" class="text-primary"><u>View
																More</u></a>
													</div>

													<div id="show-more-content">
														<span id="sp_villg_name">, ...</span>
														<div id="show-less">
															<a href="javascript:void(0)" class="text-primary"><u>View
																	Less</u></a>
														</div>
													</div>
												</div>
											</td>

										</tr>
										<tr>
											<td><strong>GP </strong></td>
											<td><span></span></td>
											<td><span>--</span></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div> -->
						<!-- <a id="" href="#collapse22" class="collapsed icon-header"
							data-toggle="collapse" aria-expanded="false"
							aria-controls="collapse22">
							<h6 class="mt-0 header-title map-title-secondary mb-4">
								Forest Administration<i class="fa fa-angle-right pull-right"></i>
							</h6>
						</a> -->
						<!-- <div id="collapse22" class="collapse" aria-labelledby="heading22"
							data-parent="#accordion4">
							<div class="table-responsive">
								<h6>AoI Summary Information</h6>
								<table class="table table-sm table-bordered">
									<thead>
										<tr>

											<th>Type</th>
											<th>No(s)</th>
											<th>Name</th>
										</tr>
									</thead>
									<tbody>
										<tr>

											<td width="40%"><strong>Division </strong></td>
											<td width="15%"><span id="sp_total_divisions"></span></td>
											<td width="45%"><span id="sp_div_name"></span></td>
										</tr>
										<tr>
											<td><strong>Range</strong></td>
											<td><span id="sp_total_ranges"></span></td>
											<td><span id="sp_rng_name"></span></td>
										</tr>


									</tbody>
								</table>
							</div>
						</div> -->
						<!-- <a id="" href="#collapse23" class="collapsed icon-header"
							data-toggle="collapse" aria-expanded="false"
							aria-controls="collapse23">
							<h6 class="mt-0 header-title map-title-secondary mb-4">
								Forest Land Details within AoI<i class="fa fa-angle-right pull-right"></i>
							</h6>
						</a>
						<div id="collapse23" class="collapse" aria-labelledby="heading23"
							data-parent="#accordion4">
							<div class="table-responsive">
								<h6>Forest Land Details within AoI</h6>
								<table class="table table-sm table-bordered">
									<thead>
										<tr>
											<th>Type</th>
											<th>No(s)</th>
											<th>Area</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="td-bg" width=30%><strong>NFB </strong></td>
											<td width=35%><span id="sp_total_fbs"></span></td>
											<td width=35%>
												<strong>Area:</strong> <span id="sp_area_fbs_ha"></span>
												Ha.
											</td>
										</tr>
										<tr>
											<td class="td-bg"><strong>DLC Forest : </strong></td>
											<td><span id="sp_plots_dlc"></span></td>
											<td>
												<strong>Area: </strong> <span
												id="sp_area_dlcplot_acre"></span> Acre.
											</td>
										</tr>
										<tr>
											<td class="td-bg"><strong>Other Rev Forest : </strong></td>
											<td><span id="sp_plots_rev"></span></td>
											<td>
												<strong>Area: </strong> <span
												id="sp_area_revplot_acre"></span> Acre.
											</td>
										</tr>
										<tr>
											<td class="td-bg"><strong>Deemed Forest: </strong></td>
											<td><span id="sp_total_deemed"></span></td>
											<td>
												<strong>Area: </strong> <span
												id="sp_area_deemed_ha"></span>
											</td>
										</tr>
										<tr>
											<td class="td-bg"><strong>Diverted Forest land
													: </strong></td>
											<td><span id="sp_total_diverted"></span></td>
											<td>
												<strong>Area: </strong> <span
												id="sp_area_diverted_ha"></span>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<a id="" href="#collapse24" class="collapsed icon-header"
							data-toggle="collapse" aria-expanded="false"
							aria-controls="collapse24">
							<h6 class="mt-0 header-title map-title-secondary mb-4">
								Protected Area Details within AoI<i class="fa fa-angle-right pull-right"></i>
							</h6>
						</a>
						<div id="collapse24" class="collapse" aria-labelledby="heading24"
							data-parent="#accordion4">
							<div class="table-responsive">
								<h6>Protected Area Details within AoI</h6>
								<table class="table table-sm table-bordered">
									<thead>
										<tr>
											<th>Type</th>
											<th>No(s)</th>
											<th>Area</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="td-bg" width=30%><strong>Sanctuary
													Boundary:</strong></td>
											<td width=35%><span id="sp_total_pa"></span></td>
											<td width=35%><span id="sp_area_pa_ha"></span></td>
										</tr>
										<tr>
											<td class="td-bg"><strong>ESZ:</strong></td>
											<td><span id="sp_total_esz"></span></td>
											<td><span id="sp_area_esz_ha"></span></td>
										</tr>
										<tr>
											<td class="td-bg"><strong>WldLife Corridor:</strong></td>
											<td><span id="sp_total_wc"></span></td>
											<td><span id="sp_area_wc_ha"></span></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div> -->

						<div class="row">
							<div class="col-md-12 text-center form-group">
								<button type="button" id="btnAoiView"
									class="btn btn-sm btn-info noprint">View Details</button>
								<!-- <button type="submit" id="btnAoiDownload" class="btn btn-sm btn-warning noprint" data-toggle="modal" data-target="#aoiModal"><i class="fa fa-download">&nbsp;</i>Download</button> -->
								<button type="button" id="btnaoismryPrint"
									class="btn btn-sm btn-warning noprint"
									onclick="printAoiSummary('printaoiSummary');">
									<i class="fa fa-print">&nbsp;</i> Print
								</button>
								<!-- <a id="image-download" ></a> -->
							</div>
						</div>

					</div>
				</div>

				<div id="aoiAnalysisDiv">
					<div id="aoiAnalysisPrint"></div>
					<div class="custom-print-dss">
						<div class="row layout-top-spacing">
							<div class="col-md-1">
								<img src="../assets/img/odisha-logo.png" class="" alt="logo"
									height="60px" width="55px">
							</div>
							<div class="col-md-7">
								<br>
								<h5>AoI Analysis Report</h5>
							</div>
							<div class="col-md-4 text-right">
								<br> <strong>Date : </strong><span class="spDate">02.11.2021</span>
							</div>
						</div>
					</div>
					
					<div class="clearfix">
						<h6 class="mt-0 page-title mb-2">AoI Detail Report</h6>
						<button type="button" id="btnAoiViewBack"
							class="btn btn-sm btn-info pull-right">
							<i class="fa fa-chevron-left"></i>
						</button>
					</div>
					
					<h6 class="mt-0 mb-2" style="float: none">AoI Summary</h6>
					<div class="table-responsive">
						<table class="table table-bordered table-sm">
							<tbody>
								<tr>
									<td width="60%">AoI Area</td>
									<td><span id="sp_area_geom1"></span> (Ha.)</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<h6 class="mt-0 mb-2" style="float: none">Forest Land Involvement</h6>
					<div class="table-responsive">
						<table class="table table-bordered table-sm">
							<tbody>
								<tr>
									<td width="60%">Notified Forest Area</td>
									<td><span id="sp_nfb_area1"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>Recorded Forest Area</td>
									<td><span id="sp_rf_area1"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>Other Forest Area</td>
									<td><span id="sp_other_forest_area1"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>Total Forest Area</td>
									<td><span id="sp_total_forest_area1"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>Non-Forest Area</td>
									<td><span id="sp_non_forest_area1"></span> (Ha.)</td>
								</tr>
								<tr>
									<td>Total AoI Area</td>
									<td><span id="sp_total_aoi_area1"></span> (Ha.)</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<h6 class="mt-0 mb-2" style="float: none">NFB Details</h6>
					<div class="table-responsive">
						<table id="tblnfb1" class="table table-bordered table-sm">
							<thead>
								<tr>
									<th>Sl. No.</th>
									<th>Division</th>
									<th>Range</th>
									<th>Forest Block</th>
									<th>Forest Type</th>
									<th>Area in AoI</th>
								</tr>
							</thead>
							<tbody class="tbodynfb">
								<!-- <tr>
									<td>1</td>
									<td>Athamallik</td>
									<td>Handapa</td>
									<td>DPF</td>
									<td>32.383</td>
								</tr>
								<tr>
									<td>2</td>
									<td>Athamallik</td>
									<td>Handapa</td>
									<td>DPF</td>
									<td>123.617</td>
								</tr> -->
							</tbody>
						</table>
					</div>
					
					<h6 class="mt-0 mb-2" style="float: none">Sanctuary Details</h6>
					<div class="table-responsive">
						<table id="tblsanc" class="table table-bordered table-sm">
							<thead>
								<tr>
									<th>Sl. No.</th>
									<th>Name</th>
									<th>Area</th>
								</tr>
							</thead>
							<tbody class="tbodysanc">
								<!-- <tr>
									<td>1</td>
									<td>Athamallik</td>
									<td>32.383</td>
								</tr>
								<tr>
									<td>2</td>
									<td>Athamallik</td>
									<td>123.617</td>
								</tr> -->
							</tbody>
						</table>
					</div>
					
					<h6 class="mt-0 mb-2" style="float: none">ESZ Details</h6>
					<div class="table-responsive">
						<table id="tblesz" class="table table-bordered table-sm">
							<thead>
								<tr>
									<th>Sl. No.</th>
									<th>Name</th>
									<th>Area</th>
								</tr>
							</thead>
							<tbody class="tbodyesz">
								<!-- <tr>
									<td>1</td>
									<td>Athamallik</td>
									<td>32.383</td>
								</tr>
								<tr>
									<td>2</td>
									<td>Athamallik</td>
									<td>123.617</td>
								</tr> -->
							</tbody>
						</table>
					</div>
					
					
					<h6 class="mt-0 mb-2" style="float: none">DLC Forest Details</h6>
					<div class="table-responsive">
						<table id="tbldlc1" class="table table-bordered table-sm">
							<thead>
								<tr>
									<th>Sl. No.</th>
									<th>Tahasil</th>
									<th>Village</th>
									<th>Khata No.</th>
									<th>Plot No.</th>
									<th>Plot Area</th>
									<th>Area within AoI</th>
									<th>Kissam</th>
									<th>Land Type</th>
								</tr>
							</thead>
							<tbody class="tbodydlc">
								<!-- <tr>
									<td>1</td>
									<td>Athamallik</td>
									<td>Kishorenagar</td>
									<td>3137</td>
									<td>35.457</td>
									<td>23.567</td>
									<td>Junggal Dui</td>
									<td>Revenue Forest</td>
								</tr>
								<tr>
									<td>2</td>
									<td>Athamallik</td>
									<td>Kishorenagar</td>
									<td>3137</td>
									<td>35.457</td>
									<td>23.567</td>
									<td>Junggal Dui</td>
									<td>Revenue Forest</td>
								</tr> -->
							</tbody>
						</table>
					</div>

					<h6 class="mt-0 mb-2" style="float: none">Other Revenue Forest Details</h6>
					<div class="table-responsive">
						<table id="tblRev1" class="table table-bordered table-sm">
							<thead>
								<tr>
									<th>Sl. No.</th>
									<th>Tahasil</th>
									<th>Village</th>
									<th>Khata No.</th>
									<th>Plot No.</th>
									<th>Plot Area</th>
									<th>Area within AoI</th>
									<th>Kissam</th>
									<th>Land Type</th>
								</tr>
							</thead>
							<tbody class="tbodyrev">
								<!-- <tr>
									<td>1</td>
									<td>Athamallik</td>
									<td>Kishorenagar</td>
									<td>3137</td>
									<td>35.457</td>
									<td>23.567</td>
									<td>Junggal Dui</td>
									<td>Revenue Forest</td>
								</tr>
								<tr>
									<td>2</td>
									<td>Athamallik</td>
									<td>Kishorenagar</td>
									<td>3137</td>
									<td>35.457</td>
									<td>23.567</td>
									<td>Junggal Dui</td>
									<td>Revenue Forest</td>
								</tr> -->
							</tbody>
						</table>
					</div>
					

					<!-- <div class="table-responsive">
						<h6>Notified Forest</h6>
						<table id="tblnfb" class="table table-sm table-bordered">
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

							</tbody>
						</table>
					</div>

					<div class="table-responsive">
						<h6>DLC</h6>
						<table id="tbldlc" class="table table-sm table-bordered">
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

							</tbody>
						</table>
					</div>

					<div class="table-responsive">
						<h6>Other Revenue Forest</h6>
						<table id="tblrev" class="table table-sm table-bordered">
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

							</tbody>
						</table>
					</div>

					<div class="table-responsive">
						<h6>Deemed Forest</h6>
						<table id="tbldeemed" class="table table-sm table-bordered">
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

							</tbody>
						</table>
					</div> -->

					<!-- <div class="table-responsive">
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
						</div> -->

					<!-- <div class="table-responsive">
						<h6>Diverted Forest</h6>
						<table id="tbldiverted" class="table table-sm table-bordered">
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

							</tbody>
						</table>
					</div> -->

					<div class="row">
						<div class="col-md-12 text-center">
							<!-- <button type="submit" class="btn btn-sm btn-warning" data-toggle="modal" data-target="#dldModal"><i class="fa fa-download">&nbsp;</i>Download</button> -->
							<button type="button" id="btnaoianalysisPrint"
								class="btn btn-sm btn-warning"
								onclick="PrintDiv('printdivcontent');">
								<i class="fa fa-print">&nbsp;</i> Print
							</button>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>
</div>
<!--  END CONTENT AREA  -->
<div id="printdivcontent" class="main-content"
	style="display: none; width: 100%; font-color: Black;">
	<div id="divAOISummaryData"></div>
	<!-- <div class="custom-print-dss">
								<div class="row layout-top-spacing">									
									<div class="col-md-1">										
										<img src="../assets/img/odisha-logo.png" class="" alt="logo" height="60px" width="55px">																			
									</div>
									<div class="col-md-8" style="text:center;">
									<h4>Forest Land Information</h5>
										<br>
										<h5>Area of Interest(AoI) Summary</h5>
									</div>
									<div class="col-md-4 text-right">
										<br>
										<strong>Date : </strong><span class="spDate">02.11.2021</span>
									</div>									
								</div>			
							</div> -->
	<div class="table-responsive">
		<h6>Notified Forest</h6>
		<table id="tblNFBp" class="table table-sm table-bordered">
			<thead>
				<tr>
					<th>Sl. No.</th>
					<th>Division</th>
					<th>Range</th>
					<th>Forest Block</th>
					<th>Forest Type</th>
					<th>Area in AoI</th>
				</tr>
			</thead>
			<tbody class="tbodynfb">

			</tbody>
		</table>
	</div>
	<div class="table-responsive">
		<h6>DLC Forest</h6>
		<table id="tblDLCp" class="table table-sm table-bordered">
			<thead>
				<tr>
					<th>Sl. No.</th>
					<th>Tahasil</th>
					<th>Village</th>
					<!-- <th>Khata No.</th> -->
					<th>Plot No.</th>
					<th>Plot Area</th>
					<th>Area within AoI</th>
					<th>Kissam</th>
					<th>Land Type</th>
				</tr>
			</thead>
			<tbody class="tbodydlc">

			</tbody>
		</table>
	</div>
	<div class="table-responsive">
		<h6>Other Revenue Forest</h6>

		<table id="tblREVp" class="table table-sm table-bordered">
			<thead>
				<tr>
					<th>Sl. No.</th>
					<th>Tahasil</th>
					<th>Village</th>
					<th>Khata No.</th>
					<th>Plot No.</th>
					<th>Plot Area</th>
					<th>Area within AoI</th>
					<th>Kissam</th>
					<th>Land Type</th>
				</tr>
			</thead>
			<tbody class="tbodyrev">

			</tbody>
		</table>
	</div>
	
	<div class="table-responsive">
		<table id="tblsancp" class="table table-bordered table-sm">
			<thead>
				<tr>
					<th>Sl. No.</th>
					<th>Name</th>
					<th>Area</th>
				</tr>
			</thead>
			<tbody class="tbodysanc">
			<tr>
				<td colspan="6">Data Not Available</td>
			</tr>	
			</tbody>
		</table>
	</div>
					
					
	<div class="table-responsive">
		<table id="tbleszp" class="table table-bordered table-sm">
			<thead>
				<tr>
					<th>Sl. No.</th>
					<th>Name</th>
					<th>Area</th>
				</tr>
			</thead>
			<tbody class="tbodyesz">
				<tr>
					<td colspan="6">Data Not Available</td>
				</tr>	
			</tbody>
		</table>
	</div>
	<!-- <div class="table-responsive">
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
					<td colspan="6">Data Not Available</td>
				</tr>

			</tbody>
		</table>
	</div> -->


	<!-- <div class="table-responsive">
		<h6>Diverted Forest</h6>
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
					<td colspan="7">Data Not Available</td>
				</tr>
			</tbody>
		</table>
	</div> -->
	<div class="table-responsive" width="100%">
		<!-- <h6>Map View</h6> -->
			<div id="imgMap" width="100%"></div>
	</div>
	<div class="table-responsive" width="100%">
	<h6>AoI Coordinates</h6>
	<table class="table table-sm table-bordered">
			<thead>
				<tr>
					<th>Sl. No.</th>
					<th>Latitude</th>
					<th>Longitude</th>
				</tr>
			</thead>
			<tbody class="tCoordinates">
				
			</tbody>
		</table>
	</div>

</div>

<div id="printaoiSummary" class="main-content"
	style="display: none; width: 100%; font-color: Black;"></div>
<div id="printpoicontent" class="main-content"
	style="display: none; width: 100%; font-color: Black;"></div>
<!-- <div id="poiModal" class="modal fade" style="z-index:9999">
	<div class="modal-dialog modal-lg modal-lg-custom modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle" style="text-align:center;">POI Summary Information</h5>
		        <button type="button" class="close noprint" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
	        </div>
			<div class="modal-body">	
				<button class="btn btn-sm btn-warning btn-modal-custom noprint" id="btnpoiPrint"><i class"fa fa-print">&nbsp;</i>Print</button>
				<div id="divPoi"></div>
			</div>
		</div>
	</div>
</div>	 -->
<!-- <div id="aoiModal" class="modal fade" style="z-index:9999">
		<div class="modal-dialog modal-lg modal-lg-custom modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle" style="text-align:center;">AoI Summary Information</h5>
			        <button type="button" class="close noprint" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
		        </div>
				<div class="modal-body">	
					<button class="btn btn-sm btn-warning btn-modal-custom noprint" id="btnaoiPrint"><i class"fa fa-print">&nbsp;</i>Print</button>
					<div id="divAoi"></div>
			</div>
		</div>
	</div>
</div> -->
<!-- <div id="dldModal" class="modal fade" style="z-index:9999">
	<div class="modal-dialog modal-lg modal-lg-custom modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle" style="text-align:center;">AoI Forest Information</h5>
		        <button type="button" class="close noprint" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
	        </div>
			<div class="modal-body" id="divdd">		
				<button class="btn btn-sm btn-warning btn-modal-custom noprint" id="btnddlPrint"><i class"fa fa-print">&nbsp;</i>Print</button>							
			</div>
		</div>
	</div>
</div> -->

<style>
.td-bg {
	background-color: #f3f3f3 !important;
	color: #353535 !important;
}

#popup-content span {
	font-size: 13px;
}

#popup-content h5 {
	color: #077b6d;
	font-size: 14px;
	font-weight: 600;
}

#popup-content p {
	line-height: 24px;
}

#popup-content .table a {
	color: #077b6d;
	text-decoration: underline;
}

#popup-content .table a:hover {
	color: #077b6d;
	text-decoration: none;
}
</style>
<!--  <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.15.1/build/ol.js"></script> -->
<script src="/cdnLinks/cdnOL.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
<script src="https://epsg.io/32645.js"></script>
<script src="/v5.3.0-dist/32644.js"></script>
<script src="/assets/js/custom/layer_style.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.8.0/jszip.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.8.0/xlsx.js"></script>
<script src="https://unpkg.com/jsts@2.0.2/dist/jsts.min.js"></script>
<script src="https://unpkg.com/jsts@2.0.2/dist/jsts.min.js"></script>

<script type="text/javascript">
var geoserverUrl = '${geoserverUrl}';
$(document).ready(function() {
    //App.init();
    /* $("#infoModal").modal('show'); */
    $(".header-title-lg").text("FLI DSS (Area of Interest)");
});
</script>

<script>
var diverted_layer1=[],diverted_layer,deemed_layer1=[],deemed_layer,wc_layer1=[],wc_layer,esz_layer1=[],esz_layer,sanc_layer1=[],sanc_layer,river_layer1=[],river_layer,reservoir_layer1=[],reservoir_layer,road_layer1=[],road_layer,rail_layer1=[],rail_layer,wp_raster1=[],village_layer,village_layer1=[],beat_layer,beat_layer1=[],dlc_layer,dlc_layer1
,statebndrylayer,districtbndrylayer,rng_layer,tahasil_layer,osm_raster,osm_raster1,si_raster,si_raster1,wp_raster
,tah_layer1 = [],rng_layer1=[],layerOrderList=[];
layerOrderList=[
	"si_raster",
	"dlc_layer",
	"nf_layer",	
	"village_layer",
	"rng_layer",
	"tahasil_layer",
	"districtbndrylayer",
	"statebndrylayer",
	"wp_raster"];
	
dlc_layer1=[];
osm_raster1=[];
si_raster1=[];
var nfb_layer;
var nfb_layer1=[];
var rf_layer;
var layerinfo;
var propArray=[];
var vectorSource1;
vectorSource1 = new ol.source.Vector({
});
 var vectorSource2 = new ol.source.Vector({
});
var polygonDraw,kmlLayer;
var polygonsource = new ol.source.Vector({wrapX: false});
var source = new ol.source.Vector();
var coordinates=[];
statebndrylayer = new ol.layer.Image({
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

districtbndrylayer = new ol.layer.Image({
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
//All Division
/*  var alldivboundarylayer = new ol.layer.Image({
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
}); */

 //State Boundary Layer Checkbox Change Event
   $("#chkState").change(function() {
       if(this.checked) {    
    	   statebndrylayer.setVisible(true);
   } 
   else{
	   statebndrylayer.setVisible(false);
   }
   }); 
 //District Boundary Layer Checkbox Change Event
   $("#chkDistrict").change(function() {
       if(this.checked) { 
    	districtbndrylayer.setVisible(true);
   }
   else{
	   districtbndrylayer.setVisible(false);
   } 
});
  
   
    //Notified Boundary Layer Checkbox Change Event
       $("#chkNf").change(function() {    	 
       if(this.checked) {        	   
    	   if(nfb_layer!=undefined){
    		   nfb_layer.setVisible(true);
    	   }
   }
   else{
	   nfb_layer.setVisible(false);
   } 
}); 
       //DLC & Rev Boundary Layer Checkbox Change Event
      $("#chkDlc").change(function() {    	 
       if(this.checked) {        	   
    	   if(dlc_layer!=undefined){
    		   dlc_layer.setVisible(true);
    	   }
   }
   else{
	   dlc_layer.setVisible(false);
   } 
});
    // Rev Boundary Layer Checkbox Change Event
     $("#chkRev").change(function() {    	 
      if(this.checked) {      	   
   	   if(rev_layer!=undefined){
   		   rev_layer.setVisible(true);
   	   }	
  }
  else{
	   rev_layer.setVisible(false);
  } 
});

    
   //Base layer 
 	var baselayer = new ol.layer.Tile({
 	    source: new ol.source.OSM(),
 	    visible:true,
 	    crossOrigin: 'anonymous'
 	    });

 	var rasterImage = new ol.layer.Image({
 	    title: 'OSM',
 	    type: 'base',
 	    visible: false,
 	    source: new ol.source.BingMaps({
 	        imagerySet: 'AerialWithLabels',
 	        key: 'voi3DlahFqo0MOrFalC2~6BX9iFreRSXk_hCsSHtZ0A~AuXzxBFu7NJaGwZO6oX2bEbHUKwhiif5YTYYqOZvgRiSl3Rt2zrcB6Addylvwat9'
 	    }),
 	    visible:false,
 	}); 

 	var googleLayerSatelliteImage =new ol.layer.Tile({
 	    title: "Google Satellite",
 	    source: new ol.source.TileImage({ url: 'https://mt1.google.com/vt/lyrs=s&hl=pl&&x={x}&y={y}&z={z}', crossOrigin: 'anonymous'}),
 	    visible:false
 	});
 	var googleLayerStreetImage =new ol.layer.Tile({
 	    title: "Google Street",
 	    source: new ol.source.TileImage({ url: 'https://mt1.google.com/vt/lyrs=r&hl=pl&&x={x}&y={y}&z={z}', crossOrigin: 'anonymous'}),
 	    visible:false
 	});
 	
 	//Base map Click 
 	   $("#rdblank_basemap").click(function(){
 		  
 	   	    baselayer.setVisible(false);
 	        googleLayerSatelliteImage.setVisible(false);
 	        googleLayerStreetImage.setVisible(false);
 	        
 	   });
 	   $("#rdimagery_basemap").click(function(){
 		  
 	  	baselayer.setVisible(false);
 	    googleLayerSatelliteImage.setVisible(true);
 	    googleLayerStreetImage.setVisible(false);
 	     
 	  });
 	   $("#rdosm_basemap").click(function(){
 		   
 	  	baselayer.setVisible(true);
 	    googleLayerSatelliteImage.setVisible(false);
 	    googleLayerStreetImage.setVisible(false);
 	  });
 	/*  $("#osm_basemap").click(function(){
 		   alert("osm_basemap");
 	    googleLayerSatellite.setVisible(false);
 	    googleLayerStreet.setVisible(false);
 	    baselayer.setVisible(true);
 	  }); */
 	 
 	   //End Base map click
 var highlightOverlay =  new ol.layer.Vector({
  // style: (customize your highlight style here),
 // source: source,
}); 
 var selectClick = new ol.interaction.Select({
	  /* condition: new ol.events.condition.click, */
	});
 //console.log(wp_raster);alldivboundarylayer
 var map = new ol.Map({
	    layers: [baselayer,rasterImage,googleLayerStreetImage,googleLayerSatelliteImage,districtbndrylayer,statebndrylayer,highlightOverlay],
	   // layers: [googleLayerSatelliteImage,districtbndrylayer,statebndrylayer,highlightOverlay],
	    target: 'map',
	    view: new ol.View({
	        center: ol.proj.fromLonLat([84.6525554,20.1664539]),
	        zoom: 6.89,
	        maxZoom: 20,
	        minZoom: 5
	    })
	});
 map.addInteraction(selectClick);
 
 //OverLay
 var container = document.getElementById('popup');
 //console.log(container);
 var content = document.getElementById('popup-content');
 //console.log(content);
 //console.log($("#popup-content").html());
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
 

 var scaleLine = new ol.control.ScaleLine({bar: true, text: true, minWidth: 140,steps:4});
 map.addControl(scaleLine); 
                    

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

	 $(document).ready(function() {
		
		//$("#areaDiv").hide();
		//$("#locationDiv").show();
		var today = new Date();
		$(".spDate").text(formatDate(today));
		document.getElementById('locationDiv').style.display ='block';
		$("#layerTab").hide();
		$("#divImport").hide();
		document.getElementById('poiSummaryDiv').style.display ='none';
		document.getElementById('aoiSummaryDiv').style.display ='none';
		document.getElementById('aoiAnalysisDiv').style.display ='none';
    }); 
	 function formatDate(date) {
		    var d = new Date(date),
		        month = '' + (d.getMonth() + 1),
		        day = '' + d.getDate(),
		        year = d.getFullYear();

		    if (month.length < 2) 
		        month = '0' + month;
		    if (day.length < 2) 
		        day = '0' + day;

		    return [day, month, year].join('-');
		}

	  function show1(){
		  document.getElementById('areaDiv').style.display ='none';
		  document.getElementById('locationDiv').style.display ='block';
		  $("#radioArea").prop('checked', false);
		}
		
		function show2(){
		  document.getElementById('locationDiv').style.display = 'none';
		  document.getElementById('areaDiv').style.display = 'block';
		  $("#radioLocation").prop('checked', false);
		}
		
		
		//Lat Long Button submit
		 $("#btnShowMap").click(function (event) {
			 var points=[];
			 var lati = $('#latitude').val();
			 var longi= $('#longitude').val();
			 
			if(lati!=null && lati!='' && longi!=null && longi!='')
			{
			 vectorSource1.clear();
			 
			 		       var feature=  new ol.Feature({
			 		           geometry: new ol.geom.Point(ol.proj.transform([longi,lati], 'EPSG:4326', 'EPSG:3857')),
			 		       }); 
			 		       points.push(feature);  
			 		       
						vectorSource1.addFeatures(points);
			 		    latlongLayer = new ol.layer.Vector({
			 		        source:vectorSource1,
			 		        title: 'latlongLayer',
			 		       style:function(feature, resolution){
			 		                var acceptedStyle=new ol.style.Style({
			 		                            image: new ol.style.Circle({
			 		                            radius: 6,
			 		                            stroke: new ol.style.Stroke({
			 		                                color: 'white',
			 		                                width: 2
			 		                            }),
			 		                            fill: new ol.style.Fill({
			 		                                    color: 'Blue'
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
			 		                            //text:feature.get('plr_no').toString()
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
			 		                   // text:feature.get('plr_no').toString()
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
			 		                   // text:feature.get('plr_no').toString()
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
			 		  
			 		   if(latlongLayer!=null)
			 		  	{   
			 		    	try{
			 		    		map.addLayer(latlongLayer);
			 		    		latlongLayer.setVisible(true);
			 		    	      //zoomLayer(url, zoom);
			 		    	}catch(error){
			 		    		alert(error);
			 		    	}	
			 		      
			 		  	} 
			 		    else{
			 		    	alert('Latlonglayer is null');
			 		    }
			}
			else
			{
				viewNotification(12);
			}
		 });
		//Latlong end
		
		
		
		map.on('click', function(evt){
			//content.innerHTML = '';
		    //console.info(evt.pixel);
		    //console.info(map.getPixelFromCoordinate(evt.coordinate));
		    vectorSource2.clear();
		    //console.info(ol.proj.toLonLat(evt.coordinate));
		    
		
		    if ($("#radioLocation").is(":checked"))
		    	{
		    	 var coords = ol.proj.toLonLat(evt.coordinate);
				    var lat = coords[1];
				    var lon = coords[0];
				    
				    $('#latitude').val(lat);
				    $('#longitude').val(lon);
				    
				    $("#btnShowMap" ).trigger( "click");
		    	}
		    else
		    	{
		    	
		    	}
		    
		    
		    
		    //Showing Details on pop up click
		    var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature, layer) {
       			return feature;
   			});
   
		   var layer = map.forEachFeatureAtPixel(evt.pixel, function(feature, layer) {
		       return layer;
		   });
   			
		    if (feature) 
		   {
		  	 var props= feature.getProperties();   
		  	 //console.log(props);
		      	if(props!=null)
			   {
			       if(props.forest_type == "NFB")
			       {
				       content.innerHTML = "<h5>Forest Block Details</h5>"
				       +"<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'>"
				       +"<tr><td>Division Name</td><td>"+props.div_name+"</td></tr>"
				       +"<tr><td>Range Name</td><td>"+props.range_name+"</td></tr>"
				       +"<tr><td>FB Name</td><td>"+props.fb_name+"</td></tr>"
				       +"<tr><td>FB Type</td><td>"+props.fb_type+"</td></tr>"
				       +"<tr><td>Area (Ha)</td><td>"+props.nfb_area_ha.toFixed(3)+"</td></tr></table></div>";
				       overlay.setPosition(evt.coordinate);
			       }
			       else if(props.forest_type=="DLC")
		    	   {
			    	   content.innerHTML = "<h5>DLC Forest Details</h5>"
			    		   +"<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'>"
			 		       +"<tr><td>District</td><td>"+props.dist_name+"</td></tr>"
			 		       +"<tr><td>Tahasil</td><td>"+props.tahasil+"</td></tr>"
			 		       +"<tr><td>Village</td><td>"+props.village+"</td></tr>"
			 		       //+"<tr><td>Khata No.</td><td>"+props.khata_no+"</td></tr>"
			 		       +"<tr><td>Plot No.</td><td>"+props.plot_no+"</td></tr>"
			 		       +"<tr><td>Kissam</td><td>"+props.kissam+"</td></tr>"
			 		       +"<tr><td>Area (Acre)</td><td>"+(props.plot_area_ac*2.471).toFixed(3)+"</td></tr></table></div>";
			 		       overlay.setPosition(evt.coordinate);
		    	   }
			       else if(props.forest_type=="REV")
		    	   {
			    	   content.innerHTML = "<h5>Other Revenue Forest Details</h5>"
			    		   +"<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'>"
			 		       +"<tr><td>District</td><td>"+props.dist_name+"</td></tr>"
			 		       +"<tr><td>Tahasil</td><td>"+props.tahasil+"</td></tr>"
			 		       +"<tr><td>Village</td><td>"+props.village+"</td></tr>"
			 		       +"<tr><td>Plot No.</td><td>"+props.plot_no+"</td></tr>"
			 		       +"<tr><td>Kissam</td><td>"+props.kissam+"</td></tr>"
			 		       +"<tr><td>Area (Acre)</td><td>"+(props.plot_area_ac*2.471).toFixed(3)+"</td></tr></table></div>";
			 		       overlay.setPosition(evt.coordinate);
		    	   }
			   } 
		   } 
		   else
		   {
		       overlay.setPosition(undefined);                        
		   } 
		});
		
		
		//Location radio button check 
		 if ($("#radioLocation").is(":checked")) 
		 { 
			 $("#btnShowMap").click(function (event) {
				 document.getElementById('poiDiv').style.display ='inline-block';
				
			 });
		 }
		 else if($("#radioArea").is(":checked")) 
		 {
			 document.getElementById('poiDiv').style.display ='none';
			 document.getElementById('aoiDiv').style.display ='inline-block';
		 }
	
		
		 $('input[type=radio][name=radiobutton]').change(function() {
			 vectorSource1.clear();
			 polygonsource.clear();
			 source.clear();
			 removeAllLayers();
			 document.getElementById('queryBtn').style.display ='none';
			 document.getElementById('queryContent').style.display ='none';
			 $('#txtbuffer').val('');
			 $('#upldkml').val('');
			 $('#upldshp').val('');
			 $('#upldfile').val(''); 
			//$("#queryBtn" ).trigger( "click");
			 $("#layerTab").hide();
			    if (this.value == 'loc') 
			    {
			        //alert("poi");
			        document.getElementById('aoiDiv').style.display ='none';
					document.getElementById('poiDiv').style.display ='none';
					document.getElementById('kmlDiv').style.display ='none';

					$('#latitude').val('');
					$('#longitude').val('');
					
			        $("#btnShowMap").click(function (event) {
			        	 document.getElementById('aoiDiv').style.display ='none';
						 document.getElementById('poiDiv').style.display ='inline-block';
					 });
			    }
			    else if (this.value == 'area') 
			    {
			         //alert("AoI");
			         document.getElementById('poiDiv').style.display ='none';
					 document.getElementById('aoiDiv').style.display ='none';
					 document.getElementById('kmlDiv').style.display ='none';
			    }
			});
		 
		 $("#btnShowMapArea").click(function (event) {
        	 
			  document.getElementById('poiDiv').style.display ='none';
				 document.getElementById('aoiDiv').style.display ='none';
			 if(polygonsource.getFeatures().length>0)
				 {
				// var extent = polygonsource.getExtent();      
				 map.getView().fit(polygonsource.getExtent(), { duration: 2000 });            
				//map.getView().fit(extent, map.getSize());  
				 document.getElementById('aoiDiv').style.display ='inline-block';
				 }
			 else{
				 alert("Draw/Import a polygon to view on map");
			 }
		 });
		 //Clear button click
		 $("#btnClear").click(function (event) {
			 $('#latitude').val('');
			 $('#longitude').val('');
			 $("#layerTab").hide();
			 document.getElementById('poiDiv').style.display ='none';
			 document.getElementById('queryBtn').style.display ='none';
			 document.getElementById('queryContent').style.display ='none';
			 document.getElementById('kmlDiv').style.display ='none';
			 vectorSource1.clear();
			 removeAllLayers();
		 });
		 
		 function  removeAllLayers(){
			 map.removeLayer(nfb_layer);
			 map.removeLayer(dlc_layer);
			 map.removeLayer(rev_layer);
			 map.removeLayer(rng_layer);
			 map.removeLayer(tahasil_layer);
			 map.removeLayer(osm_raster);
			 map.removeLayer(divlayer);
			 if (village_layer1.length > 0) {
					village_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			 if (tah_layer1.length > 0) {
					tah_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			 $(".layerchk").prop('checked', false);
			 $("#chkState").prop('checked', true);
			 $("#chkDistrict").prop('checked', true);
			 statebndrylayer.setVisible(true);
			 districtbndrylayer.setVisible(true);
			 
		 }
		 //clear Button for Area
		 $("#btnClearArea").click(function (event) {
			 
			 $("#layerTab").hide();
			 $('#txtbuffer').val('');
			 $('#upldkml').val('');
			 $('#upldshp').val('');
			 $('#upldfile').val(''); 
			 document.getElementById('aoiDiv').style.display ='none';
			 document.getElementById('queryBtn').style.display ='none';
			 document.getElementById('queryContent').style.display ='none';
			 document.getElementById('kmlDiv').style.display ='none';
			 map.removeLayer(polygonDraw);
			 map.removeInteraction(polygonDraw);
			 polygonsource.clear();
			 source.clear();
			 removeAllLayers();
		 });
		 
		 //poi Analysis Button click
		 $("#btnpoiAnalysis").click(function (event) {
			 $("#layerTab").hide();
			 PoiAnalysis();
			 getPOIGeom();
			 document.getElementById('poiSummaryDiv').style.display ='inline-block';
			 //document.getElementById('queryBtn').style.display ='block';
			 document.getElementById('aoiSummaryDiv').style.display ='none';
			 document.getElementById('aoiAnalysisDiv').style.display ='none';
			 document.getElementById('kmlDiv').style.display ='inline-block';//here i have set display to block/to show after clicking the poi analysis button
			 //$("#queryBtn" ).trigger( "click");
		 });
		 
		 //KML download of Area and Point
			$("#btnaoiKML").click(function (event) {
			if ($("#radioLocation").is(":checked")){
				//alert("loc")
				downloadPOIkml();
			}			 
			else if ($("#radioArea").is(":checked")) {
				//alert("area")				
				downloadAOIkml();
			}
			 });
		
		 //aoi Analysis Button click
		 $("#btnaoiAnalysis").click(function (event) {
			 $(".apploader-base").css("display", "inline-block");
			 map.getView().fit(polygonsource.getExtent(), { duration: 2000 }); 
			 setTimeout(function(){ 
				  removeAllLayers();
				 $("#layerTab").hide();
				 AoiAnalysis();
				 
				 if($("#txtbuffer").val()!=""){
					 AoiBufferAnalysis();
				 }
				 getAOIGeom();
				 
				 document.getElementById('aoiSummaryDiv').style.display ='inline-block';
				 document.getElementById('poiSummaryDiv').style.display ='none';
				 document.getElementById('aoiAnalysisDiv').style.display ='none';
				 document.getElementById('kmlDiv').style.display ='inline-block';//here i have set display to block/to show after clicking the AOI analysis button

				 getAOIAnalysis();
			 }, 100);
			 
			 //document.getElementById('queryBtn').style.display ='block';
				//$("#queryBtn" ).trigger( "click");
			 
		 });
		 
		 //show aoi analysis view on click of aoi view button
		 
		 $("#btnAoiView").click(function (event) {
			 document.getElementById('aoiAnalysisDiv').style.display ='block';
			 document.getElementById('aoiSummaryDiv').style.display ='none';
			 //getAOIAnalysis();
		 });
		 $("#btnAoiViewBack").click(function (event) {
			 document.getElementById('aoiAnalysisDiv').style.display ='none';
			 document.getElementById('aoiSummaryDiv').style.display ='block';
			 //getAOIAnalysis();
		 });
		 //hide and show import div
		  $("#btnimportPoly").click(function (event) {
			 $("#divImport").show();
		 });
		 //hide and show draw ploygon div
		  $("#btndrawPoly").click(function (event) {
			 // polygonsource = new ol.source.Vector({wrapX: false});
			 polygonsource.clear();
			 $("#divImport").hide();
			 addPolygonInteraction();
		 });
		
		 //Button show on map for area
		  $("#btnShowMap").click(function (event) {
		  		polygonsource.clear();
		  		
		  });
		 
		 //KML Tab Click 
		 $("#kml-tab").click(function (event) {
			 $('#upldshp').val('');
			 $('#upldfile').val('');
		  });
		
		 //Shape tab
		 $("#shp-tab").click(function (event) {
			 $('#upldkml').val('');
			 $('#upldfile').val(''); 
		  });
		 
		 //Coordinate File Tab
		 $("#file-tab").click(function (event) {
			 $('#upldkml').val('');
			 $('#upldshp').val(''); 
		  });
		 
		 //Set Min Max Buffer Zone
		 $(function () {
			    var limitInput = function () {
			        var value = parseInt(this.value,10);
			        var max = parseInt(this.max, 10);
			        var min = parseInt(this.min, 10);

			        if (value > max) {
			            this.value = max;
			        } else if (value < min) {
			            this.value = min
			        }
			    };
			    $("#txtbuffer").change(limitInput);
			});
		 
		 //Validate Excel File
		 function validate() {  
            var array = ['xls', 'xlsx'];  
           var xyz=  document.getElementById("upldfile");  
            var Extension = xyz.value.substring(xyz.value.lastIndexOf('.') + 1).toLowerCase();  
  
            if (array.indexOf(Extension) <= -1) {  
                alert("Please Upload only xls,xlsx extension flle");  
                $("#upldfile").val(''); 
                return false;  
            }
            return true;
		 }
		 //Validate Excel File
		 function validateKMLFile() {  
            var array = ['kml'];  
           var xyz=  document.getElementById("upldkml");  
            var Extension = xyz.value.substring(xyz.value.lastIndexOf('.') + 1).toLowerCase();  
  
            if (array.indexOf(Extension) <= -1) {  
               // alert("Please Upload kml file");  
                $("#upldkml").val(''); 
                return false;  
            }
            return true;
		 }
		 var divlayer;
		//Division boundary Checkbox Change Event
		$("#chkDivision").change(function() {
			//console.log(divArr);
			if (this.checked) {
				$.ajax({
					async: false,
					url: '/Utility/getDivisionVectorMapTypeLayerList',
					data: { 'distid': 0, 'divids': divArr, 'type': 3 },
					type: "GET",
					contentType: "application/json;charset=utf-8",
					dataType: "json",
					success: function(data) {
							//console.log(data);
						var arrayLength = data.length;
						for (var i = 0; i < arrayLength; i++) {
							divlayer = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: data[i].strValue,
									params: {
										'layers': data[i].text,
										'version': '1.1.0'
										// 'CQL_FILTER':"DIV_ID="+$("#drpDivision").val()
									},
									serverType: 'geoserver',
									crossOrigin: 'anonymous'

								}),
								title: 'DivisionBoundary',
								visible: true
							});

							map.addLayer(divlayer);
							//console.log(data[i].text);
						}
					},
					error: function(errormessage) {
						alert(errormessage.responseText);
					}
				});	

			}
			else {
				map.getLayers().forEach(function(element, index, array) {
								if (element.get('title') === 'DivisionBoundary') {
									if (element != null) {
										element.setVisible(false);

									}
								}
							});
				map.removeLayer(divlayer);
			}

		});
		
		//Tehsil Layer Bind on check box change
		$("#chkTehsil").on("click", function(event) {
			
			if (!$("#chkTehsil").is(":checked")) {
				
				//map.removeLayer(eval(tah_layer));
				//console.log(tah_layer1.length);
				if (tah_layer1.length > 0) {
					tah_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 19 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									tehLayernm = obj[i].text;
									//console.log(obj);

									var tah_layer;
									tah_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': tehLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									tah_layer1.push(tah_layer);
									
									//console.log(i);
									//console.log(tah_layer1);
									if (i == arrayLength - 1) {
										if (tah_layer1.length > 0) {
											tah_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Tahasil Boundary  is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					/* viewNotification(2); */
					return false;
				}
			}
		});
		//End of Tahasil
		
		//Range Layer Bind on check box change
		$("#chkRange").on("click", function(event) {
			
			if (!$("#chkRange").is(":checked")) {
				
				
				if (rng_layer1.length > 0) {
					rng_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 9 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									rngLayernm = obj[i].text;
									//console.log(rngLayernm);

									rng_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': rngLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									rng_layer1.push(rng_layer);
									
									//console.log(i);
									//console.log(tah_layer1);
									if (i == arrayLength - 1) {
										if (rng_layer1.length > 0) {
											rng_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Range Boundary  is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					/* viewNotification(2); */
					return false;
				}
			}
		});
		
		
		//Village Layer Bind on check box change
		$("#chkvillage_layer").on("click", function(event) {
			if (!$("#chkvillage_layer").is(":checked")) {
				
				
				if (village_layer1.length > 0) {
					village_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 14 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									villLayernm = obj[i].text;

									village_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': villLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									village_layer1.push(village_layer);
									
									//console.log(i);
									//console.log(tah_layer1);
									if (i == arrayLength - 1) {
										if (village_layer1.length > 0) {
											village_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Village Boundary  is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					/* viewNotification(2); */
					return false;
				}
			}
		});
		
		//Beat Layer Bind on check box change
		$("#chkBeat").on("click", function(event) {
			if (!$("#chkBeat").is(":checked")) {
				
				
				if (beat_layer1.length > 0) {
					beat_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 1 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									beatLayernm = obj[i].text;

									beat_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': beatLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									beat_layer1.push(beat_layer);
									
									//console.log(i);
									//console.log(tah_layer1);
									if (i == arrayLength - 1) {
										if (beat_layer1.length > 0) {
											beat_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Beat Boundary  is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					/* viewNotification(2); */
					return false;
				}
			}
		});
			
		//Onclick of Beat CheckBox   
		/* $("#chkBeat").on("click", function (event) {
			if (!$("#chkBeat").is(":checked")) {
				beat_layer.setVisible(false);
			}
			else {
				if (did!=0) {
					map.removeLayer(beat_layer);	
					beatLayernm = "";
					$.ajax({
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 1 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function (obj) {
							console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
								beatLayernm = obj[i].text;
								console.log(beatLayernm);
								var query = "";
								 if (divids != "") {
									query = "div_id=" + divArr;
								} 
								if (query != "") {
									beat_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[0].strValue,
											params: {
												'LAYERS': obj[i].text,
												'VERSION': '1.1.0',
												'CQL_FILTER': query
											},
											serverType: 'geoserver'
										})
									});
								}
								else {
									beat_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': obj[i].text,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
								}
								if (beat_layer != null) {
									//map.addLayer(beat_layer);
									if ($("#chkBeat").is(":checked")) {
										//LayerOrdering();
										beat_layer.setVisible(true);
									}
									else {
										beat_layer.setVisible(false);
									}

								 }
								}
								else {
									//AlertNotify("Village Boundary of "+$( "#ddlRange option:selected" ).text()+" range is not available.")
								}
							}

						},
						error: function (xhr, status) {

						}
					});
				}
				else {
					viewNotification(3);
					return false;
				}
			}
		}); */
		
		
	//Check River
		$("#checkRiver").on("click", function(event) {
			if (!$("#checkRiver").is(":checked")) {
				
				
				if (river_layer1.length > 0) {
					river_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 32 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									riverLayernm = obj[i].text;

									river_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': riverLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									river_layer1.push(river_layer);
									
									
									if (i == arrayLength - 1) {
										if (river_layer1.length > 0) {
											river_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("River  is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					 //viewNotification(2);
					return false;
				}
			}
		});
		//End River
		
	//Check Reservoir
		$("#checkReservoir").on("click", function(event) {
			if (!$("#checkReservoir").is(":checked")) {
				
				
				if (reservoir_layer1.length > 0) {
					reservoir_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 32 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									resrLayernm = obj[i].text;

									reservoir_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': resrLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									reservoir_layer1.push(reservoir_layer);
									
									
									if (i == arrayLength - 1) {
										if (reservoir_layer1.length > 0) {
											reservoir_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Reservoir  is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					 //viewNotification(2);
					return false;
				}
			}
		});
		//End Reservoir
			
	//Check Rail
		$("#checkRail").on("click", function(event) {
			if (!$("#checkRail").is(":checked")) {
				
				
				if (rail_layer1.length > 0) {
					rail_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 33 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									railLayernm = obj[i].text;

									rail_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': railLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									rail_layer1.push(rail_layer);
									
									
									if (i == arrayLength - 1) {
										if (rail_layer1.length > 0) {
											rail_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Rail  is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					 //viewNotification(2);
					return false;
				}
			}
		});
		//End Rail
	
	//Check Road
		$("#checkRoad").on("click", function(event) {
			if (!$("#checkRoad").is(":checked")) {
				
				
				if (road_layer1.length > 0) {
					road_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 34 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									roadLayernm = obj[i].text;

									road_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': roadLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									road_layer1.push(road_layer);
									
									
									if (i == arrayLength - 1) {
										if (road_layer1.length > 0) {
											road_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Road  is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					 //viewNotification(2);
					return false;
				}
			}
		});
		//End Road
	
	//Sanctuary Layer Bind on check box change
		$("#checkSanc").on("click", function(event) {
			if (!$("#checkSanc").is(":checked")) {
				
				
				if (sanc_layer1.length > 0) {
					sanc_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 35 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									sancLayernm = obj[i].text;

									sanc_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': sancLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									sanc_layer1.push(sanc_layer);
									
									
									if (i == arrayLength - 1) {
										if (sanc_layer1.length > 0) {
											sanc_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Sanctuary Boundary  is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					 //viewNotification(2);
					return false;
				}
			}
		});
	//end of Sanctuary
	
	//Eco Sensitive Zone Layer Bind on check box change
		$("#checkESZ").on("click", function(event) {
			if (!$("#checkESZ").is(":checked")) {
				
				
				if (esz_layer1.length > 0) {
					esz_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 36 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									eszLayernm = obj[i].text;

									esz_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': eszLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									esz_layer1.push(esz_layer);
									
									
									if (i == arrayLength - 1) {
										if (esz_layer1.length > 0) {
											esz_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("ESZ Boundary  is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					//viewNotification(2);
					return false;
				}
			}
		});
	//end of ESZ
	
	//Wildlife Corridor Layer Bind on check box change
		$("#checkWC").on("click", function(event) {
			if (!$("#checkWC").is(":checked")) {
				
				
				if (wc_layer1.length > 0) {
					wc_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 37 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									wcLayernm = obj[i].text;

									wc_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': wcLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									wc_layer1.push(wc_layer);
									
									
									if (i == arrayLength - 1) {
										if (wc_layer1.length > 0) {
											wc_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Willife Corridor is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					 //viewNotification(2); 
					return false;
				}
			}
		});
	//end of ESZ
	
	//Wildlife Corridor Layer Bind on check box change
		$("#checkWC").on("click", function(event) {
			if (!$("#checkWC").is(":checked")) {
				
				
				if (wc_layer1.length > 0) {
					wc_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 37 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									wcLayernm = obj[i].text;

									wc_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': wcLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									wc_layer1.push(wc_layer);
									
									
									if (i == arrayLength - 1) {
										if (wc_layer1.length > 0) {
											wc_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Wildlife Corridor is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					viewNotification(2);
					return false;
				}
			}
		});
	//end of WC
	
	
	//Deemed Forest Bind on check box change
		$("#checkDeemed").on("click", function(event) {
			if (!$("#checkDeemed").is(":checked")) {
				
				
				if (deemed_layer1.length > 0) {
					deemed_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0, 'divids': divArr, 'type': 38 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									deemedLayernm = obj[i].text;

									deemed_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': deemedLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									deemed_layer1.push(deemed_layer);
									
									
									if (i == arrayLength - 1) {
										if (deemed_layer1.length > 0) {
											deemed_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Deemed Forest is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					viewNotification(2);
					return false;
				}
			}
		});
	//end ofDeemed Forest
	
	//Diverted Forest Bind on check box change
		$("#checkDiverted").on("click", function(event) {
			if (!$("#checkDiverted").is(":checked")) {
				
				
				if (diverted_layer1.length > 0) {
					diverted_layer1.forEach(function(item) {
						map.removeLayer(item);
					});
				}
			}
			else {
				if (did!=0) 
				{
					$.ajax({
						async: false,
						url: '/Utility/getDivisionVectorMapTypeLayerList',
						data: { 'distid': 0,'divids': divArr, 'type': 39 },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function(obj) {
							//console.log(obj);
							if (obj != null) {
								var myStringArray = obj;
								var arrayLength = obj.length;
								for (var i = 0; i < arrayLength; i++) {
									divertedLayernm = obj[i].text;

									diverted_layer = new ol.layer.Image({
										source: new ol.source.ImageWMS({
											url: obj[i].strValue,
											params: {
												'LAYERS': divertedLayernm,
												'VERSION': '1.1.0'
											},
											serverType: 'geoserver'
										})
									});
									diverted_layer1.push(diverted_layer);
									
									
									if (i == arrayLength - 1) {
										if (diverted_layer1.length > 0) {
											diverted_layer1.forEach(function(item) {
												map.addLayer(item);
												//console.log(item);
												item.setVisible(true);
											});

										}
									}

								}
							}
							else {
								AlertNotify("Diverted Forest is not available.")
							}
						},
						error: function(xhr, status) {

						}
					});
				}
				else {

					viewNotification(2);
					return false;
				}
			}
		});
	//end ofDeemed Forest
	
	//start of print
	/* $( "#btnddlPrint" ).click(function() {
		$("#printdivcontent").show();
		// const modalBody = $("#dldModal").detach();
		$("#printdivcontent").html($('#divdd').html());
		$('#dldModal').modal('toggle');
		$("#content").hide(); 
  			window.print();
  			$("#printdivcontent").html("");
  			$("#printdivcontent").hide();
  			$("#content").show();
		}); */
	/* $( "#btnpoiPrint" ).click(function() {
			window.print();
	}); */
	/* $( "#btnaoiPrint" ).click(function() {
		$("#printaoiSummary").show();
		$("#content").hide();
			window.print();
		$("#printaoiSummary").html("");
		$("#printaoiSummary").hide();
		$("#content").show();
	}); */
	/* $("#poiDownload").click(function() {
			$("#divPoi").html($("#poiSummaryDiv").html());
	});
	
	$("#btnAoiDownload").click(function() {
			$("#divAoi").html($("#aoiSummaryDiv").html());
	}); */
	 
	//print AoI Analysis
	function PrintDiv(printdivcontent) { 
		
		 var printContents = document.getElementById(printdivcontent).innerHTML;
        $("#content").hide(); 
        setTimeout(function(){
		$("#printdivcontent").show();
		
	     window.print();
	     $("#printdivcontent").hide();
	    // document.body.innerHTML = originalContents;
	     $("#content").show();
        }, 200);
    }  
	
	 //print AoI Summary
	 function printAoiSummary(printaoiSummary)
	 {
		 var printaoismry = document.getElementById(printaoiSummary).innerHTML;
		// $("#printaoiSummary").html($("#aoiSummaryDiv").html());
		 
		 $("#divAOISummaryData").html($("#aoiSummaryDiv").html());
		 setTimeout(function(){
		 $("#content").hide(); 
        // $("#printaoiSummary").show();
         $("#printdivcontent").show();
         window.print();
         $("#divAOISummaryData").html("");
        // $("#printaoiSummary").hide();

         $("#printdivcontent").hide();
         $("#content").show();
		 }, 2000);
	 }
	
	//print PoI Summary
	 function PrintPOISummary(printpoicontent)
	 {
		 var printpoismry = document.getElementById(printpoicontent).innerHTML;
         
         $("#printpoicontent").html($("#poiSummaryDiv").html());
         $("#content").hide(); 
         $("#printpoicontent").show();
        /*  $("#collapse11").addClass("show");
         $("#collapse11-1").addClass("show");
         $("#collapse12").addClass("show");
         $("#collapse13").addClass("show");
         $("#collapse14").addClass("show");
         $("#collapse15").addClass("show");
         $("#collapse16").addClass("show");
         $("#collapse17").addClass("show");
         $("#collapse18").addClass("show"); */
         $("#collapse11, #collapse11-1,#collapse12,#collapse13,#collapse14,#collapse15,#collapse16,#collapse17,#collapse18",).addClass("show");
         $("#content").show();
         
         //print();
         setTimeout(function(){
             window.print();
             $("#printpoicontent").html("");
             $("#printpoicontent").hide();
             $("#content").show();
		}, 2000);        
	 }
	/* function print()
	{
		setTimeout(function(){
		window.print();
        $("#printpoicontent").html("");
        $("#printpoicontent").hide();
         $("#content").show();
}, 200);
	} */
	
	
	</script>
<!-- end of print -->
<script>
		function toggler(divId) {
		    $("#" + divId).toggle();
		}
</script>
<script>
	$('#show-more-content').hide();

	$('#show-more').click(function(){
		$('#show-more-content').show(300);
		$('#show-less').show();
		$('#show-more').hide();
	});

	$('#show-less').click(function(){
		$('#show-more-content').hide(150);
		$('#show-more').show();
		$(this).hide();
	});
	</script>
<script src="/assets/js/apps/aoiAnalysis.js"></script>
<script src="/assets/js/tokml.js"></script>
<%@ include file="../shared/footer.jsp"%>
