<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

<link href="/assets/css/app.css" rel="stylesheet" type="text/css" />

 <!-- BEGIN LOADER -->
    <div class="apploader-base"><div class="apploader"></div></div>
    <!--  END LOADER -->
  <!--  BEGIN CONTENT AREA  -->
        <div id="content" class="main-content">
            <div class="layout-px-spacing">

                <div class="row layout-top-spacing">

                    <div class="col-md-2 layout-spacing">
                        <div class="statbox widget box box-shadow">
                            <div class="widget-header">
                                <div class="row">
                                    <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                                        <h4 class="pl-3 pr-3 pt-2">Filter Option</h4>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-content widget-content-area">
                                
                                <div id="accordion">
                              
                                  <c:forEach var="item" items="${layers.stream().filter(f->f.getPid()==null).toList()}">
                                
                                    <a id="" href="#collapse${item.id}" class="collapsed icon-header" data-toggle="collapse" aria-expanded="false" aria-controls="collapse${item.id}">
                                        <h6 class="mt-0 header-title map-title-secondary mb-3">${item.name}<i class="fa fa-angle-down pull-right"></i>
                                        
                                        </h6>
                                    </a>
                                    
                                     <div id="collapse${item.id}" class="collapse show border-light" aria-labelledby="heading1" data-parent="#accordion">
                                        <form>
                                            <div class="row form-group mt-2">
                                                <div class="col-md-12">
                                                
                                                <!-- Bind Layers Check box List -->
                                               <c:forEach var="layer" items="${layers.stream().filter(f-> f.getPid().getId()==item.id).toList()}">
                                               <div class="custom-control custom-checkbox checkbox-info ml-2 mr-2">
                                                        <input type="checkbox" class="custom-control-input" value="${layer.id}" id="chkds${layer.id}" onchange="chkdsCheckChange(this)">
                                                        <label class="custom-control-label" for="chkds${layer.id}">${layer.name}</label>
                                                    </div>
                                               </c:forEach>
                                                
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    </c:forEach>

                                    
                                 </div>
                                
                            </div>
                        </div>
                        
                          <!-- Selection -->
                    <!-- <div class="col-md-2"> -->
            <div class="card r-0 b-0 mb-3 shadow">
                <div class="card-header white">
                     <h6>Selection </h6>
                </div>
                <div class="card-body">

                    <form>
                        <input type="text" class="tags-input" id="txtInputBox"
                            data-options='{"tagClass": "badge badge-danger"}' readonly>                                 
                        <hr>
                       
                        <div class="col-md-12 text-center">
                            <a href="#" class="btn btn-sm btn-success" data-toggle="modal" data-target="#createrealProject" >Create Project</a>
                        </div>
                    </form>

                </div>
            </div>
        <!--  </div> -->
                   <!-- End of Selection -->
                    </div>
                    
                  

<div class="col-md-10 layout-spacing">
                        <div class="statbox widget box box-shadow">
                           
                            <div class="widget widget-activity-three">
                                <div class="widget-content pr-3">
                                <p class="pl-3 pr-3">
                                <span class="badge badge-pills badge-primary mb-1" id="dsFilterHeader"></span> 
                                <span class="badge badge-pills badge-primary mb-1" id="dstFilterHeader"></span>
                                <span class="badge badge-pills badge-primary mb-1" id="dstagFilterHeader"></span>
                                <span class="badge badge-pills badge-primary mb-1" id="divisionFilterHeader"></span>
                                <span class="badge badge-pills badge-primary mb-1" id="sourceFilterHeader"></span>
                                </p>
                                    <div class="row">
                                     <div  id="divform" class="col-md-12 layout-spacing"></div> 
                                    <!-- Partial  Page Load -->
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
                    <h5 class="title">About Data Catalogue</h5>
                    <img src="/assets/img/modal-data-catalogue.jpg" class="img-fluid img-thumbnail float-left mr-3 mb-1 w-75">
                    <p>The Forest Land Data Catalog provides key information about the available data to the Users and enable them to choose the right type of data to work with for analysis and decision making. It is an inventory of available data that provides information to evaluate fitness data for intended uses.</p>
                    <p>The data catalog enables users to Search and see all of the available datasets quickly, Evaluate and make informed choices for which data to use, and perform data Analysis efficiently and with confidence.</p>
                    <p>The data catalogue improves data context, reducing the risk of using the wrong dataset leading to better data analysis. This also helps Odisha Forest Dept in data governance and usage tracking.</p>
                    <!-- <h6 class="title">Important Points</h6>
                    <ul>
                        <li>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth.</li>
                        <li>Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain.</li>
                        <li>The master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.</li>
                        <li>In a free hour, when our power but because occasionally circumstances occur in which toil and pain can procure him some great pleasure.</li>
                    </ul> -->
                    <div class="clearfix"></div>
                    <hr>
                    <div class="text-center">
                        <div class="custom-control custom-checkbox checkbox-info mb-3">
                            <input type="checkbox" class="custom-control-input" id="chkDontShow" value="dcatalogue">
                            <label class="custom-control-label" for="chkDontShow">Don't show this again</label>
                        </div>
                        <button type="button" id="btnDontShow" class="btn btn-success" data-dismiss="modal">Launch Data Catalogue</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    
    <!-- Modal -->
        <div class="modal fade" id="createrealProject" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Add Project</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label>Add Project Name</label>
                                    <input type="text" class="form-control form-control-sm" id="txtProjectName" placeholder="Add Project Name">
                                </div>
                                <hr>
                                <div class="col-md-12 text-center">
                                    <button type="button" class="btn btn-sm btn-success" id="createProject">Submit</button>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
         <!-- Modal -->
        <div class="modal fade" id="createProjectModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Add Project</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="modalbody">
                        
                        <form>
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label>Add Project Name</label>
                                    <input type="text" class="form-control form-control-sm" id="txtProjectName" placeholder="Add Project Name">
                                </div>
                                <hr>
                                <div class="col-md-12 text-center">
                                    <button type="button" class="btn btn-sm btn-success" id="createProject">Submit</button>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>

