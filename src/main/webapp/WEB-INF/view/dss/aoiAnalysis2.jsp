<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>


<link rel="stylesheet" href="/libs/v6.6.1-dist/ol.css" type="text/css">
<script src="/libs/dist/elm-pep.js"></script>
<!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
<script
	src="https://cdn.polyfill.io/v3/polyfill.min.js?features=fetch,requestAnimationFrame,Element.prototype.classList,URL,TextDecoder"></script>
<script
	src="https://unpkg.com/dom-to-image-more@2.8.0/dist/dom-to-image-more.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script src="https://unpkg.com/elm-pep"></script>

<link rel="stylesheet" href="/assets/css/apps/aoiAnalysis.css"
	type="text/css">

<tl:eval expression="@environment.getProperty('api.geoserverurl')"
	var="geoserverUrl"></tl:eval>

<!--  BEGIN CONTENT AREA  -->
<div id="content" class="main-content">
	<div class="layout-px-spacing">

		<div class="row layout-top-spacing">

			<div class="col-md-9 layout-spacing">
				<div class="statbox widget box box-shadow">
					<!-- <div class="widget-header">
                                <div class="row">
                                    <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                        <h4>Select Polygon</h4>
                                    </div>
                                </div>
                            </div> -->

					<div class="widget-content widget-content-area" id="mapFullscreen">

						<a href="javascript:void(0)" onclick="openFullscreen();"
							class="btn-fullscreen bs-tooltip" role="button"
							data-toggle="collapse" title="Toggle fullscreen"> <svg
								xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-maximize">
								<path
									d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3"></path></svg>
						</a>

						<div class="mapFilterBase col-md-4 col-sm-6 col-xs-12">

							<div id="accordion" class="mapFilter">
								<div class="map-tab-fix row m-0">
									<a id="" href="#collapseOne"
										class="text-dark col collapsed bs-tooltip"
										data-toggle="collapse" aria-expanded="true"
										aria-controls="collapseOne" title="Filter"> <span
										class="d-block"><img src="/assets/img/icon-filter.png"></span>
									</a> <a id="" href="#collapseTwo"
										class="text-dark col collapsed bs-tooltip"
										data-toggle="collapse" aria-expanded="false"
										aria-controls="collapseTwo" title="Layers"> <span
										class="d-block"><img src="/assets/img/icon-layers.png"></span>
									</a> <a id="" href="#collapseThree"
										class="text-dark col collapsed bs-tooltip"
										data-toggle="collapse" aria-expanded="false"
										aria-controls="collapseThree" title="Legends"> <span
										class="d-block"><img src="/assets/img/icon-legends.png"></span>
									</a> <a id="" href="#collapseFour"
										class="text-dark col collapsed bs-tooltip"
										data-toggle="collapse" aria-expanded="false"
										aria-controls="collapseFour" title="Basemap"> <span
										class="d-block"><img src="/assets/img/icon-basemap.png"></span>
									</a> <a id="a_measure" href="#collapseFive"
										class="text-dark col collapsed bs-tooltip"
										data-toggle="collapse" aria-expanded="false"
										aria-controls="collapseFive" title="Measurement"> <span
										class="d-block"><img
											src="/assets/img/icon-measurement.png"></span>
									</a> <a id="" href="#collapseSix"
										class="text-dark col collapsed bs-tooltip"
										data-toggle="collapse" aria-expanded="false"
										aria-controls="collapseSix" title="Info"> <span
										class="d-block"><img src="/assets/img/icon-info.png"></span>
									</a> <a id="" href="#collapseSeven"
										class="text-dark col collapsed bs-tooltip"
										data-toggle="collapse" aria-expanded="false"
										aria-controls="collapseSeven" title="Swipe"> <span
										class="d-block"><img src="/assets/img/icon-swipe.png"></span>
									</a> <a id="" href="#collapseEight"
										class="text-dark col collapsed bs-tooltip"
										data-toggle="collapse" aria-expanded="false"
										aria-controls="collapseEight" title="Pan"> <span
										class="d-block"><img src="/assets/img/icon-pan.png"></span>
									</a> <a id="a_reset" href="#collapseNine"
										class="text-dark col collapsed bs-tooltip"
										data-toggle="collapse" aria-expanded="false"
										aria-controls="collapseNine" title="Reset"> <span
										class="d-block"><img src="/assets/img/icon-reset.png"></span>
									</a>
									<!--  <a id="" href="#collapseTen"
										class="text-dark col collapsed bs-tooltip"
										data-toggle="collapse" aria-expanded="false"
										aria-controls="collapseTen" title="Clear"> <span
										class="d-block"><img src="/assets/img/icon-clear.png"></span>
									</a> -->
								</div>

								<div class="clearfix"></div>

								<div class="mb-0">
									<div id="collapseOne" class="collapse show"
										aria-labelledby="headingOne" data-parent="#accordion">
										<div class="card">
											<div class="card-body">
												<div class="fixHeightRight">
													<button class="btn-sm btn-danger closeBtn collapsed"
														type="button" data-toggle="collapse"
														data-target="#collapseOne" aria-expanded="false"
														aria-controls="collapseOne">
														<span aria-hidden="true">x</span>
													</button>
													<div class="card-body custom-card-body">
														<h6 class="mt-0 page-title mb-3">AOI Analysis</h6>
														<div id="accordion3">
															<a id="" href="#collapse11" class="collapsed icon-header"
																data-toggle="collapse" aria-expanded="true"
																aria-controls="collapse11">
																<h6 class="mt-0 header-title map-title-secondary mb-3">
																	Load Polygon<i class="fa fa-angle-down pull-right"></i>
																</h6>
															</a>
															<div id="collapse11" class="collapse show"
																aria-labelledby="heading11" data-parent="#accordion3">
																<ul class="fixHeightList">
																	<li><a href="javascript:void(0);" id="link_Draw">Draw
																			Area of Interest</a> <a href="javascript:void(0);"
																		id="lnkResetDrawAoi" class="text-danger"
																		style="position: absolute; right: 5px; top: 0;"><i
																			class="fa fa-refresh"></i></a></li>
																	<li><input id="upload" type="file" accept=".kml" /><a
																		href="javascript:void(0);" id="link_Upload">Import
																			AOI(KML file)</a></li>
																	<li><a href="javascript:void(0);"
																		id="link_Coordinates">Enter Lat / Long</a></li>
																</ul>
															</div>
															<a id="" href="#collapse12" class="collapsed icon-header"
																data-toggle="collapse" aria-expanded="false"
																aria-controls="collapse12">
																<h6 class="mt-0 header-title map-title-secondary mb-4">
																	AOI-Forest Land Analysis<i
																		class="fa fa-angle-right pull-right"></i>
																</h6>
															</a>
															<div id="collapse12" class="collapse"
																aria-labelledby="heading12" data-parent="#accordion3">
																<ul class="fixHeightList">
																	<!-- <li><a href="javascript:void(0);">Notified
																			Forest</a></li> -->

																	<input type="radio" id="rdonfb" name="aoiLayer">
																	<label for="rdonfb">Notified Forest</label>
																	<br>
																	<input type="radio" id="rdoRev" name="aoiLayer">
																	<label for="rdoRev">Revenue Forest</label>
																	<br>
																	<input type="radio" id="rdoDLC" name="aoiLayer">
																	<label for="rdoDLC">DLC Forest</label>
																	<li id="liNotifiedForest"><a href="javascript:void(0);">Notified
																		Forest</a></li>
																	<li><a href="javascript:void(0);">Revenue
																			Forest</a></li>
																	<li><a href="javascript:void(0);">DLC Forest</a></li>
																	<li><a href="javascript:void(0);"><del>Deemed
																				Forest</del></a></li>
																	<li><a href="javascript:void(0);"><del>Diverted
																				Forest Land</del></a></li>
																	<li><a href="javascript:void(0);"><del>CA
																				Land</del></a></li>
																	<li><a href="javascript:void(0);"><del>Wild
																				Life Corridor</del></a></li>
																	<li><a href="javascript:void(0);"><del>Protected
																				Areas</del></a></li>
																	<li><a href="javascript:void(0);"><del>DSS
																				Summary</del></a></li>
																</ul>
															</div>
															<a id="" href="#collapse13" class="collapsed icon-header"
																data-toggle="collapse" aria-expanded="false"
																aria-controls="collapse13">
																<h6 class="mt-0 header-title map-title-secondary mb-4">
																	<del>AOI-Forest Cover Analysis</del>
																	<i class="fa fa-angle-right pull-right"></i>
																</h6>
															</a>
															<div id="collapse13" class="collapse"
																aria-labelledby="heading13" data-parent="#accordion3">
																<form>
																	<div class="tab-slider--nav">
																		<ul class="tab-slider--tabs">
																			<li class="tab-slider--trigger active"
																				rel="referenceYear">Year</li>
																			<li class="tab-slider--trigger"
																				rel="referenceCompare">Compare</li>
																		</ul>
																	</div>
																	<div class="tab-slider--container">
																		<div id="referenceYear" class="tab-slider--body">
																			<div class="row">
																				<div class="col-md-6">
																					<div class="form-group mb-2">
																						<select class="form-control-sm" id="">
																							<option selected="selected">Select Year
																							</option>
																							<option>2011</option>
																							<option>2013</option>
																							<option>2015</option>
																							<option>2017</option>
																							<option>2019</option>
																						</select>
																					</div>
																				</div>
																			</div>
																		</div>
																		<div id="referenceCompare" class="tab-slider--body">
																			<div class="row">
																				<div class="col-md-6">
																					<div class="form-group mb-2">
																						<select class="form-control-sm" id="">
																							<option selected="selected">Select Year
																							</option>
																							<option>2011</option>
																							<option>2013</option>
																							<option>2015</option>
																							<option>2017</option>
																							<option>2019</option>
																						</select>
																					</div>
																				</div>
																				<div class="col-md-6">
																					<div class="form-group mb-2">
																						<select class="form-control-sm" id="">
																							<option selected="selected">Select Year
																							</option>
																							<option>2019</option>
																							<option>2017</option>
																							<option>2015</option>
																							<option>2013</option>
																							<option>2011</option>

																						</select>
																					</div>
																				</div>
																			</div>
																		</div>
																	</div>
																</form>
															</div>
															<a id="" href="#collapse14" class="collapsed icon-header"
																data-toggle="collapse" aria-expanded="false"
																aria-controls="collapse14">
																<h6 class="mt-0 header-title map-title-secondary mb-4">
																	<del>Background Reference</del>
																	<i class="fa fa-angle-right pull-right"></i>
																</h6>
															</a>
															<div id="collapse14" class="collapse"
																aria-labelledby="heading14" data-parent="#accordion3">
																<form>
																	<div class="row">
																		<div class="col-md-6">
																			<div
																				class="custom-control custom-checkbox checkbox-info ml-1 mr-1">
																				<input type="checkbox" class="custom-control-input"
																					id="checkbox51"> <label
																					class="custom-control-label" for="checkbox51">HRSI</label>
																			</div>
																		</div>
																		<div class="col-md-6">
																			<div class="form-group mb-2">
																				<select class="form-control-sm" id="">
																					<option selected="selected">Select Year</option>
																					<option>2019</option>
																					<option>2017</option>
																					<option>2015</option>
																					<option>2013</option>
																					<option>2011</option>
																				</select>
																			</div>
																		</div>
																	</div>
																	<div class="row">
																		<div class="col-md-12">
																			<div
																				class="custom-control custom-checkbox checkbox-info ml-1 mr-1">
																				<input type="checkbox" class="custom-control-input"
																					id="checkbox52"> <label
																					class="custom-control-label" for="checkbox52">SOI
																					- OSM</label>
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
									<div id="collapseTwo" class="collapse"
										aria-labelledby="headingTwo" data-parent="#accordion">
										<div class="card">
											<div class="card-body">
												<div class="fixHeightRight">
													<button class="btn-sm btn-danger closeBtn collapsed"
														type="button" data-toggle="collapse"
														data-target="#collapseTwo" aria-expanded="false"
														aria-controls="collapseTwo">
														<span aria-hidden="true">x</span>
													</button>
													<div class="card-body custom-card-body">
														<h6 class="mt-0 page-title mb-3">Layers</h6>

														<div id="accordion2">
															<a id="" href="#collapse1" class="collapsed"
																data-toggle="collapse" aria-expanded="true"
																aria-controls="collapse1">
																<h6 class="mt-0 header-title map-title-secondary mb-3">
																	Administrative Boundary<i
																		class="fa fa-angle-down pull-right"></i>
																</h6>
															</a>
															<div id="collapse1" class="collapse show"
																aria-labelledby="heading1" data-parent="#accordion2">
																<form>
																	<div class="row form-group">
																		<div class="col-md-12">

																			<div id="layerHeading1">

																				<div
																					class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																					<input type="checkbox" class="custom-control-input"
																						id="checkbox11" value="StateBoundary"
																						checked="checked"> <label
																						class="custom-control-label" for="checkbox11">State
																						Boundary</label>
																				</div>
																				<div
																					class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																					<input type="checkbox" class="custom-control-input"
																						id="checkbox12" value="DistrictBoundary">
																					<label class="custom-control-label"
																						for="checkbox12">District Boundary</label>
																				</div>
																				<div
																					class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																					<input type="checkbox" class="custom-control-input"
																						id="chkTahasilBoundary" value="TahasilBoundary">
																					<label class="custom-control-label"
																						for="chkTahasilBoundary">Tahasil Boundary</label>
																				</div>
																				<div
																					class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																					<input type="checkbox" disabled
																						class="custom-control-input" id="checkbox13"
																						value="BlockBoundary"> <label
																						class="custom-control-label" for="checkbox13">Block
																						Boundary</label>
																				</div>
																				<div
																					class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																					<input type="checkbox" disabled
																						class="custom-control-input" id="checkbox14"
																						value="GPBoundary"> <label
																						class="custom-control-label" for="checkbox14">GP
																						Boundary</label>
																				</div>
																				<div
																					class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																					<input type="checkbox" class="custom-control-input"
																						id="chkvillage_layer" value="VillageBoundary">
																					<label class="custom-control-label"
																						for="chkvillage_layer">Village Boundary</label>
																				</div>
																			</div>
																		</div>
																	</div>
																</form>
															</div>
															<a id="" href="#collapse2" class="collapsed"
																data-toggle="collapse" aria-expanded="false"
																aria-controls="collapse2">
																<h6 class="mt-0 header-title map-title-secondary mb-4">
																	Forest Administrative Boundary<i
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
																				<input type="checkbox" class="custom-control-input"
																					id="checkbox31" value="DivisionBoundary"> <label
																					class="custom-control-label" for="checkbox31">Division
																					Boundary</label>
																			</div>
																			<div
																				class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																				<input type="checkbox" class="custom-control-input"
																					id="checkbox32" value="RangeBoundary"> <label
																					class="custom-control-label" for="checkbox32">Range
																					Boundary</label>
																			</div>
																			<!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="checkbox33">
                                                                                        <label class="custom-control-label" for="checkbox33">Block Boundary</label>
                                                                                    </div> -->
																		</div>
																	</div>
																</form>
															</div>
															<%-- <a id="" href="#collapse3"
																					class="collapsed"
																					data-toggle="collapse"
																					aria-expanded="false"
																					aria-controls="collapse3">
																					<h6
																						class="mt-0 header-title map-title-secondary mb-4">
																						Forest Land Details<i
																							class="fa fa-angle-right pull-right"></i>
																					</h6>
																					</a>
																					<div id="collapse3" class="collapse"
																						aria-labelledby="heading3"
																						data-parent="#accordion2">
																						<form>
																							<div class="row form-group">
																								<div class="col-md-12">
																									<div
																										class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																										<input
																											type="checkbox"
																											class="custom-control-input"
																											id="checkbox41">
																										<label
																											class="custom-control-label"
																											for="checkbox41">Notified
																											Forest</label>
																									</div>
																									<div
																										class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																										<input
																											type="checkbox"
																											class="custom-control-input"
																											id="checkbox42">
																										<label
																											class="custom-control-label"
																											for="checkbox42">Revenue
																											Forest</label>
																									</div>
																									<div
																										class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																										<input
																											type="checkbox"
																											class="custom-control-input"
																											id="checkbox43">
																										<label
																											class="custom-control-label"
																											for="checkbox43">DLC
																											Forest</label>
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
									<div id="collapseThree" class="collapse"
										aria-labelledby="headingThree" data-parent="#accordion">
										<div class="card">
											<div class="card-body">
												<div class="fixHeightRight">
													<button class="btn-sm btn-danger closeBtn collapsed"
														type="button" data-toggle="collapse"
														data-target="#collapseThree" aria-expanded="false"
														aria-controls="collapseThree">
														<span aria-hidden="true">x</span>
													</button>
													<div class="card-body custom-card-body">
														<h6 class="mt-0 page-title mb-3">Legends</h6>
														<div class="row">
															<div class="col-md-12 ml-1">
																<div class="legendbox" id="stateboundarylayer_legend">
																	<img src="/assets/img/state_boundary.png"> <span>State
																		Boundary</span>
																</div>
																<div class="legendbox">
																	<img src="/assets/img/district_boundary.png"> <span>District
																		Boundary</span>
																</div>
																<div class="legendbox">
																	<img src="/assets/img/division_boundary.png"> <span>Division
																		Boundary</span>
																</div>
																<div class="legendbox" id="allrnglayer_legend">
																	<img src="/assets/img/range_boundary.png"> <span>Range
																		Boundary</span>
																</div>

																<div class="legendbox" id="tahasil_layer_legend">
																	<img src="/assets/img/legend-04.png"> <span>Tahasil
																		Boundary</span>
																</div>

																<div class="legendbox" id="village_layer_legend">
																	<img src="/assets/img/village_boundary.png"> <span>Village
																		Boundary</span>
																</div>

																<!-- <div class="legendbox">
																	<img src="/assets/img/legend-05.png"> <span>GP
																		Boundary</span>
																</div> -->
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="mb-0">
									<div id="collapseFour" class="collapse"
										aria-labelledby="headingFour" data-parent="#accordion">
										<div class="card">
											<div class="card-body">
												<div class="fixHeightRight">
													<button class="btn-sm btn-danger closeBtn collapsed"
														type="button" data-toggle="collapse"
														data-target="#collapseFour" aria-expanded="false"
														aria-controls="collapseFour">
														<span aria-hidden="true">x</span>
													</button>
													<div class="card-body custom-card-body">
														<h6 class="mt-0 page-title mb-3">Basemap</h6>
														<form>
															<div class="row form-group">
																<div class="col-md-12">
																	<!-- <div class="custom-control custom-checkbox checkbox-info">
                                                                                <input type="checkbox" class="custom-control-input" id="imagery_basemap">
                                                                                <label class="custom-control-label" for="imagery_basemap">Terrian</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info">
                                                                                <input type="checkbox" class="custom-control-input" id="osm_basemap">
                                                                                <label class="custom-control-label" for="osm_basemap">OSM</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info">
                                                                                <input type="checkbox" class="custom-control-input" id="street_basemap">
                                                                                <label class="custom-control-label" for="street_basemap">Cartography</label>
                                                                            </div> -->
																	<div class="tab-box">
																		<ul class="basesection">
																			<li><a id="imagery_basemap" class="basebox"><img
																					src="/assets/img/icon-imagery.png">
																					<h6>Imagery</h6> </a></li>
																			<li><a id="street_basemap" class="basebox"><img
																					src="/assets/img/icon-street.png">
																					<h6>Street</h6> </a></li>
																			<li><a id="osm_basemap" class="basebox"><img
																					src="/assets/img/icon-osm.png">
																					<h6>OSM</h6> </a></li>
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

								<%-- <div class="mb-0">
														<div id="collapseFive" class="collapse"
															aria-labelledby="headingFive" data-parent="#accordion">
															<div class="card">
																<div class="card-body">
																	<div class="fixHeightRight">
																		<button
																			class="btn-sm btn-danger closeBtn collapsed"
																			type="button" data-toggle="collapse"
																			data-target="#collapseFive"
																			aria-expanded="false"
																			aria-controls="collapseFive"><span
																				aria-hidden="true">x</span></button>
																		<div class="card-body custom-card-body">
																			<h6 class="mt-0 page-title mb-3">Measurement
																			</h6>
																			<form>
																				<div class="row form-group">
																					<div class="col-md-12">
																						<div class="form-check">
																							<div
																								class="custom-control custom-radio classic-radio-info">
																								<input type="radio"
																									id="hRadio1"
																									name="classicRadio"
																									class="custom-control-input">
																								<label
																									class="custom-control-label"
																									for="hRadio1">Area</label>
																							</div>
																						</div>
																						<div class="form-check">
																							<div
																								class="custom-control custom-radio classic-radio-info">
																								<input type="radio"
																									id="hRadio2"
																									name="classicRadio"
																									class="custom-control-input">
																								<label
																									class="custom-control-label"
																									for="hRadio2">Distance</label>
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
												</div> --%>
								<div class="mb-0">
									<div id="collapseFive" class="collapse"
										aria-labelledby="headingFive" data-parent="#accordion">
										<div class="card">
											<div class="card-body">
												<div class="fixHeightRight">
													<button class="btn-sm btn-danger closeBtn collapsed"
														type="button" data-toggle="collapse"
														data-target="#collapseFive" aria-expanded="false"
														aria-controls="collapseFive">
														<span aria-hidden="true">x</span>
													</button>
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
																			<select id="type"
																				class="form-control form-control-sm custom-adj mb-2">
																				<option selected="selected">-- Select Type
																					--</option>
																				<option value="length">Length (LineString)</option>
																				<option value="area">Area (Polygon)</option>
																			</select>
																			<button id="btnReset" type="button"
																				class="btn btn-sm btn-warning">Reset</button>
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

							</div>
							<!--/accordion-->

						</div>

						<div id="map" class="fixHeightLeft panel">
							<!-- <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834859.9797965377!2d82.19173433935192!3d20.176539522401498!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a226aece9af3bfd%3A0x133625caa9cea81f!2sOdisha!5e0!3m2!1sen!2sin!4v1564120416120!5m2!1sen!2sin" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe> -->
						</div>

					</div>
				</div>
			</div>

			<div class="col-md-3 layout-spacing">
				<div class="statbox widget box box-shadow fixHeightInfo">
					<div class="widget-header">
						<div class="row">
							<div class="col-xl-12 col-md-12 col-sm-12 col-12">
								<h4>Information View</h4>
							</div>
						</div>
					</div>
					<div class="widget-content widget-content-area">
						<h6>Notified Forest Area</h6>
						<div class="table-responsive">
							<table class="table table-sm table-bordered">
								<thead>
									<tr>
										<th>Sl. No.</th>
										<th>FB Name</th>
										<th>Area in AOI</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>-</td>
										<td>-</td>
									</tr>
									<tr>
										<td>2</td>
										<td>-</td>
										<td>-</td>
									</tr>
									<tr>
										<td>3</td>
										<td>-</td>
										<td>-</td>
									</tr>
									<tr>
										<td>4</td>
										<td>-</td>
										<td>-</td>
									</tr>
									<tr>
										<td>5</td>
										<td>-</td>
										<td>-</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>


			<!--Test-->
			<label id="lbltest"></label>
			<!--Test End-->


		</div>

	</div>
