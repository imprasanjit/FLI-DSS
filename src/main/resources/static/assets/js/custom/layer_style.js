/*CMV Style*/
function cmv_style(feature, resolution) {

let cmv_text=(resolution<80 && resolution>9)?feature.get('fb_name'):'';
//alert ('FB NameStyle '+cmv_text);
 return new ol.style.Style({
      /*fill: new ol.style.Fill({
        color: 'rgba(156, 156, 156)',
        opacity:0
      }),*/
       stroke: new ol.style.Stroke({
          color: '#A5FA6D',/*rgba(143, 126, 107)*/
          width: 1.5,
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
            text:cmv_text
            })
    });
    }
    
  function mmv_style(feature, resolution) {
let cmv_text=(resolution<80 && resolution>9)?feature.get('fb_name'):'';
 return new ol.style.Style({
    /*  fill: new ol.style.Fill({
        color: 'rgba(172, 116, 232)',
        opacity:0
      }),*/
       stroke: new ol.style.Stroke({
          color: 'rgba(178 117 234)',
          width: 2,
          /*opacity:0.5,*/
          lineDash: [4],
        }),
         text: new ol.style.Text({
            font: 'bold 12px Ariel Normal',
            fill: new ol.style.Fill({ color: '#000000' }),
 			 stroke: new ol.style.Stroke({
			    color: '#fff', width: 2
			}),
            textAlign: 'top',
            textBaseline: 'bottom',
            text:cmv_text
            })
    });
    }
    
    function nfb_style(feature, resolution) {

let cmv_text=(resolution<80 && resolution>9)?feature.get('fb_name'):'';
 let fbStyle= new ol.style.Style({
      fill: new ol.style.Fill({
        color: '#28a745',
        opacity:0
      }),
       stroke: new ol.style.Stroke({
          color: 'rgba(0, 0, 0)',
          width: 1,
          opacity:0
        }),
         text: new ol.style.Text({
            font: 'bold 12px italic Normal',
            fill: new ol.style.Fill({ color: '#000000' }),
 			 stroke: new ol.style.Stroke({
			    color: '#fff', width: 2
			}),
            textAlign: 'top',
            textBaseline: 'bottom',
            text:cmv_text
            })
    });
     let featureStyle= new ol.style.Style({
      fill: new ol.style.Fill({
        color: '#cfdfcf', //#4cac29
        opacity:0
      }),
       stroke: new ol.style.Stroke({
          color: 'rgba(0, 0, 0)',
          width: 1,
          opacity:0
        }),
         text: new ol.style.Text({
            font: 'bold 12px italic Normal',
            fill: new ol.style.Fill({ color: '#000000' }),
 			 stroke: new ol.style.Stroke({
			    color: '#fff', width: 2
			}),
            textAlign: 'top',
            textBaseline: 'bottom',
            text:cmv_text
            })
    });
    if(feature.get('fb_id')==0) {
    	return featureStyle;
    }
    else
    	return fbStyle;
    	
    }
    
 //rfstyle
 function rf_style(feature) {    
let rf_text=String(feature.get('plot_no'));
 let fbStyle= new ol.style.Style({
      fill: new ol.style.Fill({
        color: '#C7EAB0',
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
            text:rf_text
            })
    });
     let featureStyle= new ol.style.Style({
      fill: new ol.style.Fill({
        color: '#4cac29',
        opacity:0
      }),
       stroke: new ol.style.Stroke({
          color: 'rgba(0, 0, 0)',
          width: 1,
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
            text:rf_text
            })
    });
 	if(feature.get('plot_no')==0) 
    	return featureStyle;
   else
    	return fbStyle;   	
    }
    
 //dlc style
 function dlc_style(feature, resolution) {
	    
	 let dlc_text=String(feature.get('plot_no'));
	  let fbStyle= new ol.style.Style({
	       fill: new ol.style.Fill({
	         color: '#C2FC9B',
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
	             text:dlc_text
	             })
	     });
	      let featureStyle= new ol.style.Style({
	       fill: new ol.style.Fill({
	         color: '#4cac29',
	         opacity:0
	       }),
	        stroke: new ol.style.Stroke({
	           color: 'rgba(0, 0, 0)',
	           width: 1,
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
	             text:dlc_text
	             })
	     });
	  if(feature.get('plot_no')==0) 
	     	return featureStyle;
	    else
	     	return fbStyle;	
	     }
	     
  //Tehasil style
       function tahsil_style(feature, resolution) {
    	    
    	   let tahasil_text=(resolution<13 && resolution>9)?feature.get('tah_id'):'';
    	    let tahStyle= new ol.style.Style({
    	         fill: new ol.style.Fill({
    	           color: '#7af5a5',
    	           opacity:0
    	         }),
    	          stroke: new ol.style.Stroke({
    	             color: '#00FFFFFF',
    	             width: 0.5,
    	             opacity:0
    	           }),
    	            /*text: new ol.style.Text({
    	               font: 'bold 12px Ariel Normal',
    	               fill: new ol.style.Fill({ color: '#000000' }),
    	    			 stroke: new ol.style.Stroke({
    	   			    color: '#fff', width: 2
    	   			}),
    	               textAlign: 'top',
    	               textBaseline: 'bottom',
    	               text:tahasil_text
    	               })*/
    	       });
    	        let featureStyle= new ol.style.Style({
    	         fill: new ol.style.Fill({
    	           color: '#4cac29',
    	           opacity:0
    	         }),
    	          stroke: new ol.style.Stroke({
    	             color: 'rgba(0, 0, 0)',
    	             width: 1,
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
    	               text:tahasil_text
    	               })
    	       });
    	    if(feature.get('tah_id')==$("#hdn_tid").val()) 
    	       	return featureStyle;
    	      else
    	       	return tahStyle;
    	       	
    	       }
    	       
    	       
  /*Style according to survey type*/
  function nfb_survey_style(feature, resolution) {
  let isShowNFBLabel= $( "#btnnotation" ).hasClass( "note" )
  //$("#btnnotation").prop("checked", true);
  //console.log(isShowNFBLabel);
  //$('#btnnotation').is(':checked');
  
var color = ol.color.asArray(feature.get('colorcode'));
color = color.slice();
color[3] = 0.6;
 return cmvStyle= new ol.style.Style({
      fill: new ol.style.Fill({
	         color: color,  
	       }),
    stroke: new ol.style.Stroke({
    	             color: feature.get('colorcode'),
    	             width: 2,
    	             
    	           }),
         text: new ol.style.Text({
            font: '12px Arial Normal',
            fill: new ol.style.Fill({ color: '#ffff' }),
 			 /*stroke: new ol.style.Stroke({
			    color: '#fff', width: 2
			}),*/
            textAlign: 'top',
            textBaseline: 'bottom',
             text:isShowNFBLabel?feature.get('fb_name')+ ' ' +feature.get('fb_type'):''
            //text:feature.get('fb_name')
            })
    });
   
 /*  let labelStyle = new Style({
  text: new Text({
    font: '12px Calibri,sans-serif',
    overflow: true,
    fill: new Fill({
      color: '#000',
    }),
    stroke: new Stroke({
      color: '#fff',
      width: 3,
    }),
  }),
});*/
    }
   
   
