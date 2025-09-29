@isTest
public class futureMethodDemoTest {
	@isTest
    private static void updateAccountWebsiteTest(){
        
        List<Account> acclist = new List<Account>();
        
        for(Integer i=1 ; i<=5;i++){
            Account a = new Account();
            a.Name = 'test Account '+ i;
            acclist.add(a);
        }
        
        if(!acclist.isEmpty()){
            insert acclist;
        }
        
        //initializing future method
        List<Account> acclist2 = [SELECT Id FROM Account WHERE ID in:acclist];
        List<Id> Idlist = new List<Id>();
        for(Account a1:acclist2){
    		Idlist.add(a1.Id);
		}
        
        Test.startTest();        
        	futureMethodDemo.updateAccountWebsite(Idlist);
        Test.stopTest();
        
        List<Account> acclist3 = [SELECT ID,Website from Account limit 2];
        System.assertEquals('www.google.com',acclist3[0].Website);
       
    }
}