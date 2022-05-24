public  with sharing class DisplayContact {
    
    @AuraEnabled
   
     public static List<Contact> display()
    {
        return [select name from Contact order by name];
    }
    
    @AuraEnabled
      public static List<Contact> displayRecord(String cid)
    { String newSearchText = '%'+cid+'%';
        //return [select FirstName,LastName,Email,Phone from Contact where LastName= :cid];
       
        return [select FirstName,LastName,Email,Phone from Contact where LastName like:newSearchText LIMIT 1];
        //return [select FirstName,LastName,Email,Phone from Contact where Id= :cid];
    }
            
    @AuraEnabled
     public static String loaddata(String cfname,String clname,String cemail,String cphone)
    {
       Contact c=new Contact(FirstName=cfname,LastName=clname,Email=cemail,Phone=cphone);
           try
       {
           insert c;
           return 'record successfulyy loaded';
       }
        catch(System.DmlException e)
        {
            return e.getMessage();
        }
    }
    

}