package com.sparc.flidss.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.persistence.Convert;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itextpdf.text.BadElementException;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.sparc.flidss.model.common.DistrictMaster;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.RangeMaster;
import com.sparc.flidss.model.common.TehsilMaster;
import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;
import com.sparc.flidss.service.ProgressMonitoringService;
import com.sparc.flidss.service.RecordedForestCaLandService;
import com.sparc.flidss.service.UtilityMasterService;
import com.sparc.flidss.utility.ItextHeaderFooterPageEvent;
import com.sparc.flidss.viewmodel.IRecordedForestCaLand;
import com.sparc.flidss.viewmodel.progressmonitoring.DRFLsummary;
import com.sparc.flidss.viewmodel.progressmonitoring.UvwNfbSummary;

@Controller
@RequestMapping("/Reports")
public class ReportsController {

	@Autowired
	UtilityMasterService service;
	@Autowired
	RecordedForestCaLandService rfCaLand;
	@Autowired
	ProgressMonitoringService pms;
	@Autowired
	DistrictDivisionLinkMasterRepository distDivLinkRepo;

	/**
	 * For CA Land Data only
	 * 
	 * @param model
	 * @return
	 */
	@Async
	@RequestMapping("/CALandDetails")
	public String villageWiseDetails(Model model) {

		List<IRecordedForestCaLand> recodedForestCaLandMaster = rfCaLand.getRecodedForestCaLandMaster();
		List<IRecordedForestCaLand> recodedForestCaLandDetails = rfCaLand.getRecodedForestCaLandDetails();

		model.addAttribute("caLandMaster", recodedForestCaLandMaster);
		model.addAttribute("caLandDetails", recodedForestCaLandDetails);
		return "reports/villagedetails";
	}

	@Async
	@RequestMapping("/forestCoverDetails")
	public String forestCoverDetails(Model model) {
		try {
			List<DivisionMaster> divList = service.GetDivisionList();
			List<RangeMaster> rngList = service.GetRangeList();
			model.addAttribute("divList", divList.stream().filter(f -> f.getIntId() > 0).collect(Collectors.toList()));
			model.addAttribute("rngList", rngList);

		} catch (Exception ex) {
			throw ex;
		}
		return "reports/forestcoverdetails";
	}

	@Async
	@RequestMapping("/flNotificationStatus")
	public String forestLandNotificatinStatus(Model model, HttpSession session) {

		try {

			List<Integer> divids = getDivIdsbyDistOrDiv(session);

			// List<DistrictMaster> distList = service.GetDistrictList();
			List<DivisionMaster> divList = service.GetDivisionList().stream()
					.filter(f -> f.getIntId() > 0 && (!divids.isEmpty() ? divids.contains(f.getIntId()) : true))
					.collect(Collectors.toList());
			;
			List<RangeMaster> rngList = service.GetRangeList();
			// List<TehsilMaster> tehsList = service.GetTehsilList();

			// model.addAttribute("distList", distList);
			model.addAttribute("divList", divList.stream().filter(f -> f.getIntId() > 0).collect(Collectors.toList()));
			// model.addAttribute("rngList", rngList);
			// model.addAttribute("tehsList", tehsList);

			// model.addAttribute("customFieldsNfb", utility.getCustomQueryFieldsNFB());

		} catch (Exception ex) {
			throw ex;
		}

		return "reports/flNotificationStatus";
	}

	@Async
	@RequestMapping("/NotificationReports")
	public String NoticationReportsDetails(Model model) {
		try {
			List<DivisionMaster> divList = service.GetDivisionList();
			List<RangeMaster> rngList = service.GetRangeList();
			model.addAttribute("divList", divList.stream().filter(f -> f.getIntId() > 0).collect(Collectors.toList()));
			model.addAttribute("rngList", rngList);

		} catch (Exception ex) {
			throw ex;
		}
		return "reports/NotificationReports";
	}

	@RequestMapping("/getForestLandData")
	@ResponseBody
	public String getForestLandData(HttpServletRequest request, @RequestParam(name = "fields[]") String fields[],
			@RequestParam(required = false) Integer divId, @RequestParam(required = false) String rngCode,
			@RequestParam(required = false) Integer nfbid) {
		String res = "0";
		List<UvwNfbSummary> nfbDetails;
		try {
			divId = divId != null && divId > 0 ? divId : null;
			rngCode = rngCode != null && !rngCode.isEmpty() && !rngCode.equals("0") ? rngCode : null;
			nfbid = nfbid != null && nfbid > 0 ? nfbid : null;
			nfbDetails = pms.getNfbSummary(" and int_fk_division=" + (divId != null ? divId : "int_fk_division")
					+ " and chrv_fk_range_cd=" + (rngCode != null ? "'" + rngCode + "'" : "chrv_fk_range_cd")
					+ " and int_id=" + (nfbid != null ? nfbid : "int_id") + "  ");
			// model.addAttribute("nfbList", nfbDetails);
			if (generatePdf(nfbDetails, fields, request, divId, rngCode).equals("1")) {
				res = "1";
			}
		} catch (Exception ex) {
			throw ex;
		}
		return res;// "reports/flNotificationStatus";
	}

