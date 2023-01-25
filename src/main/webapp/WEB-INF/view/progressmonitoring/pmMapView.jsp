<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%> 

<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css" type="text/css">

<tl:eval expression="@environment.getProperty('api.geoserverurl')" var="geoserverUrl"></tl:eval>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/css/ol.css">
	<!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <script src="https://cdn.polyfill.io/v3/polyfill.min.js?features=fetch,requestAnimationFrame,Element.prototype.classList,URL,TextDecoder"></script>
    <script src="https://unpkg.com/dom-to-image-more@2.8.0/dist/dom-to-image-more.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script src="https://unpkg.com/elm-pep"></script>
    
	<!-- <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script> -->
	<!-- <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.15.1/build/ol.js"></script> -->
	<script src="/cdnLinks/cdnOL.js"></script>

<style>
	/* .ol-scale-bar{
		right: 0;
		left: auto;
	} */
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
      .ol-scale-bar{
          right: 8px;
          left: auto;
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

<!--  BEGIN CONTENT AREA  -->
<div id="content" class="main-content">

	<div class="layout-px-spacing">

		<div class="row layout-top-spacing">
		
			<div class="col-md-3 layout-spacing">
                    <div class="statbox widget box box-shadow">                            
                        <div class="widget-content widget-content-area">
                        	
                        	<div id="accordion" class="mapFilter mapFilterBase2 fixHeightLeft">
                                <div class="map-tab-fix row m-0">
                                    <!-- <a id="" href="#collapseOne" class="text-dark col collapsed bs-tooltip" data-toggle="collapse" aria-expanded="true" aria-controls="collapseOne" title="Area of Interest">
                                        <span class="d-block"><img src="/assets/img/icon-filter.png"></span>
                                    </a> -->
									
                                    <a id="" href="#collapseTwo" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="true" aria-controls="collapseTwo" title="Layers">
                                        <span class="d-block"><img src="/assets/img/icon-layers.png"></span>
                                    </a>
                                    <a id="" href="#collapseFour" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseFour" title="Basemap">
                                        <span class="d-block"><img src="/assets/img/icon-basemap.png"></span>
                                    </a>
                                    <!-- <a id="" href="#collapseThree" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseThree" title="Legends">
                                        <span class="d-block"><img src="/assets/img/icon-legends.png"></span>
                                    </a>
                                    <a id="" href="#collapseFour" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseFour" title="Basemap">
                                        <span class="d-block"><img src="/assets/img/icon-basemap.png"></span>
                                    </a>
                                    <a id="a_measure" href="#collapseFive" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseFive" title="Measurement">
                                        <span class="d-block"><img src="/assets/img/icon-measurement.png"></span>
                                    </a>
                                    <a id="a_info" href="#collapseSix" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseSix" title="Info">
                                        <span class="d-block"><img src="/assets/img/icon-info.png"></span>
                                    </a>
                                    <a id="a_measure" href="#collapseSeven" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseSeven" title="Swipe">
                                        <span class="d-block"><img src="/assets/img/icon-swipe.png"></span>
                                    </a>
                                    <a id="a_reset" href="#collapseEight" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseEight" title="Reset">
                                        <span class="d-block"><img src="/assets/img/icon-reset.png"></span>
                                    </a>  -->                                   
                                </div>

                                <div class="clearfix"></div>

                                

                                <div class="mb-0">
                                    <div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordion">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="fixHeightRight">
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><span aria-hidden="true">ï¿½</span></button> -->
                                                    <div class="card-body custom-card-body">
                                                        <h6 class="mt-0 page-title mb-3">Layers</h6>
                                                        
                                                        <div id="accordion2">
                                                        	 <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                  <input type="checkbox" class="custom-control-input" id="chkJVBndry">
                                                                  <label class="custom-control-label" for="chkJVBndry">JV Boundary</label>
                                                                  <img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Angul_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Angul_vector:jv_certified_boundary" class="img-chk2" />                                                               
                                                             </div>
                                                             <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                  <input type="checkbox" class="custom-control-input" id="chkJV">
                                                                  <label class="custom-control-label" for="chkJV">JV Pillar</label>                                                    
                                                             </div>
                                                                <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                  <input type="checkbox" class="custom-control-input" id="chkDGPSBndry">
                                                                  <label class="custom-control-label" for="chkDGPSBndry">DGPS Boundary</label> 
                                                                  <img src="https://mapserver.odisha4kgeo.in/geoserver/FLI_DSS_Angul_vector/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&LAYER=FLI_DSS_Angul_vector:dgps_final_boundary" class="img-chk2" />                                                                 
                                                             </div>
                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                  <input type="checkbox" class="custom-control-input" id="chkDGPS">
                                                                  <label class="custom-control-label" for="chkDGPS">DGPS Pillar <img src="/assets/img/dot-orange.png"></label>
                                                                   <div>
                                                                  <label >Virtual Pillar <img src="/assets/img/dot-virtual.jpg"></label>                                                                                                                                 <div>
                                                                  <label >Existing Pillar <img src="/assets/img/dot-black.png"></label> <br>
                                                                  <label >Proposed Pillar <img src="/assets/img/dot-blue.png"></label> 
                                                                  </div>  
                                                                  </div>
                                                             </div>
                                                             <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2" style="display: none;" id="FPCPDiv" >
                                                                  <input type="checkbox" class="custom-control-input" value="" id="chkFPCP" >
                                                                  <label class="custom-control-label" for="chkFPCP">FPCP</label>
	                                                         </div>
                                                             <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2" style="display: none;" id="FSCPDiv" >
                                                                 <input type="checkbox" class="custom-control-input" value="" id="chkFSCP" >
                                                                 <label class="custom-control-label" for="chkFSCP">FSCP</label>
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
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour"><span aria-hidden="true">ï¿½</span></button> -->
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
                            </div>
                            <!--/accordion-->	
                        </div>
                        
                    </div>
                 </div>
                  <div class="col-md-9 layout-spacing">
                  <div id="map" class="fixHeightLeft panel"></div>
                  </div>
		</div>
	</div>
</div>
<!--  END CONTENT AREA  -->

<!-- Pop up div -->
<div id="popup" class="ol-popup">
    <a href="#" id="popup-closer" class="ol-popup-closer"></a>
    <div id="popup-content"></div>
</div>

<style>
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

<script type="text/javascript">
var geoserverUrl = '${geoserverUrl}';

</script>

<script>

//Base layer 
var baselayer = new ol.layer.Tile({
    source: new ol.source.OSM(),
    visible:true,
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


 var highlightOverlay =  new ol.layer.Vector({
  // style: (customize your highlight style here),
  source: source,
}); 
 var selectClick = new ol.interaction.Select({
	  /* condition: new ol.events.condition.click, */
	});

 var map = new ol.Map({
	    layers: [baselayer,raster,googleLayerStreet,googleLayerSatellite,highlightOverlay],
	    
	    target: 'map',
	    view: new ol.View({
	        center: ol.proj.fromLonLat([84.6525554,20.1664539]),
	        zoom: 6.89,
	        maxZoom: 20,
	        minZoom: 5
	    })
	});
 map.addInteraction(selectClick);
 
 
 var scaleLine = new ol.control.ScaleLine({bar: true, text: true, minWidth: 140,steps:4});
 map.addControl(scaleLine); 
   
 
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
 
   //End Base map click
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
	
  
	    //OverLay
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
    
	    var tstyle,arr=[],jv_boundary_layer,dgps_boundary_layer,jvpillarLayer,jvpoints=[],dgpspoints=[],fpcpPoints=[],fscpPoints=[],dgpspillarLayer;
		var jv_boundary_layer1=[];
		var dgps_boundary_layer1=[];
		var fb_id=${nfb_id};

	   //JV Boundary Layer
	    $("#chkJVBndry").on("click", function(event) {	
	    			//alert("jvbndry");    			
	    			if(!$("#chkJVBndry").is(":checked"))
	                {		
	    				map.removeLayer(eval(jv_boundary_layer));
	    				if(jv_boundary_layer1.length>0)
	  	              {
	    					jv_boundary_layer1.forEach(function(item){
	  	                      map.removeLayer(item);
	  	                  });
	  	              }
	    				   jv_boundary_layer.setVisible(false);
	                }
	                else
	                {
	                	if(fb_id!=0)
	    		    		{
	    			    		map.removeLayer(jv_boundary_layer);			    		
	    	    				jvbndryLayernm="";				    		
	    			    		$.ajax({
	    				           	url:'/Utility/getAllLayerList',
	    				            data: {'type':26},
	    				            type: "GET",
	    				            contentType: "application/json;charset=utf-8",
	    				            dataType: "json",
	    				            success :function (obj) {					                   
	    				                    if(obj!=null)
	    				                    {	
	    				                    	//console.log(obj);
	    				                    	var myStringArray = obj;
												var arrayLength = obj.length;
												for (var i = 0; i < arrayLength; i++) {
	    				                    	jvbndryLayernm=obj[i].text;
	    				                    	//alert(jvbndryLayernm)
	    				                    	 var query="";
	    			                             if(fb_id!=0)
	    			                             {				                                
	    			                                 query="fb_id="+fb_id;
	    			                                 //console.log(query);
	    			                             }
	    				                             if(query!="")
	    				                             {					                            						                            	 
	    				                            	 jv_boundary_layer= new ol.layer.Image({
	    				                                     source: new ol.source.ImageWMS({
	    				                                     url: obj[i].strValue,
	    				                                     params: {
	    				                                     'LAYERS': obj[i].text,
	    				                                     'VERSION': '1.1.0',
	    				                                     'CQL_FILTER': query     
	    				                                     },
	    				                                     serverType: 'geoserver'
	    				                                     })  
	    				                             });
	    			                             }
	    			                             else{
	    			                            	 jv_boundary_layer= new ol.layer.Image({
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
	    			                            if(jv_boundary_layer!=null)
	    			                            {
	    				                              //map.addLayer(jv_boundary_layer);
	    				                             
	    				                              if($("#chkJVBndry").is(":checked"))
	    				                             {
	    				                            	  jv_boundary_layer.setVisible(true);
		    				                              jv_boundary_layer1.push(jv_boundary_layer);
		    				                              if(i==arrayLength-1){
							                            		 if(jv_boundary_layer1.length>0)
								                                 {
							                            			 jv_boundary_layer1.forEach(function(item){
								                            			 map.addLayer(item);		                            		 
								                                         item.setVisible(true);
								                                     });
								                                     
								                                 }
							                            	 }
	    				                             }	 			                                 
	    			                            }
	    			                            else
	    			                            {
	    			                                AlertNotify("JV Boundary is not available.")
	    			                            }
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
	  
	  

	   //DGPS Boundary Layer
	    $("#chkDGPSBndry").on("click", function(event) {	
	    			//alert("dgpsbndry");
	    			
	    			if(!$("#chkDGPSBndry").is(":checked"))
	                {		
	    				map.removeLayer(eval(dgps_boundary_layer));
	    				if(dgps_boundary_layer1.length>0)
	  	              {
	    					dgps_boundary_layer1.forEach(function(item){
	  	                      map.removeLayer(item);
	  	                  });
	  	              }
	    				   dgps_boundary_layer.setVisible(false);
	                }
	                else
	                {
	                	if(fb_id!=0)
	    		    		{
	    			    		map.removeLayer(dgps_boundary_layer);			    		
	    	    				dgpsbndryLayernm="";				    		
	    			    		$.ajax({
	    				           	url:'/Utility/getAllLayerList',
	    				            data: {'type':28},
	    				            type: "GET",
	    				            contentType: "application/json;charset=utf-8",
	    				            dataType: "json",
	    				            success :function (obj) {					                   
	    				                    if(obj!=null)
	    				                    {	
	    				                    	//console.log(obj);
	    				                    	var myStringArray = obj;
												var arrayLength = obj.length;
												for (var i = 0; i < arrayLength; i++) {
												dgpsbndryLayernm=obj[i].text;
	    				                    	//alert(dgpsbndryLayernm)
	    				                    	 var query="";
	    			                             if(fb_id!=0)
	    			                             {				                                
	    			                                 query="fb_id="+fb_id;
	    			                                 //console.log(query);
	    			                                 //alert(query)
	    			                             }
	    				                             if(query!="")
	    				                             {					                            						                            	 
	    				                            	 dgps_boundary_layer= new ol.layer.Image({
	    				                                     source: new ol.source.ImageWMS({
	    				                                     url: obj[i].strValue,
	    				                                     params: {
	    				                                     'LAYERS': obj[i].text,
	    				                                     'VERSION': '1.1.0',
	    				                                     'CQL_FILTER': query     
	    				                                     },
	    				                                     serverType: 'geoserver'
	    				                                     })  
	    				                             });
	    			                             }
	    			                             else{
	    			                            	 dgps_boundary_layer= new ol.layer.Image({
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
	    			                            if(dgps_boundary_layer!=null)
	    			                            {
	    				                              //map.addLayer(dgps_boundary_layer);
	    				                             
	    				                              if($("#chkDGPSBndry").is(":checked"))
	    				                             {
	    				                            	  dgps_boundary_layer.setVisible(true);
	    				                            	  dgps_boundary_layer1.push(dgps_boundary_layer);
		    				                              if(i==arrayLength-1){
							                            		 if(dgps_boundary_layer1.length>0)
								                                 {
							                            			 dgps_boundary_layer1.forEach(function(item){
								                            			 map.addLayer(item);		                            		 
								                                         item.setVisible(true);
								                                     });
								                                     
								                                 }
							                            	 }
	    				                             }
	    				                             /* else
	    				                             {
	    				                            	 dgps_boundary_layer.setVisible(false);
	    				                             }   */
	    			                                 
	    			                            }
	    			                            else
	    			                            {
	    			                                AlertNotify("DGPS Boundary is not available.")
	    			                            }
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
	  
	  
     
     //Pillar Points
     $("#chkJV").change(function() {
         if(this.checked) {    
             jvpillarLayer.setVisible(true);            
         }
         else{
             jvpillarLayer.setVisible(false); 
             overlay.setPosition(undefined);
         }
     });
    //JV Pillar
        var jvdata=JSON.parse(JSON.stringify(${jvPillarList}));
  		setTimeout(function () {
	     $.each(jvdata, function (c, d) {
	        var feature=  new ol.Feature({
	            geometry: new ol.geom.Point(ol.proj.transform([d.longitude_dd,d.latitude_dd], 'EPSG:4326', 'EPSG:3857')),
	            jvPlrNo: d.pillar_no,
	            type: d.pillar_type,
	            cond: d.pillar_condition,
	            jvpic_path: d.picture_path,
	            paint_sts: d.paint_status,
	            jvlatitude: d.latitude_dd,
	            jvlongitude: d.longitude_dd,
	            id:d.jv_pillar_id,
	            surveyor:d.surveyor_name,
	            point_type:"JV" 
	        }); 
	        jvpoints.push(feature);  
	    });
	     jvpillarLayer = new ol.layer.Vector({
	        source: new ol.source.Vector({
	            features: jvpoints 
	        }),
	        style:function(feature, resolution){
	            
	                    var acceptedStyle=new ol.style.Style({
	                            image: new ol.style.Circle({
	                            radius: 6,
	                            stroke: new ol.style.Stroke({
	                                color: 'white',
	                                width: 2
	                            }),
	                            fill: new ol.style.Fill({
	                                color: 'black'
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
	                            text:feature.get('jvPlrNo').toString()
	                            })
	                        });
	                    var newStyle=new ol.style.Style({
	                            image: new ol.style.Circle({
	                            radius: 6,
	                            stroke: new ol.style.Stroke({
	                                color: 'white',
	                                width: 2
	                            }),
	                            fill: new ol.style.Fill({
	                                color: 'blue'
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
	                            text:feature.get('jvPlrNo').toString()
	                            })
	                });
	                
	                if(feature.get('type')=="Existing") 
	                    return [acceptedStyle];
	                else
	                    return [newStyle];
	               
	        }
	    }); 
	     //z-index set for layer sequenceing(one after another)
	     jvpillarLayer.setZIndex(1);

	     if(jvpillarLayer!=null)
		  	{   
		    	try{
		    		map.addLayer(jvpillarLayer);
		    		/* if($("#chkJV").is(":checked"))
	    			{ */
		    			//alert("jv pillar");
			    		var extent2 = jvpillarLayer.getSource().getExtent();
					    map.getView().fit(extent2, map.getSize());
						//jvpillarLayer.setVisible(true);
	    			/* }
		    		else
	    			{
		    			alert("else");
		    			map.removeLayer(jvpillarLayer);
		    			jvpillarLayer.setVisible(false);
		    							    	
	    			} */
		    		
		    	}catch(error){
		    		alert(error);
		    	}			    	
		  	} 
		    else
		    {
		    	
		    	alert('jvpillarLayer is null');
		    }
  		
    //});
    
    
  
    
    
        //DGPS  Pillar
    	var data=JSON.parse(JSON.stringify(${dgpsPillarList}));
    	//console.log(data);  	
	     $.each(data, function (a, b) {
	        var feature=  new ol.Feature({
	            geometry: new ol.geom.Point(ol.proj.transform([b.longitude,b.latitude], 'EPSG:4326', 'EPSG:3857')),
	            fbid :b.nfb_id,
	            plr_cd: b.dgps_pillar_id,
	            plr_no:b.pillar_no,
	            latitude: b.latitude,
	            longitude: b.longitude,
	            fwdPic:b.forwad_image_path,
	            did:b.divid,
	            rngcd:b.rngcode,
	            point_type:"DGPS",
	            plr_type:b.fso_pillar_type
	        }); 
	        dgpspoints.push(feature);  
	        console.log(feature);
	    });
	    dgpspillarLayer = new ol.layer.Vector({
	        source: new ol.source.Vector({
	            features: dgpspoints 
	        }),
	        style:function(feature, resolution){
	                var acceptedStyle=new ol.style.Style({
	                            image: new ol.style.Circle({
	                            radius: 6,
	                            stroke: new ol.style.Stroke({
	                                color: 'white',
	                                width: 2
	                            }),
	                            fill: new ol.style.Fill({
	                                    color: 'orange'
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
	                            text:feature.get('plr_no').toString()
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
	                    text:feature.get('plr_no').toString()
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
	                    text:feature.get('plr_no').toString()
	                    })
	                });
	            var virtualStyle=new ol.style.Style({
	                    image: new ol.style.Circle({
	                    radius: 5,
	                    fillOpacity: 0.4,
	                    fill: new ol.style.Fill({color: '#808080'}),
	                    stroke: new ol.style.Stroke({
	                    color: '#808080', width: 1
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
	                    text:feature.get('plr_no').toString()
	                    })
	                });
	           
	            if(feature.get('plr_type')==4)
            	{
	            	return [virtualStyle];
            	}
	            else if(true)
	            {
	                return [acceptedStyle];
	            }
	            else
	            {
	                return [acceptedStyle];
	            }
	        }
	    });
	    //z-index set for layer sequenceing(one after another)
	    dgpspillarLayer.setZIndex(1);
	   
	    if(dgpspillarLayer!=null)
	  	{   
	    	try{
	    		map.addLayer(dgpspillarLayer);
	    		//dgpspillarLayer.setVisible(false);
	    		 /* var extent3 = dgpspillarLayer.getSource().getExtent();
			     map.getView().fit(extent3, map.getSize()); */
	    	}catch(error){
	    		alert(error);
	    	}	
	    	
	  	} 
	    else{
	    	alert('dgpspillarLayer is null');
	    } 
    /* }); */
   	var oldURL = document.referrer;
    if(oldURL.includes("frjvcDetails"))
    	{
    		dgpspillarLayer.setVisible(false);
    		fpcpLayer.setVisible(false);
    		fscpLayer.setVisible(false);
    		$("#chkJVBndry" ).trigger( "click");
    		$("#chkJV" ).trigger( "click");
    		
    		
    	}
    else
    	{
    		jvpillarLayer.setVisible(false);
    		$("#chkDGPSBndry" ).trigger( "click");
    		$("#chkDGPS" ).trigger( "click");
    		$("#FPCPDiv").css("display", "block");
    		$("#FSCPDiv").css("display", "block");
    		$("#chkFSCP" ).trigger( "click");
    		$("#chkFPCP" ).trigger( "click");
    	}
  		}, 2500);
	//alert(oldURL);
   //DGPS Pillar
    $("#chkDGPS").change(function() {
         if(this.checked) {    
        	 dgpspillarLayer.setVisible(true);
         }
         else{
        	 dgpspillarLayer.setVisible(false); 
             overlay.setPosition(undefined);
         }
     }); 
    
    
    /* //JV Boundary Layer
       
           var  jvLayer =new ol.layer.Vector({
                source: new ol.source.Vector({
                        url:'@Url.Content("~/kml/JVBoundry/")'+"jvb_"+'@Model.fb.int_fk_circle'+"_"+'@Model.fb.int_fk_division'+"_"+'@Model.fb.chrv_fk_range'+"_"+'@Model.fb.int_id'+".kml",
                        format: new ol.format.KML({
                            extractStyles: true,
                            showPointNames:true,
                            extractAttributes:true
                        }),
                    })
            });  
            map.addLayer(jvLayer);
            jvLayer.setVisible(true); */
            
            
            
          //Map Onclick Event
            map.on('click', function(evt) {
               content.innerHTML = '';
               var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature, layer) {
                   return feature;
               });
               if (feature) {
                   var coord = feature.getGeometry().getCoordinates();
                   var props = feature.getProperties();
                   //console.log(props);
                   if(props!=null)
                   {
					   
                       if(props.point_type=="JV")
                       {
                    	
                    	var url=props.jvpic_path!=null?props.jvpic_path:'NA';
                    	parts = url.split("/");
                    	last_part = parts[parts.length-1];
						
                    	
                       content.innerHTML = "Pillar Point Details"
                       +"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-bordered'><tr><td colspan='2'>"+"<img src='/projectDocs/download/jvImages/"+last_part+"'alt='Pillar Photo' width='100%' style='min-height:100px;max-height:200px'>"+"</td></tr>"
                       +"<tr><td>Demarcated No</td><td>"+props.jvPlrNo+"</td></tr>"
                       +"<tr><td>Type</td><td>"+props.type+"</td></tr>"
                       +"<tr><td>Condition</td><td>"+(props.cond!=null?props.cond:'NA')+"</td></tr>"
                       +"<tr><td>Location Type</td><td>"+props.type+"</td></tr>"
                       +"<tr><td>Paint Status</td><td>"+(props.paint_sts!=null?props.paint_sts:'NA')+"</td></tr>"
                       +"<tr><td>Latitude</td><td>"+props.jvlatitude+"</td></tr>"
                       +"<tr><td>Longitude</td><td>"+props.jvlongitude+"</td></tr></table></div>";
                       //console.log(feature);  
                       overlay.setPosition(evt.coordinate);
                       }
                       else if(props.point_type=="DGPS")
                       {
                    	
                    	/* var fb_id=${nfb_id};
                       	console.log(fb_id); */

                    	var urldgps=props.fwdPic!=null?props.fwdPic:'NA';
                    	dgps_parts = urldgps.split("/");
                    	dgps_last_part = dgps_parts[dgps_parts.length-1];
	                    	/* if(props.plr_no==4)
	                   		{
	                    		 content.innerHTML = "DGPS Pillar Point Details"
	                                 +"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-bordered'><tr><td colspan=2><img src='/projectDocs/download/dgpsImages/"+props.did+"/"+fb_id+"/"+dgps_last_part+"'width='100%' style='min-height:100px;max-height:200px'></td></tr>"
	                                //+"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-bordered'><tr><td>Demarcated No</td><td>"+props.plr_no+"</td></tr>"
	                                +"<tr><td>Type</td><td>Virtual</td></tr>"
	                                +"<tr><td>Demarcated No</td><td>"+props.plr_no+"</td></tr>"
	                                +"<tr><td>Latitude</td><td>"+props.latitude.toFixed(6)+"</td></tr>"
	                                +"<tr><td>Longitude</td><td>"+props.longitude.toFixed(6)+"</td></tr></table></div>";
	                                overlay.setPosition(evt.coordinate);
	                   		} */
	                    	/* else
	                    	{ */
	                    		 content.innerHTML = "DGPS Pillar Point Details"
	                                 +"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-bordered'><tr><td colspan=2><img src='/projectDocs/download/dgpsImages/"+props.did+"/"+fb_id+"/"+dgps_last_part+"'width='100%' style='min-height:100px;max-height:200px'></td></tr>"
	                                //+"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-bordered'><tr><td>Demarcated No</td><td>"+props.plr_no+"</td></tr>"
	                                //+"<tr><td>Demarcated No</td><td>"+props.plr_no+"</td></tr>"
	                                +"<tr><td>Demarcated No</td><td>"+props.plr_no+"</td></tr>"
	                                +"<tr><td>Latitude</td><td>"+props.latitude.toFixed(6)+"</td></tr>"
	                                +"<tr><td>Longitude</td><td>"+props.longitude.toFixed(6)+"</td></tr></table></div>";
	                                overlay.setPosition(evt.coordinate);
	                    		
	                    	//}
                       }
                       else if(props.point_type=="FSCP")
                   	   {
	                    	var urldgps=props.fwdPic!=null?props.fwdPic:'NA';
	                       	dgps_parts = urldgps.split("/");
	                       	dgps_last_part = dgps_parts[dgps_parts.length-1];
                    	   content.innerHTML = "FSCP Pillar Point Details"
                               +"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-bordered'><tr><td colspan=2><img src='/projectDocs/download/dgpsImages/"+props.did+"/"+fb_id+"/"+dgps_last_part+"'width='100%' style='min-height:100px;max-height:200px'></td></tr>"
                              +"<tr><td>Demarcated No</td><td>"+props.plr_no+"</td></tr>"
                              +"<tr><td>Latitude</td><td>"+props.latitude.toFixed(6)+"</td></tr>"
                              +"<tr><td>Longitude</td><td>"+props.longitude.toFixed(6)+"</td></tr></table></div>";
                              overlay.setPosition(evt.coordinate);
                   	   }
                       else if(props.point_type=="FPCP")
                   	   {
	                    	var urldgps=props.fwdPic!=null?props.fwdPic:'NA';
	                       	dgps_parts = urldgps.split("/");
	                       	dgps_last_part = dgps_parts[dgps_parts.length-1];
                    	    content.innerHTML = "FPCP Pillar Point Details"
                              +"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-bordered'></td></tr>"
							  //+"<tr><td colspan=2> <img src='/projectDocs/download/dgpsImages/"+props.did+"/"+fb_id+dgps_last_part+"'width='100%' height='125'>"
                              +"<tr><td>FB Id</td><td>"+props.fbid+"</td></tr>"
                              +"<tr><td>Location</td><td>"+props.location+"</td></tr>"
                              +"<tr><td>Utm Zone</td><td>"+props.utmzone+"</td></tr>"
                              +"<tr><td>Latitude</td><td>"+props.latitude.toFixed(6)+"</td></tr>"
                              +"<tr><td>Longitude</td><td>"+props.longitude.toFixed(6)+"</td></tr></table></div>";
                              overlay.setPosition(evt.coordinate);
                   	   } 
                   }  
               } 
               else{
                   overlay.setPosition(undefined);                   
               }
           });
           //End
           
           
           
   var fscpLayer; 
   var fpcpLayer

  //FPCP Onclick event
   var fpcpdata=JSON.parse(JSON.stringify(${fpcpPillarList}));
   $.each(fpcpdata, function (a, b) {
      var feature=  new ol.Feature({
          geometry: new ol.geom.Point(ol.proj.transform([b.dec_longitude,b.dec_latitude], 'EPSG:4326', 'EPSG:3857')),
          fbid :b.nfbid,
		  did :b.divid,
          location: b.chrv_location,
          id:b.int_id,
          latitude: b.dec_latitude,
          longitude: b.dec_longitude,
          utmzone:b.chrv_utmZone,
          point_type:"FPCP"
      }); 
      fpcpPoints.push(feature);  
      
  });
   fpcpLayer = new ol.layer.Vector({
      source: new ol.source.Vector({
          features: fpcpPoints 
      }),
      style:function(feature, resolution){
              var acceptedStyle=new ol.style.Style({
                          image: new ol.style.Circle({
                          radius: 6,
                          stroke: new ol.style.Stroke({
                              color: 'white',
                              width: 2
                          }),
                          fill: new ol.style.Fill({
                                  color: 'black'
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
                          text:feature.get('id').toString()
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
                  text:feature.get('id').toString()
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
                  text:feature.get('id').toString()
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


  if(fpcpLayer!=null)
  	{   
  	try{
  		map.addLayer(fpcpLayer);
  	}catch(error){
  		alert(error);
  	}	
  	
  	} 
  else{
  	alert('fpcpLayer is null');
  } 

  //FPCP Pillar
  $("#chkFPCP").change(function() {
       if(this.checked) {    
      	 fpcpLayer.setVisible(true);
       }
       else{
      	 fpcpLayer.setVisible(false); 
           overlay.setPosition(undefined);
       }
   }); 

   //End Of FPCP 
   
  //FSCP Onclick Event
  var fscpdata=JSON.parse(JSON.stringify(${fscpPillarList}));
	     $.each(fscpdata, function (a, b) {
	        var feature=  new ol.Feature({
	            geometry: new ol.geom.Point(ol.proj.transform([b.longitude,b.latitude], 'EPSG:4326', 'EPSG:3857')),
	            fbid :b.nfb_id,
				did : b.divid,
	            plr_cd: b.dgps_pillar_id,
	            plr_no:b.pillar_no,
	            latitude: b.latitude,
	            longitude: b.longitude,
	            fwdPic:b.forwad_image_path,
	            point_type:"FSCP"
	        }); 
	        fscpPoints.push(feature);  
	        
	    });
	     fscpLayer = new ol.layer.Vector({
	        source: new ol.source.Vector({
	            features: fscpPoints 
	        }),
	        style:function(feature, resolution){
	                var acceptedStyle=new ol.style.Style({
	                            image: new ol.style.Circle({
	                            radius: 6,
	                            stroke: new ol.style.Stroke({
	                                color: 'white',
	                                width: 2
	                            }),
	                            fill: new ol.style.Fill({
	                                    color: 'green'
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
	                            text:feature.get('plr_no').toString()
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
	                    text:feature.get('plr_no').toString()
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
	                    text:feature.get('plr_no').toString()
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
	    
	   
	    if(fscpLayer!=null)
	  	{   
	    	try{
	    		map.addLayer(fscpLayer);
	    	}catch(error){
	    		alert(error);
	    	}	
	    	
	  	} 
	    else{
	    	alert('fscpLayer is null');
	    } 
	    
	  //FSCP Pillar
	    $("#chkFSCP").change(function() {
	         if(this.checked) {    
	        	 fscpLayer.setVisible(true);
	         }
	         else{
	        	 fscpLayer.setVisible(false); 
	             overlay.setPosition(undefined);
	         }
	     }); 
  
 //End of FSCP
    
</script>


<%@ include file="../shared/footer.jsp"%> 




