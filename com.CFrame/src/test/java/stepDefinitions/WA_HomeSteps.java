package stepDefinitions;

import java.awt.image.BufferedImage;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.gargoylesoftware.htmlunit.ElementNotFoundException;

import org.junit.Assert;

import framework.HashMapContainer;
import framework.SQLConnector;
import framework.StepBase;
import framework.Utilities;
import framework.WrapperFunctions;
import io.cucumber.core.exception.CucumberException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import pageObjects.GetPageObject;
import org.assertj.core.api.SoftAssertions;

/**
 * @ScriptName : Utilities
 * @Description : This class contains Commonly used Keyword for Web application
 *              automation using Cucumber framework
 * 
 */
public class WA_HomeSteps {

	static WrapperFunctions wrapFunc = new WrapperFunctions();
	static StepBase sb = new StepBase();

	public static WebDriver driver = sb.getDriver();
	static Utilities util = new Utilities();
	static SQLConnector SQLC = new SQLConnector();
	private static BufferedImage bufferedImage;
	private static byte[] imageInByte;

	CommonSteps cs = new CommonSteps();
	
	static String bellactivity1="//div[contains(@class,'msg')]//div[contains(text(),'";
	static String bellactivity2="')][./b[contains(.,'";
	static String bellactivity3="')]]";
	static String bellunreaddot="/../../..//span[@class='dotBtn']";
	
	static SoftAssertions softAssertions = new SoftAssertions();

	/**
	 * Login to work assist with the specified username and password
	 * 
	 * @param username
	 *            : username to enter in username field
	 * @param password
	 *            : password to enter in password field
	 * @throws Exception
	 *             : Login failed to work assist
	 */

	@When("^I login to workassist with O365 as '(.*)' using '(.*)'$")
	public static void login_ToWorkAssist_WithO365(String username, String password) throws Exception {
		try {
			System.out.println("Login to WorkAssist");
			CommonSteps.I_should_see_element_Visible_wait(10, "microsoftlogin");
			CommonSteps.I_click("microsoftlogin");
			pickanAccount();
			CommonSteps.I_should_see_element_Visible_wait(10, "enterusernamenext");
			CommonSteps.I_enter_in_field(username, "entereusermail");
			CommonSteps.I_click("enterusernamenext");
			Thread.sleep(1500);
			CommonSteps.I_enter_in_field(password, "enterpassword");
			Thread.sleep(1000);
			CommonSteps.I_click("passwordsubmit");
			staySignIn();
			select_multiAccount("WA2.0Automation");
			CommonSteps.I_should_see_element_Visible_wait(10, "walogo");
			Thread.sleep(3000);
		} catch (Exception e) {
			System.out.println("Login failed to work assist");
			throw new CucumberException(e.getMessage(), e);
		}
	}

	/**
	 * To logout and re-login with the specified username and password
	 * 
	 * @param username
	 *            : username to enter in username field
	 * @param password
	 *            : password to enter in password field
	 * @throws Exception
	 *             : Failed to logout and re-login with a different user
	 */

	@When("^I logout and relogin with '(.*)','(.*)'$")
	public static void logout_relogin_with(String username, String password) throws Exception {
		try {
			System.out.println("About to logout and relogin with " + username);
			CommonSteps.I_click("wsuserprofileicon");
			Thread.sleep(1000);
			CommonSteps.I_click("logout");
			CommonSteps.I_should_see_element_Visible_wait(10, "microsoftlogin");
			CommonSteps.I_NavigateTo("office365url");
			boolean extraheader = false;
			extraheader = driver.findElements(GetPageObject.OR_GetElement("office365extraheader")).size() > 0;
			if (extraheader) {
				System.out.println("Had extra header for O365");
				CommonSteps.I_click("office365extraheader");
				CommonSteps.I_should_see_element_Visible_wait(10, "office365profile");
			}
			CommonSteps.I_click("office365profile");
			boolean mectrolsignout = false;
			boolean mesignout = false;
			mectrolsignout = driver.findElements(GetPageObject.OR_GetElement("office365mectrolsigout")).size() > 0;
			mesignout = driver.findElements(GetPageObject.OR_GetElement("office365mesigout")).size() > 0;
			if (mectrolsignout) {
				CommonSteps.I_click("office365mectrolsigout");
				System.out.println("Displayed mectrol sigout and clicked");
				Thread.sleep(2000);
			} else if (mesignout) {
				CommonSteps.I_click("office365mesigout");
				System.out.println("Displayed me sigout and clicked");
				Thread.sleep(2000);
			}
			CommonSteps.I_should_see_element_Visible_wait(12, "office365switchtoaccout");
			CommonSteps.I_NavigateTo("01_wa_Home");
			login_ToWorkAssist_WithO365(username, password);
		} catch (Exception e) {
			System.out.println(e.getMessage() + " Failed to logout and relogin with " + username);
			throw new CucumberException(e.getMessage(), e);
		}
	}

