/* 
Objective: Draw Polygon 
Status: ongoing
*/
var nfb_layer;
var dlc_layer;
var rev_layer;
// DRAW INTERACTION
var drawSource = new ol.source.Vector()
var dtnfb, dtrev, dtdlc, dtdeemed, dtdiverted, distArr = [], divArr = [], tahasilArr = [], rangeArr = [];
var drawLayer = new ol.layer.Vector({
	source: drawSource,
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
	})
});


var draw = new ol.interaction.Draw({
	source: drawSource,
	type: 'Polygon',
	minPoints: 4,
	freehand: true
	// condition : function (mapBrowserEvent) {
	//   return ol.events.condition.click(mapBrowserEvent) && ol.events.condition.altKeyOnly(mapBrowserEvent);
	//}

});
map.addLayer(drawLayer);
var area_m = drawLayer
var polygonsource = new ol.source.Vector({ wrapX: false });
//var parser = new ol.format.WMSGetFeatureInfo();

var highlightOverlay = new ol.layer.Vector({
	// style: (customize your highlight style here),
	source: drawSource,
});
var polygonLayer = new ol.layer.Vector({
	source: polygonsource,
	style: new ol.style.Style({
		stroke: new ol.style.Stroke({
			color: '#ffcc33',
			width: 2,
		}),
	})
});

//var selectClick = new ol.interaction.Select({
//  /* condition: new ol.events.condition.click, */
//});

map.addLayer(highlightOverlay);
map.addLayer(polygonLayer);



$("#link_Draw").on('click', function(e) {
	map.addInteraction(draw);
});

draw.on('drawend', function(evt) {
	map.removeInteraction(draw);
})

$("#lnkResetDrawAoi").on('click', function(e) {
	drawSource.clear();
	map.removeInteraction(draw);
});




/* End of Add Polygon */


/*
Objective: Upload KML FIle 
Status: ongoing
*/

$("#link_Upload").on('click', function(e) {
	e.preventDefault();
	map.removeLayer(kmlLayer);
	map.removeLayer(polygonDraw);
	map.removeInteraction(polygonDraw);
	polygonLayer.getSource().clear();
	$("#upload:hidden").trigger('click');
	// console.log($("#upload:hidden").files[0]);

});


//Draw Polygon
function addPolygonInteraction() {

	$("#btnClearArea").trigger("click");

	polygonDraw = new ol.interaction.Draw({
		source: polygonsource,
		type: 'Polygon',
	});
	map.addInteraction(polygonDraw);
	polygonDraw.on('drawend', function() {
		map.removeInteraction(polygonDraw);
	});
}
//End of Draw Polygon

