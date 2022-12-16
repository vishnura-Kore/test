	@WATopics
Feature: Topics Functionality

Scenario: 3.0-Standard Topic clean up and recreation
		Given I load page object '01_wa_Home'
  	When I load page object '03_wa_Topics'
  	And I load page object '02_wa_Workspaces'
  	And I navigate to workassist homepage
  	And I search and select workspace 'StandardWST'
  	And I select 'StandardTopic' topic
  	And I perform 'Manage' operation from 'StandardTopic' topic 3dots
  	And I delete topic
  	Then I create topic as 'StandardTopic'

Scenario: 3.1-Verify topics empty state screen
  	Given I navigate to workassist homepage
  	When I create workspace '<wsnamewithParticipants>' as private 'false' with participants'<recUser>'
  	And I click 'leftnav_messages'
  	And I wait for visiblity of element 'msgtopictext'
    And I wait for visiblity of element 'msgtopicplaceholder'
    And I wait for visiblity of element 'msgworkspacename'
    Then I wait for visiblity of element 'msgstartnewtopic'
    
    	Examples:
 |wsnamewithParticipants|recUser|
 |QA_AutoWS31|hana@koraqa1.com|

 Scenario: 3.2_3.51: Check user is able to create a topic, when user taps on the "+ Start a new topic"
    Given I click 'msgstartnewtopic'
    When I wait for visiblity of element 'edittopicname'
    And I wait for visiblity of element 'topictext'
    And I wait for visiblity of element 'topicplaceholdertext'
    And I wait for visiblity of element 'topicmodify'
   	And I wait for visiblity of element 'msgcomposebar'
  	And I wait for visiblity of element 'msgattachment'
  	And I wait for visiblity of element 'msgemoji'
   	And I wait for '2' seconds
		And I click 'topic3dots'
		And I wait for visiblity of element 'topicrename'
    And I wait for visiblity of element 'topicmute'
    And I wait for visiblity of element 'topicviewfiles'
   	And I wait for visiblity of element 'topiccopylink'
   	And I wait for visiblity of element 'topicmanage'
#>rename
   	And I create topic as '<NewTopicname>'
   	And I select '<NewTopicname>' topic
   	
#>Default @All members should be in selected mode (Manage screen)
		And I create topic as '<NewTopicname2>'
   	And I wait for visiblity of element 'topicmodify'
   	And I click 'topicmodify'
   	And I wait for '3' seconds
   	And I wait for visiblity of element 'manageallworkspace'
   	And I wait for visiblity of element 'manageallworkspacetext'
   	And I select all workspace option true/false 'false' and compare selection true/false 'true'
   	And I click 'managecloseicon'
   	
#> Check at recipient end, the same topic is showing in the workspace
   	And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace '<wsnamewithParticipants>'
   	And I verify '<NewTopicname2>' topic existance should be 'true'
   	And I wait for '5' seconds
   	And I create topic as '<NewTopicname1>'
   	And I logout and relogin with 'james@koraqa1.com','Outlook@123'
   	And I search and select workspace '<wsnamewithParticipants>'
   	Then I verify '<NewTopicname1>' topic existance should be 'true'
    	
 Examples:
 |NewTopicname|wsnamewithParticipants|NewTopicname1|NewTopicname2|
 |DeleteMe_32|QA_AutoWS31|Topic_Test|Topic_32|
 
Scenario: 3.3 Navigation to manage screen from default "modify" button
   	Given I logout and relogin with 'james@koraqa1.com','Outlook@123'
   	When I search and select workspace '<wsnamewithParticipants>'
   	And I select '<NewTopicname>' topic
   	Then I click 'topicmodify'
   	
 Examples:
 |NewTopicname|wsnamewithParticipants|
 |DeleteMe_32|QA_AutoWS31|

