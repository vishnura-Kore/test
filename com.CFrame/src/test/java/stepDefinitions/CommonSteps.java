package stepDefinitions;

import framework.FrameworkExceptions;
import framework.HashMapContainer;
import framework.StepBase;
//import cucumber.runtime.CucumberException;
import io.cucumber.core.exception.CucumberException;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.Point;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.WindowType;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.events.EventFiringWebDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.gargoylesoftware.htmlunit.ElementNotFoundException;
import framework.Utilities;
import framework.WrapperFunctions;
import pageObjects.GetPageObject;
//import cucumber.api.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.cucumber.java.en.And;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
//import org.testng.Assert;
import org.junit.Assert;
import framework.SQLConnector;


import ru.yandex.qatools.ashot.AShot;
import ru.yandex.qatools.ashot.Screenshot;
import ru.yandex.qatools.ashot.comparison.ImageDiff;
import ru.yandex.qatools.ashot.comparison.ImageDiffer;
/**
 * @ScriptName : Utilities
 * @Description : This class contains Commonly used Keyword for Web
 *              application automation using Cucumber framework
 * 
 */
public class CommonSteps {

	static WrapperFunctions wrapFunc = new WrapperFunctions();
	static StepBase sb = new StepBase();
	
	public static WebDriver driver;
	static Utilities util = new Utilities();
	static SQLConnector SQLC= new SQLConnector();
	private static BufferedImage bufferedImage;
	private static byte[] imageInByte;
	

