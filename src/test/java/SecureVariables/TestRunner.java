package SecureVariables;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:SecureVariables"})
@RunWith(Karate.class)
public class TestRunner
{

} 