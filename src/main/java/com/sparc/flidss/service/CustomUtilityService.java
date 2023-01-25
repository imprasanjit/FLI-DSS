package com.sparc.flidss.service;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class CustomUtilityService {
	public String GenerateOTP()
    {
        String strrandom = "";
        String s="0123456789";
        char[] charArr=s.toCharArray();
        Random objran = new Random();
        Integer noofcharacters =6;
        for (Integer i = 0; i < noofcharacters; i++)
        {
            int pos = objran.nextInt(charArr.length-1) + 1;
            if (!strrandom.contains(charArr.toString()))
                strrandom += charArr[pos];
            else
                i--;
        }
        return strrandom;
    }
}