	/**
	 * To choose another account or to click on sign in
	 */
	@And("^I pick an account $")
	public static void pickanAccount() {
		String pickanAccount = null;
		CommonSteps.I_should_see_element_Visible_wait(20, "pickanaccountorsignin");
		try {
			CommonSteps.I_get_text_from("pickanaccountorsignin");
			pickanAccount = HashMapContainer.get("pickanaccountorsignin");
		} catch (Exception ex) {
			System.out.println("Ignore this when user login for the first time");
		}
		if (!pickanAccount.contains("Sign in")) {
			CommonSteps.I_click("useanotheraccount");
		}
	}

	/**
	 * Selects stay sign in option if it appears
	 * 
	 * @throws Exception
	 */
	@And("^I select stay signin $")
	public static void staySignIn() throws Exception {
		boolean staysignin = false;
		staysignin = driver.findElements(GetPageObject.OR_GetElement("staysigninyes")).size() > 0;
		if (staysignin) {
			CommonSteps.I_click("staysigninyes");
			Thread.sleep(2000);
		}
	}

	/**
	 * It will select user provided account from multiaccount screen
	 * 
	 * @param accounttoselect
	 *            : Pass the account as a string to choose from multiaccount
	 *            sccreen
	 */

	@When("^I select multiaccout '(.*)'$")
	public static void select_multiAccount(String accounttoselect) {
		boolean selectaccount = false;
		selectaccount = driver.findElements(GetPageObject.OR_GetElement("selectanaccounttoproceed")).size() > 0;
		if (selectaccount) {
			boolean multiaccount = false;
			multiaccount = driver.findElements(GetPageObject.OR_GetElement("multiaccounts")).size() > 0;
			if (multiaccount) {
				List<WebElement> multilist = driver.findElements((GetPageObject.OR_GetElement("multiaccounts")));
				for (WebElement e : multilist) {
					if (e.getText().equalsIgnoreCase(accounttoselect)){
						e.click();
						break;
					}
				}
			}
		}
	}

	/**
	 * To navigate to workAssist home page
	 * 
	 * @throws Exception
	 */

	@And("^I navigate to workassist homepage$")
	public static void navigateToWAHomeFromLogo() throws Exception {
		boolean closebtn = false;
		Thread.sleep(1000);
		try {
			CommonSteps.I_should_see_element_Visible_wait(10, "walogo");
			CommonSteps.I_click("walogo");
		} catch (Exception e) {
			System.out.println("###Navigating to Home# from catch##");
			CommonSteps.I_click("screenoverlay");
			CommonSteps.I_should_see_element_Visible_wait(10, "walogo");
			CommonSteps.I_click("walogo");
		}
		
		Thread.sleep(1000);
	}

	/**
	 * To generate random current time stamp and appends with user provided text
	 * in @autotext
	 * 
	 * @param autotext
	 *            : Timestamp will be appended to this string
	 * @return : Returns user text appends with current timestamp
	 */

	@Then("^I genereate random text with current timestamp and store to '(.*)'$")
	public static void generateRandomeRunTimeandStoreTo(String randomdelete) throws Exception {
		String rearrangedrandom = "null";
		try {
			{
				String TimeinHHMMSS = null;
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				Date date = new Date();
				TimeinHHMMSS = formatter.format(date).replaceAll(":", "").substring(11).trim();
				rearrangedrandom = randomdelete + TimeinHHMMSS;
				HashMapContainer.add(randomdelete, rearrangedrandom);
			//	randomdelete = HashMapContainer.get(randomdelete);
			}
		} catch (Exception e) {
			System.out.println("random timestamp generated text is :"+randomdelete);
		}
	}

	@And("^I get stored value from '(.*)'$")
	public static String getStoredValue(String sendmessageas) throws Exception {
		return sendmessageas=HashMapContainer.get(sendmessageas);
		}
	
	@Then("^I compare/assert '(.*)' with boolean expected and actual '(.*)','(.*)'$")
	public static void assertForBooleanComparision(String message, boolean expected, boolean actual) {
		try {
			Assert.assertEquals(message, expected, actual);
		//	softAssertions.assertAll();
		} catch (Exception e) {
			e.printStackTrace();
		//	throw new CucumberException(e.getMessage(), e);
		}

	}

