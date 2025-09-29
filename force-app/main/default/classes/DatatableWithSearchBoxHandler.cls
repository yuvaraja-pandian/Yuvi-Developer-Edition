public class DatatableWithSearchBoxHandler {
	
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Industry FROM Account];
    }
}