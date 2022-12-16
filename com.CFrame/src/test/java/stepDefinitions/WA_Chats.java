package stepDefinitions;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.crypto.BadPaddingException;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;

import com.gargoylesoftware.htmlunit.ElementNotFoundException;

import framework.HashMapContainer;
import framework.SQLConnector;
import framework.StepBase;
import framework.Utilities;
import framework.WrapperFunctions;
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
public class WA_Chats {

	static WrapperFunctions wrapFunc = new WrapperFunctions();
	static StepBase sb = new StepBase();

	public static WebDriver driver = sb.getDriver();
	static Utilities util = new Utilities();
	static SQLConnector SQLC = new SQLConnector();
	private static BufferedImage bufferedImage;
	private static byte[] imageInByte;

	static String contactsuggestions1 = "//div[@class='p-clearfix userDetailBox']//div[@class='userDetail']";

	static String chatsactivethread = "//div[@class='userDetails active hasSnapshot chat']//div[@class='userNameDiv']";

	static String chatrightpanelicon = "//span[@class='chatUserIcon']";

	static String chatthreadname1 = "//span[contains(@class,'tooltipsName')][text()='";

	static String closetextbrace = "']";

	static String chatthreadnamedesc3 = "/../../../..//div[@class='userChatDEsc']";

	static String muteicon = "']/../../../../..//div[contains(@class,'icon __i')]//*[local-name()='svg'][contains(@class,'wa-Audio')]";

	static String unmuteicon = "']/../../../../..//div[contains(@class,'icon __i')]//*[local-name()='svg'][contains(@class,'wa-Mute')]";

	static String markasunreadicon = "']/../../../../..//div[contains(@class,'icon __i')]//*[local-name()='svg'][contains(@class,'wa-EyeLash')]";

	static String markasreadicon = "']/../../../../..//div[contains(@class,'icon __i')]//*[local-name()='svg'][contains(@class,'wa-Eye')]";

	static String unreadbadgeicon = "']/../../../..//span[@class='unreadCount']";

	static String more3dots = "']/../../../../..//div[contains(@class,'icon __i')]//*[local-name()='svg'][contains(@class,'wa-EllipsisVertical')]";

	static String muteslotfor = "//div[@class='dorpDownBoxMute msgThreadDD']//li[@class='dorpDownBoxLI']";

	static String leftactivegroupicon = "']/../../../../..//div[@class='avatarDiv']//span[contains(@class,'leftAvatar')]";

	static String leftactivegroupcount = "']/../../../../..//div[@class='avatarDiv']//span[@class='countAvatar']";

	static String chattimeline1 = "//div[@class='msgMemberTimeline']//span[@class='timelineCntr']/span[@class='messageOnly'][contains(text(),'";

	static String manageparticipant = "//span[@class='member'][text()='Member']/../../..//div[@class='emailUi']";

	static String chatheader1 = "//p[@class='chatUserTitle']//span[text()='";

	static String chatheadermsg1 = "']/../../../../../../..//div[@class='send-message' and text()='";

	static String chatheadermsgselection1 = "']/../../../..//span[@class='checkmark']";

	static String chatmsgele1 = "//span[contains(@class,'msgText')]//div[@class='send-message'][text()='";

	static String reactions = "/..//*[local-name()='svg'][contains(@class,'wa-EmojiSmile')]";

	static String reply = "/..//span[@class='icoBlock replyBlock']";

	static String edit = "/..//*[local-name()='svg'][contains(@class,'wa-Pencil')]";

	static String more = "/..//*[local-name()='svg'][contains(@class,'wa-EllipsisVertical')]";

	static String replybubblefor1 = "//div[contains(@class,'replyMessage replyMessageBubble')]//div[@class='replayBubbleText one'][text()='";

	static String like = "']/..//div[@class='reactionIcons']//i[@class='icon _like']";

	static String unlike = "']/..//div[@class='reactionIcons']//i[@class='icon _dislike']";

	static String reactedcountforlike = "')]/../..//div[@class='reactionIcons'][text()='1']//i[@class='icon _like']";

	static String reactedcountforunlike = "')]/../..//div[@class='reactionIcons'][text()='1']//i[@class='icon _unlike']";

	/**
	 * @Description : To select an option after clicking on plus icon
	 * @param userchoice
	 *            : this should be either chat or discussion
	 * @throws Exception
	 */

