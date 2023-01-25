<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<tl:eval expression="@environment.getProperty('api.geoserverurl')" var="geoserverUrl"></tl:eval>

<%-- <%@ include file="../shared/query_header.jsp"%> --%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css" type="text/css">
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
       /*  .ol-unselectable .ol-zoom-in, .ol-unselectable .ol-zoom-out{
        	display: none;
        } */
        .map-topbar{
        	margin-top: -12px;
        }
      .ol-zoom{
      	top: 2.5em !important;
	    right: 0.5em !important;
	    left: auto !important;
      }
 </style>  
   
    
    <div class="loader-base"><div class="loader"></div></div>
    <!--  BEGIN CONTENT AREA  -->
        <div id="content" class="main-content">
            <div class="layout-px-spacing">

                <div class="row layout-top-spacing">
                
                 <div class="col-md-3 layout-spacing">
                    <div class="statbox widget box box-shadow">                            
                        <div class="widget-content widget-content-area">
                        	
                        	<div id="accordion" class="mapFilter mapFilterBase2 fixHeightLeft">
                                <div class="map-tab-fix row m-0">
                                    <a id="" href="#collapseOne" class="text-dark col collapsed bs-tooltip" data-toggle="collapse" aria-expanded="true" aria-controls="collapseOne" title="Area of Interest">
                                        <span class="d-block"><img src="/assets/img/icon-filter.png"></span>
                                    </a>

