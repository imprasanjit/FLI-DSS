package com.sparc.flidss.utility;

import java.util.Random;

//Class to generate randam password

public class RandomNumberGenerator {
	
	// Generate a random number between two numbers    
    public static int RandomNumber(Integer min, Integer max)
    {
        Random random = new Random();
       return random.nextInt(max);
        //return random.Next(min, max);
    }
    public static String RandomString(Integer size, Boolean lowerCase)
    {
        StringBuilder builder = new StringBuilder();
        Random random = new Random();
        char ch;
        for (int i = 0; i < size; i++)
        {
            ch = (char) (int)Math.floor(26 * random.nextDouble() + 65);
            builder.append(ch);
        }
        if (lowerCase)
            return builder.toString().toLowerCase();
        return builder.toString();
    }

    // Generate a random password of a given length (optional)  
    public static String RandomPassword()
    {
        StringBuilder builder = new StringBuilder();
        builder.append(RandomString(4, true));
        builder.append(RandomNumber(1000, 9999));
        builder.append(RandomString(2, false));
        return builder.toString();
    }


}
