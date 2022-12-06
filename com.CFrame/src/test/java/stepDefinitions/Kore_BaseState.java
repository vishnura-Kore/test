package stepDefinitions;
import framework.HashMapContainer;
import framework.StepBase;
import framework.Utilities;
import framework.WrapperFunctions;
import io.cucumber.core.exception.CucumberException;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;

import framework.SQLConnector;
import framework.FrameworkExceptions;
import stepDefinitions.CommonSteps;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class Kore_BaseState {
	
	static WrapperFunctions wrapFunc = new WrapperFunctions();
	static StepBase sb = new StepBase();
	public static WebDriver driver= sb.getDriver();
	static Utilities util = new Utilities();
	static CommonSteps Comstp = new CommonSteps();
	//base state for Summary
		@Then("^I go to Summary base state$")
		public static void base_state_Summary()
		{
			 try{
		            String Active_Menu="//div[contains(@class,'selectedMenu')]/div[@href='#menuItem_botSummary']";

					@SuppressWarnings("static-access")
					By buildmenu=wrapFunc.setLocator("xpath", Active_Menu);
		            if (!wrapFunc.waitForElementPresence(buildmenu))
		            {
		            	JavascriptExecutor executor = (JavascriptExecutor)driver;
		            	executor.executeScript("window.localStorage.setItem('jStorage',null)");
		            	Comstp.I_Refresh();
		            	Comstp.waitForPageLoaded();
		            	Comstp.I_pause_for_seconds(5);
		            	Comstp.I_Clear_hasmap();
		            	Comstp.I_load_page_object("Kore_applications");
		                Comstp.I_should_see_element_Visible("username");
		                Comstp.I_should_see_element_Visible("ContinueBtn");
		                Comstp.I_pageobject_data("uname", "username");
		                Comstp. I_click("ContinueBtn");
		                Comstp.I_should_see_element_Visible("password");
		                Comstp.I_pageobject_data("pword", "password");
		                Comstp.I_wait_for_Element_clickable(5,"Login");
		                Comstp. I_click("Login");
		                Comstp.waitForPageLoaded();
		                Comstp.I_should_see_element_Visible("sreach");
		                Comstp.I_focus_on_element("sreach");
		                Comstp.I_pageobject_data("MySreach_bot", "sreach");
		                Comstp. I_click("My_1st");
		                Comstp.waitForPageLoaded();
		                Comstp.I_pause_for_seconds(5);
		                Comstp.I_should_see_element_Visible("Summary_menu");
		                Comstp.I_mouse_over_click("Summary_menu");
		                Comstp.I_pause_for_seconds(5);
		                Comstp.I_Clear_hasmap();
		                
		            }
		           
		        }catch(Exception e){
		            e.printStackTrace();
		        }

		}

}
