package com.sparc.flidss.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URISyntaxException;
import java.util.List;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.engine.jdbc.StreamUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
import com.sparc.flidss.service.ProgressMonitoringService;
import com.sparc.flidss.utility.ItextHeaderFooterPageEvent;
import com.sparc.flidss.viewmodel.progressmonitoring.UvwNfbSummary;

@Controller
@RequestMapping("/NotificationreportController")
public class NotificationreportController {
	@Autowired
	ProgressMonitoringService pms;

	@RequestMapping("/getForestLandData")
	public @ResponseBody String getForestLandData(HttpServletRequest request,
			@RequestParam(name = "fields[]") String fields[], @RequestParam(required = false) Integer divId,
			@RequestParam(required = false) String rngCode, @RequestParam(required = false) Integer nfbid) {
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
			
			if (generatePdf(nfbDetails, fields, request,divId,rngCode).equals("1")) {
				res = "1";
				getFile(null);
			}
			
			//var dir = divId + "_" + rngCode ;
			 //Move to zip folder
            //ZipFile.CreateFromDirectory (Path.Combine ("wwwroot", "ZipFiles/CDLTPLog/" + dir), Path.Combine ("wwwroot", "ZipFiles/CDLTPLog/" + dir + ".zip"));
		} catch (Exception ex) {
			throw ex;
		}
		return res;// "reports/flNotificationStatus";
	}
	
	public String generatePdf(List<UvwNfbSummary> nfbDetails, String fields[], HttpServletRequest request,Integer divId,String rngCode) {
		String res = "0";
		
		
		try {
			UvwNfbSummary firstRow = nfbDetails.stream().findFirst().orElse(null);
			
			Object userId = request.getSession().getAttribute("userID");
			
			String fileName=(userId!=null?userId.toString():"")+"ForestLandNotification.pdf";
			
			//String dataDirectory = "C:/tmp/";
			//String dataDirectory ="src/main/resources/static/reports/flNotification/";
			String dataDirectory ="/var/upload/";
			
			File file=new File(dataDirectory+fileName);
			if(file.exists()) {
				file.delete();
			}
			
			Document document = new Document(PageSize.A4, 10.0F, 10.0F, 30.0F, 30.0F);
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(dataDirectory+fileName));

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
			document.addHeader("Header", "Notification Details");
			document.addSubject("Notification Details");
			document.addTitle("Notification Details");
			document.open();

			/**
			 * Add Report Title
			 */
			Font fontHeader = new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD);
			PdfPTable ReportTitletable = new PdfPTable(new float[] { fields.length });
			// headertable.setWidthPercentage(100f);
			PdfPCell cell = new PdfPCell(new Phrase("Notification Details", fontHeader));
			cell.setBorder(0);
			cell.setColspan(fields.length);
			// cell.setRowspan(2);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setPaddingBottom(4);
			ReportTitletable.addCell(cell);
			
			if(divId!=null) {
			Font fontHeader2 = new Font(FontFamily.TIMES_ROMAN, 10, Font.NORMAL);
			PdfPCell cell2 = new PdfPCell(new Phrase((divId!=null? firstRow.getChrvDivisionNm()+" Division":"All Division")+(rngCode!=null?", "+firstRow.getChrvRangeNm()+" Range":""), fontHeader2));
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

		Font fontH1 = new Font(FontFamily.TIMES_ROMAN, 11, Font.NORMAL);
		Stream.of(fields).forEach(columnTitle -> {
			PdfPCell header = new PdfPCell();
			header.setBackgroundColor(BaseColor.LIGHT_GRAY);
			header.setBorderWidth(1);
			header.setPhrase(new Phrase(columnTitle.replace("DivisionName", "Division Name")
					                               .replace("RangeName", "Range Name")
					                               .replace("FbName", "Fb Name"), fontH1));
			table.addCell(header);
		});
	}

	

	private void addCustomRows(PdfPTable table, String fields[], List<UvwNfbSummary> nfbDetails)
			throws URISyntaxException, BadElementException, IOException {
		
		Font fontRow = new Font(FontFamily.TIMES_ROMAN, 9, Font.NORMAL);
		nfbDetails.forEach(nfb -> {
			for (Integer i = 0; i < fields.length; i++) {
				if(fields[i].equals("DivisionName")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getChrvDivisionNm() != null ? nfb.getChrvDivisionNm() : "N/A",
							fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);					
				}
				else if(fields[i].equals("RangeName")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getChrvRangeNm() != null ? nfb.getChrvRangeNm() : "N/A",
							fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				}
				else if(fields[i].equals("FbName")) {
					PdfPCell horizontalAlignCell = new PdfPCell(new Phrase(
							nfb.getNfbName() != null ? nfb.getNfbName() : "N/A",
							fontRow));
					horizontalAlignCell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
					table.addCell(horizontalAlignCell);
				}
				/*
				 * else if (fields[i].equals("FbName")) { PdfPCell default1Cell = new
				 * PdfPCell(new Phrase(nfb.getNfbName(), fontRow)); table.addCell(default1Cell);
				 * }
				 */
				else if (fields[i].equals("FRJVC")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase("FRJVC", fontRow));
					table.addCell(default1Cell);
				}
				else if (fields[i].equals("FSO")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase("FSO", fontRow));
					table.addCell(default1Cell);
				}
				else if (fields[i].equals("RENoti")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase("RENoti", fontRow));
					table.addCell(default1Cell);
				} 
			}

		});

	}

		
	@RequestMapping(value = "/export", method = RequestMethod.GET)
	public void getFile(OutputStream out) {
	    //FileSystemResource resource = new FileSystemResource("D:\\FLI_DSS\\src\\main\\resources\\static\\projectDocs\\download\\fsoCertified"); 
	   // FileSystemResource resource = new FileSystemResource("C:/tmp/");
	    FileSystemResource resource = new FileSystemResource("/var/upload/");
	    try (ZipOutputStream zippedOut = new ZipOutputStream(out)) {
	        ZipEntry e = new ZipEntry(resource.getFilename());
	        // Configure the zip entry, the properties of the file
	        e.setSize(resource.contentLength());
	        e.setTime(System.currentTimeMillis());
	        // etc.
	        zippedOut.putNextEntry(e);
	        // And the content of the resource:
	        StreamUtils.copy(resource.getInputStream(), zippedOut);
	        zippedOut.closeEntry();
	        zippedOut.finish();
	    } catch (Exception e) {
	        
	    }        
	}
}
