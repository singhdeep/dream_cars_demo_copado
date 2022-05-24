trigger LeadTrigger on Lead (before insert) 
{
        Integer allLeadEqualToLead1 = 100000000;
        List<Lead> leadList = new  List<Lead>();
        
        for(lead l:trigger.new)
        {    
            leadList.add(l);       
        }
        Set<ID> userID = new Set<ID>();
        List<User> advUser =[select id,name,city,marital_status__c,postalcode,age__c,Interest__c from user where profile.id ='00ej00000016eOY' and IsActive =: true];
       // List<User> advUser =[select id,name,city,postalcode,age__c from user];
        Map<String,Integer> userIDRecordCount = new Map<String,Integer>();
        System.debug('advUser' + advUser );
        
        for(User userObj : advUser)
        {
            userID.add(userObj.id);            
            userIDRecordCount.put(userObj.id,0);
        }
        
        
    
        AggregateResult[] leadResults  = [SELECT ownerId, COUNT(id) FROM lead where ownerID in :userID GROUP BY ownerid ];
        
        System.debug('leadResults---'+ leadResults  );
        for(AggregateResult aggrObj :leadResults)
        {
            userIDRecordCount.put(aggrObj.get('OwnerId')+'' ,(Integer) aggrObj.get('expr0'));
        }
        
        
        integer i=-1;
        Boolean matchFound = false;
        List<Lead> matchNotFoun = new List<Lead>();
        
        
        // Check If All lead deatils is matching with user .
                
        for(Lead leadObj : leadList)
        {   
            i++;
            matchFound = false;
            allLeadEqualToLead1 = 100000000;    
            System.debug('leadOBj--'+ leadOBj); 
            
            if(leadObj.Interest__c == null){
                leadObj.Interest__c = '';
            }
            
            for(User userObj: advUser)
            {          
                if(userObj.Interest__c == null){
                userObj.Interest__c = '';
                }
                
                System.debug('Before Compare IF-- LeadOBJ'+leadObj.age__C+ ' ' + leadObj.City + ' ' + leadObj.postalcode + ' '+ leadObj.marital_status__c + ' ' + leadObj.interest__c);
                System.debug('Before Compare IF-- userObj'+leadObj.age__C+ ' ' + userObj.City + ' ' + userObj.postalcode + ' '+ userObj.marital_status__c + ' ' + userObj.interest__c);
                
                if(leadObj.age__C == userObj.age__C && leadObj.postalcode ==userObj.postalcode 
                    && leadObj.City == userObj.City  && leadObj.marital_status__c== userObj.marital_status__c 
                        && leadObj.Interest__c.contains(userObj.Interest__c) )
                {          
                    System.debug('In Compare IF-- LeadOBJ'+leadObj.age__C+ ' ' + leadObj.City + ' ' + leadObj.postalcode);
                    if(userIDRecordCount.keySet().contains(UserObj.id) 
                        && userIDRecordCount.get(UserObj.id) < allLeadEqualToLead1)
                    {              
                        allLeadEqualToLead1  =  userIDRecordCount.get(UserObj.id);
                        leadObj.ownerID =  UserObj.id;
                        leadObj.assignment__c  = true;                                                       
                        matchFound = true;
                        
                    }
                }
            }
            if(!matchFound)
            {                        
                matchNotFoun.add(leadObj);
            }
        }
        
        leadList.clear();
        leadList.addAll(matchNotFoun);
        matchNotFoun.clear(); 
        i=-1;
        
        
        
        
        for(Lead leadObj : leadList)
        {   
            i++;
            matchFound = false;
            allLeadEqualToLead1 = 100000000;    
            System.debug('leadOBj--'+ leadOBj); 
            
            if(leadObj.Interest__c == null){
                leadObj.Interest__c = '';
            }
            
            for(User userObj: advUser)
            {          
                if(userObj.Interest__c == null){
                userObj.Interest__c = '';
                }
                
                System.debug('Before Compare IF-- LeadOBJ'+leadObj.age__C+ ' ' + leadObj.City + ' ' + leadObj.postalcode);
                if(leadObj.age__C == userObj.age__C && leadObj.postalcode ==userObj.postalcode 
                    && leadObj.City == userObj.City && leadObj.Interest__c.contains(userObj.Interest__c) )
                {          
                    System.debug('In Compare IF-- LeadOBJ'+leadObj.age__C+ ' ' + leadObj.City + ' ' + leadObj.postalcode);
                    if(userIDRecordCount.keySet().contains(UserObj.id) 
                        && userIDRecordCount.get(UserObj.id) < allLeadEqualToLead1)
                    {              
                        allLeadEqualToLead1  =  userIDRecordCount.get(UserObj.id);
                        leadObj.ownerID =  UserObj.id;
                        leadObj.assignment__c  = true;                                                       
                        matchFound = true;
                        
                    }
                }
            }
            if(!matchFound)
            {                        
                matchNotFoun.add(leadObj);
            }
        }
        
        leadList.clear();
        leadList.addAll(matchNotFoun);
        matchNotFoun.clear(); 
        i=-1;
        
        
        
        // Check If All lead deatils is matching with user .
        for(Lead leadObj : leadList)
        {   
            i++;
            matchFound = false;
            allLeadEqualToLead1 = 100000000;    
            System.debug('leadOBj--'+ leadOBj); 
            if(leadObj.Interest__c == null){
                leadObj.Interest__c = '';
            }
            for(User userObj: advUser)
            {       
                if(userObj.Interest__c == null){
                userObj.Interest__c = '';
                }   
                System.debug('Before Compare IF-- LeadOBJ'+leadObj.age__C+ ' ' + leadObj.City + ' ' + leadObj.postalcode);
                if(leadObj.postalcode == userObj.postalcode && leadObj.City == userObj.City 
                    && leadObj.Interest__c.contains(userObj.Interest__c) )
                {          
                    System.debug('In Compare IF-- LeadOBJ'+leadObj.age__C+ ' ' + leadObj.City + ' ' + leadObj.postalcode);
                    if(userIDRecordCount.keySet().contains(UserObj.id) 
                        && userIDRecordCount.get(UserObj.id) < allLeadEqualToLead1)
                    {              
                        allLeadEqualToLead1  =  userIDRecordCount.get(UserObj.id);
                        leadObj.ownerID =  UserObj.id;
                        leadObj.assignment__c  = true;                                                       
                        matchFound = true;
                        
                    }
                }
            }
            if(!matchFound)
            {                        
                matchNotFoun.add(leadObj);
            }
        }
        
        leadList.clear();
        leadList.addAll(matchNotFoun);
        matchNotFoun.clear(); 
        i=-1;
         // Check If All lead deatils is matching with user .
        for(Lead leadObj : leadList)
        {   
            i++;
            matchFound = false;
            allLeadEqualToLead1 = 100000000;    
            System.debug('leadOBj--'+ leadOBj); 
            if(leadObj.Interest__c == null){
                leadObj.Interest__c = '';
            }
            for(User userObj: advUser)
            {    
                     
                 System.debug('before IF-- LeadOBJ'+leadOBj);
                if(leadObj.postalcode == userObj.postalcode) 
                {          
                   
                    if(userIDRecordCount.keySet().contains(UserObj.id) 
                        && userIDRecordCount.get(UserObj.id) < allLeadEqualToLead1)
                    {              
                        allLeadEqualToLead1  =  userIDRecordCount.get(UserObj.id);
                        leadObj.ownerID =  UserObj.id;   
                        leadObj.assignment__c  = true;                                                    
                        matchFound = true;
                        
                    }
                }
            }
            if(!matchFound)
            {                        
                matchNotFoun.add(leadObj);
            }
        }
        
        
        
        // Check Only age is equal and all other info are different 
        leadList.clear();
        leadList.addAll(matchNotFoun);
        matchNotFoun.clear(); 
    
        i=-1;
        for(Lead leadObj : leadList)
        {   
            i++;
            matchFound = false;
            allLeadEqualToLead1 = 100000000;    
            System.debug('leadOBj--'+ leadOBj); 
            if(leadObj.Interest__c == null){
                leadObj.Interest__c = '';
            }
            for(User userObj: advUser)
            {   
                     
                if(leadObj.City == userObj.City)
                {          
                    if(userIDRecordCount.keySet().contains(UserObj.id) 
                        && userIDRecordCount.get(UserObj.id) < allLeadEqualToLead1)
                    {              
                        allLeadEqualToLead1  =  userIDRecordCount.get(UserObj.id);
                        leadObj.ownerID =  UserObj.id;
                        leadObj.assignment__c  = true;                                                       
                        matchFound = true;
                        
                    }
                }
            }
            if(!matchFound)
            {                        
                matchNotFoun.add(leadObj);
            }
        }
        
        
        i=-1;
        leadList.clear();
        leadList.addAll(matchNotFoun);
        matchNotFoun.clear();   
        
        // Check All  info are different 
        for(Lead leadObj : leadList)
        {   
            i++;
            matchFound = false;
            allLeadEqualToLead1 = 100000000;    
            System.debug('leadOBj--'+ leadOBj); 
            if(leadObj.Interest__c == null){
                leadObj.Interest__c = '';
            }
            for(User userObj: advUser)
            {      
                if(userObj.Interest__c == null){
                userObj.Interest__c = '';
                }    
                if(leadObj.age__C != userObj.age__C && !leadObj.Interest__c.contains(userObj.Interest__c) && leadObj.City != userObj.City && leadObj.postalcode !=userObj.postalcode)
                {          
                    if(userIDRecordCount.keySet().contains(UserObj.id) && userIDRecordCount.get(UserObj.id) < allLeadEqualToLead1)
                    {              
                        allLeadEqualToLead1  =  userIDRecordCount.get(UserObj.id);
                        leadObj.ownerID =  UserObj.id; 
                        leadObj.assignment__c  = true;                                                    
                        matchFound = true;
                        
                    }
                }
            }
            if(!matchFound)
            {                        
                matchNotFoun.add(leadObj);
            }
        }
        
        leadList.clear();
        leadList.addAll(matchNotFoun);
        matchNotFoun.clear();   
        
        if(leadList != null && leadList.size() > 0){        
            // Default Assingment
            List<user> lstuser = [select id,userRole.Id from user where userRole.Name = 'Lead agent'];        
            if(lstuser != null && lstuser.size() >0){
                user ObjUser = lstuser[0];            
                for(Lead leadObj : leadList)
                {
                    leadObj.ownerID =  ObjUser.id; 
                    leadObj.assignment__c  = true;         
                }        
            }
        }
        for(lead l:trigger.new)
        { 
            System.debug('leadObj====' + l);        
        }
}