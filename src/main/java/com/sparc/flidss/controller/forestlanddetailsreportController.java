package com.sparc.flidss.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import com.sparc.flidss.service.ProgressMonitoringService;
import com.sparc.flidss.utility.ItextHeaderFooterPageEvent;
import com.sparc.flidss.viewmodel.progressmonitoring.IFrjvcCertifiedpointDetails;
import com.sparc.flidss.viewmodel.progressmonitoring.UvwNfbSummary;
import com.sparc.flidss.viewmodel.reports.IFnForestLandSummary;

@Controller
@RequestMapping("/forestlanddetailsreport")
public class forestlanddetailsreportController {
	@Autowired
	ProgressMonitoringService pms;

	public void generatePdf(List<IFnForestLandSummary> nfbDetails, String fields[], HttpServletRequest request) {
		try {
			String dataDirectory = "C:/tmp/";
			Object userId = request.getSession().getAttribute("userID");
			String fileName = (userId != null ? userId.toString() : "") + "ForestLandTypeDetails.pdf";
			// Document document = new Document();
			// PdfWriter writer = PdfWriter.getInstance(document, new
			// FileOutputStream("src/main/resources/static/reports/flNotification/ForestLandNotification.pdf"));
			// PdfWriter writer = PdfWriter.getInstance(document, new
			// FileOutputStream(dataDirectory+fileName));
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

			Object attribute = request.getSession().getAttribute("userName");
			if (attribute != null) {
				document.addAuthor(attribute.toString());
			}
			document.addCreationDate();
			document.addHeader("Header", "Notified Forest Land Summary");
			document.addSubject("Notified Forest Land Summary");
			document.addTitle("Notified Forest Land Summary");
			document.open();

			/**
			 * Add Report Title
			 */
			Font fontHeader = new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD);
			PdfPTable ReportTitletable = new PdfPTable(new float[] { fields.length });
			// headertable.setWidthPercentage(100f);
			PdfPCell cell = new PdfPCell(new Phrase("Forest Land Summary", fontHeader));
			cell.setBorder(0);
			cell.setColspan(fields.length);
			// cell.setRowspan(2);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setPaddingBottom(5);
			ReportTitletable.addCell(cell);
			document.add(ReportTitletable);
			/** End of Report Title **/
			int size = 0;
			for (Integer i = 0; i < fields.length; i++) {
				if (fields[i].equals("DivisionName") || fields[i].equals("RangeName")) {
					size = size + 1;
				} else {
					size = size + 2;
				}
			}
			PdfPTable table = new PdfPTable(size);
			table.setWidthPercentage(100);
			addTableHeader(table, fields);
			// addRows(table);
			addCustomRows(table, fields, nfbDetails);

			document.add(table);
			document.close();
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

	}

	private void addTableHeader(PdfPTable table, String fields[]) {

		Font fontH1 = new Font(FontFamily.TIMES_ROMAN, 11, Font.NORMAL);
		/*
		 * PdfPCell cell23 = new PdfPCell(new Phrase("Notified Forest"));
		 * cell23.setColspan(6); cell23.setRowspan(2); table.addCell(cell23);
		 */
		// header.setPhrase(new
		// Phrase(columnTitle.replace("NotifiedForest","NotifiedForest")
		/*
		 * header.setPhrase(new Phrase(columnTitle.replace("DivisionName",
		 * "Division Name") //.replace("DivisionName","Division Name")
		 * .replace("RangeName", "Range Name") .replace("RF","RF") .replace("PRF","PRF")
		 * .replace("PF","PF") .replace("DPF","DPF")
		 * 
		 * ,fontH1));
		 */
		Integer int_totForestType = 0;
		for (Integer i = 0; i < fields.length; i++) {
			if (fields[i].equals("DivisionName")) {
				PdfPCell default1Cell = new PdfPCell(new Phrase("Division", fontH1));
				default1Cell.setRowspan(2);
				default1Cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
				default1Cell.setBorderWidth(1);
				table.addCell(default1Cell);
			} else if (fields[i].equals("RangeName")) {
				PdfPCell default1Cell = new PdfPCell(new Phrase("Range", fontH1));
				default1Cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
				default1Cell.setBorderWidth(1);
				default1Cell.setRowspan(2);
				table.addCell(default1Cell);
			} else {
				PdfPCell default1Cell = new PdfPCell(new Phrase(fields[i], fontH1));
				default1Cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
				default1Cell.setBorderWidth(1);
				default1Cell.setColspan(2);
				table.addCell(default1Cell);
				int_totForestType = int_totForestType + 1;
			}
		}
		for (Integer i = 0; i < int_totForestType; i++) {
			table.addCell(new PdfPCell(new Phrase("No. of FBs", fontH1)));
			table.addCell(new PdfPCell(new Phrase("Area(Ha)", fontH1)));
		}

	}

