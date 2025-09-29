public class HTTPDemoClass {
	
    public static void getWeatherAPI(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
     	req.setEndpoint('callout:http://api.weatherapi.com/v1');
     	req.setMethod('GET');
        req.setHeader('Content-Type','application/json');
        
        HttpResponse res = http.send(req);
        
         System.debug(res.getBody());
    }
}