	@Then("^I compare/assert '(.*)' with expected and actual strings '(.*)','(.*)'$")
	public static void assertForStringComparisition(String message, String expected, String actual) {
		
		try {
		//	Assert.assertEquals(message, expected, actual);
			
			softAssertions.assertThat(expected).isEqualTo(actual);
		//	softAssertions.assertAll();
		} catch (Exception e) {
			e.printStackTrace();
		//	throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I assert all$")
	public static void assertAll() {
		
		try {
			softAssertions.assertAll();
		} catch (Exception e) {
			throw new CucumberException(e.getMessage(), e);
		}
	}

	/**
	 * To get css value for the element and compare against expected color
	 * 
	 * @param ele
	 *            : for which the css value to be fetched
	 * @param expectedclr
	 *            : To which the actual css value compared
	 * @return : Returns actual background color
	 * @throws Exception
	 *             : Failed to get css value error
	 */

	// div[contains(@class,'ag-cell-value ag-cell-focus')]
	// "rgba(179, 186, 200, 0.58)"
	@Then("^I get background color of '(.*)' and compare with expected '(.*)'$")
	public static String getActiveLabelBackgroundColor(String ele, String expectedclr) throws Exception {
		String actbckgclr = null;
		boolean expected = false;
		boolean actual = false;
		try {
			actbckgclr = driver.findElement(GetPageObject.OR_GetElement(ele)).getCssValue("background-color");
			System.out.println("$$$$$$$$$$$$$" + actbckgclr);
			if (expectedclr.equals(actbckgclr))
				expected = true;
			assertForBooleanComparision(ele + " Background color : ", expected, actual);
		} catch (Exception e) {
			System.out.println("Failed to get css vakue of " + ele);
		}
		return actbckgclr;
	}

	@Then("^I update user role to '(.*)' with text '(.*)'$")
	public static void updateUserRoleTo(String role) {
		try {
			driver.findElement(By.xpath("//div[@class='roleName'][text()='" + role + "']")).click();
			/*
			 * WebElement e
			 * =driver.findElement(GetPageObject.OR_GetElement(element)); String
			 * elementpath=e+"[text()='"+text+"']";
			 * driver.findElement(By.xpath(elementpath)).click();
			 */
		} catch (Exception e) {
			System.out.println("Failed to click on user role to " + role);
			throw new CucumberException(e.getMessage(), e);
		}
	}

	/**
	 * To validate user role w.r.t expected role
	 * 
	 * @param user
	 *            : Role will be validated for the given user
	 * @param expectedrole
	 *            : It will assert with the expected role
	 */

	@Then("^I validate user '(.*)' role as '(.*)'$")
	public static void validateUserRoles(String user, String expectedrole) {
		Map<String, String> map = new LinkedHashMap<String, String>();
		ArrayList<String> userlist = new ArrayList<>();
		ArrayList<String> roleslist = new ArrayList<>();
		try {
			List<WebElement> users = driver.findElements(By.xpath("//div[contains(@class,'muwmcmcdc-userEmail')]"));
			List<WebElement> roles = driver.findElements(By.xpath("//div[@class='muwmcdc-roleName roleMenu']"));

			for (WebElement us : users) {
				userlist.add(us.getText());
			}
			for (WebElement us : roles) {
				roleslist.add(us.getText());
			}

			for (int i = 0; i < userlist.size(); i++) {
				map.put(userlist.get(i), roleslist.get(i));
			}
			System.out.println("User related roles are : " + map);

			String actualrole = (String) map.get(user);
			System.out.println(actualrole);
			/*
			 * map.forEach((k, v) -> { System.out.println("Key: " + k +
			 * ", Value: " + v); });
			 */
			System.out.println(map.get(user));
			assertForStringComparisition(user + " Role :", expectedrole, actualrole);
			
			CommonSteps.I_click("sharemanageclose_btn");
		} catch (Exception e) {
			CommonSteps.I_click("sharemanageclose_btn");
			System.out.println("Faile to validate user roles");
		}
	}
	
	@Then("^I moveto '(.*)' element$")
	public static void moveToElement(String elementpath){
		try{
			WebElement ele = driver.findElement(By.xpath(elementpath));
			JavascriptExecutor js = (JavascriptExecutor) driver;
			WebElement ele1=driver.findElement(By.xpath(elementpath));
				((JavascriptExecutor)driver).executeScript("arguments[0].scrollIntoView();", ele);
			Actions actions = new Actions(driver);
			actions.moveToElement(ele);
			actions.moveToElement(ele).build().perform();
			Thread.sleep(500);
	}catch (Exception e){
		System.out.println("Faile to move to the element "+elementpath);
		}
	}
	
	@Then("^I should not see the element '(.*)' visibility on page$")
	public static void I_should_not_see_onpage(String element) throws Exception{

		try {
			Boolean elementexist= driver.findElements(By.xpath(element)).size() > 0;
			System.out.println("Element is displayed: " +elementexist);
			if(elementexist){
				StepBase.embedScreenshot();
				WrapperFunctions.highLightElement(driver.findElement(By.xpath(element)));
				throw new Exception("Element is found on page!");
			}else{
				System.out.println("Element is not displayed");
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Element is found on Page as expected");
		}
	}
	
	@Then("^I wait for the visiblity of element '(.*)'$")
	public static void I_should_see_element_visibility(String element) {

		try {
			
			boolean x = wrapFunc.waitForElementVisible(By.xpath(element));
			if(x){
				WrapperFunctions.highLightElement(driver.findElement(By.xpath(element)));
			}else{
				throw new Exception("Element is not visible! :"+element);
			}

		} catch (Exception e) {
			StepBase.embedScreenshot();
			System.out.println("Element is not visible! :"+element);
		//	throw new CucumberException(e.getMessage(), e);
			throw new ElementNotFoundException(element, "", "");
		}
	}
		
	@Then("^I click with text '(.*)'$")
		public static void clickWithText (String text){
			try{
				driver.findElement(By.xpath("//*[text()='"+text+"']")).click();
				Thread.sleep(1000);
			}catch (Exception e){
				System.out.println(text+" is not available in the screen --> Ignore this");
				throw new CucumberException(e.getMessage(), e);
			}
		}
		
	@Then("^I click with dynamic xpath '(.*)'$")
		public static void clickWithtextBasedXpath (String xpath){
			try{
				driver.findElement(By.xpath(xpath)).click();
			}catch (Exception e){
				StepBase.embedScreenshot();
				System.out.println("Faile to click on  "+xpath);
				e.printStackTrace();
				throw new CucumberException(e.getMessage(), e);
			}
		}
	
	@Then("^I enter '(.*)' in field without clear'(.*)'$")
	public static void I_enter_text(String value, String element) {
		try {
			Thread.sleep(500);
			if(value.length()>1){
				if(value.substring(0,2).equals("$$"))
				{
					
					value = HashMapContainer.get(value);
				}
			}
			driver.findElement(By.xpath(element)).sendKeys(value);
			Thread.sleep(200);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I navigate to bell notifications$")
	public static void clicandNavigatetoBellNotification(){
		try{
			CommonSteps.I_click("bellicon");
			Thread.sleep(500);
		}catch (Exception e){
			System.out.println("Failed to navigate to the bell notification");
		}
	}
	
	/**
	 * Events can be fired --> 
	 * @param activityname : activity name should be the activity performed like renamed , mentioned you, deleted , mentioned everyone
	 * @param activityperformedon : On which the activity performed like Workspacename / Topicname
	 * @param unreaddotvisibility : True will expect unread dot visibility
	 */
	
	@Then("^I verify unread dot and bell notification for '(.*)' activity on '(.*)' and navigate$")
	public static void verifyBellNotificationAndUnreadDot(String activityname,String activityperformedon){
		//div[contains(@class,'msg')]//div[contains(text(),'added')][./b[contains(.,'GroupActivity')]]
		
		String bellnotification=bellactivity1+activityname+bellactivity2+activityperformedon+bellactivity3;
		String bellnotification_withunread=bellnotification+bellunreaddot;
		
	//	int beforeclick_bellnot = driver.findElements(By.xpath(bellnotification)).size();
		int beforeclick_redbellnot = driver.findElements(By.xpath(bellnotification_withunread)).size();
		
		try{
		//	CommonSteps.I_click("bellicon");
			I_should_see_element_visibility(bellnotification);
				I_should_see_element_visibility(bellnotification_withunread);
				clickWithtextBasedXpath(bellnotification);
				int afterclick_redbellnot = driver.findElements(By.xpath(bellnotification_withunread)).size();
				System.out.println("Here");
				if (beforeclick_redbellnot==afterclick_redbellnot){
					StepBase.embedScreenshot();
					WrapperFunctions.highLightElement(driver.findElement(By.xpath(bellnotification_withunread)));
					throw new Exception("Unread dot is still visible even after navigation!");
				}
			
			Thread.sleep(500);
			
		}catch (Exception e){
			System.out.println("Failed to validate unread dot in bell notification and navigation");
			throw new CucumberException(e.getMessage(), e);
		}
	}
	
	@Then("^I open bell notification$")
	public static void clickandNavigatetoBellNotification(){
		try{
			CommonSteps.I_click("bellicon");
			Thread.sleep(500);
		}catch (Exception e){
			System.out.println(" is not available in the screen --> Ignore this");
		}
	}
	
	@Then("^I close bell notification$")
	public static void closeBellNotification(){
		try{
			CommonSteps.I_click("bellclose");
			Thread.sleep(500);
		}catch (Exception e){
			System.out.println("Failed to close bell notofication");
		}
	}
	
	public static String getFirstChar(String input) {
		char first = input.charAt(0);
		String myStr = Character.toString(first);
		return myStr;
	}
		
}
