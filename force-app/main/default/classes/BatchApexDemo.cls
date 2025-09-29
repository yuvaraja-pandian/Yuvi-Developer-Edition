public class BatchApexDemo implements Database.batchable<sObject>{
    
    Public Integer recordCount = 0;
    
	public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,Name ,Industry FROM Account]);
    }
    
    public void execute(Database.BatchableContext bc, list<Account> acclist){
        List<Account> updateAccList = new List<Account>();
        
        for(Account a: acclist){
            Account a1 = new Account();
            a1.Id = a.Id;
            a1.Industry = 'Chemicals';
            updateAccList.add(a1);
        }
        
        if(!updateAccList.isEmpty()){
            update updateAccList;
            recordCount= recordCount + updateAccList.Size();
        }
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('Total records processed : '+recordCount);
    }
}