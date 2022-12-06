package stepDefinitions;
import framework.HashMapContainer;
import framework.StepBase;
import framework.Utilities;
import framework.WrapperFunctions;
import io.cucumber.core.exception.CucumberException;
import io.cucumber.datatable.DataTable;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;

import framework.SQLConnector;
import framework.FrameworkExceptions;
import stepDefinitions.CommonSteps;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import pageObjects.GetPageObject;

public class Kore_custom {
	
	static WrapperFunctions wrapFunc = new WrapperFunctions();
	static StepBase sb = new StepBase();
	public static WebDriver driver= sb.getDriver();
	static Utilities util = new Utilities();
	static CommonSteps Comstp = new CommonSteps();
	
	@Then("^I wait for innertext '(.*)' untill element '(.*)' found$")
    public static void I_wait_Element_is_loaded(String aText, String element){
        try{
        	int time=30;
            for (int i=0; i<time; i++){

                CommonSteps.I_get_Attribute_innertext_from(element);
                String actualText =HashMapContainer.get(element);
                
                 if (!actualText.equals(aText))
                    {
                     Thread.sleep(2000);
                     //i++;
					 System.out.println("The Actual text is "+actualText);
					 System.out.println("The Expected text is "+aText);
                    }
             else{
                System.out.println("The Actual text is "+actualText+" equals expected "+aText );
                break;
                }
            }
        }catch(Exception e){
                //e.printStackTrace();
                //throw new CucumberException(e.getMessage(), e);
            }
        }
	

	@Then("^I get system date$")
	public static String Date_gen() {
		 
		 // Create object of SimpleDateFormat class and decide the format
		 DateFormat dateFormat = new SimpleDateFormat("E, MMM dd yyyy h:mm:ss a");
		 DateFormat TimeFormat = new SimpleDateFormat("hh.mm aa");
		 DateFormat chatdateFormat = new SimpleDateFormat("E MMM dd yyyy");
		 
		 //get current date time with Date()
		 Date date = new Date();
		 
		 // Now format the date
		 String date1= dateFormat.format(date);
		 String chat_date= chatdateFormat.format(date);
		 String TimeString = TimeFormat.format(date).toString();
		 // Print the Date
		  System.out.println("Current date and time is " +date1);
		 return date1;

		 
		 }

