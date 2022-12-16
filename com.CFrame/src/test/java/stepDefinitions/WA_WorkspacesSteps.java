package stepDefinitions;

import java.awt.image.BufferedImage;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import com.aventstack.extentreports.util.Assert;

import framework.HashMapContainer;
import framework.SQLConnector;
import framework.StepBase;
import framework.Utilities;
import framework.WrapperFunctions;
import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import pageObjects.GetPageObject;

/**
 * @ScriptName : Utilities
 * @Description : This class contains Commonly used Keyword for Web application
 *              automation using Cucumber framework
 * 
 */
public class WA_WorkspacesSteps {

	static WrapperFunctions wrapFunc = new WrapperFunctions();
	static StepBase sb = new StepBase();

	public static WebDriver driver = sb.getDriver();
	static Utilities util = new Utilities();
	static SQLConnector SQLC = new SQLConnector();
	private static BufferedImage bufferedImage;
	private static byte[] imageInByte;

	@When("^I create workspace '(.*)' as private '(.*)' with out participants$")
	public static String create_WorkspaceWithoutParticipants(String workspacename,boolean privatews) throws Exception {
		String wsname =workspacename;
		try {
			System.out.println("In creation of workspace without participants");
			CommonSteps.I_should_see_element_Visible_wait(10, "wswsicon");
			CommonSteps.I_click("wswsicon");
			CommonSteps.I_should_see_element_Visible_wait(10, "wscreatenew");
			CommonSteps.I_click("wscreatenew");
			CommonSteps.I_should_see_element_Visible_wait(10, "wscreatewsheader");
			CommonSteps.I_enter_in_field(wsname, "wsenterws");
			if(!privatews){
				CommonSteps.I_click("wsvisibilityprivate");
				CommonSteps.I_should_see_element_Visible_wait(5, "wsprivatetext");
				CommonSteps.I_should_see_element_Visible_wait(5, "wspublictext");
				CommonSteps.I_click("wsvisibilitypublic");
				Thread.sleep(1500);
				CommonSteps.I_should_see_element_Visible_wait(5, "wspublictext");
			}
			CommonSteps.I_click("wsbtncreateworkspace");
			Thread.sleep(2000);
			
		} catch (Exception e) {
			System.out.println("Failed to create workspace with out participants");
		}
		return wsname;
	}
	
	@When("^I create workspace '(.*)' with in a workspace as private '(.*)' with out participants$")
	public static String create_WorkspaceFrom3Dots_WithoutParticipants(String workspacename,boolean privatews) throws Exception {
		String wsname =workspacename;
		try {
			System.out.println("In creation of workspace from 3 dots");
			CommonSteps.I_click("ws3dots");
			CommonSteps.I_should_see_element_Visible_wait(10, "ws3dotscreatews");
			CommonSteps.I_click("ws3dotscreatews");
			CommonSteps.I_should_see_element_Visible_wait(10, "wscreatewsheader");
			CommonSteps.I_enter_in_field(wsname, "wsenterws");
			if(!privatews){
				CommonSteps.I_click("wsvisibilityprivate");
				CommonSteps.I_should_see_element_Visible_wait(5, "wsprivatetext");
				CommonSteps.I_should_see_element_Visible_wait(5, "wspublictext");
				CommonSteps.I_click("wsvisibilitypublic");
				Thread.sleep(1500);
				CommonSteps.I_should_see_element_Visible_wait(5, "wspublictext");
			}
			CommonSteps.I_click("wsbtncreateworkspace");
			Thread.sleep(2000);
		} catch (Exception e) {
			System.out.println("Failed to reate workspace with out participants");
		}
		return wsname;
	}
	
