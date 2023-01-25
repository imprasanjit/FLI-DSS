package com.sparc.flidss.externalApi;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Controller
public class NfbDataSync {
	@PostMapping("/nfbDataInsertation")
	@ResponseBody
	public String nfbDataInsertation() {
		String uri="";
		//Rest Template is used to create applications that consume external RESTful Web Services
		RestTemplate restTemplate=new RestTemplate();
		String results = restTemplate.getForObject(uri, String.class);	
		return results;		
	}

}
