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
map.addLayer(measureLayer);

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
				   // measureTooltipElement.className = 'ol-tooltip ol-tooltip-static';
				  // measureTooltip.setOffset([0, -7]);
				    // unset sketch
				   //sketch = null;
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
				 map.removeOverlay(helpTooltip);
				 map.removeOverlay(measureTooltip);
				  $("div.measure_tooltip").remove();
	            // map.removeInteraction(draw);
	             measureLayer.getSource().clear(); 
			 });