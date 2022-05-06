<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

<style>

.clearfix:before, .clearfix:after{  
    display: block!important;
    }
    @page {
  size: A4;
  margin: 11mm 17mm 17mm 17mm;
}
</style>


 <!-- BEGIN LOADER -->
    <div class="apploader-base"><div class="apploader"></div></div>
    <!--  END LOADER -->
    
<!--  BEGIN CONTENT AREA  -->
<div id="content" class="main-content">

	<div id="nonPrintArea" class="layout-px-spacing noprint">
		<div class="row layout-top-spacing">
			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">					
					<div class="widget-content widget-content-area">
						<form>
							<div class="row">
								<div class="col-md-1">
									<label class="mt-2">District</label>
								</div>
					
								<div class="col-md-3">
									<select class="form-control form-control-sm">										
										<option selected="selected">-- Select --</option>
										<!-- <option>1</option>
										<option>2</option> -->
									</select>
		
								</div>
								
								<div class="col-md-1">
									<label class="mt-2">Tahasil</label>
								</div>
								<div class="col-md-3">
									<select class="form-control form-control-sm">										
										<option selected="selected">-- Select --</option>
										<!-- <option>1</option>
										<option>2</option> -->
									</select>
								</div>
							
								<div class="col-md-4">
									<button type="button" class="btn btn-success btn-sm mt-1"><i class="fa fa-search">&nbsp;</i>Search</button>
									<button type="button" onclick="PrintDiv('printdivcontent');" class="btn btn-warning btn-sm mt-1 pull-right"><i class="fa fa-print">&nbsp;</i>Print</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>			
		</div>
	</div>

<div id="printdivcontent">
<c:set var="slnoP" value="0"></c:set>
<c:set var="pageNo" value="0"></c:set>
<c:forEach var="items" items="${caLandMaster}">
	<div class="layout-px-spacing  rows-print-as-pages">
		<div class="row layout-top-spacing">
		
			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">					
					<div class="widget-content widget-content-area">
						<div class="text-right">Page No: ${pageNo=pageNo+1 }</div>
						<div class="row border-light p-1">
						<table width="100%">
							<tr>
							<td><strong>Tahasil : </strong><span>${items.tahasil}</span></td>
							<td><strong>District : </strong><span>${fn:replace(items.dist_name,"Anugul","Angul")}</span></td>
							<td><strong>Division : </strong><span>${items.div_name}</span></td>
							<td><strong>Village : </strong><span>${items.village}</span></td>
							</tr>
						</table>
						
							<!-- <div class="col-md-3">
								
							</div>
							<div class="col-md-3">
								
							</div>
							<div class="col-md-3">
								
							</div>
							<div class="col-md-3">
								
							</div> -->
							
						</div>
						<div class="row border-light p-1 mb-2">
							<div class="col-md-12">
								<strong>P.S. Name : </strong>
								<span>${items.ps }</span>,
								<strong>P.S. No. : </strong>
								<span>${items.thana_no}</span>,
								<strong>RI Circle Name : </strong>
								<span>${items.ric}</span>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="table-responsive">
									<table class="table table-bordered mb-0">
										<thead>
											<tr>
												<th>Sl.</th>
												<th>Khata No.</th>
												<th>Plot No.</th>
												<th>Kissam</th>
												<th>Rev. Area(Acre)</th>
												<th>GIS Area(Acre)</th>
												<th>Avg. Canopy Density</th>
												<!-- <th>Remarks</th>
												<th>Part of NFB</th> -->
												<th>Encroachment Status </th>
												<th>Proximity to NFB<br>(Less than 100 mtr.)</th>
											</tr>
										</thead>
										<tbody>
										<c:set var="slno" value="0"></c:set>
										<c:set var="SumArea_ac" value="0"></c:set>
										<c:set var="SumTotal_area" value="0"></c:set>
										 <c:forEach var="childItems" items="${caLandDetails.stream().filter(f->f.getVill_code().equals(items.vill_code)).toList()}">
											<tr>
												<td align='right' style="font-size: 11pt">${slno=slno+1}</td>
												<td align='right' style="font-size: 11pt">${childItems.khata_no}</td>
												<td align='right' style="font-size: 11pt">${childItems.rplot_no}</td>
												<td align='center' style="font-size: 11pt">${childItems.kissam}</td>
												<td align='right' style="font-size: 11pt"><fmt:formatNumber value="${childItems.area_ac}" minFractionDigits="2" maxFractionDigits="2"></fmt:formatNumber></td>
												<td align='right' style="font-size: 11pt"><fmt:formatNumber value="${childItems.total_area}" minFractionDigits="3" maxFractionDigits="3"></fmt:formatNumber></td>
												<td align='center' style="font-size: 11pt">${childItems.wgt_cd}</td>
												<%-- <td style="font-size: 11pt">${childItems.remarks}</td>
												<td style="font-size: 11pt">${childItems.is_nfb}</td> --%>
												<td style="font-size: 11pt">${childItems.encroach}</td>
												<td> </td>
												
												<c:set var="SumArea_ac" value="${SumArea_ac=childItems.area_ac+SumArea_ac}"></c:set>
												<c:set var="SumTotal_area" value="${SumTotal_area=childItems.total_area+SumTotal_area}"></c:set>
											</tr>
											
									 </c:forEach>
									 	<tr>
											<td colspan='3' align='center' style="font-size: 12pt;font-weight: bold;">Total</td>
											<td align='right'style="font-size: 11pt;font-weight: bold;"><fmt:formatNumber value="${SumArea_ac}" minFractionDigits="2" maxFractionDigits="2"></fmt:formatNumber> </td>
											<td align='right' style="font-size: 11pt;font-weight: bold;"><fmt:formatNumber value="${SumTotal_area}" minFractionDigits="3" maxFractionDigits="3"></fmt:formatNumber></td>
											<td colspan='4'></td>
											</tr>
											
										</tbody>
									</table>
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>			
		</div>
	</div>
 <div id="footer${slnoP=slnoP+1 }" class="footer text-center small">---End of Report ${items.village} Village---</div>
</c:forEach>
	
</div>
</div>

<%-- <%@ include file="../shared/footer.jsp"%> --%>


<script type="text/javascript">
function PrintDiv(printdivcontent) { 
	
	 var printContents = document.getElementById(printdivcontent).innerHTML;
   //$("#nonPrintArea").hide(); 
   setTimeout(function(){
	$("#printdivcontent").show();
	//alert(${slnoP});
	for(var i=1;i<${slnoP};i++){
		document.getElementById("footer"+i).style.pageBreakAfter = "always";
	}
	
	//document.getElementById("footer").style.pageBreakBefore = "always";
	
    window.print();
    //$("#printdivcontent").hide();
    //$("#nonPrintArea").show();
   }, 200);
}  

</script>


