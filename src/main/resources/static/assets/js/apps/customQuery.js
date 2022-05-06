
//Select Division or District

$("#btnDivision").click(function () {
    $("#btnDivision").addClass("btn-dark").removeClass("btn-secondary");
    $("#btnDistrict").addClass("btn-secondary").removeClass("btn-dark");     
    
    $("#distDiv").hide();
    $("#tehDiv").hide();
    
    
	$("#divsnDiv").show();
	$("#ranDiv").show();
	
	$("#drpDistrict").val('');
	$("#drpTehList").val('');
});

$("#btnDistrict").click(function () {
	$("#btnDistrict").addClass("btn-dark").removeClass("btn-secondary");
    $("#btnDivision").addClass("btn-secondary").removeClass("btn-dark");   
    
    $("#distDiv").show();
    $("#tehDiv").show();
    
	$("#divsnDiv").hide();
	$("#ranDiv").hide();
	
	$("#drpDivision").val('');
	$("#drpRngList").val('');
});

//End of Select Division or District

/*On change of District */
//Bind District wise Range dropdownlist
$("#drpDistrict").change(function() {
    clearSelectValue();
    $('#divform').empty();
    var distid = $('#drpDistrict').val();
    if ($('#drpDistrict').val() != '') {
           districtWiseRange(distid);
           districtWiseTahsil($("#drpDistrict").val());
       }

});
/*End On change of District */


/*  onChange of Forest Land Type */
var value1="";
$('#drpfltype').on('change', function() {
   
    flTypeListChange();
    
    value1=$('#drpfltype').val();

    

    /* $("#drpdistDivList").val($("#drpdistDivList option:first").val());
     $("#drpDistrict").val($("#drpDistrict option:first").val());
     $("#drpDivision").val($("#drpDivision option:first").val());*/
     
     
     clearSelectValue();

     BinddCustomFields(value1);
     
     BindCondn(value1,'ddlCondn');
     BindCondn(value1,'ddlQbFields1');
     
     //if(value1=='1'){
        // $("#tehDiv").hide();
         //$("#villDiv").hide();
        
         
         //BinddCustomFields($('#drpfltype'));
     //}
    
     //else{
         
        // $("#tehDiv").show();
         //$("#villDiv").show();
     //}
    
     if($("#drpDistrict").val()>0){
         districtWiseRange($("#drpDistrict").val());
         districtWiseTahsil($("#drpDistrict").val());
     }
     else if($("#drpDivision").val()>0){
       var obj=$('#drpDivision');
         divisionWiseRange(obj.get(0));
         divisionWiseTahsil($('#drpDivision').val());
     }
     
});

/*End of onChange of Forest Land Type */
 
$("#drpDisFields").change(function(event)
{

    selectedArr=$(this).val();
    //console.log('Selected Arr1: '+selectedArr);
    //selectedData=[];
    //console.log(selectedArr);
   var count = $("#drpDisFields :selected").length;
    
        if((event.target.id)=="drpDisFields")
        {
            //console.log('selected Arr: '+ $.inArray('nfbName', selectedArr));
            
            if ( $.inArray('nfbName', selectedArr) == -1 ) {
                if(selectedArr==null)
                {
                    selectedArr=[];
                }
                
                selectedArr.unshift("nfbName");
        
                $(this).val(selectedArr);
                //$("#drpDisFields").multiselect('rebuild');
                $(this).val(selectedArr);
               
            }
                //nfinfo=selectedArr;
        } 
              
        //console.log('Selected Data '+selectedData);
        setSelectedtext();

        
    
   //selectedData=selectedData.concat(nfinfo);
   //selectedData = selectedData.filter(function (el) {
      //  return el != null && el != "";
    //});
    //console.log('Final Selected Data: '+selectedData);
   
});



