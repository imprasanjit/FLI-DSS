var polygonDraw, kmlLayer;
var layersArray=new Array();
var drawSource = new ol.source.Vector({wrapX: false})

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

var myView = new ol.View({
    Layers:[drawLayer],
    center: ol.proj.fromLonLat([84.6525554, 20.1664539]),
        zoom: 6.89,
        maxZoom: 20,
        minZoom: 5
}) 

var map = new ol.Map({
    view: myView,
    target: 'map',
    controls: ol.control.defaults({attribution: false}).extend([new ol.control.FullScreen()])
});
