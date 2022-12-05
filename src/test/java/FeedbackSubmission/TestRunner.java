package FeedbackSubmission;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","1_0CreateAdminAppScopes","1_1GenerateJWTtoken","1_2SurveySubmission"})
@RunWith(Karate.class)
public class TestRunner
{

} 