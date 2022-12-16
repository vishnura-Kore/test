package stepDefinitions;

import java.awt.image.BufferedImage;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import com.gargoylesoftware.htmlunit.ElementNotFoundException;

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

/**
 * @ScriptName : Utilities
 * @Description : This class contains Commonly used Keyword for Web application
 *              automation using Cucumber framework
 * 
 */
public class WA_TopicsSteps {

	static WrapperFunctions wrapFunc = new WrapperFunctions();
	static StepBase sb = new StepBase();

	public static WebDriver driver = sb.getDriver();
	static Utilities util = new Utilities();
	static SQLConnector SQLC = new SQLConnector();
	private static BufferedImage bufferedImage;
	private static byte[] imageInByte;
	
	static String unreaddotfortopic1="//span[@class='redDotTopic']/..//span[@class='editTopicName'][text()='";
	static String unreaddotfortopic2="']";

	static String msgele1 = "//div[@id='all-posts']//div[@class='mp-bubbleTextContainer']//span[contains(text(),'";
	static String msgele2 = "')]";
	
	static String replyele1 = "//div[@id='RightMsgSec']//div[@class='mp-bubbleTextContainer']//span[contains(text(),'";
	static String replyele2 = "')]";
	
	static String reply = "/../..//span[@id='waTopicsReply']";
	static String reactions= "/../..//span[@id='waTopicsAddReaction']";
	static String edit= "/../..//span[@id='wwaTopicsEdit']";
	static String more= "/../..//span[@id='wwaTopicsMore']";
	
	static String readby ="//div[@class='readUserInfo'][contains(text(),'Read by')]/../../..//div[@class='userName'][text()='";
	static String deliveredto ="//div[@class='readUserInfo'][contains(text(),'Delivered to')]/../../..//div[@class='userName'][text()='";
	
	static String reactedcountforlike="')]/../..//div[@class='reactionIcons'][text()='1']//i[@class='icon _like']"; 
	static String reactedcountforunlike="')]/../..//div[@class='reactionIcons'][text()='1']//i[@class='icon _unlike']"; 
	
	
	static String like ="')]/../..//div[@class='reactionIcons']//i[contains(@class,'_like')]";
	static String unlike ="')]/../..//div[@class='reactionIcons']//i[contains(@class,'_dislike')]";
	
	@And("^I create topic as '(.*)'$")
	public static void createTopicAndRename(String topicname) throws Exception {
		// GetPageObject.OR_GetElement("expandmoretopics");
		boolean starttopic=false;
		try {
			starttopic = driver.findElements(GetPageObject.OR_GetElement("btn_startanewtopic")).size() > 0;
			if (starttopic){
			CommonSteps.I_click("btn_startanewtopic");
			Thread.sleep(2000);
			}
			CommonSteps.I_click("plusnewtopic");
			Thread.sleep(1000);
			driver.findElement(GetPageObject.OR_GetElement("edittopicname")).sendKeys(topicname);
			CommonSteps.I_send_key("Enter");
		} catch (Exception e) {
			System.out.println("Failed to create topic :" + topicname);
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}
	}

	@And("^I select '(.*)' topic$")
	public static void selectTopic(String topicname) throws Exception {
		boolean topicavalability = false;
		boolean moretopics = false;
		try {
 			CommonSteps.I_click("leftnav_messages");
			moretopics = driver.findElements(GetPageObject.OR_GetElement("expandmoretopics")).size() > 0;
			if (moretopics)
				CommonSteps.I_click("expandmoretopics");
			List<WebElement> alltopics = driver.findElements(GetPageObject.OR_GetElement("lst_tipics"));
			for (WebElement e : alltopics) {
				if(e.getText().trim().equalsIgnoreCase(topicname)){
				e.click();
				topicavalability = true;	
				break;
				}
			}

		} catch (Exception e) {
			System.out.println("Failed to select topic :" + topicname);
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}
	}
	
	@And("^I get active topic from '(.*)' element and compare with expected '(.*)' topic$")
	public static void getActiveTopic(String activetopicelement, String expectedactivetopic) throws Exception {
		try {
			CommonSteps.I_get_text_from(activetopicelement);
			activetopicelement=WA_HomeSteps.getStoredValue(activetopicelement);
			System.out.println("Active topic is :"+activetopicelement);
			WA_HomeSteps.assertForStringComparisition("Active topic should be :", expectedactivetopic, activetopicelement);
		} catch (Exception e) {
			System.out.println("Failed to get current active topic");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}
	}
	