	@RequestMapping("/partialPdfFlNotificationStatus")
	public String partialPdfFlNotificationStatus() {
		return "reports/partialPdfFlNotificationStatus";
	}

	public String generatePdf(List<UvwNfbSummary> nfbDetails, String fields[], HttpServletRequest request,
			Integer divId, String rngCode) {
		String res = "0";
		try {
			UvwNfbSummary firstRow = nfbDetails.stream().findFirst().orElse(null);
			Object userId = request.getSession().getAttribute("userID");
			String fileName = (userId != null ? userId.toString() : "") + "ForestLandNotification.pdf";
			//String dataDirectory = "C:/tmp/";
			String dataDirectory = "/var/upload/";
			File file = new File(dataDirectory + fileName);
			if (file.exists()) {
				file.delete();
			}

			Document document = new Document(PageSize.A4, 10.0F, 10.0F, 30.0F, 30.0F);
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(dataDirectory + fileName));

			/**
			 * To Add Header & Footer
			 */
			Rectangle rect = new Rectangle(30, 30, 546, 800);
			writer.setBoxSize("rect", rect);
			ItextHeaderFooterPageEvent event = new ItextHeaderFooterPageEvent();
			writer.setPageEvent(event);

			/** End of Add Header & Footer **/
			if (userId != null) {
				document.addAuthor(userId.toString());
			}
			document.addCreationDate();
			document.addHeader("Header", "Forest Land Notification Status");
			document.addSubject("Forest Land Notification Status");
			document.addTitle("Forest Land Notification Status");
			document.open();

			/**
			 * Add Report Title
			 */
			Font fontHeader = new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD);
			PdfPTable ReportTitletable = new PdfPTable(new float[] { fields.length });// Create columns in PDF table.
			// headertable.setWidthPercentage(100f);
			PdfPCell cell = new PdfPCell(new Phrase("Forest Land Notification Status", fontHeader));// Create cells
																									// table
			cell.setBorder(0);
			cell.setColspan(fields.length);
			// cell.setRowspan(2);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setPaddingBottom(4);
			ReportTitletable.addCell(cell);// Add cells in table

			/* adding Division and Range below Report_title */
			if (divId != null) {
				Font fontHeader2 = new Font(FontFamily.TIMES_ROMAN, 10, Font.NORMAL);
				PdfPCell cell2 = new PdfPCell(
						new Phrase(
								(divId != null ? firstRow.getChrvDivisionNm() + " Division" : "All Division")
										+ (rngCode != null ? ", " + firstRow.getChrvRangeNm() + " Range" : ""),
								fontHeader2));
				cell2.setBorder(0);
				cell2.setColspan(fields.length);
				cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell2.setPaddingBottom(4);
				ReportTitletable.addCell(cell2);
			}
			document.add(ReportTitletable);
			/**
			 * End of Report Title
			 **/

			PdfPTable table = new PdfPTable(fields.length);
			table.setWidthPercentage(100);
			addTableHeader(table, fields);
			// addRows(table);
			addCustomRows(table, fields, nfbDetails);

			document.add(table);// Add table in document
			document.close();

			writer.close();

