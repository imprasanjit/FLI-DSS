package com.sparc.flidss.controller;

import java.io.Console;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
import com.sparc.flidss.model.common.DistrictMaster;
import com.sparc.flidss.model.common.TehsilMaster;
import com.sparc.flidss.service.ProgressMonitoringService;
import com.sparc.flidss.service.UtilityMasterService;
import com.sparc.flidss.utility.ItextHeaderFooterPageEvent;
import com.sparc.flidss.viewmodel.reports.IFnDLCRevDetails;
@Controller
@RequestMapping("/DLCRevenuereport")
public class DLCRevenuereportController {
	@Autowired ProgressMonitoringService pms;
	@Autowired
	UtilityMasterService service;	
	public void generatePdf(List<IFnDLCRevDetails> dlcRevList,String fields[],HttpServletRequest  request) {
		try {
			String dataDirectory = "C:/tmp/";
			Object userId = request.getSession().getAttribute("userID");
			String fileName=(userId!=null?userId.toString():"")+"DLCRevenueReport.pdf";
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
			
			Object attribute = request.getSession().getAttribute("userName");
			if(attribute!=null) {
				document.addAuthor(attribute.toString());
			}
			document.addCreationDate();
			document.addHeader("Header", "DLC Revenue Details");
			document.addSubject("DLC Revenue Details");
			document.addTitle("DLC Revenue Details");
			document.open();
			
			
			/**
			 * Add Report Title
			 */
				Font fontHeader = new Font(FontFamily.COURIER, 11, Font.BOLD);
		        PdfPTable ReportTitletable = new PdfPTable(new float[] { fields.length });
		        //headertable.setWidthPercentage(100f);
		        PdfPCell cell = new PdfPCell(new Phrase("DLC Revenue Details",fontHeader));
		        cell.setBorder(0);
		        cell.setColspan(fields.length);
		        //cell.setRowspan(2);
		        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		        cell.setPaddingBottom(5);
		        ReportTitletable.addCell(cell);
		        document.add(ReportTitletable);
			/** End of Report Title **/
			/*
			 * int size=0; for(Integer i=0;i<fields.length;i++) {
			 * if(fields[i].equals("Dist") || fields[i].equals("Tahsil")) { size=size+1; }
			 * else { size=size+2; } }
			 */
		    
			PdfPTable table = new PdfPTable(fields.length);
			table.setWidthPercentage(100);
			addTableHeader(table,fields);
			//addRows(table);
			addCustomRows(table,fields,dlcRevList);

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
	
	
private void addTableHeader(PdfPTable table,String fields[]) {
		
		Font fontH1 = new Font(FontFamily.COURIER, 11, Font.NORMAL);
	        for(Integer i=0;i<fields.length;i++) {
	        	if(fields[i].equals("Dlc")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase("Type",fontH1));
					default1Cell.setRowspan(2);
					default1Cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
					default1Cell.setBorderWidth(1);
					table.addCell(default1Cell);
				}
	        	else if(fields[i].equals("Dist")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase("District",fontH1));
					default1Cell.setRowspan(2);
					default1Cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
					default1Cell.setBorderWidth(1);
					table.addCell(default1Cell);
				}
	        	else if(fields[i].equals("Tahsil")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase("Tahsil",fontH1));
					default1Cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
					default1Cell.setBorderWidth(1);
					default1Cell.setRowspan(2);
					table.addCell(default1Cell);
				}
	        	else if(fields[i].equals("RICircle")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase("RI Circle",fontH1));
					default1Cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
					default1Cell.setBorderWidth(1);
					default1Cell.setRowspan(2);
					table.addCell(default1Cell);
				}
	        	else if(fields[i].equals("Vill")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase("Village",fontH1));
					default1Cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
					default1Cell.setBorderWidth(1);
					default1Cell.setRowspan(2);
					table.addCell(default1Cell);
				}
	        	else if(fields[i].equals("Plot")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase("No of Plot",fontH1));
					default1Cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
					default1Cell.setBorderWidth(1);
					default1Cell.setRowspan(2);
					table.addCell(default1Cell);
				}
	        	else if(fields[i].equals("Area")) {
					PdfPCell default1Cell = new PdfPCell(new Phrase("Area",fontH1));
					default1Cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
					default1Cell.setBorderWidth(1);
					default1Cell.setRowspan(2);
					table.addCell(default1Cell);
				}
	        }
	}	
	
	
	private void addCustomRows(PdfPTable table,String fields[],List <IFnDLCRevDetails> dlcRevList) 
			  throws URISyntaxException, BadElementException, IOException {
			   
		Font fontRow = new Font(FontFamily.TIMES_ROMAN, 9, Font.NORMAL);	
		dlcRevList.forEach(dlcrev-> {
			//var res=dlcrev.getChrv_district_nm();
				for(Integer i=0;i<fields.length;i++) {
					if(fields[i].equals("Dlc")) {
						PdfPCell default1Cell = new PdfPCell(new Phrase("DLC",fontRow));
						table.addCell(default1Cell);
					}
					else if(fields[i].equals("Dist")) {
						PdfPCell default1Cell = new PdfPCell(new Phrase(dlcrev.getChrv_district_nm(),fontRow));
						table.addCell(default1Cell);
					}
					else if(fields[i].equals("Tahsil")) {
						PdfPCell default1Cell = new PdfPCell(new Phrase(dlcrev.getChrv_tahasil_nm(),fontRow));
						table.addCell(default1Cell);
					}
					else if(fields[i].equals("RICircle")) {
						PdfPCell default1Cell = new PdfPCell(new Phrase(dlcrev.getRic(),fontRow));
						table.addCell(default1Cell);
					}
					else if(fields[i].equals("Vill")) {
						PdfPCell default1Cell = new PdfPCell(new Phrase(dlcrev.getVillage(),fontRow));
						table.addCell(default1Cell);
					}
					else if(fields[i].equals("Plot")) {
						PdfPCell default1Cell = new PdfPCell(new Phrase(dlcrev.getNo_of_dlc_plot()!=null?dlcrev.getNo_of_dlc_plot().toString():"N/A",fontRow));
						table.addCell(default1Cell);
					}
					else if(fields[i].equals("Area")) {
						PdfPCell default1Cell = new PdfPCell(new Phrase(dlcrev.getDlc_area_ac()!=null?dlcrev.getDlc_area_ac().toString():"N/A",fontRow));
						table.addCell(default1Cell);
					}
				}
				
		    });												
			}
	
	@Async
	@RequestMapping("/DLC&RevenueReports")
	public String dlcRevenueReports(HttpServletRequest request,Model model,@RequestParam(name = "types[]") String types[],@RequestParam(name = "fields[]") String fields[],@RequestParam(required = false) Integer distid,
			@RequestParam(required = false) Integer tehid,@RequestParam(required = false) String ricname,@RequestParam(required = false) String Villname)
	{		
		List<IFnDLCRevDetails> dlcRevList=null;
		try 
		{
			List<DistrictMaster> distList = service.GetDistrictList();		
			List<TehsilMaster> TehList = service.GetTehsilList();
			model.addAttribute("distList", distList.stream().filter(d->d.getIntId()>0).collect(Collectors.toList()));
			model.addAttribute("TehList", TehList.stream().filter(t->t.getIntId()>0).collect(Collectors.toList()));
			dlcRevList = pms.getDLCRevSummary(distid,tehid,ricname,Villname,Villname,types);
			
			
			generatePdf(dlcRevList,fields,request);
			/*
			 * dlcRevList = pms.getDLCRevSummary(" and int_fk_district=" + (distid != null ?
			 * distid : "int_fk_district") + " and int_fk_tehsil=" + (tehid != null ? tehid
			 * : "int_fk_tehsil") + " and ric=" + (ricname != null ? "'" + ricname + "'" :
			 * "ric") + " and village=" + (Villname != null ? "'" + Villname + "'" :
			 * "village") + "  ");
			 */
				
		} 
		catch (Exception ex) 
		{
			throw ex;
		}
		return "reports/DLC&RevenueReports";
	}
}
