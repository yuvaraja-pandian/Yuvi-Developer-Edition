public class pathFunctionalityComponentHandler {
	@AuraEnabled(cacheable=true)
    public static List<String> getObjectsPicklistFields(String recordId) {
        List<String> picklistFields = new List<String>();
        
        String objectName = getObjectType(recordId);
        
        picklistFields = getPicklistFields(objectName);
        
        return picklistFields;
    }
    
    @AuraEnabled(cacheable=true)
    public static String getObjectType(String recordId) {
		String objectName;
        if (String.isBlank(recordId)) {
            return null;
        }
        
        try {
            // Convert the String to an Id type
            Schema.SObjectType objType = Id.valueOf(recordId).getSObjectType();
            objectName = objType.getDescribe().getName();
            return objectName;
            
        } catch (Exception e) {
            System.debug('Error fetching object type: ' + e.getMessage());
            return null;
        }
    }
    
    
  /*  @AuraEnabled(cacheable=true)
    public static List<String> getPicklistFields(String objectApiName) {
        List<String> picklistFields = new List<String>();

        if (String.isBlank(objectApiName)) {
            return picklistFields;
        }

        try {
            // Get the object's schema describe information
            Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectApiName).getDescribe().fields.getMap();

            for (String fieldName : fieldMap.keySet()) {
                Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();
                
                // Check if the field is of type Picklist
                if (fieldDescribe.getType() == Schema.DisplayType.Picklist) {
                    picklistFields.add(fieldName);
                }
            }
        } catch (Exception e) {
            System.debug('Error retrieving picklist fields: ' + e.getMessage());
        }

        return picklistFields;
    }*/
    
    @AuraEnabled
 	public static List<String> getPickList(String objectName , String fieldName ){
        system.debug(objectName);
        system.debug(fieldName);
       	List<String> returnPicklistValues = new List<String>();
    	Schema.SObjectType objSobjectType = Schema.getGlobalDescribe().get(objectName) ;
		Schema.DescribeSObjectResult objDescribeSobject = objSobjectType.getDescribe() ;
        
		Map<String,Schema.SObjectField> fields = objDescribeSobject.fields.getMap() ;
		Schema.DescribeFieldResult fieldResult = fields.get(fieldName).getDescribe();
        
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
		for( Schema.PicklistEntry pickListVal : ple){
    		//System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
            returnPicklistValues.Add(pickListVal.getValue());
		}       
        return returnPicklistValues;
	}
    
    @AuraEnabled(cacheable=true)
	public static List<String> getPicklistFields(String objectApiName) {
    	List<String> picklistFields = new List<String>();

    	if (String.isBlank(objectApiName)) {
        	return picklistFields;
    	}

    	try {
        	// Get the object's schema describe information
        	Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectApiName).getDescribe().fields.getMap();

        	for (Schema.SObjectField field : fieldMap.values()) {
            		Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
            
            		// Check if the field is of type Picklist
            		if (fieldDescribe.getType() == Schema.DisplayType.Picklist) {
                		picklistFields.add(fieldDescribe.getName()); // Get exact API name
            		}
        		}
    		} catch (Exception e) {
        			System.debug('Error retrieving picklist fields: ' + e.getMessage());
    		}

    		return picklistFields;
	}
    
    
    

}