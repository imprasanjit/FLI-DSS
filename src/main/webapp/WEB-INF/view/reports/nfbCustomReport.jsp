<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../shared/header.jsp"%>
<%@ include file="../shared/sidebar.jsp"%>

<style>
	#left-defaults, #right-defaults{
        min-height: 450px;
		max-height: 450px;
		overflow: auto;
	}
	.parent.ex-1 .dragula .media, body.gu-unselectable .media.el-drag-ex-1{
		padding: 3px 10px;
	}
	.dragula > div, .gu-mirror{
		margin: 5px;
	}
	h6.pt-3{
		font-weight: 600;
		color: #077b6d;
	}
</style>

<!-- BEGIN LOADER -->
<div class="apploader-base">
	<div class="apploader"></div>
</div>
<!--  END LOADER -->

<div id="content" class="main-content">
	<div class="layout-px-spacing">

		<div class="row layout-top-spacing">

			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">

					<div class="widget-content widget-content-area">
					
						<form>
							<div class="row">
								<div class="col-md-1">
									<label class="mt-2">Division</label>
								</div>
					
								<div class="col-md-2">								
									
									<select class="form-control form-control-sm" id="drpDivision" onchange="divListChange(this)">
										<option value="0">--Select--</option>
										<c:forEach items="${divList}" var="diviList">
											<option value="${diviList.intId}">${diviList.chrvDivisionNm}</option>
										</c:forEach>

									</select>	
								</div>
								
								<div class="col-md-1">							
									<label class="mt-2">Range</label>
									
								</div>
								<div class="col-md-2">
									<select class="form-control form-control-sm" id="drpRngList" onchange="rngListChange(this)">										
										<option selected="selected" value="0">-- All --</option>
										
									</select>																		
								</div>
								
								<div class="col-md-1">							
									<label class="mt-2">Forest Block</label>
									
								</div>
								<div class="col-md-2">
									<select class="form-control form-control-sm" id="drpNfbList">										
										<option selected="selected" value="">-- All --</option>
										
									</select>																		
								</div>
								
								<!-- <div class="col-md-3">
									<button type="button" class="btn btn-success"><i class="fa fa-search">&nbsp;</i>Search</button>
								</div> -->
			
							</div>
						</form>
					
					</div>
				</div>
			</div>
		</div>
	
		<div class="row layout-top-spacing">
			<div class="col-md-12 mb-1">
				<div class="statbox widget box box-shadow">
					<div class="widget-content widget-content-area">
					
						<div class="row">
							<div class="col-md-12 text-right">
								<p><small class="text-danger">Drag to arrange the order.</small></p>
							</div>
						</div>
					
						<div class='parent ex-1'>
                            <div class="row">

                                <div class="col-sm-6">
                                	<div class="widget">
                                		<div class="widget-header">
                                			<h4>Selection</h4>
                                		</div>
                                	</div>
                                	
                                    <div id='left-defaults' class='dragula widget-header'>
                                    
