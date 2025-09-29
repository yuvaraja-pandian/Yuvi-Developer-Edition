public class JSONdeserializeUntypedDemo {
	
    
    Public static void JsonDemo(){
        String jsonInput = '[{"Name": "John Doe","LastModifiedDate": {"LastModifiedDate1":"2024-08-30T12:00:00Z"}}]';
    
    	Map<String, Object> mapVar = (Map<String, Object>)JSON.deserializeUntyped(jsonInput);
    
    	System.debug(mapVar);
    }
}