	@And("^I verify existance of delted message '(.*)' in topic$")
	public static void verifyExistanceDeletedMessage(String messagetext) throws Exception {
		messagetext=WA_HomeSteps.getStoredValue(messagetext);
			String message = msgele1 + messagetext + msgele2;
			try {
				WA_HomeSteps.I_should_not_see_onpage(message);
				Thread.sleep(3000);
		} catch (Exception e) {
			System.out.println("Failed to check the existance of deleted message in topics");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}
	}
	
	@And("^I verify existance of delted reply '(.*)' in topic$")
	public static void verifyExistanceOfDeletedReply(String replytext) throws Exception {
		replytext=WA_HomeSteps.getStoredValue(replytext);
			String reply = replyele1 + replytext + replyele2;
			try {
				WA_HomeSteps.I_should_not_see_onpage(reply);
		} catch (Exception e) {
			System.out.println("Failed to check the existance of deleted reply in topics");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}
	}
	
	@And("^I verify '(.*)' topic existance should be '(.*)'$")
	public static boolean verifyTopicVisibilityAndSelect(String topicname, boolean expexistance) throws Exception {
		boolean topicavalability = false;
		boolean moretopics = false;
		try {
			CommonSteps.I_click("leftnav_messages");
		//	moretopics = driver.findElements(By.xpath("//div[@class='topicListItem addMoreItems']")).size() > 0;
			moretopics = driver.findElements(GetPageObject.OR_GetElement("expandmoretopics")).size() > 0;
			if (moretopics)
				CommonSteps.I_click("expandmoretopics");
			List<WebElement> alltopics = driver.findElements(GetPageObject.OR_GetElement("lst_tipics"));
			for (WebElement e : alltopics) {
				e.getText().trim().equalsIgnoreCase(topicname);
				e.click();
				topicavalability = true;
				break;
			}
			return topicavalability;

		} catch (Exception e) {
			System.out.println("Failed to select topic :" + topicname);
		}
		WA_HomeSteps.assertForBooleanComparision("Existance of topic :", expexistance, topicavalability);
		return topicavalability;
	}

