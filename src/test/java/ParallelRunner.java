


import org.junit.Assert;
import org.junit.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.Runner.Builder;

import karate.org.apache.http.util.Asserts;

public class ParallelRunner {
	
	@Test
	public void executeKarateTests() {
		Runner.parallel(getClass(), 15);
		Builder aRunner = new Builder();
		aRunner.path("classpath:src/test/java");
		aRunner.parallel(15);
		//Runner.parallel(aRunner);
		Results result = aRunner.parallel(15);
		System.out.println("Total Feature => " + result.getFeaturesTotal());
		System.out.println("Total Scenarios => " + result.getScenariosTotal());
		System.out.println("Passed Scenarios => " + result.getScenariosPassed());
		System.out.println("Failed Scenarios => " + result.getScenariosFailed());
		Assert.assertEquals("There are Some Failed Scenarios ", 0, result.getFailCount());
		
	}
}
