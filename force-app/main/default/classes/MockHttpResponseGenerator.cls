@isTest(seealldata=false)
global class MockHttpResponseGenerator implements HttpCalloutMock {
    private HttpResponse response;
 
    public MockHttpResponseGenerator(HttpResponse res) {
        this.response = res;
    }
 
    public HTTPResponse respond(HTTPRequest req) {
        return response;
    }
}