	@And("^I perform '(.*)' operation from '(.*)' topic 3dots$")
	public static void topic3DotOperations(String operation, String topicname) throws Exception {
		try {
			String ele1 = "//span[@class='editTopicName'][text()='";
			String ele2 = "']/../../..//span[@class='drArrow']";
			String element = ele1 + topicname + ele2;
			Thread.sleep(1000);
			WA_HomeSteps.moveToElement(element);
			driver.findElement(By.xpath(element)).click();
			switch (operation.trim().toUpperCase()) {
			case "RENAME":
				System.out.println("In topic Rename");
				CommonSteps.I_click("topicrename");
				break;

			case "MUTE":
				System.out.println("In topic Mute");
				CommonSteps.I_click("topicmute");
				break;

			case "VIEW FILES":
				System.out.println("In topic View files");
				CommonSteps.I_click("topicviewfiles");
				break;
				
			case "GET EMAIL":
				System.out.println("In topic get email");
				CommonSteps.I_click("topicgetemail");
				CommonSteps.I_should_see_element_Visible("topicemailcopied");
				Thread.sleep(2000);
				break;

			case "COPY LINK":
				System.out.println("In topic Copy link");
				CommonSteps.I_click("topiccopylink");
				CommonSteps.I_should_see_element_Visible("topiccopylinkcopied");
				break;

			case "MANAGE":
				System.out.println("In topic Manage");
				CommonSteps.I_click("topicmanage");
				Thread.sleep(2000);
				break;
				
			case "NA":
				System.out.println("I just enabled topic 3 dots");
				break;

			default:
				System.out.println("Please provide valid parameters to perform operations on a specific topic");
			}

		} catch (Exception e) {
			System.out.println("Failed to select topic and perform operations on it:");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}
	
	@Then("^I remove member '(.*)' from topic$")
	public static void removeUsersFromTopic(String usernametoremove){
		//span[@id='select-members']//ul/li//div[@class='npInputName']/..//div[contains(text(),'Lisa Linde')]/../../..//span[@class='p-autocomplete-token-icon pi pi-times-circle']
		String ele1 = "//span[@id='select-members']//ul/li//div[@class='npInputName']/..//div[contains(text(),'";
		String ele2 = "')]/../../..//span[@class='p-autocomplete-token-icon pi pi-times-circle']";
		String useremovecloseicon = ele1 + usernametoremove + ele2;
		
		List<WebElement> allmembers = driver.findElements(GetPageObject.OR_GetElement("topicmembers"));
		for (WebElement e : allmembers) {
			e.getText().trim().equalsIgnoreCase(usernametoremove);
			driver.findElement(By.xpath(useremovecloseicon)).click();
			break;
		}
	
	}
	
	@Then("^I select all workspace option true/false '(.*)' and compare selection true/false '(.*)'$")
	public static void selectAllWorkspaceMembersAndCompare(boolean select, boolean visibilityofallwsselection) throws Exception{
		if(select)
		CommonSteps.I_click("manageallworkspace");
		Thread.sleep(2000);
		boolean selectedallwsmembers =false;
		selectedallwsmembers = driver.findElements(GetPageObject.OR_GetElement("manageallworkspaceicon")).size() > 0;
		WA_HomeSteps.assertForBooleanComparision("All @ Workspace members ", true, selectedallwsmembers);
	}
	
	@Then("^I select limited workspace option true/false '(.*)' and compare selection true/false '(.*)'$")
	public static void selectLimitedWorkspaceAndCompare(boolean select, boolean visibilityofallwsselection) throws Exception{
		if(select)
		CommonSteps.I_click("mangelimitedmembers");
		Thread.sleep(2000);
		boolean selectedallwsmembers =false;
		selectedallwsmembers = driver.findElements(GetPageObject.OR_GetElement("managealimitedworkspaceicon")).size() > 0;
		WA_HomeSteps.assertForBooleanComparision("Limited workspace members ", true, selectedallwsmembers);
	}
	
	@And("^I delete topic$")
	public static void deleteTopic() {
		try {
		//	CommonSteps.I_mouse_over("btn_managedeletetopic");
			String deletetopic = "//div[@class='leaveBtn'][text()='Delete']";
			WA_HomeSteps.moveToElement(deletetopic);
		//	WA_HomeSteps.moveToDelete(deletetopic);
			CommonSteps.I_click("btn_managedeletetopic");
			CommonSteps.I_should_see_element_Visible_wait(5, "topicsdeleteconfirmation");
			CommonSteps.I_click("topicsdeleteconfirmation");
			Thread.sleep(3000);
		} catch (Exception e) {
			System.out.println("Failed to delete topic");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}
	}
	
	@And("^I send message '(.*)' in topic$")
	public static void sendMessageInTopic(String sendmessageas) throws Exception {
		sendmessageas=WA_HomeSteps.getStoredValue(sendmessageas);
		try {
			Thread.sleep(1000);
			try{
				driver.findElement(GetPageObject.OR_GetElement("startnewmessage")).click();
			}catch (Exception e){
			System.out.println("Start new message button is not displayed hence continued to send message in the compose bar");
			}
			CommonSteps.I_enter_in_field(sendmessageas, "msgcomposebar");
			CommonSteps.I_send_key("Enter");
			Thread.sleep(1000);
		} catch (Exception e) {
			System.out.println("Failed to send messgaes: " + sendmessageas);
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}
	
	@And("^I send reply '(.*)' in topic$")
	public static void sendReply(String sendreplyas) throws Exception {
		sendreplyas=WA_HomeSteps.getStoredValue(sendreplyas);
		try {
			Thread.sleep(1000);
			CommonSteps.I_enter_in_field(sendreplyas, "reply_composebar");
			CommonSteps.I_send_key("Enter");
			Thread.sleep(1000);
		} catch (Exception e) {
			System.out.println("Failed to send reply: " + sendreplyas);
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}
	
	@And("^I paste in message/reply '(.*)'$")
	public static void pasteMessageOrReply(String coposebarelement) {
		
		int boardcardsize_b4paste = driver.findElements(GetPageObject.OR_GetElement("topics_boardcard")).size();
		int boardcardsize_afterpaste;
		try {
			driver.findElement(GetPageObject.OR_GetElement("startnewmessage")).click();
		} catch (Exception e) {
			System.out.println(
					"Start new message button is not displayed hence continued to send message in the compose bar");
		}
		try {
			WebElement webElement = driver.findElement(GetPageObject.OR_GetElement(coposebarelement));
			JavascriptExecutor executor = (JavascriptExecutor) driver;
			executor.executeScript("arguments[0].click();", webElement);
			webElement.sendKeys(Keys.chord(Keys.CONTROL, "v"));
			Thread.sleep(1000);
			CommonSteps.I_send_key("Enter");
			boardcardsize_afterpaste = driver.findElements(GetPageObject.OR_GetElement("topics_boardcard")).size();
			
			if (boardcardsize_afterpaste>boardcardsize_b4paste){
				System.out.println("PASS : Pasted topic copy link successfully");
			}else {
				StepBase.embedScreenshot();
				System.out.println("FAIL : Failed to Paste topic copy link in message/reply compose bar");
			}
		} catch (Exception e) {
			throw new ElementNotFoundException(e.getMessage(), "", "");
			//exception.printStackTrace();
		}
	}
	
	@And("^I check at mention users for Messages/Replies '(.*)' and store users count to '(.*)'$")
	public static void verifyAtMentionUsersForMessagesorReplies(String messagesOrreplies, String storatmentionuses) throws Exception {
		storatmentionuses=WA_HomeSteps.getStoredValue(storatmentionuses);
		String hmwsuserscount=WA_HomeSteps.getStoredValue("hmwsuserscount");
		try {
		if (messagesOrreplies.equalsIgnoreCase("Messages")){
			CommonSteps.I_click("startnewmessage");
			CommonSteps.I_should_see_element_Visible("msgcomposebar");
			driver.findElement(GetPageObject.OR_GetElement("msgcomposebar")).sendKeys("@");
			int atmentionusers = driver.findElements(GetPageObject.OR_GetElement("atmentionusernames")).size()-1;
		//	int actmentionsize = atmentionusers.size();
			String actwsmemcount = Integer.toString(atmentionusers);
			CommonSteps.I_clear_Field("msgcomposebar");
			HashMapContainer.add(storatmentionuses, actwsmemcount);
			WA_HomeSteps.assertForStringComparisition("At mention users count", hmwsuserscount, actwsmemcount);
		
			
		}else if (messagesOrreplies.equalsIgnoreCase("Replies")){
			CommonSteps.I_should_see_element_Visible("reply_composebar");
			driver.findElement(GetPageObject.OR_GetElement("reply_composebar")).sendKeys("@");
			int atmentionusers = driver.findElements(GetPageObject.OR_GetElement("atmentionusernames")).size()-1;
			String actwsmemcount = Integer.toString(atmentionusers);
			CommonSteps.I_clear_Field("reply_composebar");
			HashMapContainer.add(storatmentionuses, actwsmemcount);
			WA_HomeSteps.assertForStringComparisition("At mention users count", hmwsuserscount, actwsmemcount);
		
		}
				
		} catch (Exception e) {
			System.out.println("Failed to validate @mention users");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}
	
	@And("^I send message '(.*)' with atmention user '(.*)'$")
	public static void sendMessageWithAtMentionUser(String sendmessageas, String mentionusermail) throws Exception {
		sendmessageas=WA_HomeSteps.getStoredValue(sendmessageas);
		try {
			CommonSteps.I_click("startnewmessage");
			CommonSteps.I_should_see_element_Visible("msgcomposebar");
			driver.findElement(GetPageObject.OR_GetElement("msgcomposebar")).sendKeys("@");
			List<WebElement> atmentionusers = driver.findElements(GetPageObject.OR_GetElement("atmentionusernames"));
				for (WebElement e : atmentionusers) {
					String currentuser = e.getText();
					System.out.println(e.getText());
					WA_HomeSteps.moveToElement("//table[@class='mentionDialogBoxTable']//span[@class='mentionEmailId']//span[text()='"+currentuser+"']");
					if (e.getText().trim().equalsIgnoreCase(mentionusermail)) {
						e.click();
						break;
					}
				}
			driver.findElement(GetPageObject.OR_GetElement("msgcomposebar")).sendKeys(sendmessageas);
			CommonSteps.I_send_key("Enter");
			Thread.sleep(500);
		} catch (Exception e) {
			System.out.println("Failed to send message with @ mention");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}
	
	@And("^I send reply '(.*)' with atmention user '(.*)'$")
	public static void sendReplyWithAtMentionUser(String sendreplyas, String mentionusermail) throws Exception {
		sendreplyas=WA_HomeSteps.getStoredValue(sendreplyas);
		try {
			CommonSteps.I_should_see_element_Visible("reply_composebar");
			driver.findElement(GetPageObject.OR_GetElement("reply_composebar")).sendKeys("@");
			List<WebElement> atmentionusers = driver.findElements(GetPageObject.OR_GetElement("atmentionusernames"));
				for (WebElement e : atmentionusers) {
					String currentuser = e.getText();
					System.out.println(e.getText());
					WA_HomeSteps.moveToElement("//table[@class='mentionDialogBoxTable']//span[@class='mentionEmailId']//span[text()='"+currentuser+"']");
					if (e.getText().trim().equalsIgnoreCase(mentionusermail)) {
						e.click();
						break;
					}
				}
			driver.findElement(GetPageObject.OR_GetElement("reply_composebar")).sendKeys(sendreplyas);
			CommonSteps.I_send_key("Enter");
			Thread.sleep(500);
		} catch (Exception e) {
			System.out.println("Failed to send reply with @ mention");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}
	
	/**
	 * @param messagetext
	 *            : Actions will perform on this message
	 * @param performaction
	 *            : If this flag is true, then followed action will be performed
	 * @param action
	 *            : This parameter is valid only when @performaction is true
	 * @throws Exception
	 *             : Fail, if it fail to perform action on the given message
	 */

	@Then("^I go to message '(.*)' and perform on hover action '(.*)' as '(.*)'$")
	public static void goToMessageAndPerform(String messagetext, boolean performaction, String action)
			throws Exception {
		messagetext=WA_HomeSteps.getStoredValue(messagetext);
		String message = msgele1 + messagetext + msgele2;
		try {

			WA_HomeSteps.moveToElement(message);

			if (performaction) {
				switch (action.trim().toUpperCase()) {
				case "REPLY":
					String replypath = message + reply;
				//	WA_HomeSteps.moveToElement(replypath);
					WA_HomeSteps.clickWithtextBasedXpath(replypath);
					System.out.println("Clicked on reply");
					break;

				case "REACTIONS":
					String reactionspath = message + reactions;
					WA_HomeSteps.clickWithtextBasedXpath(reactionspath);
					System.out.println("Clicked on Add Reaction");
					break;

				case "EDIT":
					String editpath = message + edit;
					WA_HomeSteps.clickWithtextBasedXpath(editpath);
					System.out.println("Clicked on Edit");
					WA_HomeSteps.I_enter_text("Editednow",message);
					CommonSteps.I_click("edit_done");
					CommonSteps.I_should_see_element_Visible("lbl_edited");
					System.out.println("Sent Edited message");
					break;

				case "MORE":
					String morepath = message + more;
					WA_HomeSteps.moveToElement(morepath);
					WA_HomeSteps.clickWithtextBasedXpath(morepath);
					System.out.println("Clicked on More");
					break;
					
				default:
					System.out.println("Please provided valid on hover action i.e. , should be match with case value");
				}
			}else {
				WA_HomeSteps.clickWithtextBasedXpath(message);
			}
			Thread.sleep(500);
		} catch (Exception e) {
			System.out.println("Issue occured in goToMessageAndPerform -->" + messagetext + "-->" + action);
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}
	
	/**
	 * @param messagetext
	 *            : Actions will perform on this reply
	 * @param performaction
	 *            : If this flag is true, then followed action will be performed
	 * @param action
	 *            : This parameter is valid only when @performaction is true
	 * @throws Exception
	 *             : Fail, if it fail to perform action on the given reply
	 */

	@Then("^I go to reply '(.*)' and perform on hover action '(.*)' as '(.*)'$")
	public static void goToReplyAndPerform(String replytext, boolean performaction, String action)
			throws Exception {
		replytext=WA_HomeSteps.getStoredValue(replytext);
		String reply = replyele1 + replytext + replyele2;
		try {

			WA_HomeSteps.moveToElement(reply);

			if (performaction) {
				switch (action.trim().toUpperCase()) {
				
				case "REACTIONS":
					String reactionspath = reply + reactions;
					WA_HomeSteps.clickWithtextBasedXpath(reactionspath);
					System.out.println("Clicked on Add Reaction");
					break;

				case "EDIT":
					String editpath = reply + edit;
					WA_HomeSteps.clickWithtextBasedXpath(editpath);
					System.out.println("Clicked on Edit");
					WA_HomeSteps.I_enter_text("Editednow",reply);
					CommonSteps.I_click("edit_done");
					CommonSteps.I_should_see_element_Visible("lbl_edited");
					System.out.println("Sent Edited reply");
					break;

				case "MORE":
					String morepath = reply + more;
					WA_HomeSteps.moveToElement(morepath);
					WA_HomeSteps.clickWithtextBasedXpath(morepath);
					System.out.println("Clicked on More");
					break;
					
				default:
					System.out.println("Please provided valid on hover action i.e. , should be match with case value");
				}
			}else {
				System.out.println("Hover on reply and do nothing");
			}
			Thread.sleep(500);
		} catch (Exception e) {
			System.out.println("Issue occured in goToReplyAndPerform -->" + replytext + "-->" + action);
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}
	
	@And("^I delete the selected messag/reply$")
	public static void deleteMessageOrReply() throws Exception {
		try {
			CommonSteps.I_click("reply_more_delete");
			CommonSteps.I_should_see_element_Visible_wait(5, "topicsdeleteconfirmation");
			CommonSteps.I_click("topicsdeleteconfirmation");
			Thread.sleep(1000);
		} catch (Exception e) {
			System.out.println("Failed to send reaction: ");
			throw new ElementNotFoundException(e.getMessage(), "", "");
			}

		}
	
	@And("^I validate message '(.*)' on hover options from sender/recipient '(.*)'$")
	public static void verifyMessageOnHoverOptions(String messagetext, String senderorrecipient) throws Exception {
		messagetext=WA_HomeSteps.getStoredValue(messagetext);
		String message = msgele1 + messagetext + msgele2;
		
		String replypath = message + reply;
		String reactionspath = message + reactions;
		String editpath = message + edit;
		String morepath = message + more;
		
		try {
			
			WA_HomeSteps.moveToElement(message);
			if (senderorrecipient.equalsIgnoreCase("SENDER")){
				WA_HomeSteps.I_should_see_element_visibility(replypath);
				WA_HomeSteps.I_should_see_element_visibility(reactionspath);
				WA_HomeSteps.I_should_see_element_visibility(editpath);
				WA_HomeSteps.I_should_see_element_visibility(morepath);
				
				WA_HomeSteps.moveToElement(morepath);
				CommonSteps.I_click(morepath);
				CommonSteps.I_should_see_element_Visible("onhover_more_forward");
				CommonSteps.I_should_see_element_Visible("onhover_more_copy");
				CommonSteps.I_should_see_element_Visible("onhover_more_messageinfo");
				CommonSteps.I_should_see_element_Visible("onhover_more_delete");
				
			}else if (senderorrecipient.equalsIgnoreCase("RECIPIENT")){
					WA_HomeSteps.I_should_see_element_visibility(replypath);
					WA_HomeSteps.I_should_see_element_visibility(reactionspath);
					WA_HomeSteps.I_should_not_see_onpage(editpath);
					WA_HomeSteps.I_should_see_element_visibility(morepath);
					WA_HomeSteps.moveToElement(morepath);
					CommonSteps.I_click(morepath);
					CommonSteps.I_should_see_element_Visible("onhover_more_forward");
					CommonSteps.I_should_see_element_Visible("onhover_more_copy");
					CommonSteps.I_should_not_see_on_page("onhover_more_messageinfo");
					CommonSteps.I_should_not_see_on_page("onhover_more_delete");
				}
		} catch (Exception e) {
			System.out.println("Failed to validate message on hover options at : "+senderorrecipient);
			throw new ElementNotFoundException(e.getMessage(), "", "");
			}
		}
	
	
	@And("^I validate reply '(.*)' on hover options from sender/recipient '(.*)'$")
	public static void verifyReplyOnHoverOptions(String replytext, String senderorrecipient) throws Exception {
		replytext=WA_HomeSteps.getStoredValue(replytext);
		String reply = replyele1 + replytext + replyele2;
		
		String reactionspath = reply + reactions;
		String editpath = reply + edit;
		String morepath = reply + more;
		
		try {
			
			WA_HomeSteps.moveToElement(reply);
			if (senderorrecipient.equalsIgnoreCase("SENDER")){
				WA_HomeSteps.I_should_see_element_visibility(reactionspath);
				WA_HomeSteps.I_should_see_element_visibility(editpath);
				WA_HomeSteps.I_should_see_element_visibility(morepath);
				
				WA_HomeSteps.moveToElement(morepath);
				CommonSteps.I_click(morepath);
				CommonSteps.I_should_see_element_Visible("reply_more_delete");
				CommonSteps.I_should_see_element_Visible("reply_more_replyinfo");
				
				}else if (senderorrecipient.equalsIgnoreCase("RECIPIENT")){
					WA_HomeSteps.I_should_see_element_visibility(reactionspath);
					WA_HomeSteps.I_should_not_see_onpage(editpath);
					WA_HomeSteps.I_should_not_see_onpage(morepath);
				}
		} catch (Exception e) {
			System.out.println("Failed to validate reply on hover options at : "+senderorrecipient);
			throw new ElementNotFoundException(e.getMessage(), "", "");
			}
		}
	
	
			@Then("^I send reaction to message '(.*)' as '(.*)'$")
			public static void sendReaction(String reactiononmessage,String reaction)throws Exception {
				Thread.sleep(1000);
				reactiononmessage=WA_HomeSteps.getStoredValue(reactiononmessage);
				try {
					switch (reaction.trim().toUpperCase()) {
						case "LIKE":
							WA_HomeSteps.clickWithtextBasedXpath(msgele1+reactiononmessage+like);
							Thread.sleep(500);
							System.out.println("Clicked on Like Reaction");
							break;

						case "UNLIKE":
							WA_HomeSteps.clickWithtextBasedXpath(msgele1+reactiononmessage+unlike);
							Thread.sleep(500);
							System.out.println("Clicked on Dislike Reaction");
							break;

							
						default:
							System.out.println("Please provided valid on hover action i.e. , should be match with case value");
						}
					Thread.sleep(500);
				} catch (Exception e) {
					System.out.println("Failed to react on a message");
					throw new ElementNotFoundException(e.getMessage(), "", "");
				}

			}
	
	@And("^I verify visibility of '(.*)' reaction on '(.*)' should be true/false '(.*)'$")
	public static void verifyReaction(String reaction, String reactiontomessage, boolean visibleornot) throws Exception{
		reactiontomessage=WA_HomeSteps.getStoredValue(reactiontomessage);
		Thread.sleep(500);
		try {
			
			switch (reaction.trim().toLowerCase()) {
			case "like":
				if (visibleornot){
				WA_HomeSteps.I_should_see_element_visibility(msgele1+reactiontomessage+reactedcountforlike);
				}else {
					WA_HomeSteps.I_should_not_see_onpage(msgele1+reactiontomessage+reactedcountforlike);
				}
				System.out.println("Validated like reaction");
				break;

			case "unlike":
				if (visibleornot){
				WA_HomeSteps.I_should_see_element_visibility(msgele1+reactiontomessage+reactedcountforunlike);
				}else {
					WA_HomeSteps.I_should_not_see_onpage(msgele1+reactiontomessage+reactedcountforunlike);
				}
				Thread.sleep(500);
				System.out.println("Validated unlike reaction");
				break;

				
			default:
				System.out.println("Please provided valid reaction and message to validate");
			}
			
		} catch (Exception e) {
			System.out.println("Failed to validate the visibility of : "+reaction+" reaction");
		//	throw new CucumberException(e.getMessage(), e);
			throw new ElementNotFoundException(msgele1+reactiontomessage+reactedcountforlike, "", "");
				
			}
		}
	
	@And("^I verify the visibility of unread dot for workspace named as'(.*)' should be '(.*)'$")
	public static void verifyUnReadDotForWorkspace(String workspacename, boolean unreaddotvisibility) throws Exception{
		String unreaddotforws1="//span[@class='wsnctc-name']//span[text()='";
		String unreaddotforws2="']/../../../..//div[@class='red-dot test']";
		String unreaddotforworkspace=unreaddotforws1+workspacename+unreaddotforws2;
		CommonSteps.I_mouse_over("wswsicon");
		if (unreaddotvisibility){
			WA_HomeSteps.I_should_see_element_visibility(unreaddotforworkspace);
		}else {
			WA_HomeSteps.I_should_not_see_onpage(unreaddotforworkspace);
		}
	}
	
	@And("^I verify the visibility of unread dot for messages should be true/false '(.*)'$")
	public static void verifyUnReadDotForWorkspace(boolean unreaddotvisibility) throws Exception{
		CommonSteps.I_click("leftnav_messages");
		if (unreaddotvisibility){
			CommonSteps.I_should_see_element_Visible("unreaddot_message");
		}else {
			CommonSteps.I_should_not_see_on_page("unreaddot_message");
		}
	}
	
	@And("^I verify the visibility of unread dot for topic '(.*)' should be true/false '(.*)'$")
	public static void verifyVisibilityTopicUnreadDot(String topicname, boolean unreaddotvisibility) throws Exception{
		
		String unreaddotfortopic=unreaddotfortopic1+topicname+unreaddotfortopic2;
	//	selectTopic(topicname);
	//	CommonSteps.I_should_see_element_Visible("new_timelinetag");
		if (unreaddotvisibility){
			WA_HomeSteps.I_should_see_element_visibility(unreaddotfortopic);
		}else {
			WA_HomeSteps.I_should_not_see_onpage(unreaddotfortopic);
		}
	}
	
	//Need to retest with possible conditions --> Do not use this
	@And("^I verify the functionality of unread dot for topic$")
	public static String verifyUnReadDotfunctionalityForTopic() throws Exception{
		boolean topicredot=false;
		String reddottopic = null;
		topicredot=driver.findElements(GetPageObject.OR_GetElement("unreaddot_topic")).size()>0;
		List<WebElement> allredottopics = driver.findElements(GetPageObject.OR_GetElement("unreaddot_topic"));
		for (WebElement e : allredottopics) {
			reddottopic=e.getText();
			verifyNewTimelineAndUnReadDotForTopic(reddottopic);
		}
		
		return reddottopic;
	}
	
	
	@And("^I verify new timeline tag topicname '(.*)'$")
	public static void verifyNewTimelineAndUnReadDotForTopic(String topicname) throws Exception{
		String unreaddotfortopic=unreaddotfortopic1+topicname+unreaddotfortopic2;
		selectTopic(topicname);
		CommonSteps.I_should_see_element_Visible("new_timelinetag");
		WA_HomeSteps.I_should_not_see_onpage(unreaddotfortopic);
	}
	
	@And("^I verify message info for user '(.*)' and should be under ReadBy/DeliveredTo '(.*)'$")
	public static void verifyMessageInfo(String username, String readordelivered) throws Exception {
		try {
			Thread.sleep(500);
			CommonSteps.I_click("onhover_more_messageinfo");
			CommonSteps.I_should_see_element_Visible("messageinfoheader");
			if (readordelivered.equalsIgnoreCase("READBY")){
				WA_HomeSteps.I_should_see_element_visibility(readby+username+"']");
				WA_HomeSteps.I_should_not_see_onpage(deliveredto+username+"']");
			}else if (readordelivered.equalsIgnoreCase("DELIVEREDTO")){
				WA_HomeSteps.I_should_see_element_visibility(deliveredto+username+"']");
				WA_HomeSteps.I_should_not_see_onpage(readby+username+"']");
				
			}
			CommonSteps.I_click("managecloseicon");
			
		} catch (Exception e) {
			CommonSteps.I_click("managecloseicon");
			System.out.println("Failed to validate message info");
			throw new ElementNotFoundException(e.getMessage(), "", "");
			}

		}
	
	@And("^I verify reply info for user '(.*)' and should be under ReadBy/DeliveredTo '(.*)'$")
	public static void verifyReplyInfo(String username, String readordelivered) throws Exception {
		try {
			Thread.sleep(500);
			CommonSteps.I_click("reply_more_replyinfo");
			CommonSteps.I_should_see_element_Visible("replyinfoheader");
			if (readordelivered.equalsIgnoreCase("READBY")){
				WA_HomeSteps.I_should_see_element_visibility(readby+username+"']");
				WA_HomeSteps.I_should_not_see_onpage(deliveredto+username+"']");
			}else if (readordelivered.equalsIgnoreCase("DELIVEREDTO")){
				WA_HomeSteps.I_should_see_element_visibility(deliveredto+username+"']");
				WA_HomeSteps.I_should_not_see_onpage(readby+username+"']");
				
			}
			CommonSteps.I_click("managecloseicon");
			
		} catch (Exception e) {
			CommonSteps.I_click("managecloseicon");
			System.out.println("Failed to validate reply info");
			throw new ElementNotFoundException(e.getMessage(), "", "");
			}

		}
	
}