/*Upload .kml file Change Event*/
$('input[type=file]').change(function() {
	$("#layerTab").hide();
	$('#txtbuffer').val('');
	document.getElementById('aoiDiv').style.display = 'none';
	document.getElementById('queryBtn').style.display = 'none';
	document.getElementById('queryContent').style.display = 'none';
	map.removeLayer(polygonDraw);
	map.removeInteraction(polygonDraw);
	polygonsource.clear();
	source.clear();
	removeAllLayers();
	if ($("#kml-tab").hasClass("active")) {
		/*if (this.files[0] && this.files[0]['type'].includes('.kml')) 
		{*/
		if (validateKMLFile()) {
			//console.log(this.files[0]['type'].includes('.kml'));
			polygonsource.clear();

			var reader = new FileReader();

			reader.onload = function() {
				polygonsource = new ol.source.Vector({
					url: reader.result,
					format: new ol.format.KML({
						extractStyles: true,
						extractAttributes: true,
						maxDepth: 2
					})
				});

				kmlLayer = new ol.layer.Vector({
					source: polygonsource
				});


				map.addLayer(kmlLayer);
				//console.log(polygonsource.getFeatures().length);
				var listenerKey = polygonsource.on('change', function(e) {
					if (polygonsource.getState() == 'ready') {
						var featureCount = polygonsource.getFeatures().length;

						ol.Observable.unByKey(listenerKey);
						if (featureCount == 0) {
							alert("Invalid kml file");
							$("#upldkml").val('');
						}
						// use vectorSource.unByKey(listenerKey) instead
						// if you do use the "master" branch of ol3
					}
					// alert("Your query returned "+ featureCount + " results."); 

				});

			}
			reader.readAsDataURL(this.files[0]);
		}
		else {
			alert("Please upload Valid KML File");
			$('#upldkml').val('');
		}
	}
	else if ($("#shp-tab").hasClass("active")) {

	}

	else {


		//console.log("hiii");
		if (validate()) {
			var file = this.files[0];
			coordinates = [];
			readFile(file);
		}





	}
});
function readFile(file) {

	//console.log(file);
	var reader = new FileReader();

	reader.onload = function(e) {
		var data = e.target.result;
		var workbook = XLSX.read(data, {
			type: 'binary'
		});

		workbook.SheetNames.forEach(function(sheetName) {
			// Here is your object
			var XL_row_object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
			var json_object = JSON.stringify(XL_row_object);
			console.log(json_object);
			console.log(XL_row_object);
			console.log(Object.keys(XL_row_object));
			coordinates = XL_row_object;
			console.log(coordinates.length);
			if (coordinates.length > 0) {
				if (coordinates[0]["Lat"] != undefined && coordinates[0]["Long"] != undefined) {
					if (coordinates.length > 2) {
						createPolygonfromCoordinate();
					}
					else {
						alert("There must be 3 points to create a geometry.Kindly update your file.");
						$("#upldfile").val("");
						return false;
					}

				}
				else {
					alert("Please upload coordinates file in given format. Click on Excel Icon to Download the file format");
					$("#upldfile").val("");
					return false;
				}

			}
			else {
				alert("Upload file should not be blank. Click on Excel Icon to Download the file format");
				$("#upldfile").val("");
				return false;
			}
		})

	};

	reader.onerror = function(ex) {
		console.log(ex);
	};

	reader.readAsBinaryString(file);

}
function createPolygonfromCoordinate() {
	var lines = [];
	var latlon = [];
	let status = true;
	polygonsource.clear();
	$.each(coordinates, function(a, b) {
		if (isNaN(parseFloat(b.Long)) || isNaN(parseFloat(b.Lat))) {
			alert("Invalid point coordinate at line no. " + (a + 2));
			$("#upldfile").val("");
			status = false;
			return status;
		} else {
			if (a != coordinates.length - 1) {
				if (coordinates[a]["Lat"] == coordinates[a + 1]["Lat"]) {
					alert("Randomly Same Coordinate found in line no " + (a + 2));
					$("#upldfile").val("");
					status = false;
					return status;
				}
				else {
					latlon = [parseFloat(b.Long), parseFloat(b.Lat)];
					lines.push(latlon);
				}

			}

		}
	});
	if (status == false) {
		return;
	}
	if (lines.length > 0) {
		var firstItem = lines[0];
		var lastItem = lines[lines.length - 1];
		if (firstItem != lastItem) {
			lines.push(firstItem);
		}
	}
	//console.log("ok");
	var polygon = new ol.geom.Polygon([lines]);
	polygon.transform('EPSG:4326', 'EPSG:3857');
	var polyfeature = new ol.Feature(polygon);

	polygonsource.addFeature(polyfeature);

	// Create vector layer attached to the vector source.

	polyvectorLayer = new ol.layer.Vector({
		source: polygonsource
	});

	map.addLayer(polyvectorLayer);
	//var extent = polyvectorLayer.getSource().getExtent();
	//map.getView().fit(extent, map.getSize());
}

//AOI Analysis
var ageometry;
function AoiAnalysis() {
	var geom = [];
	polygonsource.forEachFeature(function(feature) { geom.push(new ol.Feature(feature.getGeometry().clone().transform('EPSG:3857', 'EPSG:4326'))); });
	var writer = new ol.format.GeoJSON();
	var geoJsonStr = writer.writeFeatures(geom);
	var geoJsonObj = JSON.parse(geoJsonStr);
	var ageom = geoJsonObj["features"][0]["geometry"];
	ageometry = JSON.stringify(ageom);
	//console.log(geoJsonObj);
	//console.log(ageometry);
	let coordinateList = ageom["coordinates"][0];
	let tblrow = "";
	let cnt = 0;
	$(".tCoordinates").html("");
	coordinateList.forEach(function(data) {
		cnt = cnt + 1;
		console.log(data);
		tblrow += "<tr>";
		tblrow += "<td>" + cnt + "</td>";
		tblrow += "<td>" + data[0] + "</td>";
		tblrow += "<td>" + data[1] + "</td>";
		tblrow += "</tr>";
	});
	$(".tCoordinates").html(tblrow);

}

