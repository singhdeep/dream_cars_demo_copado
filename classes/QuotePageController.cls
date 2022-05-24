public without sharing class QuotePageController
{
    Public String SelVal{get;set;}              // Add by Himanshu - 06/07/2015 //Used in page "Personal & Medical History"
    Public String SelVal1{get;set;}             // Add by Himanshu - 06/07/2015 //Used in page "Personal & Medical History"
    Public String SelVal2{get;set;}             // Add by Himanshu - 06/07/2015 //Used in page "Personal & Medical History"
    Public String AccId1{get;set;}                // Add by Himanshu - 06/07/2015 //Used in page "Personal & Medical History"
    Public Boolean showPopup{get;set;}
    Public Boolean showEmailPopup{get;set;}
    Public Boolean showSubmitPopup{get;set;}
    public string BPMValue{get;set;}
    Public string ApplicationStatus{get;set;}
    Public string Accountmiddlename{get;set;}
    Public string QuotePayment{get;set;}
    public Boolean addButtonFlag{get;set;}
    public Boolean nextButtonFlag{get;set;}
    public Boolean QuoteCalculated{get;set;}         // Add by Himanshu - 06/07/2015 //Used in page "Personal & Medical History"
    public Boolean premiumCalculated{get;set;}
    public Integer guageVar{get;set;}
    public Integer guageCount{get;set;}
    public String firstName{get;set;}
    public String riderString {get;set;}
    public Opportunity OppObj{get;set;}
    public Decimal initialPremiumAmt{get;set;}
    public Id policyId {get;set;}
    public String recommdRider {get;set;}
    //public account AcctObj;//{get;set;}
    public String AppplicationId{get;set;}
    public String AlipApplicationStatus{get;set;}
    Public Decimal planTerm{get;set;}
    public quote lquotes{get;set;}
    public User loggedUser{get;set;}
    public String selectedSumInsured{get;set;}
    public String selectedTerm{get;set;}
    public Boolean riderAccident{get;set;}
    public Boolean riderWaiver{get;set;}
    public Boolean riderCritical{get;set;}
    public Boolean checkAccident{get;set;}
    public Boolean checkWaiver{get;set;}
    public Boolean checkCritical{get;set;}
    public Decimal riderCount{get;set;}
     public List<String> riderList;
    //Added logic for radiobutton
    public String selectedValue { get; set; }
    public Account AcctObj{
        get{
            if(AcctObj == null){
                String strleadid= ApexPages.currentPage().getParameters().get('Id');    
                Lead templead = [select ConvertedAccountId,Id from Lead where Id=:strleadid];
                System.debug('templead.ConvertedAccountId===' + templead.ConvertedAccountId);           
                if(templead.ConvertedAccountId != null){
                    
                    AcctObj= [SELECT Id, LastName, FirstName,Middle_Name__c , Salutation, 
                              BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, 
                              Phone, PersonEmail, Birth_Date__c, Tax_ID__c, Height__c, Weight__c, 
                              isPersonAccount,Gender__c, US_Citizen__c 
                              FROM Account where Id =:templead.ConvertedAccountId];
                    //System.debug('templead.ConvertedAccountId.AcctObj===' + AcctObj );
                }  
            }  
            return AcctObj;    
        }set;
    }    
    
    public Account primaryBeneficiary{get
    {
        if(primaryBeneficiary==null){
            primaryBeneficiary=new Account();
            
            RecordType recType = [Select Id From RecordType  Where SobjectType = 'Account' and name = 'Person Account' and ispersontype=true];
            //primaryBeneficiary.recordTypeId=recType.id;
            //RecordType recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' limit 1];
            primaryBeneficiary.recordTypeId=recType.id;
            //List<Account> accObjs=[select id,Name from Account where id=:leadObj.convertedAccountId];
            primaryBeneficiary.Primary_Beneficiary__c='001j000000OH5jX';
            primaryBeneficiary.Primary_Beneficiary__c=leadObj.convertedAccountId;
            
            //primaryBeneficiary.Name='Primary Beneficiary-'+accObjs[0].name;
        }
        return primaryBeneficiary;
    }
                                      
    set;}
    
    public pagereference add(){
        
        //opportunity OppObj = new opportunity();
        
        //OppObj.Distribution__c= 'Distribution';
        //OppObj.Primary_Benefi__c= 'Primary_Beneficiary';
        //OppObj.Relationship__c= 'Relationship';
        
        
        primaryBeneficiary.LastName=firstName;
        //primaryBeneficiary.FirstName=firstName;
        addButtonFlag=true;
        nextButtonFlag=false;
        try{
            //primaryBeneficiary.LastName=firstName;
            if(primaryBeneficiary.distribution__c==null)
                primaryBeneficiary.distribution__c=100;
            
            
            upsert primaryBeneficiary; 
        }
        catch(Exception e)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
        }
        return null;
    }
    
    public Lead leadObj{get;set;}
    public Policy__c policyObj{get;set;}
    public Id accId{
        get{
            return leadObj.convertedAccountId;
        }
        set;}
    public Id oppId{get{return leadObj.convertedOpportunityId;}set;}
    public Id quoteId{get;set;}
    public Integer renderBlock{get;set;}
    // policyobj get and set
    public String selectedPaymentMode{get;set;}
    public String selectedSameAsOwner{get;set;}
    public String selectedJointOwner{get;set;}
    public String selectedUSCitizen{get;set;}
    
    public List<SelectOption> getSameAsApplicantValues(){
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('True','Yes')); 
        options.add(new SelectOption('False','No')); 
        return options;
    }
    public List<SelectOption> getJointOwnerValues(){
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('True','Yes')); 
        options.add(new SelectOption('False','No')); 
        return options;
    }
    
    public List<SelectOption> getSelectedUSCitizentValues(){
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('True','Yes')); 
        options.add(new SelectOption('False','No')); 
        return options;
    }
    
    public Decimal getIntialPremiumTerms(){
        
        system.debug('===QuotePageController=initialPremiumAmt =' + initialPremiumAmt );
        String strleadid= ApexPages.currentPage().getParameters().get('Id');  
        string userId = Userinfo.getuserid();
        system.debug('===Standard QuotePageController==');
        List<tempValueHolder__c > lstTempVal =[Select id,Name, Values__c From tempValueHolder__c where Name=:strleadid And CreatedDate = Today and OwnerId=:userId  Order by CreatedDate Desc Limit 1];
        system.debug('===QuotePageController=lstPolicy=' + lstTempVal );
        if(lstTempVal != null && lstTempVal.size() > 0){
            initialPremiumAmt  =lstTempVal.get(0).Values__c.setscale(2);
        }
        return initialPremiumAmt;
        
        //system.debug('===QuotePageController=initialPremiumAmt =' + initialPremiumAmt );
        
    }
    public String strPolicyid;
    
    public QuotePageController()
    {
        
        System.debug('entered in custome controller');          
        system.debug('===QuotePageController=initialPremiumAmt =' + initialPremiumAmt );
        String strleadid= ApexPages.currentPage().getParameters().get('Id');  
        strPolicyid= ApexPages.currentPage().getParameters().get('pid'); 
        system.debug('---strPolicyid--'+strPolicyid); 
        string userId = Userinfo.getuserid();
        system.debug('===Standard QuotePageController==');
        List<tempValueHolder__c > lstTempVal =[Select id,Name, Values__c From tempValueHolder__c where Name=:strleadid And CreatedDate = Today and OwnerId=:userId  Order by CreatedDate Desc Limit 1];
        system.debug('===QuotePageController=lstPolicy=' + lstTempVal );
        if(lstTempVal != null && lstTempVal.size() > 0){
            initialPremiumAmt  =lstTempVal.get(0).Values__c;
        }
        system.debug('===QuotePageController=lstPolicy=' + lstTempVal );
        QuoteCalculated = false;
        
    }
    public QuotePageController(ApexPages.StandardController controller) 
    {
        
        System.debug('entered in standard controller');          
        
        leadObj=(Lead)controller.getRecord();
        guageCount = 0;  
        waitingMessage=false;
        showPopup = false;
        showSubmitPopup = false;
        showEmailPopup = false;
        
        premiumCalculated = false;
        
        riderAccident = false;
        riderWaiver = false;
        riderCritical = false;
        riderList = new List<String>();
        
        loggedUser = [SELECT AccountId,firstname,lastname From User WHERE username=:UserInfo.getUsername()];
        String leadId =leadObj.id;
        List<lead> leadObjs=[Select id,Name, country,postalCode,Tax_ID__c,Height__c,Interest__c ,Preferred_contact_time__c,Middle_Name__c,state,street,Weight__c,Term_Length__c,OwnerId,Age__c,Rider__c,Facebook_Profile_URL__c ,intial_premium__c,
                             coverage__c,City,status,City__c,Mailing_Address__c,AnnualRevenue,Occupation__c,
                             Product_Interest__c,Other__c,Phone,Marital_Status__c,Email,D_O_B__C,Children__c,Facebook_ID__c,
                             ProspectProfilePictureDocId__c,Social_Security_Number__c,Gender__c,Salutation,FirstName,
                             LastName,convertedAccountId,convertedOpportunityId,Tobacco_nicotine_use__c,Reference_Number__c 
                             From Lead where id =:leadId];
        leadObj=leadObjs.get(0);
        
        //premiumAmount='0';
        premiumAmount=leadObj.intial_premium__c;
        System.debug('leadObj.ConvertedAccountId====' + leadObj.ConvertedAccountId);
        if(leadObj.ConvertedAccountId != null)
            AcctObj = [SELECT Id, LastName, FirstName,Middle_Name__c , Salutation, 
                       BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, 
                       Phone, PersonEmail, Birth_Date__c, Tax_ID__c, Height__c, Weight__c, 
                       isPersonAccount,Gender__c, US_Citizen__c 
                       FROM Account where Id =:leadObj.ConvertedAccountId];
        
        System.debug('leadObj.ConvertedAccountId.AcctObj ====' + AcctObj ); 
        string userId = Userinfo.getuserid();
        system.debug('===Standard QuotePageController==');
        List<tempValueHolder__c > lstTempVal =[Select id,Name, Values__c From tempValueHolder__c where Name=:leadId And CreatedDate = Today and OwnerId=:userId  Order by CreatedDate Desc Limit 1];
        system.debug('===QuotePageController=lstPolicy=' + lstTempVal );
        if(lstTempVal != null && lstTempVal.size() > 0){
            initialPremiumAmt  =lstTempVal.get(0).Values__c;
        }
        
        system.debug('===QuotePageController=initialPremiumAmt =' + initialPremiumAmt );
        
        /***** Rider code*******/
        
        Set<String>  recommdRiderSet = new Set<String>();   
        Map<String,FB_Categories__c> fbIntrestSetting = FB_Categories__c.getAll();
        List<String> catlst = new List<String>();
        
        if(leadObj.Interest__c!=null)
        {
            catlst =   leadObj.Interest__c.split(',');   
        }     
        for(String str : catlst )
        {
            if(fbIntrestSetting.keySet().contains(str))
            {
                FB_Categories__c fbCat =  fbIntrestSetting.get(str);                 
                recommdRiderSet.add(fbCat.Recommended_Rider_1__c);
                recommdRiderSet.add(fbCat.Recommended_Rider_2__c);
            }     
        } 
        
        recommdRider  = recommdRiderSet+'';
        
        if(recommdRider.contains('Accidental Death Benefit')){
        riderAccident = true;
        }
        
        if(recommdRider.contains('Critical Injury Rider')){
        riderCritical = true;
        }
        
        if(recommdRider.contains('Waiver of Premium Rider')){
        riderWaiver = true;
        }
        
       
        
        
        /***** Rider code*******/
        
        if(leadObj.rider__c) selectedRider ='Critical Illness';else selectedRider ='None';        
        //selectedRider='None';
        selectedPaymentTerm='Monthly';
        selectedTerm=String.valueOf(leadObj.Term_Length__c);
        //selectedSumInsured=String.valueOf(leadObj.coverage__c);
        selectedSumInsured=leadObj.coverage__c;
        if(leadObj.Tobacco_nicotine_use__c) tobaccoUser='Yes'; else tobaccoUser='No';
        selectedSameAsOwner='True';
        selectedJointOwner='False';
        //selectedProduct='01tj0000001eGaYAAU';
        selectedProduct='Term';
        selectedTaxQulificationStatus='None';
        
        
        
        
        /********Guage Logic by Shilpa on 16/4/2015************************************/
        
        
        User ownerRecord =[select id,age__C,marital_Status__c,city,postalcode,interest__c from user where id =:leadObj.ownerid];
        
        /*if(ownerRecord .Interest__c == null){
ownerRecord.Interest__c = '';
}

if(leadObj.Interest__c == null){
leadObj.Interest__c = '';
}*/
        
        if(ownerRecord.age__c == leadObj.age__c){
            guageCount = guageCount + 1;
        }
        if(leadObj.Interest__c != null && ownerRecord.Interest__c !=null && leadObj.Interest__c.contains(ownerRecord.Interest__c)){
            guageCount = guageCount + 1;
        }    
        if(ownerRecord.city == leadObj.city){
            guageCount = guageCount + 1;
        }
        if(ownerRecord.postalcode == leadObj.postalcode){
            guageCount = guageCount + 1;
        }
        if(ownerRecord.marital_Status__c== leadObj.marital_Status__c){
            guageCount = guageCount + 1;
        }
        
        
        guageVar = guageCount * 20;
        
        
        /********End of Guage Logic by Shilpa on 16/4/2015************************************/   
        
        /*String strPid= ApexPages.currentPage().getParameters().get('pid'); 
System.debug('strPid===' + strPid);
if(String.IsNotBlank(strPid)){
policyObj = [SELECT Id, Name, Account_Name__c, Initial_Premium_Payment__c, Mode_Of_Payment__c, Tax_Qualification_Status__c, 
__c, Status__c FROM Policy__c where Id =: strPid limit 1];
}*/
        
        if(leadObj.convertedAccountId != null){
            List<Policy__c> policyObj = [SELECT Id, Name, Account_Name__c, Initial_Premium_Payment__c, Mode_Of_Payment__c, Tax_Qualification_Status__c, SendEmail__c, Status__c FROM Policy__c where Account_Name__c =: leadObj.convertedAccountId];
            // system.debug('---->policyObj. Status__c'+policyObj[0].Status__c);
            //ApplicationStatus = policyObj[0].Status__c;
            if(policyObj.size()>0){
                BPMValue = policyObj[0].Mode_Of_Payment__c;
                
            }
        }
        
        
    }
    
    public String premiumAmount{get;set;}
    
    
    public String leadAddress{get{
        //return String.valueOf(leadObj.Address);
        String addr='';
        addr=leadObj.city==null?'':leadObj.city;
        addr=addr+(leadObj.country==null?'':leadObj.country);
        //addr=addr+(leadObj.countryCode==null?'':leadObj.getCountryCode);
        addr=addr+(leadObj.postalCode==null?'':leadObj.postalCode);
        addr=addr+(leadObj.state==null?'':leadObj.state);
        //addr=addr+(leadObj.stateCode==null?'':leadObj.stateCode);
        addr=addr+(leadObj.street==null?'':leadObj.street);
        //system.Address[getCity=null;getCountry=null;getCountryCode=null;getPostalCode=null;getState=NJ;getStateCode=null;getStreet=null;]
        return addr;
    }set;
                             }
    
    
    // Tobacco User Picklist
    public String selectedProduct{get;set;}
    
    public List<SelectOption> getProductPicklist(){
        
        List<SelectOption> options = new List<SelectOption>();
        List<Product2> prodObjs=[SELECT id,ProductCode,Description,Name from Product2];
        for (Integer j=0;j<prodObjs.size();j++)
        {
            options.add(new SelectOption(prodObjs[j].Name,prodObjs[j].Name));
        }
        return options;
    }
    
    
    // Product Picklist
    //ProductCode,Description,Name,Payment_Term__c,Rider__c,Term__c,Sum_Insured__c,Tobacco_User__c
    public String selectedPaymentTerm{get;set;}
    List<SelectOption> paymentTermPicklist = new List<SelectOption>();
    public List<SelectOption> getPaymentTermPicklist(){
        if(paymentTermPicklist.size()==0){
            Schema.DescribeFieldResult paymentTermPicklistSchema= Product2.Payment_Term__c.getDescribe();
            for (Schema.Picklistentry picklistEntry : paymentTermPicklistSchema.getPicklistValues())
            {
                paymentTermPicklist.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
            }
        }
        return paymentTermPicklist;
    }
    
    
    // Riders Picklist
    //ProductCode,Description,Name,Payment_Term__c,Rider__c,Term__c,Sum_Insured__c,Tobacco_User__c
    public String selectedRider{get;set;}
    List<SelectOption> riderPicklist = new List<SelectOption>();
    public List<SelectOption> getRiderPicklist(){
        if(riderPicklist.size()==0){
            Schema.DescribeFieldResult riderPicklistSchema= Product2.Rider__c.getDescribe();
            for (Schema.Picklistentry picklistEntry : riderPicklistSchema.getPicklistValues())
            {
                riderPicklist.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
            }
        }
        return riderPicklist;
    }
    
    
    // Term Picklist
    //ProductCode,Description,Name,Payment_Term__c,Rider__c,Term__c,Sum_Insured__c,Tobacco_User__c
    
    
    
    public List<SelectOption> gettermPicklist(){
        
        List<SelectOption> termPicklist = new List<SelectOption>();
        
        if(termPicklist.size()==0){
            Schema.DescribeFieldResult termPicklistSchema= Product2.Term__c.getDescribe();
            for (Schema.Picklistentry picklistEntry : termPicklistSchema.getPicklistValues())
            {
                termPicklist.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
            }
        }
        return termPicklist;
    }
    
    
    
    // Sum Insured Picklist
    //ProductCode,Description,Name,Payment_Term__c,Rider__c,Term__c,Sum_Insured__c,Tobacco_User__c
    
    
    /*
List<SelectOption> sumInsuredPicklist = new List<SelectOption>();
public List<SelectOption> getSumInsuredPicklist(){
if(sumInsuredPicklist.size()==0){
Schema.DescribeFieldResult sumInsuredPicklistSchema= Product2.Sum_Insured__c.getDescribe();
for (Schema.Picklistentry picklistEntry : sumInsuredPicklistSchema.getPicklistValues())
{
sumInsuredPicklist.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
}
}
return sumInsuredPicklist;
}
*/
    // Tobacco User Picklist
    public String tobaccoUser{get;set;}
    List<SelectOption> tobaccoUserPicklist = new List<SelectOption>();
    public List<SelectOption> getTobaccoUserPicklist(){
        if(tobaccoUserPicklist.size()==0){
            Schema.DescribeFieldResult tobaccoUserPicklistSchema= Product2.Tobacco_User__c.getDescribe();
            for (Schema.Picklistentry picklistEntry : tobaccoUserPicklistSchema.getPicklistValues())
            {
                tobaccoUserPicklist.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
            }
        }
        return tobaccoUserPicklist;
    }
    Quote quoteObj=null;
    /*
public void calculatePremiumAmount(){
renderBlock=2;
//premiumAmount='$ 17.89';

String defaultRider='None';
String defaultPaymentMode='Monthly';
String defaultTobaccoUser='No';
String defaultAge='20';
selectedPaymentMode=defaultPaymentMode;
selectedRider=defaultRider;
tobaccoUser=defaultTobaccoUser;

system.debug('getQuote(\'My Insurance\''+','+selectedSumInsured+','+leadObj.Gender__c+','+selectedTerm+','+selectedPaymentTerm+','+selectedRider+','+tobaccoUser+','+(leadObj.D_O_B__c==null?Date.newInstance(1990,3,20):leadObj.D_O_B__c)+')');
premiumAmount = getQuote('My Insurance',selectedSumInsured,leadObj.Gender__c,selectedTerm,selectedPaymentTerm,selectedRider,tobaccoUser,leadObj.D_O_B__c==null?Date.newInstance(1990,3,20):leadObj.D_O_B__c);
}
*/
    public Decimal quoteAmt{get;set;}
    
    public String selectedModeOfPayment{get;set;}
    
    List<SelectOption> modeOfPaymentPicklist = new List<SelectOption>();
    public List<SelectOption> getModeOfPaymentPicklist(){
        
        if(modeOfPaymentPicklist.size()==0){
            Schema.DescribeFieldResult modeOfPaymentPicklistSchema= Policy__c.Mode_Of_Payment__c.getDescribe();
            for (Schema.Picklistentry picklistEntry : modeOfPaymentPicklistSchema.getPicklistValues())
            {
                modeOfPaymentPicklist.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
            }
        }
        return modeOfPaymentPicklist;
        
    }
    
    
    
    public String selectedTaxQulificationStatus{get;set;}
    List<SelectOption> taxQulificationStatusPicklist = new List<SelectOption>();
    
    public List<SelectOption> getTaxQulificationStatusPicklist(){
        
        if(taxQulificationStatusPicklist .size()==0){
            Schema.DescribeFieldResult taxQulificationStatusPicklistSchema= Policy__c.Tax_Qualification_Status__c.getDescribe();
            for (Schema.Picklistentry picklistEntry : taxQulificationStatusPicklistSchema.getPicklistValues())
            {
                taxQulificationStatusPicklist .add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
            }
        }
        return taxQulificationStatusPicklist ;
    }
    
    
    //Decimal quoteAmt=0.0;
    
    
    //Prospect Details(block1)
    public boolean waitingMessage{get;set;}
    public PageReference previousBlock1(){return new PageReference('https://na16.salesforce.com/00Q?fcf=00Bj0000001EYtb');}
    public void saveBlock1(){update leadObj;} //saveLead   convertLeadToAccAndOpp
    public PageReference cancelBlock1(){return new PageReference('https://na16.salesforce.com/00Q?fcf=00Bj0000001EYtb');}
    public void nextBlock1(){ 
        
    }
    
    public PageReference convertLeadToAccAndOpp(){
        try{
            if(leadObj.convertedAccountId !=null)
            {
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,''+'Lead is already converted, Please choose a new lead.'));
                return null;
            }
            else
            {
                leadObj.Company='';
                RecordType recType=[Select Id From RecordType  Where SobjectType = 'Lead' and name = 'Default Record Type'];
                leadObj.recordTypeId=recType.id;
                update leadObj;
                Database.LeadConvert lc = new Database.LeadConvert();
                
                lc.setLeadId(leadObj.id);
                lc.setOwnerId(leadObj.OwnerId);
                lc.setDoNotCreateOpportunity(false);
                lc.setOpportunityName(leadObj.Name);
                LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
                lc.setConvertedStatus(convertStatus.MasterLabel);
                
                Database.LeadConvertResult lcr = Database.convertLead(lc);
                List<lead> leadObjs=[Select id,Name,country,postalCode,state, street, Tax_ID__c, OwnerId, Height__c, Interest__c, Middle_Name__c, Weight__c, Term_Length__c,coverage__c,City,City__c,Mailing_Address__c,AnnualRevenue,Occupation__c,Product_Interest__c,Other__c,Phone,Marital_Status__c,Email,D_O_B__C,Children__c,Facebook_ID__c,ProspectProfilePictureDocId__c,Social_Security_Number__c,Gender__c,Salutation,FirstName,LastName,convertedAccountId,convertedOpportunityId,Tobacco_nicotine_use__c,Reference_Number__c,Age__c  From Lead where id =:leadObj.id];
                leadObj=leadObjs.get(0);
                //accId=leadObj.convertedAccountId;
                //oppId=leadObj.convertedOpportunityId;
                
                system.debug('leadObj.convertedOpportunityId================>:'+leadObj.convertedOpportunityId);
                List<Opportunity> oppObjs=[select id,Name,Distribution__c,Primary_Benefi__c,Relationship__c from Opportunity where id=:leadObj.convertedOpportunityId];
                oppObj=oppObjs[0];
                return new PageReference('/apex/Quick_Quoteui?id='+leadObj.id);
            }
            
        }
        catch(Exception e)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
        }
        return null;
    }
    
    
    //block2
    public void calculateAndCreateQuote(){
        QuoteCalculated = True;  
        showPopup = true;    
        String defaultRider='None';
        String defaultPaymentTerm='Monthly';
        String defaultTobaccoUser='No';
        String defaultAge='20';
        riderString= '';
        
        
        try{
            
            /*
String s=null;
String n=s.subString(0,1);
*/
            system.debug('selectedTerm====' + selectedTerm);
            system.debug('selectedSumInsured====' + selectedSumInsured);
            
            selectedPaymentTerm=defaultPaymentTerm==null?defaultPaymentTerm:selectedPaymentTerm;
            selectedRider=selectedRider==null?defaultRider:selectedRider;
            
            tobaccoUser=tobaccoUser==null?defaultTobaccoUser:tobaccoUser;
            if(leadObj.convertedAccountId ==null)
            {
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,''+'Session timed out'));
                
            }
            else
            {
                system.debug('getQuote(\'My Insurance\''+','+selectedSumInsured+','+leadObj.Gender__c+','+selectedTerm+','+selectedPaymentTerm+','+selectedRider+','+tobaccoUser+','+(leadObj.D_O_B__c==null?Date.newInstance(1990,3,20):leadObj.D_O_B__c)+')');
                
                premiumAmount = createQuote('My Insurance',selectedSumInsured,leadObj.Gender__c,selectedTerm,selectedPaymentTerm,selectedRider,tobaccoUser,leadObj.D_O_B__c==null?Date.newInstance(1990,3,20):leadObj.D_O_B__c);
            }
            
        }
        catch(Exception e)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
            premiumAmount='0.0';
        }
        
        
    }
    public void errorMessage(){
    }
    public String createQuote(String organizationName,String selectedSumInsured,String gender,String term,String paymentMode,String rider,String isTobaccoUser,Date userDateOfBirth){
        
        Integer userAge=Integer.valueOf(math.FLOOR(userDateOfBirth.daysBetween(system.today())/365.2425));
        if(paymentMode==null)
            paymentMode='Monthly';
        /*if(rider==null)
rider='None';
System.debug('Passing parameters to first query'+organizationName+'---gender---'+gender+'---------------------------age---'+userAge);
List<Gender_Multiplier__c>  genderMultiplier= [Select Id, Gender__c, Age__c, Multiplier__c  FROM Gender_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName and Gender__c=:gender and Age__c=:userAge];
List<Term_Multiplier__c>   termMultiplier= [Select Term__c, Multiplier__c FROM Term_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Term__c=:term]; 
List<Payment_Mode_Multiplier__c>  paymentModeMultiplier= [Select Payment_Mode__c, Multiplier__c FROM Payment_Mode_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Payment_Mode__c=:paymentMode];
List<Rider_Muliplier__c>   riderMultiplier= [Select Rider__c, Multiplier__c FROM Rider_Muliplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Rider__c=:rider];
List<Tobacco_Multiplier__c>   tobaccoMultiplier= [Select Tobacco_User__c, Multiplier__c FROM Tobacco_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Tobacco_User__c=:isTobaccoUser];

if(genderMultiplier.size()>0 && termMultiplier.size()>0 && paymentModeMultiplier.size()>0 && riderMultiplier.size()>0 && tobaccoMultiplier.size()>0){
//Quote = Rate * Coverage* Term Factor * Payment Mode Factor * Tobacco User factor * Rider factor
quoteAmt=noOfThousands*genderMultiplier.get(0).Multiplier__c*termMultiplier.get(0).Multiplier__c*paymentModeMultiplier.get(0).Multiplier__c*riderMultiplier.get(0).Multiplier__c*tobaccoMultiplier.get(0).Multiplier__c;
String decValue=String.valueOf(quoteAmt);
decValue=decValue.subString(0,decValue.indexOf('.')+3);
quoteAmt=Decimal.valueOf(decValue);
}
else{
quoteAmt=10;
}*/
        
        decimal PaymentModevalue = 1;
        decimal Ridervalue = 1;    
        quoteAmt= calculateQuoteAmount.calculateQuote(userAge,selectedSumInsured,gender,integer.Valueof(term),isTobaccoUser);
        
        if(paymentMode.equalsignorecase('Monthly')){
            PaymentModevalue = 1;
        }else if(paymentMode.equalsignorecase('Semi Annual')){
            PaymentModevalue = 5.88;
        }else if(paymentMode.equalsignorecase('Quarterly')){
            PaymentModevalue = 2.97;
        }else if(paymentMode.equalsignorecase('Annual')){
            PaymentModevalue = 11.63;
        }
        
        /*if(String.IsNotBlank(rider) && rider!='None'){
            Ridervalue = 1.2;
        }*/
        
        riderCount = 1;
        
        riderList.clear();
        
         if(checkAccident == true){
        riderCount = riderCount * 1.1;
        riderList.add('Accidental Disability');
        }
        
        if(checkWaiver == true){
        riderCount = riderCount * 1.1;
        riderList.add('Waiver of Premium');
        }
        
        if(checkCritical == true){
        riderCount = riderCount * 1.1;
        riderList.add('Critical illness');
        }
       // String riderString= '';
        Boolean Start = true;
        if(!riderList.isEmpty()) {           
            for(String Str : riderList) {
                if(Start) {
                    riderString= Str;
                    Start = false;
                } else {               
                    riderString= riderString+ ';' + Str;
                }
            }
        }
        else{
        riderString = 'None';
        }
        
        System.debug('-------------------riderString---'+riderString);
        
        Ridervalue = riderCount;
        
        quoteAmt = quoteAmt * PaymentModevalue * Ridervalue;
        
        
        
        /* Code to restrict the creation of duplicate quotes in the system. */
        
        // Integer sI=Integer.valueOf(selectedSumInsured);
        Boolean tobaccoTOrF=(tobaccoUser=='Yes'?true:false);
        Integer tL=Integer.valueOf(term);
        List<Quote> isSameQuoteAlreadyCreated=[select id,name,Premium__c from quote where OpportunityId=:leadObj.convertedOpportunityId and 
                                               Payment_Term__c=:paymentMode and 
                                               Product__c=:selectedProduct and Rider__c=:rider and Sum_Insured__c=:selectedSumInsured and Term_Length__c=:tL and Tobacco_Nicotine__c=:tobaccoTOrF and Sum_Insured_Amount__c=:quoteAmt];
        String Quote='';
        if(isSameQuoteAlreadyCreated.size() ==0)
        {
            Quote=String.valueOf(quoteAmt);
            //String Quote=String.valueOf(noOfThousands*genderMultiplier.get(0).Multiplier__c*termMultiplier.get(0).Multiplier__c);
            quoteObj= new Quote();
            //Payment_Term__c,Premium__c,Sum_Insured__c,Account,Opportunity,Bill_To_Name__c,Bill_To__c,
            
            //List<Account> accObjs=[select id,Name from Account where id=:leadObj.convertedAccountId];
            //system.debug('Converted accid'+leadObj.convertedAccountId+'---------------------Conveted oppId-------------------'+leadObj.convertedOpportunityId);
            
            List<Opportunity> oppObjs=[select id,Name from Opportunity where id=:leadObj.convertedOpportunityId];
            //quoteObj.Account=accObjs[0];
            //quoteObj.accountId=leadObj.convertedAccountId;
            quoteObj.OpportunityId=leadObj.convertedOpportunityId;
            quoteObj.name='Quote-'+oppObjs[0].name;
            quoteObj.Payment_Term__c=paymentMode;
            quoteObj.Premium__c=quoteAmt;
            quoteObj.Product__c=selectedProduct;
            quoteObj.Rider__c=rider;
            quoteObj.Sum_Insured__c=selectedSumInsured;
            quoteObj.Term_Length__c=Integer.valueOf(term);
            quoteObj.Tobacco_Nicotine__c=(tobaccoUser=='Yes'?true:false);
            quoteObj.Recommended_Rider__c = riderString;
            //quoteObj.Bill_To_Name=;
            //quoteObj.QuoteToAddress=leadObj.Address;
            insert quoteObj;
            quoteId=quoteObj.id;
            System.debug('-------------------quoteObj.id---'+quoteObj.id);
        }
        else
        {
            quoteId = isSameQuoteAlreadyCreated.get(0).id;
            Quote=String.valueOf(quoteAmt);
            System.debug('-------------------isSameQuoteAlreadyCreated.get(0).id---'+isSameQuoteAlreadyCreated.get(0).id);
        }
        return ''+Quote.subString(0,Quote.indexOf('.')+3);
        // return new PageReference('/apex/QuoteHistory?id='+leadObj.id');
        
    }
    
    // Next Function On the Quick Quote page
    
    Public PageReference QuickQuoteNext(){
        return new PageReference('/apex/QuoteHistoryui?id='+leadObj.id+'&pid='+policyId);
    } 
    // Function end 
    
    public id currentQuoteSelection{get;set;}

    
    Public PageReference QuoteHistoryPrevious(){
        return new PageReference('/apex/Quick_Quoteui?id='+leadObj.id+'&pid='+policyId);
    }
    
    public PageReference convertQuoteToPolicy(){
        //List<Account> accObjs=[select id,Name from Account where id=:leadObj.convertedAccountId];
        //renderBlock=2;
        try
        {
            
            system.debug('selectedValue======'+selectedValue);
            if(selectedValue!=NULL && selectedValue!='')
            {
                
               
                selectedQuoteToApply=selectedValue;
                    
            
                if(leadObj.convertedAccountId ==null)
                {
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,''+'Session Timed Out.'));
                    return null;
                }
                else{
                    
                    system.debug('selectedQuoteToApply in else condition=======>:'+selectedQuoteToApply);
                    List<Quote> isSameQuoteAlreadyCreated=[select id,name,Premium__c from quote where id=:selectedQuoteToApply];
                    policyObj=new Policy__c();
                    system.debug('leadObj.convertedAccountId==>:'+leadObj.convertedAccountId);
                    
                    policyObj.Account_Name__c=leadObj.convertedAccountId;
                    policyObj.Initial_Premium_Payment__c=isSameQuoteAlreadyCreated.get(0).Premium__c;
                    system.debug('isSameQuoteAlreadyCreated.get(0).Premium__c in else condition=======>:'+isSameQuoteAlreadyCreated.get(0).Premium__c);
                    policyObj.Mode_Of_Payment__c=selectedModeOfPayment;
                    system.debug('selectedModeOfPayment in else condition=======>:'+selectedModeOfPayment);
                    policyObj.Policy_End_Date__c=Date.today().addYears(Integer.valueOf(selectedTerm));
                    system.debug('selectedTerm in else condition=======>:'+selectedTerm);
                    policyObj.Policy_Start_Date__c=Date.today();
                    List<Product2> prodObjs=[SELECT id,ProductCode,Description,Name from Product2 where name=:selectedProduct];
                    policyObj.Product__c=prodObjs[0].id;
                    system.debug('prodObjs[0].id in else condition=======>:'+prodObjs[0].id);
                    policyObj.Quote_Name__c=selectedQuoteToApply;
                    
                    //policyObj.Tax_Qualification_Status__c=selectedTaxQulificationStatus;
                    insert policyObj;
                    system.debug(policyObj.id+  'Success');
                    //leadObj.tempPolicyAmount__c = policyObj.Initial_Premium_Payment__c;
                    //System.debug('policyObj==while convert==' + policyObj);
                    //update leadObj;
                    //System.debug('leadObj=while convert===' + leadObj);
                    
                    tempValueHolder__c objtemp = new tempValueHolder__c();
                    objtemp.Name = leadObj.id;
                    objtemp.Values__c = policyObj.Initial_Premium_Payment__c;
                    insert objtemp;
                    return new PageReference('/apex/Applicant_Informationui?id='+leadObj.id + '&pid=' + policyObj.Id);
                }
            }
            else {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select one quote')); 
            }
            return null;
            
        }
        catch(Exception e)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
        }
        return new PageReference('/apex/Applicant_Information?id='+leadObj.id);
    }
    public PageReference cancelQuickQuote(){return new PageReference('/apex/Prospect_Details?id='+leadObj.id);}
    
    
    
    /* Method for sending the email with the PDF attached by himanshu on 7/10/2015
@method Name emailQuote

*/
    public void emailQuote(){                 // refering to the PDF page for Email
        
        showEmailPopup = true;
        lquotes = New Quote();
        
        lquotes = [Select id ,Account.PersonEmail ,Account.Name ,Account.Owner.Name ,Account.Owner.Phone ,Opportunity.Name, Payment_Term__c,Premium__c, Product__c, Rider__c, Sum_Insured__c, Term_Length__c, Tobacco_Nicotine__c from Quote where OpportunityId = :leadObj.convertedOpportunityId Order by QuoteNumber desc limit 1] ;
        String email = lquotes.Account.PersonEmail;
        
        /***************************** Creating PDF****************************/
        
        //PageReference PagePDF = new PageReference('/apex/QuotePDF?id='+leadObj.id +'&pid=' + policyId);  
        PageReference pdf = Page.QuotePDF;  
        // add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id',leadObj.convertedOpportunityId);
        //return new PageReference('/apex/QuotePDF?id='+leadObj.id +'&pid=' + policyId);
        // the contents of the attachment from the pdf
        Blob body;
        
        try {
            
            // returns the output of the page as a PDF
            body = pdf.getContent();
            
            // need to pass unit test -- current bug  
        } catch (VisualforceException e) {
            body = Blob.valueOf('normal Text');
        }
 /***************************** Creating Attachment****************************/
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('QuotePDF.pdf');
        //attach.setInline(false);
        attach.Body = body;
 /***************************** Creating Email********************************/
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
 //mail.setUseSignature(false);
        mail.setToAddresses(new String[] { email });
        mail.setSaveAsActivity(true);
        mail.setSubject('Subject: Your Quote from MyInsurance');
       // String ProspectName = lquotes.Account.Name;
        date dt = date.today()+15;
        string dtes = dt.format();
        String messageBody1 = '<html><body>Hello '+ lquotes.Account.Name+ ',<br/><br/>Greetings !<br/><br/>Attached is your quote details for your perusal.<br/><br/>For any queries or concerns, please feel free to reach out to me.<br/><br/>Your quote would be valid till  '+ dtes  +' . <br/><br/>Warm Regards,<br/>'+lquotes.Account.Owner.Name +'<br/>'+lquotes.Account.Owner.Phone +'</body>  </html>';
        mail.setHtmlBody(messageBody1);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
        //mail.setSaveAsActivity(true);
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        System.debug('>>>>>>>>>>>>>>>>>>>>>'+mail);
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+email));
 /*****************************Creating a related list ********************************/
 /*  EmailMessage emailMsg = new EmailMessage(); // Created a EmailMessage and copy all details from above.
            emailMsg.ToAddress = (mail[0].getToAddresses())[0];
            emailMsg.Subject = mail[0].getSubject();
            emailMsg.HtmlBody = mail[0].getHtmlBody();
            emailMsg.MessageDate = system.now();
            emailMsg.Status = '0';
            insert emailMsg;*/
            //return null;
        
        
        
        //return new PageReference('/apex/QuotePDF?id='+leadObj.id +'&pid=' + policyId ); 
        
        
    }      
    
    
    
    //block3
    //Applicant information
    public PageReference previousApplicantInfo(){return new PageReference('/apex/QuoteHistoryui?id='+leadObj.id);}
    
    
    
    
    
    public void saveApplicantInfo(){
        System.debug('saveApplicantInfo.AcctObj======' + AcctObj);
        update  AcctObj;
    }          
    
    
    public PageReference cancelApplicantInfo(){return new PageReference('/apex/Quick_Quote?id='+leadObj.id);}
    public PageReference nextApplicantInfo(){
        addButtonFlag=true;
        nextButtonFlag=true;
        if(String.IsNotBlank(AcctObj.BillingPostalCode)){
            String strResponse = getLocationDetails.getLocation(AcctObj.BillingPostalCode);
            if(String.IsNotBlank(strResponse)){
                AcctObj.billingcity= strResponse.split(',')[0];
                AcctObj.billingState= strResponse.split(',')[1];
                AcctObj.billingCountry = 'USA';
            }
        }
    
        update AcctObj;
        return new PageReference('/apex/PersonalMedicalHistoryui?id='+leadObj.id +'&pid=' + policyId );  // Himanshu
        //return new PageReference('/apex/Payment_Information?id='+leadObj.id +'&pid=' + policyId);
        
    }
    
    
    //block4
    //Payment information
    public PageReference previousPaymentInfo(){return new PageReference('/apex/PersonalMedicalHistoryui?id='+leadObj.id+'&pid='+policyObj.Id);}
    public void savePaymentInfo(){
        policyObj.Mode_Of_Payment__c=selectedModeOfPayment;
        policyObj.Tax_Qualification_Status__c=selectedTaxQulificationStatus;
        update policyObj;
    }
    public PageReference cancelPaymentInfo(){return new PageReference('/apex/Applicant_Information?id='+leadObj.id);}
    
    public PageReference nextPaymentInfo(){
        policyObj.Initial_Premium_Payment__c=initialPremiumAmt;//quoteamt;
        policyObj.Mode_Of_Payment__c=selectedModeOfPayment;
        policyObj.Tax_Qualification_Status__c=selectedTaxQulificationStatus;
        update policyObj;
        //return new PageReference('/apex/Electronic_Signature_Consent?id='+leadObj.id);
        return new PageReference('/apex/VFP_Application_Summaryui?id='+leadObj.id +'&pid=' + policyObj.Id ); //Added by Komal
    }   
    
    //Electronic Signature Consent
    //block5
    /*public PageReference agree(){
policyObj.SendEmail__c = true;
update policyObj;
return new PageReference('/apex/Next_Steps?id='+leadObj.id);
}*/
    public PageReference agree(){
        
        System.debug('policyObj.Id==' + policyObj.Id); 
        sendToAlip(policyObj.Id);
        QuotePageController.sendEmail(leadObj.id,policyObj.Id,leadObj.convertedOpportunityId);
        System.debug('leadObj.convertedOpportunityId==' +leadObj.convertedOpportunityId);
        System.debug('leadObj.id==' +leadObj.id);
        // System.debug('policyObj.Id==' + policyObj.Id);        
        //return new PageReference('/apex/Next_Stepsui?id='+leadObj.id+'&pid='+policyObj.Id );
        //return new PageReference('/apex/Next_Steps?id='+leadObj.id);  
        showSubmitPopup = true; 
        return null;        
    }
    // @future
    public static void sendEmail(string leadId, string policyId, string opptyId){
        System.debug('leadId==' + leadId);
        System.debug('policyId==' + policyId);
        System.debug('opptyId==' + opptyId);        
        Policy__c policyObj = [Select Id,SendEmail__c, Alip_Application_Id__c  From Policy__c Where Id=:policyId];
        
        Quote lquotes = [Select id,Account.PersonEmail, Account.Name, Opportunity.Name, Payment_Term__c,Premium__c, Product__c, Rider__c, Sum_Insured__c, Term_Length__c,
                         Tobacco_Nicotine__c from Quote where OpportunityId = :opptyId Order by QuoteNumber desc limit 1] ;
        String email = lquotes.Account.PersonEmail;
        
        PageReference pdf = Page.LI_App1;  
        //pdf.getParameters().put('id',leadObj.id);
        //pdf.getParameters().put('pid',policyObj.Id);
        // PageReference pdf = new PageReference('/apex/LI_App1');
        pdf.getParameters().put('id',leadId);
        pdf.getParameters().put('pid',policyId);
        
        Blob body;
        
        try {
            system.debug('---odf---'+pdf);
            
            // returns the output of the page as a PDF
            body = pdf.getContent();
            system.debug('---odf1---'+pdf);
            
            // need to pass unit test -- current bug  
        } catch (VisualforceException e) {
            body = Blob.valueOf('normal Text');
            System.debug(e.getMessage() + '\r\n' + e.getStackTraceString() + '\r\n' + e.getTypeName() + '\r\n' + System.now() + '\r\n' + '--------------');
            
        }
        /***************************** Creating Attachment****************************/
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('LI_App.pdf');
        attach.Body = body;
        
        /***************************** Creating Email********************************/
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] { email });
        mail.setSaveAsActivity(true);
        //mail.setSubject('PDF Email Demo');
        mail.setSubject('Your Term Insurance Application #' + policyObj.Alip_Application_Id__c + ' from MyInsurance');
        //mail.setHtmlBody('Here is the email you requested! Check the attachment!');
       //String messageBody = '<html><body>Hi There,<br/><br/>This is to inform you that the application has been electronically submitted.<br/><br/>We would love to hear from you. <br/><br/>Regards<br/>Test</body>  </html>';
        String messageBody = '<html><body>Hello '+ lquotes.Account.Name + ',<br/><br/>Greetings !<br/><br/>We have attached your completed application no. '+ policyObj.Alip_Application_Id__c + ' in this email.<br/><br/>Please follow the below steps to ensure the application is completed.<br/><br/>1.  Save the attached pdf file on your local system and open it in Adobe Acrobat Reader<br/>2.  Click on the â€œFill and Signâ€ button in right top corner besides the â€œCommentâ€ button<br/>3. Click on the â€œSign with Certificateâ€ button in the below panel<br/>4.   Click on the â€œDrag New Signature Rectangle â€¦â€ button on the popup<br/>5.    Draw a rectangle at the end of the pdf beside â€œSignatureâ€ and a dialog box should appear<br/>7. On the dialog box that appears, select â€œSign-In Idâ€ from the â€œSign Asâ€ drop down<br/>8. Click on the â€œSignâ€ button at the right bottom of the dialog box <br/>9.    You shall be prompted to save the file. Kindly do so with a new file name<br/>10.   Email the new file to myinsurance@myinsurance.com<br/><br/> For any queries or concerns, please feel free to reach out to us. <br/><br/>Thank you for choosing MyInsurance.<br/><br/>Warm Regards,<br/>MyInsurance</body>  </html>';
        
        mail.setHtmlBody(messageBody);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+email));
        
        policyObj.SendEmail__c = true;    
        update policyObj;
        
    }
    //@future (callout=true)
    public void sendToAlip(String policyId){
        System.debug('Send to Alip Called====');
        String strRes = GenerateXMLforALIPFinal.sendRequesttoALIP(policyId);        
        if(String.IsNotBlank(strRes)){
            System.debug('==strRes=' + strRes);        
            Policy__c policyObj = [Select Id,Alip_Application_Id__c,Alip_Application_Status__c From Policy__c Where Id=:policyId];
            System.debug('===' + policyObj);
            policyObj.Alip_Application_Id__c = strRes.split(',')[0];
            policyObj.Alip_Application_Status__c= strRes.split(',')[1];
            
            AppplicationId = policyObj.Alip_Application_Id__c;
            AlipApplicationStatus = policyObj.Alip_Application_Status__c;
            update policyObj;            
        }                                
    }
    
    public void Disagree(){}
    
    
    
    public String getQuote(String organizationName,String selectedSumInsured,String gender,String term,String paymentMode,String rider,String isTobaccoUser,Date userDateOfBirth){
        
        System.debug('organizationName======================================>:'+organizationName);
        System.debug('gender======================================>:'+gender);
        System.debug('term======================================>:'+term);
        System.debug('paymentMode======================================>:'+paymentMode);
        System.debug('rider======================================>:'+rider);
        System.debug('isTobaccoUser======================================>:'+isTobaccoUser);
        System.debug('userDateOfBirth======================================>:'+userDateOfBirth);
        System.debug('selectedSumInsured======================================>:'+selectedSumInsured);
        Integer userAge=Integer.valueOf(math.FLOOR(userDateOfBirth.daysBetween(system.today())/365.2425));
        
        
        if(paymentMode==null)
            paymentMode='Monthly';
        //if(rider==null)
        //rider='None';
        /* selectedRider=rider;
selectedPaymentTerm=paymentMode;
selectedTerm=term;
this.selectedSumInsured=selectedSumInsured;
tobaccoUser=isTobaccoUser;
*/
        /*List<Gender_Multiplier__c>  genderMultiplier= [Select Id, Gender__c, Age__c, Multiplier__c  FROM Gender_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName and Gender__c=:gender and Age__c=:userAge];
List<Term_Multiplier__c>   termMultiplier= [Select Term__c, Multiplier__c FROM Term_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Term__c=:term]; 
List<Payment_Mode_Multiplier__c>  paymentModeMultiplier= [Select Payment_Mode__c, Multiplier__c FROM Payment_Mode_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Payment_Mode__c=:paymentMode];
List<Rider_Muliplier__c>   riderMultiplier= [Select Rider__c, Multiplier__c FROM Rider_Muliplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Rider__c=:rider];
List<Tobacco_Multiplier__c>   tobaccoMultiplier= [Select Tobacco_User__c, Multiplier__c FROM Tobacco_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Tobacco_User__c=:isTobaccoUser];
if(genderMultiplier.size()>0 && termMultiplier.size()>0 && paymentModeMultiplier.size()>0 && riderMultiplier.size()>0 && tobaccoMultiplier.size()>0){
//Quote = Rate * Coverage* Term Factor * Payment Mode Factor * Tobacco User factor * Rider factor
quoteAmt=noOfThousands*genderMultiplier.get(0).Multiplier__c*termMultiplier.get(0).Multiplier__c*paymentModeMultiplier.get(0).Multiplier__c*riderMultiplier.get(0).Multiplier__c*tobaccoMultiplier.get(0).Multiplier__c;
}
else{
quoteAmt=10;
}*/
        decimal PaymentModevalue = 1;
        decimal Ridervalue = 1;    
        quoteAmt= calculateQuoteAmount.calculateQuote(userAge,selectedSumInsured,gender,integer.Valueof(term),isTobaccoUser);
        
        if(paymentMode.equalsignorecase('Monthly')){
            PaymentModevalue = 1;
        }else if(paymentMode.equalsignorecase('Semi Annual')){
            PaymentModevalue = 5.88;
        }else if(paymentMode.equalsignorecase('Quarterly')){
            PaymentModevalue = 2.97;
        }else if(paymentMode.equalsignorecase('Annual')){
            PaymentModevalue = 11.63;
        }
        
        //if(String.IsNotBlank(rider) && rider!='None'){
        if(rider!=null && rider.equalsignorecase('yes'))       {
            Ridervalue = 1.1;
        }
        quoteAmt = quoteAmt * PaymentModevalue * Ridervalue;
        
        String Quote=String.valueOf(quoteAmt);
        
        return ''+Quote.subString(0,Quote.indexOf('.')+3);
        
        
    }
    //Quote quoObj{get;set;}
    public List<QuoteWrapper> quoteWrapperList{get;set;}
    public List<QuoteWrapper> retrieveListOfQuotesForOpp{
        get{
            if(quoteWrapperList!=null && retrieveListOfQuotesForOpp!=null && (retrieveListOfQuotesForOpp.size()-quoteWrapperList.size())>0)
            {
                integer i=retrieveListOfQuotesForOpp.size()-quoteWrapperList.size()-1;
                for(integer j=i;j>=0;j--){
                    quoteWrapperList.add(retrieveListOfQuotesForOpp.get(retrieveListOfQuotesForOpp.size()-j));
                }
                return quoteWrapperList;
            }
            quoteWrapperList=new List<QuoteWrapper>();
            List<Quote> tempList=[Select id,Name,Recommended_Rider__c,Payment_Term__c,Premium__c,Product__c,Rider__c,Sum_Insured__c,Term_Length__c,Tobacco_Nicotine__c,Account.Name,Opportunity.Name from Quote Where OpportunityId =:leadObj.convertedOpportunityId order by lastmodifieddate desc];
            for(Quote quoObj : tempList)
            {
                quoObj.Premium__c =  quoObj.Premium__c.setscale(2);
                QuoteWrapper temp= new QuoteWrapper(quoObj);
                quoteWrapperList.add(temp);
            }
            return quoteWrapperList;
            
        }
        set;
    }
    public String selectedQuoteToApply{get;set;}
    
    public void applyQuote(){
        
        List<Quote> selQuote=[Select id,Name,Payment_Term__c,Premium__c,Product__c,Rider__c,Sum_Insured__c,Term_Length__c,Tobacco_Nicotine__c,Account.Name,Opportunity.Name from Quote Where id=:selectedQuoteToApply];
        system.debug('selectedQuoteToApply==============================================================================================>:'+selectedQuoteToApply+'        selQuote.size is =========>:'+selQuote.size());
        selectedProduct=selQuote[0].Product__c;
        selectedPaymentTerm=selQuote[0].Payment_Term__c;
        selectedRider=selQuote[0].Payment_Term__c;
        selectedTerm=String.valueOf(selQuote[0].Term_Length__c);
        selectedSumInsured=String.valueOf(selQuote[0].Sum_Insured__c);
        tobaccoUser=(selQuote[0].Tobacco_Nicotine__c?'Yes':'No');
        quoteAmt=selQuote[0].Premium__c.setscale(2);
        premiumAmount=String.valueOf(quoteAmt);
        quoteId=selQuote[0].id;
    }
    
    
    public PageReference privacyDoc(){
        return new PageReference('/apex/InsuranceHIPAA?+leadObj.id');
    }
    
    public class QuoteWrapper{
        public Quote quoteObject{get;set;}
        public QuoteWrapper(){}
        public QuoteWrapper(Quote quoteObject){
            this.quoteObject=quoteObject;
            
        }
    }
    
    public String labelClass{
        get{
            return 'control-label';
        }set;
    }
    
    /////////Application Summary by Komal Date 06/07/2015////////////////
    
    
    /*  public string modeOfpaymentVar{get{

return policyObj.Mode_Of_Payment__c;

}set;}*/
    
    public String coverageAmt{get;set;}
    public String coverageAmt1{get;set;}
    /* Method for getting the policy status  by Himanshu
public String ApplicationStatus{get{
String strPlid= ApexPages.currentPage().getParameters().get('id'); 
//  String AccId2 = apexpages.currentpage().getparameters().get('id'); 
// List<policy__c> policyList1 = [Select id, Status__c, SendEmail__c from policy__c where Policy__c.Account_Name__r.id=:leadObj.convertedOpportunityId];
List<policy__c> policyList1 = [select id,Mode_Of_Payment__c,Status__c from Policy__c where id =: strPlid];
system.debug('----strPlid-------'+ strPlid);
return policyList1[0].Status__c;

} set;}
*/
    
    public String modeOfPayement{get{
        
        String strPlid1= ApexPages.currentPage().getParameters().get('pid'); 
        List<policy__c> policyList = [select id,Mode_Of_Payment__c from Policy__c where id =: strPlid1];
        system.debug('----strPlid-------'+strPlid1);
        return policyList[0].Mode_Of_Payment__c;
        
    } set;}
    public String billingFreq{get{
        
        String strPlid1= ApexPages.currentPage().getParameters().get('pid'); 
        List<policy__c> policyList = [select id,Mode_Of_Payment__c,Quote_Name__r.Payment_Term__c from Policy__c where id =: strPlid1];
        system.debug('----strPlid-------'+strPlid1);
        return policyList[0].Quote_Name__r.Payment_Term__c;
        
    } set;}
    public Account accList{get;set;}
    public Decimal CalculatedPremium{get;set;}
    public void getDetails(){
        
        String strPlid1= ApexPages.currentPage().getParameters().get('pid'); 
        List<Opportunity> oppList = [select id,AccountID,Cover_Amount__c from Opportunity where AccountID =: leadObj.ConvertedAccountId];
        accList = [SELECT Id, BillingState, ShippingState,BillingCity ,Height__c ,weight__c,PersonEmail,phone,BillingPostalCode,BillingCountry,BillingStreet, Marital_Status__c ,FirstName, LastName, Birth_Date__c, Gender__c, Age__c, Tax_ID__c FROM Account where id =: leadObj.ConvertedAccountId];
        List<Policy__c> policyObj = [SELECT Id, Name, Account_Name__r.Middle_Name__c, Quote_Name__r.Sum_Insured__c, Quote_Name__r.Payment_Term__c, Quote_Name__r.Term_Length__c, Initial_Premium_Payment__c, Mode_Of_Payment__c, Tax_Qualification_Status__c, SendEmail__c, Status__c FROM Policy__c where Account_Name__c =: leadObj.convertedAccountId and id =: strPlid1];
        
        ApplicationStatus = policyObj[0].Status__c;
        Accountmiddlename = policyObj[0].Account_Name__r.Middle_Name__c;
        QuotePayment = policyObj[0].Quote_Name__r.Payment_Term__c;
        CalculatedPremium = policyObj[0].Initial_Premium_Payment__c.setscale(2);
        planTerm = policyObj[0].Quote_Name__r.Term_Length__c;
        //selectedModeOfPayment = policyObj[0].Mode_Of_Payment__c;
        coverageAmt1 = policyObj[0].Quote_Name__r.Sum_Insured__c;
        if(oppList.size() > 0){
            coverageAmt = oppList[0].Cover_Amount__c;
            
        }
    }
    
    
    public string urlVar{get{
        
        String testid= ApexPages.currentPage().getParameters().get('pid'); 
        system.debug('----LI_App----'+'https://c.cs17.visual.force.com/apex/LI_App?id='+leadObj.id+'&pid='+testid);
        //return 'https://c.cs17.visual.force.com/apex/LI_App?id='+leadObj.id+'&pid='+testid;
        return '/apex/LI_App1?id='+leadObj.id+'&pid='+testid;
    } set;
                         
                        }
    /***8 Getting view page of hippa */
    public string urlViewHippa{get{
        
        String testid= ApexPages.currentPage().getParameters().get('pid'); 
        system.debug('----LI_App----'+'https://c.cs17.visual.force.com/apex/LI_App?id='+leadObj.id+'&pid='+testid);
        //return 'https://c.cs17.visual.force.com/apex/LI_App?id='+leadObj.id+'&pid='+testid;
        return 'apex/InsuranceHIPAA?id='+leadObj.id+'&pid='+testid;
    } set;
                               
                              }
    
    public PageReference previousApplicationSummaryInfo(){return new PageReference('/apex/Payment_Informationui?id='+leadObj.id+'&pid=' + policyObj.Id);}
    public PageReference cancelApplicationSummaryInfo(){return new PageReference('/apex/Payment_Information?id='+leadObj.id);}
    public PageReference NextApplicationSummaryInfo(){return new PageReference('/apex/VFP_Form_Screenui?id='+leadObj.id +'&pid=' + policyObj.Id);}
    public pagereference generatePDF(){
        
        PageReference ReturnPage = new PageReference('/apex/LI_App?id='+leadObj.id +'&pid='+policyId); 
        ReturnPage.setRedirect(true);
        return ReturnPage;
        
    }
    public PageReference  nextFormInfo(){
        //return new PageReference('/apex/Electronic_Signature_Consent?id='+leadObj.id);
        return new PageReference('/apex/Electronic_Signature_Consentui?id='+leadObj.id);
    }
    
    public String leadAdd{get{
        
        String addr='';
        addr=leadObj.street==null?'':leadObj.street+', ';
        addr=addr+(leadObj.city==null?'':leadObj.city+', ');
        addr=addr+(leadObj.state==null?'':leadObj.state+', ');
        addr=addr+(leadObj.PostalCode==null?'':leadObj.PostalCode+', ');
        addr=addr+(leadObj.country==null?'':leadObj.country);
        
        addr = addr.removeEnd(',');
        
        return addr;
    }set;
                         }
    public String TextQus1{get{
        
        List<Account> accObjs=[select id,LifeDisabilityInsurance__c,Name from Account where id=:leadObj.convertedAccountId];
        if(accObjs[0].LifeDisabilityInsurance__c == true){
            TextQus1 = 'Yes';
        }
        else{
            TextQus1 = 'No';
        }
        return TextQus1;
        
    }set;}
    public string TextQus2{get{
        
        List<Account> accObjs=[select id,Insuredflownaircraft__c,Name from Account where id=:leadObj.convertedAccountId];
        if(accObjs[0].Insuredflownaircraft__c == true){
            TextQus2 = 'Yes';
        }
        else{
            TextQus2 = 'No';
        }
        return TextQus2;
        
    }set;}
    public string TextQus3{get{
        
        List<Account> accObjs=[select id,InsuredTobaccoConsumption__c,Name from Account where id=:leadObj.convertedAccountId];
        if(accObjs[0].InsuredTobaccoConsumption__c == true){
            TextQus3 = 'Yes';
        }
        else{
            TextQus3 = 'No';
        }
        return TextQus3;
    }set;}
    
    
    //Function for the Personal & Medical History by Himanshu Date 06/07/2015//
    
    Public List<SelectOption> getItem(){
        List<SelectOption> selOpt = New List<SelectOption>();
        selOpt.add(new SelectOption('Yes','Yes'));
        selOpt.add(new SelectOption('No','No'));
        Return selOpt;    
    }
    
    Public List<SelectOption> getItem1(){
        List<SelectOption> selOpt = New List<SelectOption>();
        selOpt.add(new SelectOption('Yes','Yes'));
        selOpt.add(new SelectOption('No','No'));
        Return selOpt;    
    }
    
    Public List<SelectOption> getItem2(){
        List<SelectOption> selOpt = New List<SelectOption>();
        selOpt.add(new SelectOption('Yes','Yes'));
        selOpt.add(new SelectOption('No','No'));
        Return selOpt;    
    }
    /* Save function on the personalMedicalPage by Himanshu
@Method Uplead for Saving */
    
    Public Pagereference UpLead(){
        AccId1 = leadObj.convertedAccountId; 
        Account Acc = new Account();
        Acc = [Select id, Insuredflownaircraft__c,InsuredTobaccoConsumption__c, LifeDisabilityInsurance__c from Account where Id =: AccId1 limit 1] ;
        
        
        If(SelVal == 'Yes'){
            Acc.LifeDisabilityInsurance__c = True;
        }    else{
            Acc.LifeDisabilityInsurance__c = False;
        }
        If(SelVal1 == 'Yes'){
            Acc.InsuredTobaccoConsumption__c = True;
        }    else{
            Acc.InsuredTobaccoConsumption__c = False;
        }
        If(SelVal2 == 'Yes'){
            Acc.Insuredflownaircraft__c = True;
        }    else{
            Acc.Insuredflownaircraft__c = False;
        }             
        Acc.Id  = AccId1; 
        Update Acc;
        Return new PageReference('/apex/PersonalMedicalHistory?id='+leadObj.id +'&pid=' + policyId );
    }
    //Update Acc; 
    // Return null;
    // }
    /***** Previous function on the personalMedicalPage by Himanshu
@Method PersonalPrevious for Previous page ***********/
    
    Public Pagereference PersonalPrevious(){return new PageReference('/apex/Applicant_Informationui?id='+leadObj.id +'&pid=' + policyId);}
    
    /****** Cancel function on the personalMedicalPage by Himanshu
@Method PersonalCancel for Cancel ************/
    
    Public Pagereference PersonalCancel(){return new PageReference('/apex/Applicant_Information?id='+leadObj.id);}
    Public Pagereference PersonalNext(){
        // Account Acc = new Account();
        AccId1 = leadObj.convertedAccountId; 
        Account Acc = new Account();
        Acc = [Select id, Insuredflownaircraft__c,InsuredTobaccoConsumption__c, LifeDisabilityInsurance__c from Account where Id =: AccId1 limit 1] ;
        
      Try{
        If(SelVal == 'Yes'){
            Acc.LifeDisabilityInsurance__c = True;
        }    else{
            Acc.LifeDisabilityInsurance__c = False;
        }
        If(SelVal1 == 'Yes'){
            Acc.InsuredTobaccoConsumption__c = True;
        }    else{
            Acc.InsuredTobaccoConsumption__c = False;
        }
        If(SelVal2 == 'Yes'){
            Acc.Insuredflownaircraft__c = True;
        }    else{
            Acc.Insuredflownaircraft__c = False;
        }             
        Acc.Id  = AccId1; 
        Update Acc; 
        return new PageReference('/apex/Payment_Informationui?id='+leadObj.id +'&pid=' + policyId);   
        }
     catch(Exception e)  {
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select medical history fields')); 
                   return NULL;
                  }
    }
    //Functionality ends
    public void premiumFlag(){
        premiumCalculated = false;
    }
    
    public void premiumFlag1(){
        premiumCalculated = false;
        selectedTerm = apexpages.currentpage().getparameters().get('pass1');  
        
    }
    
    public void premiumFlag2(){
        premiumCalculated = false;
        selectedSumInsured= apexpages.currentpage().getparameters().get('pass2');  
        
    }
    
    public void callPremium(){
        premiumCalculated =true;
        QuoteCalculated = false;                // Added by himanshu 10/7/2015
        String defaultRider='None';
        String defaultPaymentTerm='Monthly';
        String defaultTobaccoUser='No';
        String defaultAge='20';
        selectedPaymentTerm=defaultPaymentTerm==null?defaultPaymentTerm:selectedPaymentTerm;
        selectedRider=selectedRider==null?defaultRider:selectedRider;
        tobaccoUser=tobaccoUser==null?defaultTobaccoUser:tobaccoUser;
        system.debug('Inside call premium : selectedSumInsured is : '+selectedSumInsured+' selectedTerm : '+selectedTerm );
        premiumAmount = calculatePremium('My Insurance',selectedSumInsured,leadObj.Gender__c,selectedTerm,selectedPaymentTerm,selectedRider,tobaccoUser,leadObj.D_O_B__c==null?Date.newInstance(1990,3,20):leadObj.D_O_B__c);
        
        
    }
    
    public String calculatePremium(String organizationName,String selectedSumInsured,String gender,String term,String paymentMode,String rider,String isTobaccoUser,Date userDateOfBirth){
        
        Integer userAge=Integer.valueOf(math.FLOOR(userDateOfBirth.daysBetween(system.today())/365.2425));
        if(paymentMode==null)
            paymentMode='Monthly';
        /*if(rider==null)
rider='None';
System.debug('Passing parameters to first query'+organizationName+'---gender---'+gender+'---------------------------age---'+userAge);
List<Gender_Multiplier__c>  genderMultiplier= [Select Id, Gender__c, Age__c, Multiplier__c  FROM Gender_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName and Gender__c=:gender and Age__c=:userAge];
List<Term_Multiplier__c>   termMultiplier= [Select Term__c, Multiplier__c FROM Term_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Term__c=:term]; 
List<Payment_Mode_Multiplier__c>  paymentModeMultiplier= [Select Payment_Mode__c, Multiplier__c FROM Payment_Mode_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Payment_Mode__c=:paymentMode];
List<Rider_Muliplier__c>   riderMultiplier= [Select Rider__c, Multiplier__c FROM Rider_Muliplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Rider__c=:rider];
List<Tobacco_Multiplier__c>   tobaccoMultiplier= [Select Tobacco_User__c, Multiplier__c FROM Tobacco_Multiplier__c  where Policy_Org__r.Organization_Name__c=:organizationName  and Tobacco_User__c=:isTobaccoUser];

if(genderMultiplier.size()>0 && termMultiplier.size()>0 && paymentModeMultiplier.size()>0 && riderMultiplier.size()>0 && tobaccoMultiplier.size()>0){
//Quote = Rate * Coverage* Term Factor * Payment Mode Factor * Tobacco User factor * Rider factor
quoteAmt=noOfThousands*genderMultiplier.get(0).Multiplier__c*termMultiplier.get(0).Multiplier__c*paymentModeMultiplier.get(0).Multiplier__c*riderMultiplier.get(0).Multiplier__c*tobaccoMultiplier.get(0).Multiplier__c;
String decValue=String.valueOf(quoteAmt);
decValue=decValue.subString(0,decValue.indexOf('.')+3);
quoteAmt=Decimal.valueOf(decValue);
}
else{
quoteAmt=10;
}*/
        
        decimal PaymentModevalue = 1;
        decimal Ridervalue = 1;    
        quoteAmt= calculateQuoteAmount.calculateQuote(userAge,selectedSumInsured,gender,integer.Valueof(term),isTobaccoUser);
        System.debug('calculateQuoteAmount====' + quoteAmt);
        if(paymentMode.equalsignorecase('Monthly')){
            PaymentModevalue = 1;
        }else if(paymentMode.equalsignorecase('Semi Annual')){
            PaymentModevalue = 5.88;
        }else if(paymentMode.equalsignorecase('Quarterly')){
            PaymentModevalue = 2.97;
        }else if(paymentMode.equalsignorecase('Annual')){
            PaymentModevalue = 11.63;
        }
        
        
         
        riderCount = 1;
        
        
        
         if(checkAccident == true){
        riderCount = riderCount * 1.1;
        }
        
        if(checkWaiver == true){
        riderCount = riderCount * 1.1;
        }
        
        if(checkCritical == true){
        riderCount = riderCount * 1.1;
        }
        
        
        System.debug('calculateQuoteAmount.PaymentModevalue ====' + PaymentModevalue );
        
        /*if(String.IsNotBlank(rider) && rider!='None'){
            Ridervalue = 1.2;
        }*/
        
        Ridervalue = riderCount;
        
        
        System.debug('calculateQuoteAmount.Ridervalue ====' + Ridervalue );
        
        quoteAmt = quoteAmt * PaymentModevalue * Ridervalue;
        System.debug('calculateQuoteAmount.quoteAmt ====' + quoteAmt ); 
        String Quote='';
        Quote=String.valueOf(quoteAmt);
        
        
        return ''+ Quote.subString(0,Quote.indexOf('.')+3);
        
    }
    
    //Function by shilpa for editLead 14/7/2015
    public PageReference editLead(){
        
        return new PageReference('/apex/Prospect_Detailsui?id='+leadObj.id);
    }
    
    //Function by shilpa for saveLead 14/7/2015
    public PageReference saveLead(){
        if(String.IsNotBlank(leadObj.PostalCode)){
            String strResponse = getLocationDetails.getLocation(leadObj.PostalCode);
            if(String.IsNotBlank(strResponse)){
                leadObj.City = strResponse.split(',')[0];
                leadObj.State = strResponse.split(',')[1];
            }
        }
        update leadObj;
        return new PageReference('/apex/Prospect_Details_saveui?id='+leadObj.id);
    }
    
    //Function by shilpa for cancelLead 14/7/2015
    public PageReference cancelLead(){
        
        return new PageReference('/apex/Prospect_Details_saveui?id='+leadObj.id);
    }
    
    //Function by shilpa for previousForms 17/7/2015
    public PageReference previousForms(){
        
        return new PageReference('/apex/VFP_Application_Summaryui?id='+leadObj.id +'&pid=' + policyObj.Id);
    }
    
    /*   // Function For Quote by Himanshu
public void QuoteEmailTempalte() {
PolicyObj = New Policy__c();

PolicyObj = [Select id,Account.Name,Opportunity.Name, Payment_Term__c,Premium__c, Product__c, Rider__c, Sum_Insured__c, Term_Length__c, Tobacco_Nicotine__c from Quote where OpportunityId = :leadObj.convertedOpportunityId Order by QuoteNumber desc limit 1] ;
system.debug('Quote-->'+lquotes);
}

*/
    
    
    public void closeSavepopup(){
        
        showPopup = false;
    }  
    
    public void closeEmailpopup(){
        
        showEmailPopup = false;
    }  
    
    public void closeSubmitpopup(){
        
        showSubmitPopup = false;
       // return new PageReference('/00Q/o'); 
    }  
    
    
}