			res = "1";
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (BadElementException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	private void addTableHeader(PdfPTable table, String fields[]) {

		Font fontH1 = new Font(FontFamily.TIMES_ROMAN, 10, Font.NORMAL);
		Stream.of(fields).forEach(columnTitle -> {
			PdfPCell header = new PdfPCell();
			header.setBackgroundColor(BaseColor.LIGHT_GRAY);
			header.setBorderWidth(0.5f);

			switch (columnTitle) {
			case "Sl. No.":
				header.setPhrase(new Phrase("Sl. No.", fontH1));
				break;
			case "NfbName":
				header.setPhrase(new Phrase("NFB Name", fontH1));
				break;
			case "GRReNotifnNoDt":
				header.setPhrase(new Phrase("ReNotification of GR Boundary No. & Date", fontH1));
				break;
			case "NFA":
				header.setPhrase(new Phrase("Notified forest Area(Ha.)", fontH1));
				break;
			case "NotifnNoDt":
				header.setPhrase(new Phrase("Notification No. & Date", fontH1));
				break;
			case "NoofBounPoint":
				header.setPhrase(new Phrase("No.of Boundary Point", fontH1));
				break;
			case "FsoCertifiedArea":
				header.setPhrase(new Phrase("GRFL Area Certified by FSO(Ha.)", fontH1));
				break;
			case "Type":
				header.setPhrase(new Phrase("Type", fontH1));
				break;

			}

			/*
			 * header.setPhrase(new Phrase(columnTitle.replace("NfbName", "NFB Name")
			 * .replace("GRReNotifnNoDt",
			 * "ReNotification of GR Boundary No. & Date").replace("NFA", "NFA(Ha.)")
			 * .replace("NotifnNoDt", "Notification No. & Date").replace("NoofBounPoint",
			 * "No.of Boundary Point") .replace("FsoCertifiedArea",
			 * "GRFL Area Certified by FSO(Ha.)"), fontH1));
			 */

			table.addCell(header);
		});
	}

	/*
	 * private void addRows(PdfPTable table) { table.addCell("row 1, col 1");
	 * table.addCell("row 1, col 2"); table.addCell("row 1, col 3"); }
	 */

	private void addCustomRows(PdfPTable table, String fields[], List<UvwNfbSummary> nfbDetails)
			throws URISyntaxException, BadElementException, IOException {

		Font fontRow = new Font(FontFamily.TIMES_ROMAN, 9, Font.NORMAL);	
		Integer j=0;
		for(UvwNfbSummary nfb:nfbDetails) {
			j++;//for serial no auto increment			
			for (Integer i = 0; i < fields.length; i++) {
				
				if (fields[i].equals("NfbName")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase(nfb.getNfbName(), fontRow));
					table.addCell(default1Cell);
				} else if (fields[i].equals("GRReNotifnNoDt")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase(
							nfb.getRenotificationPropDt() != null ? nfb.getRenotificationPropDt().toString() : "N/A",
							fontRow));
					table.addCell(default1Cell);
				} else if (fields[i].equals("FsoCertifiedArea")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getDgpsfHa() != null ? nfb.getDgpsfHa().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("Type")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getNfbType() != null ? nfb.getNfbType() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("NFA")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getNareaHa() != null ? nfb.getNareaHa().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("NotifnNoDt")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(nfb.getNotfNo() != null
							? nfb.getNotfNo() + " " + (nfb.getNotfDt() != null ? nfb.getNotfDt() : "")
							: "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("NoofBounPoint")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getDgpsNoOfSurveypoint() != null ? nfb.getDgpsNoOfSurveypoint().toString() : "N/A",
							fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("Range")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getChrvRangeNm() != null ? nfb.getChrvRangeNm() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("Division")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getChrvDivisionNm() != null ? nfb.getChrvDivisionNm() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				}else if (fields[i].equals("Sl. No.")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(Integer.toString(j)));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				}
			}
		}
		
		/**
		 * add additional fields here,		
		 * for total calculation in PDF table
		 */
		
