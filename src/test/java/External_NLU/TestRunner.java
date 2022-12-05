package External_NLU;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:External_NLU"})
@RunWith(Karate.class)
public class TestRunner
{

} 