//load BaseLayers
$.getScript('/assets/js/apps/baseLayers.js', function () {});

  //Load Administrative Layers
 //$.getScript('/assets/js/fld/allCommonBoundary.js', function () {});

    //Messurement tool
    //$.getScript('/assets/js/fld/measurement.js', function () {

    //});
     
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
          	
          	console.log('second execute....');

            this.checked ? layer.setVisible(true) : layer.setVisible(false);

          }

        })
      }

    } catch (error) {
      console.log('AddRemoveLayer using CheckBox CheckChange: ' + error);
    }
    /* End of AddRemove Layers using CheckBox ChangeEvent */