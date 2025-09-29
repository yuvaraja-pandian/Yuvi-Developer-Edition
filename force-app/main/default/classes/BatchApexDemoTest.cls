@isTest
public class BatchApexDemoTest {

    @isTest
    private static void TestingBatchApexDemo(){
        
        List<Account> acclist = new List<Account>();
        
        for(Integer i=1 ; i<=200;i++){
            Account a = new Account();
            a.Name = 'test Account '+ i;
            a.Industry = 'Banking';
            acclist.add(a);
        }
        
        if(!acclist.isEmpty()){
            insert acclist;
        }
        
        Test.startTest();        
        	BatchApexDemo obj = new BatchApexDemo();
			Database.executeBatch(obj);
        Test.stopTest();
        
        List<Account> acclist3 = [SELECT ID,Industry from Account limit 2];
        System.assertEquals('Chemicals',acclist3[0].Industry);
    }
}