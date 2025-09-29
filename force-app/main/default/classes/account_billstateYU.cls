public class account_billstateYU implements Queueable {
    
    private List<Account> a ;
    
    public account_billstateYU(List<Account> a){
        this.a = a ;
    }
    
    public void execute(QueueableContext qc){
       
        List<Account> uplist = new List<Account>();
        
        for(Account acc : a){
            acc.BillingState = 'JA';
            uplist.add(acc);            
            
        }
        update uplist;
        
    }

}