	@When("^I create workspace '(.*)' as private '(.*)' with participants'(.*)'$")
	public static String create_WorkspaceWithParticicpants(String workspacename,boolean privatews, String participants) throws Exception {
		String wsname =workspacename;
		try {
			System.out.println("In creation of workspace with participants");
			CommonSteps.I_should_see_element_Visible_wait(10, "wswsicon");
			CommonSteps.I_click("wswsicon");
			CommonSteps.I_should_see_element_Visible_wait(10, "wscreatenew");
			CommonSteps.I_click("wscreatenew");
			CommonSteps.I_should_see_element_Visible_wait(10, "wscreatewsheader");
			CommonSteps.I_enter_in_field(workspacename, "wsenterws");
			if(!privatews){
				CommonSteps.I_click("wsvisibilityprivate");
				CommonSteps.I_should_see_element_Visible_wait(5, "wsprivatetext");
				CommonSteps.I_should_see_element_Visible_wait(5, "wspublictext");
				CommonSteps.I_click("wsvisibilitypublic");
				Thread.sleep(1500);
				CommonSteps.I_should_see_element_Visible_wait(5, "wsvisibilitypublic");
			}
			addPeople(participants);
			CommonSteps.I_click("wsbtncreateworkspace");
			Thread.sleep(2000);
		} catch (Exception e) {
			System.out.println("Failed to create workspace with participants");
		}
		return wsname;
	}

	/**
	 * To add list of user provided participants to workspace
	 * @param participantlist : These participants will be added to workspace ot topic
	 * @param element : Participants will be added in this element
	 * @throws Exception : Throws failed to add participants error
	 */
	
	@When("^I add people '(.*)'$")
	public static void addPeople(String participantlist) throws Exception {
		try {
			CommonSteps.I_click("wsenterparticipants");
			if (participantlist.contains(",")) {
				String result[] = participantlist.trim().split("\\s*,\\s*");
				for (String part : result) {
					System.out.println(part);
					selectParticipants(participantlist);
				}
			} else {
				selectParticipants(participantlist);
			}
			Thread.sleep(2000);
		} catch (Exception e) {
			System.out.println("Failed to add participants");
		}
	}

	/**
	 * To select user provided participants from the list of contact suggestions
	 * @param participant : Select the participant
	 * @param element : Selects the participants from the suggestions
	 * @throws Exception : Throws failed to select participants
	 */
	
	@And("^I select participants '(.*)'$")
	public static void selectParticipants(String participant) throws Exception {
		try {
			CommonSteps.I_click("wsenterparticipants");
			CommonSteps.I_enter_in_field(participant, "wsenterparticipants");
			driver.findElement(GetPageObject.OR_GetElement("wsenterparticipants")).sendKeys(Keys.BACK_SPACE);
			Thread.sleep(1000);
			driver.findElement(GetPageObject.OR_GetElement("wsenterparticipants")).sendKeys(Keys.BACK_SPACE);
			Thread.sleep(1000);
			CommonSteps.I_wait_for_presence_of_element(10, "wspeoplesuggestions");
			List<WebElement> mailid = driver.findElements(GetPageObject.OR_GetElement("wspeoplesuggestions"));
			for (WebElement e : mailid) {
				e.getText().trim();
				if (e.getText().trim().equalsIgnoreCase(participant)) {
					e.click();
					break;
				}
			}
		} catch (Exception e) {
			System.out.println("Failed to select participants");
		}
	}
	
	/**
	 * From Invite popup we can add user by specifying a role. Here we are even closing 'sharing and permissions'/Manage popup
	 * @param participant : Given user will be added as a participant
	 * @param role : true will add a role to the user and false will continue with the default role
	 * @param roletype : Given role will be appended to the participant
	 * @return updatedroletype : Returns updated role type for assertions
	 * @throws Exception : Failed to add participant with role
	 */
	
