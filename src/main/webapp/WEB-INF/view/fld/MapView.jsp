<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <%@ include file="../shared/header.jsp"
<%@ include file="../shared/sidebar.jsp"%> --%>
<tl:eval expression="@environment.getProperty('api.geoserverurl')" var="geoserverUrl"></tl:eval> 
<style>
.ol-rotate-reset {
           display:none;
        }
 .ol-zoom
 {
 	display:none;
 }
 .ol-attribution 
 {
   display:none;
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
									data-toggle="collapse" aria-expanded="true"
									aria-controls="collapseTwo" title="Layers"> <span
									class="d-block"><img src="/assets/img/icon-layers.png"></span>
								</a> <a id="" href="#collapseThree"
									class="text-dark col collapsed bs-tooltip feature"
									data-toggle="collapse" aria-expanded="false"
									aria-controls="collapseThree" title="Legends"> <span
									class="d-block"><img src="/assets/img/icon-legends.png"></span>
								</a> <a id="" href="#collapseFour"
									class="text-dark col collapsed bs-tooltip feature"
									data-toggle="collapse" aria-expanded="false"
									aria-controls="collapseFour" title="Basemap"> <span
									class="d-block"><img src="/assets/img/icon-basemap.png"></span>
								</a> <a id="a_measure" href="#collapseFive"
									class="text-dark col collapsed bs-tooltip feature"
									data-toggle="collapse" aria-expanded="false"
									aria-controls="collapseFive" title="Measurement"> <span
									class="d-block"><img
										src="/assets/img/icon-measurement.png"></span>
								</a> <a id="a_reset" href="#collapseSeven"
									class="text-dark col collapsed bs-tooltip feature"
									data-toggle="collapse" aria-expanded="false"
									aria-controls="collapseSeven" title="Reset"> <span
									class="d-block"><img src="/assets/img/icon-reset.png"></span>
								</a>
							</div>

							<div class="clearfix"></div>

							<div class="mb-0">
	                                
	                                    <div id="collapseTwo" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
	                                        <div class="card">
	                                            <div class="card-body">
	                                                <div class="fixHeightRight">
	                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne"><span aria-hidden="true">×</span></button> -->
	                                                    <div class="card-body custom-card-body">
	                                                        <!-- <h6 class="mt-0 page-title mb-2">Area of Interest</h6>
	                                                        <div class="mb-2">
	                                                        	<strong>Division : </strong><span>Angul</span>
	                                                        </div>
	                                                        <h6 class="mt-0 page-title mb-2">Selected Layers</h6> -->
	                                                        <div id="accordion3">
	                                                            <a id="" href="#collapse11" class="collapsed icon-header" data-toggle="collapse" aria-expanded="true" aria-controls="collapse11">
	                                                                <h6 class="mt-0 header-title map-title-secondary mb-3">Forest Land Type<i class="fa fa-angle-down pull-right"></i></h6>
	                                                            </a>
	                                                            <div id="collapse11" class="collapse show" aria-labelledby="heading11" data-parent="#accordion3">
	                                                                <form>
	                                                                    <div class="row form-group">
	                                                                        <div class="col-md-12">
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="chkCmv" onclick="viewLayer(this,'cmv_layer')">
	                                                                                <label class="custom-control-label" for="chkCmv">Notified Forest</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="chkRFFinal" onclick="viewLayer(this,'rf_layer')">
	                                                                                <label class="custom-control-label" for="chkRFFinal">DLC & Other Revenue Forest</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="checkbox103" disabled>
	                                                                                <label class="custom-control-label" for="checkbox103">Deemed Forest</label>
	                                                                            </div>                                                                            
	                                                                        </div>
	                                                                    </div>                                                                         
	                                                                </form>
	                                                            </div>
	                                                            <a id="" href="#collapse12" class="collapsed icon-header" data-toggle="collapse" aria-expanded="false" aria-controls="collapse12">
	                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Administrative Boundary<i class="fa fa-angle-right pull-right"></i></h6>
	                                                            </a>
	                                                            <div id="collapse12" class="collapse" aria-labelledby="heading12" data-parent="#accordion3">
	                                                                <form>
	                                                                    <div class="row form-group">
	                                                                        <div class="col-md-12">
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="chkDist" onclick="viewLayer(this,'districtboundarylayer')">
	                                                                                <label class="custom-control-label" for="chkDist">District</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" value="TahasilBoundary" id="chkTehsil">
	                                                                                <label class="custom-control-label" for="chkTehsil">Tehsil</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="checkbox63" disabled>
	                                                                                <label class="custom-control-label" for="checkbox63">Block</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" value="VillageBoundary" id="chkVillage">
	                                                                                <label class="custom-control-label" for="chkVillage">Village</label>
	                                                                            </div>
	                                                                        </div>
	                                                                    </div>
	                                                                </form>
	                                                            </div>
	                                                            <a id="" href="#collapse13" class="collapsed icon-header" data-toggle="collapse" aria-expanded="false" aria-controls="collapse13">
	                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Forest Administrative Boundary<i class="fa fa-angle-right pull-right"></i></h6>
	                                                            </a>
	                                                            <div id="collapse13" class="collapse" aria-labelledby="heading13" data-parent="#accordion3">
	                                                                <form>
	                                                                    <div class="row form-group">
	                                                                        <div class="col-md-12">
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" value="DivisionBoundary" id="chkDivision" onclick="viewLayer(this,'alldivboundarylayer')">
	                                                                                <label class="custom-control-label" for="chkDivision">Division</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" value="RangeBoundary" id="chkRange">
	                                                                                <label class="custom-control-label" for="chkRange">Range</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="checkbox113" disabled>
	                                                                                <label class="custom-control-label" for="checkbox113">Section</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="checkbox114" disabled>
	                                                                                <label class="custom-control-label" for="checkbox114">Beat</label>
	                                                                            </div>
	                                                                        </div>
	                                                                    </div>
	                                                                </form>
	                                                            </div>
	                                                            <a id="" href="#collapse14" class="collapsed icon-header" data-toggle="collapse" aria-expanded="false" aria-controls="collapse14">
	                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Reference Data Overlay<i class="fa fa-angle-right pull-right"></i></h6>
	                                                            </a>
	                                                            <div id="collapse14" class="collapse" aria-labelledby="heading14" data-parent="#accordion3">
	                                                                <form>
	                                                                    <div class="row form-group">
	                                                                        <div class="col-md-12">
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="chkState121">
	                                                                                <label class="custom-control-label" for="chkState121">HRSI</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="checkbox122" disabled>
	                                                                                <label class="custom-control-label" for="checkbox122">FSI</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="checkbox123">
	                                                                                <label class="custom-control-label" for="checkbox123">SOI OSM TOPO</label>
	                                                                            </div>
	                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
	                                                                                <input type="checkbox" class="custom-control-input" id="checkbox124" disabled>
	                                                                                <label class="custom-control-label" for="checkbox124">Village Cadastral</label>
	                                                                            </div>
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
												<button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><span aria-hidden="true">×</span></button>
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
																				id="chkDraftDGPS"> <label
																				class="custom-control-label" for="chkDraftDGPS">Draft
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
								<div id="collapseThree" class="collapse"
									aria-labelledby="headingThree" data-parent="#accordion">
									<div class="card">
										<div class="card-body">
											<div class="fixHeightRight">
												<!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree"><span aria-hidden="true">×</span></button> -->
												<div class="card-body custom-card-body">
													<h6 class="mt-0 page-title mb-3">Legends</h6>
													<div class="row">
														<div class="col-md-12 ml-1">
															<div class="legendbox">
																<img src="/assets/img/state_boundary.png"> <span>State
																	Boundary</span>
															</div>
															<div class="legendbox">
																<img src="/assets/img/district_boundary.png" id="districtboundarylayer_legend"> <span>District
																	Boundary</span>
															</div>
															<div class="legendbox">
																<img src="/assets/img/division_boundary.png" id="alldivboundarylayer_legend"> <span>Division
																	Boundary</span>
															</div>
															<div class="legendbox">
																<img src="/assets/img/legend-04.png"> <span>Tehsil
																	Boundary</span>
															</div>
															<div class="legendbox">
																<img src="/assets/img/range_boundary.png"> <span>Range
																	Boundary</span>
															</div>
															<div class="legendbox" id="nfb_layer_legend">
                                                                  <img src="/assets/img/selected_FB.png">
                                                                  <span>Notified Forest Block</span>
                                                            </div>
                                                            <div class="legendbox" id="nfb_layer_adj_legend">
                                                                <img src="/assets/img/notified_forest_FB_layer.png">
                                                                <span>Adjacent Forest Block</span>
                                                            </div>
                                                           <!--  <div class="legendbox" id="rf_layer_legend">
                                                                 <img src="/assets/img/selected_FB.png">
                                                                 <span>Revenue Forest</span>
                                                             </div>
                                                             <div class="legendbox" id="rf_layer_adj_legend">
                                                                <img src="/assets/img/legend-03.png">
                                                                <span>Adjacent Forest Plot</span>
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
												<!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour"><span aria-hidden="true">×</span></button> -->
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
	
	                                <!-- <div class="mb-0">
	                                                                       <div class="tab-box">
																	    	<ul class="basesection">
																	    		<li>
																	    			<a id="blank_basemap" class="basebox"><img src="/assets/img/icon-blank.png"><h6>Blank</h6></a>
																	    		</li>
																	    		<li>
																				<a id="imagery_basemap"  class="basebox" value="Imagery"><img src="/assets/img/icon-imagery.png"><h6>Imagery</h6></a>
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
	
	                                <!-- <div class="mb-0">

																<div class="tab-box">
																	<ul class="basesection">
																		<li><a id="blank_basemap" class="basebox"><img
																				src="/assets/img/icon-blank.png">
																			<h6>Blank</h6></a></li>
																		<li><a id="imagery_basemap" class="basebox"
																			value="Imagery"><img
																				src="/assets/img/icon-imagery.png">
																			<h6>Imagery</h6></a></li>
																		<li><a id="street_basemap" class="basebox"><img
																				src="/assets/img/icon-street.png">
																			<h6>Street</h6></a></li>
																		<li><a id="osm_basemap" class="basebox"><img
																				src="/assets/img/icon-osm.png">
																			<h6>OSM</h6></a></li>
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

							<!-- <div class="mb-0">

	                                    <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordion">
	                                        <div class="card">
	                                            <div class="card-body">
	                                                <div class="fixHeightRight">
	                                                    <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">×</span></button>
	                                                    <div class="card-body custom-card-body">
	                                                        <h6 class="mt-0 page-title mb-3">Measurement</h6>
	                                                        <form>
	                                                            <div class="row form-group">
	                                                                <div class="col-md-12">
	                                                                    <div class="form-check">
	                                                                        <div class="custom-control custom-radio classic-radio-info">
	                                                                            <input type="radio" id="hRadio1" name="classicRadio" class="custom-control-input">
	                                                                            <label class="custom-control-label" for="hRadio1">Area</label>
	                                                                        </div>
	                                                                    </div>
	                                                                    <div class="form-check">
	                                                                        <div class="custom-control custom-radio classic-radio-info">
	                                                                            <input type="radio" id="hRadio2" name="classicRadio" class="custom-control-input">
	                                                                            <label class="custom-control-label" for="hRadio2">Distance</label>
	                                                                        </div>
	                                                                    </div>
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
	                                </div> -->
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
							<!-- <div class="mb-0">
	                                    <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordion">
	                                        <div class="card">
	                                            <div class="card-body">
	                                                <div class="fixHeightRight">
	                                                    <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">×</span></button>
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
	                                </div> -->
							<!-- <div class="mb-0">
	                                    <div id="collapseEight" class="collapse" aria-labelledby="headingEight" data-parent="#accordion">
	                                        <div class="card">
	                                            <div class="card-body">
	                                                <div class="fixHeightRight">
	                                                    <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseEight" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">×</span></button>
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
	                                </div> -->
						</div>
						<!--/accordion-->

					</div>

					<div class="col-md-9">
						<div id="map" class="fixHeightLeft panel">
							<div class="map-tool-icon">
								    <a href="javascript:void(0)" data-toggle="collapse" title="Toggle fullscreen" class="bs-tooltip" id="mapFullscreen" onclick="openFullscreen();" title="Zoom to extent"><img src="/assets/img/icon-zoom-to-extent.png"></span></a> 
									<a href="#" class="bs-tooltip" title="Zoom in" id="ZoomIN"><img src="/assets/img/icon-zoom-in.png"></span></a> 
									<a href="#" class="bs-tooltip" title="Zoom out" id="ZoomOut"><img src="/assets/img/icon-zoom-out.png"></span></a>
									<a href="#" class="bs-tooltip" title="Back" onclick="back();"><img src="/assets/img/icon-back.png"></span></a>
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

<%-- <%@ include file="../shared/footer.jsp"%>
 <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
<script src="https://epsg.io/32645.js"></script>
<script src="/v5.3.0-dist/32644.js"></script> --%>
<script>
var status = 0;
var geoserverUrl = '${geoserverUrl}';


//var village_layer,cmv_layer,mmv_layer,jvFnl_layer,dgpsdrft_layer,dgpsfnl_layer,revFrst_layer,dlcFnl_layer;
var stateboundarylayer,districtboundarylayer,alldivboundarylayer,allrnglayer,cmv_layer,cql_query,
plot_layer,rf_layer,village_layer,tahasil_layer,tahasil_layer1,highlightOverlay;
var  layerOrderList=[
	{"layer":"plot_layer", "visibility":0,"minz":12,"maxz":18},
	{"layer":"rf_layer", "visibility":0,"minz":10.17,"maxz":15.27},
	{"layer":"cmv_layer", "visibility":0,"minz":10.17,"maxz":14.27},
	{"layer":"village_layer", "visibility":0,"minz":9,"maxz":14},
	{"layer":"allrnglayer", "visibility":0,"minz":9.34,"maxz":11.01},
	{"layer":"tahasil_layer", "visibility":0,"minz":9,"maxz":13},
	{"layer":"alldivboundarylayer", "visibility":0,"minz":6.5,"maxz":11.68},
	{"layer":"districtboundarylayer", "visibility":0,"minz":6.4,"maxz":11.4},
	{"layer":"stateboundarylayer", "visibility":1,"minz":5.90,"maxz":8.18},
	{"layer":"highlightOverlay", "visibility":1,"minz":5.90,"maxz":18}];

var layersArray=new Array();
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
var myView = new ol.View({
    center: ol.proj.fromLonLat([84.6525554, 20.1664539]),
        zoom: 6.89,
        maxZoom: 20,
        minZoom: 5
}) 

var map = new ol.Map({
    view: myView,
    target: 'map'
    //controls: ol.control.defaults({attribution: false}).extend(mapControls)
});
map.addInteraction(selectClick);


//Base layer
//Open Street Map
var defaultLayer=new ol.layer.Tile({
  source: new ol.source.OSM()
});

var baselayer=defaultLayer;
try {
  baselayer = new ol.layer.Tile({
      source: new ol.source.OSM(),
      visible: false,
      crossOrigin: 'anonymous'
    });
} catch (error) {
  console.log('BaseLayer OSM: '+error);
}


//BingMaps AerialWithLabels
var raster=defaultLayer;
try {
  raster = new ol.layer.Tile({
      title: 'OSM',
      type: 'base',
      visible: true,
      source: new ol.source.BingMaps({
          imagerySet: 'AerialWithLabels',
          key: 'voi3DlahFqo0MOrFalC2~6BX9iFreRSXk_hCsSHtZ0A~AuXzxBFu7NJaGwZO6oX2bEbHUKwhiif5YTYYqOZvgRiSl3Rt2zrcB6Addylvwat9'
          //key:'Aj5jxhwjBJgTVTIRfrLBlZIxoyheEqfNqtvD8Nxv-dT0DIPNHK7S-LTDbca6wkjo' //thakur86@hotmail.com
    
      }),
      visible:false,
    });
} catch (error) {
  console.log('BingMaps AerialWithLabels: '+error);
}

//Google Satellite Map
var googleLayerSatellite=defaultLayer;
try {
  googleLayerSatellite = new ol.layer.Tile({
      title: "Google Satellite",
      source: new ol.source.TileImage({ url: 'https://mt1.google.com/vt/lyrs=s&hl=pl&&x={x}&y={y}&z={z}', crossOrigin: 'anonymous' }),
      visible: false
    });
} catch (error) {
  console.log('Google Satellite Map: '+error);
}

//Google Street Map
var googleLayerStreet=defaultLayer;
try {
  googleLayerStreet = new ol.layer.Tile({
      title: "Google Street",
      source: new ol.source.TileImage({ url: 'https://mt1.google.com/vt/lyrs=r&hl=pl&&x={x}&y={y}&z={z}', crossOrigin: 'anonymous' }),
      visible: false
    });
} catch (error) {
  console.log('Google Street Map: '+error);
}
//All Layers
	  var stateboundarylayer=defaultLayer;
	  try {
	     stateboundarylayer = new ol.layer.Image({
	      source: new ol.source.ImageWMS({
	          url: geoserverUrl+'/FLI_DSS_STATE/wms',
	          params: {
	              'LAYERS': 'FLI_DSS_STATE:StateBoundary',
	              'VERSION': '1.1.0'
	          },
	          serverType: 'geoserver',
	          crossOrigin: 'anonymous'
	      }),
	      title: 'StateBoundary',
	      visible: true
	    });
	  } catch (error) {
	    //stateboundarylayer=defaultLayer;
	    console.log('StateBoundaryLayer: '+error);
	  }

	  var districtboundarylayer=defaultLayer;
	  try {
	    districtboundarylayer = new ol.layer.Image({
	      source: new ol.source.ImageWMS({
	    	  url: geoserverUrl+'/FLI_DSS_AllDivision/wms',          
	          params: {
	              'LAYERS': 'FLI_DSS_AllDivision:district_boundary',
	              'VERSION': '1.1.0'
	          },
	          serverType: 'geoserver',
	          crossOrigin: 'anonymous'
	    
	      }),
	      title: 'DistrictBoundary',
	      visible: true
	    });
	  } catch (error) {
	    console.log(error);
	  }
	  
	  var alldivboundarylayer=defaultLayer;
	  try {
	    alldivboundarylayer = new ol.layer.Image({
	      source: new ol.source.ImageWMS({
	          url: geoserverUrl+'/FLI_DSS_DIVISION/wms',
	          params: {
	              'LAYERS': 'FLI_DSS_DIVISION:Division',
	    
	              'VERSION': '1.1.0'
	          },
	          serverType: 'geoserver',
	          crossOrigin: 'anonymous'
	    
	      }),
	      title: 'DivisionBoundary',
	      visible: false
	    });
	  } catch (error) {
	    console.log('alldivboundarylayer: '+error);
	  }
	  
	  var allrnglayer=defaultLayer;
	  try {
	    allrnglayer = new ol.layer.Image({
	      source: new ol.source.ImageWMS({
	          url: geoserverUrl+'/FLI_DSS_RANGE/wms',
	          params: {
	              'LAYERS': 'FLI_DSS_RANGE:Range',
	              'VERSION': '1.1.0',
	          },
	          serverType: 'geoserver',
	          crossOrigin: 'anonymous'
	      }),
	      title: 'RangeBoundary',
	      visible: false
	    });
	  } catch (error) {
	    console.log('allrnglayer: '+error);
	  }
	  
	  var alltehasillayer=defaultLayer;
	  try {
	    var alltehasillayer = new ol.layer.Image({
	      source: new ol.source.ImageWMS({
	          url: geoserverUrl+'/FLI_DSS_ALL_TAHASIL/wms',
	          params: {
	              'LAYERS': 'FLI_DSS_ALL_TAHASIL:Tehesil',
	              'VERSION': '1.1.0',
	          },
	          serverType: 'geoserver',
	          crossOrigin: 'anonymous'
	      }),
	      title: "TahasilBoundary",
	      visible: false
	    });
	  } catch (error) {
	    console.log('alltehasillayer: '+error);
	  }

	//Base map Click 
		$("#blank_basemap").click(function(){
			 baselayer.setVisible(false);
		    googleLayerSatellite.setVisible(false);
		    googleLayerStreet.setVisible(false);
		});
		$("#imagery_basemap").click(function () {
		  baselayer.setVisible(false);
		  googleLayerSatellite.setVisible(true);
		  googleLayerStreet.setVisible(false);
		});
		$("#street_basemap").click(function () {
		  baselayer.setVisible(false);
		  googleLayerSatellite.setVisible(false);
		  googleLayerStreet.setVisible(true);
		});
		$("#osm_basemap").click(function () {
		  googleLayerSatellite.setVisible(false);
		  googleLayerStreet.setVisible(false);
		  baselayer.setVisible(true);
		});
//Onclick of Village CheckBox   
  $("#chkVillage").on("click", function(event) {
	    //$("#chkVillage").change(function (event) {		    		    	 
				   if(!$("#chkVillage").is(":checked"))
	               {					   
					   village_layer.setVisible(false);
	               }
	               else
	               {
					   if($('#drpDistrict').val()!=0 || $('#drpDistrict').val()!="" || $('#drpDivision').val()!=0 || $('#drpDivision').val()!="")
			    		{
				    		//map.removeLayer(village_layer);				    		
				    		var paramdivision = $("#drpDivision").val();
				    		//console.log(paramdivision);
		    				villLayernm="";				    		
				    		$.ajax({
					           	url:'/Utility/getDivisionVectorMapTypeLayerList',
					            data: {'distid': 0,'divid': paramdivision,'type':14},
					            type: "GET",
					            contentType: "application/json;charset=utf-8",
					            dataType: "json",
					            success :function (obj) {	
					            	//console.log(obj);
					                    if(obj!=null)
					                    {	
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
				                            /* }*/
				                            if(village_layer!=null)
				                            {
					                              map.addLayer(village_layer);
					                              if($("#chkVillage").is(":checked"))
					                             {
					                            	 village_layer.setVisible(true);
					                             }
					                             else
					                             {
					                                  village_layer.setVisible(false);
					                             }  
				                                 
				                            }
				                            else{
				                                //AlertNotify("Village Boundary of "+$( "#chkRange option:selected" ).text()+" range is not available.")
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
					    	viewNotification(3);
							return false;
					    }
	                }
				 });


  			layersArray.push.apply(layersArray,[baselayer, raster, googleLayerStreet, googleLayerSatellite,stateboundarylayer,districtboundarylayer,alldivboundarylayer,allrnglayer,alltehasillayer]);
  			var layerGroup = new ol.layer.Group({
  			  layers: layersArray
  			})
  			map.addLayer(layerGroup);

zoomtoLayer();
//visibleLayer();
//View Layer Start
function viewLayer(checkbox,layerName)
{
	 if ($(checkbox).prop("checked") == true) {
		 updateLayerOrder(layerName,1);
		   //console.log(layerName);
		   
	}else{
		updateLayerOrder(layerName,0);
	}
	
	for(var i=0;i<layerOrderList.length;i++)
	   {
		$("#"+layerName+"_legend").hide();
		if(layerOrderList[i].layer!= "undefined")
			{
			//console.log(layerOrderList[i].layer);
			
			if(layerOrderList[i].visibility==1)
			{
				//console.log(layerOrderList[i].layer);
			
			
				//alert(layerOrderList[i].minz);
				//alert(layerOrderList[i].maxz);
				//alert(map.getView().getZoom());
				
				if(map.getView().getZoom()>=layerOrderList[i].minz && map.getView().getZoom()<=layerOrderList[i].maxz)
					{
					  //var cmv=layerOrderList[i].layer;
					//console.log(layerOrderList[i].layer);
					//var layerArray = map.getLayersByName(layerOrderList[i].layer);
					//alert('layerName'+layerArray);
					eval(layerOrderList[i].layer).setVisible(true);
					//cmv_layer.setVisible(true);
					
					$("#"+layerName+"_legend").show();
						if(layerName=="cmv_layer" || layerName=="rf_layer" || layerName=="dlc_layer")
						{
							$("#"+layerName+"_adj_legend").show();
							//console.log(layerName);
						}
						if($("#chk"+layerName).hasClass("chkColor")){
							$("#chk"+layerName).removeClass("chkColor");
						}
						 
						if(!$("#chk"+layerName).hasClass("custom-control-input")){
							$("#chk"+layerName).addClass("custom-control-input");
						} 
						
					}
				else
					{
					    eval(layerOrderList[i].layer).setVisible(false);
						$("#chk"+layerName).addClass("chkColor");
						if(!$("#chk"+layerName).hasClass("chkColor")){
							$("#chk"+layerName).addClass("chkColor");
						}
						
						 if($("#chk"+layerName).hasClass("custom-control-input")){
							$("#chk"+layerName).removeClass("custom-control-input");
						} 
					}
				}
			}
		
	   } 
	}
//View Layer End

//Resolution
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
					
						if(layerOrderList[i].layer=="cmv_layer" || layerOrderList[i].layer=="rf_layer")
						{
							$("#"+layerOrderList[i].layer+"_adj_legend").show();
							//console.log(layerOrderList[i].layer);
						}
					}
				else
					{
						eval(layerOrderList[i].layer).setVisible(false);
						if(!$("#chk"+layerOrderList[i].layer).hasClass("chkColor")){
							$("#chk"+layerOrderList[i].layer).css('background-color','#FF0000');
					}
				}   
				}
			}
		
	   }
}); 
//End of Resolution