</div>
<!--  END CONTENT AREA  -->
<div id="infoModal" class="modal fade modal-info-custom">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-body">
				<h5 class="title">About Data Catalogue</h5>
				<img src="/assets/img/slider/1.jpg"
					class="img-fluid img-thumbnail float-left mr-3 mb-1 w-50">
				<p>
					Sed ut perspiciatis unde omnis iste natus error sit voluptatem
					accusantium doloremque laudantium, totam rem aperiam, eaque ipsa
					quae ab illo inventore veritatis et quasi architecto beatae vitae
					dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit
					aspernatur aut odit aut fugit, sed quia consequuntur magni dolores
					eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam
					est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci
					velit, sed quia non numquam eius modi tempora incidunt ut labore et
					dolore magnam aliquam quaerat voluptatem. <a
						href="javascript:void(0);" target="_blank">Ut enim ad minima
						veniam</a>, quis nostrum exercitationem ullam corporis suscipit
					laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem
					vel eum iure reprehenderit qui in ea voluptate velit esse quam
					nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo
					voluptas nulla pariatur. At vero eos et accusamus et iusto odio
					dignissimos ducimus qui blanditiis praesentium voluptatum deleniti
					atque corrupti quos dolores et quas molestias excepturi sint
					occaecati cupiditate non provident, similique sunt in culpa qui
					officia deserunt mollitia animi, id est laborum et dolorum fuga. Et
					harum quidem rerum facilis est et expedita distinctio. Nam libero
					tempore, cum <a href="javascript:void(0);" target="_blank">soluta
						nobis</a> est eligendi optio cumque nihil impedit quo minus id quod
					maxime placeat facere possimus, omnis voluptas assumenda est, omnis
					dolor repellendus. Temporibus autem quibusdam et aut officiis
					debitis aut rerum necessitatibus saepe eveniet ut et voluptates
					repudiandae sint et molestiae non recusandae. Itaque earum rerum
					hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus
					maiores alias consequatur aut perferendis doloribus asperiores
					repellat. On the other hand, we denounce with righteous indignation
					and dislike men who are so beguiled and demoralized by the charms
					of pleasure of the moment, so blinded by desire, that they cannot
					foresee the pain and trouble that are bound to ensue; and equal
					blame belongs to those who fail in their duty through weakness of
					will, which is the same as saying through shrinking from toil and
					pain. These cases are perfectly simple and easy to distinguish. In
					a free hour, when our power of choice is untrammelled and when
					nothing prevents our being able to do what we like best, every
					pleasure is to be welcomed and every pain avoided. But in certain
					circumstances and owing to the claims of duty or the obligations of
					business it will frequently occur that pleasures have to be
					repudiated and annoyances accepted. The wise man therefore always
					holds in these matters to this principle of selection: he rejects
					pleasures to secure other greater pleasures, or else he endures
					pains to avoid worse pains.
				</p>
				<h6 class="title">Important Points</h6>
				<ul>
					<li>But I must explain to you how all this mistaken idea of
						denouncing pleasure and praising pain was born and I will give you
						a complete account of the system, and expound the actual teachings
						of the great explorer of the truth.</li>
					<li>Nor again is there anyone who loves or pursues or desires
						to obtain pain of itself, because it is pain.</li>
					<li>The master-builder of human happiness. No one rejects,
						dislikes, or avoids pleasure itself, because it is pleasure, but
						because those who do not know how to pursue pleasure rationally
						encounter consequences that are extremely painful.</li>
					<li>In a free hour, when our power but because occasionally
						circumstances occur in which toil and pain can procure him some
						great pleasure.</li>
				</ul>
				<hr>
				<div class="text-center">
					<div class="custom-control custom-checkbox checkbox-info mb-3">
						<input type="checkbox" class="custom-control-input"
							id="chkDontShow"> <label class="custom-control-label"
							for="chkDontShow">Don't show me again!</label>
					</div>
					<button type="button" class="btn btn-success" data-dismiss="modal">Launch
						Data Catalogue</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Map View div -->
