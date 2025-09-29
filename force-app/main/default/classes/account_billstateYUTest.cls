@isTest
public class account_billstateYUTest {
    
    @TestSetup   
    public static void TestSetup(){
        
        List<Account> a = new List<Account>();
        
        for(Integer i=1;i<=10;i++){
            Account acco = new Account();
            acco.Name = 'Test Account '+i;
            a.add(acco);
        }
        insert a;
        
    }
    
    @isTest
    public static void Test_Method(){
         List<Account> acclist = [SELECT Id,Name , BillingState FROM Account WHERE Name LIKE 'Test Account %'];
        
        test.startTest();
        account_billstateYU obj = new account_billstateYU(acclist);
        Id jobId = system.enqueueJob(obj);
        test.stopTest();
        
    }

}