Scenario: 3.4: check the options in Manage screen
   	Given I wait for visiblity of element 'managetext'
    When I wait for visiblity of element 'managetopicname'
    And I wait for visiblity of element 'mangeaccess'
   	And I wait for visiblity of element 'managepostemail'
   	Then I wait for visiblity of element 'managedeletetopicheader'
   	And I wait for '5' seconds

 Scenario: 3.5 Edit/Rename the topic name from manage screen
   	Given I click 'manageedittopicname'
  	When I clear field 'manageedittopicname'
  	And I enter '<StandardTopic>' in field 'manageedittopicname'
   	And I wait for '5' seconds
   	And I click 'managecloseicon'
   	And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace '<wsnamewithParticipants>'
   	And I verify '<StandardTopic>' topic existance should be 'true'
   	And I wait for '5' seconds
   	And I logout and relogin with 'james@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
#delete workspace
   	And I search and select workspace '<wsnamewithParticipants>'
   	Then I delete workspace '<wsnamewithParticipants>'
   	
 Examples:
 |StandardTopic|wsnamewithParticipants|recUser|
 |DeleteMe_35|QA_AutoWS31|hana@koraqa1.com|

 Scenario:3.6: Check whether user is able to change the access to limited members 
   	Given I create workspace '<wsnamewithParticipants>' as private 'false' with participants'<recUser>'
  	When I click 'leftnav_messages'
   	And I create topic as '<NewTopicname>'
   	And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
   	And I wait for '5' seconds
   	
#> Only self user has to show in the field 
   	And I select limited workspace option true/false 'true' and compare selection true/false 'true'
   	And I wait for visiblity of element 'managelimitedtotext'
   	And I wait for visiblity of element 'manageownername'
   	And I wait for visiblity of element 'manage_andtext'
   	
#> Add user(s) and check same topic is added to the recipient end
   	And I select participants 'hana@koraqa1.com'
   	And I click 'limitedmembersdone'
   	And I wait for '5' seconds
  	And I click 'managecloseicon'
   	And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace '<wsnamewithParticipants>'
   	And I verify '<NewTopicname>' topic existance should be 'true'
   	And I wait for '5' seconds
   	And I logout and relogin with 'james@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	#delete workspace
   	And I search and select workspace '<wsnamewithParticipants>'
   	Then I delete workspace '<wsnamewithParticipants>'
  Examples:
 |NewTopicname|wsnamewithParticipants|recUser|
 |DeleteMe_36|QA_AutoWS36|hana@koraqa1.com|
 
@ignore
 Scenario:3.7 Check user is able to add the non-workspace member or external users in the limited members field.
   	Given I create workspace '<wsnamenoParticipants>' as private 'true' with out participants
  	When I click 'leftnav_messages'
  	And I create topic as '<NewTopicname>'
  	And I wait for '5' seconds
   	And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
   	And I wait for '5' seconds
   	And I select limited workspace option true/false 'true' and compare selection true/false 'true'
   	And I wait for visiblity of element 'managelimitedtotext'
   	And I wait for visiblity of element 'manageownername'
   	And I wait for visiblity of element 'manage_andtext'
   	And I select participants 'hana@koraqa1.com'
   	And I click 'limitedmembersdone'
   	
#> While adding the non-workspace member, check user is able to see the pop-up with "confirm" and "cancel and go back"
   	And I wait for visiblity of element 'managecancelandgoback'
   	And I wait for visiblity of element 'mangeconfirm'
   	And I click 'mangeconfirm'
   	And I wait for '5' seconds
   	And I click 'managecloseicon'
   	
#> Taps on confirm button, user is added to the topic(Recipient is added to workspace and the topic)
   	And I click 'ws3dots'
 		And I wait for visiblity of element 'ws3dotssharingandpermissions'
	  And I click 'ws3dotssharingandpermissions'
 		And I validate user 'hana@koraqa1.com' role as 'Member'
 		
#> Check added non-workspace/external member should show in the manage workspace members screen
   	And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace '<wsnamenoParticipants>'
   	And I verify '<NewTopicname>' topic existance should be 'true'
   	And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
   	# need to add notification and validation
   	And I wait for '3' seconds
   	And I click 'managecloseicon'
   	
