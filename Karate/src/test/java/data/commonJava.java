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
	public static String generateRandom(String type ){
		String generatedRandom = null;
		try{
		switch(type){
		case "email":
	String generatedString = RandomStringUtils.randomAlphabetic(6);
	generatedRandom="QAAuto_"+generatedString+ "@kore.com";
		break;
		case "string":
		String generatedStr = RandomStringUtils.randomAlphabetic(6);
	double randVal = (Math.random()) * 100;
		int generatednum = (int) randVal;
		generatedRandom="Sanity"+generatedStr+generatednum;
		break;
		case "number":
		double randVal1 = (Math.random()) * 10000;
		int randomId = (int) randVal1;
		generatedRandom = Integer.toString(randomId);
		break;
		}
		}catch(Exception e) {
		e.printStackTrace();
		}

		return generatedRandom;
	}
	
	}

	 
	

