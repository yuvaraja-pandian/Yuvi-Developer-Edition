@isTest
public class Contact_Trigger_Handler_Test {
    @isTest
    private static void Related_contacts_contains_Phone_Test(){
       
        //Test Account Creation************************************************************************************** 
        List<Account> not_null_Phone_Account = new List<Account>();
        List<Account> null_Phone_Account = new List<Account>();
        
        List<Contact> not_null_Phone_Contact = new List<Contact>();
        List<Contact> null_Phone_Contact = new List<Contact>();
       
        
        for(Integer i=1;i<=3;i++){
        Account a = new Account();
        a.Name = 'not_null_Phone_Account '+i;
        a.Phone = '123456';  
        not_null_Phone_Account.add(a); 
            
        Contact createContact = new Contact();
        createContact.AccountId = a.Id;
        createContact.Phone = a.Phone;
        createContact.LastName = a.Name;    
        not_null_Phone_Contact.add(createContact);    
            
            
            }
        
        for(Integer i=1;i<=3;i++){
        Account b = new Account();
        b.Name = 'null_Phone_Account '+i; 
            
        null_Phone_Account.add(b); 
        
        Contact NullcreateContact = new Contact();
        NullcreateContact.AccountId = b.Id;
        
        NullcreateContact.LastName = b.Name;    
        null_Phone_Contact.add(NullcreateContact);    
            }
        Test.startTest();
        insert not_null_Phone_Account ;
        insert not_null_Phone_Contact ;
        insert null_Phone_Account ;
        insert null_Phone_Contact ;
        Test.stopTest();
       
        //Test Contact Update**************************************************************************************
        
        
        List<Contact> Contact_not_null_Phone = new List<Contact>();
        Contact_not_null_Phone=[SELECT Id ,Name,Phone,AccountId FROM Contact WHERE AccountId =:not_null_Phone_Account[0].id];
        
        List<Contact> Contact_null_Phone = new List<Contact>();
        Contact_null_Phone=[SELECT Id ,Name,Phone,AccountId FROM Contact WHERE AccountId =:null_Phone_Account[0].id];
        
        
        
        
       
        
        
        //Test Account's All Related Contacts Contains Phone field check**************************************************************************************
        
        
        
        system.assertEquals(true, not_null_Phone_Account[0].All_Related_Contacts_Contains_Phone__c);
        system.assertEquals(False, null_Phone_Account[0].All_Related_Contacts_Contains_Phone__c);
        
    }

}