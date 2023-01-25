<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<tl:eval expression="@environment.getProperty('api.geoserverurl')" var="geoserverUrl"></tl:eval>

<%@ include file="../shared/query_header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css" type="text/css">
<script src="https://unpkg.com/elm-pep"></script>
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <script src="https://cdn.polyfill.io/v3/polyfill.min.js?features=fetch,requestAnimationFrame,Element.prototype.classList,URL,TextDecoder"></script>
    <script src="https://unpkg.com/dom-to-image-more@2.8.0/dist/dom-to-image-more.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
    <script src="https://unpkg.com/elm-pep"></script>

 <style>
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
 </style>  
    
    <script>
        $(document).ready(function(){
        	//$("#loader").hide();
        	$(".header-title-lg").text("FLI DSS (Forest Land Information)");
        	if(${infoBoxFli!=null && infoBoxFli==true}){
        		$('#infoModal').modal({
                    backdrop: 'static',
                    keyboard: false
                })
            $("#infoModal").modal('show');
           
        	}else{
        		$("#infoModal").modal('hide');
        	}
            
        });
    </script>
    <div class="loader-base"><div class="loader"></div></div>
    <!--  BEGIN CONTENT AREA  -->
        <div id="content" class="main-content">
            <div class="layout-px-spacing">

                <div class="row layout-top-spacing">

                    <div class="col-md-12 layout-spacing">
                        <div class="statbox widget box box-shadow">
                            <!-- <div class="widget-header">
                                <div class="row">
                                    <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                        <h4>Select Polygon</h4>
                                    </div>
                                </div>
                            </div> -->
                            <div class="widget-content widget-content-area">
                                
                                <div class="mapFilterBase col-md-3 col-sm-6 col-xs-12">
                
                                    <div id="accordion" class="mapFilter">
                                        <div class="map-tab-fix row m-0">
                                            <!-- <a id="" href="#collapseOne" class="text-dark col collapsed bs-tooltip" data-toggle="collapse" aria-expanded="true" aria-controls="collapseOne" title="Filter">
                                                <span class="d-block"><img src="/assets/img/icon-filter.png"></span>
                                            </a> -->

                                            <a id="" href="#collapseTwo" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="true" aria-controls="collapseTwo" title="Layers">
                                                <span class="d-block"><img src="/assets/img/icon-layers.png"></span>
                                            </a>
                                            <a id="" href="#collapseThree" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseThree" title="Legends">
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

                                            <a id="a_reset" href="#collapseSeven" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseSeven" title="Reset">
                                                <span class="d-block"><img src="/assets/img/icon-reset.png"></span>
                                            </a>
                                            <a id="" href="#collapseEight" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseEight" title="Print">
                                                <span class="d-block"><img src="/assets/img/icon-print.png"></span>
                                            </a>
                                        </div>

                                        <div class="clearfix"></div>

                                        <!-- <div class="mb-0">
                                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="fixHeightRight">
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne"><span aria-hidden="true">�</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">AOI Details</h6>
                                                                <div id="accordion3">
                                                                    <a id="" href="#collapse11" class="collapsed icon-header" data-toggle="collapse" aria-expanded="true" aria-controls="collapse11">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-3">Select AOI<i class="fa fa-angle-down pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse11" class="collapse show" aria-labelledby="heading11" data-parent="#accordion3">
                                                                        <form>
                                                                            <div class="row">
                                                                                <div class="col-md-12 form-group mb-2">
                                                                                    <select class="form-control-sm" id="">
                                                                                        <option selected="selected">Select District</option>
                                                                                        <option>2</option>
                                                                                        <option>3</option>
                                                                                        <option>4</option>
                                                                                        <option>5</option>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-md-12 form-group mb-2">
                                                                                    <select class="form-control-sm" id="">
                                                                                        <option selected="selected">Select Division</option>
                                                                                        <option>2</option>
                                                                                        <option>3</option>
                                                                                        <option>4</option>
                                                                                        <option>5</option>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-md-12 form-group mb-2">
                                                                                    <select class="form-control-sm" id="">
                                                                                        <option selected="selected">Select Range</option>
                                                                                        <option>2</option>
                                                                                        <option>3</option>
                                                                                        <option>4</option>
                                                                                        <option>5</option>
                                                                                    </select>
                                                                                </div>
                                                                            </div>                                                                         
                                                                        </form>
                                                                    </div>
                                                                    <a id="" href="#collapse12" class="collapsed icon-header" data-toggle="collapse" aria-expanded="false" aria-controls="collapse12">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">Notified FB<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse12" class="collapse" aria-labelledby="heading12" data-parent="#accordion3">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkState">
                                                                                        <label class="custom-control-label" for="chkState">MMV</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="checkbox62">
                                                                                        <label class="custom-control-label" for="checkbox62">CMV</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="checkbox63">
                                                                                        <label class="custom-control-label" for="checkbox63">JV (Draft)</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="checkbox64">
                                                                                        <label class="custom-control-label" for="checkbox64">JV (Final)</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="checkbox65">
                                                                                        <label class="custom-control-label" for="checkbox65">DGPS (Draft)</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="checkbox66">
                                                                                        <label class="custom-control-label" for="checkbox66">DGPS (Final)</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                    <a id="" href="#collapse13" class="collapsed icon-header" data-toggle="collapse" aria-expanded="false" aria-controls="collapse13">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">Select Active Layer<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse13" class="collapse" aria-labelledby="heading13" data-parent="#accordion3">
                                                                        <form>
                                                                            <div class="row">
                                                                                <div class="col-md-12 form-group mb-2">
                                                                                    <select class="form-control-sm" id="">
                                                                                        <option selected="selected">Select Layer</option>
                                                                                        <option>2</option>
                                                                                        <option>3</option>
                                                                                        <option>4</option>
                                                                                        <option>5</option>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                    <div class="clearfix"></div>
                                                                 </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> -->

                                        <div class="mb-0">
                                            <div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordion">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="fixHeightRight">
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><span aria-hidden="true">�</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Layers</h6>
                                                                
                                                                <div id="accordion2">
                                                                    <a id="" href="#collapse1" class="collapsed" data-toggle="collapse" aria-expanded="true" aria-controls="collapse1">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-3">Administrartive Boundary<i class="fa fa-angle-down pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse1" class="collapse show" aria-labelledby="heading1" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" checked id="chkState">
                                                                                        <label class="custom-control-label" for="chkState">State Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" checked id="chkDistrict">
                                                                                        <label class="custom-control-label" for="chkDistrict">District Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkDivision">
                                                                                        <label class="custom-control-label" for="chkDivision">Division Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkRange">
                                                                                        <label class="custom-control-label" for="chkRange">Range Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkTehsil">
                                                                                        <label class="custom-control-label" for="chkTehsil">Tahasil Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkVillage">
                                                                                        <label class="custom-control-label" for="chkVillage">Village Boundary</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                   <!--  <span class="spInfo">* Search District/ Division to View other Layers</span> -->
                                                                    
                                                                    <a id="" href="#collapse2" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse2">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">Notified Forest Boundary<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse2" class="collapse" aria-labelledby="heading2" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkCMV">
                                                                                        <label class="custom-control-label" for="chkCMV">Cadastral Map Vector(CMV)</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkMMV">
                                                                                        <label class="custom-control-label" for="chkMMV">Management Map Vector(MMV)</label>
                                                                                    </div>
                                                                                    <!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkDraftJV">
                                                                                        <label class="custom-control-label" for="checkbox33">Draft JV</label>
                                                                                    </div> -->
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkFinalJV">
                                                                                        <label class="custom-control-label" for="chkFinalJV">Final JV</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkDraftDGPS">
                                                                                        <label class="custom-control-label" for="chkDraftDGPS">Draft DGPS</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkFinalDGPS">
                                                                                        <label class="custom-control-label" for="chkFinalDGPS">Final DGPS</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                    <a id="" href="#collapse3" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">Revenue Forest Boundary<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse3" class="collapse" aria-labelledby="heading3" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                   <!--  <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkRFDraft">
                                                                                        <label class="custom-control-label" for="chkRFDraft">RF Boundary Draft</label>
                                                                                    </div> -->
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkRFFinal">
                                                                                        <label class="custom-control-label" for="chkRFFinal">RF Boundary Final</label>
                                                                                    </div>
                                                                                    <!-- <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkDLCDraft">
                                                                                        <label class="custom-control-label" for="chkDLCDraft">DLC Draft</label>
                                                                                    </div> -->
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkDLCFinal">
                                                                                        <label class="custom-control-label" for="chkDLCFinal">DLC Final</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>    
                                                                     <a id="" href="#collapsef" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">FCM<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapsef" class="collapse" aria-labelledby="heading3" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkFC-1">
                                                                                        <label class="custom-control-label" for="checkbox41">FCM-2000</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkFC-2">
                                                                                        <label class="custom-control-label" for="checkbox42">FCM-2002</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkFC-3">
                                                                                        <label class="custom-control-label" for="checkbox43">FCM-2004</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkFC-4">
                                                                                        <label class="custom-control-label" for="checkbox43">FCM-2008</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>   
                                                                    <a id="" href="#collapse4" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">Diverted Forest Land<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse4" class="collapse" aria-labelledby="heading4" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkDFDraft">
                                                                                        <label class="custom-control-label" for="checkbox41">DF Boundary Draft</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkDFFinal">
                                                                                        <label class="custom-control-label" for="checkbox42">DF Boundary Final</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>  
                                                                     <a id="" href="#collapse5" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4"><i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>  
                                                                      <div id="collapse5" class="collapse" aria-labelledby="heading4" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkCAFDraft">
                                                                                        <label class="custom-control-label" for="checkbox41">CAF Land Draft</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkCAFFinal">
                                                                                        <label class="custom-control-label" for="checkbox42">CAF Land Final</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>  
                                                                      <a id="" href="#collapse6" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">WildLife<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse6" class="collapse" aria-labelledby="heading5" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkWLBoundary">
                                                                                        <label class="custom-control-label" for="checkbox41">WL Division Boundary</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkWLCDraft">
                                                                                        <label class="custom-control-label" for="checkbox42">WL corridor Draft</label>
                                                                                    </div>
                                                                                     <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkWLCFinal">
                                                                                        <label class="custom-control-label" for="checkbox42">WL corridor Final</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>    
                                                                           <a id="" href="#collapse7" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">PA Boundary<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse7" class="collapse" aria-labelledby="heading5" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkPADraft">
                                                                                        <label class="custom-control-label" for="checkbox41">PA Boundary Draft</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkPAFinal">
                                                                                        <label class="custom-control-label" for="checkbox42">PA Boundary Final</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div> 
                                                                           <a id="" href="#collapse8" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">Eco Sensitive Zone<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse8" class="collapse" aria-labelledby="heading5" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkESZDraft">
                                                                                        <label class="custom-control-label" for="checkbox42">ESZ Draft</label>
                                                                                    </div>
                                                                                     <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkESZFinal">
                                                                                        <label class="custom-control-label" for="checkbox42">ESZ Final</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div> 
                                                                           <a id="" href="#collapse9" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">Sanctuary Areas<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse9" class="collapse" aria-labelledby="heading5" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">                                                                
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkSanctuaryDraft">
                                                                                        <label class="custom-control-label" for="checkbox42">Sanctuary boundary Draft</label>
                                                                                    </div>
                                                                                     <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkSanctuaryFinal">
                                                                                        <label class="custom-control-label" for="checkbox42">Sanctuary boundary Final</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div> 
                                                                           <a id="" href="#collapse10" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">Hydrological Layers<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse10" class="collapse" aria-labelledby="heading5" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkRiver">
                                                                                        <label class="custom-control-label" for="checkbox41">Rivers</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkReservoir">
                                                                                        <label class="custom-control-label" for="checkbox42">Reservoirs</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>    
                                                                            <a id="" href="#collapse11" class="collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="collapse3">
                                                                        <h6 class="mt-0 header-title map-title-secondary mb-4">Transport Layers<i class="fa fa-angle-right pull-right"></i></h6>
                                                                    </a>
                                                                    <div id="collapse11" class="collapse" aria-labelledby="heading5" data-parent="#accordion2">
                                                                        <form>
                                                                            <div class="row form-group">
                                                                                <div class="col-md-12">
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkRoad">
                                                                                        <label class="custom-control-label" for="checkbox41">Road</label>
                                                                                    </div>
                                                                                    <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                        <input type="checkbox" class="custom-control-input" id="chkRailway">
                                                                                        <label class="custom-control-label" for="checkbox42">Railway</label>
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
                                        </div>

                                        <div class="mb-0">
                                            <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="fixHeightRight">
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree"><span aria-hidden="true">�</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Legends</h6>
                                                                <div class="row">
                                                                    <div class="col-md-12 ml-1">
                                                                        <div class="legendbox">
                                                                            <img src="/assets/img/state_boundary.png">
                                                                            <span>State Boundary</span>
                                                                        </div>
                                                                        <div class="legendbox">
                                                                            <img src="/assets/img/district_boundary.png">
                                                                            <span>District Boundary</span>
                                                                        </div>
                                                                        <div class="legendbox">
                                                                            <img src="/assets/img/division_boundary.png">
                                                                            <span>Division Boundary</span>
                                                                        </div>
                                                                        <div class="legendbox">
                                                                            <img src="/assets/img/legend-04.png">
                                                                            <span>Tehsil Boundary</span>
                                                                        </div>
                                                                        <div class="legendbox">
                                                                            <img src="/assets/img/range_boundary.png">
                                                                            <span>Range Boundary</span>
                                                                        </div>
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
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour"><span aria-hidden="true">�</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Basemap</h6>
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                            <!-- <div class="custom-control custom-checkbox checkbox-info">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox21">
                                                                                <label class="custom-control-label" for="checkbox21">Terrian</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox22">
                                                                                <label class="custom-control-label" for="checkbox22">OSM</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox23">
                                                                                <label class="custom-control-label" for="checkbox23">Cartography</label>
                                                                            </div> -->
                                                                               <div class="tab-box">
																	    	<ul class="basesection">
																	    		<li>
																	    			<a id="blank_basemap" class="basebox"><img src="/assets/img/icon-blank.png"><h6>Blank</h6></a>
																	    		</li>
																	    		<li>
																				<a id="imagery_basemap"  class="basebox"><img src="/assets/img/icon-imagery.png"><h6>Imagery</h6></a>
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

                                        <div class="mb-0">
                                            <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordion">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="fixHeightRight">
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">�</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Measurement</h6>
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                           <!--  <div class="form-check">
                                                                                <div class="custom-control custom-radio classic-radio-info">
                                                                                    <input type="radio" id="hRadio1" name="classicRadio" class="custom-control-input">
                                                                                    <label class="custom-control-label" for="hRadio1">Area</label>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <div class="custom-control custom-radio classic-radio-info">
                                                                                    <input type="radio" id="hRadio2" name="classicRadio" class="custom-control-input">
                                                                                    <label class="custom-control-label" for="hRadio2">Distance</label>
                                                                                </div>
                                                                            </div> -->
                                                                             <div class="row">
																		   <div class="col-md-4 mt-2">
																					 <label for="type" class="font-12">Measurement type &nbsp;</label>
														                    </div>
														                    <div class="col-md-8 mt-2">
														                    <select id="type" class="form-control form-control-sm custom-adj">
																	        <option value="length">Length (LineString)</option>
																	        <option value="area">Area (Polygon)</option>
																	      </select>
																	      <div id="helpTooltipElement"></div>
														                    </div>
														                
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
										<div class="mb-0">
                                            <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordion">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="fixHeightRight">
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">�</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Info</h6>
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                            <div class="row">
																		   <div class="col-md-4 mt-2">
																					<label class="font-12 pt-2">Active Layer</label>
														                    </div>
														                    <div class="col-md-8 mt-2">
														                    <select id="ddlActiveLayer" class="form-control form-control-sm custom-adj">
																					
																					<option value="">Select Layer</option>
																					<option value="stateboundarylayer">State Boundary</option>
																					<option value="districtboundarylayer">District Boundary</option> 
																				</select>
														                    </div>
														                
																		</div>
																	<div class="row" id="activeNote">
																	<div class="col-md-12 mt-2">
																		<span style="color: red; font-size:14px;">Note:- Choose any Layer
																			to view Layer info</span>
																	</div>
																	</div>
																</div>
                                                                        <div id="infodiv"></div>
                                                                     <div id="popup" class="ol-popup">
																	    <a href="#" id="popup-closer" class="ol-popup-closer"></a>
																	    <div id="popup-content"></div>
																	</div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mb-0">
                                            <div id="collapseEight" class="collapse" aria-labelledby="headingEight" data-parent="#accordion">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="fixHeightRight">
                                                            <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseEight" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">�</span></button>
                                                            <div class="card-body custom-card-body">
                                                                <h6 class="mt-0 page-title mb-3">Export Map</h6>
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                            	<div class="row">
																			   <div class="col-md-12 text-center">
																						<button type="button" id="btnExportpdf"  class="btn btn-sm btn-warning" data-toggle="modal" data-target="#printModal">Export PDF</button>
															                    
															                    <button type="button" id="btnExportImage" class="btn btn-sm btn-warning" class="btn" data-toggle="modal" data-target="#imgprintModal">Export Image</button>
															                    </div>
															                
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
                                    </div><!--/accordion-->
                    
                                </div>
								
                                <div id="map" class="fixHeightLeft panel">
                                   <!--  <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834859.9797965377!2d82.19173433935192!3d20.176539522401498!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a226aece9af3bfd%3A0x133625caa9cea81f!2sOdisha!5e0!3m2!1sen!2sin!4v1564120416120!5m2!1sen!2sin" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe> -->
                                </div>                                

                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <!--  END CONTENT AREA  -->
   
   <div id="infoModal" class="modal fade modal-info-custom">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <h5 class="title">About Forest Land Information</h5>
                    <img src="/assets/img/modal-forest-land-info.jpg" class="img-fluid img-thumbnail float-left mr-3 mb-1 w-50">
                    <p>Forest land information facilitates map view of different types of forest lands (notified forests, revenue forests and other deemed forests) in a selected jurisdiction such as a District or Forest Division. User can also view the map with different overlays such as SOI topo maps, FSI forest cover maps, Satellite Image and other open-source web maps.</p>
                    <div class="clearfix"></div>
                    <hr>
                    <div class="text-center">
                        <div class="custom-control custom-checkbox checkbox-info mb-3">
                            <input type="checkbox" class="custom-control-input" id="chkDontShow">
                            <label class="custom-control-label" for="chkDontShow">Don't show this again</label>
                        </div>
                        <button type="button" id="btnDontShow" class="btn btn-success" data-dismiss="modal">Launch Forest Land Information</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="printModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Export Map (PDF)</h5>
                        <button type="button" id="btnPdfModalClose" class="close" data-dismiss="modal" aria-label="Close">
                          <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <div class="table-responsive">
                        <form id="pdfForm">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Page Size</strong></td>
                                        <td><select id="format" class="form-control custom-adj">
									        <option value="a0">A0 (slow)</option>
									        <option value="a1">A1</option>
									        <option value="a2">A2</option>
									        <option value="a3">A3</option>
									        <option value="a4" selected>A4</option>
									        <option value="a5">A5 (fast)</option>
									      </select>
									     </td>
                                        
                                    </tr>
                                    <tr>
                                        <td><strong>Resolution</strong></td>
                                        <td><select id="resolution" class="form-control custom-adj">
									        <option value="72">72 dpi (fast)</option>
									        <option value="150">150 dpi</option>
									        <option value="200" selected>200 dpi</option>
									        <option value="300">300 dpi (slow)</option>
									      </select></td>
                                    </tr>
                                  <!--   <tr>
                                        <td><strong>Scale</strong></td>
                                        <td><select id="scale">
								        <option value="500">1:500000</option>
								        <option value="250" selected>1:250000</option>
								        <option value="100">1:100000</option>
								        <option value="50">1:50000</option>
								        <option value="25">1:25000</option>
								        <option value="10">1:10000</option>
								      </select></td>
                                    </tr> -->
                                    <tr>
                                        <td><strong>File Name</strong></td>
                                        <td><input id="txtPdfName" name="txtPdfName" required type="text" class="form-control custom-adj"/>
                                        <span id="lblpdfError" style="color:red;display:none;">File Name is required.</span>
                                        </td>
                                    </tr>
                                    
                                </tbody>
                                <tfoot>
                                <tr style="text-align:center">
                                        <td colspan="2" ><button id="btnExport" type="button">Export</button></td>
                                    </tr>
                                </tfoot>
                            </table>
                            </form>
                            <!--  -->
                        </div>

                    </div>
                </div>
            </div>
        </div>
     <div class="modal fade" id="imgprintModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Export Map (Image)</h5>
                        <button type="button" id="btnImageModalClose" class="close" data-dismiss="modal" aria-label="Close">
                          <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <div class="table-responsive">
                        <form id="imageForm">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Image Format</strong></td>
                                        <td><select id="imgformat" class="form-control custom-adj">
									        <option value="jpeg">jpeg</option>
									        <option value="jpeg">jpg</option>
									        <option value="png" selected>png</option>
									      </select>
									     </td>
                                        
                                    </tr>
                                    <tr>
                                        <td><strong>Image Name</strong></td>
                                        <td><input id="txtImageName" name="txtImageName" required type="text" class="form-control custom-adj"/>
                                        <span id="lblimgError" style="color:red;display:none;">File Name is required.</span>
                                        <a id="image-download" ></a>
                                        </td>
                                    </tr>
                                    
                                </tbody>
                                <tfoot>
                                <tr style="text-align:center">
                                        <td colspan="2" ><button id="btnImageExport" type="button">Export</button></td>
                                    </tr>
                                </tfoot>
                            </table>
                            </form>
                            <!--  -->
                        </div>

                    </div>
                </div>
            </div>
        </div>
    <script src="/assets/js/libs/jquery-3.1.1.min.js"></script>
     
   <!--  <script>
       
        $(document).ready(function() {
            App.init();
            /* $("#infoModal").modal('hide'); */
            $(".header-title-lg").text("FLI DSS (Forest Land Information)");
           
        });
    </script>  -->
