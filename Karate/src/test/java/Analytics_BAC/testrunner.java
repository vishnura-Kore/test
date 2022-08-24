package Analytics_BAC;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:Analytics_BAC"})
@RunWith(Karate.class)
public class testrunner
{

} 