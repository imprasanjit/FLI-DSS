
$.getScript('/assets/js/apps/baseLayers.js', function() {
	var  rng_layer, village_layer, cmv_layer, mmv_layer, jvFnl_layer, dgpsdrft_layer, dgpsfnl_layer, revFrst_layer, dlcFnl_layer;
	//tahasil_layer, tahasil_layer1 = []
	/*var layerdata={
			"layerName":"alldivboundarylayer",
			"layer":alldivboundarylayer
		}*/
	//var source = new ol.source.Vector();
	var defaultLayer = new ol.layer.Tile({
		source: new ol.source.OSM()
	});

	var stateboundarylayer = defaultLayer;
	try {
		stateboundarylayer = new ol.layer.Image({
			source: new ol.source.ImageWMS({
				url: geoserverUrl + '/FLI_DSS_STATE/wms',
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
		console.log('StateBoundaryLayer: ' + error);
	}
	

	/* var districtboundarylayer=defaultLayer;
	 try {
   districtboundarylayer = new ol.layer.Image({
		 source: new ol.source.ImageWMS({
			 url: geoserverUrl+'/FLI_DSS_AllDivision/wms',          
			 params: {
				 'LAYERS': 'FLI_DSS_AllDivision:district_boundary',
				 'VERSION': '1.1.0',
				 //'CQL_FILTER':"dist_id="+$("#drpDistrict").val()
			 },
			 serverType: 'geoserver',
			 crossOrigin: 'anonymous'
	   
		 }),
		 title: 'DistrictBoundary',
		 visible: true
	   });
	 } catch (error) {
	   console.log(error);
	 }*/

	/* var alldivboundarylayer=defaultLayer;
	try {  
  alldivboundarylayer = new ol.layer.Image({
		source: new ol.source.ImageWMS({
			url: geoserverUrl+'/FLI_DSS_DIVISION/wms',
			params: {
				'LAYERS': 'FLI_DSS_DIVISION:Division',    
				'VERSION': '1.1.0',
				'CQL_FILTER':"DIV_ID="+$("#drpDivision").val()
			},
			serverType: 'geoserver',
			crossOrigin: 'anonymous'
	  
		}),
		title: 'DivisionBoundary',
		visible: false
	  });
	} catch (error) {
	  console.log('alldivboundarylayer: '+error);
	}*/

	/* var allrnglayer=defaultLayer;
	 try {
	   //console.log($("#drpDivision").val()),
	   //console.log(allrnglayer),
	   //alert($("#drpDivision").val());
	   allrnglayer = new ol.layer.Image({
		 source: new ol.source.ImageWMS({
			 url: geoserverUrl+'/FLI_DSS_RANGE/wms',
			 params: {
				 'LAYERS': 'FLI_DSS_RANGE:Range',
				 'VERSION': '1.1.0',
				 //'CQL_FILTER':"DIV_ID="+$("#drpDivision").val()
			 },
			 serverType: 'geoserver',
			 crossOrigin: 'anonymous'
		 }),
		 title: 'RangeBoundary',
		 visible: false
	   });
	 } catch (error) {
	   console.log('allrnglayer: '+error);
	 }*/

	/*var alltehasillayer=defaultLayer;
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
	}*/



	/*  $("#chkDivision").on("click", function(event) {
		 alert("hi");
		 if(this.array_.length){
				var extent = this.array_[0].getGeometry().getExtent();
				map.getView().fitExtent(extent,map.getSize());
			}
	  });*/
	
	layersArray.push.apply(layersArray, [stateboundarylayer]);

	const layerGroup = new ol.layer.Group({
		layers: layersArray
	})

	map.addLayer(layerGroup);
	/*  Objective: AddRemove Layers using CheckBox ChangeEvent 
	Status: Completed*/

	try {
		var fromDiv = document.getElementById("layerHeading1"); // get all checkbox under this id
		const layerElements = document.querySelectorAll('input[type=checkbox]'); // get all check box in this page
		for (let layerElement of layerElements) {
			layerElement.addEventListener('change', function() {
				let layerElementValue = this.value;
				let layer;

				layerGroup.getLayers().forEach(function(element, index, array) {

					if (layerElementValue === element.get('title')) {
						layer = element;
					}
				})
				if (layer != null) {

					console.log('3rd execu....');
					this.checked ? layer.setVisible(true) : layer.setVisible(false);

				}

			})
		}

	} catch (error) {
		console.log('AddRemoveLayer using CheckBox CheckChange: ' + error);
	}
	/* End of AddRemove Layers using CheckBox ChangeEvent */
});
var divlayer;
//Division boundary Checkbox Change Event
$("#chkDivision").change(function() {
	try{
	//map.removeLayer(stateboundarylayer);
	//map.removeLayer(districtboundarylayer);
	var paramdist = ($("#drpDistrict").val() == null || $("#drpDistrict").val() == "") ? 0 : $("#drpDistrict").val();
	var paramdiv = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();
	if (this.checked) {

		/*alert($("#drpDivision option:selected").text().toLowerCase());*/
		/*alert($("#drpDivision option:selected").text());*/
		
		
		$.ajax({
			async: false,
			url: '/Utility/getDivisionVectorMapTypeLayerList',
			data: { 'distid': paramdist, 'divid': paramdiv, 'type': 3 },
			type: "GET",
			contentType: "application/json;charset=utf-8",
			dataType: "json",
			success: function(data) {

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
					LayerOrdering();
					//map.addLayer(divlayer);
					layerQuery('division', data[i].text)
				}

				

			},
			error: function(errormessage) {
				alert(errormessage.responseText);
			}
		});

		
		

	}
	else {
		//alert("else");
		map.getLayers().forEach(function(element, index, array) {
						if (element.get('title') === 'DivisionBoundary') {
							if (element != null) {
								element.setVisible(false);

							}
						}
					});
		map.removeLayer(divlayer);
	}
}
catch(e)
{
console.log(e);
}
});

$("#chkDist").change(function() {

	try {
		if (this.checked) {
			var distid = $("#drpDistrict").val() != '' || $("#drpDistrict").val() != null ? $("#drpDistrict").val() : 0;
			
			districtboundarylayer = new ol.layer.Image({
				source: new ol.source.ImageWMS({
					url: geoserverUrl + '/FLI_DSS_AllDivision/wms',
					params: {
						'LAYERS': 'FLI_DSS_AllDivision:district_boundary',
						'VERSION': '1.1.0',
						//'STYLE': "district_style",
						 style:district_style(),
						'CQL_FILTER': (distid != 0 ? "dist_id=" + distid : "dist_id=dist_id")
						
					},
				}),
				title: 'DistrictBoundary',
				visible: true
			});
			LayerOrdering();
			//map.addLayer(districtboundarylayer);
		}
		else {
			map.removeLayer(districtboundarylayer);
		}
	} catch (error) {
		console.log(error);
	}
	layerQuery('district', '');
});


/*$("#chkDist").change(function() {
						
							var vectorSource = new ol.source.Vector({
								features:features,
					            wrapX: false,
					            });

					            districtboundarylayer = new ol.layer.Vector({
					            source: vectorSource,
					            style:district_style,
					            title:'DistrictBoundary'
					            });
					            
					            map.addLayer(districtboundarylayer);
					            districtboundarylayer.setVisible(true);
					         
							
					});*/
					
//Zoom Layer
								
function layerQuery(layer, layerName) {
	try
	{
	var query = ""; //Query for Zoom Extent
	var url = "";  //Feature Layer URL
	var zoom = 10;  //Zoom 
	var linkid = layerName.substr(0, layerName.indexOf(':'));
	if (layer == "division") {
		//alert("if") ;
		query = "div_id='" + $('#drpDivision').val() + "'";

		url = geoserverUrl + '/' + linkid + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=' + layerName + '&maxFeatures=50&outputFormat=application%2Fjson&CQL_FILTER=' + query;
		zoom = 10;
		zoomLayer(url, zoom);

	}
	else if (layer == "district") {
		query = "dist_id='" + $('#drpDistrict').val() + "'";
		var url = geoserverUrl + '/FLI_DSS_AllDivision/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=FLI_DSS_AllDivision%3Adistrict_boundary&maxFeatures=50&outputFormat=application%2Fjson&CQL_FILTER=' + query; 
		zoom = 10;
		zoomLayer(url, zoom);

	}
	else {

	}
	}
	catch(exception)
	{
		console.log(exception);
	}
}
function zoomLayer(url, zoom) {
	try{
	var vectorSource = new ol.source.Vector({
		url: url,
		format: new ol.format.GeoJSON(),
		wrapX: false,
	});

	var vector = new ol.layer.Vector({
		source: vectorSource
	});


	map.addLayer(vector);
	vectorSource.once('change', function(e) {
		if (vectorSource.getState() === 'ready') {
			if (vector.getSource().getFeatures().length > 0) {
				if (vectorSource.getExtent()[0] != "Infinity") {
					ol.proj.proj4.register(proj4);
					//console.log(vectorSource);
					var ext = new ol.proj.transformExtent(vectorSource.getExtent(), ol.proj.get('EPSG:32645'), ol.proj.get('EPSG:4326'));
					//console.log(ext);
					var center = new ol.extent.getCenter(ext);
					if (Math.floor(center[0]) >= 88) {
						ext = new ol.proj.transformExtent(vectorSource.getExtent(), ol.proj.get('EPSG:32644'), ol.proj.get('EPSG:4326'));
						center = new ol.extent.getCenter(ext);
					}
					map.setView(new ol.View({
						center: ol.proj.fromLonLat([center[0], center[1]]),//zoom to the center of your feature
						zoom: zoom //here you define the levelof zoom
					}));
					vector.setVisible(false);
				}
				else {
					alert("Data not available..")
				}

				//var ext =new  ol.proj.transformExtent(vectorSource.getExtent(), ol.proj.get('EPSG:4326'), ol.proj.get('EPSG:32645'));
				// map.getView().fit(ext,map.getSize());
			}
		}
	});
	}
	catch(exception)
	{
		console.log(exception);
	}
}