<!--                                     	<div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Division</h6>   
                                                         <input type="hidden" value="Division">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    	
										 <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Range</h6>   
                                                         <input type="hidden" value="Range">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
										
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Type</h6>   
                                                         <input type="hidden" value="Type">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                         <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="fields">ReNotification of GR Boundary No. & Date</h6>
                                                        <input type="hidden" value="GRReNotifnNoDt">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">No. of Boundary Point</h6>   
                                                         <input type="hidden" value="NoofBounPoint">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> -->
                                        
                                        <h6 class="pt-3 pl-3 pr-3">Notification Info</h6>
                                        
                                      <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Division</h6>   
                                                         <input type="hidden" value="Division">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    	
										 <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Range</h6>   
                                                         <input type="hidden" value="Range">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
										
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Forest Type</h6>   
                                                         <input type="hidden" value="Type">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                         <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="fields">ReNotification of GR Boundary No. & Date</h6>
                                                        <input type="hidden" value="GRReNotifnNoDt">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">No. of Boundary Point</h6>   
                                                         <input type="hidden" value="NoofBounPoint">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                      
                                        <h6 class="pt-3 pl-3 pr-3">WP Info</h6>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">WP Year</h6>   
                                                         <input type="hidden" value="WpYear">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">WP Area (Ha.)</h6>   
                                                         <input type="hidden" value="WpArea">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">MMV Area (Ha.)</h6>   
                                                         <input type="hidden" value="MmvArea">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <!-- <h6 class="">NFA - MMVA (Ha.)</h6> -->   
                                                        <h6 class="">(NFA - MMV)Area (Ha.)</h6>
                                                         <input type="hidden" value="DiffNfMmv">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">(NFA - MMV)Area % Difference</h6>   
                                                         <input type="hidden" value="DiffNfMmvPerc">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <h6 class="pt-3 pl-3 pr-3">CMV Info</h6>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">CMV Area (Ha.)</h6>   
                                                         <input type="hidden" value="CmvArea">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">(NFA - CMV)Area (Ha.)</h6>   
                                                         <input type="hidden" value="DiffCmvNfa">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">(NFA - CMV)Area % Difference</h6>   
                                                         <input type="hidden" value="DiffCmvNfaPerc">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <h6 class="pt-3 pl-3 pr-3">JV Info</h6>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">JV Area (Ha.)</h6>   
                                                         <input type="hidden" value="JvArea">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">(NFA - JV)Area (Ha.)</h6>   
                                                         <input type="hidden" value="DiffNfaJv">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">(NFA - JV)Area % Difference</h6>   
                                                         <input type="hidden" value="DiffNfaJvPerc">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Date of JV Clearance</h6>   
                                                         <input type="hidden" value="DtJvClr">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Category</h6>   
                                                         <input type="hidden" value="JvCatg">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Existing Pillar</h6>   
                                                         <input type="hidden" value="JvExPillar">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                      
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Total Pillar</h6>   
                                                         <input type="hidden" value="TotalPillar">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Total Perimeter</h6>   
                                                         <input type="hidden" value="JvPerimtr">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <h6 class="pt-3 pl-3 pr-3">DGPS Info</h6>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">DGPS Survey Area (Ha.)</h6>   
                                                         <input type="hidden" value="DgpsArea">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
									<!-- <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">DFO Certification Date</h6>   
                                                         <input type="hidden" value="DfoCertDt">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> -->
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">FSO Certification Date</h6>   
                                                         <input type="hidden" value="FsoCertDt">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">FSO Certified Area (Ha.)</h6>   
                                                         <input type="hidden" value="FsocertArea">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">New Pillar</h6>   
                                                         <input type="hidden" value="DgpsNwPillar">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">NFA - DGPS</h6>   
                                                         <input type="hidden" value="DiffDgpsNfa">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">DGPS - JVA</h6>   
                                                         <input type="hidden" value="DiffDgpsJv">                                                      
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> -->

                                    </div>
                                </div>

                                <div class="col-sm-6">
                                
                                	<div class="widget">
                                		<div class="widget-header">
                                			<h4>Result</h4>
                                		</div>
                                	</div>
                                
                                    <div id='right-defaults' class='dragula widget-header'>
                                    
                                        <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="" >
                                                        <h6 class="fields" id="resFbName">NFB Name</h6>  
                                                         <input type="hidden" value="NfbName">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
										<div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Notified forest Area (Ha.)</h6>     
                                                        <input type="hidden" value="NFA">                                                    
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                         <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="">Notification No. & Date</h6>  
                                                        <input type="hidden" value="NotifnNoDt">                                                        
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                       

                                        <!-- <div class="media  d-md-flex d-block text-sm-left text-center">                                            
                                            <div class="media-body">
                                                <div class="d-xl-flex d-block justify-content-between">
                                                    <div class="">
                                                        <h6 class="fields">GRFL Area Certified by FSO(Ha.)</h6>   
                                                        <input type="hidden" value="FsoCertifiedArea">                                                       
                                                    </div>
                                                    <div>
                                                        <button class="btn btn-info btn-sm"><i class="fa fa-arrows-alt">&nbsp;</i>Drag</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> -->

                                        
                                    </div>
                                </div>
						
							</div>
							<hr>
							<div class="row">
								<div class="col-md-12 text-center mb-2">
								
									<button type="button" class="btn btn-success" onclick="openmodal();"><i class="fa fa-file-o">&nbsp;</i>Generate Report</button>
									<!-- <button type="button" class="btn btn-success" onclick="viewReport_click();"><i class="fa fa-file-o">&nbsp;</i>View Report</button> -->
								</div>
							</div>
						</div>
					
						
					</div>
				</div>
			</div>
		</div>
	
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Enter a report title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <input class="form-control text-box single-line" data-val="true"
								id="input_id_pdf" name="user_manage_info.dept_id"
								placeholder="" required="required" />
	    <span class="form_error" id="title_Id" style="color:red;font-size: 11px;">Please enter the title</span> 
	    <span class="form_error" id="lblName" style="color:red;font-size: 11px;"></span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="generateReport_click()">Generate</button>
      </div>
    </div>
  </div>
