
var village_layer,cmv_layer,mmv_layer,jvFnl_layer,dgpsdrft_layer,dgpsfnl_layer,revFrst_layer,dlcFnl_layer;
var  layerOrderList=[
	
	{"layer":"cmv_layer", "visibility":0,"minz":10.17,"maxz":14.27}];

var polygonDraw, kmlLayer;
var layersArray=new Array();

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


layersArray.push.apply(layersArray,[baselayer, raster, googleLayerStreet, googleLayerSatellite]);




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

var defaultLayer=new ol.layer.Tile({
    source: new ol.source.OSM()
  });
  
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
    	  url: geoserverUrl+'/FLI_DSS_DISTRICT/wms',          
          params: {
              'LAYERS': 'FLI_DSS_DISTRICT:DistrictBoundary',
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
    console.log('alldivboundarylayer: '+error);
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
    console.log('alldivboundarylayer: '+error);
  }

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
				    		console.log(paramdivision);
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
					                    	console.log(obj[0].text);
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
  			 



  			layersArray.push.apply(layersArray,[stateboundarylayer,districtboundarylayer,alldivboundarylayer,allrnglayer,alltehasillayer]);

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

zoomtoLayer();


function zoomtoLayer()
{
	alert("Zoom");
	try{
		
	
	if($("#drpfltype").val()=="1"){
		var jsonObj = {};
		var arr=[];
		//var cmvList=${layer};
		var cmvList=layers;
		alert('CMV List'+layers);
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
	       // map.addLayer(cmv_layer);
	        
 		//viewLayer($("input[id='chkCmv']"), "cmv_layer");
	      cmv_layer.setVisible(true);
	   map.getView().fit(cmv_layer.getSource().getExtent(), (map.getSize()));
	}
	/*else if($("#drpfltype").val()=="2"){
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
	}*/
	}
	catch(error)
	{
		alert("zomm to layer error");
	}
	
}


function viewLayer(checkbox,layerName)
{
	
	alert(layerName);
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

