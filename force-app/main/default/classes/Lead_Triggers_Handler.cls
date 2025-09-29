public class Lead_Triggers_Handler {
    public static void EmailToEmailHistoryIsInsert(List<Lead> newListValues){
        for(Lead l:newListValues){
            l.Email_History__c = l.Email;
        }
        
    }
    public static void EmailToEmailHistoryIsUpdate(List<Lead> newListValues,List<Lead> oldListValues){
       
        for(Lead l:newListValues){
            
            for(Lead old : oldListValues){                
            
            if(l.Email != null && l.Email != old.Email ){
            l.Email_History__c = l.Email_History__c+' ; '+l.Email;
        
            }
           
            }
        }
    

}
}