
import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:Analytics_BAC","classpath:DeprecateUB","classpath:WordLengthValidation","classpath:CustomDashBoardFilters","classpath:GoalDrivenNLU_ShortUtterence","classpath:AppCredentials"})
@RunWith(Karate.class)
public class TestRunner2
{

} 

