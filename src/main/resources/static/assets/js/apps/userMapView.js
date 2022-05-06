
var paramdist,paramdivision,paramtehsil,paramrange,cmv_layer,cmv_text,mmv_layer,
plot_layer,revenueFnl_forest_layer,dlcFnl_layer,dgps_layer,dgpsfnl_layer,jv_layer,village_layer,tahasil_layer,tahasil_layer1,
layerOrderList=[],stateboundarylayer,districtboundarylayer,alldivboundarylayer,allrnglayer;
tahasil_layer1=[];

 layerOrderList=[
		"plot_layer",
		"dlcFnl_layer",
		"revenueFnl_forest_layer",
		"dgps_layer",
		"dgpsfnl_layer",
		"jv_layer",
		"cmv_layer",
		"mmv_layer",
		"village_layer",
		"allrnglayer",
		"tahasil_layer",
		"alldivboundarylayer",
		"districtboundarylayer",
		"stateboundarylayer"];
		
		
		
 stateboundarylayer = new ol.layer.Image({
    	source: new ol.source.ImageWMS({
        url: geoserverUrl+'/FLI_DSS_STATE/wms',
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
    visible:false
    });
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
    visible:false
    });
    
  /* allrnglayer  = new ol.layer.Image({
        source: new ol.source.ImageWMS({
        url: geoserverUrl+'/FLI_DSS_RANGE/wms',
        params: {
        'LAYERS': 'FLI_DSS_RANGE:Range',
        'VERSION': '1.1.0',
        },
        serverType: 'geoserver',
        	crossOrigin: 'anonymous'
    }),
    visible:false
    }); */
 
	//Base layer 
	var baselayer = new ol.layer.Tile({
	    source: new ol.source.OSM(),
	    visible:false,
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
	
	var parser = new ol.format.WMSGetFeatureInfo();
	var parser = new ol.format.WMSGetFeatureInfo();
	var highlightOverlay =  new ol.layer.Vector({
	  // style: (customize your highlight style here),
	  source: source,
	});
	var selectClick = new ol.interaction.Select({
		  /* condition: new ol.events.condition.click, */
		});
	var map = new ol.Map({
	    layers: [baselayer,raster,googleLayerStreet,googleLayerSatellite,measureLayer,alldivboundarylayer,districtboundarylayer,stateboundarylayer,highlightOverlay],
	/*     controls: ol.control.defaults().extend([
	     new ol.control.ScaleLine({
	    	 units: "metric",
	    	    bar: true,
	    	    steps: 4,
	    	    text: true,
	    	    minWidth: 140,
	    	    maxwidth:150
	    })/* ,
	    new ol.control.FullScreen(), */
	   /*  mousePositionControl]), */ 
	    
	    target: 'map',
	    view: new ol.View({
	        center: ol.proj.fromLonLat([84.6525554,20.1664539]),
	        zoom: 6.89,
	        maxZoom: 20,
	        minZoom: 5
	    })
	});
	//console.log(map.getView().getResolution());
	map.addInteraction(selectClick);

	
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
         //overlay.setPosition(undefined);
         closer.blur();
         return false;
     };
     var scaleLine = new ol.control.ScaleLine({bar: true, text: true, minWidth: 140,steps:4});
     map.addControl(scaleLine); 
     
     var dims = {
    		  a0: [1189, 841],
    		  a1: [841, 594],
    		  a2: [594, 420],
    		  a3: [420, 297],
    		  a4: [297, 210],
    		  a5: [210, 148],
    		};
     var exportOptions = {
    		  filter: function (element) {
    		    var className = element.className || '';
    		    return (
    		      className.indexOf('ol-control') === -1 ||
    		      className.indexOf('ol-scale') > -1 ||
    		      (className.indexOf('ol-attribution') > -1 &&
    		        className.indexOf('ol-uncollapsible'))
    		    );
    		  },
    		};
     
     var exportButton = document.getElementById('btnExport');//Export PDF Button
     
     //PDF Export on click
     exportButton.addEventListener(
       'click',
       function () {
    	   if($("#txtPdfName").val()=="")
  		 {
    		   $("#lblpdfError").css("display","block");
    		   return true;
  		 }
  	 else
  		 {
  		 $("#lblpdfError").css("display","none");
  		 }
    	   exportButton.disabled = true;
    	    document.body.style.cursor = 'progress';

    	    var format = document.getElementById('format').value;
    	    var resolution = document.getElementById('resolution').value;
    	    var dim = dims[format];
    	    var width = Math.round((dim[0] * resolution) / 25.4);
    	    var height = Math.round((dim[1] * resolution) / 25.4);
    	    var size = map.getSize();
    	    var viewResolution = map.getView().getResolution();

    	    map.once('rendercomplete', function () {
    	      var mapCanvas = document.createElement('canvas');
    	      mapCanvas.width = width;
    	      mapCanvas.height = height;
    	      var mapContext = mapCanvas.getContext('2d');
    	      Array.prototype.forEach.call(
    	        document.querySelectorAll('.ol-layer canvas'),
    	        function (canvas) {
    	          if (canvas.width > 0) {
    	            var opacity = canvas.parentNode.style.opacity;
    	         //   console.log(opacity);
    	            mapContext.globalAlpha = opacity === '' ? 1 : Number(opacity);
    	            var transform = canvas.style.transform;
    	            mapContext.fillStyle = "#FFFFFF";
    	            mapContext.fillRect(0,0,width,height);
    	            // Get the transform parameters from the style's transform matrix
    	            var matrix = transform
    	              .match(/^matrix\(([^\(]*)\)$/)[1]
    	              .split(',')
    	              .map(Number);
    	              //console.log(matrix);
    	            // Apply the transform to the export map context
    	            CanvasRenderingContext2D.prototype.setTransform.apply(
    	              mapContext,
    	              matrix
    	            );
    	          
    	            mapContext.drawImage(canvas, 0, 0);
    	          }
    	        }
    	      );
    	      var pdf = new jsPDF('landscape', undefined, format);
    	      pdf.addImage(
    	        mapCanvas.toDataURL('image/jpeg'),
    	        'JPEG',
    	        0,
    	        0,
    	        dim[0],
    	        dim[1]
    	      );
    	      pdf.save($("#txtPdfName").val()+'.pdf');
    	      // Reset original map size
    	      map.setSize(size);
    	      map.getView().setResolution(viewResolution);
    	      exportButton.disabled = false;
    	      document.body.style.cursor = 'auto';
    	    });

    	    // Set print size
    	    var printSize = [width, height];
    	    map.setSize(printSize);
    	    var scaling = Math.min(width / size[0], height / size[1]);
    	    map.getView().setResolution(viewResolution / scaling);
    	  },
    	  false
    	);
    	    
    /* PDF Export Onclick End */
    /* Image Export Onclick Start */
    document.getElementById('btnImageExport').addEventListener('click', function () {
  map.once('rendercomplete', function () {
    var mapCanvas = document.createElement('canvas');
    var size = map.getSize();
    mapCanvas.width = size[0];
    mapCanvas.height = size[1];
    var mapContext = mapCanvas.getContext('2d');
    Array.prototype.forEach.call(
      document.querySelectorAll('.ol-layer canvas'),
      function (canvas) {
        if (canvas.width > 0) {
          var opacity = canvas.parentNode.style.opacity;
          mapContext.globalAlpha = opacity === '' ? 1 : Number(opacity);
          var transform = canvas.style.transform;
          mapContext.fillStyle = "#FFFFFF";
          mapContext.fillRect(0,0,size[0],size[1]);
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
    if (navigator.msSaveBlob) {
      // link download attribuute does not work on MS browsers
      navigator.msSaveBlob(mapCanvas.msToBlob(), $("#txtImageName").val()+'.'+$("#imgformat").val());
    } else {
      var link = document.getElementById('image-download');
      link.href = mapCanvas.toDataURL();
      link.download=$("#txtImageName").val()+'.'+$("#imgformat").val();
      link.click();
    }
  });
  map.renderSync();
});
   /*  Image Export Onclick End */
	//googleLayerSatellite.setVisible(true);
	/* View Layers on Map Start */
	//State Boundary Layer Checkbox Change Event
    $("#chkState").change(function() {
        if(this.checked) {    
            stateboundarylayer.setVisible(true);
            var option="<option value='stateboundarylayer'>State Boundary</option>";
            $("#ddlActiveLayer").append(option);
    } 
    else{
        stateboundarylayer.setVisible(false);
        $("#ddlActiveLayer option[value='stateboundarylayer']").remove();
    }
    });
      //District Boundary Layer Checkbox Change Event
       $("#chkDistrict").change(function() {
        if(this.checked) {    
        	districtboundarylayer.setVisible(true);
        	var option="<option value='districtboundarylayer'>District Boundary</option>";
            $("#ddlActiveLayer").append(option);
    }
    else{
    	districtboundarylayer.setVisible(false);
    	$("#ddlActiveLayer option[value='districtboundarylayer']").remove();
    } 
});
       //Division Boundary Layer Checkbox Change Event
       $("#chkDivision").change(function() {
        if(this.checked) {    
        	alldivboundarylayer.setVisible(true);
        	var option="<option value='alldivboundarylayer'>Division Boundary</option>";
            $("#ddlActiveLayer").append(option);
    }
    else{
    	alldivboundarylayer.setVisible(false);
    	$("#ddlActiveLayer option[value='alldivboundarylayer']").remove();
    } 
});            
     //CMV Layer Checkbox Change Event
        $("#chkCMV").on("click", function (e) {
        if(this.checked) { 
        	if($('#selectedDistDiv').is(':visible')){
        		if($("#ddldist")[0].selectedIndex==0)
        			{
        				viewNotification(2);
        				e.preventDefault();
        				 return false;
        			}
        		else
        			{        			
        			ViewLayer('cmv');        				
        			}
        	}
        	else
        		{
	        		if($("#ddldivision")[0].selectedIndex==0)
	    			{
	    				viewNotification(3);
	    				e.preventDefault();
       				 return false;
	    			}
	    		else
	    			{	    			
	    			ViewLayer('cmv');	    				
	    			}
        		}
        	//allrnglayer.setVisible(true);
    }
    else{
    	cmv_layer.setVisible(false);
    	 map.removeLayer(cmv_layer);
    	$("#ddlActiveLayer option[value='cmv_layer']").remove();
    } 
});
     //MMV Layer Checkbox Change Event
       $("#chkMMV").on("click", function (e) {
    	   //alert("checked");
        if(this.checked) { 
        	if($('#selectedDistDiv').is(':visible')){
        		if($("#ddldist")[0].selectedIndex==0)
        			{
        				viewNotification(2);
        				e.preventDefault();
        				 return false;
        			}
        		else
        			{        			
        			ViewMMVLayer('mmv');        				
        			}
        	}
        	else
        		{
	        		if($("#ddldivision")[0].selectedIndex==0)
	    			{
	    				viewNotification(3);
	    				e.preventDefault();
       				 return false;
	    			}
	    		else
	    			{	    			
	    			ViewMMVLayer('mmv');	    					    				
	    			}
        		}
        	//allrnglayer.setVisible(true);
    }
    else{
    	
    	 map.removeLayer(mmv_layer);
    	$("#ddlActiveLayer option[value='mmv_layer']").remove();
    } 
});       
       /*     View Layers on Map End     */
       
         	/* Radio Button Selection */
    $("input[name='classicRadio']").change(function(e){	
    	$(".dvselection").hide();
    	if($(this).attr('id')=="hRadiodist")
   		{
    		var div = $('#ddldivision');
    		div[0].selectedIndex = 0;
    		 $('#ddlRange').html('');
    	     $('#ddlRange').append($("<option></option>").attr("value", "").text("Select Range"));
    		$("#selectedDistDiv").show();
    		 if(!$('#chkDistrict').is(":checked")){
    			 $('#chkDistrict').trigger('click');
    		 }
    		 if($('#chkDivision').is(":checked")){
    			 $('#chkDivision').trigger('click');
    		 }
   		}
    	else if($(this).attr('id')=="hRadiodiv")
   		{
    		var dist = $('#ddldist');
    		dist[0].selectedIndex = 0;
   		 $('#ddlTehsil').html('');
   	     $('#ddlTehsil').append($("<option></option>").attr("value", "").text("Select Tehsil"));
    		$("#selectdivisionDiv").show();
    		if(!$('#chkDivision').is(":checked")){
      			 $('#chkDivision').trigger('click');
      		 }
    		if($('#chkDistrict').is(":checked")){
   			 $('#chkDistrict').trigger('click');
   		 }   		     		
   		}    	
    });
    function resetData()
	{
		if($("input[name='classicRadio']:checked").attr('id')=="hRadiodist")
		{
			var dist = $('#ddldist');
    		dist[0].selectedIndex = 0;
	   		 $('#ddlTehsil').html('');
	   	     $('#ddlTehsil').append($("<option></option>").attr("value", "").text("Select Tehsil"));
		}
		else
		{
			var div = $('#ddldivision');
    		div[0].selectedIndex = 0;
   		 $('#ddlRange').html('');
   	     $('#ddlRange').append($("<option></option>").attr("value", "").text("Select Range"));
		}
	}
    //ViewLayer for adding CMV Layer
    function ViewLayer(layer)
    {
    	
    	if($('#selectedDistDiv').is(':visible')){
    		if($("#ddldist")[0].selectedIndex==0)
    			{
    				viewNotification(2);
    				return false;
    			}
    		else
    			{
    			paramdist=$("#ddldist").val();
    			paramtehsil=($("#ddlTehsil").val()==""|| $("#ddlTehsil").val()==null)?0:$("#ddlTehsil").val();
    			paramdivision=0;
    			paramrange='';
    			}
    	}
    	else
    		{
        		if($("#ddldivision")[0].selectedIndex==0)
    			{
    				viewNotification(3);
    				return false;
    			}
    		else
    			{
    			paramdist=0;
    			paramtehsil=0;
    			paramdivision=$("#ddldivision").val();
    			paramrange=($("#ddlRange").val()==null || $("#ddlRange").val()=='')?'':$("#ddlRange").val();
    			}
    		}
    	$(".loader-base").css("display","block");
    	
    	$.ajax({
            url:'/FLD/getLayerInfo',
            data: { 'layer':layer,'distid':paramdist,'divid':paramdivision,'tehsilid':paramtehsil,'rangeCode':paramrange },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function (data) {     		
     			var jsonObj = {};
     			var arr=[];
     			data.forEach(function(column) 
     		    {
     				var jsonData = {};
     		        jsonData["geometry"] =JSON.parse(column["8"]);
     		       jsonData["type"]="Feature";
     		        var prop={};
     		       prop["fb_name"]=column[0];
     		      prop["fb_type"]=column[1];
     		       prop["range_name"]=column[2];
     		      prop["division_name"]=column[3];
   		        prop["district_name"]=column[4];
   		       prop["area_ha"]=column[5];
   		      prop["area_sqkm"]=column[6];
		      prop["perimeter"]=column[7];
		      
		      jsonData["properties"]=prop;
		      arr.push(jsonData);
     		    });
     			console.log(arr);
     			jsonObj["features"]=arr;
     			jsonObj["type"]="FeatureCollection";
     			//var abc=JSON.parse(jsonObj);
     			//console.log(jsonObj);
     			/* var _myStroke = new ol.style.Stroke({
     			   color : 'rgba(255,0,0,1.0)',
     			   width : 1    
     			}); */     	
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
     		   	 style:cmv_style,
     		   	 //opacity:0,
     		       
     		   	  });
     		      map.addLayer(cmv_layer);
     		     cmv_layer.setVisible(true);
     		   var option="<option value='cmv_layer'>Cadastral Map Vector</option>";
     		  $("#ddlActiveLayer").append(option);		    	  	       	        	         	      
     		     $(".loader-base").css("display","none");
          },
            error: function (errormessage) {
                alert(errormessage.responseText);
                $(".loader-base").css("display","none");
            }
        }); 
    	
    }
    function ViewMMVLayer(layer)
    {
    	
    	if($('#selectedDistDiv').is(':visible')){
    		if($("#ddldist")[0].selectedIndex==0)
    			{
    				viewNotification(2);
    				return false;
    			}
    		else
    			{
    			paramdist=$("#ddldist").val();
    			paramtehsil=($("#ddlTehsil").val()==""|| $("#ddlTehsil").val()==null)?0:$("#ddlTehsil").val();
    			paramdivision=0;
    			paramrange='';
    			}
    	}
    	else
    		{
        		if($("#ddldivision")[0].selectedIndex==0)
    			{
    				viewNotification(3);
    				return false;
    			}
    		else
    			{
    			paramdist=0;
    			paramtehsil=0;
    			paramdivision=$("#ddldivision").val();
    			paramrange=($("#ddlRange").val()==null || $("#ddlRange").val()=='')?'':$("#ddlRange").val();
    			}
    		}
    	$(".loader-base").css("display","block");
    	
    	$.ajax({
            url:'/FLD/getLayerInfo',
            data: { 'layer':'mmv','distid':paramdist,'divid':paramdivision,'tehsilid':paramtehsil,'rangeCode':paramrange },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function (data) {     
            	
            	//console.log('data: '+data);
            	
     			var jsonObj = {};
     			var arr=[];
     			data.forEach(function(column) 
     		    {
     				var jsonData = {};
     		        jsonData["geometry"] =JSON.parse(column["8"]);
     		       jsonData["type"]="Feature";
     		        var prop={};
     		       prop["fb_name"]=column[0];
     		      prop["fb_type"]=column[1];
     		       prop["range_name"]=column[2];
     		      prop["division_name"]=column[3];
   		        prop["district_name"]=column[4];
   		       prop["area_ha"]=column[5];
   		      prop["area_sqkm"]=column[6];
		      prop["perimeter"]=column[7];
		      
		      jsonData["properties"]=prop;
		      arr.push(jsonData);
     		    });
     			console.log(arr);
     			jsonObj["features"]=arr;
     			jsonObj["type"]="FeatureCollection";
     			//var abc=JSON.parse(jsonObj);
     			//console.log(jsonObj);
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
     		  mmv_layer = new ol.layer.Vector({
     		   	  source: vectorSource,
     		   	  style:mmv_style,
     		       //opacity:0,
     		   	  });
     		      map.addLayer(mmv_layer);
     		     mmv_layer.setVisible(true);
     		   	var option="<option value='mmv_layer'>Management Map Vector</option>";
     		 		 $("#ddlActiveLayer").append(option);    			    	      
     		    	 $(".loader-base").css("display","none");
          },
            error: function (errormessage) {
                alert(errormessage.responseText);
                $(".loader-base").css("display","none");
            }
        }); 
    	
    }
   
           
    //Map on Single Click
    
     map.on('click', function(evt) { 
    	 var divContent="";
    	 $("#a_info").click();
    	 if($("#ddlActiveLayer").val()=="")
    		 {
	    		 if($("#a_info").attr('aria-expanded')=='false'){
	    		 	$("#activeNote").show();
	    		 }
    		 }
    	 else
    		 {
    		 $("#activeNote").hide();
    		 if($("#a_measure").attr('aria-expanded')=='false'){
                 var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature, layer) {
                     return feature;
                 });
                 if (feature) 
                 {                 
                 	if($("#a_info").attr('aria-expanded')=='false'){
                 		$("#a_info").click();
                 	}
                 		
                 	var coord = feature.getGeometry().getCoordinates();
                     var props = feature.getProperties();
                     //console.log(props);
                     var content1 = "Layer Details"
                     	+"</br>"+"<div class='table-responsive my-table-sm'><table class='table table-bordered'>"
                         +"<tr><td>Forest Block</td><td>"+props.fb_name+"</td></tr>"  
                         +"<tr><td>FB Type</td><td>"+props.fb_type+"</td></tr>"                           
                         +"<tr><td>District</td><td>"+props.district_name+"</td></tr>"
                         +"<tr><td>Division</td><td>"+props.division_name+"</td></tr>"
                         +"<tr><td>Range</td><td>"+props.range_name+"</td></tr>"
                         +"<tr><td>Area(Ha)</td><td>"+props.area_ha+"</td></tr>"
                         +"<tr><td>Area(Sq KM)</td><td>"+props.area_sqkm+"</td></tr>"
                         +"<tr><td>Perimeter(mtr)</td><td>"+props.perimeter+"</td></tr></table></div>"
                        //overlay.setPosition(evt.coordinate); 
                         $("#infodiv").html(content1);
                 } 
                 else 
                 {
                 	 var view = map.getView();
                 	 var url="";
                 	 divContent="State Boundary </br><div class='table-responsive my-table-sm'><table class='table table-bordered'>";
                 	 if($("#ddlActiveLayer").val()=="stateboundarylayer")
             		 {
             		 url = stateboundarylayer.getSource().getFeatureInfoUrl(evt.coordinate,
                    	      view.getResolution(), view.getProjection(),
                    	      {'INFO_FORMAT': 'application/vnd.ogc.gml'});
                 		getInfo(url,divContent);
             		 }
                 	 else if($("#ddlActiveLayer").val()=="districtboundarylayer")
             		 {
                 		 divContent="District Boundary </br><div class='table-responsive my-table-sm'><table class='table table-bordered'>";
             		url = districtboundarylayer.getSource().getFeatureInfoUrl(evt.coordinate,
                    	      view.getResolution(), view.getProjection(),
                    	      {'INFO_FORMAT': 'application/vnd.ogc.gml'});
             		getInfo(url,divContent);
             		 }
                 	 else if($("#ddlActiveLayer").val()=="alldivboundarylayer")
                		 {
                 		 divContent="Division Boundary </br><div class='table-responsive my-table-sm'><table class='table table-bordered'>";
                			url = alldivboundarylayer.getSource().getFeatureInfoUrl(evt.coordinate,
                       	      view.getResolution(), view.getProjection(),
                       	      {'INFO_FORMAT': 'application/vnd.ogc.gml'});
                			getInfo(url,divContent);
                      
                		 }
                   
                  };
	 				}
    		 }    	    	
                        });
    function getInfo(url,divContent)
    {
  	  $.ajax(url).then(function(response) {
   	    var features = parser.readFeatures(response);
   	    highlightOverlay.getSource().clear();
   	    highlightOverlay.getSource().addFeatures(features);
   	   // console.log(features[0].getProperties());
   	    var props=features[0].getProperties();
   	 for(var key in props) {
   		 if(key!='the_geom')
   			 {
   				divContent+="<tr><td>"+key+"</td><td>"+props[key]+"</td></tr>"
   			 }
         /* alert("Key: " + key + " value: " + props[key]); */
       }
   	divContent+="</table></div>"
   	 $("#infodiv").html(divContent); 
   	  });
    }
    /* On Modal Close */
     $('#printModal').on('hidden.bs.modal', function () {
    	 $("#lblpdfError").css("display","none");
    	 $("#txtPdfName").val("");
    	});
     $('#imgprintModal').on('hidden.bs.modal', function () {
    	 $("#lblimgError").css("display","none");
    	 $("#txtImageName").val("");
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
				    helpTooltipElement.parentNode.removeChild(helpTooltipElement);
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
				    measureTooltipElement.parentNode.removeChild(measureTooltipElement);
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
					 map.removeOverlay(overlay);
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
				 
     /* Measurement End */
     
     
/*   //On change of District */
    $("#ddldist").change(function () {
        $('#ddlTehsil').html('');
    	if($(this).prop('selectedIndex')!=0)
		{
        $.ajax({
            url:'/Utility/getDistwiseTahasil',
            data: { 'distid':$('#ddldist').val() },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function (data) {
     
                var options = '';
          /*       if(${divID}==0)
                            { */
                              $('#ddlTehsil').append($("<option></option>").attr("value", "").text("All"));
                          /*   } */
                $.each(data, function (a, b) {
                	
                    options += '<option value="' + b.value + '">' + b.text + '</option>';
                });
                $('#ddlTehsil').append(options);
             /*    if(${divID}!=0)
                {
                    var did='${divID}';
                    $('#ddldist option[value='+did+']').attr("selected",true);
                    $('#ddldist').trigger('change');
                    $("#ddldist").attr("disabled", true);
                }  */ 
                // LoadDonutChart();   
            },
            error: function (errormessage) {
                alert(errormessage.responseText);
            }
        });  
		}
    	else
    		{
    		 $('#ddlTehsil').append($("<option></option>").attr("value", "").text("Select Tehsil"));
    		}
     });
     //Onchange of Division
    $("#ddldivision").change(function () {
    	 $('#ddlRange').html('');
    	if($(this).prop('selectedIndex')!=0)
		{
        $.ajax({
            url:'/Utility/getDivwiseRange',
            data: { 'divid':$('#ddldivision').val() },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function (data) {
                var options = '';
          /*       if(${divID}==0)
                            { */
                              $('#ddlRange').append($("<option></option>").attr("value", "").text("All"));
                          /*   } */
                $.each(data, function (a, b) {
                	
                    options += '<option value="' + b.strValue + '">' + b.text + '</option>';
                });
                $('#ddlRange').append(options);
             /*    if(${divID}!=0)
                {
                    var did='${divID}';
                    $('#ddldist option[value='+did+']').attr("selected",true);
                    $('#ddldist').trigger('change');
                    $("#ddldist").attr("disabled", true);
                }  */ 
                // LoadDonutChart();   
            },
            error: function (errormessage) {
                alert(errormessage.responseText);
            }
        }); 
		}
    	else
    		{
    		$('#ddlRange').append($("<option></option>").attr("value", "").text("Select Range"));
    		}
     });
    
  /*  $("#a_reset").click(function(){
        window.location.href='/FLD/forestLandInfo';
    });*/
  //Onclick of Tehsil CheckBox  
  $("#chkTehsil").on("click", function(event) {
	    //$("#chkTehsil").change(function (event) { 	    	    		 
			  if(!$("#chkTehsil").is(":checked"))
               { 
              	tahasil_layer.setVisible(false);
              	map.removeLayer(eval(tahasil_layer));
                if(tahasil_layer1.length>0)
                {
                	tahasil_layer1.forEach(function(item){
                        map.removeLayer(item);
                    });
                }
               }
               else
               {               				 			 
	    	if($('#ddldist').val()!=0 || $('#ddldist').val()!="")
 		      {		    		
	    		var paramdist = $("#ddldist").val();
	    		 var paramtahasil=($("#ddlTehsil").val()==""|| $("#ddlTehsil").val()==null)?0:$("#ddlTehsil").val();				
	    		$.ajax({	    			
	    			url:'/Utility/getDivisionVectorMapTypeLayerList',
		            data: {'distid':paramdist,'divid': 0,'type':19},
		            type: "GET",
		            contentType: "application/json;charset=utf-8",
		            dataType: "json",
		            success :function (obj) {	
		            	//console.log(obj);
		                    if(obj!=null)
		                    {	
		                        var myStringArray = obj;
		                    	var arrayLength = obj.length;	                    	
		                	for (var i = 0; i < arrayLength; i++) {  
		                    	tehLayernm=obj[i].text;
		                    	//console.log(obj);
	                             if($("#ddlTehsil").val()!="")
	                             {
	                                var query="tah_id="+$( "#ddlTehsil option:selected" ).val();
	                                 if(obj[i].value==$("#ddlTehsil option:selected" ).val()){
	                                  	 tahasil_layer= new ol.layer.Image({
		                                     source: new ol.source.ImageWMS({
		                                     url: obj[i].strValue,
		                                     params: {
		                                     'LAYERS': tehLayernm,
		                                     'VERSION': '1.1.0',
		                                     'CQL_FILTER': query     
		                                     },
		                                     serverType: 'geoserver'
		                                     })  
		                             });
	                                  	map.addLayer(tahasil_layer);
		                            	tahasil_layer.setVisible(true);
	                                  	 break;
	                                 }
	                                 
	                             }   else{
	                            	 tahasil_layer= new ol.layer.Image({
	                                     source: new ol.source.ImageWMS({
	                                     url: obj[i].strValue,
	                                     params: {
	                                     'LAYERS':tehLayernm,
	                                     'VERSION': '1.1.0'     
	                                     },
	                                     serverType: 'geoserver'
	                                     })  
	                             });
	                            	 tahasil_layer1.push(tahasil_layer);
	                            	 //console.log(i);
	                            	 //console.log(arrayLength-1);
	                            	 if(i==arrayLength-1){
	                            		 if(tahasil_layer1.length>0)
		                                 {
		                            		 tahasil_layer1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
	                            	
	                             }		                       	                            
		                    	} 
	                            }
	                            else{
	                                AlertNotify("Tahasil Boundary of "+$( "#ddlTehsil option:selected" ).text()+" tahasil is not available.")
	                            }
		                },		            
		            error :function (xhr, status) 
		            {
		                    
		            }
		            });
 		}
		    else
		    {
		        //alert('Select division or  district.');
		    	viewNotification(2);
				return false;
		    }
          }
		 }); 
	  //Onclick of Range CheckBox 
	  $("#chkRange").on("click", function(event) {
	    //$("#chkRange").change(function (event) {	
	    	map.removeLayer(allrnglayer);
		    	if($('#ddldivision').val()!=0 || $('#ddldivision').val()!="")
	    		{		    		
		    		
		    		map.removeLayer(allrnglayer);		    		    				
    				var paramdivision = $("#ddldivision").val();
    				
		    		//alert(paramdist);
		    		$.ajax({
			           	url:'/Utility/getDivisionVectorMapTypeLayerList',
			            data: {'distid':0,'divid':paramdivision,'type':9},
			            type: "GET",
			            contentType: "application/json;charset=utf-8",
			            dataType: "json",
			            success :function (obj) {
			                   
			                    if(obj!=null)
			                    {	
		                    	
		                             if($("#ddlRange").val()!="")
		                             {			                            	
		                               var query="range_id="+"'"+$( "#ddlRange option:selected" ).val()+"'";
		                                
		                             }
			                             if(query!="")
			                             {					                            	 
			                            	 allrnglayer= new ol.layer.Image({
			                                     source: new ol.source.ImageWMS({
			                                     url: obj[0].strValue,
			                                     params: {
			                                     'LAYERS': obj[0].text,
			                                     'VERSION': '1.1.0',
			                                     //'STYLES': tstyle
			                                     'CQL_FILTER': query     
			                                     },
			                                     serverType: 'geoserver'
			                                     })  
			                             });
		                             }
		                             else{		                            	 
		                            	 allrnglayer= new ol.layer.Image({
		                                     source: new ol.source.ImageWMS({
		                                     url: obj[0].strValue,
		                                     params: {
		                                     'LAYERS': obj[0].text,
		                                     'VERSION': '1.1.0',
		                                   	 //'STYLES': tstyle
		                                     },
		                                     serverType: 'geoserver'
		                                     })  
		                             });
		                             }		                            
		                            if(allrnglayer!=null)
		                            {
		                              map.addLayer(allrnglayer);
		                             if($("#chkRange").is(":checked"))
		                             {
		                            	 allrnglayer.setVisible(true);
		                            	
		                             }
		                             else
		                             {
		                                 /*  layerlist=layerlist.filter(item=>item.layerName!="divWs_tahesil_boundary"); */
		                                  allrnglayer.setVisible(false);
		                             }
		                                 
		                            }
		                            else{
		                                AlertNotify("Range Boundary of "+$( "#ddlRange option:selected" ).text()+" range is not available.")
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
					   if($('#ddldist').val()!=0 || $('#ddldist').val()!="" || $('#ddldivision').val()!=0 || $('#ddldivision').val()!="")
			    		{
				    		map.removeLayer(village_layer);				    		
				    		var paramdivision = $("#ddldivision").val();				    		
		    				villLayernm="";				    		
				    		$.ajax({
					           	url:'/Utility/getDivisionVectorMapTypeLayerList',
					            data: {'distid': 0,'divid': paramdivision,'type':14},
					            type: "GET",
					            contentType: "application/json;charset=utf-8",
					            dataType: "json",
					            success :function (obj) {					                   
					                    if(obj!=null)
					                    {	
					                    	villLayernm=obj[0].text;
					                    	
					                    	 var query="";
				                             if($("#ddlRange").val()!="")
				                             {				                                
				                                 query="range_id="+"'"+$( "#ddlRange option:selected" ).val()+"'";				                                 
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
				                             else{
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
				                             }
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
				                                AlertNotify("Village Boundary of "+$( "#ddlRange option:selected" ).text()+" range is not available.")
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
	    
				//Onclick of JV Final CheckBox   
				   $("#chkFinalJV").on("click", function(event) {
				    		    		    	 
							   if(!$("#chkFinalJV").is(":checked"))
				               {					   
								   jv_layer.setVisible(false);
				               }
				               else
				               {
								   if($('#ddldivision').val()!=0 || $('#ddldivision').val()!="")
						    		{
							    		map.removeLayer(jv_layer);				    		
							    		var paramdivision = $("#ddldivision").val();				    		
							    		jvLayernm="";				    		
							    		$.ajax({
								           	url:'/Utility/getDivisionVectorMapTypeLayerList',
								            data: {'distid': 0,'divid': paramdivision,'type':26},
								            type: "GET",
								            contentType: "application/json;charset=utf-8",
								            dataType: "json",
								            success :function (obj) {					                   
								                    if(obj!=null)
								                    {	
								                    	jvLayernm=obj[0].text;
								                    	
								                    	 var query="";
							                             if($("#ddlRange").val()!="")
							                             {				                                
							                                 query="range_code="+"'"+$( "#ddlRange option:selected" ).val()+"'";	
							                                 console.log(query);
							                             }
								                             if(query!="")
								                             {					                            						                            	 
								                            	 jv_layer= new ol.layer.Image({
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
							                             else{
							                            	 jv_layer= new ol.layer.Image({
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
							                            if(jv_layer!=null)
							                            {
								                              map.addLayer(jv_layer);
								                              if($("#chkFinalJV").is(":checked"))
								                             {
								                            	  jv_layer.setVisible(true);
								                             }
								                             else
								                             {
								                            	 jv_layer.setVisible(false);
								                             }  
							                                 
							                            }
							                            else{
							                                AlertNotify("JV Certified Boundary of "+$( "#ddlRange option:selected" ).text()+" range is not available.")
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
				 //Onclick of DGPS Draft CheckBox   
				   $("#chkDraftDGPS").on("click", function(event) {
				    		    		    	 
							   if(!$("#chkDraftDGPS").is(":checked"))
				               {					   
								   dgps_layer.setVisible(false);
				               }
				               else
				               {
								   if($('#ddldivision').val()!=0 || $('#ddldivision').val()!="")
						    		{
							    		map.removeLayer(dgps_layer);				    		
							    		var paramdivision = $("#ddldivision").val();				    		
							    		dgpsLayernm="";				    		
							    		$.ajax({
								           	url:'/Utility/getDivisionVectorMapTypeLayerList',
								            data: {'distid': 0,'divid': paramdivision,'type':25},
								            type: "GET",
								            contentType: "application/json;charset=utf-8",
								            dataType: "json",
								            success :function (obj) {					                   
								                    if(obj!=null)
								                    {	
								                    	dgpsLayernm=obj[0].text;
								                    	
								                    	 var query="";
							                             if($("#ddlRange").val()!="")
							                             {				                                
							                                 query="range_code="+"'"+$( "#ddlRange option:selected" ).val()+"'";	
							                                 console.log(query);
							                             }
								                             if(query!="")
								                             {					                            						                            	 
								                            	 dgps_layer= new ol.layer.Image({
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
							                             else{
							                            	 dgps_layer= new ol.layer.Image({
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
							                            if(dgps_layer!=null)
							                            {
								                              map.addLayer(dgps_layer);
								                              if($("#chkDraftDGPS").is(":checked"))
								                             {
								                            	  dgps_layer.setVisible(true);
								                             }
								                             else
								                             {
								                            	 dgps_layer.setVisible(false);
								                             }  
							                                 
							                            }
							                            else{
							                                AlertNotify("DGPS Draft Boundary of "+$( "#ddlRange option:selected" ).text()+" range is not available.")
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
				 //Onclick of DGPS Final CheckBox   
				   $("#chkFinalDGPS").on("click", function(event) {
				    		    		    	 
							   if(!$("#chkFinalDGPS").is(":checked"))
				               {					   
								   dgpsfnl_layer.setVisible(false);
				               }
				               else
				               {
								   if($('#ddldivision').val()!=0 || $('#ddldivision').val()!="")
						    		{
							    		map.removeLayer(dgpsfnl_layer);				    		
							    		var paramdivision = $("#ddldivision").val();				    		
							    		dgpsfnlLayernm="";				    		
							    		$.ajax({
								           	url:'/Utility/getDivisionVectorMapTypeLayerList',
								            data: {'distid': 0,'divid': paramdivision,'type':28},
								            type: "GET",
								            contentType: "application/json;charset=utf-8",
								            dataType: "json",
								            success :function (obj) {					                   
								                    if(obj!=null)
								                    {	
								                    	dgpsfnlLayernm=obj[0].text;
								                    	
								                    	 var query="";
							                             if($("#ddlRange").val()!="")
							                             {				                                
							                                 query="range_code="+"'"+$( "#ddlRange option:selected" ).val()+"'";	
							                                 console.log(query);
							                             }
								                             if(query!="")
								                             {					                            						                            	 
								                            	 dgpsfnl_layer= new ol.layer.Image({
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
							                             else{
							                            	 dgpsfnl_layer= new ol.layer.Image({
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
							                            if(dgpsfnl_layer!=null)
							                            {
								                              map.addLayer(dgpsfnl_layer);
								                              if($("#chkFinalDGPS").is(":checked"))
								                             {
								                            	  dgpsfnl_layer.setVisible(true);
								                             }
								                             else
								                             {
								                            	 dgpsfnl_layer.setVisible(false);
								                             }  
							                                 
							                            }
							                            else{
							                                AlertNotify("DGPS Final Boundary of "+$( "#ddlRange option:selected" ).text()+" range is not available.")
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
				 //Onclick of  RF Final CheckBox   
				   $("#chkRFFinal").on("click", function(event) {
				    		    		    	 
							   if(!$("#chkRFFinal").is(":checked"))
				               {					   
								   revenueFnl_forest_layer.setVisible(false);
				               }
				               else
				               {
								   if($('#ddldivision').val()!=0 || $('#ddldivision').val()!="")
						    		{
							    		map.removeLayer(revenueFnl_forest_layer);				    		
							    		var paramdivision = $("#ddldivision").val();				    		
							    		rfFnlLayernm="";				    		
							    		$.ajax({
								           	url:'/Utility/getDivisionVectorMapTypeLayerList',
								            data: {'distid': 0,'divid': paramdivision,'type':24},
								            type: "GET",
								            contentType: "application/json;charset=utf-8",
								            dataType: "json",
								            success :function (obj) {					                   
								                    if(obj!=null)
								                    {	
								                    	rfFnlLayernm=obj[0].text;
								                    	console.log(rfFnlLayernm);
								                    	 var query="";
							                             if($("#ddlRange").val()!="")
							                             {				                                
							                                 query="range_id="+"'"+$( "#ddlRange option:selected" ).val()+"'";	
							                                 console.log(query);
							                             }
								                             if(query!="")
								                             {					                            						                            	 
								                            	 revenueFnl_forest_layer= new ol.layer.Image({
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
							                             else{
							                            	 revenueFnl_forest_layer= new ol.layer.Image({
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
							                            if(revenueFnl_forest_layer!=null)
							                            {
								                              map.addLayer(revenueFnl_forest_layer);
								                              if($("#chkRFFinal").is(":checked"))
								                             {
								                            	  revenueFnl_forest_layer.setVisible(true);
								                             }
								                             else
								                             {
								                            	 revenueFnl_forest_layer.setVisible(false);
								                             }  
							                                 
							                            }
							                            else{
							                                AlertNotify("RF Final Boundary of "+$( "#ddlRange option:selected" ).text()+" range is not available.")
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
				 //Onclick of  DLC Final CheckBox   
				   $("#chkDLCFinal").on("click", function(event) {
				    		    		    	 
							   if(!$("#chkDLCFinal").is(":checked"))
				               {					   
								   dlcFnl_layer.setVisible(false);
				               }
				               else
				               {
								   if($('#ddldivision').val()!=0 || $('#ddldivision').val()!="")
						    		{
							    		map.removeLayer(dlcFnl_layer);				    		
							    		var paramdivision = $("#ddldivision").val();				    		
							    		dlcFnlLayernm="";
							    		console.log(dlcFnlLayernm);
							    		$.ajax({
								           	url:'/Utility/getDivisionVectorMapTypeLayerList',
								            data: {'distid': 0,'divid': paramdivision,'type':23},
								            type: "GET",
								            contentType: "application/json;charset=utf-8",
								            dataType: "json",
								            success :function (obj) {					                   
								                    if(obj!=null)
								                    {	

								                    	dlcFnlLayernm=obj[0].text;
								                    	console.log(dlcFnlLayernm);
								                    	 var query="";
								                    	if($("#ddlRange").val()!="")
							                             {				                                
							                                 query="range_id="+"'"+$( "#ddlRange option:selected" ).val()+"'";	
							                                 console.log(query);
							                             }
								                             if(query!="")
								                             {					                            						                            	 
								                            	 dlcFnl_layer= new ol.layer.Image({
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
							                             else{
							                            	 dlcFnl_layer= new ol.layer.Image({
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
							                            if(dlcFnl_layer!=null)
							                            {
								                              map.addLayer(dlcFnl_layer);
								                              if($("#chkDLCFinal").is(":checked"))
								                             {
								                            	  dlcFnl_layer.setVisible(true);
								                             }
								                             else
								                             {
								                            	 dlcFnl_layer.setVisible(false);
								                             }  
							                                 
							                            }
							                            else{
							                                AlertNotify("DLC Final Boundary of "+$( "#ddlRange option:selected" ).text()+" range is not available.")
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
				   //Button search
					    /* $("#btnSearch").click(function() {
					       //$('#divform').empty();
					       var  dist_id, div_id, tahasil_id, range_code;
					       // status = 0;				      				           
					           dist_id = ($("#ddldist").val() == null || $("#ddldist").val() == "") ? 0 : $("#ddldist").val();
					           div_id = ($("#ddldivision").val() == null || $("#ddldivision").val() == "") ? 0 : $("#ddldivision").val();
					           tahasil_id = ($("#ddlTehsil").val() == null || $("#ddlTehsil").val() == "") ? 0 : $("#ddlTehsil").val();
					           range_code = ($("#ddlRange").val() == null || $("#ddlRange").val() == "") ? "" : $("#ddlRange").val();
					           alert("hi");
					           //$(".apploader-base").css("display", "block");
					           $.ajax({
					               
					        	   url: '/Utility/getDivisionVectorMapTypeLayerList',
					               data: {			                   
					                   'dist_id': dist_id,
					                   'div_id': div_id,
					                   'tahasil_id': tahasil_id,
					                   'range_code': range_code
					               },
					               contentType: 'application/html; charset=utf-8',
					               type: 'GET',
					               dataType: "html",
					               success: function(result) {
					               		if($("#chkRange").is(":checked")){
					               			map.addLayer(range_layer);
					               			allrnglayer.setVisible(true);
					               		} 					               							        					                 
					                	else{
					               		alert("else");
					               	}
					               },
					               		error :function (xhr, status) 
							            {
							                    
							            }
					           });
					       
					   });  */
    //Base map Click 
    $("#blank_basemap").click(function(){
    	 baselayer.setVisible(false);
         googleLayerSatellite.setVisible(false);
         googleLayerStreet.setVisible(false);
    });
    $("#imagery_basemap").click(function(){
   	 baselayer.setVisible(false);
     googleLayerStreet.setVisible(false);
     googleLayerSatellite.setVisible(true);
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
   function addLayer()
   {
	/*    allrnglayer.setVisible(false);
	   alldivboundarylayer.setVisible(false);
	   districtboundarylayer.setVisible(false);
	   stateboundarylayer.setVisible(false);
	   allrnglayer.setVisible(true);
	   alldivboundarylayer.setVisible(true);
	   districtboundarylayer.setVisible(true);
	   stateboundarylayer.setVisible(true); */
	   //console.log(allrnglayer);
	   //console.log(alldivboundarylayer);
	   //console.log(districtboundarylayer);
	   //console.log(allrnglayer);
	  // map.removeLayer(allrnglayer);
	   map.removeLayer(alldivboundarylayer);
	   map.removeLayer(districtboundarylayer);
	   map.removeLayer(stateboundarylayer);
	   //map.addLayer(allrnglayer);
	   map.addLayer(alldivboundarylayer);
	   map.addLayer(districtboundarylayer);
	   map.addLayer(stateboundarylayer);
	   //console.log(layerOrderList);
	   for(var i=0;i<layerOrderList.length;i++)
		   {
		  // map.removeLayer(layerOrderList[i]);
		   //console.log(layerOrderList[i]);
		   }
	   /* for(var i=0;i<layerOrderList.length;i++)
	   {
	   //map.addLayer(layerOrderList[i]);
	   } */
	   
	   
	   for (var i=0; i<map.getLayers().getArray().length; i++){
		 //   console.log(map.getLayers().getArray()[i].getProperties());
		    }; 
		  //  console.log(map.getLayers());
		   // allrnglayer,alldivboundarylayer,districtboundarylayer,stateboundarylayer
   }
    //End Base map click

    
    