//Update Layer Order
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
//End of Update Layer Order

//visible Layer Start
function visibleLayer()
{
	$(".legendbox").hide();
	// divRange divVillage divCMV divRev divDLC
	if($("#drpfltype").val()=="1")
		{
			alert("visible");
		//$("#divTehsil").hide();
			//$("#divVillage").hide();
			//$("#divRev").hide();
			//$("#divDLC").hide();
			
			if($("#btnDistrict").hasClass("btn-dark"))
			{
				alert("visible dist");
				updateLayerOrder("alldivboundarylayer",1);
				$('input[type="checkbox"][id="chkDivision"]').prop("checked", true);
				$("#alldivboundarylayer_legend").show();
			}
			else
				{
				updateLayerOrder("districtboundarylayer",1);
				$('input[type="checkbox"][id="chkDist"]').prop("checked", true);
				$("#districtboundarylayer_legend").show();
				}
			updateLayerOrder("cmv_layer",1);
			$('input[type="checkbox"][id="chkCmv"]').prop("checked", true).trigger("change");
			$("#nfb_layer_legend").show();
		}
	else 
		{
		//$("#divRange").hide();
		//$("#divCMV").hide();
		//$("#divDLC").hide();
		if($("#btnDistrict").hasClass("btn-dark"))
		{
			updateLayerOrder("alldivboundarylayer",1);
			$('input[type="checkbox"][id="chkDivision"]').prop("checked", true);
			$("#alldivboundarylayer_legend").show();
		}
		else{
			updateLayerOrder("districtboundarylayer",1);
			$('input[type="checkbox"][id="chkDist"]').prop("checked", true);
			$("#districtboundarylayer_legend").show();
		}
		updateLayerOrder("rf_layer",1);
		$('input[type="checkbox"][id="chkRFFinal"]').prop("checked", true).change();
		$("#rf_layer_legend").show();
	  }
	/* else
	{
		//$("#divRange").hide();
		//$("#divCMV").hide();
		//$("#divRev").hide();
		if($("#drpdistDivList").val()==2)
		{
			updateLayerOrder("alldivboundarylayer",1);
			$('input[type="checkbox"][id="chkDivision"]').prop("checked", true);
			$("#alldivboundarylayer_legend").show();
		}
		else{
			updateLayerOrder("districtboundarylayer",1);
			$('input[type="checkbox"][id="chkDist"]').prop("checked", true);
			$("#districtboundarylayer_legend").show();
		}
		
	  }
		updateLayerOrder("tahasil_layer",1);
		$('input[type="checkbox"][id="chktahasil_layer"]').prop("checked", true).change();
		$("#tahasil_layer_legend").show(); */
	}
