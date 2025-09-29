public class account_Trigger_Handler {
    public static void AccountCopyBillingToShipping(list<Account> triggeredValues){ 
        if(!triggeredValues.isEmpty()){
        for(Account a : triggeredValues ){
            
            a.ShippingStreet     = a.BillingStreet;
            a.ShippingCity       = a.BillingCity;
            a.ShippingPostalCode = a.BillingPostalCode;
            a.ShippingState      = a.BillingState;
            a.ShippingCountry    = a.BillingCountry;    
        }}
    }

    public static void AccountPhoneisRequired(list<Account> triggeredValues){
        if(!triggeredValues.isEmpty()){
        for(Account a : triggeredValues ){
            if(a.Phone==null){
                a.addError('Phone number is required');
            }
               
        }}
    }
    
    public static void createContactonTheCreatedAccount(list<Account> triggeredValues){
        if(!triggeredValues.isEmpty()){
            List<Contact> insertContact = new List<Contact>();
        for(Account a : triggeredValues ){
            Contact con = new Contact();
               con.AccountId = a.Id;
               con.LastName = a.Name;
               con.Phone = a.Phone;
               insertContact.add(con);
                
        }insert insertContact;}
        
    }
    public static void updatePhoneOnContact(list<Account> New_triggeredValues,list<Account> old_triggeredValues){
        
        List<Contact> c = new List<Contact>();
        set<Id> accId = new set<Id>();
        
        
       
        for(Account a : New_triggeredValues){
            for(Account old : old_triggeredValues){
            if(a.Phone != old.phone){
            accId.add(a.Id);
            for(Contact con : [SELECT Id ,Name, Phone FROM Contact WHERE AccountId IN:accId]){
            con.AccountId = a.Id;    
            con.Phone = a.Phone;
            c.add(con);
            }}}
  
        
        }   
        update c;
    } 
   /* public static void relatedContactsPhoneButton(list<Account> New_triggeredValues,list<Account> old_triggeredValues){
        set<Id> accid = new set<Id>();
        for(Account acc : New_triggeredValues){
            for(Account acc1 :old_triggeredValues){
                accid.add(acc.Id);
            }
            
            
        }
        
    }*/

}