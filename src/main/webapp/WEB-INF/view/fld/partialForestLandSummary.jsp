<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!-- <div class="col-md-4 text-right">
	<br> <strong>Date : </strong><span class="spDate"></span>
</div> -->
<div class="widget-content widget-content-area" id="tblStatistics">
							
		<div class="table-responsive">
			<table id="" class="table table-light table-sm" style="border: none;">
				<!-- <thead>
					<tr>
						<th>Sl. No.</th>
						<th align="center">Forest Type</th>
						<th align="right">No of NFB</th>
						<th align="right">Area(Ha.)</th>
					</tr>
				</thead> -->
				<tbody>									
					<%-- <c:set var="slno" value="0"></c:set> --%>
					<c:set var="totalFb" value="0"></c:set>
					<c:set var="NFBArea" value="0"></c:set>
					<tr style="border: none;" id="customNfb">
					<c:forEach var="item" items="${nfbStatistics}">
						
							<%-- <td>${slno=slno+1}</td> --%>
							<td align="center">
							${item.getNFB_type()}(Ha.) :<fmt:formatNumber value='${item.getfb_Area()}' pattern="0.00"></fmt:formatNumber>
							<small>(FBs:${item.getno_of_fb()}) </small>
							</td>
							<%-- <td align="right">${item.getno_of_fb()}</td>
							<td align="right"><fmt:formatNumber value='${item.getfb_Area()}' pattern="0.00"></fmt:formatNumber></td>
						 --%>
						<c:set var="totalFb" value="${totalFb=totalFb+(item.getno_of_fb())}"></c:set> 
						<c:set var="NFBArea" value="${NFBArea=NFBArea+((item.getfb_Area()))}"></c:set>
					</c:forEach>
					<td align="right"><strong>Total Area(Ha.) : <fmt:formatNumber value='${NFBArea}' pattern="0.00"></fmt:formatNumber>
					<small>(FBs:${totalFb})</small></strong>
					</td>
					</tr>
				</tbody>
				
				<%-- <tfoot>
					<tr>
						<td colspan='2'><b>Total</b></td>
						<td align="right"><b>${totalFb}</b></td>
						<td align="right"><b><fmt:formatNumber value='${NFBArea}' pattern="0.00"></fmt:formatNumber> </b></td>
						
					</tr>
				</tfoot> --%>
            </table>
      </div>
</div>
<script>
/* $(document).ready(function() {
	var today = new Date();
	$(".spDate").text(formatDate(today));
	
}); 
 function formatDate(date) {
	    var d = new Date(date),
	        month = '' + (d.getMonth() + 1),
	        day = '' + d.getDate(),
	        year = d.getFullYear();

	    if (month.length < 2) 
	        month = '0' + month;
	    if (day.length < 2) 
	        day = '0' + day;

	    return [day, month, year].join('-');
	} */
</script>

