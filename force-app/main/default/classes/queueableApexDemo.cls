public class queueableApexDemo implements Queueable {
	
    Private List<Account> targetAccountList;
    Private String IndustryValue1;
    
    public queueableApexDemo(List<Account> accList,String IndustryValue){
        this.targetAccountList = accList;
        this.IndustryValue1 = IndustryValue;
    }
    
    public void execute(QueueableContext context) {
        List<Account> updateAccountList = new List<Account>();
        
        For(Account a : targetAccountList){
            Account a1 = new Account();
            a1.Id = a.Id;
            a1.Industry = this.IndustryValue1;
            updateAccountList.add(a1);
        }
        
        if(!updateAccountList.isEmpty()){
            update updateAccountList;
            System.debug(updateAccountList.Size());
        }
    }
}