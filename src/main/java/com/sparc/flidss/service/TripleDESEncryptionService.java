package com.sparc.flidss.service;

	import javax.crypto.SecretKey;
	import javax.crypto.Cipher;
	import javax.crypto.spec.*;


import org.springframework.stereotype.Service;

import java.util.*;

	import java.security.MessageDigest; 
	/**
	* Encryption and Decryption using TripleDES algorithm and  MD5 for generating hash
	* @author Smita 
	*/
	@Service
	public class TripleDESEncryptionService {
	   
	  private String key;
	    
     public TripleDESEncryptionService ()
     {
         this.key = "jkfasbgjd12345hjkbhckjsdh";
     }
	 
     public String encryptText(String plainText) throws Exception{
    	 final MessageDigest md = MessageDigest.getInstance("md5");
         final byte[] digestOfPassword = md.digest(key
                 .getBytes("utf-8"));
         final byte[] keyBytes = Arrays.copyOf(digestOfPassword, 24);
         for (int j = 0, k = 16; j < 8;) {
             keyBytes[k++] = keyBytes[j++];
         }

         final SecretKey secretkey = new SecretKeySpec(keyBytes, "TripleDES");
         //final IvParameterSpec iv = new IvParameterSpec(new byte[8]);
         final Cipher cipher = Cipher.getInstance("TripleDES/ECB/PKCS5Padding");
         cipher.init(Cipher.ENCRYPT_MODE, secretkey);
         
         final byte[] plainTextBytes = plainText.getBytes("utf-8");
         final byte[] cipherText = cipher.doFinal(plainTextBytes);
         return new String(Base64.getEncoder().encode(cipherText));
     }
	   
     public String decrypt(String input) throws Exception {

         byte[] message = Base64.getDecoder().decode(input);

         final MessageDigest md = MessageDigest.getInstance("md5");
         final byte[] digestOfPassword = md.digest(key
                 .getBytes("utf-8"));
         final byte[] keyBytes = Arrays.copyOf(digestOfPassword, 24);
         for (int j = 0, k = 16; j < 8;) {
             keyBytes[k++] = keyBytes[j++];
         }

         final SecretKey secretkey = new SecretKeySpec(keyBytes, "DESede");
         //final IvParameterSpec iv = new IvParameterSpec(new byte[8]);
         final Cipher decipher = Cipher.getInstance("TripleDES/ECB/PKCS5Padding");
         decipher.init(Cipher.DECRYPT_MODE, secretkey);
         final byte[] plainText = decipher.doFinal(message);

         return new String(plainText, "UTF-8");
     }
	}
