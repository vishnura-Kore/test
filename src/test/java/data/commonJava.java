package data;

import org.apache.commons.lang3.RandomStringUtils;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.TimeZone;
import java.text.SimpleDateFormat;  
import java.util.Date;  
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;
import java.util.concurrent.TimeUnit;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class commonJava {
	
		public static String getRequiredDate(int incrementDays, String expectedDateFormat, String timeZoneId)
		{
			try 
			{
				DateFormat dateFormat;
				Calendar calendar = Calendar.getInstance();
				dateFormat = new SimpleDateFormat(expectedDateFormat);
				if(timeZoneId != null && ! timeZoneId.equals(""))
					dateFormat.setTimeZone(TimeZone.getTimeZone(timeZoneId));
				calendar.add(Calendar.DAY_OF_MONTH, incrementDays);
				Date tomorrow = calendar.getTime();
				String formattedDate = dateFormat.format(tomorrow);
				return formattedDate;
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				return null;
			}}
		
		
		public static String getdecrementdays(int decrementdays, String expectedDateFormat, String timeZoneId)
		{
			try 
			{
				DateFormat dateFormat;
				Calendar calendar = Calendar.getInstance();
				calendar.add(Calendar.DAY_OF_MONTH, 0);
				dateFormat = new SimpleDateFormat(expectedDateFormat);
				if(timeZoneId != null && ! timeZoneId.equals(""))
					dateFormat.setTimeZone(TimeZone.getTimeZone(timeZoneId));
				calendar.add(Calendar.DAY_OF_MONTH, decrementdays);
				Date tomorrow = calendar.getTime();
				String formattedDate = dateFormat.format(tomorrow);
				return formattedDate;
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				return null;
			}}
		
		public static String ConvertDateFormat (String givenDate,String givenDateFormat, String expectedDateFormat)
		{
			try 
			{
				DateFormat dateFormat;
				Calendar calendar = Calendar.getInstance();
				dateFormat = new SimpleDateFormat(givenDateFormat);
				Date date = (Date)dateFormat.parse(givenDate);
				dateFormat = new SimpleDateFormat(expectedDateFormat);
				String formattedDate = dateFormat.format(date);
				return formattedDate;
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				return null;
			}
		}

		public static String generateRandom(String type) {
			String generatedRandom = null;
			try {
				switch (type) {
				case "email":
					String generatedString = RandomStringUtils.randomAlphabetic(6);
					generatedRandom = "QAAuto_" + generatedString + "@kore.com";
					break;
				case "string":
					String generatedStr = RandomStringUtils.randomAlphabetic(6);
					double randVal = (Math.random()) * 100;
					int generatednum = (int) randVal;
					generatedRandom = "Sanity" + generatedStr + generatednum;
					break;
				case "number":
					double randVal1 = (Math.random()) * 10000;
					int randomId = (int) randVal1;
					generatedRandom = Integer.toString(randomId);
					break;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

			return generatedRandom;
		}
		
	    public static void downloadUsingStream(String urlStr, String file) throws IOException {
	        URL url = new URL(urlStr);
	        BufferedInputStream bis = new BufferedInputStream(url.openStream());
	        FileOutputStream fis = new FileOutputStream(file);
	        byte[] buffer = new byte[1024];
	        int count=0;
	        while((count = bis.read(buffer,0,1024)) != -1)
	        {
	            fis.write(buffer, 0, count);
	        }
	        fis.close();
	        bis.close();
	    }
	    
	    
	    public static void unzip(String zipFilePath, String destinationFilePath) throws IOException {
			File destinationDirectoryFolder = new File(destinationFilePath);
			if (destinationDirectoryFolder.exists()) {
				deleteDirectory(destinationDirectoryFolder);
				destinationDirectoryFolder.delete();
			}
			destinationDirectoryFolder.mkdir();
			byte[] buffer = new byte[1024];
			ZipInputStream zis = new ZipInputStream(new FileInputStream(zipFilePath));
			ZipEntry entry = zis.getNextEntry();
			while (entry != null) {
				String filePath = destinationFilePath + File.separator + entry.getName();
				System.out.println("Unzipping " + filePath);
				if (!entry.isDirectory()) {
					FileOutputStream fos = new FileOutputStream(filePath);
					int len;
					while ((len = zis.read(buffer)) > 0) {
						fos.write(buffer, 0, len);
					}
					fos.close();
				} else {
					File file = new File(filePath);
					file.mkdir();
				}
				zis.closeEntry();
				entry = zis.getNextEntry();

			}
			zis.closeEntry();
			zis.close();
			System.out.println("Unzipping complete...");
		}

		public static void deleteDirectory(File file) {
			for (File subfile : file.listFiles()) {
				if (subfile.isDirectory()) {
					deleteDirectory(subfile);
				}
				subfile.delete();
			}
		}
	}


	 
	

