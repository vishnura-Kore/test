
import org.junit.Test;
import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.Runner.Builder;
import com.intuit.karate.junit4.Karate;
//@KarateOptions(features = { "classpath:token","classpath:Analytics_BAC","classpath:DeprecateUB","classpath:WordLengthValidation","classpath:publicAPIs","classpath:BotHealthandMonitoring","classpath:BatchTesting_HealthandMonitoring","classpath:GoalDrivenNLU_ShortUtterence","classpath:CustomerValidationBot","classpath:AppCredentials"})
@RunWith(Karate.class)
public class TestRunner2
{
	@Test
	public void executeKarateTests() {
		Runner.parallel(getClass(), 1);
		Builder aRunner = new Builder();
		aRunner.path("classpath:src/test/java");
		aRunner.parallel(1);
		//Runner.parallel(aRunner);
		Results result = aRunner.parallel(1);
	}
	
} 