	@And("^I select '(.*)' user and assign role '(.*)' of type '(.*)'$")
	public static String selectParticipantAndAssisgnRole(String participant, boolean role, String roletype) throws Exception {
		String updatedroletype="";
		try {
			CommonSteps.I_click("wsenterparticipants");
			CommonSteps.I_enter_in_field(participant, "wsenterparticipants");
			driver.findElement(GetPageObject.OR_GetElement("wsenterparticipants")).sendKeys(Keys.BACK_SPACE);
			Thread.sleep(1000);
			driver.findElement(GetPageObject.OR_GetElement("wsenterparticipants")).sendKeys(Keys.BACK_SPACE);
			Thread.sleep(1000);
			CommonSteps.I_wait_for_presence_of_element(10, "wspeoplesuggestions");
			List<WebElement> mailid = driver.findElements(GetPageObject.OR_GetElement("wspeoplesuggestions"));
			for (WebElement e : mailid) {
				e.getText().trim();
				if (e.getText().trim().equalsIgnoreCase(participant)) {
					e.click();
					if (role){
						CommonSteps.I_click("wsroleselect_drpdwn");
						Thread.sleep(1000);
						WA_HomeSteps.updateUserRoleTo(roletype);
						CommonSteps.I_should_see_element_Visible_wait(10, "wsroleselect_drpdwn");
						updatedroletype= driver.findElement(GetPageObject.OR_GetElement("wsroleselect_drpdwn")).getText();
						WA_HomeSteps.assertForStringComparisition("User role ", roletype, updatedroletype);
						CommonSteps.I_click("invite_btn");
						Thread.sleep(4000);
						CommonSteps.I_click("sharemanageclose_btn");
						Thread.sleep(2000);
					}
						
					break;
				}
			}
		} catch (Exception e) {
			System.out.println("Failed to select participants and assign role");
		}
		return updatedroletype;
	}
	
	/**
	 * To select workspace from primary navigation (List of recent 3 workspaces)
	 * @param wsname : Given workspace will be selected from primary navigation
	 */
	
	@And("^I select workspace from primary navigation '(.*)'$")
	public static void selectWorkspaceFromPrimaryNav(String wsname){
		boolean primarynav =false;
		List<WebElement> primarynavws = driver.findElements(GetPageObject.OR_GetElement("wsprimarynavws"));
		for (WebElement e : primarynavws) {
			if (e.getAttribute("title").trim().equalsIgnoreCase(wsname)) {
				e.click();
				primarynav =true;
				System.out.println(wsname+" is available in the primary nav");
				break;
			}
		}
		if (!primarynav)
			System.out.println(wsname+" is not available in the primary nav");
		
	}
	
	/**
	 * To select workspace from search workspace
	 * @param wsname : Search for the given workspace and selects the same
	 */
	
	@And("^I search and select workspace '(.*)'$")
	public static void searchAndSelectWorkspace(String wsname) {
		try {
			CommonSteps.I_click("wswsicon");
			Thread.sleep(2000);
			CommonSteps.I_wait_for_presence_of_element(10, "wssearch");
			CommonSteps.I_click("wssearch");
			CommonSteps.I_enter_in_field(wsname, "wssearchinput");
			List<WebElement> wssearchlist = driver.findElements(GetPageObject.OR_GetElement("wssearchlist"));
			for (WebElement e : wssearchlist) {
				if (e.getText().trim().equalsIgnoreCase(wsname)) {
					e.click();
					Thread.sleep(2000);
					CommonSteps.I_wait_for_presence_of_element(10, "wshomevalidation");	
					break;
				}
			}

		} catch (Exception e) {
			CommonSteps.I_click("wsclose");
			System.out.println(wsname + " is not available in the entire workspaces list");
		}

	}
	
	/**
	 * To verify workspace existance
	 * @param wsname : Search for the given workspace and selects the same
	 */
	
	@And("^I search for '(.*)' existance and should be '(.*)'$")
	public static void searchAndVerifyWorkspaceExistance(String wsname, boolean existance) {
		boolean wsexistance=false;
		try {
			CommonSteps.I_click("wswsicon");
			Thread.sleep(2000);
			CommonSteps.I_wait_for_presence_of_element(10, "wssearch");
			CommonSteps.I_click("wssearch");
			CommonSteps.I_enter_in_field(wsname, "wssearchinput");
			List<WebElement> wssearchlist = driver.findElements(GetPageObject.OR_GetElement("wssearchlist"));
			for (WebElement e : wssearchlist) {
				String actualws=e.getText().trim();
				if (e.getText().trim().equalsIgnoreCase(wsname)) {
					wsexistance=true;
					break;
				}
			}
			WA_HomeSteps.assertForBooleanComparision("Existance of" +wsname, existance, wsexistance);
			CommonSteps.I_click("wsclose");
		} catch (Exception e) {
			CommonSteps.I_click("wsclose");
			System.out.println(wsname + " is not available in the entire workspaces list");
		}
	}
	
