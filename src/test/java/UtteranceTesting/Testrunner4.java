package UtteranceTesting;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
@KarateOptions(features = { "classpath:token","classpath:UtteranceTesting"})
@RunWith(Karate.class)
public class Testrunner4
{

} 