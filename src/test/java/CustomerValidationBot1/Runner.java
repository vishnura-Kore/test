package CustomerValidationBot1;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:CustomerValidationBot1"})
@RunWith(Karate.class)
public class Runner
{

} 