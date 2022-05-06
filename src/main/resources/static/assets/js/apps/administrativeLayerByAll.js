var nfblayer;
var revlayer;
var dlclayer;
var defaultLayer=new ol.layer.Tile({
    source: new ol.source.OSM()
  });
  
   var stateboundarylayer=defaultLayer;
  try {
     stateboundarylayer = new ol.layer.Image({
      source: new ol.source.ImageWMS({
          url: geoserverUrl+'/FLI_DSS_STATE/wms', //https://geoserver.odishaforestlandsurvey.in/geoserver/CDLTP_State_District/wms',
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
      visible: false
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
  
  
//Remove AOI Analysis Layer
function removeAoiAnalysisLayer(layerName){
  console.log('Layer Name: '+layerName);
  var layersToRemove = [];
  map.getLayers().forEach(function (layer) {
      if (layer.get('title') != undefined && layer.get('title') === layerName) {
          layersToRemove.push(layer);
          console.log('Layer Match: '+layerName);
      }
  });
  
  var len = layersToRemove.length;
  for(var i = 0; i < len; i++) {
      map.removeLayer(layersToRemove[i]);
      //layersToRemove[i].setVisible(false);
  }
  
}

  //NFB Boundary  
  $("#rdonfb").on("click", function (e) {
    removeAoiAnalysisLayer('revlayer');
	   //nfblayer=defaultLayer;
	  //alert("nfb");
   		$.ajax({
  	           	url:'/Utility/getAllLayerList',
  	            data: {'type':28},
  	            type: "GET",
  	            contentType: "application/json;charset=utf-8",
  	            dataType: "json",
  	            success :function (obj) {
  	                   console.log(obj);
  	                    //console.log(obj.text);
  	                    if(obj!=null)
  	                    {	
  	                    	var myStringArray = obj;
  	                    	var arrayLength = obj.length;
  	                    	for (var i = 0; i < arrayLength; i++) 
  	                    	{   
  	                    	 var query="";
  	                    	 			 nfblayer= new ol.layer.Tile({
  	                                     source: new ol.source.TileWMS({
  	                                     url: obj[i].strValue,
  	                                     params: {
  	                                     'LAYERS': obj[i].text,
  	                                     'VERSION': '1.1.0',
  	                                     //'CQL_FILTER': query     
  	                                     },
  	                                     serverType: 'geoserver',
                                        
  	                                     }),
                                         title: 'nfblayer'  

  	                             }); 
                           if(nfblayer!=null)
                           {
                             map.addLayer(nfblayer);
                            if($("#rdonfb").is(":checked"))
                            {
                            	nfblayer.setVisible(true);
                            }
                            else
                            {
                            	nfblayer.setVisible(false);
                           	map.removeLayer(nfblayer);
                           	 
                            }
                                
                           }
                           else{
                               AlertNotify("NFB Boundary is not available.")
                           }
  	                    }
  	                  }  
  	                },
  	            error :function (xhr, status) 
  	            {
  	                    
  	            }
  	            });
  	 }); 
  //End of NFB
  //Revenue Boundary
  $("#rdoRev").on("click", function (e) {
   	
    removeAoiAnalysisLayer('nfblayer');
    if(nfblayer.length>0)
    {
      nfblayer.forEach(function(item){
            map.removeLayer(item);
        });
    }
    //revlayer=defaultLayer;
      //alert("rev");
      $.ajax({
                url:'/Utility/getAllLayerList',
               data: {'type':21},
               type: "GET",
               contentType: "application/json;charset=utf-8",
               dataType: "json",
               success :function (obj) {
                      console.log(obj);
                       //console.log(obj.text);
                       if(obj!=null)
                       {	
                         var myStringArray = obj;
                         var arrayLength = obj.length;
                         for (var i = 0; i < arrayLength; i++) 
                         {   
                          var query="";
                                 revlayer= new ol.layer.Tile({
                                        source: new ol.source.TileWMS({
                                        url: obj[i].strValue,
                                        params: {
                                        'LAYERS': obj[i].text,
                                        'VERSION': '1.1.0',
                                        //'CQL_FILTER': query     
                                        },
                                        serverType: 'geoserver'
                                        }),
                                        title: 'revlayer' 
                                }); 
                          if(revlayer!=null)
                          {
                            map.addLayer(revlayer);
                           if($("#rdoRev").is(":checked"))
                           {
                            revlayer.setVisible(true);
                           }
                           else
                           {
                            revlayer.setVisible(false);
                            map.removeLayer(revlayer);
                             
                           }
                               
                          }
                          else{
                              AlertNotify("Revenue Boundary is not available.")
                          }
                       }
                     }  
                   },
               error :function (xhr, status) 
               {
                       
               }
               });
    }); 
    //End of Revenue
    //DLC Boundary
  $("#rdoDLC").on("click", function (e) {
   	
    removeAoiAnalysisLayer('nfblayer');
    //dlclayer=defaultLayer;
      //alert("dlc");
      $.ajax({
                url:'/Utility/getAllLayerList',
               data: {'type':23},
               type: "GET",
               contentType: "application/json;charset=utf-8",
               dataType: "json",
               success :function (obj) {
                      console.log(obj);
                       //console.log(obj.text);
                       if(obj!=null)
                       {	
                         var myStringArray = obj;
                         var arrayLength = obj.length;
                         for (var i = 0; i < arrayLength; i++) 
                         {   
                          var query="";
                                  dlclayer= new ol.layer.Tile({
                                        source: new ol.source.TileWMS({
                                        url: obj[i].strValue,
                                        params: {
                                        'LAYERS': obj[i].text,
                                        'VERSION': '1.1.0',
                                        //'CQL_FILTER': query     
                                        },
                                        serverType: 'geoserver'
                                        }),
                                        title: 'dlclayer' 
                                }); 
                          if(dlclayer!=null)
                          {
                            map.addLayer(dlclayer);
                           if($("#rdoDLC").is(":checked"))
                           {
                            dlclayer.setVisible(true);
                           }
                           else
                           {
                            dlclayer.setVisible(false);
                            map.removeLayer(dlclayer);
                             
                           }
                               
                          }
                          else{
                              AlertNotify("DLC Boundary is not available.")
                          }
                       }
                     }  
                   },
               error :function (xhr, status) 
               {
                       
               }
               });
    }); 
    //End of DLC
  
layersArray.push.apply(layersArray,[stateboundarylayer, districtboundarylayer, alldivboundarylayer, allrnglayer, alltehasillayer]);

const layerGroup = new ol.layer.Group({
  layers: layersArray
})

map.addLayer(layerGroup);
var scaleline = new ol.Control.ScaleLine({bar:true,text:true,minWidth:140,steps:4});
map.addControl(scaleline);


