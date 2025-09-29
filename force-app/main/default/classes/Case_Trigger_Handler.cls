public class Case_Trigger_Handler {
    public static void setPriorityasMedium(List<Case> NewValue ,List<Case> oldValue){
       
        for(Case c : NewValue){
            if(c.Origin =='Email'){
                c.Status ='New';
                c.Priority ='Medium';
                
            }
        }
        
    }   
}