<div id="popup" class="ol-popup">
	<a href="#" id="popup-closer" class="ol-popup-closer"></a>
	<div id="popup-content"></div>
</div>
<div id="map" class="fixHeightLeft2" height="100%" width="100%"></div>
<!--End Map View div -->
<%@ include file="../shared/footer.jsp"%>

<script src="/assets/js/libs/jquery-3.1.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/build/ol.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
<script src="https://epsg.io/32645.js"></script>
<script src="/libs/proj4js/proj4-src.js"></script>
<!-- <script src="/libs/v6.0.0-dist/ol.js"></script> -->
<script src="/libs/v6.6.1-dist/ol.js"></script>

<script src="https://cdn.maptiler.com/ol-mapbox-style/v4.3.1/olms.js"></script>



<!-- <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
<script src="https://epsg.io/32645.js"></script>
<script src="/v5.3.0-dist/32644.js"></script>
<script src="/assets/js/custom/layer_style.js"></script>   -->

<script type="text/javascript">
	var geoserverUrl = '${geoserverUrl}';

	$(document).ready(function() {
		//  App.init();
		/* $("#infoModal").modal('show'); */
		$(".header-title-lg").text("FLI DSS (AOI Analysis)");
	});
</script>

<script src="/assets/js/apps/loadMap.js"></script>
 <script src="/assets/js/apps/aoiAnalysis.js"></script>
