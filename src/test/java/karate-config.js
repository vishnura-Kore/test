function fn(){
	
	 {
var env = karate.env;
 if (!env) {
env = 'preprod';
}


var config = {

                 appUrl: 'https://staging-bots.korebots.com/api/1.1/', 
                username: 'botowner@koreai.in', 
                password: 'Kore#123',
                jwturl: 'https://demo.kore.net/mock/util/sts', 
                publicUrl: 'https://staging-bots.korebots.com/api', 
                runtimeUrl: 'https://staging-bots.korebots.com',
                }

if(env == 'staging') {
                config.appUrl = 'https://staging-bots.korebots.com/api/1.1/';
                config.username = 'botowner@koreai.in';
                config.password = 'Kore#123' ;
                config.jwturl = 'https://demo.kore.net/mock/util/sts';
                config.publicUrl ='https://staging-bots.korebots.com/api';
                config.runtimeUrl= 'https://staging-bots.korebots.com';
}
else if(env == 'qa1') {
           config.appUrl = 'https://qa1-bots.kore.ai/api/1.1/',
           config.username = 'owner@koreai.in',
           config.password = 'Kore@123'
           config.jwturl = 'https://demo.kore.net/mock/util/sts',
           config.publicUrl = 'https://qa1-bots.kore.ai/api/',
           config.runtimeUrl= 'https://qa1-bots.kore.ai'
}
 
else if(env == 'prod'){
           config.appUrl = 'https://bots.kore.ai/api/1.1/',
           config.username = 'botowner@koreai.in',
           config.password = 'Kore#123'
           config.jwturl = 'https://demo.kore.net/mock/util/sts',
           config.publicUrl = 'https://bots.kore.ai/api/',
           config.runtimeUrl = 'https://bots.kore.ai'
           }
           
           
           else if(env == 'preprod'){
           config.appUrl = 'https://preprod-bots.korebots.com/api/1.1/';
           config.username = 'botowner@koreai.in';
           config.password = 'Kore#123';
           config.jwturl = 'https://demo.kore.net/mock/util/sts';
           config.publicUrl = 'https://preprod-bots.korebots.com/api';
           config.runtimeUrl = 'https://preprod-bots.korebots.com';
           }
           
           
           else if(env == 'JAPAN') {
           config.appUrl = 'https://jp-bots.kore.ai/api/1.1',
           config.username = 'owner@koreai.in',
           config.password = 'Kore#123'
           config.jwturl = 'https://demo.kore.net/mock/util/sts',
           config.publicUrl = 'https://jp-bots.kore.ai/api/',
           config.runtimeUrl= 'https://jp-bots.kore.ai'
}
  else if(env == 'EUPROD') {
           config.appUrl = 'https://eu-bots.kore.ai/api/1.1',
           config.username = 'owner@koreai.in',
           config.password = 'Kore@123456'
           config.jwturl = 'https://demo.kore.net/mock/util/sts',
           config.publicUrl = 'https://eu-bots.kore.ai/api/',
           config.runtimeUrl= 'https://eu-bots.kore.ai'
}

else if(env == 'post') {
           config.appUrl = 'https://ebaysandbox.korebots.com/api/1.1',
           config.username = 'installer@kore.com',
           config.password = 'Kore@123'
           config.jwturl = 'https://demo.kore.net/mock/util/sts',
           config.publicUrl = 'https://ebaysandbox.korebots.com/api/',
           config.runtimeUrl= 'https://ebaysandbox.korebots.com'
}

else if(env == 'sit') {
           config.appUrl = 'https://sit-bots.kore.ai/api/1.1',
           config.username = 'owner@koreai.in',
           config.password = 'Kore@123'
           config.jwturl = 'https://demo.kore.net/mock/util/sts',
           config.publicUrl = 'https://sit-bots.kore.ai/api/',
           config.runtimeUrl= 'https://sit-bots.kore.ai'
}

else if(env == 'IDFC') {
           config.appUrl = 'https://bots-dev.korebots.com/api/1.1',
           config.username = 'jan12@idfc.com',
           config.password = 'IdfcKore@123'
           config.jwturl = 'https://demo.kore.net/mock/util/sts',
           config.publicUrl = 'https://bots-dev.korebots.com/api/',
           config.runtimeUrl= 'https://bots-dev.korebots.com'
}
else if(env == 'DE-BOTS') {
           config.appUrl = 'https://de-bots.kore.ai/api/1.1',
           config.username = 'owner@koreai.in',
           config.password = 'Kore#123'
           config.jwturl = 'https://demo.kore.net/mock/util/sts',
           config.publicUrl = 'https://de-bots.kore.ai/api/',
           config.runtimeUrl= 'https://de-bots.kore.ai'
}
else if(env == 'installer') {
           config.appUrl = 'https://installer-598-use1.korebots.com/api/1.1',
           config.username = 'installer@kore.com',
           config.password = 'Kore@123'
           config.jwturl = 'https://demo.kore.net/mock/util/sts',
           config.publicUrl = 'https://installer-598-use1.korebots.com/api/',
           config.runtimeUrl= 'https://installer-598-use1.korebots.com'
}
result = karate.callSingle('classpath:token/1_0AuthToken.feature',config);

//karate.log('config log',result);
//karate.configure('userId', result.response.authorization.accessToken)

//karate.log('token log--------------------------------------------------------------------------------',userId);

config.ids=  {userId: result.response.userInfo.id, accessToken: result.response.authorization.accessToken}
karate.configure('retry',{ count:10, interval:5000});

 return config 

}}


