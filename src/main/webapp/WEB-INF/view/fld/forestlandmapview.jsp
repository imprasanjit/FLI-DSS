<%@ taglib prefix="tl" uri="http://www.springframework.org/tags" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
			<script src="/assets/js/custom/layer_style.js"></script>
			<script src="/assets/js/apps/loadMap.js"></script>
			<!--  <script src="/assets/js/apps/baseLayer.js"></script> -->
			<script src="/assets/js/fld/allCommonBoundary.js"></script>
			<!-- <script src="/assets/js/fld/analysis.js"></script> -->
			<script src="/assets/js/fld/measurement.js"></script>
			<link rel="stylesheet" href="/assets/css/apps/aoiAnalysis.css" type="text/css">

			<link rel="stylesheet"
				href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css"
				type="text/css">
			<style>
				.modal-backdrop fade show {
					display: none;
				}

				.ol-rotate-reset {
					display: none;
				}

				/* .ol-zoom
 {
 	display:none;
 } */
				.ol-attribution {
					display: none;
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

				.ol-popup:after,
				.ol-popup:before {
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

				.ol-scale-bar {
					right: 8px;
					left: auto;
				}

				.ol-zoom {
					top: 2.5em !important;
					right: 0.5em !important;
					left: auto !important;
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
			</style>
			<div class="row layout-top-spacing">

				<div class="col-md-12 mb-1">
					<div class="statbox widget box box-shadow">
						<div class="widget-content widget-content-area">

							<div class="row">

								<div class="col-md-3">
									<div id="accordion" class="mapFilter mapFilterBase2 fixHeightLeft">
										<div class="map-tab-fix row m-0">
											<!-- <a id="" href="#collapseOne" class="text-dark col collapsed bs-tooltip" data-toggle="collapse" aria-expanded="true" aria-controls="collapseOne" title="Area of Interest">
	                                        <span class="d-block"><img src="/assets/img/icon-filter.png"></span>
	                                    </a> -->

											<a id="" href="#collapseTwo"
												class="text-dark col collapsed bs-tooltip feature"
												data-toggle="collapse" aria-expanded="true" aria-controls="collapseTwo"
												title="Layers"> <span class="d-block"><img
														src="/assets/img/icon-layers.png"></span>
											</a> <a id="" href="#collapseThree"
												class="text-dark col collapsed bs-tooltip feature"
												data-toggle="collapse" aria-expanded="false"
												aria-controls="collapseThree" title="Legends"> <span
													class="d-block"><img src="/assets/img/icon-legends.png"></span>
											</a> <a id="" href="#collapseFour"
												class="text-dark col collapsed bs-tooltip feature"
												data-toggle="collapse" aria-expanded="false"
												aria-controls="collapseFour" title="Basemap"> <span class="d-block"><img
														src="/assets/img/icon-basemap.png"></span>
											</a> <a id="a_measure" href="#collapseFive"
												class="text-dark col collapsed bs-tooltip feature"
												data-toggle="collapse" aria-expanded="false"
												aria-controls="collapseFive" title="Measurement"> <span
													class="d-block"><img src="/assets/img/icon-measurement.png"></span>
											</a> <a id="a_reset" href="#collapseSeven"
												class="text-dark col collapsed bs-tooltip feature"
												data-toggle="collapse" aria-expanded="false"
												aria-controls="collapseSeven" title="Reset"> <span class="d-block"><img
														src="/assets/img/icon-reset.png"></span>
											</a>
										</div>

										<div class="clearfix"></div>

										<div class="mb-0">

											<div id="collapseTwo" class="collapse show" aria-labelledby="headingOne"
												data-parent="#accordion">
												<div class="card">
													<div class="card-body">
														<div class="fixHeightRight">
															<!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne"><span aria-hidden="true">�</span></button> -->
															<div class="card-body custom-card-body">
																<!-- <h6 class="mt-0 page-title mb-2">Area of Interest</h6>
	                                                        <div class="mb-2">
	                                                        	<strong>Division : </strong><span>Angul</span>
	                                                        </div>
	                                                        <h6 class="mt-0 page-title mb-2">Selected Layers</h6> -->
																<div id="accordion3">
																	<a id="" href="#collapse11"
																		class="collapsed icon-header"
																		data-toggle="collapse" aria-expanded="true"
																		aria-controls="collapse11">
																		<h6
																			class="mt-0 header-title map-title-secondary mb-3">
																			Forest Land Type<i
																				class="fa fa-angle-down pull-right"></i>
																		</h6>
																	</a>
																	<div id="collapse11" class="collapse show"
																		aria-labelledby="heading11"
																		data-parent="#accordion3">
																		<form>
																			<div class="row form-group">
																				<div class="col-md-12">
																					<div
																						class="border-light mb-2 pl-1 pr-1 pt-2 pb-2">
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkNFB" value="1">
																							<label
																								class="custom-control-label"
																								for="chkNFB">Notified
																								Forest</label>
																							<span id="NfbLabel">
																								<!-- <input type="checkbox" class="custom-control-input" id="chkNFBLabel" checked="checked" >
			                                                                                <label class="custom-control-label" for="chkNFBLabel">NFB Label</label> -->
																								<button type="button"
																									id="btnnotation"
																									class="noty">A</button>
																								<script>
																									$("#btnnotation").click(function () {
																										$(this).toggleClass("note"); $(this).addClass("active");
																									});
																								</script>
																							</span>
																							<img src="/assets/img/forest-01.png"
																								class="img-chk">
																						</div>

																					</div>

																					<div
																						class="border-light mb-2 pl-1 pr-1 pt-2 pb-2">
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkRFFinal"
																								value="2">
																							<label
																								class="custom-control-label"
																								for="chkRFFinal">Revenue
																								Forest and DLC</label>
																							<span id="dlcLabel">
																								<!-- <input type="checkbox" class="custom-control-input" id="chkRFLabel" checked="checked" >
			                                                                                <label class="custom-control-label" for="chkRFLabel">RF Label</label> -->
																								<button type="button"
																									id="btnnotation2"
																									class="noty">A</button>
																								<script>
																									$("#btnnotation2").click(function () {
																										$(this).toggleClass("note"); $(this).addClass("active");
																									});
																								</script>
																							</span>
																							<img src="/assets/img/dlc_forest.png"
																								class="img-chk">
																							<img src="/assets/img/rev_forest.png"
																								class="img-chk">																							
																						</div>


																					</div>
																					<div
																						class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																						<input type="checkbox"
																							class="custom-control-input"
																							id="chkCmpnstryAL"
																							value="4">
																						<label
																							class="custom-control-label"
																							for="chkCmpnstryAL">DRFL</label>
																						<span id="caLabel">

																							<button type="button"
																								id="btnnotation3"
																								class="noty">A</button>
																							<script>
																								$("#btnnotation3").click(function () {
																									$(this).toggleClass("note"); $(this).addClass("active");
																								});
																							</script>
																						</span>
																						<img src="/assets/img/forest-06.png"
																							class="img-chk">
																					</div>
																					<!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="chkFRA" value="3" disabled>
	                                                                                <label class="custom-control-label" for="chkFRA">FRA</label>
	                                                                                <img src="/assets/img/forest-04.png" class="img-chk">
	                                                                        </div>      
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="chkDivertedFL" value="5" disabled>
	                                                                                <label class="custom-control-label" for="chkDivertedFL">Diverted Forest Land</label>
	                                                                                <img src="/assets/img/forest-02.png" class="img-chk">                                                                           
                                                                            </div>      -->
																				</div>
																			</div>
																		</form>
																	</div>
																	<a id="" href="#collapse12"
																		class="collapsed icon-header"
																		data-toggle="collapse" aria-expanded="false"
																		aria-controls="collapse12">
																		<h6
																			class="mt-0 header-title map-title-secondary mb-4">
																			Administrative Boundary<i
																				class="fa fa-angle-right pull-right"></i>
																		</h6>
																	</a>
																	<div id="collapse12" class="collapse"
																		aria-labelledby="heading12"
																		data-parent="#accordion3">
																		<form>
																			<div class="row form-group">
																				<div class="col-md-12">
																					<div
																						class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																						<input type="checkbox"
																							class="custom-control-input"
																							value="DistrictBoundary"
																							id="chkDist">
																						<label
																							class="custom-control-label"
																							for="chkDist">District</label>
																						<img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_AllDivision/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_AllDivision:district_boundary"
																							class="img-chk2" />
																					</div>
																					<div
																						class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																						<input type="checkbox"
																							class="custom-control-input"
																							value="TahasilBoundary"
																							id="chkTehsil">
																						<label
																							class="custom-control-label"
																							for="chkTehsil">Tehsil</label>
																						<img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Angul_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Angul_vector:tahasil_boundary"
																							class="img-chk2" />
																					</div>
																					<div
																						class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																						<input type="checkbox"
																							class="custom-control-input"
																							id="checkbox63" disabled>
																						<label
																							class="custom-control-label"
																							for="checkbox63">Block</label>
																						<img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_AllDivision/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_AllDivision:block_boundary"
																							class="img-chk2" />
																					</div>
																					<div
																						class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																						<input type="checkbox"
																							class="custom-control-input"
																							value="VillageBoundary"
																							id="chkVillage">
																						<label
																							class="custom-control-label"
																							for="chkVillage">Village</label>
																						<img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Phulbani_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Phulbani_vector:village_boundary"
																							class="img-chk2" />
																					</div>
																				</div>
																			</div>
																		</form>
																	</div>
																	<a id="forestAdmin" href="#collapse13"
																		class="collapsed icon-header"
																		data-toggle="collapse" aria-expanded="false"
																		aria-controls="collapse13">
																		<h6
																			class="mt-0 header-title map-title-secondary mb-4">
																			Forest Administrative Boundary<i
																				class="fa fa-angle-right pull-right"></i>
																		</h6>
																	</a>
																	<div id="collapse13" class="collapse"
																		aria-labelledby="heading13"
																		data-parent="#accordion3">
																		<form>
																			<div class="row form-group">
																				<div class="col-md-12">
																					<div
																						class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																						<input type="checkbox"
																							class="custom-control-input"
																							value="DivisionBoundary"
																							id="chkDivision">
																						<label
																							class="custom-control-label"
																							for="chkDivision">Division</label>
																						<img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Angul_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Angul_vector:division_boundary"
																							class="img-chk2" />
																					</div>
																					<div
																						class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																						<input type="checkbox"
																							class="custom-control-input"
																							value="RangeBoundary"
																							id="chkRange">
																						<label
																							class="custom-control-label"
																							for="chkRange">Range</label>
																						<img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Angul_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Angul_vector:range_boundary"
																							class="img-chk2" />
																					</div>
																					<div
																						class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																						<input type="checkbox"
																							class="custom-control-input"
																							id="chkSectn">
																						<label
																							class="custom-control-label"
																							for="chkSectn">Section</label>
																						<img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Sambalpur_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Sambalpur_vector:section_boundary"
																							class="img-chk2" />
																					</div>
																					<div
																						class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																						<input type="checkbox"
																							class="custom-control-input"
																							id="chkBeat">
																						<label
																							class="custom-control-label"
																							for="chkBeat">Beat</label>
																						<img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Sambalpur_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Sambalpur_vector:beat_boundary"
																							class="img-chk2" />
																					</div>
																				</div>
																			</div>
																		</form>
																	</div>
																	<%-- <a id="gdtab" href="#collapse14"
																		class="collapsed icon-header"
																		data-toggle="collapse" aria-expanded="false"
																		aria-controls="collapse14" style="display:none">
																		<h6
																			class="mt-0 header-title map-title-secondary mb-4">
																			Ground Demarcation<i
																				class="fa fa-angle-right pull-right"></i>
																		</h6>
																		</a>
																		<div id="collapse14" class="collapse"
																			aria-labelledby="heading13"
																			data-parent="#accordion3">
																			<form>
																				<div class="row form-group">
																					<div class="col-md-12">
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								value="" id="chkFPCP">
																							<label
																								class="custom-control-label"
																								for="chkFPCP">FPCP</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								value="" id="chkFSCP">
																							<label
																								class="custom-control-label"
																								for="chkFSCP">FSCP</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkGCP" disabled>
																							<label
																								class="custom-control-label"
																								for="chkGCP">Other
																								GCP</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkDGPS">
																							<label
																								class="custom-control-label"
																								for="chkDGPS">Forest
																								Boundary Pillar
																								(DGPS)</label>
																						</div>
																						<div class="row" id="drpFB"
																							style="display:none">
																							<div class="col-md-12">
																								<div
																									class="border-light p-2">
																									<div class="row">
																										<div
																											class="col-md-3">
																											<label>Range</label>
																										</div>
																										<div
																											class="col-md-9">
																											<select
																												class="form-control form-control-sm mb-2"
																												id="drpRng"
																												name="drpRng">
																												<option
																													value="">
																													--Select--
																												</option>
																												<c:forEach
																													items="${rngList}"
																													var="rList">
																													<option
																														value="${rList.intId}">
																														${rList.chrvRangeNm}
																													</option>
																												</c:forEach>
																											</select>
																										</div>
																									</div>
																									<div class="row">
																										<div
																											class="col-md-3">
																											<label>FB</label>
																										</div>
																										<div
																											class="col-md-9">
																											<select
																												class="form-control form-control-sm mb-2"
																												id="drpfblist"
																												name="drpfblist">
																												<option
																													value="">
																													--Select--
																												</option>
																												<c:forEach
																													items="${fbList}"
																													var="fList">
																													<option
																														value="${fList.intId}">
																														${fList.chrvRangeNm}
																													</option>
																												</c:forEach>
																											</select>
																										</div>
																									</div>
																									<div class="row">
																										<div
																											class="col-md-12 text-center">
																											<button
																												type="button"
																												id="btnDgpsSubmit"
																												class="btn btn-sm btn-success">Apply</button>
																											<button
																												type="button"
																												id="btnClear"
																												class="btn btn-sm btn-danger">Clear</button>
																										</div>
																									</div>
																								</div>
																							</div>

																						</div>
																					</div>
																				</div>
																			</form>
																		</div> --%>

																		<a id="" href="#collapse15" class="collapsed"
																			data-toggle="collapse" aria-expanded="false"
																			aria-controls="collapse15">
																			<h6
																				class="mt-0 header-title map-title-secondary mb-4">
																				Protected Area<i
																					class="fa fa-angle-right pull-right"></i>
																			</h6>
																		</a>
																		<div id="collapse15" class="collapse"
																			aria-labelledby="heading3"
																			data-parent="#accordion3">
																			<form>
																				<div class="row form-group">
																					<div class="col-md-12">
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkSanc">
																							<label
																								class="custom-control-label"
																								for="chkSanc">Sanctuary
																								Boundary</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkNatPark"
																								disabled>
																							<label
																								class="custom-control-label"
																								for="chkNatPark">National
																								Park</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkEcoSens"
																								disabled>
																							<label
																								class="custom-control-label"
																								for="chkEcoSens">Eco-sensitive
																								Zone</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkNWC" disabled>
																							<label
																								class="custom-control-label"
																								for="chkNWC">Notified
																								Wildlife
																								Corridor</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkConsRes"
																								disabled>
																							<label
																								class="custom-control-label"
																								for="chkConsRes">Conservation
																								Reserve</label>
																						</div>
																					</div>
																				</div>
																			</form>
																		</div>
																		<a id="" href="#collapse16" class="collapsed"
																			data-toggle="collapse" aria-expanded="false"
																			aria-controls="collapse16">
																			<h6
																				class="mt-0 header-title map-title-secondary mb-4">
																				FSI - Forest Cover Map<i
																					class="fa fa-angle-right pull-right"></i>
																			</h6>
																		</a>
																		<div id="collapse16" class="collapse"
																			aria-labelledby="heading4"
																			data-parent="#accordion3">
																			<form>
																				<div
																					class="row form-group form-scroll border pt-2 pb-2">
																					<div class="col-md-12">
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="checkbox41"
																								disabled>
																							<label
																								class="custom-control-label"
																								for="checkbox41">Forest
																								Cover 2020</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="checkbox42"
																								disabled>
																							<label
																								class="custom-control-label"
																								for="checkbox42">Forest
																								Cover 2018</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="checkbox43"
																								disabled>
																							<label
																								class="custom-control-label"
																								for="checkbox43">Forest
																								Cover 2016</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="checkbox44"
																								disabled>
																							<label
																								class="custom-control-label"
																								for="checkbox44">Forest
																								Cover 2014</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="checkbox45"
																								disabled>
																							<label
																								class="custom-control-label"
																								for="checkbox45">Forest
																								Cover 2012</label>
																						</div>
																					</div>
																				</div>
																			</form>
																		</div>
																		<a id="" href="#collapse17" class="collapsed"
																			data-toggle="collapse" aria-expanded="false"
																			aria-controls="collapse17">
																			<h6
																				class="mt-0 header-title map-title-secondary mb-4">
																				Hydrological Layers<i
																					class="fa fa-angle-right pull-right"></i>
																			</h6>
																		</a>
																		<div id="collapse17" class="collapse"
																			aria-labelledby="heading5"
																			data-parent="#accordion3">
																			<form>
																				<div class="row form-group">
																					<div class="col-md-12">
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="checkRiver">
																							<label
																								class="custom-control-label"
																								for="checkRiver">Rivers</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="checkReservoir">
																							<label
																								class="custom-control-label"
																								for="checkReservoir">Reservoirs</label>
																						</div>
																					</div>
																				</div>
																			</form>
																		</div>
																		<a id="" href="#collapse18" class="collapsed"
																			data-toggle="collapse" aria-expanded="false"
																			aria-controls="collapse18">
																			<h6
																				class="mt-0 header-title map-title-secondary mb-4">
																				Transport Layers<i
																					class="fa fa-angle-right pull-right"></i>
																			</h6>
																		</a>
																		<div id="collapse18" class="collapse"
																			aria-labelledby="heading6"
																			data-parent="#accordion3">
																			<form>
																				<div class="row form-group">
																					<div class="col-md-12">
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="checkRail">
																							<label
																								class="custom-control-label"
																								for="checkRail">Rail</label>
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="checkRoad">
																							<label
																								class="custom-control-label"
																								for="checkRoad">Road</label>
																						</div>
																					</div>
																				</div>
																			</form>
																		</div>
																		<a id="" href="#collapse19"
																			class="collapsed icon-header"
																			data-toggle="collapse" aria-expanded="false"
																			aria-controls="collapse19">
																			<h6
																				class="mt-0 header-title map-title-secondary mb-4">
																				Reference Data Overlay<i
																					class="fa fa-angle-right pull-right"></i>
																			</h6>
																		</a>
																		<div id="collapse19" class="collapse"
																			aria-labelledby="heading14"
																			data-parent="#accordion3">
																			<form>
																				<div class="row form-group">
																					<div class="col-md-12">
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkHrsi" >
																							<label
																								class="custom-control-label"
																								for="chkHrsi">HRSI</label>
																						</div>
																						<!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="checkbox122" disabled>
	                                                                                <label class="custom-control-label" for="checkbox122">FSI</label>
	                                                                            </div> -->
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkOsm">
																							<label
																								class="custom-control-label"
																								for="chkOsm">SOI OSM
																								TOPO</label>
																							<!-- <img src="https://mapserver.odisha4kgeo.in/geoserver/Athamallik_OSM/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=Athamallik_OSM:f45-m12"/> -->
																						</div>
																						<div
																							class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																							<input type="checkbox"
																								class="custom-control-input"
																								id="chkWp">
																							<label
																								class="custom-control-label"
																								for="chkWp">Working
																								Plan</label>
																							<!-- <img src="https://mapserver.odisha4kgeo.in/geoserver/Angul_Working_Plan/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=Angul_Working_Plan:73C_12"/> -->
																						</div>
																						<!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="checkbox124" disabled>
	                                                                                <label class="custom-control-label" for="checkbox124">Village Cadastral</label>
	                                                                            </div> -->
																					</div>
																				</div>
																			</form>
																		</div>
																		<div class="clearfix"></div>
																</div>

															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<!-- <div class="mb-0">
								<div id="collapseTwo" class="collapse show"
									aria-labelledby="headingTwo" data-parent="#accordion">
									<div class="card">
										<div class="card-body">
											<div class="fixHeightRight">
												<button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><span aria-hidden="true">�</span></button>
												<div class="card-body custom-card-body">
													<h6 class="mt-0 page-title mb-3">Layers</h6>

													<div id="accordion2">
														<a id="" href="#collapse1" class="collapsed"
															data-toggle="collapse" aria-expanded="true"
															aria-controls="collapse1">
															<h6 class="mt-0 header-title map-title-secondary mb-3">
																Administrartive Boundary<i
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
																			<input type="checkbox" class="custom-control-input"
																				value="StateBoundary" checked id="chkState">
																			<label class="custom-control-label" for="chkState">State
																				Boundary</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				value="DistrictBoundary" checked id="chkDistrict">
																			<label class="custom-control-label" for="chkDistrict">District
																				Boundary</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				value="DivisionBoundary" id="chkDivision"> <label
																				class="custom-control-label" for="chkDivision">Division
																				Boundary</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				value="RangeBoundary" id="chkRange"> <label
																				class="custom-control-label" for="chkRange">Range
																				Boundary</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				value="TahasilBoundary" id="chkTehsil"> <label
																				class="custom-control-label" for="chkTehsil">Tahasil
																				Boundary</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				value="VillageBoundary" id="chkVillage"> <label
																				class="custom-control-label" for="chkVillage">Village
																				Boundary</label>
																		</div>
																	</div>
																</div>
															</form>
														</div>
														 <span class="spInfo">* Search District/ Division to View other Layers</span>

														<a id="" href="#collapse2" class="collapsed"
															data-toggle="collapse" aria-expanded="false"
															aria-controls="collapse2">
															<h6 class="mt-0 header-title map-title-secondary mb-4">
																Notified Forest Boundary<i
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
																				id="chkCMV"> <label
																				class="custom-control-label" for="chkCMV">Cadastral
																				Map Vector(CMV)</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				id="chkMMV"> <label
																				class="custom-control-label" for="chkMMV">Management
																				Map Vector(MMV)</label>
																		</div>
																		<div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="chkDraftJV">
	                                                                                <label class="custom-control-label" for="checkbox33">Draft JV</label>
	                                                                            </div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				id="chkFinalJV"> <label
																				class="custom-control-label" for="chkFinalJV">Final
																				JV</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				id="chkNFB"> <label
																				class="custom-control-label" for="chkNFB">Draft
																				DGPS</label>
																		</div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				id="chkFinalDGPS"> <label
																				class="custom-control-label" for="chkFinalDGPS">Final
																				DGPS</label>
																		</div>
																	</div>
																</div>
															</form>
														</div>
														<a id="" href="#collapse3" class="collapsed"
															data-toggle="collapse" aria-expanded="false"
															aria-controls="collapse3">
															<h6 class="mt-0 header-title map-title-secondary mb-4">
																Revenue Forest Boundary<i
																	class="fa fa-angle-right pull-right"></i>
															</h6>
														</a>
														<div id="collapse3" class="collapse"
															aria-labelledby="heading3" data-parent="#accordion2">
															<form>
																<div class="row form-group">
																	<div class="col-md-12">
																		 <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="chkRFDraft">
	                                                                                <label class="custom-control-label" for="chkRFDraft">RF Boundary Draft</label>
	                                                                            </div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				id="chkRFFinal"> <label
																				class="custom-control-label" for="chkRFFinal">RF
																				Boundary Final</label>
																		</div>
																		<div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="chkDLCDraft">
	                                                                                <label class="custom-control-label" for="chkDLCDraft">DLC Draft</label>
	                                                                            </div>
																		<div
																			class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
																			<input type="checkbox" class="custom-control-input"
																				id="chkDLCFinal"> <label
																				class="custom-control-label" for="chkDLCFinal">DLC
																				Final</label>
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
							</div> -->

										<div class="mb-0">
											<div id="collapseThree" class="collapse" aria-labelledby="headingThree"
												data-parent="#accordion">
												<div class="card">
													<div class="card-body">
														<div class="fixHeightRight">
															<!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree"><span aria-hidden="true">�</span></button> -->
															<div class="card-body custom-card-body">
																<h6 class="mt-0 page-title mb-3">Legends</h6>
																<div class="row">
																	<div class="col-md-12 ml-1">
																		<div class="legendbox">
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_STATE/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_STATE:StateBoundary" /><span>State
																				Boundary</span>
																			<!-- <img src="/assets/img/state_boundary.png"> <span>State
																	Boundary</span> -->
																		</div>
																		<div class="legendbox">
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_AllDivision/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_AllDivision:district_boundary" /><span>District
																				Boundary</span>
																			<!-- <img src="/assets/img/district_boundary.png"> <span>District
																	Boundary</span> -->
																		</div>
																		<div class="legendbox">
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Sambalpur_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Sambalpur_vector:division_boundary" /><span>Division
																				Boundary</span>
																			<!-- <img src="/assets/img/division_boundary.png"> <span>Division
																	Boundary</span> -->
																		</div>
																		<div class="legendbox">
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Sambalpur_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Sambalpur_vector:tahasil_boundary" /><span>Tehsil
																				Boundary</span>
																			<!-- <img src="/assets/img/legend-04.png"> <span>Tehsil
																	Boundary</span> -->
																		</div>
																		<div class="legendbox">
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Sambalpur_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Sambalpur_vector:range_boundary" /><span>Range
																				Boundary</span>
																			<!-- <img src="/assets/img/range_boundary.png"> <span>Range
																	Boundary</span> -->
																		</div>
																		<div class="legendbox">
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Phulbani_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Phulbani_vector:village_boundary" /><span>Village
																				Boundary</span>
																		</div>
																		<div class="legendbox">
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Sambalpur_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Sambalpur_vector:section_boundary" /><span>Section
																				Boundary</span>
																		</div>
																		<div class="legendbox">
																			<img
																				src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Sambalpur_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Sambalpur_vector:beat_boundary" /><span>Beat
																				Boundary</span>
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
											<div id="collapseFour" class="collapse" aria-labelledby="headingFour"
												data-parent="#accordion">
												<div class="card">
													<div class="card-body">
														<div class="fixHeightRight">
															<!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour"><span aria-hidden="true">�</span></button> -->
															<div class="card-body custom-card-body">
																<h6 class="mt-0 page-title mb-3">Basemap</h6>
																<form>
																	<div class="row form-group">
																		<div class="col-md-12">
																			<!-- <div class="custom-control custom-checkbox checkbox-info">
	                                                                        <input type="checkbox" class="custom-control-input" id="checkbox21">
	                                                                        <label class="custom-control-label" for="checkbox21">Terrian</label>
	                                                                    </div>
	                                                                    <div class="custom-control custom-checkbox checkbox-info">
	                                                                        <input type="checkbox" class="custom-control-input" id="checkbox22">
	                                                                        <label class="custom-control-label" for="checkbox22">OSM</label>
	                                                                    </div>
	                                                                    <div class="custom-control custom-checkbox checkbox-info">
	                                                                        <input type="checkbox" class="custom-control-input" id="checkbox23">
	                                                                        <label class="custom-control-label" for="checkbox23">Cartography</label>
	                                                                    </div> -->
																			<div class="tab-box">
																				<ul class="basesection">
																					<li>
																						<a id="blank_basemap"
																							class="basebox"><img
																								src="/assets/img/icon-blank.png">
																							<h6>Blank</h6>
																						</a>
																					</li>
																					<li>
																						<a id="imagery_basemap"
																							class="basebox"><img
																								src="/assets/img/icon-imagery.png">
																							<h6>Imagery</h6>
																						</a>
																					</li>
																					<li>
																						<a id="street_basemap"
																							class="basebox"><img
																								src="/assets/img/icon-street.png">
																							<h6>Street</h6>
																						</a>
																					</li>
																					<li>
																						<a id="osm_basemap"
																							class="basebox"><img
																								src="/assets/img/icon-osm.png">
																							<h6>OSM</h6>
																						</a>
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
											<div id="collapseFive" class="collapse" aria-labelledby="headingFive"
												data-parent="#accordion">
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
																					<label for="type"
																						class="font-12 pt-2">Measurement</label>
																				</div>
																				<div class="col-md-8 mt-2">
																					<select id="type"
																						class="form-control form-control-sm custom-adj mb-2">
																						<option selected="selected">--
																							Select Type
																							--</option>
																						<option value="length">Length
																							(LineString)</option>
																						<option value="area">Area
																							(Polygon)</option>
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

								<div class="col-md-9">
									<div id="map" class="fixHeightLeft fixenlarge panel">
										<div class="map-tool-icon">
											<!-- <a href="javascript:void(0)" data-toggle="collapse" title="Toggle fullscreen" class="bs-tooltip" id="mapFullscreen" onclick="openFullscreen();"><img src="/assets/img/icon-zoom-to-extent.png"></span></a> -->
											<!-- <a href="#" class="bs-tooltip" title="Zoom in" id="ZoomIN"><img src="/assets/img/icon-zoom-in.png"></span></a> 
									<a href="#" class="bs-tooltip" title="Zoom out" id="ZoomOut"><img src="/assets/img/icon-zoom-out.png"></span></a> -->
											<!-- <a href="#" class="bs-tooltip" title="Back" onclick="back();"><img src="/assets/img/icon-back.png"></span></a> -->
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>

			</div>
			<!-- Pop up div -->
			<div id="popup" class="ol-popup">
				<a href="#" id="popup-closer" class="ol-popup-closer"></a>
				<div id="popup-content"></div>
			</div>
			
			<!-- BEGIN LOADER -->
			<div class="apploader-base">
			<div class="apploader"></div>
			</div>
			<!--  END LOADER -->
			
			<script src="https://epsg.io/32645.js"></script>
			<script src="/v5.3.0-dist/32644.js"></script>
			<script src="/assets/js/custom/layer_style.js"></script>

			<script type="text/javascript">
				var sectn_layer, sectn_layer1, beat_layer, beat_layer1, osm_topoLayer, wp_layer,hrsi_layer, river_layer,
					reservoir_layer, rail_layer, road_layer, sanctuary_layer
				var osm_topoLayer1 = [];
				var wp_layer1 = [];
				var hrsi_layer1=[];
				var tahasil_layer;
				var tahasil_layer1 = [];
				var nfb_layer;
				var rf_layer;
				var ca_layer;
				var layerinfo;
				var propArray = [];
				var rfArray = [];
				var caArray = [];
				var geom = [];
				var vectorSource1;
				var layerOrder = ["wp_layer", "osm_topoLayer","hrsi_layer", "road_layer", "rail_layer", "reservoir_layer", "river_layer", "sanctuary_layer", "beat_layer", "sectn_layer", "rng_layer", "divlayer", "village_layer", "tahasil_layer", "districtboundarylayer", "ca_layer", "rf_layer", "nfb_layer"];
				var checkboxOrder = ["chkWp", "chkOsm", "chkHrsi","checkRoad", "checkRail", "checkReservoir", "checkRiver", "chkSanc", "chkBeat", "chkSectn", "chkRange", "chkDivision", "chkVillage", "chkTehsil", "chkDist", "chkCmpnstryAL", "chkRFFinal", "chkNFB"];
				vectorSource1 = new ol.source.Vector({
				});
				var popValues;
				wp_layer = new ol.layer.Image({
				});
				osm_topoLayer = new ol.layer.Image({
				});
				road_layer = new ol.layer.Image({
				});
				rail_layer = new ol.layer.Image({
				});
				reservoir_layer = new ol.layer.Image({
				});
				river_layer = new ol.layer.Image({
				});
				sanctuary_layer = new ol.layer.Image({
				});
				beat_layer = new ol.layer.Image({
				});
				sectn_layer = new ol.layer.Image({
				});
				rng_layer = new ol.layer.Image({
				});
				divlayer = new ol.layer.Image({
				});
				village_layer = new ol.layer.Image({
				});
				tahasil_layer = new ol.layer.Image({
				});
				districtboundarylayer = new ol.layer.Image({
				});
				ca_layer = new ol.layer.Image({
				});
				rf_layer = new ol.layer.Image({
				});
				nfb_layer = new ol.layer.Image({
				});

				/* on single click both chkbox for NF will work same */

				var nfb1 = $("input[type='checkbox'][value='1']");
				var nfb2 = $("input[type='checkbox'][value='1']");
				var nfb3 = $("input[type='checkbox'][value='2']");
				var nfb4 = $("input[type='checkbox'][value='2']");
				var nfb5 = $("input[type='checkbox'][value='4']");
				var nfb6 = $("input[type='checkbox'][value='4']");
				var nfbAll = $("input[type='checkbox'][value='0']");

				nfbAll.on('change', function () {

					nfb1.prop('checked', this.checked);
					nfb3.prop('checked', this.checked);
				});

				nfb1.on('change', function () {
					nfb2.prop('checked', this.checked);
					$("#NfbLabel").show();
					$("#NfbLabel").toggle(this.checked);
					//nfb2.trigger( "click");
					$("#btnnotation").trigger("click");
				});


				nfb3.on('change', function () {
					nfb4.prop('checked', this.checked);
					$("#dlcLabel").show();
					$("#dlcLabel").toggle(this.checked);
					$("#btnnotation2").trigger("click");
				});
				nfb5.on('change', function () {
					nfb6.prop('checked', this.checked);
					$("#caLabel").show();
					$("#caLabel").toggle(this.checked);
					$("#btnnotation3").trigger("click");
				});

				$("#chkNFB").on("click", function (event) {
					$('input[type="checkbox"][value="1"]')
						.attr('checked', true)
						.trigger('click')
						.attr('checked', true);
					$("#btnnotation").trigger("click");



					try {
						if ($(this).prop("checked")) {
							//$("#btnShow" ).trigger( "click");
							//nfb_layer.setVisible(true);
							LayerOrdering();
						}
						else {
							nfb_layer.setVisible(false);
						}

					} catch (e) {

					}

				});

				$("#chkRFFinal").on("click", function (event) {
					$('input[type="checkbox"][value="2"]')
						.attr('checked', true)
						.trigger('click')
						.attr('checked', true);
					$("#btnnotation2").trigger("click");
				});

				$("#chkCmpnstryAL").on("click", function (event) {
					$('input[type="checkbox"][value="4"]')
						.attr('checked', true)
						.trigger('click')
						.attr('checked', true);
					$("#btnnotation3").trigger("click");

					try {
						if ($(this).prop("checked")) {
							//$("#btnShow" ).trigger( "click");
							ca_layer.setVisible(true);
						}
						else {
							ca_layer.setVisible(false);
						}

					} catch (e) {

					}
				});
				//Bind NFB Layers
				function LoadFBLayer() {
					//alert("nfb")
					if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "" && $("#drpfltype").val() != '' && $("#drpfltype").val() != null) {
						//$(".apploader-base").css("display", "block");
						fldDataview();
						$(".tbody").html("");
						try {
							caArray.forEach(function (ca_layer) {
								map.removeLayer(ca_layer);
							});
							rfArray.forEach(function (rf_layer) {
								map.removeLayer(rf_layer);
							});
							map.removeLayer(nfb_layer);
							layerinfo = "";
							//propArray="";
							var paramdist = ($("#drpDistrict").val() == 0 ? 0 : $("#drpDistrict").val());
							var paramdivision = ($("#drpDivision").val() == 0 ? 0 : $("#drpDivision").val());
							var range_code = ($("#drpRngList").val() == null || $("#drpRngList").val() == "") ? "" : $("#drpRngList").val();
							var flType = $("#drpfltype").val();
							var condn, operator, opvalue;
							condn = ($("#ddlArea").val() == null || $("#ddlArea").val() == "") ? 0 : $("#ddlArea").val();
							operator = ($("#ddlOperator").val() == null || $("#ddlOperator").val() == "") ? 0 : $("#ddlOperator").val();
							opvalue = ($("#txtValue").val() == null || $("#txtValue").val() == "") ? 0 : $("#txtValue").val().replace('-', '');
							opvalueCALand = ($("#txtValue").val() == null || $("#txtValue").val() == "") ? '0-15' : $("#txtValue").val();
							var landtype = "";
							// dtForest.clear();
							var i = 1;
							if (flType.includes("1")) {
								//$("#loaderNfb").show();
								$(".apploader-base").css("display", "block");
								$.ajax({
									async: true,
									url: "/LoadLayers",
									data: {
										'landType': "1",
										'distid': paramdist,
										'divid': paramdivision,
										'rangeCode': range_code,
										'condn': condn,
										'operator': operator,
										'opvalue': opvalue
									},
									type: "GET",
									contentType: "application/json;charset=utf-8",
									dataType: "json",
									success: function (result) {
										//console.log(result);
										//$("#loaderNfb").hide();
										$(".apploader-base").css("display", "none");
										var jsonObj = {};
										var arr = [];
										//var nfbList=${data};
										var k = 0;
										result.forEach(function (data) {
											k = k + 1;
											var jsonData = {};
											jsonData["geometry"] = JSON.parse(data.geom);
											jsonData["type"] = "Feature";
											let cmvProp = JSON.parse(JSON.stringify(data))
											delete cmvProp['geom'];
											jsonData["properties"] = cmvProp;
											arr.push(jsonData);


											//propArray.push(cmvProp);
											// i=i+1;
											/* "+cmvProp.colortag+" */
											/*  layerinfo+="<tr>";
											layerinfo+="<td>"+(i++)+"</td>";
											layerinfo+="<td><input type='hidden' value="+cmvProp.fb_id+"/>"+"Notified Forest"+"</td>";
											layerinfo+="<td>"+cmvProp.fb_name+"<sup>"+cmvProp.colortag+"</sup></td>";
											layerinfo+="<td>"+""+"</td>";
											layerinfo+="<td>"+cmvProp.area_ha+"</td>";
											layerinfo+="<td>"+(cmvProp.area_ha*2.47105)+"</td>";
											layerinfo+="<td><button type='button' class='btn btn-sm btn-success waves-effect waves-light'  onclick='BindFBDetails("+cmvProp.fb_id+")'><i aria-hidden='true' class='fa fa-eye' id='btneye' ></i></button>"+
											   "<button type='button' class='btn btn-sm teal-color  waves-effect waves-light'   onclick='MapView("+cmvProp.fb_id+","+cmvProp.fb_name+")'><i aria-hidden='true' class='fa fa-map'></i></button></td>";
											layerinfo+="</tr>";
										   
											$(".tbody").html(layerinfo); */

											dtForest.row.add([i++, "Notified Forest", data.range_name, data.fb_name + "&nbsp;<sup class='badge badge-pills badge-info badge-map'>" + data.colortag.toString().replace(1, '') + "</sup>", data.fb_type, parseFloat(data.area_ha).toFixed(2), parseFloat(data.area_ha * 2.47105).toFixed(2),
											"<button type='button' class='btn btn-sm btn-success waves-effect waves-light mr-1'  onclick='BindFBDetails(" + data.fb_id + ")'><i aria-hidden='true' class='fa fa-eye' id='btneye' ></i></button>" +
											"<button type='button' class='btn btn-sm btn-info  waves-effect waves-light'   onclick='MapView(" + data.fb_id + ")'><i aria-hidden='true' class='fa fa-map'></i></button>"
											]);


											if (k == result.length - 1) {
												//dtForest.draw(false);
											}
										});

										dtForest.draw(false);

										jsonObj["features"] = arr;
										jsonObj["type"] = "FeatureCollection";
										ol.proj.proj4.register(proj4);
										var format = new ol.format.GeoJSON({
											projection: 'EPSG:3857'
										});
										var vectorSource = new ol.source.Vector({
											features: format.readFeatures(jsonObj, {
												dataProjection: new ol.proj.get('EPSG:4326'),
												featureProjection: new ol.proj.get('EPSG:3857')
											}),
											wrapX: false,
											crossOrigin: 'anonymous'
										});

										nfb_layer = new ol.layer.Vector({
											source: vectorSource,
											style: nfb_survey_style,
											title: 'nfbLayer'
										});
										LayerOrdering();
										//map.addLayer(nfb_layer);

										//nfb_layer.setVisible(true);
									},
									error: function (errormessage) {
										alert(errormessage.responseText);
									}
								});
							}
							//for DLC and REVENUE
							if (flType.includes("2")) {
								//alert("DLC & rev")
								//var range_code = ($("#drpRngList").val() == null || $("#drpRngList").val() == "") ? "" : $("#drpRngList").val();
								var tahasil_id = ($("#drpTehList").val() == null || $("#drpTehList").val() == "") ? 0 : $("#drpTehList").val();
								//var ricid = ($("#drpRic").val() == null || $("#drpRic").val() == "") ? 0 : $("#drpRic").val();
								var ric = ($("#drpRic option:selected").text() == "--Select--" || $("#drpRic option:selected").text() == "") ? "" : $("#drpRic option:selected").text();
								var vill_code = ($("#drpVill").val() == null || $("#drpVill").val() == "") ? 0 : $("#drpVill").val();

								//$("#loaderRev").show();
								$(".apploader-base").css("display", "block");
								$.ajax({
									url: "/LoadLayers",
									async: true,
									data: {
										'type': 24,
										'landType': "2",
										'distid': paramdist,
										'divid': paramdivision,
										'rangeCode': range_code,
										'tahasil_id': tahasil_id,
										'ric': ric,
										'vill_code': vill_code,
										'condn': condn,
										'operator': operator,
										'opvalue': opvalue
									},
									type: "GET",
									contentType: "application/json;charset=utf-8",
									dataType: "json",
									success: function (result) {
										//alert("enterd")
										//console.log(result)
										var layerquery = "";
										//Filter Tehsil,RIC,Village,plot_no
										if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "plot_no") && (operator == "==")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND vill_code=" + vill_code + " AND plot_no = " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "plot_no") && (operator == "<=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND vill_code=" + vill_code + " AND plot_no <= " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "plot_no") && (operator == ">=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND vill_code=" + vill_code + " AND plot_no >= " + opvalue + ") ";
										}
										//end

										//Filter Tehsil,RIC,Village,area_ac
										else if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "area_ac") && (operator == "==")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND vill_code=" + vill_code + " AND area_ac = " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "area_ac") && (operator == "<=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND vill_code=" + vill_code + " AND area_ac <= " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "area_ac") && (operator == ">=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND vill_code=" + vill_code + " AND area_ac >= " + opvalue + ") ";
										}
										//end

										//Filter Tehsil,RIC,Village,publYear
										else if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "publYear") && (operator == "==")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND vill_code=" + vill_code + " AND publ_year = " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "publYear") && (operator == "<=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND vill_code=" + vill_code + " AND publ_year <= " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "publYear") && (operator == ">=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND vill_code=" + vill_code + " AND publ_year >= " + opvalue + ") ";
										}
										//end

										//Filter Tehsil,RIC,plot_no
										else if (tahasil_id > 0 && ric != null && (condn != null && condn != "" && condn == "plot_no") && (operator == "==")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND plot_no = " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && (condn != null && condn != "" && condn == "plot_no") && (operator == "<=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND plot_no <= " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && (condn != null && condn != "" && condn == "plot_no") && (operator == ">=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND plot_no >= " + opvalue + ") ";
										}
										//end

										//Filter Tehsil,RIC,area_ac
										else if (tahasil_id > 0 && ric != null && (condn != null && condn != "" && condn == "area_ac") && (operator == "==")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND area_ac = " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && (condn != null && condn != "" && condn == "area_ac") && (operator == "<=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND area_ac <= " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && (condn != null && condn != "" && condn == "area_ac") && (operator == ">=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND area_ac >= " + opvalue + ") ";
										}
										//end

										//Filter Tehsil,RIC,publYear
										else if (tahasil_id > 0 && ric != null && (condn != null && condn != "" && condn == "publYear") && (operator == "==")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "'AND publ_year = " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "publYear") && (operator == "<=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND publ_year <= " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && ric != null && vill_code > 0 && (condn != null && condn != "" && condn == "publYear") && (operator == ">=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND publ_year >= " + opvalue + ") ";
										}
										//end


										//Filter Tahasil,RIC,Village
										else if (tahasil_id > 0 && ric != null && vill_code > 0) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "' AND vill_code=" + vill_code + ") ";
										}
										//end

										//Filter Tahasil,RIC
										else if (tahasil_id > 0 && (ric != null && ric != '')) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "') ";
										}
										//end



										//Filter Tehsil,plot_no
										else if (tahasil_id > 0 && (condn != null && condn != "" && condn == "plot_no") && (operator == "==")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND plot_no = " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && (condn != null && condn != "" && condn == "plot_no") && (operator == "<=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND plot_no <= " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && (condn != null && condn != "" && condn == "plot_no") && (operator == ">=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND plot_no >= " + opvalue + ") ";
										}
										//end

										//Filter Tehsil,area_ac
										else if (tahasil_id > 0 && (condn != null && condn != "" && condn == "area_ac") && (operator == "==")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND area_ac = " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && (condn != null && condn != "" && condn == "area_ac") && (operator == "<=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND area_ac <= " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && (condn != null && condn != "" && condn == "area_ac") && (operator == ">=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND area_ac >= " + opvalue + ") ";
										}
										//end

										//Filter Tehsil,publYear
										else if (tahasil_id > 0 && (condn != null && condn != "" && condn == "publYear") && (operator == "==")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND publ_year = " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && (condn != null && condn != "" && condn == "publYear") && (operator == "<=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND publ_year <= " + opvalue + ") ";
										}
										else if (tahasil_id > 0 && (condn != null && condn != "" && condn == "publYear") && (operator == ">=")) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND publ_year >= " + opvalue + ") ";
										}
										//end

										else if (tahasil_id > 0) {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " ) ";
										}
										/* else if(range_code!=null && range_code !="" )
										{
											layerquery="((land_class='Govt. Forest' OR land_class='Private Forest') AND range_id='"+range_code+"' ) ";
										} */
										else if (condn != null && condn != "") {
											layerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND plot_no=" + opvalue + " ) ";
										}
										else {
											layerquery = "(land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') ";
										}
										//alert("lopyt200")
										if (result.length > 0) {
											result.forEach(function (rfdata) {
												var i = 1;
												var url = rfdata.chrvGlink + '?service=WFS&version=1.0.0&request=GetFeature&typeName=' + rfdata.chrvStrLayerNm + '&outputFormat=application%2Fjson&CQL_FILTER=' + layerquery;
												//console.log(url);
												//alert('olp')
												//console.log(url)
												ol.proj.proj4.register(proj4);
												//alert('olp00')
												var features;
												jQuery.getJSON(url, function (data) {
													features = new ol.format.GeoJSON().readFeatures(data, {
														dataProjection: new ol.proj.get('EPSG:' + rfdata.utmZone),
														featureProjection: new ol.proj.get('EPSG:3857')
													});

													if (features.length > 0) {
														//var props = features.properties;

														var vectorSource = new ol.source.Vector({
															features: features,
															wrapX: false,
														});

														rf_layer = new ol.layer.Vector({
															source: vectorSource,
															style: rev_dlc_style,
															title: 'rfLayer'
														});
														rfArray.push(rf_layer);
														LayerOrdering();
														//map.addLayer(rf_layer);
														//rf_layer.setVisible(true);


													}
													else {
														if (rfdata.length == 0) {
															alert("Feature Layer is not found");
															return;
														}
														//rfList.shift();
														//addRFLayer(rfList);
													}

												});
											});
											var sdata = [];
											var j = 1;
											var kp = 0;

											var arrres = [];
											let tmp;
											//alert(layerquery)
											result.forEach(function (featuredata) {
												var url = featuredata.chrvGlink + '?service=WFS&version=1.0.0&request=GetFeature&typeName=' + featuredata.chrvStrLayerNm + '&outputFormat=application%2Fjson&CQL_FILTER=' + layerquery;
												if (url) {
													fetch(url)
														.then(function (response) { return response.json(); })
														.then(function (html) {
															kp = kp + 1;
															if (html.features.length > 0) {
																sdata = sdata.concat(html.features);
															}
															var sl = 1;
															if (kp == result.length) {

																var s = sdata.length;

																$.each(sdata, function (key, item) {
																	let village_code = item['properties']['vill_code'];
																	tmp = [sl++, "Revenue Forest", item['properties']['tahasil'], item['properties']['ric'], item['properties']['village'], item['properties']['plot_no'], (item['properties']['area_ac'] / 2.47105).toFixed(3), item['properties']['area_ac'],
																	"<button type='button' class='btn btn-sm btn-success waves-effect waves-light mr-1'  onclick=BindRfDetails('" + village_code + "'," + item['properties']['plot_no'] + ")><i aria-hidden='true' class='fa fa-eye' id='btneye' ></i></button>" +
																	"<button type='button' class='btn btn-sm btn-info  waves-effect waves-light'   onclick='revMapView(" + item['properties']['plot_no'] + "," + item['properties']['vill_code'] + ")'><i aria-hidden='true' class='fa fa-map'></i></button>"
																	];
																	arrres.push(tmp);
																	// arrres=
																	/*   dtRev.row.add([i++,"Revenue Forest",item['properties']['tahasil'],item['properties']['ric'], item['properties']['village'], item['properties']['plot_no'],(item['properties']['area_ac']/2.47105).toFixed(2), item['properties']['area_ac'],
																		  "<button type='button' class='btn btn-sm btn-success waves-effect waves-light mr-1'  onclick='BindRfDetails("+item['properties']['vill_code']+","+item['properties']['plot_no']+")'><i aria-hidden='true' class='fa fa-eye' id='btneye' ></i></button>" +
																		  "<button type='button' class='btn btn-sm btn-info  waves-effect waves-light'   onclick='revMapView("+item['properties']['plot_no']+","+item['properties']['vill_code']+")'><i aria-hidden='true' class='fa fa-map'></i></button>"
																	  ]); */
																	if (key != 0 && key % 200 == 0) {
																		s = s - 200;

																	}

																	if (s < 200 && key == (sdata.length - 1)) {
																		//$("#loaderRev").hide();
																		$(".apploader-base").css("display", "none");
																		dtRev.rows.add(arrres).draw();
																		//dtRev.draw(false);
																	}
																});
																//loader hide if empty data will come
																$(".apploader-base").css("display", "none");
															}

														});
												}

											});
										}
									},
									error: function (errormessage) {
										$("#loaderRev").hide();
									}
								});

							}
							//For CAF/DRFL Land
							if (flType.includes("4")) {
								var tahasil_id = ($("#drpTehList").val() == null || $("#drpTehList").val() == "") ? 0 : $("#drpTehList").val();
								var ric = ($("#drpRic option:selected").text() == "--Select--" || $("#drpRic option:selected").text() == "") ? "" : $("#drpRic option:selected").text();
								var vill_code = ($("#drpVill").val() == null || $("#drpVill").val() == "") ? 0 : $("#drpVill").val();

								//$("#loaderCA").show();
								$(".apploader-base").css("display", "block");
								$.ajax({
									url: "/LoadLayers",
									async: true,
									data: {
										'type': 40,
										'landType': "4",
										'distid': paramdist,
										'divid': paramdivision,
										'rangeCode': range_code,
										'tahasil_id': tahasil_id,
										'ric': ric,
										'vill_code': vill_code,
										'condn': condn,
										'operator': operator,
										'opvalue': opvalue
									},
									type: "GET",
									contentType: "application/json;charset=utf-8",
									dataType: "json",
									success: function (result) {
										//console.log(result);
										var calayerquery = "";

										let operator2 = (operator == "==" ? "=" : operator);

										//Filter Tehsil,RIC,Village,area_ac
										if ((condn != null && condn != "" && condn == "area_ac")) {
											calayerquery = "(tah_id=" + (tahasil_id > 0 ? tahasil_id : 'tah_id') + " AND ric=" + (ric.length > 0 ? "'" + ric + "'" : 'ric') + "  AND vill_code=" + (vill_code > 0 ? vill_code : 'vill_code') + " AND area_ac " + operator2 + " " + opvalue + ") ";
											//alert(calayerquery);
										}

										//Filter Tehsil,RIC,Village,slope_deg
										else if ((condn != null && condn != "" && condn == "slope_deg") && (operator == "==")) {
											calayerquery = "(tah_id=" + (tahasil_id > 0 ? tahasil_id : 'tah_id') + " AND ric=" + (ric.length > 0 ? "'" + ric + "'" : 'ric') + "  AND vill_code=" + (vill_code > 0 ? vill_code : 'vill_code') + " AND slope_deg = '" + opvalueCALand + "') ";

											//alert(calayerquery);
										}
										//Filter Tehsil,RIC,Village
										else if (tahasil_id > 0 && (ric != null && ric != ''&& vill_code!='')) {
											 calayerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "'AND vill_code='"+vill_code+"') ";
											//calayerquery = "(tah_id=" + tahasil_id + " AND ric='" + ric + "'AND vill_code='"+vill_code+"') ";
											//alert(calayerquery);
										}
										
										//Filter Tahasil,RIC
										else if (tahasil_id > 0 && (ric != null && ric != '')) {
											calayerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " AND ric='" + ric + "') ";
											//alert(calayerquery);
										}
										//end
										//Filter Tahasil
                                       else if (tahasil_id > 0) {
                                    	   calayerquery = "((land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') AND tah_id=" + tahasil_id + " ) ";
                                    	   //alert(calayerquery);
										}//end
										else {
											calayerquery = "(land_class='Govt. Forest' OR land_class='Private Forest') ";
										}
										if (result.length > 0) {
											result.forEach(function (cadata) {
												//console.log(cadata);
												$("#loaderCA").hide();
												var i = 1;
												var url = cadata.chrvGlink + '?service=WFS&version=1.0.0&request=GetFeature&typeName=' + cadata.chrvStrLayerNm + '&outputFormat=application%2Fjson&CQL_FILTER=' + calayerquery;
												ol.proj.proj4.register(proj4);
												var features;
												jQuery.getJSON(url, function (data) {
													features = new ol.format.GeoJSON().readFeatures(data, {
														dataProjection: new ol.proj.get('EPSG:' + cadata.utmZone),
														featureProjection: new ol.proj.get('EPSG:3857')
													});
													if (features.length > 0) {
														//var props = features.properties;							
														var vectorSource = new ol.source.Vector({
															features: features,
															wrapX: false,
														});
														ca_layer = new ol.layer.Vector({
															source: vectorSource,
															style: ca_style,
															title: 'caLayer'
														});
														caArray.push(ca_layer);
														LayerOrdering();
														//map.addLayer(ca_layer);
														//ca_layer.setVisible(true);					         

													}
													else {
														if (cadata.length == 0) {
															alert("Feature Layer is not found");
															return;
														}
													}
												});
											});
											var caData = [];
											var j = 1;
											var cafp = 0;
											var arraies = [];

											let tmpCaf;
											result.forEach(function (featuredata) {
												var url = featuredata.chrvGlink + '?service=WFS&version=1.0.0&request=GetFeature&typeName=' + featuredata.chrvStrLayerNm + '&outputFormat=application%2Fjson&CQL_FILTER=' + calayerquery;
												if (url) {
													fetch(url)
														.then(function (response) { return response.json(); })
														.then(function (html) {
															cafp = cafp + 1;
															if (html.features.length > 0) {
																caData = caData.concat(html.features);
															}
															var sl = 0;
															if (cafp == result.length) {
																var s = caData.length;
																//alert("entry foreach")
																//console.log(caData);
																$.each(caData, function (key, item) {	
																	//alert("enter")	
																	sl++;
																	tmpCaf = [sl, item['properties']['tahasil'], item['properties']['ric'], item['properties']['village'], item['properties']['khata_no']
																		, item['properties']['plot_no'], item['properties']['area_ac'], item['properties']['carea_ac'], item['properties']['slope_deg'],

																		"<input type=hidden id=hdnDist" + sl + " value='" + item['properties']['dist_name'] + "'>" +
																		"<input type=hidden id=hdnDiv" + sl + " value='" + item['properties']['div_name'] + "'>" +
																		"<input type=hidden id=hdnRan" + sl + " value='" + item['properties']['range_name'] + "'>" +
																		"<input type=hidden id=hdnPs" + sl + " value='" + item['properties']['ps'] + "'>" +
																		"<input type=hidden id=hdnThanano" + sl + " value='" + item['properties']['thana_no'] + "'>" +
																		"<input type=hidden id=hdnKissam" + sl + " value='" + item['properties']['kissam'] + "'>" +
																		"<input type=hidden id=hdnRorcls" + sl + " value='" + item['properties']['ror_class'] + "'>" +
																		"<input type=hidden id=hdnLandcls" + sl + " value='" + item['properties']['land_class'] + "'>" +
																		"<input type=hidden id=hdnVariation" + sl + " value='" + item['properties']['variation'] + "'>" +
																		"<input type=hidden id=hdnAreaha" + sl + " value='" + item['properties']['area_ha'] + "'>" +
																		"<input type=hidden id=hdnCAreaha" + sl + " value='" + item['properties']['carea_ac'] + "'>" +
																		"<input type=hidden id=hdnCden" + sl + " value='" + item['properties']['wacd'] + "'>" +
																		"<input type=hidden id=hdnSlope" + sl + " value='" + item['properties']['slope_deg'] + "'>" +
																		"<button type='button' class='btn btn-sm btn-success waves-effect waves-light mr-1'  onclick=BindCADetails('" + (sl - 1) + "')><i aria-hidden='true' class='fa fa-eye' id='btneye'></i></button>" +
																		"<button type='button' class='btn btn-sm btn-info  waves-effect waves-light' onclick='cafMapView(" + item['properties']['plot_no'] + "," + item['properties']['vill_code'] + ")'><i aria-hidden='true' class='fa fa-map'></i></button>"
																		// "<button type='button' class='btn btn-sm btn-info  waves-effect waves-light'><i aria-hidden='true' class='fa fa-map'></i></button>"
																	];
																	//alert("loader end1")
																	arraies.push(tmpCaf);
																	if (key != 0 && key % 200 == 0) {
																		s = s - 200;
																	}
																	//alert("loader end2")
																	if (s < 200 && key == (caData.length - 1)) {																		
																		//alert("loader end3")
																		$(".apploader-base").css("display", "none");
																		//$("#loaderCA").hide();
																		dtCA.rows.add(arraies).draw();
																		//dtCA.draw(false);
																	}
																});
																//alert("loaderover")
																//loader hide if empty data will come
																$(".apploader-base").css("display", "none");
															}
														});
												}
											});
										}
										else {
											$(".apploader-base").css("display", "none");											
											//$("#loaderCA").hide();
											alert("Data not found");
										}
									},
									error: function (errormessage) {
										$("#loaderCA").hide();
									}
								});
							}
						}
						catch (error) {
							$("#loaderRev").hide();
							$("#loaderCA").hide();
						}
					}
					else {
						nfb_layer.setVisible(false);
						rf_layer.setVisible(false);
						ca_layer.setVisible(false);
						$("#chkNFB").prop('checked', false);
						$("#chkRFFinal").prop('checked', false);
						$("#chkCmpnstryAL").prop('checked', false);
					}
				}

				/* function LoadSancLayer()
				{
					try{
						map.removeLayer(sanctuary_layer);
						layerinfo="";
						//propArray="";
						var paramdist = ($("#drpDistrict").val()==0 ? 0 : $("#drpDistrict").val());
						var paramdivision = ($("#drpDivision").val() == 0 ?  0 :$("#drpDivision").val());
							$.ajax({
								async:true,
								url: "/LoadSanctuary",
								data: {
									'distid': paramdist,
									'divid': paramdivision
								},
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function(result) {
										var jsonObj = {};
										var arr=[];	        			 
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
											
										   sanctuary_layer = new ol.layer.Vector({
													  source: vectorSource,
													 title:'SanctuaryLayer'	
													  });
													map.addLayer(sanctuary_layer);
												    
												  sanctuary_layer.setVisible(true);
								},
								error: function(errormessage) {
									alert(errormessage.responseText);
								}
							});
						
					}
					catch(error)
					{
						$("#loaderRev").hide();
					}
				} */


				//overlay
				var container = document.getElementById('popup');
				var content = document.getElementById('popup-content');
				var closer = document.getElementById('popup-closer');
				var overlay = new ol.Overlay({
					element: container,
					positioning: 'bottom-center',
					stopEvent: true,
					autoPan: true,
					autoPanAnimation: {
						duration: 250
					}
				});
				map.addOverlay(overlay);
				closer.onclick = function () {
					overlay.setPosition(undefined);
					closer.blur();
					return false;
				};

				//Scale in Map
				var scaleLine = new ol.control.ScaleLine({ bar: true, text: true, minWidth: 140, steps: 4 });
				map.addControl(scaleLine);
				var activeTabL;
				$('#a_measure').click(function () {
					activeTabL = "measurementTab";
				});
				$('#a_layer').click(function () {
					activeTabL = "layerTab";
				});
				$(document).ready(function () {
					activeTabL = "layerTab";
				});
				
				//map onclick event
				map.on('click', function (evt) {
					content.innerHTML = '';
					vectorSource1.clear();
					var feature = map.forEachFeatureAtPixel(evt.pixel, function (feature, layer) {
						return feature;
					});

					var layer = map.forEachFeatureAtPixel(evt.pixel, function (feature, layer) {
						return layer;
					});

					if (feature) {
						var coord = feature.getGeometry().getCoordinates();
						var props = feature.getProperties();
						geom = [];

						geom.push(feature);
						vectorSource1.addFeatures(geom);
						feature = new ol.layer.Vector
							({
								source: vectorSource1,
								style: Highlightfeature_style

							});
						map.addLayer(feature);
						if (activeTabL == "layerTab") {

							//if( $("#drpfltype").val()=="1" /* props.surveytype=="DGPS Final" */)
							if (layer.get('title') == "nfbLayer") {
								content.innerHTML = "<h5>NFB Details</h5>"
									+ "<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr><td><strong>Division :</strong></td><td>" + props.division_name + "</td></tr>"
									+ "<tr><td><strong>Range :</strong></td><td>" + props.range_name + "</td></tr>"
									+ "<tr><td><strong>Forest Block :</strong></td><td>" + props.fb_name +"  " + props.fb_type +"</td></tr>"
									//+ "<tr><td><strong>FB Type :</strong></td><td>" + props.fb_type + "</td></tr>"
									//+"<tr><td><strong>Notification No :</strong></td><td>"+props.notf_no+"</td></tr>"
									+ "<tr><td><strong>Area(Ha.) :</strong></td><td>" + props.area_ha + "</td></tr>"
									+ "<tr><td><strong>Perimeter(KM) :</strong></td><td>" + props.perimeter + "</td></tr>"
									+ "<tr><td><strong>Survey Stage :</strong></td><td>" + props.surveytype + "</td></tr></table></div>";
								// http://103.55.73.169:5065/pillarsphoto/IMG_20201006_094354_4_47490436914561039648.jpg
								//+"<tr><td><strong>FRJVC Report :</strong></td><td><a href='"+report+"' target='_blank'><span>View</span></a></td></tr></table></div>";
								overlay.setPosition(evt.coordinate);
							}
							else if (layer.get('title') == "rfLayer") {
								content.innerHTML = "Revenue Details"
									+ "</br>" + "<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr><td><strong>Division :</strong></td><td>" + props.div_name + "</td></tr>"
									+ "<tr><td><strong>Tahasil :</strong></td><td>" + props.tahasil + "</td></tr>"
									+ "<tr><td><strong>RI Circle :</strong></td><td>" + props.ric + "</td></tr>"
									+ "<tr><td><strong>Village Name :</strong></td><td>" + props.village + "</td></tr>"
									/* + "<tr><td><strong>Publish Year :</strong></td><td>" + props.publ_year + "</td></tr>" */
									+ "<tr><td><strong>Khata No :</strong></td><td>" + props.khata_no + "</td></tr>"
									+ "<tr><td><strong>Plot No :</strong></td><td>" + props.plot_no + "</td></tr>"
									+ "<tr><td><strong>RoR Area(Acre) :</strong></td><td>" + props.area_ac + "</td></tr>"
									+ "<tr><td><strong>RoR Kissam :</strong></td><td>" + props.kissam + "</td></tr>"
									+ "<tr><td><strong>DLC Forest :</strong></td><td>" + (props.dlc != null ? props.dlc : 'No') + "</td></tr>"
									//+"<tr><td><strong>Rev Forest :</strong></td><td>Y</td></tr>"
									+ "<tr><td><strong>Land Type :</strong></td><td>" + props.land_class + "</td></tr></table></div>";
								overlay.setPosition(evt.coordinate);
							}
							else if (layer.get('title') == "caLayer") {
								content.innerHTML = "Compensatory Afforestation Details"
									+ "</br>" + "<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr><td><strong>Division :</strong></td><td>" + props.div_name + "</td></tr>"
									+ "<tr><td><strong>Tahasil :</strong></td><td>" + props.tahasil + "</td></tr>"
									+ "<tr><td><strong>RI Circle :</strong></td><td>" + props.ric + "</td></tr>"
									+ "<tr><td><strong>Village Name :</strong></td><td>" + props.village + "</td></tr>"
									+ "<tr><td><strong>Khata No :</strong></td><td>" + props.khata_no + "</td></tr>"
									+ "<tr><td><strong>Plot No :</strong></td><td>" + props.plot_no + "</td></tr>"
									+ "<tr><td><strong>ROR Area(Acre) :</strong></td><td>" + props.area_ac + "</td></tr>"
									+ "<tr><td><strong>ROR Kissam :</strong></td><td>" + props.kissam + "</td></tr>"
									+ "<tr><td><strong>Land Type :</strong></td><td>" + props.land_class + "</td></tr></table></div>";
								overlay.setPosition(evt.coordinate);
							}
							/*  else if($("#drpfltype").val()=="3")
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
								  }    */
						}
						if (props != null) {
							if (props.point_type == "DGPS") {
								content.innerHTML = "<h5>DGPS Pillar Point Details</h5>"
									// +"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-bordered'><tr><td colspan=2><img src='@ViewBag.dgpspillarPath"+getFileNameFromURL(props.dgpsfpic)+"' alt='Pillar Photo' width='100%' height='125'></td></tr>"
									+ "<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr></tr>"
									+ "<tr><td>Demarcated No</td><td>" + props.plr_no + "</td></tr>"
									+ "<tr><td>RTX Accuracy(In cm)</td><td>" + (props.rtxAccuracy == null ? "NA" : props.rtxAccuracy) + "</td></tr>"
									//+"<tr><td>Survey Time(MM:SS)</td><td>"+props.dgpsSmin +": "+props.dgpsSsec+"</td></tr>"
									+ "<tr><td>Latitude</td><td>" + props.latitude.toFixed(6) + "</td></tr>"
									+ "<tr><td>Longitude</td><td>" + props.longitude.toFixed(6) + "</td></tr></table></div>";
								overlay.setPosition(evt.coordinate);
							}
							else if (props.point_type == "FSCP") {
								content.innerHTML = "<h5>FSCP Point Details</h5>"
									+ "<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr></tr>"
									+ "<tr><td>FB Id</td><td>" + props.fbid + "</td></tr>"
									//+"<tr><td>Location</td><td>"+props.chrv_location+"</td></tr>"
									+ "<tr><td>Latitude</td><td>" + props.latitude.toFixed(6) + "</td></tr>"
									+ "<tr><td>Longitude</td><td>" + props.longitude.toFixed(6) + "</td></tr>"
									+ "<tr><td>Point Type</td><td>" + props.point_type + "</td></tr></table></div>";
								overlay.setPosition(evt.coordinate);
							}
							else if (props.point_type == "FPCP") {
								content.innerHTML = "<h5>FPCP Point Details</h5>"
									+ "<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'>"
									+ "<tr><td>Demarcated No</td><td>" + props.plr_no + "</td></tr>"
									+ "<tr><td>Location</td><td>" + props.Location + "</td></tr>"
									+ "<tr><td>Latitude</td><td>" + props.latitude.toFixed(6) + "</td></tr>"
									+ "<tr><td>Longitude</td><td>" + props.longitude.toFixed(6) + "</td></tr>"
									+ "<tr><td>Point Type</td><td>" + props.point_type + "</td></tr></table></div>";
								overlay.setPosition(evt.coordinate);
							}
						}
					}
					else {
						overlay.setPosition(undefined);
					}
					/* } */
				});



				/* On click of back button */
				/* function back() {
					
					$( "#divforData" ).show(); */
				//$("#divformMap").hide();
				// $('#map').hide();
				//}
				/* End- On click of back button */
				//Zoom In and Zoom Out
				$('#ZoomIN').click(function () {

					$('.ol-zoom-in').trigger("click");
				});
				$('#ZoomOut').click(function () {

					$('.ol-zoom-out').trigger("click");
				});

				/*    <!-- Full Screen -->
				var elem = document.getElementById("mapFullscreen");
				function openFullscreen() {
					$(".fixenlarge").toggleClass("intro");
					if (elem.requestFullscreen) {
						elem.requestFullscreen()
					}else if (elem.webkitRequestFullscreen) {    //Safari 
						elem.webkitRequestFullscreen();
					}else if (elem.msRequestFullscreen) {  // IE 11
						elem.msRequestFullscreen();
					}
				} */



				//map zoom click nfb
				function MapView(fbid) {
					geom = [];
					vectorSource1.clear();
					nfb_layer.getSource().forEachFeature(function (feature) {
						if (feature.values_.fb_id == fbid) {
							//geom.push(new ol.Feature(feature.getGeometry().clone().transform('EPSG:4326', 'EPSG:3857'))); 
							geom.push(feature);
							vectorSource1.addFeatures(geom);
						}

					});


					feature = new ol.layer.Vector({
						source: vectorSource1,
						style: Highlightfeature_style

					});

					$("#btnMapView").click();
					map.addLayer(feature);
					map.getView().fit(feature.getSource().getExtent(), (map.getSize()));
				}
				//map zoom click RF Layer
				function revMapView(plotNo, VillCode) {
					var i = 0;
					var j = 0;
					geom = [];
					vectorSource1.clear();
					rfArray.forEach(function (rf_layer) {
						j = j + 1;
						rf_layer.getSource().forEachFeature(function (feature) {
							if (feature.values_.plot_no == plotNo && feature.values_.vill_code == VillCode) {
								//geom.push(new ol.Feature(feature.getGeometry().clone().transform('EPSG:4326', 'EPSG:3857'))); 
								geom.push(feature);
								vectorSource1.addFeatures(geom);

								feature = new ol.layer.Vector({
									source: vectorSource1,
									style: Highlightfeature_style

								});

								$("#btnMapView").click();
								map.addLayer(feature);
								map.getView().fit(feature.getSource().getExtent(), (map.getSize()));
								i = 1;
								return;
							}

						});
						if (i == 1) {
							return;
						}
						else {
							console.log("feature not found:" + j);
						}
					});
				}
				//map zoom click CAF Layer
				function cafMapView(plotNo, VillCode) {
					var i = 0;
					var j = 0;
					geom = [];
					vectorSource1.clear();
					caArray.forEach(function (ca_layer) {
						j = j + 1;
						ca_layer.getSource().forEachFeature(function (feature) {
							if (feature.values_.plot_no == plotNo && feature.values_.vill_code == VillCode) {
								geom.push(feature);
								vectorSource1.addFeatures(geom);

								feature = new ol.layer.Vector({
									source: vectorSource1,
									style: Highlightfeature_style

								});

								$("#btnMapView").click();
								map.addLayer(feature);
								map.getView().fit(feature.getSource().getExtent(), (map.getSize()));
								i = 1;
								return;
							}

						});
						if (i == 1) {
							return;
						}
						else {
							console.log("feature not found:" + j);
						}
					});
				}
				//End of CAF 

				//Onclick of Section CheckBox   
				$("#chkSectn").on("click", function (event) {
					if (!$("#chkSectn").is(":checked")) {
						sectn_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							map.removeLayer(sectn_layer);
							var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
							var paramdiv = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();
							secLayernm = "";
							$.ajax({
								url: '/Utility/getDivisionVectorMapTypeLayerList',
								data: { 'distid': paramdist, 'divid': paramdiv, 'type': 11 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									if (obj != null) {
										secLayernm = obj[0].text;

										var query = "";
										if ($("#drpDivision").val() != "") {
											query = "div_id=" + $("#drpDivision option:selected").val();
										}
										if (query != "") {
											sectn_layer = new ol.layer.Image({
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
										else {
											sectn_layer = new ol.layer.Image({
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
										if (sectn_layer != null) {
											//map.addLayer(sectn_layer);
											if ($("#chkSectn").is(":checked")) {
												LayerOrdering();
												//sectn_layer.setVisible(true);
											}
											else {
												sectn_layer.setVisible(false);
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
				});
				//Onclick of Beat CheckBox   
				$("#chkBeat").on("click", function (event) {
					if (!$("#chkBeat").is(":checked")) {
						beat_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							map.removeLayer(beat_layer);
							var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
							var paramdiv = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();
							beatLayernm = "";
							$.ajax({
								url: '/Utility/getDivisionVectorMapTypeLayerList',
								data: { 'distid': paramdist, 'divid': paramdiv, 'type': 1 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									if (obj != null) {
										beatLayernm = obj[0].text;
										var query = "";
										if ($("#drpDivision").val() != "") {
											query = "div_id=" + $("#drpDivision option:selected").val();
										}
										if (query != "") {
											beat_layer = new ol.layer.Image({
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
										else {
											beat_layer = new ol.layer.Image({
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
										if (beat_layer != null) {
											//map.addLayer(beat_layer);
											if ($("#chkBeat").is(":checked")) {
												LayerOrdering();
												//beat_layer.setVisible(true);
											}
											else {
												beat_layer.setVisible(false);
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
				});
				//chkOsm of OSM TOPO CheckBox   
				$("#chkOsm").on("click", function (event) {
					//setTimeout(function () {

					if (!$("#chkOsm").is(":checked")) {
						map.removeLayer(eval(osm_topoLayer));
						if (osm_topoLayer1.length > 0) {
							osm_topoLayer1.forEach(function (item) {
								map.removeLayer(item);
							});
						}
						osm_topoLayer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							var paramdivision = $("#drpDivision").val();
							osmLayernm = "";
							$.ajax({
								url: '/Utility/getDivisionRasterMapTypeLayerList',
								data: { 'distid': 0, 'divid': paramdivision, 'type': 1 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									if (obj != null) {
										var myStringArray = obj;
										var arrayLength = obj.length;
										for (var i = 0; i < arrayLength; i++) {
											var query = "";
											osm_topoLayer = new ol.layer.Image({
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

											/* osm_topoLayer = new ol.layer.Image({
												source: new ol.source.ImageWMS({
													url: obj[i].strValue,
													params: {
														'LAYERS': obj[i].text,
														'VERSION': '1.1.0'
													},
													serverType: 'geoserver'
												})
											}); */

											if (osm_topoLayer != null) {

												if ($("#chkOsm").is(":checked")) {
													osm_topoLayer.setVisible(true);
													osm_topoLayer1.push(osm_topoLayer);
													if (i == arrayLength - 1) {
														if (osm_topoLayer1.length > 0) {
															/* osm_topoLayer1.forEach(function(item){
																map.addLayer(item);		                            		 
																item.setVisible(true);
															}); */
															LayerOrdering();
														}
													}
												}
											}
											else {
												//AlertNotify("OSM of "+$( "#chkOsm option:selected" ).text()+" range is not available.")
											}
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
					//$("#btnShow" ).trigger( "click");
					//}, 500);		
				});
				//chkWp of WP CheckBox   
				$("#chkWp").on("click", function (event) {
					if (!$("#chkWp").is(":checked")) {
						map.removeLayer(eval(wp_layer));
						if (wp_layer1.length > 0) {
							wp_layer1.forEach(function (item) {
								map.removeLayer(item);
							});
						}
						wp_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							var paramdivision = $("#drpDivision").val();
							wpLayernm = "";
							$.ajax({
								url: '/Utility/getDivisionRasterMapTypeLayerList',
								data: { 'distid': 0, 'divid': paramdivision, 'type': 3 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									if (obj != null) {
										var myStringArray = obj;
										var arrayLength = obj.length;
										for (var i = 0; i < arrayLength; i++) {
											var query = "";
											wp_layer = new ol.layer.Image({
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

											/* wp_layer = new ol.layer.Image({
												source: new ol.source.ImageWMS({
													url: obj[0].strValue,
													params: {
														'LAYERS': obj[i].text,
														'VERSION': '1.1.0'
													},
													serverType: 'geoserver'
												})
											}); */

											if (wp_layer != null) {

												if ($("#chkWp").is(":checked")) {
													wp_layer.setVisible(true);
													wp_layer1.push(wp_layer);
													if (i == arrayLength - 1) {
														if (wp_layer1.length > 0) {
															/* wp_layer1.forEach(function(item){
																map.addLayer(item);		                            		 
																item.setVisible(true);
															}); */
															LayerOrdering();
														}
													}
												}
											}
											else {
												//AlertNotify("Village Boundary of "+$( "#chkWp option:selected" ).text()+" range is not available.")
											}
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
				});
				
				//Check HRSI
				
				$("#chkHrsi").on("click", function (event) {
					if (!$("#chkHrsi").is(":checked")) {
						map.removeLayer(eval(hrsi_layer));
						if (hrsi_layer1.length > 0) {
							hrsi_layer1.forEach(function (item) {
								map.removeLayer(item);
							});
						}
						hrsi_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							var paramdivision = $("#drpDivision").val();
							wpLayernm = "";
							$.ajax({
								url: '/Utility/getDivisionRasterMapTypeLayerList',
								data: { 'distid': 0, 'divid': paramdivision, 'type': 2 },
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
											hrsi_layer = new ol.layer.Image({
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

											
											if (hrsi_layer != null) {

												if ($("#chkHrsi").is(":checked")) {
													hrsi_layer.setVisible(true);
													hrsi_layer1.push(hrsi_layer);
													if (i == arrayLength - 1) {
														if (hrsi_layer1.length > 0) {
															
															LayerOrdering();
														}
													}
												}
											}
											else {
												//AlertNotify("HRSI of "+$( "#chkHrsi option:selected" ).text()+"  is not available.")
											}
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
				});
				
				
				//check River Layer 
				$("#checkRiver").on("click", function (event) {
					if (!$("#checkRiver").is(":checked")) {
						river_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
							var paramdivision = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();
							riverLayernm = "";
							$.ajax({
								async: false,
								url: '/Utility/getDivisionVectorMapTypeLayerList',
								data: { 'distid': paramdist, 'divid': paramdivision, 'type': 31 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									if (obj != null) {
										river_layer = new ol.layer.Image({
											source: new ol.source.ImageWMS({
												url: obj[0].strValue,
												params: {
													'LAYERS': obj[0].text,
													'VERSION': '1.1.0'
												},
												serverType: 'geoserver'
											})
										});
										if (river_layer != null) {
											//map.addLayer(river_layer);
											if ($("#checkRiver").is(":checked")) {
												//river_layer.setVisible(true);
												LayerOrdering();
											}
											else {
												river_layer.setVisible(false);
											}

										}
										else {
											//AlertNotify("River Layer of "+$( "#checkRiver option:selected" ).text()+" river is not available.")
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
				});

				//End of River Layer

				//Check Reservoir
				$("#checkReservoir").on("click", function (event) {
					if (!$("#checkReservoir").is(":checked")) {
						reservoir_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
							var paramdivision = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();

							$.ajax({
								async: false,
								url: '/Utility/getDivisionVectorMapTypeLayerList',
								data: { 'distid': paramdist, 'divid': paramdivision, 'type': 32 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									if (obj != null) {
										reservoir_layer = new ol.layer.Image({
											source: new ol.source.ImageWMS({
												url: obj[0].strValue,
												params: {
													'LAYERS': obj[0].text,
													'VERSION': '1.1.0'
												},
												serverType: 'geoserver'
											})
										});
										if (reservoir_layer != null) {
											//map.addLayer(reservoir_layer);
											if ($("#checkReservoir").is(":checked")) {
												LayerOrdering();
												//reservoir_layer.setVisible(true);
											}
											else {
												reservoir_layer.setVisible(false);
											}

										}
										else {
											//AlertNotify("Reservoir Layer of "+$( "#checkReservoir option:selected" ).text()+" reservoir is not available.")
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
				});
				//End of Reservoir

				//Check Rail
				$("#checkRail").on("click", function (event) {
					if (!$("#checkRail").is(":checked")) {
						rail_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
							var paramdivision = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();

							$.ajax({
								async: false,
								url: '/Utility/getDivisionVectorMapTypeLayerList',
								data: { 'distid': paramdist, 'divid': paramdivision, 'type': 33 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									if (obj != null) {
										rail_layer = new ol.layer.Image({
											source: new ol.source.ImageWMS({
												url: obj[0].strValue,
												params: {
													'LAYERS': obj[0].text,
													'VERSION': '1.1.0'
												},
												serverType: 'geoserver'
											})
										});
										if (rail_layer != null) {
											//map.addLayer(rail_layer);
											if ($("#checkRail").is(":checked")) {
												LayerOrdering();
												//rail_layer.setVisible(true);
											}
											else {
												rail_layer.setVisible(false);
											}

										}
										else {
											//AlertNotify("Rail Layer of "+$( "#checkRail option:selected" ).text()+" rail is not available.")
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
				});
				//End of Rail

				//Check Road
				$("#checkRoad").on("click", function (event) {
					if (!$("#checkRoad").is(":checked")) {
						road_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
							var paramdivision = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();

							$.ajax({
								async: false,
								url: '/Utility/getDivisionVectorMapTypeLayerList',
								data: { 'distid': paramdist, 'divid': paramdivision, 'type': 34 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									if (obj != null) {
										road_layer = new ol.layer.Image({
											source: new ol.source.ImageWMS({
												url: obj[0].strValue,
												params: {
													'LAYERS': obj[0].text,
													'VERSION': '1.1.0'
												},
												serverType: 'geoserver'
											})
										});
										if (road_layer != null) {
											//map.addLayer(road_layer);
											if ($("#checkRoad").is(":checked")) {
												LayerOrdering();
												//road_layer.setVisible(true);
											}
											else {
												road_layer.setVisible(false);
											}

										}
										else {
											//AlertNotify("Road Layer of "+$( "#checkRail option:selected" ).text()+" road is not available.")
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
				});
				//End of Road


				//Check Sanctuary
				$("#chkSanc").on("click", function (event) {
					if (!$("#chkSanc").is(":checked")) {
						sanctuary_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
							var paramdivision = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();

							$.ajax({
								async: false,
								url: '/LoadSanctuary',
								data: { 'distid': paramdist, 'divid': paramdivision },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (result) {
									var jsonObj = {};
									var arr = [];
									result.forEach(function (data) {
										var jsonData = {};
										jsonData["geometry"] = JSON.parse(data.geom);
										jsonData["type"] = "Feature";
										let cmvProp = JSON.parse(JSON.stringify(data))
										delete cmvProp['geom'];
										jsonData["properties"] = cmvProp;
										arr.push(jsonData);
									});

									jsonObj["features"] = arr;
									jsonObj["type"] = "FeatureCollection";
									ol.proj.proj4.register(proj4);
									var format = new ol.format.GeoJSON({
										projection: 'EPSG:3857'
									});
									var vectorSource = new ol.source.Vector({
										features: format.readFeatures(jsonObj, {
											dataProjection: new ol.proj.get('EPSG:4326'),
											featureProjection: new ol.proj.get('EPSG:3857')
										}),
										wrapX: false,
										crossOrigin: 'anonymous'
									});

									sanctuary_layer = new ol.layer.Vector({
										source: vectorSource,
										title: 'SanctuaryLayer'
									});
									LayerOrdering();
									// map.addLayer(sanctuary_layer);

									//sanctuary_layer.setVisible(true);
								},
								error: function (errormessage) {
									alert(errormessage.responseText);
								}

							});
						}
						else {
							viewNotification(3);
							return false;
						}
					}
				});
				//End of Sanctuary

				//Onclick of Tehsil CheckBox  
				$("#chkTehsil").on("click", function (event) {
					if (!$("#chkTehsil").is(":checked")) {
						tahasil_layer.setVisible(false);
						map.removeLayer(eval(tahasil_layer));
						if (tahasil_layer1.length > 0) {
							tahasil_layer1.forEach(function (item) {
								map.removeLayer(item);
							});
						}
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
							var paramdiv = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();
							$.ajax({
								async: false,
								url: '/Utility/getDivisionVectorMapTypeLayerList',
								data: { 'distid': paramdist, 'divid': paramdiv, 'type': 19 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									//console.log(obj);
									if (obj != null) {
										var myStringArray = obj;
										var arrayLength = obj.length;
										for (var i = 0; i < arrayLength; i++) {
											tehLayernm = obj[i].text;
											//console.log(obj);


											tahasil_layer = new ol.layer.Image({
												source: new ol.source.ImageWMS({
													url: obj[i].strValue,
													params: {
														'LAYERS': tehLayernm,
														'VERSION': '1.1.0'
													},
													serverType: 'geoserver'
												})
											});
											tahasil_layer.setVisible(true);
											tahasil_layer1.push(tahasil_layer);
											//console.log(i);
											//console.log(arrayLength-1);
											if (i == arrayLength - 1) {
												if (tahasil_layer1.length > 0) {
													/*tahasil_layer1.forEach(function(item) {
														map.addLayer(item);
														item.setVisible(true);
													});*/
													LayerOrdering();
												}
											}

										}
									}
									else {
										AlertNotify("Tahasil Boundary  is not available.")
									}
								},
								error: function (xhr, status) {

								}
							});
						}
						else {
							//alert('Select division or  district.');
							viewNotification(2);
							return false;
						}
					}
				});

				//Onclick of Range CheckBox   
				$("#chkRange").on("click", function (event) {
					if (!$("#chkRange").is(":checked")) {
						rng_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {

							var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
							var paramdivision = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();
							//console.log(paramdivision);
							$.ajax({
								async: false,
								url: '/Utility/getDivisionVectorMapTypeLayerList',
								data: { 'distid': paramdist, 'divid': paramdivision, 'type': 9 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									//console.log(obj);
									if (obj != null) {
										//console.log(obj[0].text);

										rng_layer = new ol.layer.Image({
											source: new ol.source.ImageWMS({
												url: obj[0].strValue,
												params: {
													'LAYERS': obj[0].text,
													'VERSION': '1.1.0'
												},
												serverType: 'geoserver'
											})
										});
										/* }*/
										if (rng_layer != null) {
											//map.addLayer(rng_layer);
											if ($("#chkRange").is(":checked")) {
												//alert("falose66")
												LayerOrdering();
												//rng_layer.setVisible(true);
											}
											else {
												rng_layer.setVisible(false);
											}

										}
										else {
											//AlertNotify("Village Boundary of "+$( "#chkRange option:selected" ).text()+" range is not available.")
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
				});


				//Onclick of Village CheckBox   
				$("#chkVillage").on("click", function (event) {
					if (!$("#chkVillage").is(":checked")) {
						village_layer.setVisible(false);
					}
					else {
						if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
							//map.removeLayer(village_layer);				    		
							var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
							var paramdivision = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();
							//console.log(paramdivision);
							villLayernm = "";
							$.ajax({
								async: false,
								url: '/Utility/getDivisionVectorMapTypeLayerList',
								data: { 'distid': paramdist, 'divid': paramdivision, 'type': 14 },
								type: "GET",
								contentType: "application/json;charset=utf-8",
								dataType: "json",
								success: function (obj) {
									//console.log(obj);
									if (obj != null) {
										//console.log(obj[0].text);
										//villLayernm=obj[0].text;

										//var query="";
										/* if($("#chkRange").val()!="")
										 {				                                
											 query="range_id="+"'"+$( "#chkRange option:selected" ).val()+"'";				                                 
										 }
											 if(query!="")
											 {					                            						                            	 
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
										 else{*/
										village_layer = new ol.layer.Image({
											source: new ol.source.ImageWMS({
												url: obj[0].strValue,
												params: {
													'LAYERS': obj[0].text,
													'VERSION': '1.1.0'
												},
												serverType: 'geoserver'
											})
										});
										/* }*/
										if (village_layer != null) {
											//map.addLayer(village_layer);
											if ($("#chkVillage").is(":checked")) {
												LayerOrdering();
												village_layer.setVisible(true);
											}
											else {
												village_layer.setVisible(false);
											}

										}
										else {
											//AlertNotify("Village Boundary of "+$( "#chkRange option:selected" ).text()+" range is not available.")
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
				});


				//DGPS check box start
				//  $("#btnDgpsSubmit").click(function (event) {
				// 	 var points=[];
				// 	 var data;
				// 	 //var zoom = 10;
				// 	    //var data; //${dgpsPillarListJson};
				// 	    $.ajax({
				// 	        url: 'http://14.98.253.212:8081/progressmonitoring/api/DGPSSurvey/_PartialDGPSMapView',
				// 	        data: {'fbid':$('#drpfblist').val()},
				// 	        contentType: "application/json;charset=utf-8",
				// 	        type: 'GET',
				// 	        dataType: "json",
				// 	    	success:function (result) {

				// 	 		 data=result.dgpsPillarList;
				// 	 		   $.each(data, function (a, b) {
				// 	 		       var feature=  new ol.Feature({
				// 	 		           geometry: new ol.geom.Point(ol.proj.transform([b.decLongitude,b.decLatitude], 'EPSG:4326', 'EPSG:3857')),
				// 	 		           fbid :b.mforestBlkSurveyDetail!=null ? b.mforestBlkSurveyDetail.intId:0,
				// 	 		           //plr_cd:  b.tpillarDetail!=null? b.tpillarDetail.intPkSlno:0,
				// 	 		           plr_no:((b.intSubPlrNo==0 || b.intSubPlrNo==null )?  b.intPlrNo : b.intPlrNo+"_"+b.intSubPlrNo),
				// 	 		           latitude: b.decLatitude,
				// 	 		           longitude: b.decLongitude,
				// 	 		           rtxAccuracy: b.decRtxAccuracy,
				// 	 		           /* fpic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_f_pic_name),
				// 	 		           bpic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_b_pic_name),
				// 	 		           ipic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_i_pic_name),
				// 	 		           opic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_o_pic_name), */
				// 	 		           //wpic:'${pillarPath}'+getFileNameFromURL(b.chrvDivPicName),
				// 	 		           point_type:"DGPS"
				// 	 		       }); 
				// 	 		       points.push(feature);  

				// 	 		   });



				// 	 		    dgpspillarLayer = new ol.layer.Vector({
				// 	 		        source: new ol.source.Vector({
				// 	 		            features: points 
				// 	 		        }),
				// 	 		        title: 'dgpsLayer',
				// 	 		        style:function(feature, resolution){
				// 	 		                var acceptedStyle=new ol.style.Style({
				// 	 		                            image: new ol.style.Circle({
				// 	 		                            radius: 6,
				// 	 		                            stroke: new ol.style.Stroke({
				// 	 		                                color: 'white',
				// 	 		                                width: 2
				// 	 		                            }),
				// 	 		                            fill: new ol.style.Fill({
				// 	 		                                    color: 'orange'
				// 	 		                            })
				// 	 		                            }),
				// 	 		                            text: new ol.style.Text({
				// 	 		                            font: 'bold 12px Calibri,sans-serif',
				// 	 		                            fill: new ol.style.Fill({ color: '#000' }),
				// 	 		                            stroke: new ol.style.Stroke({
				// 	 		                                color: '#fff', width: 2
				// 	 		                            }),
				// 	 		                            textAlign: 'top',
				// 	 		                            textBaseline: 'bottom',
				// 	 		                            text:feature.get('plr_no').toString()
				// 	 		                            })
				// 	 		                        });
				// 	 		            var verifyStyle=new ol.style.Style({
				// 	 		                    image: new ol.style.Circle({
				// 	 		                    radius: 5,
				// 	 		                    fillOpacity: 0.4,
				// 	 		                    fill: new ol.style.Fill({color: '#14abef'}),
				// 	 		                    stroke: new ol.style.Stroke({
				// 	 		                    color: '#14abef', width: 1
				// 	 		                    })
				// 	 		                    }),
				// 	 		                    text: new ol.style.Text({
				// 	 		                    font: 'bold 12px Calibri,sans-serif',
				// 	 		                    fill: new ol.style.Fill({ color: '#000' }),
				// 	 		                    stroke: new ol.style.Stroke({
				// 	 		                        color: '#fff', width: 2
				// 	 		                    }),
				// 	 		                    textAlign: 'top',
				// 	 		                    textBaseline: 'bottom',
				// 	 		                    text:feature.get('plr_no').toString()
				// 	 		                    })
				// 	 		                });
				// 	 		            var defaultStyle=new ol.style.Style({
				// 	 		                    image: new ol.style.Circle({
				// 	 		                    radius: 5,
				// 	 		                    fillOpacity: 0.4,
				// 	 		                    fill: new ol.style.Fill({color: '#1f7a1f'}),
				// 	 		                    stroke: new ol.style.Stroke({
				// 	 		                    color: '#1f7a1f', width: 1
				// 	 		                    })
				// 	 		                    }),
				// 	 		                    text: new ol.style.Text({
				// 	 		                    font: 'bold 12px Calibri,sans-serif',
				// 	 		                    fill: new ol.style.Fill({ color: '#000' }),
				// 	 		                    stroke: new ol.style.Stroke({
				// 	 		                        color: '#fff', width: 2
				// 	 		                    }),
				// 	 		                    textAlign: 'top',
				// 	 		                    textBaseline: 'bottom',
				// 	 		                    text:feature.get('plr_no').toString()
				// 	 		                    })
				// 	 		                });
				// 	 		            if(true)
				// 	 		            {
				// 	 		                return [acceptedStyle];
				// 	 		            } 
				// 	 		            else
				// 	 		            {
				// 	 		                return [acceptedStyle];
				// 	 		            }
				// 	 		        }
				// 	 		    });

				// 	 		   if(dgpspillarLayer!=null)
				// 	 		  	{   
				// 	 		    	try{
				// 	 		    		map.addLayer(dgpspillarLayer);
				// 	 		    	      dgpspillarLayer.setVisible(true);
				// 	 		    	      //zoomLayer(url, zoom);
				// 	 		    	}catch(error){
				// 	 		    		alert(error);
				// 	 		    	}	

				// 	 		  	} 
				// 	 		    else{
				// 	 		    	alert('dgpspillarLayer is null');
				// 	 		    }

				// 	    }
				// 	    ,error:function (xhr, status) {
				// 	        alert(status);
				// 	    }

				// 	    });   
				//  });
				//DGPS check box end

				//Remove dgps layer and uncheck on button clear
				/* $("#btnClear").click(function (event) {
					map.getLayers().forEach(function(element, index, array) {
						if (element.get('title') === 'dgpsLayer') {
							if (element != null) {
								element.setVisible(false);
							}
						}
					});
					map.removeLayer(dgpspillarLayer);
					$("#chkDGPS").prop("checked", false);
					$('#drpRng').prop('selectedIndex',0);
					$('#drpfblist').prop('selectedIndex',0); 
				}); */
				//End

				//FSCP Onclick Event
				//   $("#chkFSCP").on("click", function(event) {
				// 	     var paramdivision = ($("#drpDivision").val() == 0 ?  0 :$("#drpDivision").val());
				// 		 var range_code = ($("#drpRngList").val() == null || $("#drpRngList").val() == "") ?"All" : $("#drpRngList").val();
				// 		 var fb_id=($("#drpfblist").val() == 0 || $("#drpfblist").val() == null ?  0 :$("#drpfblist").val());
				// 		 var points=[];
				// 		 var data;
				// 		 if(!$("#chkFSCP").is(":checked"))
				//          {					   
				// 			fscpLayer.setVisible(false);
				//          }
				// 		 else
				// 		{
				// 		 $.ajax({
				// 		        url: 'http://14.98.253.212:8081/progressmonitoring/api/DGPSSurvey/fscp',
				// 		        data: {'divid':paramdivision,'rancode':range_code,'fbid':fb_id},
				// 		        contentType: "application/json;charset=utf-8",
				// 		        type: 'GET',
				// 		        dataType: "json",
				// 		    	success:function (result) {
				// 		 		   $.each(result, function (a, b) {
				// 		 		       var feature=  new ol.Feature({
				// 		 		           geometry: new ol.geom.Point(ol.proj.transform([b.dec_longitude,b.dec_latitude], 'EPSG:4326', 'EPSG:3857')),
				// 		 		           fbid :b.int_fk_fb_id,
				// 		 		           //plr_no:b.int_id,	   
				// 		 		           latitude: b.dec_latitude,
				// 		 		           longitude: b.dec_longitude,
				// 		 		           point_type:"FSCP"
				// 		 		       }); 
				// 		 		       points.push(feature);  

				// 		 		   });

				// 		 		  console.log('after success Points data are: '+JSON.stringify(points));


				// 		 		    fscpLayer = new ol.layer.Vector({
				// 		 		        source: new ol.source.Vector({
				// 		 		            features: points 
				//	 	 		        }),
				// 		 		        style:function(feature, resolution){
				// 		 		                var acceptedStyle=new ol.style.Style({
				// 		 		                            image: new ol.style.Circle({
				// 		 		                            radius: 6,
				// 		 		                            stroke: new ol.style.Stroke({
				// 		 		                                color: 'white',
				// 		 		                                width: 2
				// 		 		                            }),
				// 		 		                            fill: new ol.style.Fill({
				// 		 		                                    color: 'blue'
				// 		 		                            })
				// 		 		                            }),
				// 		 		                            text: new ol.style.Text({
				// 		 		                            font: 'bold 12px Calibri,sans-serif',
				// 		 		                            fill: new ol.style.Fill({ color: '#000' }),
				// 		 		                            stroke: new ol.style.Stroke({
				// 		 		                                color: '#fff', width: 2
				// 		 		                            }),
				// 		 		                            textAlign: 'top',
				// 		 		                            textBaseline: 'bottom',
				// 		 		                            text:feature.get('fbid').toString()
				// 		 		                            })
				// 		 		                        });
				// 		 		            var verifyStyle=new ol.style.Style({
				// 		 		                    image: new ol.style.Circle({
				// 		 		                    radius: 5,
				// 		 		                    fillOpacity: 0.4,
				// 		 		                    fill: new ol.style.Fill({color: '#14abef'}),
				// 		 		                    stroke: new ol.style.Stroke({
				// 		 		                    color: '#14abef', width: 1
				// 		 		                    })
				// 		 		                    }),
				// 		 		                    text: new ol.style.Text({
				// 		 		                    font: 'bold 12px Calibri,sans-serif',
				// 		 		                    fill: new ol.style.Fill({ color: '#000' }),
				// 		 		                    stroke: new ol.style.Stroke({
				// 		 		                        color: '#fff', width: 2
				// 		 		                    }),
				// 		 		                    textAlign: 'top',
				// 		 		                    textBaseline: 'bottom',
				// 		 		                    text:feature.get('fbid').toString()
				// 		 		                    })
				// 		 		                });
				// 		 		            var defaultStyle=new ol.style.Style({
				// 		 		                    image: new ol.style.Circle({
				// 		 		                    radius: 5,
				// 		 		                    fillOpacity: 0.4,
				// 		 		                    fill: new ol.style.Fill({color: '#1f7a1f'}),
				// 		 		                    stroke: new ol.style.Stroke({
				// 		 		                    color: '#1f7a1f', width: 1
				// 		 		                    })
				// 		 		                    }),
				// 		 		                    text: new ol.style.Text({
				// 		 		                    font: 'bold 12px Calibri,sans-serif',
				// 		 		                    fill: new ol.style.Fill({ color: '#000' }),
				// 		 		                    stroke: new ol.style.Stroke({
				// 		 		                        color: '#fff', width: 2
				// 		 		                    }),
				// 		 		                    textAlign: 'top',
				// 		 		                    textBaseline: 'bottom',
				// 		 		                    text:feature.get('fbid').toString()
				// 		 		                    })
				// 		 		                });
				// 		 		            if(true)
				// 		 		            {
				// 		 		                return [acceptedStyle];
				// 		 		            } 
				// 		 		            else
				// 		 		            {
				// 		 		                return [acceptedStyle];
				// 		 		            }
				// 		 		        }
				// 		 		    });

				// 		 		   if(fscpLayer!=null)
				// 		 		  	{   
				// 		 		    	try{
				// 		 		    		map.addLayer(fscpLayer);
				// 		 		    		fscpLayer.setVisible(true);
				// 		 		    	}catch(error){
				// 		 		    		alert(error);
				// 		 		    	}	

				// 		 		  	} 
				// 		 		    else{
				// 		 		    	alert('fscpLayer is null');
				// 		 		    }

				// 		    }
				// 		    ,error:function (xhr, status) {
				// 		        alert(status);
				// 		    }

				// 		    });
				// 		 }
				//   	});
				//End of FSCP


				//FPCP Onclick event
				//  $("#chkFPCP").on("click", function(event) {
				// 	 var rng_code = ($("#drpRngList").val() == null || $("#drpRngList").val() == "") ? "" : $("#drpRngList").val();
				// 	 var paramdivision = ($("#drpDivision").val() == 0 ?  0 :$("#drpDivision").val());
				// 	 var points=[];
				// 	 var data;
				// 	 if(!$("#chkFPCP").is(":checked"))
				//      {					   
				// 		 fpcpLayer.setVisible(false);
				//      }
				// 	 else
				// 	 {
				// 		 $.ajax({
				// 		     url: 'http://14.98.253.212:8081/progressmonitoring/api/DGPSSurvey/fpcp',
				// 		     data: {'divid':paramdivision,'rancode':rng_code},
				// 		     contentType: "application/json;charset=utf-8",
				// 		     type: 'GET',
				// 		     dataType: "json",
				// 		 	success:function (result) {

				// 				   $.each(result, function (a, b) {
				// 				       var feature=  new ol.Feature({
				// 				           geometry: new ol.geom.Point(ol.proj.transform([b.decLongitude,b.decLatitude], 'EPSG:4326', 'EPSG:3857')),
				// 				           plr_no:b.intId,
				// 				           Location:b.chrvLocation,
				// 				           latitude: b.decLatitude,
				// 				           longitude: b.decLongitude,
				// 				           point_type:"FPCP"
				// 				       }); 
				// 				       points.push(feature);  

				// 				   });
				// 				    fpcpLayer = new ol.layer.Vector({
				// 				        source: new ol.source.Vector({
				// 				            features: points 
				// 				        }),
				// 				        style:function(feature, resolution){
				// 				                var acceptedStyle=new ol.style.Style({
				// 				                            image: new ol.style.Circle({
				// 				                            radius: 6,
				// 				                            stroke: new ol.style.Stroke({
				// 				                                color: 'white',
				// 				                                width: 2.5
				// 				                            }),
				// 				                            fill: new ol.style.Fill({
				// 				                                    color: 'brown'
				// 				                            })
				// 				                            }),
				// 				                            text: new ol.style.Text({
				// 				                            font: 'bold 12px Calibri,sans-serif',
				// 				                            fill: new ol.style.Fill({ color: '#000' }),
				// 				                            stroke: new ol.style.Stroke({
				// 				                                color: '#fff', width: 2
				// 				                            }),
				// 				                            textAlign: 'top',
				// 				                            textBaseline: 'bottom',
				// 				                            text:feature.get('plr_no').toString()
				// 				                            })
				// 				                        });
				// 				            var verifyStyle=new ol.style.Style({
				// 				                    image: new ol.style.Circle({
				// 				                    radius: 5,
				// 				                    fillOpacity: 0.4,
				// 				                    fill: new ol.style.Fill({color: '#14abef'}),
				// 				                    stroke: new ol.style.Stroke({
				// 				                    color: '#14abef', width: 1
				// 				                    })
				// 				                    }),
				// 				                    text: new ol.style.Text({
				// 				                    font: 'bold 12px Calibri,sans-serif',
				// 				                    fill: new ol.style.Fill({ color: '#000' }),
				// 				                    stroke: new ol.style.Stroke({
				// 				                        color: '#fff', width: 2
				// 				                    }),
				// 				                    textAlign: 'top',
				// 				                    textBaseline: 'bottom',
				// 				                    text:feature.get('plr_no').toString()
				// 				                    })
				// 				                });
				// 				            var defaultStyle=new ol.style.Style({
				// 				                    image: new ol.style.Circle({
				// 				                    radius: 5,
				// 				                    fillOpacity: 0.4,
				// 				                    fill: new ol.style.Fill({color: '#1f7a1f'}),
				// 				                    stroke: new ol.style.Stroke({
				// 				                    color: '#1f7a1f', width: 1
				// 				                    })
				// 				                    }),
				// 				                    text: new ol.style.Text({
				// 				                    font: 'bold 12px Calibri,sans-serif',
				// 				                    fill: new ol.style.Fill({ color: '#000' }),
				// 				                    stroke: new ol.style.Stroke({
				// 				                        color: '#fff', width: 2
				// 				                    }),
				// 				                    textAlign: 'top',
				// 				                    textBaseline: 'bottom',
				// 				                    text:feature.get('plr_no').toString()
				// 				                    })
				// 				                });
				// 				            if(true)
				// 				            {
				// 				                return [acceptedStyle];
				// 				            } 
				// 				            else
				// 				            {
				// 				                return [acceptedStyle];
				// 				            }
				// 				        }
				// 				    });

				// 				   if(fpcpLayer!=null)
				// 				  	{   
				// 				    	try{
				// 				    		map.addLayer(fpcpLayer);
				// 				    		fpcpLayer.setVisible(true);
				// 				    	}catch(error){
				// 				    		alert(error);
				// 				    	}	

				// 				  	} 
				// 				    else{
				// 				    	alert('fpcpLayer is null');
				// 				    }

				// 		 }
				// 		 ,error:function (xhr, status) {
				// 		     alert(status);
				// 		 }

				// 		 });
				// 	 }
				//  });

				//End Of FPCP   


				//Showing dropdown on dgps box checked
				/* if(document.getElementById('chkDGPS').checked) 
				{
					 $("#drpFB").show();
				} 
					   else 
				 {
					 $("#drpFB").hide();
				 } */
				$('#chkDGPS').click(function () {
					$("#drpFB").toggle(this.checked);
				});
				//end

				//Showing Label on nfb  checked
				if (document.getElementById('chkNFB').checked) {
					$("#NfbLabel").show();
				}
				else {
					$("#NfbLabel").hide();
				}
				$('#chkNFB').click(function () {
					$("#NfbLabel").toggle(this.checked);
				});
				//end

				//Showing Label on dlc  checked
				if (document.getElementById('chkRFFinal').checked) {
					$("#dlcLabel").show();
				}
				else {
					$("#dlcLabel").hide();
				}
				$('#chkRFFinal').click(function () {
					$("#dlcLabel").toggle(this.checked);
					try {
						if ($(this).prop("checked")) {
							//$("#btnShow" ).trigger( "click");
							map.getLayers().forEach(function (element, index, array) {
								if (element.get('title') === 'rfLayer') {
									if (element != null) {
										element.setVisible(true);
									}
								}
							});
							//rf_layer.setVisible(true);
						}
						else {
							map.getLayers().forEach(function (element, index, array) {
								if (element.get('title') === 'rfLayer') {
									if (element != null) {
										element.setVisible(false);
									}
								}
							});
							//rf_layer.setVisible(false);
						}

					} catch (e) {

					}

				});
				//end

				//Showing Label on CA Land  checked
				if (document.getElementById('chkCmpnstryAL').checked) {
					$("#caLabel").show();
				}
				else {
					$("#caLabel").hide();
				}
				$('#chkCmpnstryAL').click(function () {
					$("#caLabel").toggle(this.checked);
				});
				//end

				//Bind Forest block dropdownlist
				$("#drpRng").change(function () {
					$.ajax({
						url: '/Utility/getRangeWiseFB',
						data: { 'divid': $('#drpDivision').val(), 'rid': $('#drpRng').val() },
						type: "GET",
						contentType: "application/json;charset=utf-8",
						dataType: "json",
						success: function (data) {
							$('#drpfblist').html('');
							var options = '';
							$('#drpfblist')
								.append($("<option></option>")
									.attr("value", "")
									.text("--Select--"));
							$.each(data, function (a, b) {
								options += '<option value="' + b.value + '">' + b.strValue + ' ' + b.text + '</option>';

							});
							$('#drpfblist').append(options);
						},
						error: function (errormessage) {
							alert(errormessage.responseText);
						}
					});
				});

				//NFB Level button click
				$("#btnnotation").click(function () {
					$(this).data('clicked', true);
				});


				$("#a_reset").click(function () {
					location.reload(true);
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

				//Method for Layer order
				function LayerOrdering() {
					if ($('#drpDistrict').val() != 0 || $('#drpDistrict').val() != "" || $('#drpDivision').val() != 0 || $('#drpDivision').val() != "") {
						for (var i = 0; i < layerOrder.length; i++) {

							//console.log(window[layerOrder[i]]);
							var tempLayers = window[layerOrder[i]];
							//alert(window[layerOrder[i]]);
							if (checkboxOrder[i] == "chkOsm" || checkboxOrder[i] == "chkWp" || checkboxOrder[i] == "chkTehsil" || checkboxOrder[i] == "chkHrsi") {
								//console.log(layerOrder[i]);
								//alert("osm");
								window[layerOrder[i] + "1"].forEach(function (item) {
									map.removeLayer(item);
								});
							}
							else {
								//console.log(layerOrder[i]);
								map.removeLayer(window[layerOrder[i]]);
							}
							window[layerOrder[i]] = tempLayers;
							if ($("#" + checkboxOrder[i]).is(":checked")) {
								//console.log(layerOrder[i]);
								if (checkboxOrder[i] == "chkOsm" || checkboxOrder[i] == "chkWp" || checkboxOrder[i] == "chkTehsil"  || checkboxOrder[i] == "chkHrsi") {
									//console.log(layerOrder[i]);
									window[layerOrder[i] + "1"].forEach(function (item) {
										//console.log("hi");
										map.addLayer(item);
										item.setVisible(true);
									});
								}
								else {
									map.addLayer(window[layerOrder[i]]);
									window[layerOrder[i]].setVisible(true);
								}
							}
						}
					}
					else {
						viewNotification(11);
						//event.preventDefault();
					}
				}

			</script>