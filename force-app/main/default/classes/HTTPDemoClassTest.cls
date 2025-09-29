@isTest
public class HTTPDemoClassTest {
	@TestSetup
    private static void setup(){
        
    }
    
    @isTest
    public static void testHTTP(){
        Test.startTest();
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setHeader('Content-Type', 'application/json');
        mockResponse.setBody('[{"hello":"Yuvaraja"}]');
        mockResponse.setStatusCode(200);
 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(mockResponse));
 
        HTTPDemoClass.getWeatherAPI();
        Test.stopTest();
    }
}