		for (Integer i = 0; i < fields.length; i++) {
			if (fields[i].equals("FsoCertifiedArea")) {
				PdfPCell totalCell = new PdfPCell(new Phrase("Total: "+nfbDetails.stream().mapToDouble(f->f.getDgpsfHa()).sum(), fontRow));
				totalCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(totalCell);
			} else if (fields[i].equals("NoofBounPoint")) {
				PdfPCell totalCell2 = new PdfPCell(new Phrase("Total:"+nfbDetails.stream().mapToInt(f->f.getDgpsNoOfSurveypoint()).sum(), fontRow));
				totalCell2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(totalCell2);
			} else if (fields[i].equals("NFA")) {
				PdfPCell totalCell3 = new PdfPCell(new Phrase("Total:"+nfbDetails.stream().mapToDouble(f->f.getNareaHa()).sum(), fontRow));
				totalCell3.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(totalCell3);
			} else if (fields[i].equals("NfbName")) {
				PdfPCell totalCell = new PdfPCell(new Phrase("N/A", fontRow));
				totalCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(totalCell);
			} else if (fields[i].equals("Type")) {
				PdfPCell totalCell3 = new PdfPCell(new Phrase("N/A", fontRow));
				totalCell3.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(totalCell3);
			} else if (fields[i].equals("GRReNotifnNoDt")) {
				PdfPCell totalCell6 = new PdfPCell(new Phrase("N/A", fontRow));
				totalCell6.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(totalCell6);
			} else if (fields[i].equals("NotifnNoDt")) {
				PdfPCell totalCell7 = new PdfPCell(new Phrase("N/A", fontRow));
				totalCell7.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(totalCell7);
			}
		}

	}

	@RequestMapping("/filedown/{fileName:.+}")
	private void downloadFlNotification(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("fileName") String fileName) {
		downloadFile(request, response, fileName);
	}

	private void downloadFile(HttpServletRequest request, HttpServletResponse response, String fileName) {
		//String dataDirectory = "C:/tmp/";
		String dataDirectory = "/var/upload/";
		Path file = Paths.get(dataDirectory, fileName);
		if (Files.exists(file)) {
			response.setContentType("application/pdf");
			response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
			try {
				Files.copy(file, response.getOutputStream());
				response.getOutputStream().flush();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}

	@Async
	@RequestMapping("/forestlandsummary")
	public String forestLandSummary(Model model,HttpSession session) {
		//List<DivisionMaster> divList = service.GetDivisionList();
		List<Integer> divids = getDivIdsbyDistOrDiv(session);
		List<RangeMaster> rngList = service.GetRangeList();
		List<DivisionMaster> divList = service.GetDivisionList().stream()
				.filter(f -> f.getIntId() > 0 && (!divids.isEmpty() ? divids.contains(f.getIntId()) : true))
				.collect(Collectors.toList());
		model.addAttribute("divList", divList.stream().filter(f -> f.getIntId() > 0).collect(Collectors.toList()));
		model.addAttribute("rngList", rngList);
		return "reports/forestlandsummary";
	}
	

	@Async
	@RequestMapping("/DLC&RevenueReports")
	public String dlcRevenueReports(Model model) {
		List<DistrictMaster> distList = service.GetDistrictList();
		List<TehsilMaster> TehList = service.GetTehsilList();
//			List<RangeMaster> rngList = service.GetRangeList();
		model.addAttribute("distList", distList.stream().filter(d -> d.getIntId() > 0).collect(Collectors.toList()));
		model.addAttribute("TehList", TehList.stream().filter(t -> t.getIntId() > 0).collect(Collectors.toList()));
//			model.addAttribute("distList", distList.stream().filter(f->f.getIntId()>0).collect(Collectors.toList()));
//			model.addAttribute("rngList", rngList);
		return "reports/DLC&RevenueReports";
	}

	/*
	 * @RequestMapping("/getForestLandSummary") public @ResponseBody String
	 * getForestLandSummary(HttpServletRequest request,@RequestParam(name =
	 * "fields[]") String fields[],@RequestParam(required = false) Integer
	 * divId,@RequestParam(required = false) String rngCode,@RequestParam(required =
	 * false) Integer nfbid) { List<UvwNfbSummary> nfbDetails; try {
	 * divId=divId!=null && divId>0?divId:null; rngCode=rngCode!=null &&
	 * !rngCode.isEmpty()?rngCode:null; nfbid=nfbid!=null && nfbid>0?nfbid:null;
	 * nfbDetails = pms.getNfbSummary(" and int_fk_division="+(divId!=null?divId:
	 * "int_fk_division")+" and chrv_fk_range_cd="+(rngCode!=null?"'"+rngCode+"'":
	 * "chrv_fk_range_cd")+" and int_id="+(nfbid!=null?nfbid:"int_id")+"  ");
	 * //model.addAttribute("nfbList", nfbDetails);
	 * 
	 * 
	 * generatePdf(nfbDetails,fields,request); } catch (Exception ex) { throw ex; }
	 * return "1";//"reports/flNotificationStatus"; }
	 */

	@RequestMapping("/maptest")
	private String mapviewTest() {
		return "/reports/mapViewTest";
	}

	public List<Integer> getDivIdsbyDistOrDiv(HttpSession session) {

		Integer distId = session.getAttribute("distID") != null
				? Integer.parseInt(session.getAttribute("distID").toString())
				: 0;
		Integer divId = session.getAttribute("divID") != null
				? Integer.parseInt(session.getAttribute("divID").toString())
				: 0;
		List<Integer> dividsByDist = new ArrayList<Integer>();

		if (distId != null && Integer.parseInt(distId.toString()) > 0) {
			dividsByDist = distDivLinkRepo.findByDistId(distId).stream().map(m -> m.getDivisionMaster().getIntId())
					.collect(Collectors.toList());
		} else {
			if (divId > 0) {
				dividsByDist.add(divId);
			}
		}

		return dividsByDist;
	}
		
}