#> Remove the user from the list, the member should remove and should not show the topic at the recipient end
   	And I logout and relogin with 'james@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace '<wsnamenoParticipants>'
   	And I verify '<NewTopicname>' topic existance should be 'true'
   	And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
   	And I select limited workspace option true/false 'false' and compare selection true/false 'true'
   	And I remove member 'Hana Yori' from topic
   	And I click 'limitedmembersdone'
   	And I click 'managecloseicon'
   	And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace '<wsnamenoParticipants>'
   	Then I verify '<NewTopicname>' topic existance should be 'false'
   	
 Examples:
 |NewTopicname|wsnamenoParticipants|
 |DeleteMe_37|QA_AutoWS37|


Scenario: 3.8 Manage - "All @ workspace" to "Limited members" and  "Limited members" to "All @ workspace" 
#		Given I logout and relogin with 'james@koraqa1.com','Outlook@123'
   	When I navigate to workassist homepage
   	And I search and select workspace 'StandardWST'
   	And I create topic as '<NewTopicname>' 	
   	And I perform 'Manage' operation from '<NewTopicname>' topic 3dots

#>  "All @ workspace" to "Limited members", then the topic should not show at the workspace members
		And I select limited workspace option true/false 'true' and compare selection true/false 'true'
		And I click 'managecloseicon'
		And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace 'StandardWST'
   	And I verify '<NewTopicname>' topic existance should be 'false'
   	
#> "Limited members" to "All @ workspace", then the topic should show for members who all part of workspace
		And I logout and relogin with 'james@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace 'StandardWST'
   	And I verify '<NewTopicname>' topic existance should be 'true'
   	And I select '<NewTopicname>' topic
   	And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
   	And I select all workspace option true/false 'true' and compare selection true/false 'true'
   	And I click 'managecloseicon'
		And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace 'StandardWST'
   	And I verify '<NewTopicname>' topic existance should be 'true'
   	And I logout and relogin with 'james@koraqa1.com','Outlook@123'
 		And I navigate to workassist homepage
   	#delete workspace
   	And I search and select workspace '<wsnamenoParticipants>'
   	Then I delete workspace '<wsnamenoParticipants>'
   	
 Examples:
 |NewTopicname|wsnamenoParticipants|
 |DeleteMe_38|QA_AutoWS38|
 

Scenario:3.9 Check user is able to send a mail as a post using post via email
		 Given I navigate to workassist homepage
		 When I create workspace '<wsnamewithParticipants>' as private 'false' with participants'<recUser>'
  	 And I click 'leftnav_messages'
  	 And I create topic as '<NewTopicname>'
  	 And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
  	 And I wait for '5' seconds
  	 And I wait for visiblity of element 'manage_postemail_togglebuttonoff'
  	 And I verify element 'manage_postemail_togglebuttonoff' is displayed
  	 And I click 'manage_postemail_togglebuttonoff'
  	 And I wait for '3' seconds
  	 And I wait for visiblity of element 'manage_postemail_togglebutton_on'
  	 And I verify element 'manage_postemail_togglebutton_on' is displayed
  	 And I wait for visiblity of element 'manage_postemail_edit'
  	 And I wait for visiblity of element 'manage_postemail_copy'
  	 And I click 'managecloseicon'
  	 And I perform 'Get Email' operation from '<NewTopicname>' topic 3dots
  	 And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	 And I navigate to workassist homepage
   	 And I search and select workspace '<wsnamewithParticipants>'
   	 And I verify '<NewTopicname>' topic existance should be 'true'
   	 And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
  	 And I wait for visiblity of element 'recipient_postemail_togglebuttonon'
  	 Then I click 'managecloseicon'
  	  	 
