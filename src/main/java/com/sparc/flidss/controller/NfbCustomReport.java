package com.sparc.flidss.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFileAttributes;
import java.nio.file.attribute.PosixFilePermission;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.sparc.flidss.model.common.DivisionMaster;
import com.sparc.flidss.model.common.RangeMaster;
import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;
import com.sparc.flidss.service.ProgressMonitoringService;
import com.sparc.flidss.service.RecordedForestCaLandService;
import com.sparc.flidss.service.UtilityMasterService;
import com.sparc.flidss.utility.ItextHeaderFooterPageEvent;
import com.sparc.flidss.viewmodel.progressmonitoring.UvwNfbSummary;

@Controller
@RequestMapping("/Reports")
public class NfbCustomReport {
	@Autowired
	UtilityMasterService service;

	@Autowired
	RecordedForestCaLandService rfCaLand;

	@Autowired
	ProgressMonitoringService pms;
	
	@Autowired
	DistrictDivisionLinkMasterRepository distDivLinkRepo;

	@Async
	@RequestMapping("/nfbCustomReport")
	public String nfbCustomReport(Model model,HttpSession session) {

		try {
			//List<DivisionMaster> divList = service.GetDivisionList();
			List<Integer> divids = getDivIdsbyDistOrDiv(session);
			List<DivisionMaster> divList = service.GetDivisionList().stream()
					.filter(f -> f.getIntId() > 0 && (!divids.isEmpty() ? divids.contains(f.getIntId()) : true))
					.collect(Collectors.toList());
			divList.sort((x,y)->x.getChrvDivisionNm().compareTo(y.getChrvDivisionNm()));
			//divList.stream().sorted(Comparator.comparing(DivisionMaster::getChrvDivisionNm));
			List<RangeMaster> rngList = service.GetRangeList();
			//model.addAttribute("divList", divList.stream().filter(f -> f.getIntId() > 0).collect(Collectors.toList()));
			model.addAttribute("divList", divList);
			model.addAttribute("rngList", rngList);

		} catch (Exception ex) {
			throw ex;
		}
		return "/reports/nfbCustomReport";
	}
	
	@RequestMapping("/getForestLandDataNfbCustom")
	@ResponseBody
	public String getForestLandData(HttpServletRequest request, @RequestParam(name = "fields[]") String fields[],
			@RequestParam(required = false) Integer divId, @RequestParam(required = false) String rngCode,
			@RequestParam(required = false) Integer nfbid, @RequestParam(required = false) String reportTitle) {
		String res = "0";
		List<UvwNfbSummary> nfbDetails;
		try {
			divId = divId != null && divId > 0 ? divId : null;
			rngCode = rngCode != null && !rngCode.isEmpty() && !rngCode.equals("0") ? rngCode : null;
			nfbid = nfbid != null && nfbid > 0 ? nfbid : null;
			nfbDetails = pms.getNfbSummary(" and int_fk_division=" + (divId != null ? divId : "int_fk_division")
					+ " and chrv_fk_range_cd=" + (rngCode != null ? "'" + rngCode + "'" : "chrv_fk_range_cd")
					+ " and int_id=" + (nfbid != null ? nfbid : "int_id") + "  ");
			if (generatePdf(nfbDetails, fields, request, divId, rngCode, reportTitle).equals("1")) {
				res = "1";
			}
		} catch (Exception ex) {
			throw ex;
		}
		return res;// "reports/flNotificationStatus";
	}