	@And("^I delete workspace '(.*)'$")
	public static void deleteWorkspace(String wsname) {
		try {
			CommonSteps.I_click("ws3dots");
			CommonSteps.I_should_see_element_Visible_wait(10, "ws3dotsdelete");
			CommonSteps.I_click("ws3dotsdelete");
			Thread.sleep(1000);
			CommonSteps.I_click("wsdeleteconfirmation");
			Thread.sleep(4000);
		//	CommonSteps.I_wait_Element_is_not_Displayed(10, "wsdeleteconfirmation"); Not working as expected
		} catch (Exception e) {
			System.out.println("Failed to delete ws" + wsname);
		}
	}
	
	@And("^I select and delete workspace '(.*)'$")
	public static void selectAndDeleteWorkspace(String wsname) {
		try {
			CommonSteps.I_click("wswsicon");
			Thread.sleep(2000);
			CommonSteps.I_wait_for_presence_of_element(10, "wssearch");
			CommonSteps.I_click("wssearch");
			CommonSteps.I_enter_in_field(wsname, "wssearchinput");
			List<WebElement> wssearchlist = driver.findElements(GetPageObject.OR_GetElement("wssearchlist"));
			for (WebElement e : wssearchlist) {
				String actualws=e.getText().trim();
				if (e.getText().trim().equalsIgnoreCase(wsname)) {
					e.click();
					CommonSteps.I_click("ws3dots");
					CommonSteps.I_should_see_element_Visible_wait(10, "ws3dotsdelete");
					CommonSteps.I_click("ws3dotsdelete");
					Thread.sleep(1000);
					CommonSteps.I_click("wsdeleteconfirmation");
					CommonSteps.I_wait_Element_is_not_Displayed(10, "wsdeleteconfirmation");
					Thread.sleep(7000);
					break;
				}
			}
		} catch (Exception e) {
			System.out.println(wsname + " is not available in the entire workspaces list");
		}
	}
	
	@And("^I validate show all workspaces$")
	public static void showAllWorkspaces() throws Exception {
		String headerwscount = driver.findElement(GetPageObject.OR_GetElement("wscount")).getText();
		boolean expectedwscount=true;
		boolean actualwscount=false;
		try {
			int expwscount = Integer.parseInt(headerwscount);
			List<WebElement> allws = driver.findElements((GetPageObject.OR_GetElement("wssearchlist")));
			int actwscount =allws.size();
			if (expwscount==actwscount){
				actualwscount=true;
				expectedwscount=true;
			}
			WA_HomeSteps.assertForBooleanComparision("Show all workspaces count : ",expectedwscount,actualwscount);
			CommonSteps.I_click("wsclose");
		} catch (Exception e) {
			CommonSteps.I_click("wsclose");
			System.out.println("Failed to validate show all workspaces");
		}
	}
	
	@And("^I get total participants count from manage workspace and store to '(.*)'$")
	public static void getWSParticipantsCount(String storewsuserscountto) throws Exception {
		try{
		CommonSteps.I_click("ws3dots");
		CommonSteps.I_should_see_element_Visible_wait(10, "ws3dotssharingandpermissions");
		CommonSteps.I_click("ws3dotssharingandpermissions");
		int wsparticipantscount = driver.findElements(GetPageObject.OR_GetElement("wsparticipantscount")).size();
		System.out.println("Total workspace participants are : "+wsparticipantscount);
		CommonSteps.I_click("sharemanageclose_btn");
		String wspacount=Integer.toString(wsparticipantscount);
		HashMapContainer.add(storewsuserscountto,wspacount );
		} catch (Exception e) {
			CommonSteps.I_click("wsclose");
			System.out.println("Failed to validate show all workspaces");
		}
	}
	


}
