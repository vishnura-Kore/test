package AmbiguousEvents;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:AmbiguousEvents"})
@RunWith(Karate.class)
public class TestRunner
{

} 