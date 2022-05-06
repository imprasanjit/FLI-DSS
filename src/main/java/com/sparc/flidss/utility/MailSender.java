package com.sparc.flidss.utility;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

public class MailSender {

	 String msg=null;
	  public  String sendEmail(String _toEmails,String _emailSubject,String _emailBody) throws AddressException, MessagingException
	    { 
		  
		  
		  try {

		    Session mailSession;
		    Properties emailProperties = System.getProperties();
	        emailProperties.put("mail.smtp.port", "587");
	        emailProperties.put("mail.smtp.auth", "true");
	        emailProperties.put("mail.smtp.starttls.enable", "true");
	        mailSession = Session.getDefaultInstance(emailProperties, null);
		 
	        String toEmails = _toEmails;
	        String emailSubject = _emailSubject;
	        String emailBody = _emailBody;
	        MimeMessage emailMessage = new MimeMessage(mailSession);
	     
			/* Set the mail recipients */
			/*
			 * for (int i = 0; i < toEmails.length; i++) {
			 * emailMessage.addRecipient(Message.RecipientType.TO, new
			 * InternetAddress(toEmails[i])); }
			 */
	        
	        emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails));
	        emailMessage.setSubject(emailSubject);
	        emailMessage.setContent(emailBody, "text/html"); /* If sending HTML mail */
	        emailMessage.setText(emailBody); /* If sending only text mail */
	        
			/*
			 * Sender's credentials
			 */
	        
	        String fromUser ="Email";
	        String fromUserEmailPassword ="Password";
	        String emailHost = "smtp.gmail.com";
	        Transport transport = mailSession.getTransport("smtp");
	        transport.connect(emailHost, fromUser, fromUserEmailPassword);
	        
			/* Send the mail */
	        transport.sendMessage(emailMessage, emailMessage.getAllRecipients());
            msg="OK";
	    }
		  catch(Exception e) {
			  e.printStackTrace();
			 msg = e.getMessage();
		  }
	 
		  return msg;
	    }


}