	public String generatePdf(List<UvwNfbSummary> nfbDetails, String fields[], HttpServletRequest request,
			Integer divId, String rngCode, String reportTitle) {
		String res = "0";
		try {
			UvwNfbSummary firstRow = nfbDetails.stream().findFirst().orElse(null);

			Object attribute = request.getSession().getAttribute("userID");

			String fileName = (attribute != null ? attribute.toString() : "") + "NFBCustomReport.pdf";
			// String fileName=(attribute!=null?attribute.toString():"")+reportTitle+".pdf";
			// String dataDirectory =
			// request.getServletContext().getRealPath("/reports/downloads/");
			//String dataDirectory = "C:/tmp/";
			String dataDirectory = "/var/upload/";
			//String dataDirectory = "C:/upload/";
			// Path path = Paths.get(dataDirectory, fileName);
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

			if (attribute != null) {
				document.addAuthor(attribute.toString());
			}
			document.addCreationDate();
			document.addHeader("Header", "Forest Land Notification Status");
			document.addSubject("Forest Land Notification Status");
			document.addTitle("Forest Land Notification Status");
			document.open();

			/*
			 * fontHeader.setStyle("align-center"); Paragraph parg=new
			 * Paragraph("Forest Land Notification Status"); document.add(parg);
			 */

			/**
			 * Add Report Title
			 */
			Font fontHeader = new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD);
			PdfPTable ReportTitletable = new PdfPTable(new float[] { fields.length });
			// headertable.setWidthPercentage(100f);
			PdfPCell cell = new PdfPCell(new Phrase(reportTitle, fontHeader));
			cell.setBorder(0);
			cell.setColspan(fields.length);
			// cell.setRowspan(2);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setPaddingBottom(4);
			ReportTitletable.addCell(cell);

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
				cell2.setPaddingBottom(3);
				ReportTitletable.addCell(cell2);
			}

			document.add(ReportTitletable);
			/** End of Report Title **/

			PdfPTable table = new PdfPTable(fields.length);
			table.setWidthPercentage(100);
			addTableHeader(table, fields);
			// addRows(table);
			addCustomRows(table, fields, nfbDetails);

