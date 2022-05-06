<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>



<input id="hdnNFBName" type="hidden" value='${nfbdetail.nfbMaster.nfbName}' />
<div class="table-responsive">

	<table class="table table-bordered">
		<tbody>
			<tr>
				<td><strong>CMV Area(Ha.) :</strong></td>
				<td><fmt:formatNumber value="${nfbdetail.cmvHa}" pattern="#.###"></fmt:formatNumber></td>
			</tr>
			<tr>
				<td><strong>MMV Area(Ha.) :</strong></td>
				<td><fmt:formatNumber value="${nfbdetail.mmvHa}" pattern="#.###"></fmt:formatNumber></td>
			</tr>			
			<tr>
				<td><strong>JV Area(Ha.) :</strong></td>
				<td><fmt:formatNumber value="${nfbdetail.jvHa}" pattern="#.###"></fmt:formatNumber></td>
			</tr>
			<tr>
				<td><strong>JV Category :</strong></td>
				<td>${nfbdetail.jvCatg}</td>
			</tr>
			<tr>
				<td><strong>DGPS Draft Area(Ha.) :</strong></td>
				<td><fmt:formatNumber value="${nfbdetail.dgpsdHa}" pattern="#.###"></fmt:formatNumber></td>
			</tr>
			
			<tr>
				<td><strong>FSO Certified Area(Ha.) :</strong></td>
				<td><fmt:formatNumber value="${nfbdetail.dgpsfHa}" pattern="#.###"></fmt:formatNumber></td>
			</tr>
		</tbody>
	</table>
</div>


