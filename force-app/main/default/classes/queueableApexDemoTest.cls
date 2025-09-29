@isTest
public class queueableApexDemoTest {
    
    @testSetup
    Static void setup(){
        List<Account> insertacclist = new List<Account>();
        
        for(Integer i=1;i<=50;i++){
            Account a = new Account();
            a.Name = 'testSetupAccount '+i;
            insertacclist.add(a);
        }
        
        if(!insertacclist.isEmpty()){
            insert insertacclist;
        }
    }
    
    
	@isTest
    private static void TestingQueueableApexDemo(){
        List<Account> acc =[SELECT Id, Name from Account WHERE Name LIKE 'testSetupAccount%'];
        queueableApexDemo obj = new queueableApexDemo(acc,'Retail');
        
        Test.startTest();
        	System.enqueueJob(obj);
        Test.stopTest();
        
        List<Account> acc1 =[SELECT Id, Name , Industry from Account WHERE Name LIKE 'testSetupAccount%'];
        System.assertEquals('Retail',acc1[0].Industry);
        
    }
}