<!--                                     <a id="" href="#collapseTwo" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseTwo" title="Layers">
                                        <span class="d-block"><img src="/assets/img/icon-layers.png"></span>
                                    </a> -->
                                    <a id="" href="#collapseThree" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseThree" title="Legends">
                                        <span class="d-block"><img src="/assets/img/icon-legends.png"></span>
                                    </a>
                                    <a id="" href="#collapseFour" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseFour" title="Basemap">
                                        <span class="d-block"><img src="/assets/img/icon-basemap.png"></span>
                                    </a>
                                    <a id="a_measure" href="#collapseFive" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseFive" title="Measurement">
                                        <span class="d-block"><img src="/assets/img/icon-measurement.png"></span>
                                    </a>
                                    <a id="a_reset" href="#collapseSeven" class="text-dark col collapsed bs-tooltip feature" data-toggle="collapse" aria-expanded="false" aria-controls="collapseSeven" title="Reset">
                                        <span class="d-block"><img src="/assets/img/icon-reset.png"></span>
                                    </a>                                    
                                </div>

                                <div class="clearfix"></div>

                                <div class="mb-0">
                                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="fixHeightRight">
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne"><span aria-hidden="true">�</span></button> -->
                                                    <div class="card-body custom-card-body">
                                                        <h6 class="mt-0 page-title mb-2">Area of Interest</h6>
                                                        <div class="mb-2">
                                                        	<strong>Division : </strong><span>${dMasterName.chrvDivisionNm}</span>
                                                            <input type="hidden" id="hdnDivid" name="hdnDivid" value=${dMasterName.intId}>
                                                        </div>
                                                        <h6 class="mt-0 page-title mb-2">Selected Layers</h6>
                                                        
                                                        <div id="accordionSelectedProj">
                               
                                  <c:forEach var="item" items="${layers.stream().filter(f->f.getPid()==null).toList()}">
                                    <a id="" href="#collapse${item.id}" class="collapsed icon-header" data-toggle="collapse" aria-expanded="${item.id==1?true:false}" aria-controls="collapse${item.id}">
                                        <h6 class="mt-0 header-title map-title-secondary mb-3">${item.name}<i class="fa fa-angle-down pull-right"></i>
                                        
                                        </h6>
                                    </a>
                                    
                                     <div id="collapse${item.id}" class="collapse ${item.id==1?'show':''} border-light" aria-labelledby="heading1" data-parent="#accordionSelectedProj">
                                        <form>
                                            <div class="row form-group mt-2">
                                                <div class="col-md-12">
                                                
                                                <!-- Bind Layers Check box List -->
                                                <c:forEach var="layer" items="${layers.stream().filter(f-> f.getPid().getId()==item.id).toList()}">
                                                
                                                <c:choose>
                                                <c:when test="${!ActiveLayers.stream().filter(f-> f.id==layer.id).toList().isEmpty()}">
                                                <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                        <input type="checkbox" class="custom-control-input" checked value="${layer.id}" id="chkds${layer.id}" >
                                                        <!-- onchange="chkLayersCheckChange(this)" -->
                                                        <label class="custom-control-label" id="lblLayer${layer.id}" for="chkds${layer.id}">${layer.name}</label>
                                                    </div>
                                                </c:when>
                                                
                                                <c:otherwise>
                                                <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                        <input type="checkbox" class="custom-control-input" disabled="true" value="${layer.id}" id="chkds${layer.id}" >
                                                        <label class="custom-control-label" id="lblLayer${layer.id}" for="chkds${layer.id}">${layer.name}</label>
                                                    </div>
                                                </c:otherwise>
                                                
                                                </c:choose>
              
                                                </c:forEach>
                                                
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    </c:forEach>
                                
                                
                               
                                 </div>
                                
      
                                                       <%--  <div id="accordion3">
                                                            <a id="" href="#collapse11" class="collapsed icon-header" data-toggle="collapse" aria-expanded="true" aria-controls="collapse11">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-3">Forest Land Type<i class="fa fa-angle-down pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse11" class="collapse show" aria-labelledby="heading11" data-parent="#accordion3">
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkState101" checked>
                                                                                <label class="custom-control-label" for="chkState101">Notified Forest</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox102" checked>
                                                                                <label class="custom-control-label" for="checkbox102">DLC & Other Revenue Forest</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox103" disabled>
                                                                                <label class="custom-control-label" for="checkbox103">Deemed Forest</label>
                                                                            </div>                                                                            
                                                                        </div>
                                                                    </div>                                                                         
                                                                </form>
                                                            </div>
                                                            <a id="" href="#collapse12" class="collapsed icon-header" data-toggle="collapse" aria-expanded="false" aria-controls="collapse12">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Administrative Boundary<i class="fa fa-angle-right pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse12" class="collapse" aria-labelledby="heading12" data-parent="#accordion3">
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkState61" checked>
                                                                                <label class="custom-control-label" for="chkState61">District</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox62" checked>
                                                                                <label class="custom-control-label" for="checkbox62">Tehsil</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox63" disabled>
                                                                                <label class="custom-control-label" for="checkbox63">Block</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox64" disabled>
                                                                                <label class="custom-control-label" for="checkbox64">Village</label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <a id="" href="#collapse13" class="collapsed icon-header" data-toggle="collapse" aria-expanded="false" aria-controls="collapse13">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Forest Administrative Boundary<i class="fa fa-angle-right pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse13" class="collapse" aria-labelledby="heading13" data-parent="#accordion3">
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkState111" checked>
                                                                                <label class="custom-control-label" for="chkState111">Division</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox112" disabled>
                                                                                <label class="custom-control-label" for="checkbox112">Range</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox113" disabled>
                                                                                <label class="custom-control-label" for="checkbox113">Section</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox114" disabled>
                                                                                <label class="custom-control-label" for="checkbox114">Beat</label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <a id="" href="#collapse14" class="collapsed icon-header" data-toggle="collapse" aria-expanded="false" aria-controls="collapse14">
                                                                <h6 class="mt-0 header-title map-title-secondary mb-4">Reference Data Overlay<i class="fa fa-angle-right pull-right"></i></h6>
                                                            </a>
                                                            <div id="collapse14" class="collapse" aria-labelledby="heading14" data-parent="#accordion3">
                                                                <form>
                                                                    <div class="row form-group">
                                                                        <div class="col-md-12">
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="chkState121" checked>
                                                                                <label class="custom-control-label" for="chkState121">HRSI</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox122" disabled>
                                                                                <label class="custom-control-label" for="checkbox122">FSI</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox123" checked>
                                                                                <label class="custom-control-label" for="checkbox123">SOI OSM TOPO</label>
                                                                            </div>
                                                                            <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                                                <input type="checkbox" class="custom-control-input" id="checkbox124" disabled>
                                                                                <label class="custom-control-label" for="checkbox124">Village Cadastral</label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="clearfix"></div>
                                                         </div> --%>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%-- <div class="mb-0">
                                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="fixHeightRight">
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><span aria-hidden="true">�</span></button> -->
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
                                                              
                                                         </div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
 --%>
                                <div class="mb-0">
                                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="fixHeightRight">
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree"><span aria-hidden="true">�</span></button> -->
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
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour"><span aria-hidden="true">�</span></button> -->
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
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">�</span></button> -->
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
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">�</span></button> -->
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
                                                    <!-- <button class="btn-sm btn-danger closeBtn collapsed" type="button" data-toggle="collapse" data-target="#collapseEight" aria-expanded="false" aria-controls="collapseFive"><span aria-hidden="true">�</span></button> -->
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
                    </div>
                 </div>
                 
                 <div class="col-md-9 layout-spacing">
                    <div class="statbox widget box box-shadow">                            
                        <div class="widget-content widget-content-area">
                        	<div id="map" class="fixHeightLeft panel">
                        		<div class="map-tool-icon">
                        			<!-- <a href="#" id="mapFullscreen" class="bs-tooltip" title="Zoom to extent"><img src="/assets/img/icon-zoom-to-extent.png"></span></a>
                        			<a href="#" class="bs-tooltip" title="Pan"><img src="/assets/img/icon-pan.png"></span></a>
                        			<a href="#" class="bs-tooltip" id="btnZoom" title="Zoom in"><img src="/assets/img/icon-zoom-in.png"></span></a>
                        			<a href="#" class="bs-tooltip" id="btnZoomout" title="Zoom out"><img src="/assets/img/icon-zoom-out.png"></span></a> -->
                        		</div>
                               <!-- <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834859.9797965377!2d82.19173433935192!3d20.176539522401498!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a226aece9af3bfd%3A0x133625caa9cea81f!2sOdisha!5e0!3m2!1sen!2sin!4v1564120416120!5m2!1sen!2sin" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe> -->
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
                    <h5 class="title">About Project</h5>
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
        

        <!-- <div id="popup" class="ol-popup">
            <a href="#" id="popup-closer" class="ol-popup-closer"></a>
            <div id="popup-content"></div>
        </div> -->
    <script src="/assets/js/libs/jquery-3.1.1.min.js"></script>
     
   <script>
        $(document).ready(function() {
            $(".header-title-lg").text("ODISHA FLI-DSS"+" (Project: "+'${Project.projectName}'+")");
            //Notified Forest
            nfLayer();
            //DLC & Other Revenue Forest
            dlcofLayer();
            //District
            dstLayer();
            //Tahasil
            thslLayer();
            //Block
           // blkLayer();
            //Village
            vilgLayer();
            //Division
            divsnLayer();
            //Range
            rngLayer();
            //Section
           secLayer();
            //Beat
            btfLayer();
            //HRSI
            //hrsiLayer();
            //FSI
            //fsiLayer();
            //SOI OSM TOPO
            //sotLayer();
            //Village Cadastral
            //vcLayer();
        });
      
    </script> 
<!--    <script src="/v5.3.0-dist/ol.js"></script> -->
<!--    <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/build/ol.js"></script> -->
 <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
<script src="https://epsg.io/32645.js"></script>
<script src="/v5.3.0-dist/32644.js"></script>

<script type="text/javascript">
console.log("");
var geoserverUrl = '${geoserverUrl}';
</script>
<script src="/assets/js/apps/userMapView.js"></script>

 <%@ include file="../shared/footer.jsp"%> 
 