	private void addCustomRows(PdfPTable table, String fields[], List<IFnForestLandSummary> nfbDetails)
			throws URISyntaxException, BadElementException, IOException {

		Font fontRow = new Font(FontFamily.TIMES_ROMAN, 9, Font.NORMAL);
		nfbDetails.forEach(nfb -> {
			for (Integer i = 0; i < fields.length; i++) {
				// var res=nfb.getDiv_name();
				if (fields[i].equals("DivisionName")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase(nfb.getDiv_name(), fontRow));
					table.addCell(default1Cell);
				} else if (fields[i].equals("RangeName")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase(nfb.getRange_name(), fontRow));
					table.addCell(default1Cell);
				}

				else if (fields[i].equals("RF")) {

					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getRf_total() != null ? nfb.getRf_total().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(horizontalAlignCell);

					PdfPCell horizontalAlignCell1 = new PdfPCell(new Phrase(
							nfb.getRf_area() != null ? String.format("%,.3f", nfb.getRf_area()) : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(horizontalAlignCell1);

				}

				else if (fields[i].equals("PRF")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getPrf_total() != null ? nfb.getPrf_total().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(horizontalAlignCell);
					PdfPCell horizontalAlignCell1 = new PdfPCell(new Phrase(
							nfb.getPrf_area() != null ? String.format("%,.3f", nfb.getPrf_area()) : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(horizontalAlignCell1);
				} else if (fields[i].equals("PF")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getPf_total() != null ? nfb.getPf_total().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(horizontalAlignCell);

					PdfPCell horizontalAlignCell1 = new PdfPCell(new Phrase(
							nfb.getPf_area() != null ? String.format("%,.3f", nfb.getPf_area()) : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(horizontalAlignCell1);
				}

				else if (fields[i].equals("DPF")) {
					PdfPCell horizontalAlignCell = new PdfPCell(
							new Phrase(nfb.getDpf_total() != null ? nfb.getDpf_total().toString() : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(horizontalAlignCell);

					PdfPCell horizontalAlignCell1 = new PdfPCell(new Phrase(
							nfb.getDpf_area() != null ? String.format("%,.3f", nfb.getDpf_area()) : "N/A", fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(horizontalAlignCell1);

				}
				/*
				 * else if(fields[i].equals("NoofPF")) { PdfPCell horizontalAlignCell = new
				 * PdfPCell(new
				 * Phrase(nfb.getPf_total()!=null?nfb.getPf_total().toString():"N/A",fontRow));
				 * horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
				 * table.addCell(horizontalAlignCell); }
				 * 
				 * else if(fields[i].equals("AreaofPF")) { PdfPCell horizontalAlignCell = new
				 * PdfPCell(new
				 * Phrase(nfb.getPf_area()!=null?nfb.getPf_area().toString():"N/A",fontRow));
				 * horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				 * table.addCell(horizontalAlignCell); } else if(fields[i].equals("NoofDPF")) {
				 * PdfPCell horizontalAlignCell = new PdfPCell(new
				 * Phrase(nfb.getDpf_total()!=null?nfb.getDpf_total().toString():"N/A",fontRow))
				 * ; horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
				 * table.addCell(horizontalAlignCell); }
				 * 
				 * else if(fields[i].equals("AreaofDPF")) { PdfPCell horizontalAlignCell = new
				 * PdfPCell(new
				 * Phrase(nfb.getDpf_area()!=null?nfb.getDpf_area().toString():"N/A",fontRow));
				 * horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				 * table.addCell(horizontalAlignCell); }
				 */
			}

		});
		//total addition in PDF table
		for (Integer i = 0; i < fields.length; i++) {
			if (fields[i].equals("DivisionName")) {
				PdfPCell default1Cell1 = new PdfPCell(new Phrase("N/A", fontRow));
				table.addCell(default1Cell1);
			} else if (fields[i].equals("RangeName")) {
				PdfPCell default1Cell2 = new PdfPCell(new Phrase("N/A", fontRow));
				table.addCell(default1Cell2);
			} else if (fields[i].equals("RF")) {

				PdfPCell horizontalAlignCell = new PdfPCell(
						new Phrase("Total:" + nfbDetails.stream().mapToInt(f -> f.getRf_total()).sum(), fontRow));
				horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell);

				PdfPCell horizontalAlignCell1 = new PdfPCell(
						new Phrase("Total:" + nfbDetails.stream().mapToDouble(f -> f.getRf_area()).sum(), fontRow));
				horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell1);

			} else if (fields[i].equals("PRF")) {
				PdfPCell horizontalAlignCell = new PdfPCell(
						new Phrase("Total:" + nfbDetails.stream().mapToInt(f -> f.getPrf_total()).sum(), fontRow));
				horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell);
				PdfPCell horizontalAlignCell1 = new PdfPCell(
						new Phrase("Total:" + nfbDetails.stream().mapToDouble(f -> f.getPrf_area()).sum(), fontRow));
				horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(horizontalAlignCell1);
			} else if (fields[i].equals("PF")) {
				PdfPCell horizontalAlignCell = new PdfPCell(
						new Phrase("Total:" + nfbDetails.stream().mapToInt(f -> f.getPf_total()).sum(), fontRow));
				horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(horizontalAlignCell);

				PdfPCell horizontalAlignCell1 = new PdfPCell(
						new Phrase("Total:" + nfbDetails.stream().mapToDouble(f -> f.getPf_area()).sum(), fontRow));
				horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(horizontalAlignCell1);
			} else if (fields[i].equals("DPF")) {
				PdfPCell horizontalAlignCell = new PdfPCell(
						new Phrase("Total:" + nfbDetails.stream().mapToInt(f -> f.getDpf_total()).sum(), fontRow));
				horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(horizontalAlignCell);

				PdfPCell horizontalAlignCell1 = new PdfPCell(
						new Phrase("Total:" + nfbDetails.stream().mapToDouble(f -> f.getDpf_area()).sum(), fontRow));
				horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(horizontalAlignCell1);

			}

		}
	}

	@RequestMapping("/getForestLandSummary")
	public @ResponseBody String getForestLandSummary(HttpServletRequest request,
			@RequestParam(name = "fields[]") String fields[], @RequestParam(required = false) Integer divId,
			@RequestParam(required = false) String rngCode, @RequestParam(required = false) Integer nfbid) {
		List<IFnForestLandSummary> nfbDetails;
		try {
			divId = divId != null ? divId : 0;
			rngCode = rngCode != null && !rngCode.isEmpty() ? rngCode : "";
			nfbid = nfbid != null ? nfbid : 0;
			nfbDetails = pms.getForestlandSummary(divId, rngCode, nfbid, rngCode);
			// nfbDetails = pms.getForestlandSummary("select * from
			// public.fn_forest_land_summary(2,'ATH01',null,'')");
			// model.addAttribute("nfbList", nfbDetails);

			generatePdf(nfbDetails, fields, request);
		} catch (Exception ex) {
			throw ex;
		}
		return "1";// "reports/flNotificationStatus";
	}
}
