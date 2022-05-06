
<%@page import="java.util.stream.Collectors"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!--  BEGIN MAIN CONTAINER  -->
<div class="loader-base" id="idLoader">
	<div class="loader"></div>
</div>
<div class="main-container sidebar-closed sbar-open" id="container">
	<script>
		function ManageLoader(type) {
			if (type == 1) {
				$('#idLoader').show();
			} else {
				$('#idLoader').hide();
			}
		}
	</script>
	<div class="overlay"></div>
	<div class="cs-overlay"></div>
	<div class="search-overlay"></div>

	<!--  BEGIN SIDEBAR  -->
	<div class="sidebar-wrapper sidebar-theme">
		<nav id="sidebar">
			<ul class="navbar-nav theme-brand flex-row  text-center">
				<li class="nav-item theme-logo"><a
					href="/FLD/forestLandDetails"> <img
						src="/assets/img/logo-app.png" class="navbar-logo" alt="logo">
				</a></li>
				<li class="nav-item theme-text"><a href="#"
					class="nav-link">ODISHA FLI-DSS </a></li>
			</ul>

			<ul class="list-unstyled menu-categories" id="accordionExample">

				<c:forEach items="${gLinkList}" var="glink">
					<%-- <c:set var="plinkUrl"
						value="${pLinkList.stream().filter(f->f.getGlobalLinkMaster().getIntGlinkId()==glink.getIntGlinkId()).map(m->m.getChrvPlinkUrl()).toList().get(0) }"></c:set> --%>
					<c:choose>
						<c:when
							test="${pLinkList.stream().filter(f->f.getGlobalLinkMaster().getIntGlinkId()==glink.getIntGlinkId() && !f.getGlobalLinkMaster().getChrvGlinkName().equals(f.getChrvPlinkName())).count()==0 }">
							<%-- <c:when	test='${pLinkList.stream().filter(a->a.getGlobalLinkMaster().getIntGlinkId()==glink.getIntGlinkId()).count()==1 && glink.getChrvGlinkName()==pLinkList.stream().filter(a->a.getGlobalLinkMaster().getIntGlinkId()==glink.getIntGlinkId()).map(a->a.getChrvPlinkName()).toList().get(0)}'> --%>

							<li class="menu"><a href="/${glink.getChrvGlinkUrl()}"
								aria-expanded="false" class="dropdown-toggle">
									<div class="">
										${glink.getLinkStyle()} <span>${glink.getChrvGlinkName()}</span>

									</div>
							</a></li>
						</c:when>
						<c:otherwise>
							<li class="menu"><a href="${glink.getChrvGlinkUrl()}"
								data-toggle="collapse" aria-expanded="false"
								class="dropdown-toggle">
									<div class="">
										${glink.getLinkStyle() } <span>${glink.getChrvGlinkName()}</span>
									</div>
									<div>
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
											viewBox="0 0 24 24" fill="none" stroke="currentColor"
											stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round" class="feather feather-chevron-right">
												<polyline points="9 18 15 12 9 6"></polyline></svg>
									</div>
							</a>
								<ul class="collapse submenu list-unstyled"
									id="${glink.getChrvGlinkUrl().replace('#','')}"
									data-parent="#accordionExample">
									<c:forEach
										items="${pLinkList.stream().filter(a->a.getGlobalLinkMaster().getIntGlinkId()==glink.getIntGlinkId()).toList()}"
										var="plink">
										<li><a href="/${plink.getChrvPlinkUrl()}">
												${plink.getChrvPlinkName()} </a></li>
									</c:forEach>
								</ul></li>

						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${userProjList!=null}">
					<li class="menu"><a href="#myProjects" data-toggle="collapse"
						aria-expanded="false" class="dropdown-toggle">
							<div class="">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-folder">
								<path
										d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
								<span>My Projects</span>
							</div>
							<div>
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-chevron-right">
								<polyline points="9 18 15 12 9 6"></polyline></svg>
							</div>
					</a>
						<ul class="collapse submenu list-unstyled" id="myProjects" data-parent="#accordionExample">
							<c:forEach items="${userProjList}" var="projList">
								<li>
									<a href="/UserProject/userMapView?projId=${projList.intId}">
										${projList.projectName } 
										<i
											class='fa fa-trash text-danger font-14 mr-2'
											onclick='deleteProject("${projList.intId}")'>
										</i>
									</a>
								</li>
								
							</c:forEach>
						</ul></li>

				</c:if>
			</ul>



			<%-- <ul>
				 <li class="menu"><a href="/GIS/dataCatalogue"
					aria-expanded="false" class="dropdown-toggle">
						<div class="">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-layers">
								<polygon points="12 2 2 7 12 12 22 7 12 2"></polygon>
								<polyline points="2 17 12 22 22 17"></polyline>
								<polyline points="2 12 12 17 22 12"></polyline></svg>
							<span>Data Catalogue</span>
						</div>
				</a></li>

				<li class="menu"><a href="/FLD/forestLandDetails"
					aria-expanded="false" class="dropdown-toggle">
						<div class="">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-map">
								<polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6"></polygon>
								<line x1="8" y1="2" x2="8" y2="18"></line>
								<line x1="16" y1="6" x2="16" y2="22"></line></svg>
							<span>Forest Land Details</span>
						</div>
				</a></li>

				<li class="menu"><a href="/FLD/forestLandInfo"
					aria-expanded="false" class="dropdown-toggle">
						<div class="">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-map-pin">
								<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
								<circle cx="12" cy="10" r="3"></circle></svg>
							<span>Forest Land Information</span>
						</div>
				</a></li>

				<li class="menu"><a href="#decisionSupportSystem"
					data-toggle="collapse" aria-expanded="false"
					class="dropdown-toggle">
						<div class="">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-box">
								<path
									d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
								<polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
								<line x1="12" y1="22.08" x2="12" y2="12"></line></svg>
							<span>Decision Support System</span>
						</div>
						<div>
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-chevron-right">
								<polyline points="9 18 15 12 9 6"></polyline></svg>
						</div>
				</a>
					<ul class="collapse submenu list-unstyled"
						id="decisionSupportSystem" data-parent="#accordionExample">
						<li><a href="/DSS/aoiAnalysis"> AOI Analysis </a></li>
						<li><a href="/DSS/customQuery"> Custom Query </a></li>
					</ul></li>

				<li class="menu"><a href="#support" data-toggle="collapse"
					aria-expanded="false" class="dropdown-toggle">
						<div class="">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-users">
								<path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
								<circle cx="9" cy="7" r="4"></circle>
								<path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
								<path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
							<span>Support</span>
						</div>
						<div>
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-chevron-right">
								<polyline points="9 18 15 12 9 6"></polyline></svg>
						</div>
				</a>
					<ul class="collapse submenu list-unstyled" id="support"
						data-parent="#accordionExample">
						<li><a href="#"> FAQ </a></li>
						<li><a href="#"> User Manual </a></li>
						<li><a href="#"> Operation Guide </a></li>
					</ul></li>

				<li class="menu"><a href="#portalAdministration"
					data-toggle="collapse" aria-expanded="false"
					class="dropdown-toggle">
						<div class="">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-lock">
								<rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
								<path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
							<span>Portal Administration</span>
						</div>
						<div>
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-chevron-right">
								<polyline points="9 18 15 12 9 6"></polyline></svg>
						</div>
				</a>
					<ul class="collapse submenu list-unstyled"
						id="portalAdministration" data-parent="#accordionExample">
						<li><a href="/UserMgmt/addPositionToUser"> Set user-wise position </a></li>
						<li><a href="/UserMgmt/addPosition"> Position Creation </a></li>
						<li><a href="/UserMgmt/roleCreation"> Role Creation </a></li>
						<li><a href="/UserMgmt/userCreation"> User Creation </a></li>
						<li><a href="/UserMgmt/AddSetPermission"> Role &
								Permission </a></li>
						<li><a href="/UserMgmt/addGlobalLink"> Global Link </a></li>
						<li><a href="/UserMgmt/addPrimaryLink"> Primary Link </a></li>
						
					</ul></li>

				</ul>

  --%>

		</nav>

	</div>
	<!--  END SIDEBAR  -->
	<script type="text/javascript">

	//if(confirm("Do you want to upgrade?")){ Your code }
		function deleteProject(intId) {
			$.ajax({
				url : "/deleteProject/"+ intId,
				type: 'DELETE',
				success : function(response) 
				{
					//viewNotification(response);//function for alert call					
					//sleep(1000);
					
					costumeNotification(response);
					window.location.href="/GIS/dataCatalogue";
					
				    /* let url ="/GIS/dataCatalogue";				    
				    costumeNotification(response);
					setTimeout(function(){window.location.href =url;}; */
				},
				error : function(errormessage) {
					alert(errormessage.responseText);
				}
			})
		}
	</script>