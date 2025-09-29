public class create_200Leads implements Database.Batchable<sObject> , Database.Stateful{
    
    
    
    public Database.QueryLocator start(Database.BatchableContext bc){
       
           
        return Database.getQueryLocator([SELECT Id , Name ,Rating from Account WHERE Name LIKE '%account%']);       
        
    } 
    public void execute(Database.BatchableContext bc , List<Account> acclist){
        
        List<Account> insertAccount = new List<Account>();
        
        for(Account acc : acclist){
             acc.Rating ='Hot';
             
             insertAccount.add(acc);
        }
        if(!insertAccount.isEmpty()){ 
       update insertAccount;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Total records inserted successfully' );
    }

}