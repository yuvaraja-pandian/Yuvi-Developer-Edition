public class cListView {   
        
        @AuraEnabled(Cacheable=true)
        public static list<Account> accountListLWC(){
            try {
                List<Account> acclist =[SELECT id,Name,Phone,Description FROM Account];
                system.debug(acclist);
                return acclist;
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

    
}