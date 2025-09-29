public class picklistMethods {
			/**
 * @description Retrieves dependent picklist values based on a controlling field's selected value
 * @param objectName - API name of the object
 * @param controllingFieldName - API name of the controlling field
 * @param controllingFieldSelectedValue - Selected value of the controlling field
 * @return List<String> - Available dependent picklist values for the selected controlling value
 */
		public static List<String> getDependentPicklistValues(String objectName, String controllingFieldName, String controllingFieldSelectedValue){
    		List<String> dependentValues = new List<String>();
    
    		// Get the object's describe result
    		Schema.DescribeSObjectResult objDescribe = ((SObject) Type.forName(objectName).newInstance()).getSObjectType().getDescribe();
    
    		// Get the dependent field's describe result
    		Schema.DescribeFieldResult dependentFieldDescribe;
    
    		// Find all picklist fields on the object that have the specified controlling field
    		Map<String, Schema.SObjectField> fieldsMap = objDescribe.fields.getMap();
    			for (Schema.SObjectField field : fieldsMap.values()) {
        			Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
                
        			if (fieldDescribe.getType() == Schema.DisplayType.PICKLIST && fieldDescribe.getController() != null && fieldDescribe.getController().getDescribe().getName() == controllingFieldName) {
            			dependentFieldDescribe = fieldDescribe;
            			break;
        			}
    			}
    
    		if (dependentFieldDescribe == null) {
        		return dependentValues; // Return empty list if no dependent field found
    		}
    
    		// Get all valid values for the controlling field
    		List<Schema.PicklistEntry> controllingValues = dependentFieldDescribe.getController().getDescribe().getPicklistValues();
    
    		// Find the controlling value's index
    		Integer controllingValueIndex = -1;
    		for (Integer i = 0; i < controllingValues.size(); i++) {
        		if (controllingValues[i].getValue() == controllingFieldSelectedValue) {
            		controllingValueIndex = i;
            		break;
        		}
    		}
    
    		if (controllingValueIndex == -1) {
        		return dependentValues; // Controlling value not found
    		}
    
    		// Get the dependent picklist values
    		List<Schema.PicklistEntry> dependentEntries = dependentFieldDescribe.getPicklistValues();
    
    		// Use JSON serialize/deserialize to access the validFor property
    		for (Schema.PicklistEntry entry : dependentEntries) {
        		if (entry.isActive()) {
            		// Serialize the entry to access hidden properties
            		String jsonEntry = JSON.serialize(entry);
            		Map<String, Object> entryMap = (Map<String, Object>) JSON.deserializeUntyped(jsonEntry);
            
            		// Check if validFor exists in the serialized data
            		if (entryMap.containsKey('validFor')) {
                		String validFor = (String) entryMap.get('validFor');
                		if (isBitSet(validFor, controllingValueIndex)) {
                    		dependentValues.add(entry.getValue());
                		}
            		}
        		}
    		}
    
    		return dependentValues;
        }

		private static Boolean isBitSet(String validFor, Integer bitIndex) {
    		if (validFor == null || bitIndex < 0) {
        		return false;
    		}
    
    		// Convert the base64 string to bytes
    		Blob validForBits = EncodingUtil.base64Decode(validFor);
    		String hexString = EncodingUtil.convertToHex(validForBits);
    
    		// Calculate which byte and bit position we need to check
    		Integer byteIndex = bitIndex / 8;
    		Integer bitPosition = 7 - (bitIndex - (byteIndex * 8)); // MSB first
    
    		// Check if we have enough bytes
    		if (byteIndex >= hexString.length() / 2) {
        		return false;
    		}
    
    		// Get the specific byte (two hex characters)
    		String byteString = hexString.substring(byteIndex * 2, byteIndex * 2 + 2);
    
    		// Convert hex string to integer
    		Integer byteValue = hexToInteger(byteString);
    
    		// Check the specific bit
    		return ((byteValue >> bitPosition) & 1) == 1;
		}

		private static Integer hexToInteger(String hex) {
    		// Create a map of hex characters to their integer values
    		Map<String, Integer> hexMap = new Map<String, Integer>{
        		'0' => 0, '1' => 1, '2' => 2, '3' => 3,
        		'4' => 4, '5' => 5, '6' => 6, '7' => 7,
        		'8' => 8, '9' => 9, 'A' => 10, 'B' => 11,
        		'C' => 12, 'D' => 13, 'E' => 14, 'F' => 15,
        		'a' => 10, 'b' => 11, 'c' => 12, 'd' => 13,
        		'e' => 14, 'f' => 15
    		};
    
    	// Convert each character and calculate the value
    	Integer value = 0;
    	for (Integer i = 0; i < hex.length(); i++) {
        	String c = hex.substring(i, i + 1);
        	if (!hexMap.containsKey(c)) {
            	return 0; // Invalid hex character
        	}
        	value = value * 16 + hexMap.get(c);
    	}
    	return value;
	}
}