<%@ include file="../shared/footer.jsp"%>
	
<script type="text/javascript">
$(document).ready(function(){
	
	//loadDatasetDdl(true);
	
	//$('#chkds1').prop('checked',true);
});

</script>	
<!-- //Load DatasetDDL -->
<script type="text/javascript">
function loadDatasetDdl(isCheck){
            $.ajax({
                url : "/api/Utility/getDatasetValueText",
                data: { 'divid':divid },
                type: "GET",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (data) {
                	$('#divDatasetList').empty();
             	   $.each(data, function (a, b) {
             		   //b.value=b.value.replace(' ','');
                        if(isCheck==true){
                        	//$("#mm"+b.strValue).remove();
                        	addCustomeCheckbox('divds','chkds',b.value,b.text,'divDatasetList','chkdsCheckChange(this)');
                 	   }
                 	   else{
                 		   $("#divds"+b.value).remove();
                 		  
                 	   }
                    });
             	  $('input[type="checkbox"][id="chkds1"]').prop("checked", true).change();
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });  
            
}
function loadDatasetDdlForDivCheck(){
            $.ajax({
                url : "/api/Utility/getDatasetValueText",
                data: { 'divid':divid },
                type: "GET",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (data) {
                
             	   $.each(data, function (a, b) {
             		   //b.value=b.value.replace(' ','');
             		  $("#lblds"+b.value).text(b.text); 
                    });
             	//  $('input[type="checkbox"][id="chkds1"]').prop("checked", true).change();
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });  
            
}




</script>

	
 <script>
 var dsid= new Array();
 var dstagid= new Array();
 var divid= new Array();
 var dstypeid= new Array();
 var dsourceid=new Array();
 
 
        $(document).ready(function(){
            $(".header-title-lg").text("FLI DSS (Geo-Referenced Data Catalogue)");
           // loadDataSourceTypeDdl(true);
            //$("#chkds1").prop('checked':'checked'));
            //loadPartialDataCatalogue();
           // loadDataSourceTypeDdl(true);

        });
    </script>

<!-- //DatasetCheckChange  -->   
<script type="text/javascript">

function chkdsCheckChange(e){
	bindDatasetTags(e);
	
           /*  dsid = $.grep(dsid, function(value) {
            	  return value != removeItem;
            	}); */
	
            loadDataSourceTypeDdl(true);
            divisionCountPerDataset(true);
            loadDatasetTagsForDivCheck();
            loadPartialDataCatalogue();
            
}
</script>

<!-- //Bind Dataset Tags -->
<script type="text/javascript">
function bindDatasetTags(e){
var isCheck=e.checked;
var ds=e.value;
        $.ajax({
            url : "/api/Utility/getDatasetTagValueText",
            data: { 'id':ds,'divid':divid },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function (data) {
         	   
         	   $.each(data, function (a, b) {
                    if(isCheck==true){
                 	   
                 	   addCheckbox(b.value,b.text);
             		   //$("#chkdsTag"+b.value).prop("disabled","");
             	   }
             	   else{
             		   $("#mm"+b.value).remove();
             		   //$('#divDsTagList').empty();
             		   //$("#chkdsTag"+b.value).prop("disabled","disabled");
             	   }
                });
            },
            error: function (errormessage) {
                alert(errormessage.responseText);
            }
        });  
        
        
        if(isCheck==true){
        dsid.push(ds);
        }
        else{
        	
        	for( var i = 0; i < dsid.length; i++){ 
        	    
                if ( dsid[i] === ds) { 
            
                	dsid.splice(i, 1); 
                }
            
            }
        }
}


function loadDatasetTagsForDivCheck(){
    $.ajax({
        url : "/api/Utility/getDatasetTagValueTexts",
        data: { 'dsids':dsid,'divids':divid },
        type: "GET",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (data) {
        
     	   $.each(data, function (a, b) {
     		   //b.value=b.value.replace(' ','');
     		  $("#lbldsTag"+b.value).text(b.text); 
            });
     	//  $('input[type="checkbox"][id="chkds1"]').prop("checked", true).change();
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });  
    
}
        
</script>


<!-- //Division Count Per Dataset -->
<script type="text/javascript">
function divisionCountPerDataset(e){
	$.ajax({
        url : "/api/Utility/getDivisionCountPerDataSet",
        data: { 'dsid':dsid },
        type: "GET",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (data) {
      	   $.each(data, function (a, b) {
      		   $("#lbl"+b.id).text(b.division+" ("+b.count+")");
             });
         },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}

</script>

<!-- //DataSetTagChange -->
<script type="text/javascript">

 function chkdsTagChange(e){
	 if(e.checked){
		 dstagid.push(e.value);
         }
         else{
         	for( var i = 0; i < dstagid.length; i++){ 
         	    
                 if ( dstagid[i] === e.value) { 
             
                	 dstagid.splice(i, 1); 
                 }
             }
         }
	 
	     //showAllSelectedFilterOption();
	     
	     loadDataSourceTypeDdl(true);
         loadPartialDataCatalogue();
}

</script>
 
<!-- //Desc: Dynamically add checkbox to a specified Div Tag -->	
<script type="text/javascript">
/* Desc: Dynamically add checkbox to a specified Div Tag
Auth: Thakur */
function addCheckbox(v,t) {
	   var container = $('#divDsTagList');
	   //var inputs = container.find('input');
	   //var id = inputs.length+1;
	   $('<div>', {id:'mm'+v, class:'custom-control custom-checkbox checkbox-info ml-2 mr-2'}).appendTo(container);
	   $('<input />', { type: 'checkbox', id: 'cb'+v, value: v, class:'custom-control-input',onchange:'chkdsTagChange(this)' }).appendTo('#mm'+v);
	   $('<label />', { 'for': 'cb'+v, id:'lbldsTag'+v,text: t, class:'custom-control-label' }).appendTo('#mm'+v);
	   
	}
</script> 	

<!-- Desc: Dynamically add checkbox -->
<script type="text/javascript">
/* Desc: Dynamically add checkbox
Auth: Thakur */
function addCustomeCheckbox(divid,controlid,vlu,txt,bindDivid,eventname) {
	   var container = $('#'+bindDivid);
	   //var inputs = container.find('input');
	   //var id = inputs.length+1;
	  
	   $('<div>', {id:divid+vlu, class:'custom-control custom-checkbox checkbox-info ml-2 mr-2'}).appendTo(container);
	   $('<input />', { type: 'checkbox', id: controlid+vlu, value: vlu, class:'custom-control-input',onchange:eventname }).appendTo('#'+divid+vlu);
	   $('<label />', { 'for': controlid+vlu,id:'lblds'+vlu,text: txt, class:'custom-control-label' }).appendTo('#'+divid+vlu);
	   
	}
</script> 	

<!-- //DivisionCheckChange --> 	
<script type="text/javascript">
function chkdivisionCheckChange(e){
	if(e.checked){
		 divid.push(e.value);
        }
        else{
        	for( var i = 0; i < divid.length; i++){ 
        	    
                if ( divid[i] === e.value) { 
            
                	divid.splice(i, 1); 
                }
            }
        }
	
		//showAllSelectedFilterOption();
	    loadDatasetDdlForDivCheck();
	    loadDatasetTagsForDivCheck();
        loadPartialDataCatalogue();
}
</script> 	

<!-- //GeoSpatialCheckChange -->
<script type="text/javascript">
 function chkGeoSpatialCheckChange(e){
	 if(e.checked){
		 dstypeid.push(e.value);
        }
        else{
        	for( var i = 0; i < dstypeid.length; i++){ 
        	    
                if ( dstypeid[i] === e.value) { 
            
                	dstypeid.splice(i, 1); 
                }
            }
        }
	 
	    //showAllSelectedFilterOption();
        loadPartialDataCatalogue();
 }
</script>


<!-- //Desc: Load Partial DataCatalogue Page -->
<script type="text/javascript">
/* Desc: Load Partial DataCatalogue Page
Auth: Thakur */
function loadPartialDataCatalogue()
{
	 $(".apploader-base").css("display", "block");
    $.ajax({
            url: '/GIS/partialDatacatalogue',
            data: {'dsid':dsid,'dstagid':dstagid,'divid':divid,'dstypeid':dstypeid,'dsourceid':dsourceid},
            contentType: 'application/html; charset=utf-8',
            type: 'GET',
            dataType: "html",
        })
        .done(function (result) {
        	 $(".apploader-base").css("display", "none");
          $('#divform').empty();
          $('#divform').html(result);
          //Load Table
          //LoadCustomDataTableCustomButtonFunctions('example',['']);
          //MergeCellsOfTable(example);
          showAllSelectedFilterOption();
          
        })
        .fail(function (xhr, status) {
            alert(status);
            showAllSelectedFilterOption();
        }); 
    
    
}

</script>

<!-- //InfoBox -->
<script>
        $(document).ready(function(){
        	if(${infoBox!=null && infoBox==true}){
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
    
    
<!-- //Desc: for don't show Popup info again for current session only -->    
<script type="text/javascript">
/* Desc: for don't show Popup info again for current session only
Auth: Thakur */
 $("#chkDontShow").click(function() {
   if($("#chkDontShow").is(":checked")){	
	   $.ajax({
           url: '/api/Utility/dontShowAgain',
           data: {'sessionName':'infoBox'},
           contentType: 'application/html; charset=utf-8',
           type: 'GET',
           dataType: "html",
       })
   }
        });
</script>

<script>
function showAllSelectedFilterOption(){
	showSelectedFilterOption('divDatasetList','dsFilterHeader','Dataset');
	/* showSelectedFilterOption('divDsType','sourceFilterHeader','Source');
	showSelectedFilterOption('divDatasetTypeList','dstFilterHeader','Dataset Type'); */
	showSelectedFilterOption('divisionList','divisionFilterHeader','Division');
	showSelectedFilterOption('divDsTagList','dstagFilterHeader','Tags');
	
}
</script>

<!-- Desc: Bind Selected Filter option on Header
divId: checkboxes inside the div
texToBindId: span tag id, where you want to bind the result
Auth: Thakur -->
<script>
function showSelectedFilterOption(divId,texToBindId,defaultText){
var selectedDs="";
$('div#'+divId+' input[type=checkbox]').each(function(i,ob) {
   if ($(this).is(":checked")) {

       selectedDs=selectedDs+$("label[for='"+$(this).attr("id")+"']").html()+", ";
   }
});
document.getElementById(texToBindId).innerText="";

	if(selectedDs.length>0){
	document.getElementById(texToBindId).innerText=defaultText+": "+selectedDs.replace(/,\s*$/, "");
	}
}
</script>
    
    
<script>

/* window.onload = function() {
	$('#chkds1').prop('checked', true);
}; */
</script>

<script src="/assets/js/apps/app.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/reqwest/2.0.5/reqwest.min.js"></script> 
<script>
var checkListTextBox =new Array();
var datafilterlist=new Array();
function SetCheckedList(e)
{ 
   var checkbox = event.target;
   var html="";
   html+="<span id='span_"+e.target.id+"' class='tag badge badge-primary'>"+e.target.name+"<span id='spremove"+e.target.id+"' onclick='removebadge(this,\""+e.target.id+"\")' data-role='remove'></span></span>";
       if (checkbox.checked) {
    	   alert(checkbox.checked);
           //Checkbox has been checked
           checkListTextBox.push(e.target.value);
           $(".bootstrap-tagsinput").append(html);
           //$("input:text").val(checkListTextBox);
           //$(this).trigger("enterKey");
       } else {
           //Checkbox has been unchecked
           checkListTextBox.splice(checkListTextBox.indexOf(event.target.value), 1);
           $("#span_"+e.target.id).remove();
       }
       
}

function removebadge(data,checkBoxID){
    $(data).parent().remove();
    $("#"+checkBoxID).prop('checked', false); 
}

</script>