/*Feature Style NFB*/
 function Highlightfeature_style() {
 return Style= new ol.style.Style({
    
    stroke: new ol.style.Stroke({
    	             color: 'blue',
    	             width: 2,
    	             
    	           })
        
    });
    }

 /*RF Style without feature*/
 function rforest_style(feature) {
 return rfStyle= new ol.style.Style({
    fill: new ol.style.Fill({
        color: '#C7EAB0',
        opacity:0
      }),
    stroke: new ol.style.Stroke({
    	             color: '#00FFFFFF',
    	             width: 0.5,
    	             
    	           }),
     text: new ol.style.Text({
            font: 'bold 12px Ariel Normal',
            fill: new ol.style.Fill({ color: '#000000' }),
 			 stroke: new ol.style.Stroke({
			    color: '#fff', width: 2
			}),
            textAlign: 'top',
            textBaseline: 'bottom',
            text:feature.get('village')
            })    
    });
    }
    
 /*DLC and Revenue Style*/
 function rev_dlc_style(feature, resolution) {
  
	let isShowRfLabel= $( "#btnnotation2" ).hasClass( "note" )
	//$("#btnnotation2").toggle(this.checked);
	//$('#btnnotation2').is(':checked');
	  let revStyle= new ol.style.Style({
	       fill: new ol.style.Fill({
	         color: '#ffc107',
	         //#ADFF2F
	         opacity:1
	       }),
	        stroke: new ol.style.Stroke({
	           color: '#808080',
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
	              text:isShowRfLabel?(feature.get('rplot_no')+ ', ' + feature.get('village')):''
	             })
	     });
	      let dlcStyle= new ol.style.Style({
	       fill: new ol.style.Fill({
	         color: '#007bff',
	         //#9ACD32
	         opacity:0
	       }),
	        stroke: new ol.style.Stroke({
	           color: '#778899',
	           width: 1,
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
	             text:isShowRfLabel?(feature.get('rplot_no')+ ', ' + feature.get('village')):''
	             })
	     });
	  if(feature.get('dlc')=='Y') 
	     	return dlcStyle;
	    else
	     	return revStyle;	
  }
	     
	/*District Style*/
 function district_style() {

	 return dist_style= new ol.style.Style({
	    fill: new ol.style.Fill({
	        color: '#C7EAB0',
	        opacity:0
	      }),
	    stroke: new ol.style.Stroke({
	    	             color: '#00FFFFFF',
	    	             width: 0.5,
	    	             
	    	           }),
	     text: new ol.style.Text({
	            font: 'bold 12px Ariel Normal',
	            fill: new ol.style.Fill({ color: '#000000' }),
	 			 stroke: new ol.style.Stroke({
				    color: '#fff', width: 2
				}),
	            textAlign: 'top',
	            textBaseline: 'bottom',
	            /*text:feature.get('dist_name')*/
	            })    
	    });
    }
    
   /*CAF Style*/
   
    function ca_style(feature)
    {
    	let isShowCALabel= $( "#btnnotation3" ).hasClass( "note" )
	    let caStyle= new ol.style.Style({
	       fill: new ol.style.Fill({
	         color: '#c7eab0',
	         opacity:1
	       }),
	        stroke: new ol.style.Stroke({
	           color: '#808080',
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
	              text:isShowCALabel?(feature.get('rplot_no')+ ', ' + feature.get('village')):''
	             })
	     });
	      
	     	return caStyle;
    }