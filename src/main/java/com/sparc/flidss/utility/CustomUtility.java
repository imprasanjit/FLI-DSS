package com.sparc.flidss.utility;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.stream.Collectors;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.sparc.flidss.repository.common.DistrictDivisionLinkMasterRepository;



/**
* Custom Utility classes
* Static Functions
* @author Thakur 
*/
public class CustomUtility {
	
	/**
	* Static Functions to get Dashboard Type
	* @author Smita
	*/
		public static Iterable<DBType> dashboardList()
		{
			ArrayList<DBType> arrList=new ArrayList<DBType>();
			arrList.add(new DBType(1,"Notified Forest Block"));
			/*
			 * arrList.add(new DBType(2,"Revenue Forest")); arrList.add(new
			 * DBType(3,"FRA")); arrList.add(new DBType(4,"Deemed Forest")); arrList.add(new
			 * DBType(5,"Other Forests"));
			 */
			arrList.add(new DBType(6,"Base Station Log"));
			arrList.add(new DBType(7,"JV Completed Forest Blocks"));
			arrList.add(new DBType(8,"ORSAC Verification"));
			
			return arrList;
		}
		
	/* Static Functions to send email with multiple recipient 
	*/
	 public static void sendEmail(String[] _toEmails,String _emailSubject,String _emailBody) throws AddressException, MessagingException
	    {
		 Session mailSession;
		 Properties emailProperties = System.getProperties();
	        emailProperties.put("mail.smtp.port", "587");
	        emailProperties.put("mail.smtp.auth", "true");
	        emailProperties.put("mail.smtp.starttls.enable", "true");
	        mailSession = Session.getDefaultInstance(emailProperties, null);
		 
	        String[] toEmails = _toEmails;
	        String emailSubject = _emailSubject;
	        String emailBody = _emailBody;
	        MimeMessage emailMessage = new MimeMessage(mailSession);
	        /**
	         * Set the mail recipients
	         * */
	        for (int i = 0; i < toEmails.length; i++)
	        {
	            emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
	        }
	        emailMessage.setSubject(emailSubject);
	        /**
	         * If sending HTML mail
	         * */
	        emailMessage.setContent(emailBody, "text/html");
	        /**
	         * If sending only text mail
	         * */
	        //emailMessage.setText(emailBody);// for a text email
	 
	        /**
	         * Sender's credentials
	         * */
	        String fromUser = "sltpgis@gmail.com";
	        String fromUserEmailPassword = "Sltp@12345";
	 
	        String emailHost = "smtp.gmail.com";
	        Transport transport = mailSession.getTransport("smtp");
	        transport.connect(emailHost, fromUser, fromUserEmailPassword);
	        
	        /**
	         * Send the mail
	         * */
	        transport.sendMessage(emailMessage, emailMessage.getAllRecipients());
	        transport.close();
	        //System.out.println("Email sent successfully.");
	    }
	 
	 
	 public static Iterable<ValueText> cdltpList() {
		 List<ValueText> obj= new ArrayList<ValueText>();
		 obj.add(new ValueText(1,"SPARC Pvt Ltd"));
		 obj.add(new ValueText(2,"Ananta Technology"));
		 
		 return obj;
     };
     
     public static Iterable<ValueText> workingYear() {
		 List<ValueText> obj= new ArrayList<ValueText>();
		 obj.add(new ValueText(1,"Year 1"));
		 obj.add(new ValueText(2,"Year 2"));
		 obj.add(new ValueText(3,"Year 3"));
		 obj.add(new ValueText(4,"Year 4"));
		 return obj;
     };

     public static List<String>convertArrayToStringList(String[]arr){
 		List<String> strArrya = new ArrayList<String>();
 		if (arr != null) {
 			for (var s : arr) {
 				strArrya.add(s);
 			}
 		}
 		return strArrya;
 	}
     public static Set<Integer>convertArrayToIntegerList(String[]arr){
  		Set<Integer> strArrya = new HashSet<Integer>();
  		if (arr != null) {
  			for (var s : arr) {
  				strArrya.add(Integer.parseInt(s));
  			}
  		}
  		return strArrya;
  	}
     public static Set<Integer>convertArrayToIntegerList(Integer[]arr){
   		Set<Integer> strArrya = new HashSet<Integer>();
   		if (arr != null) {
   			for (var s : arr) {
   				strArrya.add(s);
   			}
   		}
   		return strArrya;
   	}
     
}

 class DBType
{
	 private int int_val;
	 private String chrv_fbname ;
	public DBType(int int_val, String chrv_fbname) {
		super();
		this.int_val = int_val;
		this.chrv_fbname = chrv_fbname;
	}
	public int getInt_val() {
		return int_val;
	}
	public void setInt_val(int int_val) {
		this.int_val = int_val;
	}
	public String getChrv_fbname() {
		return chrv_fbname;
	}
	public void setChrv_fbname(String chrv_fbname) {
		this.chrv_fbname = chrv_fbname;
	}
	
	
	
}

 