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

