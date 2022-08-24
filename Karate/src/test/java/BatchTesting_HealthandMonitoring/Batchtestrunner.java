package BatchTesting_HealthandMonitoring;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:BatchTesting_HealthandMonitoring"})
@RunWith(Karate.class)
public class Batchtestrunner
{

} 