Examples:
 |NewTopicname|wsnamewithParticipants|recUser|
 |DeleteMe_39|QA_AutoWS39|hana@koraqa1.com|

 Scenario:3.11 Check user is able to delete the topic
		Given I logout and relogin with 'james@koraqa1.com','Outlook@123'
  	When I navigate to workassist homepage
   	And I search and select workspace '<wsnamewithParticipants>'
  	And I verify '<NewTopicname>' topic existance should be 'true'
  	And I select '<NewTopicname>' topic
  	And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
   	And I delete topic
   	And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace '<wsnamewithParticipants>'
   	And I verify '<NewTopicname>' topic existance should be 'false'
   	And I logout and relogin with 'james@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
  #delete workspace
   	And I search and select workspace '<wsnamewithParticipants>'
   	Then I delete workspace '<wsnamewithParticipants>'
   	
  Examples:
 |NewTopicname|wsnamewithParticipants|
 |DeleteMe_311|QA_AutoWS311|

 Scenario: 3.12_3.50-Invite a member from workspace and verify that the user should be part of topics too
  	Given I navigate to workassist homepage
  	When I create workspace '<wsnamewithParticipants>' as private 'false' with participants'<recUser>'
  	And I click 'leftnav_messages'
  	And I create topic as '<NewTopicname>'
  	And I wait for visiblity of element 'msgcomposebar'
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
   	And I send message 'Topic_AutoMsg' in topic
  	And I click 'ws3dots'
  	And I wait for visiblity of element 'ws3dotssharingandpermissions'
 		And I click 'ws3dotssharingandpermissions'
    And I wait for visiblity of element 'wsinviteusers'
    And I click 'wsinviteusers'
 	  And I select '<recUser1>' user and assign role 'true' of type '<userrole>'
 	  And I logout and relogin with 'ricky@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace '<wsnamewithParticipants>'
   	And I verify '<NewTopicname>' topic existance should be 'true'
   	And I select '<NewTopicname>' topic
   	And I validate message 'Topic_AutoMsg' on hover options from sender/recipient 'recipient'
   	And I logout and relogin with 'james@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
#delete workspace
   	And I search and select workspace '<wsnamewithParticipants>'
   	Then I delete workspace '<wsnamewithParticipants>'
 	
 	Examples:
 |NewTopicname|wsnamewithParticipants|recUser|recUser1|userrole|
 |DeleteMe_312|QA_AutoWS312|hana@koraqa1.com|ricky@koraqa1.com|Member|

Scenario: 3.13 send a post with text from the compose bar  	
  	Given I navigate to workassist homepage
   	When I search and select workspace 'StandardWST'
    And I click 'leftnav_messages'
   	And I create topic as '<NewTopicname>'
   	And I wait for visiblity of element 'msgcomposebar'
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
   	And I send message 'Topic_AutoMsg' in topic
   	And I wait for '3' seconds
  	Then I wait for visiblity of element 'startnewmessage'
  	
 Examples:
 |NewTopicname|
 |DeleteMe_313|

 Scenario: 3.22 React to a message with unlike
 		Given I search and select workspace 'StandardWST'
 		When I select 'StandardTopic' topic
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
  	And I send message 'Topic_AutoMsg' in topic
  	And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reactions'
  	And I send reaction to message 'Topic_AutoMsg' as 'unlike'
		Then I verify visibility of 'unlike' reaction on 'Topic_AutoMsg' should be true/false 'true'

 Scenario: 3.23  Undo the reaction
 		Given I search and select workspace 'StandardWST'
 		When I select 'StandardTopic' topic
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
  	And I send message 'Topic_AutoMsg' in topic
  	And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reactions'
  	And I send reaction to message 'Topic_AutoMsg' as 'like'
  	And I verify visibility of 'like' reaction on 'Topic_AutoMsg' should be true/false 'true'
  	And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reactions'
  	And I send reaction to message 'Topic_AutoMsg' as 'like'
		Then I verify visibility of 'like' reaction on 'Topic_AutoMsg' should be true/false 'false'

 		