<!-- <script src="/assets/js/apps/aoiInteraction.js"></script> -->





<script type="text/javascript">
	//Village Boundary   
	$("#chkvillage_layer").change(function(event) {

		/* $(document).ready(function() { */
		var village_layer;
		if (village_layer != null) {

		}
		//map.removeLayer(village_layer);
		$.ajax({
			url : '/Utility/getAllLayerList',
			data : {
				'type' : 14
			},
			type : "GET",
			contentType : "application/json;charset=utf-8",
			dataType : "json",
			success : function(obj) {
				console.log(obj);
				//console.log(obj.text);
				if (obj != null) {
					var myStringArray = obj;
					var arrayLength = obj.length;
					for (var i = 0; i < arrayLength; i++) {
						//tehLayernm=obj[i].text;
						//alert(tehLayernm);
						var query = "";
						/*  if($("#drpTehList").val()!="")
						 {
							query="tah_id="+$( "#drpTehList option:selected" ).val();
						 } */
						/*  if(query!="")
						 { */
						village_layer = new ol.layer.Image({
							source : new ol.source.ImageWMS({
								url : obj[i].strValue,
								params : {
									'LAYERS' : obj[i].text,
									'VERSION' : '1.1.0',
								//'CQL_FILTER': query     
								},
								serverType : 'geoserver'
							})
						});
						if (village_layer != null) {
							map.addLayer(village_layer);
							if ($("#chkvillage_layer").is(":checked")) {
								village_layer.setVisible(true);
							} else {
								village_layer.setVisible(false);
								map.removeLayer(village_layer);
								alert('dfdfdf');
							}

						} else {
							AlertNotify("village Boundary is not available.")
						}
					}
				}
			},
			error : function(xhr, status) {

			}
		});
	});
</script>

<script type="text/javascript">
$("#a_reset").click(function(){
    window.location.href='/DSS/aoiAnalysis2';
});
</script>

<!-- Full Screen -->
<script type="text/javascript">
	var elem = document.getElementById("mapFullscreen");
	function openFullscreen() {
		$(".fixHeightLeft").toggleClass("intro");
		if (elem.requestFullscreen) {
			elem.requestFullscreen();
		} else if (elem.webkitRequestFullscreen) { /* Safari */
			elem.webkitRequestFullscreen();
		} else if (elem.msRequestFullscreen) { /* IE 11 */
			elem.msRequestFullscreen();
		}
	}
</script>