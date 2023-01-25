<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css"
	type="text/css">
<script src="https://unpkg.com/elm-pep"></script>
<!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
<script
	src="https://cdn.polyfill.io/v3/polyfill.min.js?features=fetch,requestAnimationFrame,Element.prototype.classList,URL,TextDecoder"></script>
<script
	src="https://unpkg.com/dom-to-image-more@2.8.0/dist/dom-to-image-more.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script src="https://unpkg.com/elm-pep"></script>

<form>

	<div class="mapFilterBase2 col-xl-3 col-md-3 col-sm-3">

		<!-- <h4 class="mt-0 header-title mb-4">Map Filter</h4> -->
		<a class="closeBtn closeBtnAll2 collapsed" type=""
			data-toggle="collapse" data-target="#accordionCloseAll"
			aria-expanded="false" aria-controls="accordionCloseAll"><span
			aria-hidden="true"><i class="fa fa-angle-down"></i></span></a>
		<div id="accordion" class="mapFilter2">
			<div class="pull-right" style="margin-right: 37px">
				<a id="layerDiv" href="#collapseOne" class="text-dark collapsed"
					data-toggle="collapse" aria-expanded="true"
					aria-controls="collapseOne"> <span class="d-block"><img
						src="/images/icon-layers-2.png" style="width: 25px"></span>
				</a>

			</div>
			<div class="clearfix"></div>

			<div id="accordionCloseAll" style="position: relative; right: -40px">

				<div class="mb-0">
					<div class="card">
						<div class="">
							<div id="collapseOne" class="collapse show"
								aria-labelledby="headingOne" data-parent="#accordion">
								<div class="fixHeightRight2">
									<div class="card-body">
										<h5 class="mt-0 header-title mb-2">Base Map</h5>
										<div class="custom-box-separator">
											<form class="form-horizontal" action="">
												<div class="form-group-sm row">
													<div class="custom-control custom-checkbox">
														<input class="custom-control-input" id="terrian"
															type="checkbox" checked> <label
															class="custom-control-label" for="terrian">Topographic</label>
													</div>
												</div>
												<div class="form-group-sm row">
													<div class="custom-control custom-checkbox">
														<input class="custom-control-input" id="googlesat"
															type="checkbox"> <label
															class="custom-control-label" for="googlesat">Google
															Satellite</label>
													</div>
												</div>
											</form>
										</div>
										<!--/custom-box-separator-->
										<div id="divlayerlist">
											<h5 class="mt-3 header-title mb-2">FB:
												${model.getFb().getChrvNfbName()}
												${model.getFb().getMForestType().getChrvTypeName()}</h5>
											<div class="custom-box-separator">
												<form>
													<!--   @* <h6 class="mt-2 header-title mb-2">Derived Map</h6> *@ -->
													<!--/State Boundry-->
													<div class="form-group-sm row">
														<div class="custom-control custom-checkbox col-md-10">
															<input class="custom-control-input" id="chkCMV"
																type="checkbox"> <label
																class="custom-control-label" for="chkCMV">CMV</label> <img
																src="/images/icon-district-boundary.png" width="15px" />
														</div>
													</div>
													<div class="form-group-sm row">
														<div class="custom-control custom-checkbox">
															<input class="custom-control-input" id="chkJVB"
																type="checkbox" checked> <label
																class="custom-control-label" for="chkJVB">JV
																Boundary</label> <img src="/images/icon-jvboundary.png"
																width="12px" />
														</div>
													</div>
													<div class="form-group-sm row">
														<div class="custom-control custom-checkbox">
															<input class="custom-control-input" id="jvpillarpoints"
																type="checkbox"> <label
																class="custom-control-label" for="jvpillarpoints">JV
																Pillar</label> <br> <img src="/images/icon-crl-black.png"
																width="12px" class="ml-3 mr-1" /><span>Existing</span>
															<br> <img src="/images/icon-crl-blue.png"
																width="12px" class="ml-3 mr-1" /><span>Proposed</span>
															<br>
															<!-- @* <img src="~/images/icon-crl-red.png" width="12px" class="ml-3 mr-1"/><span>Common Pillar</span> *@ -->
															<i class="fa fa-circle"
																style="font-size: 12px; color: #02ba5a; position: relative; top: 3px; padding-right: 3px; margin-left: 15px;"></i>
															<span>Common Pillar</span>
														</div>
													</div>

													<div class="form-group-sm row">
														<div class="custom-control custom-checkbox">
															<input class="custom-control-input" id="dgpspillarpoints"
																type="checkbox" checked> <label
																class="custom-control-label" for="dgpspillarpoints">DGPS
																Pillar</label> <br> <i class="fa fa-circle"
																style="font-size: 12px; color: #f90; position: relative; top: 3px; padding-right: 3px; margin-left: 15px;"></i>
															<span>DGPS Pillar</span>
														</div>
													</div>

													<c:if test="${!model.commonpillarList.isEmpty() }">
														<!--  @if(@Model.commonpillarList.Any())
                                            { -->
														<div class="form-group-sm row">
															<div class="custom-control custom-checkbox">
																<input class="custom-control-input"
																	id="dgpscommonpoints" type="checkbox"> <label
																	class="custom-control-label" for="dgpscommonpoints">Common
																	Pillars</label> <i class="fa fa-circle"
																	style="font-size: 12px; color: #800000;"></i>


																<!--  @* <span>Common Pillar</span> *@ -->
															</div>
														</div>


													</c:if>

													<!--/State Boundry-->
												</form>
											</div>
											<!--/custom-box-separator-->

											<!--/custom-box-separator-->

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


				<div class="mb-0">
					<div class="card">
						<div class="">
							<div id="collapseFour" class="collapse"
								aria-labelledby="headingFour" data-parent="#accordion">
								<div class="fixHeightRight2">
									<div class="card-body">
										<h5 class="mt-0 header-title mb-2">Measurement</h5>

										<div class="custom-box-separator">
											<form class="form-horizontal" action="">
												<div class="widget-body">
													<div id="measurementDiv" class="widget-main">

														<div class="custom-control custom-radio">
															<input type="radio" id="customRadioInline1"
																name="outer-group[0][customRadioInline1]"
																class="custom-control-input" value="Polygon"> <label
																class="custom-control-label" for="customRadioInline1">Area</label>
														</div>
														<div class="custom-control custom-radio">
															<input type="radio" id="customRadioInline2"
																name="outer-group[0][customRadioInline1]"
																class="custom-control-input" value="LineString">
															<label class="custom-control-label"
																for="customRadioInline2">Distance</label>
														</div>
														<div class="mt-2">
															Result :
															<samp id="js-result">NA</samp>
														</div>
														<div class="text-right">
															<input type="button"
																class="btn btn-sm btn-warning waves-effect waves-light m-1"
																value="Reset" id="btnresetmeasure">
														</div>
													</div>
												</div>
											</form>
										</div>
										<!--/custom-box-separator-->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--/all div close-->

		</div>
		<!--/accordion-->
	</div>
	<!--/mapFilterBase-->
	<!-- Map View div -->
	<div id="popup" class="ol-popup">
		<a href="#" id="popup-closer" class="ol-popup-closer"></a>
		<div id="popup-content"></div>
	</div>



	<div id="divmap" style="height: 580px; width: 100%;"></div>


	<%@ include file="../shared/footer.jsp"%>

	<script src="/assets/js/libs/jquery-3.1.1.min.js"></script>

	<script
		src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
	<script src="https://epsg.io/32645.js"></script>
	<script src="/v5.3.0-dist/32644.js"></script>



	<script type="text/javascript">
		var jvPillarListJson, dgpsPillarListJson, commonpillarListJson;
	</script>


	<script>
		//Base layer 
		var wpLayer = []
		var baselayer = new ol.layer.Tile({
			source : new ol.source.OSM()
		});
		var raster = new ol.layer.Tile(
				{
					title : 'OSM',
					type : 'base',
					visible : false,
					source : new ol.source.BingMaps(
							{
								imagerySet : 'AerialWithLabels',
								key : 'voi3DlahFqo0MOrFalC2~6BX9iFreRSXk_hCsSHtZ0A~AuXzxBFu7NJaGwZO6oX2bEbHUKwhiif5YTYYqOZvgRiSl3Rt2zrcB6Addylvwat9'
							})
				});

		var googleLayerSatellite = new ol.layer.Tile(
				{
					title : "Google Satellite",
					source : new ol.source.TileImage(
							{
								url : 'https://mt1.google.com/vt/lyrs=s&hl=pl&&x={x}&y={y}&z={z}'
							}),
					visible : false,
				});

		//Pillar Points
		var points = [], tstyle, arr = [], dgpspillarLayer, jvpillarLayer, jvpoints = [], dgpscommonpillarLayer, commonpoints = [], adjacentarr = [], adjacentfb = [];
		//JV

		var jvdata; //${jvPillarListJson};

		$.ajax({
			url : 'http://localhost:8080/api/DGPSSurvey/_PartialDGPSMapView',
			data : {
				'fbid' : 1200
			},
			contentType : "application/json;charset=utf-8",
			type : 'GET',
			dataType : "json",
		}).done(
				function(result) {

					jvdata = result.jvPillarList;

					console.log('JV Successfully call the api: ');

					$.each(jvdata, function(c, d) {
						var feature = new ol.Feature({
							geometry : new ol.geom.Point(ol.proj.transform([d.decLongitude, d.decLatitude ],'EPSG:4326', 'EPSG:3857')),
							jvPlrNo : d.intSeqNo,
							type : d.chrvPlrType,
							cond : d.chrvPlrCond,
							rmk : d.chrvPlrRmk,
							jvpic_path : d.chrvPicPath,
							loc_type : d.chrvLocType,
							paint_sts : d.chrvPaintSts,
							jvlatitude : d.decLatitude,
							jvlongitude : d.decLongitude,
							delete_sts : d.bytDeleteStatusWeb,
							id : d.intPkSlno,
							commonPlrSts : d.intCommonStatus,
							point_type : "JV"
						});
						jvpoints.push(feature);

					});
				}).fail(function(xhr, status) {
			alert(status);
		});

		jvpillarLayer = new ol.layer.Vector({
			source : new ol.source.Vector({
				features : jvpoints
			}),
			style : function(feature, resolution) {
				var rejectedStyle = new ol.style.Style({
					image : new ol.style.Circle({
						radius : 6,
						stroke : new ol.style.Stroke({
							color : 'white',
							width : 2
						}),
						fill : new ol.style.Fill({
							color : 'green'
						})
					}),
					text : new ol.style.Text({
						font : 'bold 12px Calibri,sans-serif',
						fill : new ol.style.Fill({
							color : '#000'
						}),
						stroke : new ol.style.Stroke({
							color : '#fff',
							width : 2
						}),
						textAlign : 'top',
						textBaseline : 'bottom',
						text : feature.get('jvPlrNo').toString()
					})
				});
				var acceptedStyle = new ol.style.Style({
					image : new ol.style.Circle({
						radius : 6,
						stroke : new ol.style.Stroke({
							color : 'white',
							width : 2
						}),
						fill : new ol.style.Fill({
							color : 'black'
						})
					}),
					text : new ol.style.Text({
						font : 'bold 12px Calibri,sans-serif',
						fill : new ol.style.Fill({
							color : '#000'
						}),
						stroke : new ol.style.Stroke({
							color : '#fff',
							width : 2
						}),
						textAlign : 'top',
						textBaseline : 'bottom',
						text : feature.get('jvPlrNo').toString()
					})
				});
				var newStyle = new ol.style.Style({
					image : new ol.style.Circle({
						radius : 6,
						stroke : new ol.style.Stroke({
							color : 'white',
							width : 2
						}),
						fill : new ol.style.Fill({
							color : 'blue'
						})
					}),
					text : new ol.style.Text({
						font : 'bold 12px Calibri,sans-serif',
						fill : new ol.style.Fill({
							color : '#000'
						}),
						stroke : new ol.style.Stroke({
							color : '#fff',
							width : 2
						}),
						textAlign : 'top',
						textBaseline : 'bottom',
						text : feature.get('jvPlrNo').toString()
					})
				});
				if (feature.get('commonPlrSts') == 1)
					return [ rejectedStyle ];
				if (feature.get('delete_sts') == 0)
					return [ acceptedStyle ];
				else
					return [ newStyle ];
			}
		});

		//DGPS  
		/*  var data = @Html.Raw(Json.Serialize(Model.dgpsPillarList)); */
		var data; //${dgpsPillarListJson};

		$
				.ajax(
						{
							url : 'http://localhost:8080/api/DGPSSurvey/_PartialDGPSMapView',
							data : {
								'fbid' : 1200
							},
							contentType : "application/json;charset=utf-8",
							type : 'GET',
							dataType : "json",
						})
				.done(
						function(result) {

							console.log('dgps call the api: ');
							data = result.dgpsPillarList;
							$
									.each(
											data,
											function(a, b) {
												var feature = new ol.Feature(
														{
															geometry : new ol.geom.Point(
																	ol.proj
																			.transform(
																					[
																							b.decLongitude,
																							b.decLatitude ],
																					'EPSG:4326',
																					'EPSG:3857')),
															fbid : b.mforestBlkSurveyDetail != null ? b.mforestBlkSurveyDetail.intId
																	: 0,
															plr_cd : b.tpillarDetail != null ? b.tpillarDetail.intPkSlno
																	: 0,
															plr_no : ((b.intSubPlrNo == 0 || b.intSubPlrNo == null) ? b.intPlrNo
																	: b.intPlrNo
																			+ "_"
																			+ b.intSubPlrNo),
															latitude : b.decLatitude,
															longitude : b.decLongitude,
															rtxAccuracy : b.decRtxAccuracy,
															/* fpic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_f_pic_name),
															bpic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_b_pic_name),
															ipic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_i_pic_name),
															opic:'@ViewBag.pillarPath'+getFileNameFromURL(b.chrv_o_pic_name), */
															//wpic:'${pillarPath}'+getFileNameFromURL(b.chrvDivPicName),
															point_type : "DGPS"
														});
												points.push(feature);

											});

						}).fail(function(xhr, status) {
					alert(status);
				});

		dgpspillarLayer = new ol.layer.Vector({
			source : new ol.source.Vector({
				features : points
			}),
			style : function(feature, resolution) {
				var acceptedStyle = new ol.style.Style({
					image : new ol.style.Circle({
						radius : 6,
						stroke : new ol.style.Stroke({
							color : 'white',
							width : 2
						}),
						fill : new ol.style.Fill({
							color : 'orange'
						})
					}),
					text : new ol.style.Text({
						font : 'bold 12px Calibri,sans-serif',
						fill : new ol.style.Fill({
							color : '#000'
						}),
						stroke : new ol.style.Stroke({
							color : '#fff',
							width : 2
						}),
						textAlign : 'top',
						textBaseline : 'bottom',
						text : feature.get('plr_no').toString()
					})
				});
				var verifyStyle = new ol.style.Style({
					image : new ol.style.Circle({
						radius : 5,
						fillOpacity : 0.4,
						fill : new ol.style.Fill({
							color : '#14abef'
						}),
						stroke : new ol.style.Stroke({
							color : '#14abef',
							width : 1
						})
					}),
					text : new ol.style.Text({
						font : 'bold 12px Calibri,sans-serif',
						fill : new ol.style.Fill({
							color : '#000'
						}),
						stroke : new ol.style.Stroke({
							color : '#fff',
							width : 2
						}),
						textAlign : 'top',
						textBaseline : 'bottom',
						text : feature.get('plr_no').toString()
					})
				});
				var defaultStyle = new ol.style.Style({
					image : new ol.style.Circle({
						radius : 5,
						fillOpacity : 0.4,
						fill : new ol.style.Fill({
							color : '#1f7a1f'
						}),
						stroke : new ol.style.Stroke({
							color : '#1f7a1f',
							width : 1
						})
					}),
					text : new ol.style.Text({
						font : 'bold 12px Calibri,sans-serif',
						fill : new ol.style.Fill({
							color : '#000'
						}),
						stroke : new ol.style.Stroke({
							color : '#fff',
							width : 2
						}),
						textAlign : 'top',
						textBaseline : 'bottom',
						text : feature.get('plr_no').toString()
					})
				});
				if (true) {
					return [ acceptedStyle ];
				} else {
					return [ acceptedStyle ];
				}
			}
		});

		$.each(data, function(i, d) {
			arr.push({
				latitude : d.decLatitude,
				longitude : d.decLongitude
			});
		});
		//const result=averageGeolocation(arr);
		var map = new ol.Map({
			layers : [ baselayer, googleLayerSatellite ],
			controls : ol.control.defaults().extend(
					[ new ol.control.ScaleLine({
						units : 'metric'
					}), new ol.control.FullScreen() ]),
			target : 'divmap',
			view : new ol.View({
				center : ol.proj.fromLonLat([ 20.7241, 84.5353 ]),
				zoom : arr.length > 50 ? 13 : 15,
				maxZoom : 50,
				minZoom : 5
			})
		});
		baselayer.setVisible(true);

		//dgps common layer
		/* var dgpscommonpillardata = @Html.Raw(Json.Serialize(Model.commonpillarList)); */

		var dgpscommonpillardata;//${commonpillarListJson};

		$
				.ajax(
						{
							url : 'http://localhost:8080/api/DGPSSurvey/_PartialDGPSMapView',
							data : {
								'fbid' : 1200
							},
							contentType : "application/json;charset=utf-8",
							type : 'GET',
							dataType : "json",
						})
				.done(
						function(result) {

							dgpscommonpillardata = result.commonpillarList;

							console.log('Common Successfully call the api: ');

							$
									.each(
											dgpscommonpillardata,
											function(a, b) {
												var feature = new ol.Feature(
														{
															geometry : new ol.geom.Point(
																	ol.proj
																			.transform(
																					[
																							b.tpillarDetail1 != null ? b.tpillarDetail1.decLongitude
																									: null,
																							b.tpillarDetail1 != null ? b.tpillarDetail1.decLatitude
																									: null ],
																					'EPSG:4326',
																					'EPSG:3857')),
															fbid : b.mforestBlkSurveyDetail != null ? b.mforestBlkSurveyDetail.intId
																	: null,
															plr_no : b.tpillarDetail1 != null ? b.tpillarDetail1.intSeqNo
																	: null,
															fbname : b.mforestBlkSurveyDetail2 != null ? b.mforestBlkSurveyDetail2.chrvNfbName
																	: null,
															range : b.mrange1 != null ? b.mrange1.chrvRangeNm
																	: null,
															division : b.mdivision2 != null ? b.mdivision2.chrvDivisionNm
																	: null,
															refplr_no : b.tpillarDetail2 != null ? b.tpillarDetail2.intSeqNo
																	: null,
															latitude : b.tpillarDetail1 != null ? b.tpillarDetail1.decLatitude
																	: null,
															longitude : b.tpillarDetail1 != null ? b.tpillarDetail1.decLongitude
																	: null,
															point_type : "DGPSCommon"
														});
												commonpoints.push(feature);

											});
						}).fail(function(xhr, status) {
					alert(status);
				});

		dgpscommonpillarLayer = new ol.layer.Vector({
			source : new ol.source.Vector({
				features : commonpoints
			}),
			style : function(feature, resolution) {
				var acceptedStyle = new ol.style.Style({
					image : new ol.style.Circle({
						radius : 6,
						stroke : new ol.style.Stroke({
							color : 'white',
							width : 2
						}),
						fill : new ol.style.Fill({
							color : '#800000'
						})
					}),
					text : new ol.style.Text({
						font : 'bold 12px Calibri,sans-serif',
						fill : new ol.style.Fill({
							color : '#000'
						}),
						stroke : new ol.style.Stroke({
							color : '#fff',
							width : 2
						}),
						textAlign : 'top',
						textBaseline : 'bottom',
						text : feature.get('plr_no').toString()
					})
				});

				return [ acceptedStyle ];

			}
		});

		//end

		/* visible */
		jvpillarLayer.setVisible(false);
		googleLayerSatellite.setVisible(false);
		map.addLayer(dgpscommonpillarLayer);
		dgpscommonpillarLayer.setVisible(false);
		// console.log(dgpscommonpillarLayer);
		dgpspillarLayer.setVisible(true);
		//On Check Box Change Event
		//DGPS Pillar Layer
		//OverLay
		var container = document.getElementById('popup');
		var content = document.getElementById('popup-content');
		var closer = document.getElementById('popup-closer');
		var overlay = new ol.Overlay({
			element : container,
			positioning : 'bottom-center',
			stopEvent : true,
			autoPan : true,
			autoPanAnimation : {
				duration : 250
			}
		});
		map.addOverlay(overlay);
		closer.onclick = function() {
			overlay.setPosition(undefined);
			closer.blur();
			return false;
		};
		/* end Overlay */
	</script>




	<script type="text/javascript">
		//Change event
		$("#dgpspillarpoints").change(function() {

			if (this.checked) {
				dgpspillarLayer.setVisible(true);
			} else {
				dgpspillarLayer.setVisible(false);
				overlay.setPosition(undefined);
			}
		});
		//Common Pillar
		$("#dgpscommonpoints").change(function() {
			//console.log(this);
			if (this.checked) {
				dgpscommonpillarLayer.setVisible(true);
			} else {
				dgpscommonpillarLayer.setVisible(false);
				overlay.setPosition(undefined);
			}
		});
		//Pillar Points
		$("#jvpillarpoints").change(function() {
			if (this.checked) {
				jvpillarLayer.setVisible(true);
			} else {
				jvpillarLayer.setVisible(false);
				overlay.setPosition(undefined);
			}
		});
	</script>

	<script type="text/javascript">
		$("#dgpspillarpoints").change(function() {

			if (dgpspillarLayer != null) {
				map.addLayer(dgpspillarLayer);
				dgpspillarLayer.setVisible(true);
			}
		});

		if (dgpspillarLayer != null) {
			map.addLayer(dgpspillarLayer);
			dgpspillarLayer.setVisible(true);
		}

		//JV bOundary

		$("#chkJVB").change(function() {

			if (this.checked) {
				if (jvLayer != null) {
					jvLayer.setVisible(true);
				}
			} else {
				if (jvLayer != null) {
					jvLayer.setVisible(false);
				}
			}
		});

		$("#terrian").change(function() {
			if (this.checked) {
				baselayer.setVisible(true);
				//raster.setVisible(false);
				googleLayerSatellite.setVisible(false);
				$("#googlesat").prop("checked", false);
			} else {
				baselayer.setVisible(false);
			}
		});
		//OSM basemap Checkbox Change Event
		$("#googlesat").change(function() {
			if (this.checked) {
				//raster.setVisible(true);
				googleLayerSatellite.setVisible(true);
				baselayer.setVisible(false);
				$("#terrian").prop("checked", false);
			} else {
				//raster.setVisible(false);
				googleLayerSatellite.setVisible(false);
			}
		});
	</script>

</form>
