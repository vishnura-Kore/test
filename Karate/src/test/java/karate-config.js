function fn(){
	
	var env = karate.env;
	  if (!env) {
			env = 'staging';
			}
	
	
var config = {
				appUrl:  'https://staging-bots.korebots.com/api/1.1/', 
                username: 'botowner@koreai.in', 
                password: 'Kore@123456' ,
                jwturl: 'https://demo.kore.net/mock/util/sts', 
                publicUrl: 'https://staging-bots.korebots.com/api', 
                runtimeUrl: 'https://staging-bots.korebots.com',
                }

			if(env == 'staging') {
				config.appUrl = 'https://staging-bots.korebots.com/api/1.1/', 
                config.username= 'botowner@koreai.in', 
                config.password = 'Kore@123456' ,
                config.jwturl = 'https://demo.kore.net/mock/util/sts', 
                config.publicUrl ='https://staging-bots.korebots.com/api', 
                config.runtimeUrl= 'https://staging-bots.korebots.com'
				}
			else if(env == 'qa1') {
	            config.appUrl = 'https://qa1-bots.kore.ai/api/1.1/',
	            config.username ='botowner@koreai.in',
	            config.password ='Kore@112233'
	            config.jwturl ='https://demo.kore.net/mock/util/sts',
	            config.publicUrl ='https://staging-bots.korebots.com/api',
	            config.runtimeUrl='https://staging-bots.korebots.com'
				}
 
			else if(env == 'prod'){
	            config.appUrl = 'https://bots.kore.ai/api/1.1/',
	            config.username ='botowner@koreai.in',
	            config.password ='Kore@1122'
	            config.jwturl ='https://demo.kore.net/mock/util/sts',
	            config.publicUrl ='https://bots.kore.ai/api/',
	            config.runtimeUrl='https://bots.kore.ai'
	            }
result = karate.callSingle('classpath:token/1_0AuthToken.feature',config);

//karate.log('config log',result);
//karate.configure('userId', result.response.authorization.accessToken)

//karate.log('token log--------------------------------------------------------------------------------',userId);

config.ids=  {userId: result.response.userInfo.id, accessToken: result.response.authorization.accessToken}
karate.configure('retry',{ count:10, interval:5000});

 return config 

}


