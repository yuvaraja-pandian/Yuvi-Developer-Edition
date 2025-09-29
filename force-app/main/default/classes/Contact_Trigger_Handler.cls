public class Contact_Trigger_Handler {
    public static void Related_contacts_contains_Phone(List<Contact> newListValues,List<Contact> oldListValues){
        set<Id> conId = new set<Id>();
        List<Account> acclist = new List<Account>();
        
        
        for(Contact c : newListValues){
            conId.add(c.AccountId);
            for(Contact c1 : oldListValues){
                for(Account acc:[SELECT Id,Name,All_Related_Contacts_Contains_Phone__c FROM Account WHERE Id IN:conId]){
                    if(acc.All_Related_Contacts_Contains_Phone__c == true && c.Phone == null){
                        acc.All_Related_Contacts_Contains_Phone__c = false;
                        acclist.add(acc);
                    }else if(acc.All_Related_Contacts_Contains_Phone__c == false && c.Phone != null){
                        acc.All_Related_Contacts_Contains_Phone__c = true;
                        acclist.add(acc);
                    }
                }
                
                
            }
        }update acclist;
    }
    
    
    /*public static void WelcomeEmail(List<Contact> newListValues,List<Contact> oldListValues){
        List<Messaging.Email> EmailList = new List<Messaging.Email>();
        for(Contact con :newListValues){
            if(con.Email != null){
                Messaging.SingleEmailMessage Single_email = new Messaging.SingleEmailMessage();
                String[] contactEmail = new String[]{con.Email};
                Single_email.setToAddresses(contactEmail);
                String subject = 'Thankyou for adding your Email into salesforce '+con.Name;
                Single_email.setSubject(subject);
                String senderName = 'Yuvaraja P SalesForce Administator';
                Single_email.setSenderDisplayName(senderName);
                String contentBody = 'Welcome aboard! Exciting journey ahead 🚀 Let\'s thrive together!</br></br>'+ 'We\'re thrilled to have you on board and look forward to achieving great things together.</br></br>'+ 'If you have any questions or need assistance, don\'t hesitate to reach out.</br></br>'+ 'Let\'s get started on this exciting journey.';
                Single_email.setHtmlBody(contentBody);
                EmailList.add(Single_email);
            }
            
        } Messaging.sendEmail(EmailList);
        
    }*/
}