<script type="text/javascript" >
 var arrDist=[];
var nf_layer,nf_layer1,dlc_rev_layer,dlc_rev_layer1,dist_layer,dist_layer1,
tshl_layer,tshl_layer1,blk_layer,blk_layer1,vilg_layer,vilg_layer1,sec_layer,sec_layer1,
beat_layer,beat_layer1,hrsi_layer,hrsi_layer1,fsi_layer,fsi_layer1,sot_layer,sot_layer1,vc_layer,vc_layer1,div_layer,div_layer1,range_layer,range_layer1;
nf_layer1=[];
dlc_rev_layer1=[];
dist_layer1=[];
tshl_layer1=[];
blk_layer1=[];
vilg_layer1=[];
sec_layer1=[];
beat_layer1=[];
hrsi_layer1=[];
fsi_layer1=[];
sot_layer1=[];
vc_layer1=[];
div_layer1=[];
range_layer1=[];
var rfArray = [];
var vectorSource1;
vectorSource1 = new ol.source.Vector({
});
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




      // Onchange of chkNf,add/remove Notified Forest.
     
        $("#chkds2").change(function (event) {	
           
           //if(this.checked){
            nfLayer();
        //    }
        //    else{
        //     map.removeLayer(nf_layer);
        //     nf_layer.setVisible(false);
        //    }
            
		 });  
        
        //Bind NFB Layers