			document.add(table);
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
			case "Division":
				header.setPhrase(new Phrase("Division", fontH1));
				break;
			case "Range":
				header.setPhrase(new Phrase("Range", fontH1));
				break;
			case "Type":
				header.setPhrase(new Phrase("Type", fontH1));
				break;
			case "GRReNotifnNoDt":
				header.setPhrase(new Phrase("ReNotification of GR Boundary No. & Date", fontH1));
				break;
			case "NoofBounPoint":
				header.setPhrase(new Phrase("No. of Boundary Point", fontH1));
				break;
			case "WpYear":
				header.setPhrase(new Phrase("WP Year", fontH1));
				break;
			case "WpArea":
				header.setPhrase(new Phrase("WP Area (Ha.)", fontH1));
				break;
			case "MmvArea":
				header.setPhrase(new Phrase("MMV Area (Ha.)", fontH1));
				break;
			case "DiffNfMmv":
				header.setPhrase(new Phrase("Notified Forest Area - MMVA (Ha.)", fontH1));
				break;
			case "DiffNfMmvPerc":
				header.setPhrase(new Phrase("(Notified Forest Area - MMVA) % Diff.", fontH1));
				break;
			case "CmvArea":
				header.setPhrase(new Phrase("CMV Area (Ha.).", fontH1));
				break;
			case "DiffCmvNfa":
				header.setPhrase(new Phrase("CMV - NFA (Ha.)", fontH1));
				break;
			case "DiffCmvNfaPerc":
				header.setPhrase(new Phrase("(CMV - NFA) % Diff.", fontH1));
				break;
			case "JvArea":
				header.setPhrase(new Phrase("JV Area (Ha.)", fontH1));
				break;
			case "DiffNfaJv":
				header.setPhrase(new Phrase("(Notified Forest Area - JVA) (Ha.)", fontH1));
				break;
			case "DiffNfaJvPerc":
				header.setPhrase(new Phrase("(Notified Forest Area - JVA) % Diff.", fontH1));
				break;
			case "DtJvClr":
				header.setPhrase(new Phrase("Date of JV Clearance", fontH1));
				break;
			case "JvCatg":
				header.setPhrase(new Phrase("Category", fontH1));
				break;
			case "JvExPillar":
				header.setPhrase(new Phrase("Existing Pillar", fontH1));
				break;
			case "TotalPillar":
				header.setPhrase(new Phrase("Total Pillar", fontH1));
				break;
			case "JvPerimtr":
				header.setPhrase(new Phrase("Total Perimeter", fontH1));
				break;
			case "DgpsArea":
				header.setPhrase(new Phrase("DGPS Survey Area (Ha.)", fontH1));
				break;
			case "DfoCertDt":
				header.setPhrase(new Phrase("DFO Certification Date", fontH1));
				break;
			case "FsoCertDt":
				header.setPhrase(new Phrase("FSO Certification Date", fontH1));
				break;
			case "FsocertArea":
				header.setPhrase(new Phrase("FSO Certified Area (Ha.)", fontH1));
				break;
			case "DgpsNwPillar":
				header.setPhrase(new Phrase("New Pillar", fontH1));
				break;
			case "DiffDgpsNfa":
				header.setPhrase(new Phrase("NDGPS - NFA (Ha.)", fontH1));
				break;
			case "DiffDgpsJv":
				header.setPhrase(new Phrase("DGPS - JVA (Ha.)", fontH1));
				break;
			case "NfbName":
				header.setPhrase(new Phrase("NFB Name", fontH1));
				break;
			case "NFA":
				header.setPhrase(new Phrase("Notified Forest Area (Ha.)", fontH1));
				break;
			case "NotifnNoDt":
				header.setPhrase(new Phrase("Notification No. & Date", fontH1));
				break;
			case "FsoCertifiedArea":
				header.setPhrase(new Phrase("GRFL Area Certified by FSO(Ha.)", fontH1));
				break;
			}

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
		//nfbDetails.forEach(nfb -> {
		Integer j = 0;
		for (UvwNfbSummary nfb : nfbDetails) {
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
				}
				/* Notification Info */

				else if (fields[i].equals("Type")) {
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
				}
				/* WP Info */

				else if (fields[i].equals("WpYear")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getWpYear() != null ? nfb.getWpYear().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("WpArea")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getWpArea() != null ? nfb.getWpArea().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("MmvArea")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getMmvHa() != null ? nfb.getMmvHa().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DiffNfMmv")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getNareaHa() != null && nfb.getMmvHa() != null
									? (nfb.getNareaHa() - nfb.getMmvHa()) + ""
									: "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DiffNfMmvPerc")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getNareaHa() != null && nfb.getMmvHa() != null
									? (nfb.getMmvHa() / nfb.getNareaHa()) * 100 + ""
									: "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				}
				/* CMV Area */

				else if (fields[i].equals("CmvArea")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getCmvHa() != null ? nfb.getCmvHa().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DiffCmvNfa")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getCmvHa() != null && nfb.getNareaHa() != null
									? (nfb.getNareaHa() - nfb.getCmvHa()) + ""
									: "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DiffCmvNfaPerc")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getCmvHa() != null && nfb.getNareaHa() != null
									? (nfb.getNareaHa() / nfb.getCmvHa()) * 100 + ""
									: "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				}
				/* JV Area */

				else if (fields[i].equals("JvArea")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getJvHa() != null ? nfb.getJvHa().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DiffNfaJv")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getNareaHa() != null && nfb.getJvHa() != null ? (nfb.getNareaHa() - nfb.getJvHa()) + ""
									: "N/A",
							fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DiffNfaJvPerc")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getNareaHa() != null && nfb.getJvHa() != null
									? (nfb.getJvHa() / nfb.getNareaHa()) * 100 + ""
									: "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DtJvClr")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getJvEdate() != null ? nfb.getJvEdate().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("JvCatg")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getJvCatg() != null ? nfb.getJvCatg().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("JvExPillar")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getJvExistingPnts() != null ? nfb.getJvExistingPnts().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("TotalPillar")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getJvExistingPnts() != null && nfb.getDgpsNoOfNewpillarpoint() != null
									? (nfb.getJvExistingPnts() + nfb.getDgpsNoOfNewpillarpoint()) + ""
									: "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("JvPerimtr")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getJvPerimeter() != null ? nfb.getJvPerimeter().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				}

				/* DGPS Info */

				else if (fields[i].equals("DgpsArea")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getDgpsdHa() != null ? nfb.getDgpsdHa().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DfoCertDt")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getDfoCertificationDt() != null ? nfb.getDfoCertificationDt().toString() : "N/A",
							fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("FsoCertDt")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getFsoCertificationDt() != null ? nfb.getFsoCertificationDt().toString() : "N/A",
							fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("FsocertArea")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getDgpsfHa() != null ? nfb.getDgpsfHa().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DgpsNwPillar")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getDgpsNoOfNewpillarpoint() != null ? nfb.getDgpsNoOfNewpillarpoint().toString()
									: "N/A",
							fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DiffDgpsNfa")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getDgpsdHa() != null && nfb.getNareaHa() != null
									? (nfb.getNareaHa() - nfb.getDgpsdHa()) + ""
									: "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("DiffDgpsJv")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getDgpsdHa() != null && nfb.getJvHa() != null ? (nfb.getDgpsdHa() - nfb.getJvHa()) + ""
									: "N/A",
							fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				} else if (fields[i].equals("Sl. No.")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(Integer.toString(j)));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				}

			}

		}
		for (Integer i = 0; i < fields.length; i++) {
			if (fields[i].equals("NfbName")) {
				PdfPCell totalCell1 = new PdfPCell(new Phrase(" ", fontRow));
				totalCell1.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(totalCell1);
			} else if (fields[i].equals("GRReNotifnNoDt")) {
				PdfPCell totalCell2 = new PdfPCell(new Phrase(" ", fontRow));
				totalCell2.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(totalCell2);
			} else if (fields[i].equals("FsoCertifiedArea")) {
				PdfPCell totalCell3 = new PdfPCell(new Phrase(" ", fontRow));
				totalCell3.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(totalCell3);
			}
			/* Notification Info */
			else if (fields[i].equals("Type")) {
				PdfPCell horizontalAlignCell4 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell4.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(horizontalAlignCell4);
			} else if (fields[i].equals("NFA")) {
				PdfPCell horizontalAlignCell5 = new PdfPCell(
						new Phrase("total:" + nfbDetails.stream().mapToDouble(f -> f.getNareaHa()).sum(), fontRow));
				horizontalAlignCell5.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell5);
			} else if (fields[i].equals("NotifnNoDt")) {
				PdfPCell horizontalAlignCell6 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell6.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(horizontalAlignCell6);
			} else if (fields[i].equals("NoofBounPoint")) {
				PdfPCell horizontalAlignCell7 = new PdfPCell(new Phrase(
						"total:" + nfbDetails.stream().mapToInt(f -> f.getDgpsNoOfSurveypoint()).sum(), fontRow));
				horizontalAlignCell7.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell7);
			} else if (fields[i].equals("Range")) {
				PdfPCell horizontalAlignCell8 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell8.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(horizontalAlignCell8);
			} else if (fields[i].equals("Division")) {
				PdfPCell horizontalAlignCell9 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell9.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(horizontalAlignCell9);
			}
			/* WP Info */
			else if (fields[i].equals("WpYear")) {
				PdfPCell horizontalAlignCell10 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell10.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(horizontalAlignCell10);
			} else if (fields[i].equals("WpArea")) {
				PdfPCell horizontalAlignCell11 = new PdfPCell(
						new Phrase(
								"total:" + nfbDetails.stream()
										.mapToDouble(f -> f.getWpArea() != null ? f.getWpArea() : 0.0d).sum(),
								fontRow));
				horizontalAlignCell11.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell11);
			} else if (fields[i].equals("MmvArea")) {
				PdfPCell horizontalAlignCell12 = new PdfPCell(
						new Phrase("total:" + nfbDetails.stream().mapToDouble(f -> f.getMmvHa()).sum(), fontRow));
				horizontalAlignCell12.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell12);
			} else if (fields[i].equals("DiffNfMmv")) {
				PdfPCell horizontalAlignCell13 = new PdfPCell(new Phrase(
						"total:" + nfbDetails.stream().mapToDouble(f -> (f.getNareaHa() - f.getMmvHa())).sum(),
						fontRow));
				horizontalAlignCell13.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell13);
			} else if (fields[i].equals("DiffNfMmvPerc")) {
				PdfPCell horizontalAlignCell14 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell14.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(horizontalAlignCell14);
			}

			/* CMV Area */
			else if (fields[i].equals("CmvArea")) {
				PdfPCell horizontalAlignCell15 = new PdfPCell(
						new Phrase("total:" + nfbDetails.stream().mapToDouble(f -> f.getCmvHa()).sum(), fontRow));
				horizontalAlignCell15.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell15);
			} else if (fields[i].equals("DiffCmvNfa")) {
				PdfPCell horizontalAlignCell16 = new PdfPCell(new Phrase(
						"total:" + nfbDetails.stream().mapToDouble(f -> f.getNareaHa() / f.getCmvHa() * 100).sum(),
						fontRow));
				horizontalAlignCell16.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell16);
			} else if (fields[i].equals("DiffCmvNfaPerc")) {
				PdfPCell horizontalAlignCell17 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell17.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(horizontalAlignCell17);
			}
			/* JV Area */
			else if (fields[i].equals("JvArea")) {
				PdfPCell horizontalAlignCell18 = new PdfPCell(
						new Phrase("total:" + nfbDetails.stream().mapToDouble(f -> f.getJvHa()).sum(), fontRow));
				horizontalAlignCell18.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell18);
			} else if (fields[i].equals("DiffNfaJv")) {
				PdfPCell horizontalAlignCell19 = new PdfPCell(new Phrase(
						"total:" + nfbDetails.stream().mapToDouble(f -> f.getNareaHa() - f.getJvHa()).sum(), fontRow));
				horizontalAlignCell19.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell19);
			} else if (fields[i].equals("DiffNfaJvPerc")) {
				PdfPCell horizontalAlignCell20 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell20.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(horizontalAlignCell20);
			} else if (fields[i].equals("DtJvClr")) {
				PdfPCell horizontalAlignCell21 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell21.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(horizontalAlignCell21);
			} else if (fields[i].equals("JvCatg")) {
				PdfPCell horizontalAlignCell22 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell22.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(horizontalAlignCell22);
			} else if (fields[i].equals("JvExPillar")) {
				PdfPCell horizontalAlignCell23 = new PdfPCell(
						new Phrase("total:" + nfbDetails.stream().mapToInt(f -> f.getJvExistingPnts()).sum(), fontRow));
				horizontalAlignCell23.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell23);
			} else if (fields[i].equals("TotalPillar")) {
				PdfPCell horizontalAlignCell24 = new PdfPCell(
						new Phrase(
								"total:" + nfbDetails.stream()
										.mapToInt(f -> f.getJvExistingPnts() + f.getDgpsNoOfNewpillarpoint()).sum(),
								fontRow));
				horizontalAlignCell24.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell24);
			} else if (fields[i].equals("JvPerimtr")) {
				PdfPCell horizontalAlignCell25 = new PdfPCell(new Phrase(
						"total:" + nfbDetails.stream().mapToDouble(f -> f.getJvPerimeter().doubleValue()).sum(),
						fontRow));
				horizontalAlignCell25.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell25);
			}
			/* DGPS Info */
			else if (fields[i].equals("DgpsArea")) {
				PdfPCell horizontalAlignCell26 = new PdfPCell(
						new Phrase("total:" + nfbDetails.stream().mapToDouble(f -> f.getDgpsdHa()).sum(), fontRow));
				horizontalAlignCell26.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell26);
			} else if (fields[i].equals("DfoCertDt")) {
				PdfPCell horizontalAlignCell27 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell27.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(horizontalAlignCell27);
			} else if (fields[i].equals("FsoCertDt")) {
				PdfPCell horizontalAlignCell28 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell28.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(horizontalAlignCell28);
			} else if (fields[i].equals("FsocertArea")) {
				PdfPCell horizontalAlignCell29 = new PdfPCell(
						new Phrase("total:" + nfbDetails.stream().mapToDouble(f -> f.getDgpsfHa()).sum(), fontRow));
				horizontalAlignCell29.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell29);
			} else if (fields[i].equals("DgpsNwPillar")) {
				PdfPCell horizontalAlignCell30 = new PdfPCell(new Phrase(
						"total:" + nfbDetails.stream().mapToInt(f -> f.getDgpsNoOfNewpillarpoint()).sum(), fontRow));
				horizontalAlignCell30.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell30);
			} else if (fields[i].equals("DiffDgpsNfa")) {
				PdfPCell horizontalAlignCell31 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell31.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell31);
			} else if (fields[i].equals("DiffDgpsJv")) {
				PdfPCell horizontalAlignCell32 = new PdfPCell(new Phrase(" ", fontRow));
				horizontalAlignCell32.setHorizontalAlignment(Element.ALIGN_MIDDLE);
				table.addCell(horizontalAlignCell32);
			}

		}

	}

	@RequestMapping("/filedownNfbCustom/{fileName:.+}")
	private void downloadFlNotification(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("fileName") String fileName) {
		downloadFile(request, response, fileName);
	}


	private void downloadFile(HttpServletRequest request, HttpServletResponse response, String fileName) {
		// Object attribute = request.getSession().getAttribute("userID");
		// fileName=(attribute!=null?attribute.toString():"")+fileName;
		// String dataDirectory =
		// request.getServletContext().getRealPath("/WEB-INF/reports/downloads/");

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

//	private void downloadFile(HttpServletRequest request, HttpServletResponse response, String fileName) {
//		try {
//		// Object attribute = request.getSession().getAttribute("userID");
//		// fileName=(attribute!=null?attribute.toString():"")+fileName;
//		// String dataDirectory =
//		// request.getServletContext().getRealPath("/WEB-INF/reports/downloads/");
//
//		String dataDirectory = "C:/tmp/";
//		//String dataDirectory = "/var/upload/";
//		//String dataDirectory = "C:/upload/";
//		//Path file = Paths.get(dataDirectory, fileName);
//		Path path1 = Paths.get(dataDirectory, fileName);
//
//        Set<PosixFilePermission> perms = Files.readAttributes(path1, PosixFileAttributes.class).permissions();
//          
//           perms.add(PosixFilePermission.OWNER_READ);	      
//           perms.add(PosixFilePermission.GROUP_READ);
//           perms.add(PosixFilePermission.OTHERS_READ);
//     
//           Files.setPosixFilePermissions(path1, perms);
//		if (Files.exists(path1)) {
//			response.setContentType("application/pdf");
//			response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
//			try {
//				Files.copy(path1, response.getOutputStream());
//				response.getOutputStream().flush();
//			} catch (IOException ex) {
//				ex.printStackTrace();
//			}
//		}
//		}
//		catch (IOException ex) {
//			ex.printStackTrace();
//		}
//		
//	}
	
	    //for getting divData from session
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
				/*dividsByDiv = distDivLinkRepo.getDivisionMaster(divId).stream().map(m -> m.getDivisionMaster().getIntId())
						.collect(Collectors.toList());*/
			} else {
				if (divId > 0) {
					dividsByDist.add(divId);
				}
			}

			return dividsByDist;
		}


}
