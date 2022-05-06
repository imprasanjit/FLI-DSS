<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tl" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<style>
		img {
		  border: 1px solid #ddd; /* Gray border */
		  border-radius: 4px;  /* Rounded border */
		  padding: 5px; /* Some padding */
		  width: 80 !important; /* Set a small width */
		}
		
		/* Add a hover effect (blue shadow) */
		img:hover {
		  box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
		}
		</style>

<div class="table-responsive tableFixHead">
	<table id="example" class="table table-bordered">
		<thead>
			<tr class="text-center">
				<th style="padding: 1px 3px !important">Pillar No</th>
				<th style="padding: 1px 3px !important">Pillar Type</th>
				<!-- <th style="padding: 1px 3px !important">Dur of obs(mm:ss)</th> -->
				<th style="padding: 1px 3px !important">RTX Soln Type</th>
				<th style="padding: 1px 3px !important">H.Acc(Mtr)</th>
				<th style="padding: 1px 3px !important">V.Acc(Mtr)</th>
			    <th style="padding: 1px 3px !important">Easting</th>
				<th style="padding: 1px 3px !important">Northing</th>
				<th style="padding: 1px 3px !important">Lat</th>
				<th style="padding: 1px 3px !important">Lon</th>
				
				<th style="padding: 1px 3px !important">Fwd</th>
				<th style="padding: 1px 3px !important">Bkwd</th>
				<th style="padding: 1px 3px !important">Inwd</th>
				<th style="padding: 1px 3px !important">OutWD</th>
				<!-- <th style="padding: 1px 3px !important">W Dev.</th> -->

			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${frjvcPointDtls}">
			<tr class="custom-btn-hover">
				<td style="padding: 1px 3px !important">${item.pillar_no }</td>
				<td style="padding: 1px 3px !important">${item.pillar_type }</td>
				<%-- <td style="padding: 1px 3px !important">${item.dur_of_obs_mmss }</td> --%>
				<td style="padding: 1px 3px !important">${item.solution_type}</td>
			    <td style="padding: 1px 3px !important">${item.horizonental_prec_m}(Mtr)</td>
				<td style="padding: 1px 3px !important">${item.vertical_prec_m }(Mtr)</td>
			    <td style="padding: 1px 3px !important">${item.easting }</td>
				<td style="padding: 1px 3px !important">${item.northing }</td>
				<td style="padding: 1px 3px !important">${item.latitude }</td>
				<td style="padding: 1px 3px !important">${item.longitude}</td>
				
				<td style="padding: 1px 3px !important">
					<a target="_blank" href="/projectDocs/download/dgpsImages/${item.divid}/${item.nfb_id}/${fn:replace(item.forwad_image_path,'/storage/emulated/0/Pictures/CameraSample/','')}">
						<img width="80px" src="/projectDocs/download/dgpsImages/${item.divid}/${item.nfb_id}/${fn:replace(item.forwad_image_path,'/storage/emulated/0/Pictures/CameraSample/','')}" alt="forward image">
					  </a>
					 <!-- ${fn:replace(item.forwad_image_path,'/storage/emulated/0/Pictures/CameraSample/','')} -->
				</td>
				<td style="padding: 1px 3px !important">
					<a target="_blank" href="/projectDocs/download/dgpsImages/${item.divid}/${item.nfb_id}/${fn:replace(item.backward_image_path,'/storage/emulated/0/Pictures/CameraSample/','')}">
						<img width="80px" src="/projectDocs/download/dgpsImages/${item.divid}/${item.nfb_id}/${fn:replace(item.backward_image_path,'/storage/emulated/0/Pictures/CameraSample/','')}" alt="backword image">
					  </a>
				</td>
				<td style="padding: 1px 3px !important">
					<a target="_blank" href="/projectDocs/download/dgpsImages/${item.divid}/${item.nfb_id}/${fn:replace(item.inward_image_path,'/storage/emulated/0/Pictures/CameraSample/','')}">
						<img width="80px" src="/projectDocs/download/dgpsImages/${item.divid}/${item.nfb_id}/${fn:replace(item.inward_image_path,'/storage/emulated/0/Pictures/CameraSample/','')}" alt="Inwd image">
					  </a>
				</td>

				<td style="padding: 1px 3px !important">
					<a target="_blank" href="/projectDocs/download/dgpsImages/${item.divid}/${item.nfb_id}/${fn:replace(item.outward_image_path,'/storage/emulated/0/Pictures/CameraSample/','')}">
						<img width="80px" src="/projectDocs/download/dgpsImages/${item.divid}/${item.nfb_id}/${fn:replace(item.outward_image_path,'/storage/emulated/0/Pictures/CameraSample/','')}" alt="OutWD image">
					  </a>
				</td>
				<!-- <td style="padding: 1px 3px !important">W Dev.</td> -->
				
			</tr>	
			</c:forEach>
		</tbody>
	</table>
</div>

 <input type="hidden" id="mfbNm" value="${frjvcMaster.nfbName}">
<input type="hidden" id="mfbType" value="${frjvcMaster.nfbType}">
<input type="hidden" id="mrngNm" value="${frjvcMaster.chrvRangeNm}">
<input type="hidden" id="mdivNm" value="${frjvcMaster.chrvDivisionNm}">


<%-- td style="padding: 1px 3px !important" class="text-center">
						<span>${item.pillar_no}</span>
					</td>
					<td style="padding: 1px 3px !important" class="text-left">
							${item.pillar_type}
						</td>
					

				<td>${item.pillar_condition}</td>
					
					<td>${item.paint_status}</td>
					
					<td style="padding: 1px 3px !important" class="text-center">
							${item.latitude_dd}
						</td>
					<td style="padding: 1px 3px !important" class="text-left">
							${item.longitude_dd}
                	</td>
					
					<td style="padding: 1px 3px !important" class="text-right">
						${item.pillar_shifting_status }
					</td>
					
					<td style="padding: 1px 3px !important" class="text-right">
						${item.survey_date }
					</td>
					
					<td style="padding: 1px 3px !important" class="text-right">
						${item.surveyor_name }
					</td>
		 --%>
