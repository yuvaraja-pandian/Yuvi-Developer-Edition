public class ACCOUNT_BILL_TO_SHIP {
    @Future
    public static void execute(List<Id> accids){
        List<Account> a = new List<Account>();
        List<Account> acclist = new List<Account>();
        acclist = [SELECT Id ,Name,BillingCity,BillingCountry,BillingPostalCode,BillingState ,BillingStreet FROM Account WHERE Id IN:accids];
        
        for(Account acc: acclist){
            
              acc.ShippingCity = acc.BillingCity; 
              acc.ShippingCountry = acc.BillingCountry;
              acc.ShippingPostalCode = acc.BillingPostalCode ;
              acc.ShippingState = acc.BillingState; 
              acc.ShippingStreet = acc.BillingStreet; 
              a.add(acc);  
             
                             
        } update a;
        
        
    }

}