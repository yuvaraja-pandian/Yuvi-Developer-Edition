@isTest
public class create_200LeadsTest {
    @testSetup
    static void setup(){
        
        List<Account> a = new List<Account>();
        
        for(Integer i=1;i<=10;i++){
            Account acco = new Account();
            acco.Name = 'Assignment account '+ i ;
            a.add(acco);
        }
        insert a;
    }
    
    
    
    
    @isTest
    public static void test(){       
        
        test.startTest();
        create_200Leads obj = new create_200Leads();
        id jodID = Database.executeBatch(obj);
        test.stopTest();
        
        
        
    } 

}