Scenario: 3.24 Edit the original message
		Given I search and select workspace 'StandardWST'
 		When I select 'StandardTopic' topic
 		And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
 		And I send message 'Topic_AutoMsg' in topic
  	Then I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Edit'

Scenario: 3.28_3.37 Verify the display of deleted messages and replies 
  	Given I select 'StandardTopic' topic
  	When I genereate random text with current timestamp and store to 'Topic_AutoMsg'
  	And I send message 'Topic_AutoMsg' in topic
    And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
    And I genereate random text with current timestamp and store to 'Topic_AutoReply'
    And I send reply 'Topic_AutoReply' in topic
    And I go to reply 'Topic_AutoReply' and perform on hover action 'true' as 'More'
    And I delete the selected messag/reply
    And I verify existance of delted reply 'Topic_AutoReply' in topic
    And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'More'
    And I delete the selected messag/reply
    Then I verify existance of delted message 'Topic_AutoMsg' in topic	

Scenario: 3.29 - Verify the user navigations to reply compose bar from a message
  	Given I genereate random text with current timestamp and store to 'Topic_AutoMsg'
   	When I send message 'Topic_AutoMsg' in topic
   	And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'REPLY'
   	And I wait for visiblity of element 'reply_composebar'
   	And I click 'reply_crossicon'
   	And I go to message 'Topic_AutoMsg' and perform on hover action 'false' as 'NA'
   	Then I wait for visiblity of element 'reply_composebar'

Scenario:3.30 - Verify reaction on reply at recipient end 

		Given I search and select workspace 'StandardWST'
  	When I select 'StandardTopic' topic
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
  	And I send message 'Topic_AutoMsg' in topic
  	And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
   	And I genereate random text with current timestamp and store to 'Topic_AutoReply'
		And I send reply 'Topic_AutoReply' in topic
		And I go to reply 'Topic_AutoReply' and perform on hover action 'true' as 'Reactions'
  	And I send reaction as 'like_reaction'
  	And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace 'StandardWST'
   	And I select 'StandardTopic' topic
   	And I go to message 'Topic_AutoMsg' and perform on hover action 'false' as 'NA'
   	And I verify visibility of like reaction on 'Topic_AutoReply' should be true/false 'true'
   	Then I logout and relogin with 'james@koraqa1.com','Outlook@123'
   	
Scenario:3.31_3.36 - Verify undo reaction at recipient and verify the reaction done by recipient user
		Given I search and select workspace 'StandardWST'
  	When I select 'StandardTopic' topic
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
  	And I send message 'Topic_AutoMsg' in topic
  	And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
   	And I genereate random text with current timestamp and store to 'Topic_AutoReply'
		And I send reply 'Topic_AutoReply' in topic
		And I go to reply 'Topic_AutoReply' and perform on hover action 'true' as 'Reactions'
  	And I send reaction as 'like_reaction'
  	And I go to reply 'Topic_AutoReply' and perform on hover action 'true' as 'Reactions'
  	And I send reaction as 'like_reaction'
  	And I verify visibility of like reaction on 'Topic_AutoReply' should be true/false 'false'
  	And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I search and select workspace 'StandardWST'
   	And I select 'StandardTopic' topic
   	And I go to message 'Topic_AutoMsg' and perform on hover action 'false' as 'NA'
   	And I verify visibility of like reaction on 'Topic_AutoReply' should be true/false 'false'
   	And I go to reply 'Topic_AutoReply' and perform on hover action 'true' as 'Reactions'
  	And I send reaction as 'like_reaction'
#  	3.36
   	And I logout and relogin with 'james@koraqa1.com','Outlook@123'
		And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
	  Then I verify visibility of like reaction on 'Topic_AutoReply' should be true/false 'true'
	  
  