//POI Analysis
var pgeometry;
function PoiAnalysis() {
	var geom = [];
	vectorSource1.forEachFeature(function(feature) { geom.push(new ol.Feature(feature.getGeometry().clone().transform('EPSG:3857', 'EPSG:4326'))); });
	var writer = new ol.format.GeoJSON();
	var geoJsonStr = writer.writeFeatures(geom);
	//console.log(geoJsonStr);
	var geoJsonObj = JSON.parse(geoJsonStr);
	//console.log(geoJsonObj);
	var pgeom = geoJsonObj["features"][0]["geometry"];
	console.log(pgeom);
	pgeometry = JSON.stringify(pgeom);

	// console.log(pgeometry);
}
//for POI
function downloadPOIkml() {
	//alert("olp")
	var geomkml = [];
	vectorSource1.forEachFeature(function(feature) {
		geomkml.push(new ol.Feature(feature.getGeometry().clone().transform('EPSG:3857', 'EPSG:4326')));

	});
	var node = new ol.format.KML({
		'maxDepth': 10,
		'extractStyles': true
	}).writeFeaturesNode(geomkml);
	var string = "";
	string = new XMLSerializer().serializeToString(
                    /** @type {Node} */(node));
	var str = (new XMLSerializer).serializeToString(node);
	var blob = new Blob([str], { type: "application/vnd.google-earth.kml+xml;charset=utf-8;" });
	console.log(blob);
	saveAs(blob, "Data.kml");

}
//for AOI
function downloadAOIkml() {
	console.log(nfb_layer);
	//alert("olp1")
	var geomkmlpoly = [];
	polygonsource.forEachFeature(function(feature) {
		var clonedraw = feature.clone();
		let drawstyle1 = new ol.style.Style({

			stroke: new ol.style.Stroke({
				color: 'rgba(0, 0, 0)',
				width: 1,
				// opacity:0
			}),

		});
		clonedraw.setStyle(drawstyle1);
		clonedraw.getGeometry().transform('EPSG:3857', 'EPSG:4326');
		geomkmlpoly.push(clonedraw);

	});
	
	//NFB
	let cmv_text1 = nfb_layer.getSource().getFeatures()[0].get('fb_name');
	let fbStyle1 = new ol.style.Style({
		fill: new ol.style.Fill({
			color: '#28a745',
			opacity: 0
		}),
		stroke: new ol.style.Stroke({
			color: 'rgba(0, 0, 0)',
			width: 1,
			// opacity:0
		}),
		text: new ol.style.Text({
			font: 'bold 12px italic Normal',
			fill: new ol.style.Fill({ color: '#000000' }),
			stroke: new ol.style.Stroke({
				color: '#fff', width: 2
			}),
			textAlign: 'top',
			textBaseline: 'bottom',
			text: cmv_text1
		})
	});
	
	//Revenue
	//let rf_text1=String(feature.get('plot_no'));	
	 let rfStyle1= new ol.style.Style({
      fill: new ol.style.Fill({
        //color: '#C7EAB0',
        color: '#ffc107',
        opacity:0
      }),
       stroke: new ol.style.Stroke({
          color: '#00FFFFFF',
          width: 0.5,
          opacity:0
        }),
         text: new ol.style.Text({
            font: 'bold 12px Ariel Normal',
            fill: new ol.style.Fill({ color: '#000000' }),
 			 stroke: new ol.style.Stroke({
			    color: '#fff', width: 2
			}),
            textAlign: 'top',
            textBaseline: 'bottom',
            text:rf_textlevel
            })
    });
    
    //DLC
    //let dlc_text1=String(feature.get('plot_no'));
    //let dlc_text1 = dlc_layer.getSource().getFeatures()[0].get('plot_no');
    let dlcStyle1= new ol.style.Style({
	       fill: new ol.style.Fill({
	         //color: '#C2FC9B',
	          color: '#007bff',
	         opacity:1
	       }),
	        stroke: new ol.style.Stroke({
	           color: '#00FFFFFF',
	           width: 0.5,
	           opacity:1
	         }),
	          text: new ol.style.Text({
	             font: 'bold 12px Ariel Normal',
	             fill: new ol.style.Fill({ color: '#000000' }),
	  			 stroke: new ol.style.Stroke({
	 			    color: '#fff', width: 2
	 			}),
	             textAlign: 'top',
	             textBaseline: 'bottom',
	             text:dlc_plotlevel
	             })
	     });
	     
	 //NFB
    var clonenfb;
    for(var i=0;i<nfb_layer.getSource().getFeatures().length;i++)
    {
	clonenfb = nfb_layer.getSource().getFeatures()[i].clone();
	clonenfb.setProperties({"name": cmv_text1,"FB Name":cmv_text1});
	clonenfb.setStyle(fbStyle1);
	clonenfb.getGeometry().transform('EPSG:3857', 'EPSG:4326');
	geomkmlpoly.push(clonenfb);
    }
	 
	//revenue
	var clonerf;
	var rf_textlevel;
	for(var i=0;i<rev_layer.getSource().getFeatures().length;i++)
    {
	 rf_textlevel= rev_layer.getSource().getFeatures()[i].get('plot_no');
	 clonerf = rev_layer.getSource().getFeatures()[i].clone();
	 clonerf.setStyle(rfStyle1);
	 clonerf.setProperties({ "name": rf_textlevel ,"Plot No:":rf_textlevel});
	 clonerf.getGeometry().transform('EPSG:3857', 'EPSG:4326');
	geomkmlpoly.push(clonerf);
    }
	
	//DLC
	var clonedlc;
	var dlc_plotlevel;
	for(var i=0;i<dlc_layer.getSource().getFeatures().length;i++){
		clonedlc = dlc_layer.getSource().getFeatures()[i].clone();
		dlc_plotlevel= dlc_layer.getSource().getFeatures()[i].get('plot_no');
	    clonedlc.setStyle(dlcStyle1);
	    clonedlc.setProperties({ "name": dlc_plotlevel ,"Plot No:":dlc_plotlevel});
		clonedlc.getGeometry().transform('EPSG:3857', 'EPSG:4326');
	geomkmlpoly.push(clonedlc);
	}	
	// nfb_layer.getSource().getFeatures()[0].setStyle(fbStyle1)
	//geomkmlpoly.push(clonenfb);
	//geomkmlpoly.push(clonerf);
	//geomkmlpoly.push(clonedlc);
	//console.log(geomkmlpoly)
	var node = new ol.format.KML({
		'maxDepth': 10,
		'extractStyles': false,
		'writeStyles': true,

	}).writeFeaturesNode(geomkmlpoly);
	var string = "";
	string = new XMLSerializer().serializeToString(
                    /** @type {Node} */(node));
	var str = (new XMLSerializer).serializeToString(node);
	var blob = new Blob([str], { type: "application/vnd.google-earth.kml+xml;charset=utf-8;" });
	//console.log(blob);
	saveAs(blob, "Data.kml");

}
//get geom for poi
function getPOIGeom() {
	var poigeometry = pgeometry;
	//$(".apploader-base").css("display", "block");
	//console.log(poigeometry);
	$.ajax({
		async: false,
		url: '/getPOIGeom',
		data: { 'geom': poigeometry },
		contentType: "application/json; charset=utf-8",
		type: 'GET',
		dataType: "html",

		success: function(result) {
			// console.log(result);
			var jresult = JSON.parse(result);
			//console.log(jresult);
			$(".sp_poianalysis").text("");
			//console.log($("#latitude").val());
			$("#sp_lat").text(parseFloat($("#latitude").val()).toFixed(6));
			$("#sp_lon").text(parseFloat($("#longitude").val()).toFixed(6));
			if (jresult.length > 0) {
				const keys = Object.keys(jresult[0]);
				for (let i = 0; i < keys.length; i++) {
					const key = keys[i];
					$("#sp_" + key).text(jresult[0][key]);
					//console.log(key,jresult[0][key]);
				}
				document.getElementById('queryBtn').style.display = 'block';
				if ($('#queryContent').css('display') == 'none') {
					$("#queryBtn").trigger("click");
				}
			}
			else {
				viewNotification(13);
				//vectorSource1.clear();
				document.getElementById('queryBtn').style.display = 'none';
			}
			//$(".apploader-base").css("display", "none");
		},
		error: function(errormessage) {
			alert(errormessage.responseText);
			$(".apploader-base").css("display", "none");
		}
	});
}
//get geom for drawn AOI area
function getAOIGeom() {
	var aoigeometry = ageometry;
	var _data = JSON.stringify({
		'geom': ageometry, 'bgeom': bgeometry
	});
	$(".apploader-base").css("display", "block");
	$.ajax({
		async: false,
		url: '/getAOIGeom',
		data: _data,
		contentType: "application/json; charset=utf-8",
		type: 'POST',
		dataType: "html",

		success: function(result) {
			//console.log(result);
			var jresult = JSON.parse(result);
			//console.log(jresult);

			if (jresult.length > 0) {
				const keys = Object.keys(jresult[0]);
				for (let i = 0; i < keys.length; i++) {

					const key = keys[i];
					//const myArray23 = jresult[0][key].toString().split(",");
					//console.log(myArray23);
					$("#sp_" + key).text(jresult[0][key]);
					$("#sp_" + key + "1").text(jresult[0][key]);
					//console.log("gggggg"+jresult[0][key]);
				}
				//console.log("keys"+keys[14]);
				document.getElementById('queryBtn').style.display = 'block';
				if ($('#queryContent').css('display') == 'none') {
					$("#queryBtn").trigger("click");
				}
			}
			else {
				viewNotification(13);
				document.getElementById('queryBtn').style.display = 'none';
			}
			//  $(".apploader-base").css("display", "none");
		},
		error: function(errormessage) {
			$(".apploader-base").css("display", "none");
			alert(errormessage.responseText);

		}
	});
}

