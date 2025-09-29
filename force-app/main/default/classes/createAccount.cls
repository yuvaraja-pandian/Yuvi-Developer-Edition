public class createAccount {
    @AuraEnabled//(Cacheable=true)
    public static void AccountCreation(String name ,String phone,String rating , String description , String active){
        
        try{           
            if(Schema.sObjectType.Account.isCreateable()
               && Schema.sObjectType.Account.fields.Name.isCreateable()
               &&Schema.sObjectType.Account.fields.Phone.isCreateable()
              &&Schema.sObjectType.Account.fields.Rating.isCreateable()
              &&Schema.sObjectType.Account.fields.Description.isCreateable()
              && Schema.sObjectType.Account.fields.Active__c.isCreateable()
              ){
               Account acc = new Account();
            acc.Name=name;
            acc.Phone=phone;
            acc.Rating=rating;
            acc.Description=description;
            acc.Active__c=active;
            insert acc; 
            }
            
                }
        catch(Exception e){
                    throw new AuraHandledException(e.getMessage());
                }
            
        
    }

}