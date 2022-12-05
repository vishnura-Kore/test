package Feedback_Dashboard;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:Feedback_Dashboard"})
@RunWith(Karate.class)
public class TestRunner
{

} 