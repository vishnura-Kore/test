import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:BillingRequestsProactiveNotification","classpath:SecureVariables","classpath:FeedbackSubmission","classpath:Feedback_SurveyCreation","classpath:Feedback_ConversationHistory","classpath:External_NLU","classpath:Conversational_Insights","classpath:BillingRequestsFreePlanBAC","classpath:DataTablesandViews","classpath:Conversation_History","classpath:BillingRequestsFreePlan"})
@RunWith(Karate.class)
public class Runner10Userstoeries
{

} 