</div>

<%@ include file="../shared/footer.jsp"%>
   
<script type="text/javascript">
$(document).ready(function(){
	 $(".header-title-lg").text("ODISHA FLI-DSS (NFB Custom Reports)");
	
});

</script>

<script>
/* On change of Division */
function divListChange(e) {
    
   divisionWiseRange(e);
   
}
function rngListChange(e){
	//alert($('#drpDivision').val());
	rangeWiseNfb($('#drpDivision').val(),e.value)
}

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
                $('#drpRngList').append($("<option></option>").attr("value", "").text("--All--"));
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


function rangeWiseNfb(divid,rid){
	 if (rid != '') {
	        $.ajax({
	            url: '/Utility/getRangeWiseFB',
	            data: {
	                'divid': divid,
	                'rid' : rid
	            },
	            type: "GET",
	            contentType: "application/json;charset=utf-8",
	            dataType: "json",
	            success: function(data) {
	                $('#drpNfbList').html('');
	                var options = '';
	                $('#drpNfbList').append($("<option></option>").attr("value", "").text("--All--"));
	                $.each(data, function(a, b) {
	                    options += '<option value="' + b.value + '">' + b.strValue + '</option>';

	                });
	                $('#drpNfbList').append(options);

	            },
	            error: function(errormessage) {
	                alert(errormessage.responseText);
	            }
	        });
	    }
	}

</script>

<script type="text/javascript">
	   function openmodal()
	   {
		  $('#exampleModalCenter').modal('show');
	    }
	var isGenReport=true;
	function generateReport_click() 
	{
		//$('#exampleModalCenter').modal('show');
		var res=0;
		$(".apploader-base").css("display", "block");
		
		var selectedFields=new Array();
		//for adding slno in pdf
		selectedFields.push("Sl. No.");
		var x = document.getElementById("right-defaults").querySelectorAll("h6"); 
		var fields = document.getElementById("right-defaults").querySelectorAll("input[type=hidden]"); 
		for(var i=0; i<fields.length;i++){
			//alert(fields[i].value);
			selectedFields.push(fields[i].value);
			//alert(fields[i].value);
		}
		
		div_id = ($("#drpDivision").val() == null || $("#drpDivision").val() == "") ? 0 : $("#drpDivision").val();
        range_code = ($("#drpRngList").val() == null || $("#drpRngList").val() == "") ? "" : $("#drpRngList").val();
        nfbid = ($("#drpNfbList").val() == null || $("#drpNfbList").val() == "") ? "" : $("#drpNfbList").val();
        var reportTitle = $('#input_id_pdf').val();
        $('.form_error').hide();
        if(reportTitle == '')
        {       	        	
        	document.getElementById("input_id_pdf").focus();
        	$('#title_Id').show();
        	//$("#title_Id").html("please enter a title");
        	$(".apploader-base").css("display", "none");
        }else{
		 $.ajax({
			 	async:false,
	            url: '/Reports/getForestLandDataNfbCustom',
	            data: {
	                'divId': div_id,
	                'rngCode': range_code,
	                'nfbid':nfbid,
	                'fields':selectedFields,
	                'reportTitle':reportTitle
	            },
	            contentType: 'application/html; charset=utf-8',
	            type: 'GET',
	            dataType: 'html',
	            success: function(result) 
	            {	
	            	$('#exampleModalCenter').modal('hide');
	            	res=1;
	            	$(".apploader-base").css("display", "none");
	            	costumeNotification("PDF report has been successfully generated.");
	        		if(isGenReport){
	        			var v="/Reports/filedownNfbCustom/"+'${userID}'+"NFBCustomReport.pdf";
	        			window.open(v);        			
	            	}           	
	            },
	            error: function(errormessage) {
	            	$(".apploader-base").css("display", "none");
	            	costumeNotification("Unable to generate PDF report! Please try again!");
	            }
	            
	        });
		 $('.form_error').hide();
	    }
		return res;
	}
	
	//Validate Only Alphabet for title input
	$(function() {
		$("#input_id_pdf").keypress(function(e) {
			var keyCode = e.keyCode || e.which;
			$("#lblName").html("");
			//var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
			var regex = /^[A-Za-z,. ]+$/;
			var isValid = regex.test(String.fromCharCode(keyCode));
			if (!isValid) {
				$("#lblName").html("Only Alphabets allowed.");
				$('#title_Id').hide();
			} else
				$('#title_Id').hide();
			return isValid;
		});
		$('.form_error').hide();
	});
	
</script>



  