	@Then("^I Import the Type of file '(.*)' and its in '(.*)'$")
	public static void Import_file(String File_typ, String filename )
	{
		try{
			
			WebElement fileInput = driver.findElement(GetPageObject.OR_GetElement(File_typ));
			//driWebElement fileInput = driver.findElement(GetPageObject.OR_GetElement(File_typ));ver.findElement(By.xpath("//input[@id='importBotDefinition']"));
			fileInput.sendKeys(System.getProperty("user.dir") +"/src/test/java/resources/BOT/"+filename+"");
		
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}

	
	@Then("^I compare responces message '(.*)' from Channel type '(.*)'$")
	public static void FB_compare_Msg(String aText, String bot_typ) {
		try{
			String element = "";
			String Timeofchat="";
			switch(bot_typ){

				case "FB":
					element="(//*[@data-testid=\"message-container\"]/div[1]/div[1]/div[1]/span/div/div[1]/div/div)";
					break;
					
				case "whatsapp":
					element="(//span[@aria-label=\"Akraji Bank:\"]/following-sibling::div//div/div/span/span[text()='"+aText+"'])";
					Timeofchat="(//span[@aria-label=\"Akraji Bank:\"]/following-sibling::div//div/div/span/span[text()='"+aText+"']//parent::span//parent::div//parent::div/following-sibling::div/div/span)";
					break;	

				case "Talk2Bot":
					element="(//span[@class='simpleMsg' and contains(@msgdata,'"+aText+"')])";
					Timeofchat="(//span[@class='simpleMsg' and contains(@msgdata,'"+aText+"')]//parent::div//parent::div//parent::li/div[@class='extra-info'])";
					break;
					}
							
			String actualText=get_last_innertext(element);
			String actualTexttime=get_last_innertext(Timeofchat);
			String dateres =null;
			if (bot_typ.contains("whatsapp")) {
				dateres=date_chat_comp_whatsapp(actualTexttime);
			}else {
				dateres=date_chat_comp(actualTexttime);
				}

			   if(dateres.contains("Greater")||dateres.contains("Equal"))
			   {
			
			 System.out.println("The text is " +actualText);

			 if(actualText.contains(aText))
			 	{
				 System.out.println("The Keyword is found ");
				}else{
					Assert.fail(actualText+" Did not match expected.");
					throw new Exception("String is not Displayed!");
					
				}
			 }else{
					Assert.fail(" Chat date is not Greater than test start time ");
					throw new Exception("Chat date is not current date!");
					}
					
	    	}catch(Exception e) {
				e.printStackTrace();
	    	}
	}
	
	@Then("^Stored date '(.*)' compared from Channel type '(.*)' in expected format '(.*)'$")
	public static void compare_Stored_Msg(String hmap, String bot_typ, String expFormat) {
		try{
			String element = "";
			String aText=HashMapContainer.get(hmap);
			String dateformat=HashMapContainer.get(hmap+"dataformat");
			String aDate=Utilities.ConvertDateFormat(aText,dateformat, expFormat);
			//System.out.println("The text is " +aDate);
			switch(bot_typ){

				case "FB":
					element="(//*[@data-testid=\"message-container\"]/div[1]/div[1]/div[1]/span/div/div[1]/div/div)";
					break;

				case "Talk2Bot":
					element="(//span[@class='simpleMsg' and contains(text(),'"+aDate+"')])";
					break;
					}
			String actualText=get_last_innertext(element);

			 if(actualText.contains(aDate))
			 	{
				 System.out.println("The Date is found in given responce");
				}else{
					Assert.fail(actualText+" Did not contain "+aDate);
					throw new Exception(aDate+" String is not Displayed!");
					
				}
					
	    	}catch(Exception e) {
				e.printStackTrace();
	    	}
	}
	
	@Then("^I perfrom action Edit/Delete/Comment/Link a message/Link a scene in storyboard chat '(.*)'$")
	public static void click_eidt_comment(String action) {
		try{
		

			//action is a case sensetive.			
			String Action_element="//button[contains (text(),'"+action+"')]";
			@SuppressWarnings("static-access")
			By NE1=wrapFunc.setLocator("xpath", Action_element);
			wrapFunc.waitForElementPresence(NE1);
			driver.findElement(NE1).click();
	
			
	    	}catch(Exception e) {
				e.printStackTrace();
	    	}
	}
	
	
	@Then("^I click edit in storyboard chat last_0 or last-n'(.*)'$")
	public static void click_eidt(int act) {
		try{
		
			String ele = "//i[contains (@class,'bxpw-icon-config')]";
			@SuppressWarnings("static-access")
			By element=wrapFunc.setLocator("xpath", ele);

			int value = driver.findElements(element).size();
			String xp;
			if (act==0){
				xp="("+ele+")["+value+"]";
			}else {
				int Newval=value-act;
				xp="("+ele+")["+Newval+"]";
			}
			@SuppressWarnings("static-access")
			By NE=wrapFunc.setLocator("xpath", xp);
			wrapFunc.waitForElementPresence(NE);
			driver.findElement(NE).click();
			
	
			
	    	}catch(Exception e) {
				e.printStackTrace();
	    	}
	}

	@Then("^I compare user input message '(.*)' from Channel type '(.*)'$")
	public static void compare_user_Msg(String aText, String bot_typ) {
		try{
			String element = "";
			String Timeofchat="";
			switch(bot_typ){

				case "FB":
					element="";
					break;

				case "whatsapp":
					element="(//span[@aria-label=\"You:\"]/following-sibling::div//div/div/span/span[text()='"+aText+"'])";
					Timeofchat="(//span[@aria-label=\"You:\"]/following-sibling::div//div/div/span/span[text()='"+aText+"']//parent::span//parent::div//parent::div/following-sibling::div/div/span)";
					break;	
					
				case "Talk2Bot":
					element="(//div[@class='messageBubble']/div[contains(text(),'"+aText+"')])";
					Timeofchat="(//div[@class='messageBubble']/div[contains(text(),'"+aText+"')]//parent::div//parent::li/div[@class='extra-info'])";
					break;
					}
			
			String actualText=get_last_innertext(element);
			String actualTexttime=get_last_innertext(Timeofchat);
			String dateres=null;
			if (bot_typ.contains("whatsapp")) {
				dateres=date_chat_comp_whatsapp(actualTexttime);
			}else {
				dateres=date_chat_comp(actualTexttime);
				}

		   if(dateres.contains("Greater")||dateres.contains("Equal"))
		   {
			 System.out.println("The text is " +actualText);

			 if(actualText.contains(aText))
			 	{
				 System.out.println("The Keyword is found ");
				}else{
					Assert.fail(actualText+" Did not match expected.");
					throw new Exception("String is not Displayed!");
					
				}}else{
					Assert.fail(" Chat date is not Greater than test start time ");
					throw new Exception("Chat date is not current date!");}
					
	    	}catch(Exception e) {
				e.printStackTrace();
	    	}
	}
	
	//to split the given time string and compare with test start time.
	public static String date_chat_comp(String actualTexttime) {
		String dateres=null;
		try{

			String[] retval =util.string_split(actualTexttime, " at ");
			String part1 = retval[0];
			String part2 = retval[1];
			String ctime=part1+" "+part2;
			String Cvalue =null;
			Cvalue = HashMapContainer.get(Cvalue);
		    dateres=util.date_compare("E MMM dd yyyy h:mm:ss a",ctime,Cvalue);
					
	   	    	}catch(Exception e) 
				{
				e.printStackTrace();
	    	}
		return dateres;
		
	}
	
	public static String date_chat_comp_whatsapp(String actualTexttime) {
		String dateres=null;
		try{

			String Cvalue =null;
			Cvalue = HashMapContainer.get(Cvalue);
			String starttime=util.ConvertDateFormat(Cvalue, "E MMM dd yyyy h:mm:ss a", "kk:mm");
			dateres= util.date_compare("kk:mm", actualTexttime, starttime);

		
			}catch(Exception e) 
			{
			e.printStackTrace();
			}
		return dateres;
	}
	
	public static String get_last_innertext(String element) {
		String InnerText=null;
		try{

			int value = driver.findElements(By.xpath(element)).size();
			String xp=element+"["+value+"]";
			InnerText = driver.findElement(By.xpath(xp)).getAttribute("innerText");	
	   	    	
		   }catch(Exception e) 
				{
				e.printStackTrace();
	    	}
		return InnerText;
	}
	
	@Then("^I compare template header responces '(.*)' for Template type Quick/Button '(.*)'$")
	public static void Template_compare_header(String aText, String Temp_typ) {
		try{
			String element = "";
			String Timeofchat="";
			switch(Temp_typ){

				case "Quick":
					element="(//div[contains(text(),'"+aText+"') and @class='buttonTmplContentHeading quickReply'])";
					Timeofchat="(//div[contains(text(),'"+aText+"') and @class='buttonTmplContentHeading quickReply']//parent::div/div[@class='extra-info'])";
					break;

				case "Button":
					element="(//li[contains(text(),'"+aText+"') and @class='buttonTmplContentHeading'])";
					Timeofchat="(//li[contains(text(),'"+aText+"') and @class='buttonTmplContentHeading']//parent::ul//parent::div/div[@class='extra-info'])";
					break;
					}
								
			String actualText=get_last_innertext(element);
			String actualTexttime=get_last_innertext(Timeofchat);
			String dateres=date_chat_comp(actualTexttime);
			   if(dateres.contains("Greater")||dateres.contains("Equal"))
			   {
			
			 System.out.println("The text is " +actualText);

			 if(actualText.contains(aText))
			 	{
				 System.out.println("The Keyword is found ");
				}else{
					Assert.fail(actualText+" Did not match expected.");
					throw new Exception("String is not Displayed!");
					
				}
			 }else{
					Assert.fail(" Chat date is not Greater than test start time ");
					throw new Exception("Chat date is not current date!");
					}
					
	    	}catch(Exception e) {
				e.printStackTrace();
	    	}
	}
	
	//This method is to move to default window ,check the notification msg and close.It will switch back to Iframe
	@Then("^I compare notify msg '(.*)' and switch back to iframeID '(.*)'$")
	public static void validate_conf_msg(String Msg,String Iframeid) {
		String locator="xpath,//span[@class='noty_text']/div/div[2]";
		String close="xpath,//span[@class='noty_text']/div/i[@class='btx-close']";
		String Ab="Ab";
		String Ad="Ad";
		String storedValue = HashMapContainer.getPO(Ab);
		if (storedValue==null) {
		HashMapContainer.addPO("Ab", locator.toString().trim());
		HashMapContainer.addPO("Ad", close.toString().trim());}
		try{
			Comstp.I_switchTo_MainWindow();
			Comstp.I_pause_for_seconds(1);
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(Ab));
			String actualText = driver.findElement(GetPageObject.OR_GetElement(Ab)).getText();
			System.out.println("The text is " +actualText);
			WrapperFunctions.highLightElement(driver.findElement(GetPageObject.OR_GetElement(Ab)));
			StepBase.embedScreenshot();
			Comstp.I_mouse_over_click(Ad);
			Comstp.I_switchTo_iFrame(Iframeid);
			//Assert.assertTrue(actualText.contains(Msg));
		   }catch(Exception e) 
				{
				e.printStackTrace();
	    	}
		}
	//Compare any response given from the bot response
	@Then("^I compare any one of the response from Bot$")
	public void i_compare_anyone_of_msg_response(DataTable dt) {
		String element="";
		String Timeofchat="";
		String match="";
		try{
			
			List<String> list = dt.asList(String.class);
			//System.out.println("list size is : "+list.size());
		
			for(int k=0; k<list.size(); k++) { 
			
					String Value=list.get(k);
					element="(//span[@class='simpleMsg'])";
					String actualText=get_last_innertext(element);
						
					if(actualText.contains(Value))
						{
							match="yes";
							System.out.println("Match is : "+actualText);
							Timeofchat="(//span[@class='simpleMsg' and contains(@msgdata,'"+actualText+"')]//parent::div//parent::div//parent::li/div[@class='extra-info'])";
							String actualTexttime=get_last_innertext(Timeofchat);
							String dateres=date_chat_comp(actualTexttime);
							if(dateres.contains("Greater")||dateres.contains("Equal"))
								{
								System.out.println("The chat date is greater " +actualTexttime);
								}else{
								Assert.fail(" Chat date is not Greater than test start time ");
								throw new Exception("Chat date is not current date!");
								}
				
							break;
						}	

				}
			if(match!="yes") {
				Assert.fail(" Bot responce did not match ");
				throw new Exception("Bot responce did not match!");
			}
		}catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);	
		}
	}
	
	@Then("^I wait '(.*)' sec for chat massage to load in Bot$")
	public static void wait_for_chat_msg_toload(int time) {
	
		try{
			String element="xpath,//div[@class='typingIndicatorContent' and contains(@style,'block')]";
			String Chat_msg_wait_load="Chat_msg_wait_load";
			String storedValue = HashMapContainer.getPO(Chat_msg_wait_load);
			if (storedValue==null) {
				HashMapContainer.addPO("Chat_msg_wait_load", element.toString().trim());
			}
			
			for (int i=0; i<time; i++){
				
			Boolean elem= driver.findElements(GetPageObject.OR_GetElement(Chat_msg_wait_load)).size() > 0;
			
			if(elem){
				Thread.sleep(1000);
				
			}else{
				System.out.println("Element Not displayed");
				break;
				}
			}
	   	    	
		   }catch(Exception e) 
				{
				e.printStackTrace();
	    	}
	
	}
	
	@Then("^I get innertext of random gentext '(.*)' and store in '(.*)'$")
	public static void I_get_innertext_gentext_exist(String element, String name){
			try{
				String value = HashMapContainer.get(element).toLowerCase( );
				String DXpath="//*[contains(text(),'"+value+"')]";
				String InnerText = driver.findElement(By.xpath(DXpath)).getAttribute("innerText");	
				HashMapContainer.add(name, InnerText.toString().trim());
		
					}catch(Exception e) {
				e.printStackTrace();
				
			}
		}
	@Then("^I enter OTP value from stored text '(.*)'$")
	public static void Enter_OTP(String hasmap) {
		try {
			   String xpath="(//input[contains(@class,'koreOtpInput')])";
			   String OTP = HashMapContainer.get(hasmap).toLowerCase( );
			   String[] retval =util.string_split(OTP, " - ");
			   String part1 = retval[0];
			   String part2 = retval[1];
			   String value=part1+part2;
			   char[] chars=value.toCharArray();

			   for (int i=0; i<chars.length; i++) {
			   char text=value.charAt(i);
			   String values=String.valueOf(text);
			   int j=i+1;
			   String element=xpath+"["+j+"]";
			   driver.findElement(By.xpath(element)).sendKeys(values);

				}
		}catch(Exception e) {
			e.printStackTrace();
			
		}
	}
	
	@Then("^I compare button template responces message '(.*)' and click/onlycompare '(.*)'$")
	public static void compare_button_temp_Msg(String aText,String action) {
		try{

			String element="(//li[contains(text(),'"+aText+"') and @class='buttonTmplContentChild'])";
			String Timeofchat="(//li[contains(text(),'"+aText+"') and @class='buttonTmplContentChild']//parent::ul//parent::div/div[@class='extra-info'])";
					
			String actualText=get_last_innertext(element);
			String actualTexttime=get_last_innertext(Timeofchat);
			String dateres=date_chat_comp(actualTexttime);
			   if(dateres.contains("Greater")||dateres.contains("Equal"))
			   {
			
			 System.out.println("The text is " +actualText);

			 if(actualText.contains(aText))
			 	{
				 if(action.contains("click"))
				 {
					 String click=click_last_innertext_index(element);
					 if (!click.contains("done"))
							 {
						 throw new Exception("Unable to click the element");
							 }
							 
				 }
				 System.out.println("The Keyword is found ");
				}else{
					Assert.fail(actualText+" Did not match expected.");
					throw new Exception("String is not Displayed!");
					
				}
			 }else{
					Assert.fail(" Chat date is not Greater than test start time ");
					throw new Exception("Chat date is not current date!");
					}
					
	    	}catch(Exception e) {
				e.printStackTrace();
	    	}
	}
	
	public static String click_last_innertext_index(String element) {
		String click_action=null;
		try{

			int value = driver.findElements(By.xpath(element)).size();
			String xp=element+"["+value+"]";
			 driver.findElement(By.xpath(xp)).click();	
			 click_action ="done";
	   	    	
		   }catch(Exception e) 
				{
				e.printStackTrace();
	    	}
		return click_action;
	}
	@Then("^I login in to Kore with username '(.*)' and password '(.*)'$")
	public static void I_Login_kore(String uname, String Pword) {
		 String user_ele="xpath, //input[@name='emailPhone']";
		 String pword_ele="xpath, //input[@placeholder='Password']";
		 String Log_ele="xpath, //button/span[text()='Login']";
		 String Continue_e="xpath, //button[@class='continueBtn']";
		 String search_e="xpath, //span[contains(@class,'botSearch')]";
		 String Logo_e="xpath, //img[@class='logoIcon']";
		 HashMapContainer.addPO("username_ele", user_ele.toString().trim());
		 HashMapContainer.addPO("password_ele", pword_ele.toString().trim());
		 HashMapContainer.addPO("Login_ele", Log_ele.toString().trim());
		 HashMapContainer.addPO("Continue_ele", Continue_e.toString().trim());
		 HashMapContainer.addPO("search_ele", search_e.toString().trim());
		 HashMapContainer.addPO("Logo_ele", Logo_e.toString().trim());
		 
		
		try {
        	Comstp.waitForPageLoaded();
        	Comstp.I_pause_for_seconds(5);
            Comstp.I_should_see_element_Visible("username_ele");
            Comstp.I_should_see_element_Visible("Continue_ele");
            Comstp.I_enter_in_field(uname, "username_ele");
            Comstp. I_click("Continue_ele");
            Comstp.I_should_see_element_Visible("password_ele");
            Comstp.I_enter_in_field(Pword, "password_ele");
            Comstp.I_wait_for_Element_clickable(5,"Login_ele");
            Comstp. I_click("Login_ele");
            Comstp.waitForPageLoaded();
            Comstp.I_should_see_element_Visible("Logo_ele");
            Comstp.I_should_see_element_Visible("search_ele");

		}catch(Exception e) {
			e.printStackTrace();
			
		}
	}


	
}