Scenario: 3.34_3.35 Navigate to reply from bell notification and validate unread dot in bell notification
	  Given I navigate to workassist homepage
		When I search and select workspace 'StandardWST'
  	And I select 'StandardTopic' topic
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
  	And I send message 'Topic_AutoMsg' in topic
  	And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
   	And I genereate random text with current timestamp and store to 'Topic_AutoReply'
		And I send reply 'Topic_AutoReply' with atmention user 'hana@koraqa1.com'
  	And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
   	And I navigate to workassist homepage
   	And I open bell notification
		And I verify unread dot and bell notification for 'mentioned' activity on 'StandardTopic' and navigate
		And I verify the visibility of unread dot for topic 'StandardTopic' should be true/false 'false'
		And I go to reply 'Topic_AutoReply' and perform on hover action 'true' as 'Reactions'
  	And I send reaction as 'like_reaction'
  	Then I logout and relogin with 'james@koraqa1.com','Outlook@123'
	
Scenario: 3.33 Verify the list of at mentions users displayed in reply compose bar
  	Given I navigate to workassist homepage
  	When I search and select workspace 'StandardWST'
  	And I get total participants count from manage workspace and store to 'hmwsuserscount'
  	And I select 'StandardTopic' topic
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
		And I send message 'Topic_AutoMsg' in topic
		And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
		Then I check at mention users for Messages/Replies 'Replies' and store users count to 'hmatmentioncount'

Scenario: 3.16 Verify the list of at mentions users displayed in message compose bar
  	Given I navigate to workassist homepage
  	When I search and select workspace 'StandardWST'
  	And I get total participants count from manage workspace and store to 'hmwsuserscount'
  	And I select 'StandardTopic' topic
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
		And I send message 'Topic_AutoMsg' in topic
		Then I check at mention users for Messages/Replies 'Messages' and store users count to 'hmatmentioncount'

Scenario: 3.18_3.19_3.14_3.48 Verify at mention notification and navigation
		Given I create topic as '<NewTopicname>'
		When I genereate random text with current timestamp and store to 'Topic_AutoMsg'
		And I send message 'Topic_AutoMsg' in topic
  	And I send message 'Topic_AutoMsg' with atmention user 'hana@koraqa1.com'
  	And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
  	And I open bell notification
		And I verify unread dot and bell notification for 'mentioned' activity on '<NewTopicname>' and navigate
		And I close bell notification
		And I get active topic from 'activetopic' element and compare with expected '<NewTopicname>' topic
#>	3.14
		And I verify the visibility of unread dot for topic '<NewTopicname>' should be true/false 'false'
#		Then I verify the visibility of unread dot for topic 'StandardTopic' should be true/false 'true'
		And I logout and relogin with 'james@koraqa1.com','Outlook@123'
		And I navigate to workassist homepage
  	And I search and select workspace 'StandardWST'
#>	3.48
  	And I select '<NewTopicname>' topic
  	And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
  	Then I delete topic
		
	 Examples:
 |NewTopicname|
 |DeleteMe_318|

Scenario: 3.40 Verify the display and navigation of Jump to bottom 
  	When I search and select workspace 'StandardWST'
  	When I select 'StandardTopic' topic
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
		And I send message 'Topic_AutoMsg' in topic
  	And I scroll to 'topic_welcome' element
  	And I wait for visiblity of element 'jumptobottom'
  	And I click 'jumptobottom'
  	And I wait for '1' seconds
  	Then I should not see element 'jumptobottom' present on page

Scenario: 3.26 Verify copy paste validation in message compose bar 
  	Given I search and select workspace 'StandardWST'
  	When I select 'StandardTopic' topic
  	And I perform 'Copy link' operation from 'StandardTopic' topic 3dots
  	Then I paste in message/reply 'msgcomposebar'

Scenario: 3.49 Verify Workspace topic info from topic 3 dots
  	Given I search and select workspace 'StandardWST'
  	When I select 'StandardTopic' topic
  	And I perform 'NA' operation from 'StandardTopic' topic 3dots
  	And I wait for visiblity of element 'topiccreatedbyinfo'
    Then I wait for visiblity of element 'topiccreatedoninfo'
  