function divisionWiseRange(e){
 if ($(e).val() != '') {
        $.ajax({
            url: '/Utility/getDivwiseRange',
            data: {
                'divid': e.value
            },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(data) {
                $('#drpRngList').html('');
                var options = '';
                $('#drpRngList').append($("<option></option>").attr("value", "").text("--Select--"));
                $.each(data, function(a, b) {
                    options += '<option value="' + b.strValue + '">' + b.text + '</option>';

                });
                $('#drpRngList').append(options);

            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });
    }
}

/* On change of Division */
function divListChange(e) {
    clearSelectValue();
    $('#divform').empty();
   divisionWiseRange(e);
   divisionWiseTahsil(e.value);
}
/* End On change of Division */

function districtWiseTahsil(distid){

 var url = "";
        
       url = "/Utility/getDistwiseTahasil";
        
        $.ajax({
            url: url,
            data: {
                'distid': distid
            },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(data) {
                var options = '';

                    $('#drpTehList').html('');
                    $('#drpTehList').append($("<option></option>").attr("value", "").text("--Select--"));
                    $.each(data, function(a, b) {
                        options += '<option value="' + b.value + '">' + b.text + '</option>';
                    });
                    $('#drpTehList').append(options);
               
            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });

}

function divisionWiseTahsil(divid){

 var url = "";
        
       url = "/Utility/getDivwiseTahasil";
        
        $.ajax({
            url: url,
            data: {
                'divid': divid
            },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(data) {
                var options = '';

                    $('#drpTehList').html('');
                    $('#drpTehList').append($("<option></option>").attr("value", "").text("--Select--"));
                    $.each(data, function(a, b) {
                        options += '<option value="' + b.value + '">' + b.text + '</option>';
                    });
                    $('#drpTehList').append(options);
               
            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });
}

function districtWiseRange(distid){

 var url = "/Utility/getDistwiseRange";
        /*if ($("#drpfltype").val() == 1) {
            url = "/Utility/getDistwiseRange";
        } else {
            url = "/Utility/getDistwiseTahasil";
        }*/
        $.ajax({
            url: url,
            data: {
                'distid': distid
            },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(data) {
                var options = '';
                
                //if ($("#drpfltype").val() == 1) {
                
                    $('#drpRngList').html('');
                    $('#drpRngList').append($("<option></option>").attr("value", "").text("--Select--"));
                    $.each(data, function(a, b) {
                        options += '<option value="' + b.strValue + '">' + b.text + '</option>';
                    });
                    $('#drpRngList').append(options);
                    
                //} else {
                /*
                    /*$('#drpTehList').html('');
                    $('#drpTehList').append($("<option></option>").attr("value", "").text("--Select--"));
                    $.each(data, function(a, b) {
                        options += '<option value="' + b.value + '">' + b.text + '</option>';
                    });
                    $('#drpTehList').append(options);*/
                //}
            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });

}

/* Bind Fields under as per Forest Land Type */
function BinddCustomFields(e) {
    $('#drpDisFields').val([]);
    //$('#divform').empty();
    if (e!= '') {
        $.ajax({
            url: '/Utility/getCustomQueryFields',
            data: {
                'forestLandType':e
            },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(data) {
                $('#drpDisFields').html('');
                var options = '';
                $('#drpDisFields').append($("<option></option>").attr("value", "").text("--Select--"));
                
                
                $.each(data, function(a, b) {
                    if(b.isChecked){
                        options += '<option value="' + b.strValue + '" selected >' + b.text+ '</option>';
                    }
                    else{
                        options += '<option value="' + b.strValue + '"  >' + b.text+ '</option>';
                    }
                    
                    $("#drpDisFields").multiselect('rebuild');
                });
                $('#drpDisFields').append(options);
                $("#drpDisFields").multiselect('rebuild');

                setSelectedtext();

            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });
    }
}
/* End of Bind Fields under as per Forest Land Type */

function BindCondn(e,controlId) {
    
    //$('#divform').empty();
    if (e!= '') {
        $.ajax({
            url: '/Utility/getCustomQueryFields',
            data: {
                'forestLandType':e
            },
            type: "GET",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(data) {
                $('#'+controlId).html('');
                var options = '';
                $('#'+controlId).append($("<option selected></option>").attr("value", "").text("--Select--"));
                
                
                $.each(data, function(a, b) {
                    if(b.isNumeric){
                        options += '<option value="' + b.strValue + '"  >' + b.text+ '</option>';
                    }
                    
  
                });
                $('#'+controlId).append(options);
               

                setSelectedtext();

            },
            error: function(errormessage) {
                alert(errormessage.responseText);
            }
        });
    }
}


//Clear Dropdownlist
function clearSelectValue() {

    $('#drpRngList').html('');
    $('#drpTehList').html('');
    $('#drpRngList').append($("<option></option>").attr("value", "").text("--Select--"));
    $('#drpTehList').append($("<option></option>").attr("value", "").text("--Select--"));

}


function flTypeListChange() {
	 clearSelectValue();
	    $('#divform').empty();
};


function setSelectedtext()
{

	var setValue=[];
    var setText=[];
    selectedHeader=[];

    $("#drpDisFields option:selected").each(function () {
        var $this = $(this);
        if ($this.length) {
            setText.push($this.text());
            setValue.push($this.val())
            //selectedHeader.push($this.text());
        }
    });
    $("#spnotif").html(setValue.join(", "));
    
    
    //nfinfo=setValue.join(", ");
    //selectedData=setValue.join(", ");
   // alert('Yes Execute...'+setValue.join(", "));
}
 