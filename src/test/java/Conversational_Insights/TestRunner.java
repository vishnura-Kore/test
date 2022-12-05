package Conversational_Insights;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:Conversational_Insights"})
@RunWith(Karate.class)
public class TestRunner
{

} 