Scenario: 3.20_3.21 - Verify message and reply on hover options from sender and recipient end
		Given I navigate to workassist homepage
  	When I search and select workspace 'StandardWST'
  	And I select 'StandardTopi' topic
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
  	And I send message 'Topic_AutoMsg' in topic
    And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
    And I genereate random text with current timestamp and store to 'Topic_AutoReply'
    And I send reply 'Topic_AutoReply' in topic
    And I validate message 'Topic_AutoMsg' on hover options from sender/recipient 'Sender'
    And I validate reply 'Topic_AutoReply' on hover options from sender/recipient 'Sender'
    And I logout and relogin with 'Hana@koraqa1.com','Outlook@123'
    And I search and select workspace 'StandardWST'
  	And I select 'StandardTopic' topic
  	And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
  	And I validate message 'Topic_AutoMsg' on hover options from sender/recipient 'Recipient'
    Then I validate reply 'Topic_AutoReply' on hover options from sender/recipient 'Recipient'
   
Scenario: 3.47 - Copy paste the copied link in message compose bar and reply compose bar
	  Given I logout and relogin with 'James@koraqa1.com','Outlook@123'
	  When I navigate to workassist homepage	 	
	  And I search and select workspace 'StandardWST'
  	And I select 'StandardTopic' topic
  	And I perform 'Copy link' operation from 'StandardTopic' topic 3dots
  	And I paste in message/reply 'msgcomposebar'
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
  	And I send message 'Topic_AutoMsg' in topic
    And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
  	Then I paste in message/reply 'reply_composebar'
  	
Scenario: 3.27 Verify message info from sender and rrecipient end 
    Given I navigate to workassist homepage	 	
	  When I search and select workspace 'StandardWST'
	  And I create topic as '<NewTopicname>'
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
  	And I send message 'Topic_AutoMsg' in topic
    And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'More'
    And I verify message info for user 'Hana Yori' and should be under ReadBy/DeliveredTo 'DeliveredTo'
		And I logout and relogin with 'Hana@koraqa1.com','Outlook@123'
		And I search and select workspace 'StandardWST'
		And I select '<NewTopicname>' topic
		And I logout and relogin with 'James@koraqa1.com','Outlook@123'
		And I search and select workspace 'StandardWST'
		And I select '<NewTopicname>' topic
		And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'More'
    And I verify message info for user 'Hana Yori' and should be under ReadBy/DeliveredTo 'ReadBy'
		And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
  	Then I delete topic
		
	 Examples:
 |NewTopicname|
 |DeleteMe_327|

 Scenario: 3.38 Verify reply info from sender and rrecipient end 
    Given I navigate to workassist homepage	 	
	  When I search and select workspace 'StandardWST'
	  And I create topic as '<NewTopicname>'
  	And I genereate random text with current timestamp and store to 'Topic_AutoMsg'
  	And I send message 'Topic_AutoMsg' in topic
  	And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
  	And I genereate random text with current timestamp and store to 'Topic_AutoReply'
    And I send reply 'Topic_AutoReply' in topic
		And I logout and relogin with 'Hana@koraqa1.com','Outlook@123'
		And I navigate to workassist homepage	
		And I search and select workspace 'StandardWST'
		And I select '<NewTopicname>' topic
		And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
		And I logout and relogin with 'James@koraqa1.com','Outlook@123'
		And I search and select workspace 'StandardWST'
		And I select '<NewTopicname>' topic
		And I go to message 'Topic_AutoMsg' and perform on hover action 'true' as 'Reply'
		And I go to reply 'Topic_AutoReply' and perform on hover action 'true' as 'More'
    And I verify reply info for user 'Hana Yori' and should be under ReadBy/DeliveredTo 'ReadBy'
		And I perform 'Manage' operation from '<NewTopicname>' topic 3dots
  	Then I delete topic
		
	 Examples:
 |NewTopicname|
 |DeleteMe_338|
	  	 	
	
  @clear 
  Scenario: clear hashmap
  Given I assert all
  When I clear hashmap 