//get AOI Analysis Report
var did = 0;
var distid = 0;
function getAOIAnalysis() {
	//$(".apploader-base").css("display", "block"); 
	var _data = JSON.stringify({
		'geom': ageometry, 'bgeom': bgeometry
	});
	//console.log(_data);
	$.ajax({
		async: false,
		url: '/getAOIAnalysis',
		data: _data,
		contentType: "application/json; charset=utf-8",
		type: 'POST',
		dataType: "html",

		success: function(result) {
			$("#layerTab").show();
			//$(".apploader-base").css("display", "block"); 
			//console.log(result);
			var aoiData = JSON.parse(result);
			//console.log(aoiData);
			var nfbData = aoiData.filter(function(item) {
				return item.forest_type === 'NFB';
			});
			var revData = aoiData.filter(function(item) {
				return item.forest_type === 'REV';
			});
			var dlcData = aoiData.filter(function(item) {
				return item.forest_type === 'DLC';
			});


			let layerinfo = "";
			let i = 0, j = 0, k = 0;
			checknfbDataTable();
			checkrevDataTable();
			checkdlcDataTable();
			checksancDataTable();
			checkeszDataTable();
			//checkdeemedDataTable();
			//checkdivertedDataTable();
			let nfbArr = [], revArr = [], dlcArr = [];
			let nfbrow = "";
			let revrow = "";
			let dlcrow = "";
			nfbData.forEach(function(data) {
				i++;
				let tmpnfb = [i, data.div_name, data.range_name, data.fb_name, data.fb_type, data.nfb_area_ha];
				nfbArr.push(tmpnfb);
				nfbrow += "<tr>";
				nfbrow += "<td>" + i + "</td>";
				nfbrow += "<td>" + data.div_name + "</td>";
				nfbrow += "<td>" + data.range_name + "</td>";
				nfbrow += "<td>" + data.fb_name + "</td>";
				nfbrow += "<td>" + data.fb_type + "</td>";
				nfbrow += "<td>" + data.nfb_area_ha + "</td>";
				nfbrow += "</tr>";
				if (data.dist_id != null && data.dist_id != '' && !distArr.includes(data.dist_id)) {
					distArr.push(data.dist_id);

				}
				if (data.div_id != null && data.div_id != '' && !divArr.includes(data.div_id)) {
					divArr.push(data.div_id);

				}

				if (data.range_code != null && data.range_code != '' && !rangeArr.includes(data.range_code)) {
					rangeArr.push(data.range_code);

				}

				if (i == nfbData.length) {
					dtnfb.rows.add(nfbArr).draw();
					$(".tbodynfb").html(nfbrow);
				}

				did = data.div_id;
			});
			//console.log(did);
			revData.forEach(function(data) {
				j++;
				let tmprev = [j, data.tahasil, data.village, data.khata_no, data.plot_no, data.plot_area_actual, data.plot_area_ac, data.kissam, data.land_class];
				revArr.push(tmprev);
				revrow += "<tr>";
				revrow += "<td>" + j + "</td>";
				//revrow+="<td>"+data.dist_name+"</td>";
				revrow += "<td>" + data.tahasil + "</td>";
				revrow += "<td>" + data.village + "</td>";
				revrow += "<td>" + data.khata_no + "</td>";
				revrow += "<td>" + data.plot_no + "</td>";
				revrow += "<td>" + data.plot_area_actual + "</td>";
				revrow += "<td>" + data.plot_area_ac + "</td>";
				revrow += "<td>" + data.kissam + "</td>";
				revrow += "<td>" + data.land_class + "</td>";
				revrow += "</tr>";
				if (data.dist_id != null && data.dist_id != '' && !distArr.includes(data.dist_id)) {
					distArr.push(data.dist_id);

				}
				if (data.div_id != null && data.div_id != '' && !divArr.includes(data.div_id)) {
					divArr.push(data.div_id);

				}
				if (data.tah_id != null && data.tah_id != '' && !tahasilArr.includes(data.tah_id)) {
					tahasilArr.push(data.tah_id);

				}
				if (j == revData.length) {
					dtrev.rows.add(revArr).draw();
					$(".tbodyrev").html(revrow);
				}
				distid = data.dist_id;

			});
			dlcData.forEach(function(data) {
				k++;
				let tmpdlc = [k, data.tahasil, data.village, data.khata_no, data.plot_no, data.plot_area_actual, data.plot_area_ac, data.kissam, data.land_class];
				dlcArr.push(tmpdlc);
				dlcrow += "<tr>";
				dlcrow += "<td>" + k + "</td>";
				/*dlcrow+="<td>"+data.dist_name+"</td>";*/
				dlcrow += "<td>" + data.tahasil + "</td>";
				dlcrow += "<td>" + data.village + "</td>";
				dlcrow += "<td>" + data.khata_no + "</td>";
				dlcrow += "<td>" + data.plot_no + "</td>";
				dlcrow += "<td>" + data.plot_area_actual + "</td>";
				dlcrow += "<td>" + data.plot_area_ac + "</td>";
				dlcrow += "<td>" + data.kissam + "</td>";
				dlcrow += "<td>" + data.land_class + "</td>";
				dlcrow += "</tr>";
				if (data.dist_id != null && data.dist_id != '' && !distArr.includes(data.dist_id)) {
					distArr.push(data.dist_id);

				}
				if (data.div_id != null && data.div_id != '' && !divArr.includes(data.div_id)) {
					divArr.push(data.div_id);

				}
				if (data.tah_id != null && data.tah_id != '' && !tahasilArr.includes(data.tah_id)) {
					tahasilArr.push(data.tah_id);

				}
				if (k == dlcData.length) {
					dtdlc.rows.add(dlcArr).draw();
					$(".tbodydlc").html(dlcrow);
				}
			});

			//NFB Layer
			var jsonNfbObj = {};
			var Nfbarr = [];
			nfbData.forEach(function(data1) {

				var jsonNfbData = {};
				jsonNfbData["geometry"] = JSON.parse(data1.geom);
				jsonNfbData["type"] = "Feature";
				let nfbProp = JSON.parse(JSON.stringify(data1))
				delete nfbProp['geom'];
				jsonNfbData["properties"] = nfbProp;
				Nfbarr.push(jsonNfbData);
			});
			jsonNfbObj["features"] = Nfbarr;
			jsonNfbObj["type"] = "FeatureCollection";
			ol.proj.proj4.register(proj4);
			var format = new ol.format.GeoJSON({
				projection: 'EPSG:3857'
			});
			var nfbSource = new ol.source.Vector({
				features: format.readFeatures(jsonNfbObj, {
					dataProjection: new ol.proj.get('EPSG:4326'),
					featureProjection: new ol.proj.get('EPSG:3857')
				}),
				wrapX: false,
				crossOrigin: 'anonymous'
			});
			//console.log(jsonNfbObj);
			nfb_layer = new ol.layer.Vector({
				source: nfbSource,
				style: nfb_style,
				title: 'nfbLayer'
			});
			map.addLayer(nfb_layer);

			nfb_layer.setVisible(true);
			$("#chkNf").prop('checked', true);


			//DLC Layer
			var jsonDlcObj = {};
			var Dlcarr = [];
			dlcData.forEach(function(data2) {

				var jsonDlcObj = {};
				jsonDlcObj["geometry"] = JSON.parse(data2.geom);
				jsonDlcObj["type"] = "Feature";
				let dlcProp = JSON.parse(JSON.stringify(data2))
				delete dlcProp['geom'];
				jsonDlcObj["properties"] = dlcProp;
				Dlcarr.push(jsonDlcObj);
			});
			jsonDlcObj["features"] = Dlcarr;
			jsonDlcObj["type"] = "FeatureCollection";
			ol.proj.proj4.register(proj4);
			var format = new ol.format.GeoJSON({
				projection: 'EPSG:3857'
			});
			var dlcSource = new ol.source.Vector({
				features: format.readFeatures(jsonDlcObj, {
					dataProjection: new ol.proj.get('EPSG:4326'),
					featureProjection: new ol.proj.get('EPSG:3857')
				}),
				wrapX: false,
				crossOrigin: 'anonymous'
			});

			dlc_layer = new ol.layer.Vector({
				source: dlcSource,
				style: dlc_style,
				title: 'ooo_Layer'
			});
			map.addLayer(dlc_layer);

			dlc_layer.setVisible(true);
			$("#chkDlc").prop('checked', true);


			//Revenue Layer
			var jsonRevObj = {};
			var Revarr = [];
			revData.forEach(function(data3) {

				var jsonRevObj = {};
				jsonRevObj["geometry"] = JSON.parse(data3.geom);
				jsonRevObj["type"] = "Feature";
				let revProp = JSON.parse(JSON.stringify(data3))
				delete revProp['geom'];
				jsonRevObj["properties"] = revProp;
				Revarr.push(jsonRevObj);
			});
			jsonRevObj["features"] = Revarr;
			jsonRevObj["type"] = "FeatureCollection";
			ol.proj.proj4.register(proj4);
			var format = new ol.format.GeoJSON({
				projection: 'EPSG:3857'
			});
			var revSource = new ol.source.Vector({
				features: format.readFeatures(jsonRevObj, {
					dataProjection: new ol.proj.get('EPSG:4326'),
					featureProjection: new ol.proj.get('EPSG:3857')
				}),
				wrapX: false,
				crossOrigin: 'anonymous'
			});

			rev_layer = new ol.layer.Vector({
				source: revSource,
				style: rf_style,
				title: 'revLayer'
			});
			map.addLayer(rev_layer);
			rev_layer.setVisible(true);
			$("#chkRev").prop('checked', true);
			$(".apploader-base").css("display", "none");
			loadImageMap();
		},
		error: function(errormessage) {
			$(".apploader-base").css("display", "none");
			alert(errormessage.responseText);
		}
	});
}