	@Given("^My WebApp '(.*)' is open$")
	public static void my_webapp_is_open(String url) throws Exception {
		try {			
			driver = sb.getDriver();
			System.out.println("Driver value: "+driver);
			driver.get(GetPageObject.OR_GetURL(url));
			wrapFunc.waitForPageToLoad();
			//To save Test start time and save in hahmap
			   String currentdate=util.Date_system("E MMM dd yyyy h:mm:ss a");
			   String teststarttime=null;
			   HashMapContainer.add(teststarttime, currentdate);
			   
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	//To clear hashmap and load the page object
	@Then("^I load page object '(.*)'$")
	public static void I_load_page_object(String PageOB) throws Exception {
		try {			
			I_Clear_hasmap();
			GetPageObject.OR_Load_Page_object(PageOB);
			wrapFunc.waitForPageToLoad();
			//To save Test start time and save in hahmap
			String currentdate=util.Date_system("E MMM dd yyyy h:mm:ss a");
			String teststarttime=null;
			HashMapContainer.add(teststarttime, currentdate);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}



	@Then("^I navigate to '(.*)' page$")
	public static void I_NavigateTo(String urlt){
		try{
			//driver.navigate().to(HashMapContainer.getPO(url));
			String[] urlParameter = HashMapContainer.getPO(urlt).split(",");
			String url = urlParameter[1];
			driver.get(url);
		}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}



	@Then("^I enter '(.*)' in field '(.*)'$")
	public static void I_enter_in_field(String value, String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			I_clear_Field(element);
						
			if(value.length()>1){
				if(value.substring(0,2).equals("$$"))
				{
					
					value = HashMapContainer.get(value);
				}
			}
			driver.findElement(GetPageObject.OR_GetElement(element)).sendKeys(value);
			// TODO Dismiss keyboard for webView
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	@Then("^I clear field '(.*)'$")
	public static void I_clear_Field(String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			driver.findElement(GetPageObject.OR_GetElement(element)).sendKeys(Keys.CONTROL,"a",Keys.BACK_SPACE);
			driver.findElement(GetPageObject.OR_GetElement(element)).clear();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}


	@Then("^I hit enter-key on element '(.*)'$")
	public static void I_hit_key_on_element(String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			driver.findElement(GetPageObject.OR_GetElement(element)).sendKeys(Keys.ENTER);
			// TODO Dismiss keyboard for webView
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	@Then("^I compare JS field_ID '(.*)' text '(.*)'$")
	public static void I_compare_JS_field_text(String field, String text)
	{
		try{
		JavascriptExecutor js=(JavascriptExecutor)driver;
		String fname=(String)js.executeScript("return document.getElementById('"+field+"').value");
		Assert.assertEquals(text,fname);
		}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I mouse over '(.*)'$")
	public static void I_mouse_over(String element){
		try{
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			Actions action = new Actions(driver);
			WebElement we = driver.findElement(GetPageObject.OR_GetElement(element));
			action.moveToElement(we).build().perform();
		}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	@Then("^I mouse over and right click '(.*)' and click '(.*)'$")
	public static void I_mouse_over_and_click(String element, String menu){
		try{
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			Actions action = new Actions(driver);
			WebElement we = driver.findElement(GetPageObject.OR_GetElement(element));
			action.moveToElement(we).build().perform();
			action.contextClick(we).contextClick().perform();
			WebElement CC=driver.findElement(GetPageObject.OR_GetElement(menu));
			CC.click();
			
		}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
		
	@Then("^I right click '(.*)'$")
	public static void I_right_click(String element){
		try{
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			Actions action = new Actions(driver);
			WebElement we = driver.findElement(GetPageObject.OR_GetElement(element));
			action.contextClick(we).contextClick().perform();
			
		}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	@Then("^I verify tool tip message '(.*)' for element '(.*)'$")
	public static void I_Verify_ToolTip_Message(String message,String element){
		try{
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			WebElement we = driver.findElement(GetPageObject.OR_GetElement(element));
			/*Actions action = new Actions(driver);
			WebElement we = driver.findElement(GetPageObject.OR_GetElement(element));
			action.moveToElement(we).build().perform();
			 */
			String ToolTipMessage = we.getAttribute("title");
			Assert.assertEquals(ToolTipMessage, message);
		}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	@Then("^I verify value '(.*)' in field '(.*)'$")
	public static void I_Verify_value_inField(String value, String element){
		try{
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			String ActualValue = driver.findElement(GetPageObject.OR_GetElement(element)).getAttribute("value");
			Assert.assertEquals("Actual value does not match the expected value in specified field!",value,ActualValue);
		}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	@Then("^I verify element '(.*)' is disabled$")
	public static void I_Verify_Element_isDisabled(String element){
		try{
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			WebElement elem = driver.findElement(GetPageObject.OR_GetElement(element));
			if(elem.isEnabled()){
				StepBase.embedScreenshot();
				Assert.fail("Element is enabled!!"+element);
				throw new Exception("Element is enabled!");
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}



	@Given("^I click '(.*)'$")
	public static void I_click(String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			driver.findElement(GetPageObject.OR_GetElement(element)).click();
			//StepBase.embedScreenshot();
			wrapFunc.waitForPageToLoad();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}



	@Given("^I click link '(.*)'$")
	public static void I_click_link(String linkText) {
		try {
			
			driver.findElement(By.linkText(linkText)).click();
			wrapFunc.waitForPageToLoad();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}


	@Then("^I click by JS '(.*)'$")
	public static void I_clickJS(String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			System.out.println(driver.findElement(GetPageObject.OR_GetElement(element)).isEnabled());
			System.out.println(driver.findElement(GetPageObject.OR_GetElement(element)).isDisplayed());
			wrapFunc.clickByJS(GetPageObject.OR_GetElement(element));
			StepBase.embedScreenshot();
			wrapFunc.waitForPageToLoad();

		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	


	@Then("^I create the request query '(.*)'$")
	public static void I_Create_Request(String element) {

		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			WebElement x = driver.findElement(GetPageObject.OR_GetElement(element));
			if(x.isDisplayed()){
				WrapperFunctions.highLightElement(driver.findElement(GetPageObject.OR_GetElement(element)));
			}else{
				throw new Exception("Element is not found!");
			}

		} catch (Exception e) {
			e.printStackTrace();
			StepBase.embedScreenshot();
			System.out.println("Element is not found");
			throw new ElementNotFoundException(element, "", "");
		}
	}


	@Then("^I should see element '(.*)' present on page$")
	public static void I_should_see_on_page(String element) {

		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			Boolean elementexist= driver.findElements(GetPageObject.OR_GetElement(element)).size() > 0;
			WebElement x = driver.findElement(GetPageObject.OR_GetElement(element));
			if(elementexist){
				WrapperFunctions.highLightElement(driver.findElement(GetPageObject.OR_GetElement(element)));
			}else{
				StepBase.embedScreenshot();
				Assert.fail("Element is not found on page!"+element);
				throw new Exception("Element is not found! :"+element);
			}

		} catch (Exception e) {
			e.printStackTrace();
			StepBase.embedScreenshot();
			System.out.println("Element is not found! :"+element);
			throw new ElementNotFoundException(element, "", "");
		}
	}

	@Then("^I should see element '(.*)' present on page_$")
	public static void I_should_see_on_page_AndScreenshot(String element) {

		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			Boolean elementexist= driver.findElements(GetPageObject.OR_GetElement(element)).size() > 0;
			WebElement x = driver.findElement(GetPageObject.OR_GetElement(element));
			if(elementexist){
				WrapperFunctions.highLightElement(driver.findElement(GetPageObject.OR_GetElement(element)));
				StepBase.embedScreenshot();
			}else{
				StepBase.embedScreenshot();
				Assert.fail("Element is not found on page!"+element);
				throw new Exception("Element is not found!");
			}

		} catch (Exception e) {
			e.printStackTrace();
			StepBase.embedScreenshot();
			System.out.println("Element is not found");
			throw new ElementNotFoundException(element, "", "");
		}
	}

	@Then("^I should not see element '(.*)' present on page$")
	public static void I_should_not_see_on_page(String element) throws Exception{

		try {
			Boolean elementexist= driver.findElements(GetPageObject.OR_GetElement(element)).size() > 0;
			System.out.println("Element is displayed: " +elementexist);
			if(elementexist){
				StepBase.embedScreenshot();
				WrapperFunctions.highLightElement(driver.findElement(GetPageObject.OR_GetElement(element)));
				Assert.fail("Element is found on page!"+element);
				throw new Exception("Element is found on page!");
			}else{
				System.out.println("Element is not displayed");
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Element is found on Page!");
		}
	}

	@Then("^I should see text '(.*)' present on page$")
	public static void I_should_see_text_present_on_page(String expectedText) {
		try {
			if (driver.getPageSource().contains(expectedText)) {
				System.out.println("Text " + expectedText + " found on page!");
				StepBase.embedScreenshot();
			} else {
				throw new ElementNotFoundException(expectedText, " ", " ");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ElementNotFoundException(expectedText, " ", " ");
		}
	}

	

	@Then("^I click submenu '(.*)' from '(.*)'$")
	// enter linktext of "submenu" from "Mainmenu"
	public static void clickSubMenuItem(String submenulinktext,String mainmenulinktext) {
		try {
			
			Actions action = new Actions(driver);
			WebElement menu = driver.findElement(GetPageObject.OR_GetElement(mainmenulinktext));
			action.moveToElement(menu).click().build().perform();
			WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
			WebElement sub_menu = driver.findElement(GetPageObject.OR_GetElement(submenulinktext));
			wait.until(ExpectedConditions.visibilityOf(sub_menu));

			action.moveToElement(sub_menu).click().build().perform();
		} catch (Exception e) {

			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}

	}
	
	@Then("^I verify count submenu from '(.*)' and compare value'(.*)'$")
	public void I_verify_count_subMenu(String mainmenutext, int nomenuvalue){
			List<WebElement> submenuitems = new ArrayList<WebElement>();
			try {
				submenuitems = driver
						.findElements(By.xpath("//*[text()='" + mainmenutext + "'" + "]//following::ul[1]//a"));
				int itemval=submenuitems.size();
				Assert.assertEquals(nomenuvalue, itemval);
						
			} catch (Exception e) {

				e.printStackTrace();
				throw new CucumberException(e.getMessage(), e);
			}
			
		}
		

	
	@Then("^I verify checkbox '(.*)' is '(.*)'$")
	public static void I_verify_checkBox_is_Checked(String checkbox, String status) {
		try {

			if(status.equalsIgnoreCase("checked")){
				if (!driver.findElement(GetPageObject.OR_GetElement(checkbox)).isSelected()) {
					throw new Exception("Specified Checkbox is not checked!");
				}	
			}else if(status.equalsIgnoreCase("unchecked")){
				if (driver.findElement(GetPageObject.OR_GetElement(checkbox)).isSelected()) {
					throw new Exception("Specified Checkbox is checked!");
				}	
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}


	@Then("^I switch to iFrame '(.*)'$")
	public static void I_switchTo_iFrame(String FrameID) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(FrameID));
			WebElement frame = driver.findElement(GetPageObject.OR_GetElement(FrameID));
			driver.switchTo().frame(frame);
			StepBase.embedScreenshot();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}

	}

	@Then("^I switch to default content$")
	public static void I_switchTo_DefaultContent() {
		try {
			driver.switchTo().defaultContent();
			StepBase.embedScreenshot();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}

	}

	@Then("^I switch back to default content$")
	public static void I_switchTo_MainWindow() {
		try {
			driver.switchTo().window(driver.getWindowHandle());
			StepBase.embedScreenshot();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}

	}

	@Then("^I should see text '(.*)' present on page at '(.*)'$")
	public static void I_should_see_text_present_on_page_At(String expectedText, String location) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(location));
			//WebElement we = driver.findElement(GetPageObject.OR_GetElement(location));
			String actualText = driver.findElement(GetPageObject.OR_GetElement(location)).getText();
			WrapperFunctions.highLightElement(driver.findElement(GetPageObject.OR_GetElement(location)));
			Assert.assertEquals(actualText, expectedText);
			StepBase.embedScreenshot();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}

	}

	@Then("^I should see text matching regx '(.*)' present on page at '(.*)'$")
	public static void I_should_see_text_matching_regularExpression(String regx, String location) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(location));
			String actualText = driver.findElement(GetPageObject.OR_GetElement(location)).getText();
			Assert.assertEquals(actualText.matches(regx),"Actual Text Found: "+actualText+"|");
			StepBase.embedScreenshot();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}

	}

	@Then("^I wait '(.*)' seconds for presence of element '(.*)'$")
	public static void I_wait_for_presence_of_element(int seconds, String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element), seconds);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	@Then("^I wait for '(.*)' seconds$")
	public static void I_pause_for_seconds(int seconds) {
		try {
			Thread.sleep(seconds * 1000);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}


	@Then("^I switch to window with title '(.*)'$")
	public static void I_switch_to_window_with_title(String title) {
		try {
			wrapFunc.switchToWindowUsingTitle(title);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}

	}

	@Then("^I select option '(.*)' in dropdown '(.*)' by '(.*)'$")
	public static void I_select_option_in_dd_by(String option, String element, String optionType) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			wrapFunc.selectDropDownOption(GetPageObject.OR_GetElement(element), option, optionType);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I scroll to '(.*)' - '(.*)'$")
	//When Horizontal is used, kindly provide the element [class=\"ag-body-viewport\"] as xpath or id.
	public static void I_scroll_to_element(String scrolltype, String element) {
		try {
			wrapFunc.scroll(scrolltype, element);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	@Then("^I scroll through page$")
	public static void I_scroll_thru_page() {
		try {
			for(int i=0;i<=16;i++){
				wrapFunc.scroll("coordinates", "0,200");
				Thread.sleep(1000);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	
	@Then("^I get text from '(.*)' and store$")
	public static void I_get_text_from(String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			String value = driver.findElement(GetPageObject.OR_GetElement(element)).getText();
			HashMapContainer.add(element, value);
			//System.out.println("text is =" +value);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	@Then("^I compare '(.*)' with stored value '(.*)'$")
	public static void I_compare_with_StoredValue(String element, String storedValue) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			String actualValue = driver.findElement(GetPageObject.OR_GetElement(element)).getText();
			storedValue = HashMapContainer.get(storedValue);
			Assert.assertEquals("I Compare "+actualValue+" with expected value "+storedValue,storedValue,actualValue);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	@Then("^I verify element '(.*)' is displayed$")
	public static void I_Verify_Element_isDisplayed(String element){
		try{
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			WebElement elem = driver.findElement(GetPageObject.OR_GetElement(element));
			if(elem.isDisplayed()){
				System.out.println("Element is displayed");
				Assert.assertTrue(true);
			}else{
				Assert.fail("Element is notDisplayed! :"+element);
				throw new Exception("Element is notDisplayed!");
				
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	

    @Then("^I verify screenshot to Baseline of page '(.*)'$")
    public static void I_verify_Screenshot_toBaselined(String ImageBaseline)throws Exception{
          try{
  		   //checking for BaseImg_capture is True/False.
  			String BC= System.getProperty("test.BaseImg_capture");
  			if(BC!="True")
  			{
                 File f1 = new File(Utilities.takeScreenshot(driver));
                 System.out.println("ActualSS Path: "+f1);
                 File f2 = new File((System.getProperty("user.dir")+"/BaselineImg/"+ImageBaseline+".png"));
                 Float PercentageVariation = Utilities.compareImage(f1,f2);
                 System.out.println("% of variation in image comparison with Baseline image: "+PercentageVariation+"%");
                 if (PercentageVariation>1.0){
                        BufferedImage img1 = ImageIO.read(f1);
                        BufferedImage img2 = ImageIO.read(f2);
                        BufferedImage bufferedImage = Utilities.getDifferenceImage(img1,img2);
                        //bufferedImage = Utilities.getDifferenceImage(f1,f2);
                        ByteArrayOutputStream baos = new ByteArrayOutputStream();
                        ImageIO.write(bufferedImage, "png", baos);
                        baos.flush();
                        imageInByte = baos.toByteArray();
                        baos.close();
                        throw new Exception("Compared images do not match! and has "+PercentageVariation+" % of Variation");
                 }
           }else 
           {
        	   Screenshot_of_page(ImageBaseline);
           }
          }catch(Exception e){
                 e.printStackTrace();
                 StepBase.embedProvidedScreenshot(imageInByte);
                 throw new CucumberException(e.getMessage(),e);
          }
    }




	@Then("^I close browser$")
	public static void I_Close_Browser() {
		try {
			driver.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then ("^I wait '(.*)' secs for Element '(.*)' be clickable$")
	public static void I_wait_for_Element_clickable(int seconds,String element){
		try{
		wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
		wrapFunc.waitForElementToBeClickable(GetPageObject.OR_GetElement(element),seconds * 1000);
		}catch(Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
				
	}
	
	@Then("^I select value '(.*)' from multi select RJS combobox '(.*)'$")
	public static void I_select_value_from_multi_select_RJS_combobox(String Value,String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			Actions action = new Actions(driver);
			driver.findElement(GetPageObject.OR_GetElement(element)).click();
			WebElement Select_input = driver.findElement(GetPageObject.OR_GetElement(element));
			action.sendKeys(Select_input, Value).click().build().perform();
			action.sendKeys(Keys.TAB).click().build().perform();
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I send key pageUp/pageDown/ESC/Enter/Tab '(.*)'$")
	public static void I_send_key(String key) {
		try {
			wrapFunc.sendkey(key);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	//The Element is saved has Key, value pair.
	@Then("^I enter value with Random email/string/number '(.*)' in field '(.*)'$")
	public static void I_enter_value_with_Random_in_field(String value, String element) {
		
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			driver.findElement(GetPageObject.OR_GetElement(element)).clear();				
			String Relement=wrapFunc.generateRandom(value);
			System.out.println(Relement);
			driver.findElement(GetPageObject.OR_GetElement(element)).sendKeys(Relement);
			HashMapContainer.add(element, Relement);

			// TODO Dismiss keyboard for webView
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	

	/*//Element value is the name of the element in creating random value.Its Key ,value pair.

/*	//Element value is the name of the element in creating random value.Its Key ,value pair.

	@Then("^I like enter saved random element value '(.*)' in field '(.*)'$")
	public static void I_like_enter_saved_random_in_field(String Relement, String element) {
			try {
				wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
				driver.findElement(GetPageObject.OR_GetElement(element)).clear();

				String value = HashMapContainer.get(Relement);
				System.out.println(value);

				driver.findElement(GetPageObject.OR_GetElement(element)).sendKeys(value);
				

				// TODO Dismiss keyboard for webView
			} catch (Exception e) {
				e.printStackTrace();
				throw new CucumberException(e.getMessage(), e);
			}
		}*/

	
    //Element value is the name of the element in creating random value.Its Key ,value pair.
    @Then("^I like enter saved random element value '(.*)' in field '(.*)' which is Input/Dropdown/Multi '(.*)'$")
    public static void I_like_enter_saved_random_in_field_to_Input_dropdown(String Relement, String element,String type) {
                        try {
                               wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
                              String value = HashMapContainer.get(Relement);
                              System.out.println(value);
                              switch(type){
                                     case "Input":
                                            driver.findElement(GetPageObject.OR_GetElement(element)).clear();
                                         driver.findElement(GetPageObject.OR_GetElement(element)).sendKeys(value);
                                            break;
                                     case "Dropdown":
                                            String optionType="Text";
                                            I_select_option_in_dd_by(value,element,optionType);
                                            break;
									case "Multi":
											I_select_value_from_multi_select_RJS_combobox(value,element);
											break;
                              }
                              // TODO Dismiss keyboard for webView
                        } catch (Exception e) {
                              e.printStackTrace();
                              throw new CucumberException(e.getMessage(), e);
                        }
                 }


	

	//To focus on Input element
	@Then("^I focus on element '(.*)'$")
	public static void I_focus_on_element(String element){
		try{
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			Actions action = new Actions(driver);
			WebElement we = driver.findElement(GetPageObject.OR_GetElement(element));
			we.sendKeys("");
			action.moveToElement(we).click().build().perform();
			}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	

	
	@Then("^I zoom the screen '(.*)'$")
	public static void I_zoom_the_screen(int percentage ){
		try{
			WrapperFunctions.zoom_window(percentage);
			I_pause_for_seconds(2);

				}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@Then("^I septup DB connection type oracle/mysql '(.*)' DBurl '(.*)' and DBusername '(.*)' and DBPassword '(.*)'$")
	public void I_septup_DB_connection(String DB_type,String dbUrl,String username,String password) throws ClassNotFoundException, SQLException{
		try{
		SQLC.DB_setUp(DB_type,dbUrl,username,password);
		System. out.println("Connection success.");
		}catch(Exception e) {
			e.printStackTrace();
			}
	}
	
	@Then("^I close DB connection$")
	public void DB_Close() throws ClassNotFoundException, SQLException{
		try{
		SQLC.DB_close_Down();
		}catch(Exception e) {
			e.printStackTrace();
			}	
	}
	
	@Then("^I send query '(.*)' and compare value '(.*)'$")
	public void I_send_query(String Query,String Value) throws ClassNotFoundException, SQLException{
		try{
		ResultSet QRS=SQLC.SendDB_Query(Query);
		while (QRS.next()){
    		String Qvalue = QRS.getString(1);								        		                               
            System. out.println("Query Value = "+Qvalue);
            Assert.assertEquals(Qvalue,Value, "I Compare "+Qvalue+" with expected value "+Value);
			}
		}catch(Exception e) {
			e.printStackTrace();
			}
		}


	@Then("^I click random gentext '(.*)'$")
	public static void I_click_random_gentext(String element){
			try{
				String value = HashMapContainer.get(element);
				String DXpath="//*[text()='"+value+"']";
				driver.findElement(By.xpath(DXpath)).click();
				System.out.println("Text " + value + " has been clicked");
		
					}catch(Exception e) {
				e.printStackTrace();
				System.out.println("Text to click has been not found!");
			}
		}


	

	@Then("^I should not see text '(.*)' present on page$")
	public static void I_should_not_see_text_present_on_page(String expectedText) {
		try {
			if (driver.getPageSource().contains(expectedText))
			{
				FrameworkExceptions exp = new FrameworkExceptions("Text " + expectedText + " is found on the page"); 
	                    throw exp; 
			} else {
				System.out.println("Text " + expectedText + " Not found on page!");
				StepBase.embedScreenshot();
			}
		} catch (FrameworkExceptions e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
			
		}
	}
	
	@Then("^I wait for Page to Load$")
	 public static void waitForPageLoaded() {
		wrapFunc.waitForPageToLoad();
	    }
	
	@Then("^I compare '(.*)' with given value '(.*)'$")
	public static void I_compare_with_GivenValue(String element, String givenValue) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			String actualValue = driver.findElement(GetPageObject.OR_GetElement(element)).getText();
			Assert.assertEquals("I Compare "+actualValue+" with expected value "+givenValue,givenValue,actualValue);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I double click '(.*)'$")
	public static void double_click(String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			wrapFunc.doubleClick(GetPageObject.OR_GetElement(element));
			//StepBase.embedScreenshot();
			wrapFunc.waitForPageToLoad();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	//To Capture icon.
	@Then("^I capture element Image '(.*)' and compare in baseline img path '(.*)'$")
	public static void I_capture_element_image(String element,String ImageBaseline) throws IOException{
		try {  
		final BufferedImage img;
		  final Point topleft;
		  final Point bottomright;
		  final byte[] screengrab;
		  File screenshotLocation = new File(Utilities.takeScreenshot(driver));
		  File expectedImg = new File((System.getProperty("user.dir")+"/BaselineImg/"+ImageBaseline));
		  WebElement e = driver.findElement(GetPageObject.OR_GetElement(element));
		  screengrab = ((TakesScreenshot) driver).getScreenshotAs(OutputType.BYTES);
		  img = ImageIO.read(new ByteArrayInputStream(screengrab));
		  topleft = e.getLocation();
		  bottomright = new Point(e.getSize().getWidth(), e.getSize().getHeight());
		  BufferedImage imgScreenshot= 
		      (BufferedImage)img.getSubimage(topleft.getX(), topleft.getY(), bottomright.getX(), bottomright.getY());
		  ImageIO.write(imgScreenshot, "png", screenshotLocation);
		  
		  Float PercentageVariation = Utilities.compareImage(screenshotLocation,expectedImg);
			System.out.println("% of variation in image comparison with Baseline image: "+PercentageVariation+"%");
			if (PercentageVariation!=1.0){	
				BufferedImage img1 = ImageIO.read(screenshotLocation);
				BufferedImage img2 = ImageIO.read(expectedImg);
				BufferedImage bufferedImage = Utilities.getDifferenceImage(img1,img2);					
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				ImageIO.write(bufferedImage, "png", baos);
				baos.flush();
				imageInByte = baos.toByteArray();
				baos.close();
			throw new Exception("Compared images do not match! and has "+PercentageVariation+" % of Variation");
			}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				StepBase.embedProvidedScreenshot(imageInByte);
				throw new CucumberException(e.getMessage(),e);
			}
		 }

	@Then("^I check random gentext exist '(.*)'$")
	public static void I_check_random_gentext_exist(String element){
			try{
				String value = HashMapContainer.get(element);
				String DXpath="//*[text()='"+value+"']";
				driver.findElement(By.xpath(DXpath)).isDisplayed();
				System.out.println("Text " + value + " has been Exist");
		
					}catch(Exception e) {
				e.printStackTrace();
				System.out.println("Text to click has been not found!");
			}
		}
	

	@Then("^I clear hashmap$")
	public static void I_Clear_hasmap() {
	try {
		HashMapContainer.ClearHM();
	} catch (Exception e) {
		e.printStackTrace();
		throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I wait for '(.*)' sec untill element not displayed '(.*)'$")
	public static void I_wait_Element_is_not_Displayed(int time,String element){
		try{
			for (int i=0; i<time; i++){
				wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			Boolean elem= driver.findElements(GetPageObject.OR_GetElement(element)).size() > 0;
			
			if(elem){
				Thread.sleep(2000);
				//i++;
				
			}else{
				System.out.println("Element Not displayed");
				break;
				}
			}
		}catch(Exception e){
			//e.printStackTrace();
			//throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I select value '(.*)' from multi select RJS Dropdown '(.*)'$")
	public static void I_select_value_from_multi_select_RJS_Dropdown(String Value,String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			Actions action = new Actions(driver);
			driver.findElement(GetPageObject.OR_GetElement(element)).click();
			WebElement Select_input = driver.findElement(GetPageObject.OR_GetElement(element));
			//action.sendKeys(Select_input, Value).click().build().perform();
			Select_input.sendKeys(Value);
			action.sendKeys(Keys.ENTER).click().build().perform();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I Refresh the page$")
	public static void I_Refresh() {
		try {
			driver.navigate().refresh();
			waitForPageLoaded();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	@Then("^I scroll horizontal bar '(.*)' untill the element '(.*)'$")
	public static void I_scroll_horizontal_end(String target,String element) throws Exception {
   
	  try{
		int x_cordinate=700;
		EventFiringWebDriver test= new EventFiringWebDriver(driver);
		String[] Scroll_Ele = HashMapContainer.getPO(target).split(",");
		String Element_scroll = Scroll_Ele[1];
		for(int i=0;i<=16;i++){
			Boolean elementexist= driver.findElements(GetPageObject.OR_GetElement(element)).size() > 0;
			//System.out.println("Element is displayed: " +elementexist);
			if(elementexist){
				StepBase.embedScreenshot();
				System.out.println("Element is displayed");
				break;
			}else{
				test.executeScript("document.querySelector('"+Element_scroll+"').scrollLeft="+x_cordinate);
			    x_cordinate=x_cordinate+500;
			    //System.out.println(x_cordinate);
			    Thread.sleep(1000);
				
			    if (i==16){
			    	System.out.println("Element is not displayed");
			    	Assert.fail("Element is not displayed :");
			    	throw new Exception("Element Not found on page!");
			    }
			}

		}

	 }catch(Exception e){
	    e.printStackTrace();
	    throw new Exception("Element Not found on page!");
	    }
	}	

	@Then("^I get Attribute_value from '(.*)' and store$")
	public static void I_get_Attribute_value_from(String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			String value = driver.findElement(GetPageObject.OR_GetElement(element)).getAttribute("value");
			HashMapContainer.add(element, value);

		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	@Then("^I get Attribute_innertext from '(.*)' and store$")
	public static void I_get_Attribute_innertext_from(String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			String value = driver.findElement(GetPageObject.OR_GetElement(element)).getAttribute("innerText");
			HashMapContainer.add(element, value);

		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	@Then("^I close Tab$")
	public static void I_close_tab() {
		try {
			wrapFunc.CloseTab();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I scroll horizontal till start of the page '(.*)'$")
	public static void I_scroll_horizontal_untill_start_page(String target) {
	    int x_cordinate=700;
	  try{
	for(int i=0;i<=16;i++){
	EventFiringWebDriver test= new EventFiringWebDriver(driver);
	String[] Scroll_Ele = HashMapContainer.getPO(target).split(",");
	String Element_scroll = Scroll_Ele[1];
	test.executeScript("document.querySelector('"+Element_scroll+"').scrollLeft="+x_cordinate);
	            x_cordinate=x_cordinate-200;
	            System.out.println(x_cordinate);
	            Thread.sleep(1000);
	}

	}catch(Exception e){
	    e.printStackTrace();
	    }
	}

	@Then("^I scroll PS top/bottom '(.*)' scroll class '(.*)'$")
	public static void I_scroll_top_bottom_element(String scro, String sclass) {
		try {
			wrapFunc.PS_scroll(scro,sclass);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I scroll to element '(.*)'$")
	public static void I_scroll_to_element(String element) {
		try {
			String scro="element";
			wrapFunc.scroll(scro,element);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	

	
	@Then("^I type '(.*)' in field '(.*)' and click enter$")
	public static void I_type_in_field_enter(String value, String element) {
		try {
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			driver.findElement(GetPageObject.OR_GetElement(element)).clear();
						
			driver.findElement(GetPageObject.OR_GetElement(element)).sendKeys(value);
			I_pause_for_seconds(1);
			wrapFunc.sendkey("Enter");
			I_pause_for_seconds(2);
			// TODO Dismiss keyboard for webView
		} catch (Exception e) {
			e.printStackTrace();
			Assert.fail("I_type_in_field_enter failed :"+e);
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	//Do not use this method as it a custom, plz use I_should_see_element_Visible_wait
	@Then("^I wait for '(.*)' sec untill element '(.*)' is visible$")
    public static void I_wait_Element_is_visible(int time, String element){
        try{
            for (int i=0; i<time; i++){

    			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
    			WebElement x = driver.findElement(GetPageObject.OR_GetElement(element));
    			if(x.isDisplayed()){
    				 Thread.sleep(2000);

    			}
             else{
                System.out.println("The Actual element "+element+" is visible" );
                break;
                }
            }
        }catch(Exception e){
                //e.printStackTrace();
                //throw new CucumberException(e.getMessage(), e);
            }
        }
	
	@Then("^I add '(.*)' number of days to Today in format '(.*)' and store as '(.*)'$")
	public static void I_need_desired_date(int value, String dataformat, String element) {
		try {
				String ele="";
				String formattedDate=Utilities.getRequiredDate(value, dataformat, ele);
				HashMapContainer.add(element, formattedDate);
				HashMapContainer.add(element+"dataformat", dataformat);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I enter desired date '(.*)' in field '(.*)'$")
	public static void I_enter_desired_date(String date, String element) {
		try {
				String DDate=HashMapContainer.get(date);
				I_type_in_field_enter(DDate,element);

		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	//This method takes Base64 encrypted string as input.
	@Then("^I enter encrypted data '(.*)' in field '(.*)'$")
	public static void Password_decrypt(String pwd, String element) {
		try {
				String pass=Utilities.decryptedPwd(pwd);
				I_enter_in_field(pass,element);

		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}

	@Then("^I compare attribute value '(.*)' stored value '(.*)'$")
	public static void I_compare_two_StoredValue(String element, String storedValue) {
		try {
			storedValue = HashMapContainer.get(storedValue);
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			String value = driver.findElement(GetPageObject.OR_GetElement(element)).getAttribute("value");
			Assert.assertEquals("I Compare "+value+" with expected value "+storedValue,storedValue,value);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I Enter data from Page object file '(.*)' in '(.*)' field$")
	public static void I_pageobject_data(String value, String element){
		try{
			wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
			String[] Parameter = HashMapContainer.getPO(value).split(",");
			String data = Parameter[1];
			I_clear_Field(element);
			driver.findElement(GetPageObject.OR_GetElement(element)).sendKeys(data);
			Thread.sleep(1000);
		}catch(Exception e){
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	 @Then("^I drag '(.*)' and drop '(.*)'$")  // Drag and Drop
	 public static void I_drag_and_drop(String element1,String element2){
	 try{
		 wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element1));
		 Actions action = new Actions(driver);
		 WebElement we1 = driver.findElement(GetPageObject.OR_GetElement(element1));
		 WebElement we2 = driver.findElement(GetPageObject.OR_GetElement(element2));
		 action.clickAndHold(we1).moveToElement(we2).release().build().perform();
		 }catch(Exception e){
		 e.printStackTrace();
		 throw new CucumberException(e.getMessage(), e);
		 }
	 }

		@Then("^I select element '(.*)' from Dropdown '(.*)'$")
		public static void I_select_value_PS_Dropdown(String Value,String element) {
			try {
				wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
				I_click(element);
				I_scroll_to_element(Value);
				//driver.findElements((GetPageObject.OR_GetElement(element));
				I_click(Value);
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new CucumberException(e.getMessage(), e);
			}
		}
		
		@Then("^Validate all Image$")
		public static void Validate_image() throws Exception, Exception {
			try{
				int invalidImageCount = 0; 

				List<WebElement> imagesList = driver.findElements(By.tagName("img")); 
				System.out.println("Total no. of images are " + imagesList.size()); 

				for (WebElement imgElement : imagesList) { 
				 if (imgElement != null) { 
				    HttpClient client = HttpClientBuilder.create().build(); 
				   HttpGet request = new HttpGet(imgElement.getAttribute("src")); 
				   HttpResponse response = client.execute(request); 

				   if (response.getStatusLine().getStatusCode() != 200) 
				     invalidImageCount++; 
				   } 
				  } 
				System.out.println("Total no. of invalid images are " + invalidImageCount);

				if (invalidImageCount > 0){
					Assert.fail("Total no. of invalid images are " + invalidImageCount);
						FrameworkExceptions exp = new FrameworkExceptions("Total no. of invalid images are " + invalidImageCount);          
						throw exp; 
				}

				}catch	(FrameworkExceptions e) {
							e.printStackTrace();
							throw new CucumberException(e.getMessage(), e);
					}	
			
		}

		
		@Then("^Validate all Links$")
		public static void Link_validation() throws InterruptedException, Exception {

			int Valid_link=0;
			int Broken_link=0;
			int null_link=0;
			int redirect_link=0;
			List<WebElement> links = driver.findElements(By.tagName("a"));

			System.out.println("Total links are "+links.size());
			 try {
			for(int i=0; i<links.size(); i++) {
			WebElement element = links.get(i);

			String url=element.getAttribute("href");
			System.out.println(url);
			
            if ((url == null) || (url.isEmpty()))
            {
                null_link++;
            	System.out.println("URL is either not configured for anchor tag or it is empty");
                continue;
            }
			
			URL link = new URL(url);

			HttpURLConnection httpConn =(HttpURLConnection)link.openConnection();

			httpConn.setConnectTimeout(2000);

			httpConn.connect();
			
			System.out.println("Responce code=" +httpConn.getResponseCode());

			if(httpConn.getResponseCode()== 200) {
			System.out.println(url+" - "+httpConn.getResponseMessage());
			Valid_link++;
				}
			if(httpConn.getResponseCode()== 301) {
			System.out.println(url+" - "+httpConn.getResponseMessage());
			redirect_link++;
				}
			if(httpConn.getResponseCode()>= 400) {
			System.out.println(url+" - "+httpConn.getResponseMessage());
			Broken_link++;
						}
				}
			System.out.println("Total no. of valid Links are " + Valid_link);
			System.out.println("Total no. of Broken Link are " + Broken_link);
			System.out.println("Total no. of Null Link are " + null_link);
			System.out.println("Total no. of Re direct Link are " + redirect_link);

			if ((Broken_link > 0)||(null_link >0)||(redirect_link>0)){
					Assert.fail("Total no. of Broken link = " + Broken_link+" and No of Null link = "+null_link+" and No of Re Direct link= "+redirect_link);
					FrameworkExceptions exp = new FrameworkExceptions("Total no. of Broken link = " + Broken_link+" and No of Null link = "+null_link+" and No of Re Direct link= "+redirect_link);          
					throw exp; 
			}

			}catch (FrameworkExceptions e) {
						e.printStackTrace();
						throw new CucumberException(e.getMessage(), e);
						}
			}

		@Then("^I mouse over and click '(.*)'$")
		public static void I_mouse_over_click(String element){
			try{

				wrapFunc.waitForElementPresence(GetPageObject.OR_GetElement(element));
				wrapFunc.clickByAction(GetPageObject.OR_GetElement(element));
				Thread.sleep(1000);

			}catch(Exception e){
				e.printStackTrace();
				throw new CucumberException(e.getMessage(), e);
			}
		}
		
		@Then("^I mouse over text contains '(.*)'$")
		public static void mouseover_contains_txt(String Message) {
			try{
				String element = "//*[contains(text(),'"+Message+"')]";
				@SuppressWarnings("static-access")
				By xp=wrapFunc.setLocator("xpath", element);
				wrapFunc.waitForElementPresence(xp);
				wrapFunc.mouseHover(xp);

						
		    	}catch(Exception e) {
					e.printStackTrace();
		    	}
		}
		
		@Then("^I mouse over element with text '(.*)' and click$")
		public static void mouseover_equal_txt(String Message) {
			try{
				String element = "//*[text()='"+Message+"']";
				@SuppressWarnings("static-access")
				By xp=wrapFunc.setLocator("xpath", element);
				wrapFunc.waitForElementPresence(xp);
				wrapFunc.mouseHover(xp);
				wrapFunc.clickByAction(xp);

						
		    	}catch(Exception e) {
					e.printStackTrace();
		    	}
		}
		
		@Then("^I should see element with text '(.*)' present on page$")
		public static void I_should_see_ele_text_AndScreenshot(String Message) {

			try {
					String element = "//*[contains(text(),'"+Message+"')]";
					@SuppressWarnings("static-access")
					By xp=wrapFunc.setLocator("xpath", element);
					wrapFunc.waitForElementPresence(xp);

				WebElement x = driver.findElement(xp);
				if(x.isDisplayed()){
					WrapperFunctions.highLightElement(driver.findElement(xp));
					StepBase.embedScreenshot();
				}else{
					StepBase.embedScreenshot();
					Assert.fail("Element is not found! :"+xp);
					//throw new Exception("Element is not found!");
				}

			} catch (Exception e) {
				e.printStackTrace();
				StepBase.embedScreenshot();
				System.out.println("Element is not found");
				throw new CucumberException(e.getMessage(), e);
			}
		}	
		@Then("^I should see element with ID '(.*)' present on page$")
		public static void I_should_see_ele_ID_AndScreenshot(String Message) {

			try {
					//String element = "//*[contains(@id,'"+Message+"')]";
					@SuppressWarnings("static-access")
					By xp=wrapFunc.setLocator("id", Message);
					wrapFunc.waitForElementPresence(xp);

				WebElement x = driver.findElement(xp);
				if(x.isDisplayed()){
					WrapperFunctions.highLightElement(driver.findElement(xp));
					StepBase.embedScreenshot();
				}else{
					StepBase.embedScreenshot();
					Assert.fail("Element is not found! :"+xp);
					//throw new Exception("Element is not found!");
				}

			} catch (Exception e) {
				e.printStackTrace();

				System.out.println("Element is not found");
				throw new CucumberException(e.getMessage(), e);
			}
		}	
			
		@Then("^I wait till '(.*)' seconds for visiblity of element '(.*)'$")
		public static void I_should_see_element_Visible_wait(int time,String element) {

			try {
				
				boolean x = wrapFunc.waitForElementVisible(GetPageObject.OR_GetElement(element),time);
				if(x){
					Assert.assertTrue(element, x);
					WrapperFunctions.highLightElement(driver.findElement(GetPageObject.OR_GetElement(element)));
				}else{
					StepBase.embedScreenshot();
					Assert.fail("Element is not visible! :"+element);
					//throw new Exception("Element is not visible! :"+element);
				}

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("Element is not visible! :"+element);
				throw new CucumberException(e.getMessage(), e);
			}
		}
		
		@Then("^I wait for visiblity of element '(.*)'$")
		public static void I_should_see_element_Visible(String element) {

			try {
				
				boolean x = wrapFunc.waitForElementVisible(GetPageObject.OR_GetElement(element));
				if(x){
					WrapperFunctions.highLightElement(driver.findElement(GetPageObject.OR_GetElement(element)));
					Assert.assertTrue(element, x);
				}else{
					StepBase.embedScreenshot();
					Assert.fail("Element is not visible! :"+element);
					//throw new Exception("Element is not visible! :"+element);
				}

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("Element is not visible! :"+element);
				throw new CucumberException(e.getMessage(), e);
			}
		}
		
		//Open new tab with given URL
		@Then("^I open and navigate to New '(.*)' Tab$")
		public static void I_New_tab_NavigateTo(String urlt){
			try{
		
				String[] urlParameter = HashMapContainer.getPO(urlt).split(",");
				String url = urlParameter[1];
				driver.switchTo().newWindow(WindowType.TAB);
				driver.navigate().to(url);
			}catch(Exception e){
				e.printStackTrace();
				throw new CucumberException(e.getMessage(), e);
			}
		}
		//To click a element (following or preceding) with ref to random text
		//Path eg:/img[@class='test']
		//Element: is the random gentext stored name
		@Then("^I click following path '(.*)' of random gentext '(.*)'$")
		public static void I_click_following_path_random_gentext(String path, String element){
				try{
					String value = HashMapContainer.get(element);
					String DXpath="//*[contains(text(),'"+value+"')]"+path;
					driver.findElement(By.xpath(DXpath)).click();
					System.out.println("Text " + DXpath + " has been clicked");
			
						}catch(Exception e) {
					e.printStackTrace();
					System.out.println("Text to click has been not found!");
				}
			}	
		
		
	    @Then("^Capture baseline image of the page with name '(.*)'$")
	    public static void Screenshot_of_page(String Screenname)throws Exception{
	          try{
	                 File f1 = new File(Utilities.takeScreenshot(driver,Screenname));
	                 System.out.println("ActualSS Path: "+f1);
	          }catch(Exception e){
	                 e.printStackTrace();
	                throw new CucumberException(e.getMessage(),e);
	          }
	    }
	    
			
		 /**
		  * @ScriptName    : Dynamic_xpath
		  * @Description   : This function replaces the dynamic value in locator path
		  * @Input data	   : aText-string to replace,element- from csv, save as value to hashmap.
		  * sample data in csv : test,xpath,(//div[contains(text(),'Xdynamic')                
		  */
			
			@Then("^Dynamic xpath text '(.*)' for the element '(.*)' and save as '(.*)'$")
			public static void Dynamic_xpath(String aText,String element, String Value){
				try {
					String Parameter = HashMapContainer.getPO(element);
					String Nvalue=Parameter.replace("Xdynamic", aText);
					HashMapContainer.addPO(Value, Nvalue.toString().trim());
					}catch(Exception e) {
					e.printStackTrace();
					throw new CucumberException(e.getMessage(),e);
					}
			}
			
			@Then("^I wait for element not to be visiblie '(.*)'$")
			public static void I_should_not_see_element_Visible(String element) {

				try {
					
					boolean x = wrapFunc.waitForElementVisible(GetPageObject.OR_GetElement(element));
					if(!x){
						System.out.println("Element is not visible! :"+element);
						Assert.assertTrue(element, true);
					}else{
						StepBase.embedScreenshot();
						Assert.fail("Element is visible! :"+element);
						
					}

				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("I_should_not_see_element_Visible  failed."+element);
					throw new CucumberException(e.getMessage(),e);
				}
			}
			
}
