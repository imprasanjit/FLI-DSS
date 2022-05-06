package com.sparc.flidss.utility;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import org.springframework.core.io.ClassPathResource;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadUtil {
	
	public static void saveFile(String fileName,
            MultipartFile multipartFile) throws IOException {
		File savFile = new ClassPathResource("static/assets/profile_img").getFile();
        Path uploadPath = Paths.get(savFile.getAbsolutePath()+File.separator+fileName);
         
        if (!Files.exists(uploadPath)) {
        	System.out.println(uploadPath);
           Files.createDirectories(uploadPath);
        }
         
        try (InputStream inputStream = multipartFile.getInputStream()) {
            Files.copy(inputStream, uploadPath, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException ioe) {        
            throw new IOException("Could not save image file: " + fileName, ioe);
        }      
    }

}