var bgeometry;

function AoiBufferAnalysis() {

	var bgeom = [];
	const parser = new jsts.io.OL3Parser();
	polygonsource.forEachFeature(function(feature) {
		var featur1 = new ol.Feature(feature.getGeometry());
		const jstsGeom = parser.read(featur1.getGeometry());
		const buffered = jstsGeom.buffer(parseInt($("#txtbuffer").val()) * 1000);
		featur1.setGeometry(parser.write(buffered));
		bgeom.push(new ol.Feature(featur1.getGeometry().clone().transform('EPSG:3857', 'EPSG:4326')));
		source.addFeature(featur1);
	});
	const vcl = new ol.layer.Vector({
		source: source,
	});
	map.addLayer(vcl);
	vcl.setVisible(true);
	var extent1 = vcl.getSource().getExtent();
	map.getView().fit(extent1, map.getSize());


	var writer = new ol.format.GeoJSON();
	var bgeoJsonStr = writer.writeFeatures(bgeom);
	var bgeoJsonObj = JSON.parse(bgeoJsonStr);
	var buffergeom = bgeoJsonObj["features"][0]["geometry"];
	bgeometry = JSON.stringify(buffergeom);
}

function checknfbDataTable() {
	if ($.fn.DataTable.isDataTable('#tblnfb1')) {
		$("#tblnfb1").dataTable().fnClearTable();
		$("#tblnfb1").dataTable().fnDestroy();
	}

	dtnfb = $('#tblnfb1').DataTable({
		"oLanguage": {
			"oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
			"sInfo": "Showing page _PAGE_ of _PAGES_",
			"sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
			"sSearchPlaceholder": "Search...",
			"sLengthMenu": "Results :  _MENU_",
		},
		"pageLength": 5,
		"lengthChange": false,
		searching: false,
		info: false
	});

}

