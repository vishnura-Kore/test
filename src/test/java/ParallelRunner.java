


import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.Assert;
import org.junit.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.Runner.Builder;

import karate.org.apache.http.util.Asserts;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class ParallelRunner {
	
	@Test
	public void executeKarateTests() {
		Runner.parallel(getClass(), 15);
		Builder aRunner = new Builder();
		aRunner.path("classpath:CustomerValidationBot1");
		aRunner.outputCucumberJson(true);
		aRunner.parallel(15);
		//Runner.parallel(aRunner);
		Results result = aRunner.parallel(1);
		System.out.println("Total Feature => " + result.getFeaturesTotal());
		System.out.println("Total Scenarios => " + result.getScenariosTotal());
		System.out.println("Passed Scenarios => " + result.getScenariosPassed());
		System.out.println("Failed Scenarios => " + result.getScenariosFailed());
		generateCucumberReport(result.getReportDir());
		Assert.assertEquals("There are Some Failed Scenarios ", 0, result.getFailCount());
		
	}
	
	
	  private void generateCucumberReport(String reportDirLocation) { File
	  reportDir = new File(reportDirLocation); 
	  Collection<File> jsonCollection =  FileUtils.listFiles(reportDir, new String[] {"json"}, true);
	  
	  List<String> jsonFiles = new ArrayList<String>(); jsonCollection.forEach(file
	  -> jsonFiles.add(file.getAbsolutePath()));
	  
	  Configuration configuration = new Configuration(new File("target"), "XO Platform Karate Run");
	  ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, configuration);
	  reportBuilder.generateReports(); }
	 

}
