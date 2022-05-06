<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<div class="table-responsive tableFixHead">
	<table id="example" class="table table-bordered">
		<thead>
			<tr class="text-center">
				<th style="padding: 1px 3px !important">Pillar No</th>
				<th style="padding: 1px 3px !important">Pillar Type</th>
				<th style="padding: 1px 3px !important">Pillar Condn.</th>
				<th style="padding: 1px 3px !important">Paint Status</th>
				<!-- <th style="padding: 1px 3px !important">Easting</th>
				<th style="padding: 1px 3px !important">Northing</th> -->
				<th style="padding: 1px 3px !important">Lat</th>
				<th style="padding: 1px 3px !important">Lon</th>
				<th style="padding: 1px 3px !important">Pillar Shifting Status</th>
				
			
				<th style="padding: 1px 3px !important">Survey Date</th>
			<!-- 	<th style="padding: 1px 3px !important">Surveyor Name</th> -->
				
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${frjvcPointDtls}">
				<tr class="custom-btn-hover">
			
					<td style="padding: 1px 3px !important" class="text-center">
						<span>${item.pillar_no}</span>
					</td>
					<td style="padding: 1px 3px !important" class="text-center">
							${item.pillar_type}
						</td>
					

				<td>${item.pillar_condition}</td>
					
					<td>${item.paint_status}</td>
					
					<td style="padding: 1px 3px !important" class="text-center">
							${item.latitude_dd}
						</td>
					<td style="padding: 1px 3px !important" class="text-center">
							${item.longitude_dd}
                	</td>
					
					<td style="padding: 1px 3px !important" class="text-center">
						${item.pillar_shifting_status }
					</td>
					
					<td style="padding: 1px 3px !important" class="text-center">
						<fmt:formatDate value="${item.survey_date}" pattern="dd-MM-yyyy"/> 
					</td>
					
				<%-- 	<td style="padding: 1px 3px !important" class="text-center">
						${item.surveyor_name }
					</td> --%>
		
			</c:forEach>
		</tbody>
	</table>
</div>

 <input type="hidden" id="mfbNm" value="${frjvcMaster.nfbName}">
<input type="hidden" id="mfbType" value="${frjvcMaster.nfbType}">
<input type="hidden" id="mrngNm" value="${frjvcMaster.chrvRangeNm}">
<input type="hidden" id="mdivNm" value="${frjvcMaster.chrvDivisionNm}">
<%--<input type="hidden" id="hTotal" value="${model.getDGPSDataFBWiseList().stream().filter(m->m.getSolutionType()=='RTX').map(m ->m.getPillarNo()).count()}">
<input type="hidden" id="hvTotal" value="${model.getDGPSDataFBWiseList().stream().filter(m->m.getSolutionType()=='RTX').count() - model.getDGPSDataFBWiseList().stream().filter(m->m.getRtxHprec() > 1 || m.getRtxVprec() >1).count()}">
<input type="hidden" id="hiTotal" value="${model.getDGPSDataFBWiseList().stream().filter(m->m.getSolutionType()=='RTX' && (m.getRtxHprec() > 1 || m.getRtxVprec() > 1)).count()}">

 --%>