function checkrevDataTable() {
	if ($.fn.DataTable.isDataTable('#tblrev1')) {
		$("#tblrev1").dataTable().fnClearTable();
		$("#tblrev1").dataTable().fnDestroy();
	}

	dtrev = $('#tblrev1').DataTable({
		"oLanguage": {
			"oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
			"sInfo": "Showing page _PAGE_ of _PAGES_",
			"sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
			"sSearchPlaceholder": "Search...",
			"sLengthMenu": "Results :  _MENU_",
		},
		"pageLength": 5,
		"lengthChange": false,
		searching: false,
		info: false
	});
}
function checkdlcDataTable() {
	if ($.fn.DataTable.isDataTable('#tbldlc1')) {
		$("#tbldlc1").dataTable().fnClearTable();
		$("#tbldlc1").dataTable().fnDestroy();
	}

	dtdlc = $('#tbldlc1').DataTable({
		"oLanguage": {
			"oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
			"sInfo": "Showing page _PAGE_ of _PAGES_",
			"sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
			"sSearchPlaceholder": "Search...",
			"sLengthMenu": "Results :  _MENU_",
		},
		"pageLength": 5,
		"lengthChange": false,
		searching: false,
		info: false
	});

}
function checksancDataTable() {
	if ($.fn.DataTable.isDataTable('#tblsanc')) {
		$("#tblsanc").dataTable().fnClearTable();
		$("#tblsanc").dataTable().fnDestroy();
	}

	dtsanc = $('#tblsanc').DataTable({
		"oLanguage": {
			"oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
			"sInfo": "Showing page _PAGE_ of _PAGES_",
			"sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
			"sSearchPlaceholder": "Search...",
			"sLengthMenu": "Results :  _MENU_",
		},
		"pageLength": 5,
		"lengthChange": false,
		searching: false,
		info: false
	});
}
function checkeszDataTable() {
	if ($.fn.DataTable.isDataTable('#tblesz')) {
		$("#tblesz").dataTable().fnClearTable();
		$("#tblesz").dataTable().fnDestroy();
	}

	dtesz = $('#tblesz').DataTable({
		"oLanguage": {
			"oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
			"sInfo": "Showing page _PAGE_ of _PAGES_",
			"sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
			"sSearchPlaceholder": "Search...",
			"sLengthMenu": "Results :  _MENU_",
		},
		"pageLength": 5,
		"lengthChange": false,
		searching: false,
		info: false
	});
}
/*function checkdeemedDataTable()
{
	if ( $.fn.DataTable.isDataTable('#tbldeemed') ) {
		$("#tbldeemed").dataTable().fnClearTable();
		$("#tbldeemed").dataTable().fnDestroy();
	}

		dtdeemed= $('#tbldeemed').DataTable({
			"oLanguage": {
				"oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
				"sInfo": "Showing page _PAGE_ of _PAGES_",
				"sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
				"sSearchPlaceholder": "Search...",
			   "sLengthMenu": "Results :  _MENU_",
			},
			  "pageLength": 5,
			"lengthChange": false,
			searching: false,
			  info: false
		});
}
function checkdivertedDataTable()
{
	if ( $.fn.DataTable.isDataTable('#tbldeemed') ) {
		$("#tbldiverted").dataTable().fnClearTable();
		$("#tbldiverted").dataTable().fnDestroy();
	}

		dtdiverted= $('#tbldiverted').DataTable({
			"oLanguage": {
				"oPaginate": { "sPrevious": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-left"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>', "sNext": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-right"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>' },
				"sInfo": "Showing page _PAGE_ of _PAGES_",
				"sSearch": '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
				"sSearchPlaceholder": "Search...",
			   "sLengthMenu": "Results :  _MENU_",
			},
			  "pageLength": 5,
			"lengthChange": false,
			searching: false,
			  info: false
		});
}*/
function loadImageMap() {
	map.once('rendercomplete', function() {
		let mapCanvas = document.createElement('canvas');
		let size = map.getSize();
		mapCanvas.width = size[0];
		mapCanvas.height = size[1];
		let mapContext = mapCanvas.getContext('2d');
		Array.prototype.forEach.call(
			document.querySelectorAll('.ol-layer canvas'),
			function(canvas) {
				if (canvas.width > 0) {
					let opacity = canvas.parentNode.style.opacity;
					mapContext.globalAlpha = opacity === '' ? 1 : Number(opacity);
					let transform = canvas.style.transform;
					mapContext.fillStyle = "#FFFFFF";
					mapContext.fillRect(0, 0, size[0], size[1]);
					// Get the transform parameters from the style's transform matrix
					var matrix = transform
						.match(/^matrix\(([^\(]*)\)$/)[1]
						.split(',')
						.map(Number);
					// Apply the transform to the export map context
					CanvasRenderingContext2D.prototype.setTransform.apply(
						mapContext,
						matrix
					);
					mapContext.drawImage(canvas, 0, 0);
				}
			}
		);


		setTimeout(function() {
			map.renderSync();
			let divmp = document.getElementById("imgMap");
			divmp.innerHTML = "";
			divmp.appendChild(mapCanvas);
		}, 3000);
		/* let divmp1 = document.getElementById("imgMap1");
		 divmp1.appendChild(mapCanvas);*/
	});

}				