	@And("^I navigate to chats$")
	public static void navigateToChats() throws Exception {
		CommonSteps.I_should_see_element_Visible_wait(10, "wachaticon");
		CommonSteps.I_click("wachaticon");
	}

	@And("^I start new chat$")
	public static void startNewChat() throws Exception {
		CommonSteps.I_click("newchat");
		Thread.sleep(1000);
	}

	@And("^I close new chat$")
	public static void closeNewChat() throws Exception {
		CommonSteps.I_click("closenewchat");
		Thread.sleep(1000);
	}

	@And("^I check default contact suggestions for a new chat$")
	public static void checkDefaultFocus_Recents() throws Exception {
		try {
			List<WebElement> recents = driver.findElements(GetPageObject.OR_GetElement("chatcontactsuggestions"));
			if (recents.size() > 0) {
				System.out.println("PASS ..Displayed recent contact suggestions");
			} else {
				System.out.println("FAIL ..Recent contact suggestions are not displayed for new chat ");
			}
		} catch (Exception e) {
			CommonSteps.I_click("closenewchat");
			System.out.println("FAIL .. Failed to validate new chat flow with recent contact suggestions");
		}
	}

	/**
	 * 
	 * @param nameorletter
	 *            : To check the suggestions based on this parameter
	 * @throws Exception
	 */

	@And("^I check contact suggestion validation for '(.*)'$")
	public static void checkMatchesWith(String nameorletter) throws Exception {
		try {
			int i = 1;
			// startNewChat();
			CommonSteps.I_click("addpeople");
			CommonSteps.I_enter_in_field(nameorletter, "addpeople");
			Thread.sleep(1000);
			CommonSteps.I_should_see_element_Visible_wait(5, "chatcontactsuggestions");
			List<WebElement> msuggestions = driver.findElements(GetPageObject.OR_GetElement("chatcontactsuggestions"));
			System.out.println("Displayed suggestion list is : " + msuggestions.size());

			for (WebElement e : msuggestions) {
				WA_HomeSteps.moveToElement(contactsuggestions1 + "//div[@class='userEmailId'])" + "[" + i + "]");
				String username = driver.findElement(By.xpath("(" + contactsuggestions1 + "//div[1])" + "[" + i + "]"))
						.getText();
				String useremail = driver
						.findElement(
								By.xpath("(" + contactsuggestions1 + "//div[@class='userEmailId'])" + "[" + i + "]"))
						.getText();
				System.out.println(username);
				System.out.println(useremail);
				if (!username.contains(nameorletter) && (!useremail.contains(nameorletter))
						&& (!useremail.toUpperCase().contains(nameorletter))
						&& (!username.toUpperCase().contains(nameorletter))) {
					System.out.println("FAIL");
				}
				i++;
			}
			// CommonSteps.I_click("closenewchat");

		} catch (Exception e) {
			// CommonSteps.I_click("closenewchat");
			System.out.println("FAIL .. Failed to check contact suggestions with exect match");
		}
	}