//Visible Layer End

//Zoom to Layer Start
function zoomtoLayer()
{
	try{
		if($("#drpfltype").val()=="1")
		{
			var jsonObj = {};
			var arr=[];
			var cmvList=${layer};
			//var cmvList=layers;
			//alert('CMV List'+layers);
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
		    	 style:nfb_survey_style
		        
		    	  });
		        map.addLayer(cmv_layer);
		        
	 		viewLayer($("input[id='chkCmv']"), "cmv_layer");
		      cmv_layer.setVisible(true);
		   map.getView().fit(cmv_layer.getSource().getExtent(), (map.getSize()));
		}
		else{
			var rfList=${layer};
			//console.log(rfList);
			if(rfList!=null) {
				addRFLayer(rfList);
			}
		}
		/* else if($("#drpfltype").val()=="3"){
			var dlcList=${layer};
			//console.log(dlcList[0]);
			if(dlcList!=null) {
				addDLCLayer(dlcList);
			}
		} */
	}
	catch(error)
	{
		alert("zomm to layer error");
	}	
}
//Zoom to Layer End

//Revenue Forest Layer
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
	            viewLayer($("input[id='chkRFFinal']"), "rf_layer");
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
//End of Revenue

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
        		//console.log("on click map");
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
                   // var report="https://odishaforestlandsurvey.in/FRJVC_Certified_Reports/"+props.range_code+"-"+props.fb_id+"-JVR.pdf";
                  	 content.innerHTML = "<h5>NFB Details</h5>"
                           +"<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr><td><strong>Division :</strong></td><td>"+props.division_name+"</td></tr>"
                           +"<tr><td><strong>Range :</strong></td><td>"+props.range_name+"</td></tr>"
                           +"<tr><td><strong>Forest Block :</strong></td><td>"+props.fb_name+"</td></tr>"
                           +"<tr><td><strong>CMV Area(Sq KM) :</strong></td><td>"+props.area_sqkm+"</td></tr>"
                           +"<tr><td><strong>CMV Perimeter :</strong></td><td>"+props.perimeter+"</td></tr></table></div>";
                           //+"<tr><td><strong>FRJVC Report :</strong></td><td><a href='"+report+"' target='_blank'><span>View</span></a></td></tr></table></div>";
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


	
/* On click of back button */
function back() {
    $('#divforData').show();
    $('#divMap').hide();
    //$('#map').hide();
}
/* End- On click of back button */

/*  Objective: AddRemove Layers using CheckBox ChangeEvent 
Status: Completed*/

try {
var fromDiv = document.getElementById("layerHeading1"); // get all checkbox under this id
const layerElements = document.querySelectorAll('input[type=checkbox]'); // get all check box in this page
for (let layerElement of layerElements) {
layerElement.addEventListener('change', function () {
  let layerElementValue = this.value;
  let layer;

  layerGroup.getLayers().forEach(function (element, index, array) {

    if (layerElementValue === element.get('title')) {
      layer = element;
    }
  })
  if (layer != null) {

    this.checked ? layer.setVisible(true) : layer.setVisible(false);

  }

})
}

} catch (error) {
console.log('AddRemoveLayer using CheckBox CheckChange: ' + error);
}

</script>


<!-- <script src="/assets/js/fld/fldMapView.js"></script> -->