<!--    <script src="/v5.3.0-dist/ol.js"></script> -->
<!--    <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/build/ol.js"></script> -->
 <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
<script src="https://epsg.io/32645.js"></script>
<script src="/v5.3.0-dist/32644.js"></script>

<script type="text/javascript">
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
        url: '${geoserverUrl}/FLI_DSS_STATE/wms',
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
        url: '${geoserverUrl}/FLI_DSS_DISTRICT/wms',
        params: {
        'LAYERS': 'FLI_DSS_DISTRICT:DistrictBoundary',
        'VERSION': '1.1.0'     
        },
        serverType: 'geoserver',
        crossOrigin: 'anonymous'
        
    }),
    visible:true
    });
 alldivboundarylayer = new ol.layer.Image({
    source: new ol.source.ImageWMS({
        url: '${geoserverUrl}/FLI_DSS_DIVISION/wms',
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
        url: '${geoserverUrl}/FLI_DSS_RANGE/wms',
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
</script>

    
    <script type="text/javascript">
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
    
    $("#a_reset").click(function(){
        window.location.href='/FLD/forestLandInfo';
    });
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
    </script>
    
    
 <%@ include file="../shared/footer.jsp"%> 

<script type="text/javascript">
$("#btnDontShow").click(function() {
   if($("#chkDontShow").is(":checked")){
	   $.ajax({
           url: '/api/Utility/dontShowAgain',
           data: {'sessionName':'infoBoxFli' },
           contentType: 'application/html; charset=utf-8',
           type: 'GET',
           dataType: "html",
       })
   }
        });
</script>
 <script src="/assets/js/custom/layer_style.js"></script>   
 
 