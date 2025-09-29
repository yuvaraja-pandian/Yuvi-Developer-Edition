public class futureMethodDemo {
	@future
    public static void updateAccountWebsite(List<Id> accId){
        
        List<Account> acclist = [SELECT Id,Name,Website FROM Account WHERE Id in:accId];
        List<Account> updateacclist = new  List<Account>();
        
        for(Account a:acclist){
            Account acc = new Account();
            acc.Id = a.Id;
            acc.Website = 'www.google.com';
            updateacclist.add(acc); 
        }
        
        if(!updateacclist.isEmpty()){
            update updateacclist;
        }
    }
}