function nfLayer()
{
    if(!$("#chkds2").is(":checked"))
              { 				 
            	map.removeLayer(eval(nf_layer));
              }
              else{
                  
	try{
	
    var did= $("#hdnDivid").val();
    $.ajax({
        url: "/LoadLayers",
        data: {
            'landType': "1",
            'distid': 0,
            'divid': did,
            'rangeCode':"",
            'condn':""
        },
        type: "GET",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(result) {
            //console.log(result);
                var jsonObj = {};
                var arr=[];
                var i=1;
                result.forEach(function(data) 
                    {
                        var jsonData = {};
                            jsonData["geometry"] =JSON.parse(data.geom);
                               jsonData["type"]="Feature";
                          let cmvProp = JSON.parse(JSON.stringify(data))
                          delete cmvProp['geom'];
                          jsonData["properties"]=cmvProp;
                          arr.push(jsonData);
                         
                        });
                jsonObj["features"]=arr;
                    jsonObj["type"]="FeatureCollection";
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
                     
                        
                        nf_layer = new ol.layer.Vector({
                            source: vectorSource,
                            style:nfb_survey_style,
                            title: 'nfbLayer'
                          
                            });
                    
                            map.addLayer(nf_layer);
                          nf_layer.setVisible(true);
                      
                    //}	
        },
        error: function(errormessage) {
            alert(errormessage.responseText);
        }
    //});
    });
}
catch(error)
{
    
}	
              }
    
}

        // function nfLayer()
        // {
        //     var did= $("#hdnDivid").val();
        //     //alert(did);
		// 	 if(!$("#chkds2").is(":checked"))
        //      { 				 
        //     	map.removeLayer(eval(nf_layer));
        //       if(nf_layer1.length>0)
        //       {
        //     	  nf_layer1.forEach(function(item){
        //               map.removeLayer(item);
        //           });
        //       }
        //      }			
		// 	else{							
		// 	$.ajax({
		// 		url: '/Utility/getDivisionVectorMapTypeLayerList',
		// 		data: {
        //             'distid': 0,
        //             'divid': did,
		// 			'type': 28
		// 		},
		// 		type: "GET",
		// 		contentType: "application/json;charset=utf-8",
		// 		dataType: "json",
		// 		success: function (obj) {
        //            // console.log(obj);					
		// 			if (obj != null) {
		// 				var myStringArray = obj;
		// 				var arrayLength = obj.length;
		// 				for (var i = 0; i < arrayLength; i++) {							
		// 					var query = "";								
		// 					nf_layer = new ol.layer.Image({
		// 						source: new ol.source.ImageWMS({
		// 							url: obj[i].strValue,
		// 							params: {
		// 								'LAYERS': obj[i].text,
		// 								'VERSION': '1.1.0',
		// 								//'CQL_FILTER': query     
		// 							},
		// 							serverType: 'geoserver'
		// 						})
		// 					});
		// 					if (nf_layer != null) {
		// 						//map.addLayer(nf_layer);
		// 						if ($("#chkds2").is(":checked")) {
		// 							nf_layer.setVisible(true);
		// 							nf_layer1.push(nf_layer);	                            	 
	    //                         	 if(i==arrayLength-1){
	    //                         		 if(nf_layer1.length>0)
		//                                  {
	    //                         			 nf_layer1.forEach(function(item){
		//                             			 map.addLayer(item);		                            		 
		//                                          item.setVisible(true);
		//                                      });
		                                     
		//                                  }
	    //                         	 }
		// 						}
		// 						else {
		// 							nf_layer.setVisible(false);
		// 							map.removeLayer(nf_layer);									
		// 						}

		// 					} else {
		// 						AlertNotify("NF Boundary is not available.")
		// 					}
		// 				}
		// 			}
		// 		},
		// 		error: function (xhr, status) {

		// 		}
		// 	});
		// 	}
        // }

        //  For DLC & Other Revenue Forest

        $("#chkds3").change(function (event) {	
            dlcofLayer();
		});

        function dlcofLayer()
        {
            var did= $("#hdnDivid").val();
            //alert(did);
			 if(!$("#chkds3").is(":checked"))
             { 	
				    map.getLayers().forEach(function (element, index, array) {
						if (element.get('title') === 'rfLayer') {
							if (element != null) {
								element.setVisible(false);
							}
						}
					});
            	//map.removeLayer(eval(dlc_rev_layer));
              /* if(dlc_rev_layer1.length>0)
              {
                dlc_rev_layer1.forEach(function(item){
                      map.removeLayer(item);
                  });
              } */
             }			
			else{							
			/* $.ajax({
				url: '/Utility/getDivisionVectorMapTypeLayerList',
				data: {
                    'distid': 0,
                    'divid': did,
					'type': 24
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {
                    //console.log(obj);					
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";								
							dlc_rev_layer = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0'
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
							if (dlc_rev_layer != null) {
								//map.addLayer(dlc_rev_layer);
								if ($("#chkds3").is(":checked")) {
									dlc_rev_layer.setVisible(true);
									dlc_rev_layer1.push(dlc_rev_layer);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(dlc_rev_layer1.length>0)
		                                 {
                                            dlc_rev_layer1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									dlc_rev_layer.setVisible(false);
									map.removeLayer(dlc_rev_layer);									
								}

							} else {
								AlertNotify("DLC & Other Revenue Forest Boundary is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			}); */
			
			
			
			
			
		//RF LAYER START
		$.ajax({
				url: "/LoadLayers",
				async: true,
				data: {
					'type': 24,
					'landType': "2",
					'distid': 0,
		            'divid': did,
		            'rangeCode':"",
		            'condn':"",
					'tahasil_id': "",
					'ric': "",
					'vill_code': "",
					'operator': "",
					'opvalue': ""
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (result) {
					var layerquery = "";
						layerquery = "(land_class='Govt. Forest' OR land_class='Private Forest' OR dlc='Y') ";
					if (result.length > 0) {
						result.forEach(function (rfdata) {
							var i = 1;
							var url = rfdata.chrvGlink + '?service=WFS&version=1.0.0&request=GetFeature&typeName=' + rfdata.chrvStrLayerNm + '&outputFormat=application%2Fjson&CQL_FILTER=' + layerquery;
							ol.proj.proj4.register(proj4);
							var features;
							jQuery.getJSON(url, function (data) {
								features = new ol.format.GeoJSON().readFeatures(data, {
									dataProjection: new ol.proj.get('EPSG:' + rfdata.utmZone),
									featureProjection: new ol.proj.get('EPSG:3857')
								});

								if (features.length > 0) {
									//var props = features.properties;
									var vectorSource = new ol.source.Vector({
										features: features,
										wrapX: false,
									});

									dlc_rev_layer = new ol.layer.Vector({
										source: vectorSource,
										style: rev_dlc_style,
										title: 'rfLayer'
									});
									rfArray.push(dlc_rev_layer);
									map.addLayer(dlc_rev_layer);
									dlc_rev_layer.setVisible(true);
								}
								else {
									if (rfdata.length == 0) {
										alert("Feature Layer is not found");
										return;
									}	
								}

							});
						});
					}
				},
				error: function (errormessage) {

				}
			});
			//RF LAYER END
			}
        }

        // for District

        $("#chkds5").change(function (event) {
            //alert("function");	
            dstLayer();
		});

        function dstLayer()
        {
            var did= $("#hdnDivid").val();
             
			 if(!$("#chkds5").is(":checked"))
             { 		
            	map.removeLayer(eval(dist_layer));
              if(dist_layer1.length>0)
              {
                dist_layer1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{	
              					
			$.ajax({
				url: '/Utility/getDivisionVectorMapTypeLayerList',
				data: {
                    'distid': 0,
                    'divid': did,
					'type': 29
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {  	 
                  let distList=[];
                  	for(let d=1;d<=obj.length-1;d++){
                        distList.push(obj[d].value);
                      }
    				
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length-distList.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "dist_id in("+distList+")";	
							console.log(query);
							dist_layer = new ol.layer.Image({
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
							if (dist_layer != null) {
								//map.addLayer(dist_layer);
								if ($("#chkds5").is(":checked")) {
                                    
									dist_layer.setVisible(true);
									dist_layer1.push(dist_layer);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(dist_layer1.length>0)
		                                 {
                                            
                                            dist_layer1.forEach(function(item){
                                                
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                   
		                                 }
                                      
	                            	 }
                                   
								}
                                
								else {
									dist_layer.setVisible(false);
									map.removeLayer(dist_layer);									
								}

							} else {
								AlertNotify("District Boundary is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {
                    
				}
			});
			}
        }


     


        // for Block

        // $("#chkds7").change(function (event) {	
        //     blkLayer();
		// });

        // function blkLayer()
        // {
        //     var did= $("#hdnDivid").val();
        //     //alert(did);
		// 	 if(!$("#chkds7").is(":checked"))
        //      { 				 
        //     	map.removeLayer(eval(blk_layer));
        //       if(blk_layer1.length>0)
        //       {
        //         blk_layer1.forEach(function(item){
        //               map.removeLayer(item);
        //           });
        //       }
        //      }			
		// 	else{							
		// 	$.ajax({
		// 		url: '/Utility/getDivisionVectorMapTypeLayerList',
		// 		data: {
        //             'distid': 0,
        //             'divid': did,
		// 			'type': 
		// 		},
		// 		type: "GET",
		// 		contentType: "application/json;charset=utf-8",
		// 		dataType: "json",
		// 		success: function (obj) {
        //             console.log(obj);					
		// 			if (obj != null) {
		// 				var myStringArray = obj;
		// 				var arrayLength = obj.length;
		// 				for (var i = 0; i < arrayLength; i++) {							
		// 					var query = "";								
		// 					blk_layer = new ol.layer.Image({
		// 						source: new ol.source.ImageWMS({
		// 							url: obj[i].strValue,
		// 							params: {
		// 								'LAYERS': obj[i].text,
		// 								'VERSION': '1.1.0',
		// 								//'CQL_FILTER': query     
		// 							},
		// 							serverType: 'geoserver'
		// 						})
		// 					});
		// 					if (dlc_rev_layer != null) {
		// 						//map.addLayer(blk_layer);
		// 						if ($("#chkds7").is(":checked")) {
		// 							blk_layer.setVisible(true);
		// 							blk_layer1.push(blk_layer);	                            	 
	    //                         	 if(i==arrayLength-1){
	    //                         		 if(blk_layer1.length>0)
		//                                  {
        //                                     blk_layer1.forEach(function(item){
		//                             			 map.addLayer(item);		                            		 
		//                                          item.setVisible(true);
		//                                      });
		                                     
		//                                  }
	    //                         	 }
		// 						}
		// 						else {
		// 							blk_layer.setVisible(false);
		// 							map.removeLayer(blk_layer);									
		// 						}

		// 					} else {
		// 						AlertNotify("Block Boundary is not available.")
		// 					}
		// 				}
		// 			}
		// 		},
		// 		error: function (xhr, status) {

		// 		}
		// 	});
		// 	}
        // }

        //for Village 

        $("#chkds8").change(function (event) {	
            vilgLayer();
		});

        function vilgLayer()
        {
            var did= $("#hdnDivid").val();
            //alert(did);
			 if(!$("#chkds8").is(":checked"))
             { 				 
            	map.removeLayer(eval(vilg_layer));
              if(vilg_layer1.length>0)
              {
                vilg_layer1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getDivisionVectorMapTypeLayerList',
				data: {
                    'distid': 0,
                    'divid': did,
					'type': 14
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {
                    //console.log(obj);					
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";								
							vilg_layer = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
							if (vilg_layer != null) {
								//map.addLayer(vilg_layer);
								if ($("#chkds8").is(":checked")) {
									vilg_layer.setVisible(true);
									vilg_layer1.push(vilg_layer);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(vilg_layer1.length>0)
		                                 {
                                            vilg_layer1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									vilg_layer.setVisible(false);
									map.removeLayer(vilg_layer);									
								}

							} else {
								AlertNotify("Village Boundary is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
        }


        // for Division

        $("#chkds10").change(function (event) {	
            divsnLayer();
		});

        function divsnLayer()
        {
            var did= $("#hdnDivid").val();
            //alert(did);
			 if(!$("#chkds10").is(":checked"))
             { 				 
            	map.removeLayer(eval(div_layer));
              if(div_layer1.length>0)
              {
                div_layer1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getDivisionVectorMapTypeLayerList',
				data: {
                    'distid': 0,
                    'divid': 0,
					'type': 3
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {
                    var query = "DIV_ID="+did;
                    					
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {						
							div_layer = new ol.layer.Image({
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
							if (div_layer != null) {
								//map.addLayer(div_layer);
								if ($("#chkds10").is(":checked")) {
									div_layer.setVisible(true);
									div_layer1.push(div_layer);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(div_layer1.length>0)
		                                 {
                                            div_layer1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									div_layer.setVisible(false);
									map.removeLayer(div_layer);									
								}

							} else {
								AlertNotify("Division Boundary is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
        }

//for Range

$("#chkds11").change(function (event) {	
    rngLayer();
		});

        function rngLayer()
        {
            var did= $("#hdnDivid").val();
            //alert(did);
			 if(!$("#chkds11").is(":checked"))
             { 				 
            	map.removeLayer(eval(range_layer));
              if(range_layer1.length>0)
              {
                range_layer1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getDivisionVectorMapTypeLayerList',
				data: {
                    'distid': 0,
                    'divid': did,
					'type': 9
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {
                    //console.log(obj);					
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";								
							range_layer = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
							if (range_layer != null) {
								//map.addLayer(range_layer);
								if ($("#chkds11").is(":checked")) {
									range_layer.setVisible(true);
									range_layer1.push(range_layer);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(range_layer1.length>0)
		                                 {
                                            range_layer1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									range_layer.setVisible(false);
									map.removeLayer(range_layer);									
								}

							} else {
								AlertNotify("Range Boundary is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
        }

        // for Section


$("#chkds12").change(function (event) {	
    secLayer();
		});

        function secLayer()
        {
            var did= $("#hdnDivid").val();
            //alert(did);
			 if(!$("#chkds12").is(":checked"))
             { 				 
            	map.removeLayer(eval(sec_layer));
              if(sec_layer1.length>0)
              {
                sec_layer1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getDivisionVectorMapTypeLayerList',
				data: {
                    'distid': 0,
                    'divid': did,
					'type': 11
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {
                  //  console.log(obj);					
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";								
							sec_layer = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
							if (sec_layer != null) {
								//map.addLayer(sec_layer);
								if ($("#chkds12").is(":checked")) {
									sec_layer.setVisible(true);
									sec_layer1.push(sec_layer);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(sec_layer1.length>0)
		                                 {
                                            sec_layer1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									sec_layer.setVisible(false);
									map.removeLayer(sec_layer);									
								}

							} else {
								AlertNotify("Section Boundary is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
        }

        // for Beat

        $("#chkds13").change(function (event) {	
            btfLayer();
		});

        function btfLayer()
        {
            var did= $("#hdnDivid").val();
            //alert(did);
			 if(!$("#chkds13").is(":checked"))
             { 				 
            	map.removeLayer(eval(beat_layer));
              if(beat_layer1.length>0)
              {
                beat_layer1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getDivisionVectorMapTypeLayerList',
				data: {
                    'distid': 0,
                    'divid': did,
					'type': 1
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {
                    //console.log(obj);					
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";								
							beat_layer = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
							if (beat_layer != null) {
								//map.addLayer(beat_layer);
								if ($("#chkds13").is(":checked")) {
									beat_layer.setVisible(true);
									beat_layer1.push(beat_layer);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(beat_layer1.length>0)
		                                 {
                                            beat_layer1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									beat_layer.setVisible(false);
									map.removeLayer(beat_layer);									
								}

							} else {
								AlertNotify("Beat Boundary is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
        }

        //for HRSI

        // $("#chkds15").change(function (event) {	
        //     hrsiLayer();
		// });

        // function hrsiLayer()
        // {
        //     var did= $("#hdnDivid").val();
        //     //alert(did);
		// 	 if(!$("#chkds15").is(":checked"))
        //      { 				 
        //     	map.removeLayer(eval(hrsi_layer));
        //       if(hrsi_layer1.length>0)
        //       {
        //         hrsi_layer1.forEach(function(item){
        //               map.removeLayer(item);
        //           });
        //       }
        //      }			
		// 	else{							
		// 	$.ajax({
		// 		url: '/Utility/getDivisionVectorMapTypeLayerList',
		// 		data: {
        //             'distid': 0,
        //             'divid': did,
		// 			'type': 
		// 		},
		// 		type: "GET",
		// 		contentType: "application/json;charset=utf-8",
		// 		dataType: "json",
		// 		success: function (obj) {
        //             console.log(obj);					
		// 			if (obj != null) {
		// 				var myStringArray = obj;
		// 				var arrayLength = obj.length;
		// 				for (var i = 0; i < arrayLength; i++) {							
		// 					var query = "";								
		// 					hrsi_layer = new ol.layer.Image({
		// 						source: new ol.source.ImageWMS({
		// 							url: obj[i].strValue,
		// 							params: {
		// 								'LAYERS': obj[i].text,
		// 								'VERSION': '1.1.0',
		// 								//'CQL_FILTER': query     
		// 							},
		// 							serverType: 'geoserver'
		// 						})
		// 					});
		// 					if (hrsi_layer != null) {
		// 						//map.addLayer(hrsi_layer);
		// 						if ($("#chkds15").is(":checked")) {
		// 							hrsi_layer.setVisible(true);
		// 							hrsi_layer1.push(hrsi_layer);	                            	 
	    //                         	 if(i==arrayLength-1){
	    //                         		 if(hrsi_layer1.length>0)
		//                                  {
        //                                     hrsi_layer1.forEach(function(item){
		//                             			 map.addLayer(item);		                            		 
		//                                          item.setVisible(true);
		//                                      });
		                                     
		//                                  }
	    //                         	 }
		// 						}
		// 						else {
		// 							hrsi_layer.setVisible(false);
		// 							map.removeLayer(hrsi_layer);									
		// 						}

		// 					} else {
		// 						AlertNotify("HRSI Boundary is not available.")
		// 					}
		// 				}
		// 			}
		// 		},
		// 		error: function (xhr, status) {

		// 		}
		// 	});
		// 	}
        // }

        //for FSI


        // $("#chkds16").change(function (event) {	
        //     fsiLayer();
		// });

        // function fsiLayer()
        // {
        //     var did= $("#hdnDivid").val();
        //     //alert(did);
		// 	 if(!$("#chkds16").is(":checked"))
        //      { 				 
        //     	map.removeLayer(eval(fsi_layer));
        //       if(fsi_layer1.length>0)
        //       {
        //         fsi_layer1.forEach(function(item){
        //               map.removeLayer(item);
        //           });
        //       }
        //      }			
		// 	else{							
		// 	$.ajax({
		// 		url: '/Utility/getDivisionVectorMapTypeLayerList',
		// 		data: {
        //             'distid': 0,
        //             'divid': did,
		// 			'type': 
		// 		},
		// 		type: "GET",
		// 		contentType: "application/json;charset=utf-8",
		// 		dataType: "json",
		// 		success: function (obj) {
        //             console.log(obj);					
		// 			if (obj != null) {
		// 				var myStringArray = obj;
		// 				var arrayLength = obj.length;
		// 				for (var i = 0; i < arrayLength; i++) {							
		// 					var query = "";								
		// 					fsi_layer = new ol.layer.Image({
		// 						source: new ol.source.ImageWMS({
		// 							url: obj[i].strValue,
		// 							params: {
		// 								'LAYERS': obj[i].text,
		// 								'VERSION': '1.1.0',
		// 								//'CQL_FILTER': query     
		// 							},
		// 							serverType: 'geoserver'
		// 						})
		// 					});
		// 					if (fsi_layer != null) {
		// 						//map.addLayer(fsi_layer);
		// 						if ($("#chkds16").is(":checked")) {
		// 							fsi_layer.setVisible(true);
		// 							fsi_layer1.push(fsi_layer);	                            	 
	    //                         	 if(i==arrayLength-1){
	    //                         		 if(fsi_layer1.length>0)
		//                                  {
        //                                     fsi_layer1.forEach(function(item){
		//                             			 map.addLayer(item);		                            		 
		//                                          item.setVisible(true);
		//                                      });
		                                     
		//                                  }
	    //                         	 }
		// 						}
		// 						else {
		// 							fsi_layer.setVisible(false);
		// 							map.removeLayer(fsi_layer);									
		// 						}

		// 					} else {
		// 						AlertNotify("FSI Boundary is not available.")
		// 					}
		// 				}
		// 			}
		// 		},
		// 		error: function (xhr, status) {

		// 		}
		// 	});
		// 	}
        // }

        //for SOI OSM TOPO 

        // $("#chkds17").change(function (event) {	
        //     sotLayer();
		// });

        // function sotLayer()
        // {
        //     var did= $("#hdnDivid").val();
        //     //alert(did);
		// 	 if(!$("#chkds17").is(":checked"))
        //      { 				 
        //     	map.removeLayer(eval(sot_layer));
        //       if(sot_layer1.length>0)
        //       {
        //         sot_layer1.forEach(function(item){
        //               map.removeLayer(item);
        //           });
        //       }
        //      }			
		// 	else{							
		// 	$.ajax({
		// 		url: '/Utility/getDivisionVectorMapTypeLayerList',
		// 		data: {
        //             'distid': 0,
        //             'divid': did,
		// 			'type': 13
		// 		},
		// 		type: "GET",
		// 		contentType: "application/json;charset=utf-8",
		// 		dataType: "json",
		// 		success: function (obj) {
        //             console.log(obj);					
		// 			if (obj != null) {
		// 				var myStringArray = obj;
		// 				var arrayLength = obj.length;
		// 				for (var i = 0; i < arrayLength; i++) {							
		// 					var query = "";								
		// 					sot_layer = new ol.layer.Image({
		// 						source: new ol.source.ImageWMS({
		// 							url: obj[i].strValue,
		// 							params: {
		// 								'LAYERS': obj[i].text,
		// 								'VERSION': '1.1.0',
		// 								//'CQL_FILTER': query     
		// 							},
		// 							serverType: 'geoserver'
		// 						})
		// 					});
		// 					if (sot_layer != null) {
		// 						//map.addLayer(sot_layer);
		// 						if ($("#chkds17").is(":checked")) {
		// 							sot_layer.setVisible(true);
		// 							sot_layer1.push(sot_layer);	                            	 
	    //                         	 if(i==arrayLength-1){
	    //                         		 if(sot_layer1.length>0)
		//                                  {
        //                                     sot_layer1.forEach(function(item){
		//                             			 map.addLayer(item);		                            		 
		//                                          item.setVisible(true);
		//                                      });
		                                     
		//                                  }
	    //                         	 }
		// 						}
		// 						else {
		// 							sot_layer.setVisible(false);
		// 							map.removeLayer(sot_layer);									
		// 						}

		// 					} else {
		// 						AlertNotify("SOI OSM TOPO Boundary is not available.")
		// 					}
		// 				}
		// 			}
		// 		},
		// 		error: function (xhr, status) {

		// 		}
		// 	});
		// 	}
        // }

        // for Village Cadastral

        // $("#chkds18").change(function (event) {	
        //     vcLayer();
		// });

        // function vcLayer()
        // {
        //     var did= $("#hdnDivid").val();
        //     //alert(did);
		// 	 if(!$("#chkds18").is(":checked"))
        //      { 				 
        //     	map.removeLayer(eval(vc_layer));
        //       if(vc_layer1.length>0)
        //       {
        //         vc_layer1.forEach(function(item){
        //               map.removeLayer(item);
        //           });
        //       }
        //      }			
		// 	else{							
		// 	$.ajax({
		// 		url: '/Utility/getDivisionVectorMapTypeLayerList',
		// 		data: {
        //             'distid': 0,
        //             'divid': did,
		// 			'type': 
		// 		},
		// 		type: "GET",
		// 		contentType: "application/json;charset=utf-8",
		// 		dataType: "json",
		// 		success: function (obj) {
        //             console.log(obj);					
		// 			if (obj != null) {
		// 				var myStringArray = obj;
		// 				var arrayLength = obj.length;
		// 				for (var i = 0; i < arrayLength; i++) {							
		// 					var query = "";								
		// 					vc_layer = new ol.layer.Image({
		// 						source: new ol.source.ImageWMS({
		// 							url: obj[i].strValue,
		// 							params: {
		// 								'LAYERS': obj[i].text,
		// 								'VERSION': '1.1.0',
		// 								//'CQL_FILTER': query     
		// 							},
		// 							serverType: 'geoserver'
		// 						})
		// 					});
		// 					if (vc_layer != null) {
		// 						//map.addLayer(vc_layer);
		// 						if ($("#chkds18").is(":checked")) {
		// 							vc_layer.setVisible(true);
		// 							vc_layer1.push(vc_layer);	                            	 
	    //                         	 if(i==arrayLength-1){
	    //                         		 if(vc_layer1.length>0)
		//                                  {
        //                                     vc_layer1.forEach(function(item){
		//                             			 map.addLayer(item);		                            		 
		//                                          item.setVisible(true);
		//                                      });
		                                     
		//                                  }
	    //                         	 }
		// 						}
		// 						else {
		// 							vc_layer.setVisible(false);
		// 							map.removeLayer(vc_layer);									
		// 						}

		// 					} else {
		// 						AlertNotify("Village Cadastral Boundary is not available.")
		// 					}
		// 				}
		// 			}
		// 		},
		// 		error: function (xhr, status) {

		// 		}
		// 	});
		// 	}
        // }
//Zoom In and Zoom Out
       $('#btnZoom').click(function(){
	        
	        $('.ol-zoom-in').trigger("click");
	    });
	     $('#btnZoomout').click(function(){
	        
	        $('.ol-zoom-out').trigger("click");
	    });

     

      //  <!-- Full Screen -->
	   
    //    var elem = document.getElementById("mapFullscreen");
    //    function openFullscreen() {
    //        $(".fixHeightLeft").toggleClass("intro");
    //        if (elem.requestFullscreen) {
    //            elem.requestFullscreen();
    //        }else if (elem.webkitRequestFullscreen) {   /* Safari */
    //            elem.webkitRequestFullscreen();
    //        }else if (elem.msRequestFullscreen) {   /* IE 11 */
    //            elem.msRequestFullscreen();
    //        }
    //    }


   
</script>

<script >

       //for Tahasil 



       $("#chkds6").change(function (event) {	
            thslLayer();
		});

        function thslLayer()
        {
            
            var did= $("#hdnDivid").val();
            //alert(did);
			 if(!$("#chkds6").is(":checked"))
             { 				 
            	map.removeLayer(eval(tshl_layer));
              if(tshl_layer1.length>0)
              {
                tshl_layer1.forEach(function(item){
                      map.removeLayer(item);
                  });
              }
             }			
			else{							
			$.ajax({
				url: '/Utility/getDivisionVectorMapTypeLayerList',
				data: {
                    'distid': 0,
                    'divid': did,
					'type': 19
				},
				type: "GET",
				contentType: "application/json;charset=utf-8",
				dataType: "json",
				success: function (obj) {
                    //console.log(obj);					
					if (obj != null) {
						var myStringArray = obj;
						var arrayLength = obj.length;
						for (var i = 0; i < arrayLength; i++) {							
							var query = "";	
                           	
					
							tshl_layer = new ol.layer.Image({
								source: new ol.source.ImageWMS({
									url: obj[i].strValue,
									params: {
										'LAYERS': obj[i].text,
										'VERSION': '1.1.0',
										//'CQL_FILTER': query     
									},
									serverType: 'geoserver'
								})
							});
                            console.log("tshl_layer :"+tshl_layer);
							if (tshl_layer != null) {
								//map.addLayer(tshl_layer);
								if ($("#chkds6").is(":checked")) {
                                    
									tshl_layer.setVisible(true);
									tshl_layer1.push(tshl_layer);	                            	 
	                            	 if(i==arrayLength-1){
	                            		 if(tshl_layer1.length>0)
		                                 {
                                            tshl_layer1.forEach(function(item){
		                            			 map.addLayer(item);		                            		 
		                                         item.setVisible(true);
		                                     });
		                                     
		                                 }
	                            	 }
								}
								else {
									tshl_layer.setVisible(false);
									map.removeLayer(tshl_layer);									
								}

							} else {
								AlertNotify("Tahasil Boundary is not available.")
							}
						}
					}
				},
				error: function (xhr, status) {

				}
			});
			}
        }
        
       
        //overlay
				var container = document.getElementById('popup');
				var content = document.getElementById('popup-content');
				var closer = document.getElementById('popup-closer');
				var overlay = new ol.Overlay({
					element: container,
					positioning: 'bottom-center',
					stopEvent: true,
					autoPan: true,
					autoPanAnimation: {
						duration: 250
					}
				});
				map.addOverlay(overlay);
				closer.onclick = function () {
					overlay.setPosition(undefined);
					closer.blur();
					return false;
				};
				
		//Info Window
        //map onclick event
				map.on('click', function (evt) {
					console.log("inside");

					content.innerHTML = '';
					vectorSource1.clear();
					var feature = map.forEachFeatureAtPixel(evt.pixel, function (feature, layer) {
						return feature;
					});

					var layer = map.forEachFeatureAtPixel(evt.pixel, function (feature, layer) {
						return layer;
					});

					if (feature) {
						var coord = feature.getGeometry().getCoordinates();
						var props = feature.getProperties();
						geom = [];

						geom.push(feature);
						vectorSource1.addFeatures(geom);
						feature = new ol.layer.Vector
							({
								source: vectorSource1,
								style: Highlightfeature_style

							});
						map.addLayer(feature);
						console.log(feature);
						//if (activeTabL == "layerTab") {
							if (layer.get('title') == "nfbLayer") {
								content.innerHTML = "<h5>NFB Details</h5>"
									+ "<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr><td><strong>Division :</strong></td><td>" + props.division_name + "</td></tr>"
									+ "<tr><td><strong>Range :</strong></td><td>" + props.range_name + "</td></tr>"
									+ "<tr><td><strong>Forest Block :</strong></td><td>" + props.fb_name + "</td></tr>"
									+ "<tr><td><strong>FB Type :</strong></td><td>" + props.fb_type + "</td></tr>"
									//+"<tr><td><strong>Notification No :</strong></td><td>"+props.notf_no+"</td></tr>"
									+ "<tr><td><strong>Area(Ha.) :</strong></td><td>" + props.area_ha + "</td></tr>"
									+ "<tr><td><strong>Perimeter(KM) :</strong></td><td>" + props.perimeter + "</td></tr>"
									+ "<tr><td><strong>Survey Type :</strong></td><td>" + props.surveytype + "</td></tr></table></div>";
								// http://103.55.73.169:5065/pillarsphoto/IMG_20201006_094354_4_47490436914561039648.jpg
								//+"<tr><td><strong>FRJVC Report :</strong></td><td><a href='"+report+"' target='_blank'><span>View</span></a></td></tr></table></div>";
								overlay.setPosition(evt.coordinate);
							}
							else if (layer.get('title') == "rfLayer") {
								
								content.innerHTML = "Revenue Details"
									+ "</br>" + "<div class='table-responsive my-table-sm'><table class='table table-sm table-bordered mb-0'><tr><td><strong>Division :</strong></td><td>" + props.div_name + "</td></tr>"
									+ "<tr><td><strong>Tahasil :</strong></td><td>" + props.tahasil + "</td></tr>"
									+ "<tr><td><strong>RI Circle :</strong></td><td>" + props.ric + "</td></tr>"
									+ "<tr><td><strong>Village Name :</strong></td><td>" + props.village + "</td></tr>"
									+ "<tr><td><strong>Publish Year :</strong></td><td>" + props.publ_year + "</td></tr>"
									+ "<tr><td><strong>Khata No :</strong></td><td>" + props.khata_no + "</td></tr>"
									+ "<tr><td><strong>Plot No :</strong></td><td>" + props.plot_no + "</td></tr>"
									+ "<tr><td><strong>ROR Area(Acre) :</strong></td><td>" + props.area_ac + "</td></tr>"
									+ "<tr><td><strong>ROR Kissam :</strong></td><td>" + props.kissam + "</td></tr>"
									+ "<tr><td><strong>DLC Forest :</strong></td><td>" + (props.dlc != null ? props.dlc : 'N') + "</td></tr>"
									//+"<tr><td><strong>Rev Forest :</strong></td><td>Y</td></tr>"
									+ "<tr><td><strong>Land Type :</strong></td><td>" + props.land_class + "</td></tr></table></div>";
								overlay.setPosition(evt.coordinate);
							}
						}
					else {
						overlay.setPosition(undefined);
					}
				});
</script>
 <script src="/assets/js/custom/layer_style.js"></script>
 
 