	@And("^I add participant '(.*)'$")
	public static void selectParticipants(String participant) throws Exception {
		try {
			CommonSteps.I_click("addpeople");
			CommonSteps.I_enter_in_field_without_clear(participant, "addpeople");
			driver.findElement(GetPageObject.OR_GetElement("addpeople")).sendKeys(Keys.BACK_SPACE);
			Thread.sleep(1000);
			driver.findElement(GetPageObject.OR_GetElement("addpeople")).sendKeys(Keys.BACK_SPACE);
			Thread.sleep(1000);
			CommonSteps.I_wait_for_presence_of_element(10, "chatcontactsuggestions");
			List<WebElement> mailid = driver
					.findElements(By.xpath(contactsuggestions1 + "//div[@class='userEmailId']"));
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
	 * 
	 * @param groupname
	 *            : This will be your group name for a new group
	 * @throws Exception
	 */
	@And("^I create group name as '(.*)'$")
	public static void createGroupAs(String groupname) throws Exception {
		try {
			CommonSteps.I_click("chatgroupchevronicon");
			CommonSteps.I_click("chatgroupname");
			CommonSteps.I_enter_in_field(groupname, "chatgroupname");
		} catch (Exception e) {
			System.out.println("Failed to create a group name");
		}
	}

	@And("^I get active threadname from right panel and store to '(.*)'$")
	public static void getActiveThreadNameFromRightPanel(String chatheadername) throws Exception {
		String chatheader = "null";
		try {
			chatheader = driver.findElement(GetPageObject.OR_GetElement("chatheadername")).getText();
			HashMapContainer.add(chatheadername, chatheader);
		} catch (Exception e) {
			System.out.println("Right panel chat header name is :" + chatheader);
		}
	}

	public static int getGroupCountFromRightPanel() throws Exception {
		String chatgroupcount = "null";
		int groupcount = 0;
		try {
			chatgroupcount = driver.findElement(GetPageObject.OR_GetElement("chatgroupcount")).getText();
			groupcount = Integer.parseInt(chatgroupcount);

			// HashMapContainer.add(activegoupcount, chatgroupcount);
		} catch (Exception e) {
			System.out.println("Selected group count is :" + chatgroupcount);
		}
		return groupcount;
	}

	@And("^I get active chat background color and compare with '(.*)'$")
	public static void getActiveThreadBackgroundColor(String expected) throws Exception {
		String actbckgclr = null;
		Thread.sleep(5000);
		try {
			String cted = "rgba(179, 186, 200, 0.58)";
			actbckgclr = driver.findElement(GetPageObject.OR_GetElement("activechat")).getCssValue("background-color");
			System.out.println("$$$$$$$$$$$$$" + actbckgclr);
			System.out.println("Actual background for active thread with RGBA values as : " + cted);
			if (cted.equals(actbckgclr)) {
				System.out.println("PASS .. Background color is as expected");
			} else {
				System.out.println("FAIL .. Background color is not same");
			}
		} catch (Exception e) {
		}
	}

	/**
	 * @Description : To get right side profile icons count
	 * @return
	 * @throws Exception
	 */
	@And("^I get active chat profile icons count from right panel$")
	public static void rightPaneProfileAvtarCount() throws Exception {
		String count = null;
		int i = 0;
		try {
			boolean groupflagprofileicon = false;
			boolean groupcountavtarflag = false;
			boolean onetooneavtarflag = false;

			groupflagprofileicon = driver
					.findElements(By.xpath(chatrightpanelicon + "//span[@class='nameAvatar triple']")).size() > 0;
			groupcountavtarflag = driver.findElements(By.xpath(chatrightpanelicon + "//span[@class='countAvatar']"))
					.size() > 0;
			onetooneavtarflag = driver
					.findElements(By.xpath(chatrightpanelicon + "//span[@class='nameAvatar single ']")).size() > 0;

			if (groupflagprofileicon) {

				if (groupflagprofileicon && groupcountavtarflag) {
					count = driver.findElement(By.xpath(chatrightpanelicon + "//span[@class='countAvatar']")).getText();
					i = Integer.parseInt(count);
					i = i + 1;
					System.out.println("This thread is having " + i + " participants");
				} else {
					count = driver.findElement(By.xpath(chatrightpanelicon + "//span[@class='nameAvatar single ']"))
							.getText();
					System.out.println("Seems this thread is one to one chat and having profile icon as " + count);
					i = 1;
				}
			}

		} catch (Exception e) {
			System.out.println("");
		}
	}

	/**
	 * @Description : TO validate @ mention functionality
	 * @param groupcount
	 *            : Group count will be the input parameter
	 * @param select
	 *            : If this is true select user parameter should be mentioned
	 * @param selectuser
	 *            : This is mandatory when select is true
	 * @throws Exception
	 */
	@And("^I validate at mention users and select user '(.*)' true/false '(.*)'$")
	public static void atMentionValidation(String selectuser, boolean select) throws Exception {
		try {
			int grpcount = getGroupCountFromRightPanel();
			int witheveryone = grpcount + 1;
			CommonSteps.I_enter_in_field("@", "chatmsgcomposebar");
			List<WebElement> atmentionusers = driver.findElements(GetPageObject.OR_GetElement("atmentionusermailids"));
			int atsize = atmentionusers.size();
			if (witheveryone == atsize) {
				System.out.println("PASS @ mention size is equal");
			} else {
				System.out.println("PASS @ mention size is not equal");
			}
			if (select)
				for (WebElement e : atmentionusers) {
					System.out.println(e.getText());
					String currentuser = e.getText();
					System.out.println(e.getText());
					WA_HomeSteps.moveToElement(
							"//table[@class='mentionDialogBoxTable']//span[@class='mentionEmailId'][text()='"
									+ currentuser + "']");
					if (e.getText().trim().equalsIgnoreCase(selectuser)) {
						e.click();
						break;
					}
				}
			System.out.println("out of if");
		} catch (Exception e) {
			System.out.println("");
		}
	}

	/**
	 * 
	 * @param groupname
	 *            : Will get the time stamp of the group provided by user
	 * @throws Exception
	 */
	@And("^I check for last timestamp and description for '(.*)' chat from lest panel$")
	public static void getGroupTimestampAndChatDesc(String chatthreadname) throws Exception {
		try {
			String timestamp = driver
					.findElement(By.xpath(
							chatthreadname1 + chatthreadname + closetextbrace + "/../../..//span[@class='dayTime']"))
					.getText();
			System.out.println("For " + chatthreadname + " Timestamp displayed as : " + timestamp);
			List<WebElement> ele = driver.findElements(By.xpath(chatsactivethread + "//span[text()='" + chatthreadname
					+ "']/../../../..//div[@class='userChatDEsc']//span"));
			for (WebElement e : ele) {
				e.getText();
				System.out.println("For " + chatthreadname + " sender or message displayed as : <b>" + e.getText());
			}
		} catch (Exception e) {

		}
	}

	/**
	 * @param groupname
	 *            : Actions will perform on this group
	 * @param check
	 *            : If this flag is true, then followed action will be performed
	 * @param action
	 *            : This parameter is valid only when @check is true
	 * @throws Exception
	 *             : Fail, if it fail to perform action
	 */

	@And("^I go to chat '(.*)' and perform on hover action true/false '(.*)' as '(.*)'$")
	public static void goToGroupAndPerform(String groupname, boolean performaction, String action) throws Exception {
		try {
			WA_HomeSteps.moveToElement(chatthreadname1 + groupname + closetextbrace + chatthreadnamedesc3);
			WA_HomeSteps.clickWithtextBasedXpath(chatthreadname1 + groupname + closetextbrace + chatthreadnamedesc3);
			if (performaction) {
				switch (action.trim().toUpperCase()) {
				case "MUTE":
					WA_HomeSteps.moveToElement(chatthreadname1 + groupname + muteicon);
					Thread.sleep(1000);
					WA_HomeSteps.clickWithtextBasedXpath(chatthreadname1 + groupname + muteicon);
					System.out.println("Displayed mute slots");
					break;

				case "UNMUTE":
					WA_HomeSteps.moveToElement(chatthreadname1 + groupname + unmuteicon);
					Thread.sleep(1000);
					WA_HomeSteps.clickWithtextBasedXpath(chatthreadname1 + groupname + unmuteicon);
					System.out.println("Unmuted");
					break;

				case "UNREAD":
					WA_HomeSteps.moveToElement(chatthreadname1 + groupname + markasunreadicon);
					Thread.sleep(1000);
					WA_HomeSteps.clickWithtextBasedXpath(chatthreadname1 + groupname + markasunreadicon);
					System.out.println("Click on read icon and made it as unread");
					WA_HomeSteps.I_should_not_see_onpage(chatthreadname1 + groupname + unreadbadgeicon);
					break;

				case "READ":
					WA_HomeSteps.moveToElement(chatthreadname1 + groupname + markasreadicon);
					Thread.sleep(1000);
					WA_HomeSteps.clickWithtextBasedXpath(chatthreadname1 + groupname + markasreadicon);
					System.out.println("Click on unread icon and made it as read");
					WA_HomeSteps.I_should_see_element_visibility(chatthreadname1 + groupname + unreadbadgeicon);
					break;

				case "3DOTS":
					WA_HomeSteps.moveToElement(chatthreadname1 + groupname + more3dots);
					Thread.sleep(1000);
					WA_HomeSteps.clickWithtextBasedXpath(chatthreadname1 + groupname + more3dots);
					System.out.println("Unmuted");
					break;

				default:
					System.out.println("Please provie valid option to perform on thread");
				}
			}
		} catch (Exception e) {
			System.out.println("Issue occured in goToGroupAndPerform -->" + groupname + "-->" + action);
		}
	}

	@And("^I select mute slot as '(.*)'$")
	public static void selectMuteSlotAs(String muteslottobeselected) throws Exception {
		try {
			List<WebElement> options = driver.findElements(By.xpath(muteslotfor));
			for (WebElement ele : options) {
				Thread.sleep(500);
				if (ele.getText().equalsIgnoreCase(muteslottobeselected)) {
					ele.click();
				}
			}

		} catch (Exception e) {

		}
	}

	@And("^I delete chat$")
	public static void deleteChat() throws Exception {
		try {
			CommonSteps.I_click("3dotsdeletechat");
			CommonSteps.I_should_see_element_Visible_wait(5, "topicsdeleteconfirmation");
			CommonSteps.I_click("topicsdeleteconfirmation");
			Thread.sleep(1000);
		} catch (Exception e) {
			System.out.println("Failed to delete chat");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}

	@And("^I clear chat history$")
	public static void clearChatHistory() throws Exception {
		try {
			CommonSteps.I_click("clearchathistory");
			CommonSteps.I_should_see_element_Visible_wait(5, "clearchatconfirmationyes");
			CommonSteps.I_click("clearchatconfirmationyes");
			Thread.sleep(1000);
		} catch (Exception e) {
			System.out.println("Failed to clear chat history");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}

	@And("^I leave chat$")
	public static void leaveChat() throws Exception {
		try {
			CommonSteps.I_click("leavechat");
			CommonSteps.I_should_see_element_Visible_wait(5, "leavechatconfirmation");
			CommonSteps.I_click("leavechatconfirmation");
			Thread.sleep(1000);
		} catch (Exception e) {
			System.out.println("Failed to clear chat history");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}

	@And("^I go to manage group$")
	public static void goToManage() throws Exception {
		try {
			CommonSteps.I_click("leavechat");
			CommonSteps.I_should_see_element_Visible_wait(5, "leavechatconfirmation");
			CommonSteps.I_click("leavechatconfirmation");
			Thread.sleep(1000);
		} catch (Exception e) {
			System.out.println("Failed to clear chat history");
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}

	@And("^I select chat type as Chats/Unread Chats/Muted Chats '(.*)'$")
	public static void selectUnreadOrMutedChats(String typeofchattobeselected) throws Exception {
		try {
			CommonSteps.I_click("chatdropdown");
			List<WebElement> options = driver.findElements(GetPageObject.OR_GetElement("chatdropdowntypes"));
			for (WebElement e : options) {
				if (e.getText().equals(typeofchattobeselected)) {
					e.click();
					Thread.sleep(2000);
					break;
				}

			}
		} catch (Exception e) {

		}
	}

	/*
	 * @And("^I check for empty chat screen$") public static void
	 * checkEmptyScreen(String user, String message) throws Exception {
	 * CommonSteps.I_should_not_see_on_page("emptychatscreen"); }
	 */

	/**
	 * 
	 * @param groupname
	 *            : Will get on hover participants of this group
	 * @param loginuser
	 *            : to check if the last message is from current user
	 * @return : Will return the count of participants of the group name
	 *         provided
	 * @throws Exception
	 */
	public int getOnHoverParticipantsCount(String groupname, String loginuser) throws Exception {
		ArrayList<String> count;
		int groupparticipants = 0;
		try {
			goToGroupAndPerform(groupname, false, "NA");
			count = getAndValidateGroupIcons(groupname, false, loginuser);
			String val = count.get(2);
			int i = Integer.parseInt(val);
			System.out.println(i = i + 2);
			Thread.sleep(2000);
			WA_HomeSteps.moveToElement(chatthreadname1 + groupname + leftactivegroupicon);
			List<WebElement> totalparticipants = driver
					.findElements(By.xpath(chatthreadname1 + groupname + leftactivegroupcount));
			groupparticipants = totalparticipants.size();
			if (i == totalparticipants.size()) {

				System.out.println("PASS ... Group icouns count matching with the total participants of group");

			} else {
				System.out.println("FAIL ... Group icouns count is not matching with the total participants of group");

			}

		} catch (Exception e) {
		}
		return groupparticipants;
	}

	/**
	 * 
	 * @param groupname
	 *            : Group icon validations performs on this group name
	 * @param validation
	 *            : true, will validate first icon from last messaged person
	 * @param loginuser
	 *            : to check if the last message is from current user
	 * @return allicons : return list of group icons i.e. Left, Right and Top
	 * @throws Exception
	 */
	public ArrayList<String> getAndValidateGroupIcons(String groupname, boolean validation, String loginuser)
			throws Exception {
		String value = null;
		goToGroupAndPerform(groupname, false, "NA");
		ArrayList<String> allicons = new ArrayList<>();
		try {

			String leftactiveusericon = driver.findElement(By.xpath(chatthreadname1 + groupname + leftactivegroupicon))
					.getText();
			String leftactivegroupcountnumber = driver
					.findElement(By.xpath(chatthreadname1 + groupname + leftactivegroupcount)).getText();
			allicons.add(leftactiveusericon);
			allicons.add(leftactivegroupcountnumber);

			if (validation) {
				String lastmessagefrom = getLastMessageParticipant(groupname, loginuser);

				String firstchar = WA_HomeSteps.getFirstChar(lastmessagefrom);

				if (lastmessagefrom.startsWith(firstchar)) {
					System.out.println(
							"PASS ... Last message participant and the first(Left) group icon letters are matching");
					System.out.println("INFO ... In thread, user profile icon displayed as :" + leftactiveusericon
							+ " and count displayed as " + leftactivegroupcountnumber);

				} else {

					System.out.println("FAIL ... Last message participant name starts with <b>" + firstchar
							+ "</b> But the first icon displayed as <b>" + leftactiveusericon);

				}
			}

		} catch (Exception e) {
			System.out.println("FAIL ... Failed to get Group profile icons of : " + groupname);

		}
		return allicons;
	}

	/**
	 * @param groupname
	 *            : TO print this group name in the reports
	 * @param logedinuser
	 *            :If the last message is from logedinuser, will return the same
	 * @return : returns last message username
	 * @throws InterruptedException
	 * @throws Exception
	 */
	public String getLastMessageParticipant(String groupname, String logedinuser)
			throws InterruptedException, Exception {
		String lastmessagefrom = null;
		try {
			List<WebElement> msgs = driver.findElements(By.xpath("//div[@class='bodyMsg ']"));
			int i = msgs.size();
			try {
				WA_HomeSteps.moveToElement("//div[contains(@class,'bodyMsg')][" + i + "]");
				lastmessagefrom = driver
						.findElement(By.xpath("//div[contains(@class,'bodyMsg')][" + i + "]//div[@class='nameTime']"))
						.getText();
				System.out.println("INFO ... In " + groupname + " group, last message is from : " + lastmessagefrom);

			} catch (Exception e) {
				lastmessagefrom = logedinuser;
				System.out.println("INFO ... In " + groupname + " group, last message is from current user i.e. : "
						+ lastmessagefrom);
			}
		} catch (Exception e) {
			System.out.println("FAIL .. Fail to get last message person name");
		}
		return lastmessagefrom;
	}

	/**
	 * @Description : To get group timeline(info) i.e. Who created and when the
	 *              group created info
	 * @throws IOException
	 */
	// Need analysis
	@And("^I verify chat creation timeline by user '(.*)'$")
	public static void verifyGroupCreationTimeline(String currentuser) throws IOException {
		try {
			CommonSteps.moveToElement("chatcreationuserinitials");
			String userinitial = driver.findElement(GetPageObject.OR_GetElement("chatcreationuserinitials")).getText();
			String usernameforthreadcreation = driver.findElement(GetPageObject.OR_GetElement("chatcreationtimeline"))
					.getText();
			String firstchar = WA_HomeSteps.getFirstChar(userinitial);

			if (usernameforthreadcreation.startsWith("You"))
				firstchar = WA_HomeSteps.getFirstChar(currentuser);
			if (usernameforthreadcreation.contains(currentuser))
				System.out.println("FAIL .. Group timeline name displayed as : " + currentuser
						+ "<b> It should be displayed as you");
			if (userinitial.startsWith(firstchar)) {

				System.out.println("PASS .. User initial matches with the first character of the user");

			} else {
				System.out.println(
						"FAIL .. Initial displayed as :" + userinitial + " but, expected inital is :" + firstchar);
			}
			String creationdate = driver.findElement(GetPageObject.OR_GetElement("chatcreationdate")).getText();
			System.out.println("INFO .. Group timeline date and time displayed as : " + creationdate);

		} catch (Exception e) {
		}
	}

	/**
	 * @throws Exception
	 * @Description : To get group updated(info) i.e. if any one added and
	 *              removed from the group @ : Yet to implement better logic for
	 *              this
	 */
	// Still need to check for exact parameter value
	@And("^I verify timeline event for cleared/updated/added/removed '(.*)'$")
	public static void verifyGroupUpdateTimelines(String typeofAmend) throws Exception {
		ArrayList<String> timelines = new ArrayList<>();
		Thread.sleep(2000);
		try {
			WA_HomeSteps.moveToElement(chattimeline1 + typeofAmend + closetextbrace);
			List<WebElement> alltimelines = driver.findElements(By
					.xpath("//div[@class='msgMemberTimeline']//span[@class='timelineCntr']/span[@class='messageOnly'][contains(text(),'"
							+ typeofAmend + "')]/..//span"));
			if (alltimelines.size() > 0) {
				System.out.println(alltimelines.size());
				for (WebElement e : alltimelines) {
					timelines.add(e.getText());
				}
				System.out.println("INFO.. Timeline displayed as " + timelines);
			} else {
				System.out.println("FAIL.. Timeline is not displayed");
			}

		} catch (Exception e) {
			System.out.println("FAIL.. Failed to validate tie line event");
		}
	}

	@And("^I verify empty chat screen$")
	public void verifyClearChatStatus() throws Exception {
		CommonSteps.I_should_not_see_on_page("chatmessagebubbles");
	}

	/**
	 * 
	 * @param participant
	 *            : Will check this participant added to the group or not
	 * @throws Exception
	 */

	@And("^I check for newly added participants '(.*)'$")
	public static void validateRecentAddedParticipants(String participant) throws Exception {
		boolean flag = false;
		Thread.sleep(2000);
		try {
			WA_HomeSteps.moveToElement(manageparticipant + "[text()='" + participant + "']");
			List<WebElement> Menulist = driver.findElements(By.xpath(manageparticipant));
			for (WebElement e : Menulist) {
				if (e.getText().trim().equalsIgnoreCase(participant)) {
					flag = true;
					System.out.println("PASS .. " + participant + " Added to the chat group");
					break;
				}
			}

			if (!flag) {
				System.out.println("FAIL .. " + participant + " is not Added to the chat group");
			}
		} catch (Exception e) {

		}
	}

	/**
	 * 
	 * @param renameto
	 *            : This will rename the group to the user provided name as a
	 *            parameter
	 * @return : Return the updated name from the application
	 * @throws Exception
	 */
	@And("^I rename the group to '(.*)'$")
	public static void renameGroupAndClose(String renameto) throws Exception {
		String updatedname = null;
		try {
			CommonSteps.I_click("managegroupname");
			CommonSteps.I_enter_in_field(renameto, "managegroupname");
			updatedname = driver.findElement(GetPageObject.OR_GetElement("managegroupname")).getAttribute("value");
			// updatedname = getAttributeValue("//input[@placeholder='Group
			// Name']", "value");
			System.out.println(updatedname);
			if (renameto.equals(updatedname)) {
				System.out.println("PASS .. Renamed successfully");
			} else {
				CommonSteps.I_click("chatmanageclose");
				System.out.println("FAIL .. Failed to rename the group");
			}
			CommonSteps.I_click("chatmanageclose");
		} catch (Exception e) {
			CommonSteps.I_click("chatmanageclose");
		}

	}

	/**
	 * @Description : It will remove all the members from the group
	 * @throws Exception
	 */
	@And("^I remove all members from the group$")
	public static void removeAllMembersAndClose() throws Exception {
		try {
			String currentuser = null;
			boolean memb = false;
			int memcount = driver.findElements(By.xpath(manageparticipant)).size();
			int counter = 0;
			List<WebElement> Menulist;
			do {
				memb = driver.findElements(By.xpath(manageparticipant)).size() > 0;
				if (memb) {
					Menulist = driver.findElements(By.xpath(manageparticipant));
					for (WebElement e : Menulist)
						currentuser = e.getText();
				}
				if (memb) {
					WA_HomeSteps.clickWithtextBasedXpath(
							manageparticipant + "[text()='" + currentuser + "']/../../..//span[@class='member']");
					System.out.println("About remove participant ------------> " + currentuser);
					CommonSteps.I_click("removeparticipant");
					CommonSteps.I_click("removeconfirmation");
					counter++;
					System.out.println("Remove participants counter value is ------------> " + counter);
					Thread.sleep(2000);
				}
			} while ((memb || counter > memcount));
			CommonSteps.I_click("chatmanageclose");
		} catch (Exception e) {
			CommonSteps.I_click("chatmanageclose");
			System.out.println("Failed to remove members from the group");
		}

	}

	@And("^I send message '(.*)' in chats$")
	public static void sendMessageInChats(String sendmessageas) throws Exception {
		sendmessageas = WA_HomeSteps.getStoredValue(sendmessageas);
		try {
			CommonSteps.I_enter_in_field(sendmessageas, "chatmsgcomposebar");
			CommonSteps.I_send_key("Enter");
			Thread.sleep(1000);
		} catch (Exception e) {
			System.out.println("Failed to send messgae: " + sendmessageas);
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}

	@Then("^I go to chats message '(.*)' and perform on hover action '(.*)' as '(.*)'$")
	public static void goToChatsMessageAndPerform(String messagetext, boolean performaction, String action)
			throws Exception {
		messagetext = WA_HomeSteps.getStoredValue(messagetext);
		String message = chatmsgele1 + messagetext + closetextbrace;
		try {

			WA_HomeSteps.moveToElement(message);

			if (performaction) {
				switch (action.trim().toUpperCase()) {
				case "REPLY":
					String replypath = message + reply;
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
					WA_HomeSteps.I_enter_text("Editednow", message);
					WA_HomeSteps.I_should_see_element_visibility(
							chatmsgele1 + messagetext + "Editednow" + "']/..//span[text()='Edited']");
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
			} else {
				WA_HomeSteps.clickWithtextBasedXpath(message);
			}
			Thread.sleep(500);
		} catch (Exception e) {
			System.out.println("Issue occured in goToChatsMessageAndPerform -->" + messagetext + "-->" + action);
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}

	@And("^I verify reply bubble for message '(.*)'$")
	public static void verifyReplyFor(String replybubblefor) throws Exception {
		replybubblefor = WA_HomeSteps.getStoredValue(replybubblefor);
		try {
			WA_HomeSteps.I_should_not_see_onpage(replybubblefor1 + replybubblefor + closetextbrace);
		} catch (Exception e) {
			System.out.println("Failed to send messgae: " + replybubblefor);
			throw new ElementNotFoundException(e.getMessage(), "", "");
		}

	}

	@And("^I send reaction to chat message '(.*)' as '(.*)'$")
	public static void sendReactionInChats(String reactiononmessage, String reaction) throws Exception {
		Thread.sleep(1000);
		reactiononmessage = WA_HomeSteps.getStoredValue(reactiononmessage);
		try {
			switch (reaction.trim().toUpperCase()) {
			case "LIKE":
				WA_HomeSteps.clickWithtextBasedXpath(chatmsgele1 + reactiononmessage + like);
				Thread.sleep(500);
				System.out.println("Clicked on Like Reaction");
				break;

			case "UNLIKE":
				WA_HomeSteps.clickWithtextBasedXpath(chatmsgele1 + reactiononmessage + unlike);
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

	@And("^I verify visibility of '(.*)' reaction on chat message '(.*)' should be true/false '(.*)'$")
	public static void verifyReaction(String reaction, String reactiontomessage, boolean visibleornot)
			throws Exception {
		reactiontomessage = WA_HomeSteps.getStoredValue(reactiontomessage);
		Thread.sleep(500);
		try {

			switch (reaction.trim().toUpperCase()) {
			case "LIKE":
				if (visibleornot) {
					WA_HomeSteps.I_should_see_element_visibility(chatmsgele1 + reactiontomessage + reactedcountforlike);
				} else {
					WA_HomeSteps.I_should_not_see_onpage(chatmsgele1 + reactiontomessage + reactedcountforlike);
				}
				System.out.println("Validated like reaction");
				break;

			case "UNLIKE":
				if (visibleornot) {
					WA_HomeSteps
							.I_should_see_element_visibility(chatmsgele1 + reactiontomessage + reactedcountforunlike);
				} else {
					WA_HomeSteps.I_should_not_see_onpage(chatmsgele1 + reactiontomessage + reactedcountforunlike);
				}
				Thread.sleep(500);
				System.out.println("Validated unlike reaction");
				break;

			default:
				System.out.println("Please provided valid reaction and message to validate");
			}

		} catch (Exception e) {
			System.out.println("Failed to validate the visibility of : " + reaction + " reaction");
			// throw new CucumberException(e.getMessage(), e);
			throw new ElementNotFoundException(chatmsgele1 + reactiontomessage + reactedcountforlike, "", "");

		}
	}

	@And("^I select message '(.*)' from '(.*)'$")
	public static void selectMessages(String messagetobeSelected, String threadname) throws Exception {
		try {

			WA_HomeSteps.clickWithtextBasedXpath(
					chatheader1 + threadname + chatheadermsg1 + messagetobeSelected + chatheadermsgselection1);
			CommonSteps.I_should_not_see_on_page("chatheaderforwardicon");

		} catch (Exception e) {
			System.out.println("Failed to select messages");
		}
	}
}