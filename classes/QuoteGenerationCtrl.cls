public with sharing class QuoteGenerationCtrl {
    
    public Opportunity oppObj{get;set;}
    public Policy__c policyObj{get;set;}
    public String leadId{get;set;}
    public Lead leadObj{get;set;}
    public Account accList{get;set;}
    Public string ApplicationStatus{get;set;}
    Public string Accountmiddlename{get;set;}
    Public string QuotePayment{get;set;}
    public Decimal CalculatedPremium{get;set;}
    public Decimal planTerm{get;set;}
    public String coverageAmt{get;set;}
    public String selectedProduct{get;set;}
    public String selectedSumInsured{get;set;}
    public String modeOfPayement {get;set;}
    public String billingFreq{get;set;}
    public String selectedRider {get;set;}
    public String TextQus1 {get;set;}
    public String TextQus2{get;set;}
    public String TextQus3{get;set;}
    
    public QuoteGenerationCtrl(ApexPages.StandardController controller)
    {
        leadObj = (lead)Controller.getRecord();
        leadId =leadObj.id;
        
        getDetails();
    }
    
    
    public void getDetails(){
        
        String strPlid1= ApexPages.currentPage().getParameters().get('pid'); 
        List<Opportunity> oppList = [select id,AccountID,Cover_Amount__c from Opportunity where AccountID =: leadObj.ConvertedAccountId];
        List<Account> accObjs=[select id,LifeDisabilityInsurance__c,Name,Insuredflownaircraft__c,InsuredTobaccoConsumption__c from Account where id=:leadObj.convertedAccountId];
        
        if(oppList.size()>0)
        {
            oppObj =  oppList.get(0);
        }
        
        accList = [SELECT Id, BillingState, ShippingState,BillingCity ,Height__c ,weight__c,PersonEmail,phone,
                   BillingPostalCode,BillingCountry,BillingStreet,Marital_Status__c ,FirstName, 
                   LastName, Birth_Date__c, Gender__c, Age__c, Tax_ID__c FROM Account where id =: leadObj.ConvertedAccountId];
        
        List<Policy__c> policyList = [SELECT Id, Name, Account_Name__r.Middle_Name__c,Quote_Name__r.Payment_Term__c,Quote_Name__r.Recommended_Rider__c ,Quote_Name__r.Sum_Insured__c, Quote_Name__r.Term_Length__c, 
                                      Initial_Premium_Payment__c, Mode_Of_Payment__c, Tax_Qualification_Status__c, SendEmail__c,
                                      Status__c FROM Policy__c where Account_Name__c =: leadObj.convertedAccountId and id =: strPlid1];
        
        if(policyList.size()>0)
        {
            policyObj =  policyList.get(0);
        }
        List<lead> leadLst =[Select id,Name,Address,country,postalCode,Tax_ID__c,Height__c,Interest__c ,Preferred_contact_time__c,Middle_Name__c,state,street,Weight__c,Term_Length__c,OwnerId,Age__c,Rider__c,Facebook_Profile_URL__c ,intial_premium__c,
                             coverage__c,City,status,City__c,Mailing_Address__c,AnnualRevenue,Occupation__c,
                             Product_Interest__c,Other__c,Phone,Marital_Status__c,Email,D_O_B__C,Children__c,Facebook_ID__c,
                             ProspectProfilePictureDocId__c,Social_Security_Number__c,Gender__c,Salutation,FirstName,
                             LastName,convertedAccountId,convertedOpportunityId,Tobacco_nicotine_use__c,Reference_Number__c 
                             From Lead where id =:leadId];
        if(leadLst.size()>0)
        {
            LeadObj =  leadLst.get(0);
        }
        ApplicationStatus = policyObj.Status__c;
        Accountmiddlename = policyObj.Account_Name__r.Middle_Name__c;
        QuotePayment = policyObj.Quote_Name__r.Payment_Term__c;
        CalculatedPremium = policyObj.Initial_Premium_Payment__c;
        planTerm = policyObj.Quote_Name__r.Term_Length__c;
        //selectedModeOfPayment = policyObj[0].Mode_Of_Payment__c;
        selectedSumInsured=policyObj.Quote_Name__r.Sum_Insured__c;
        selectedProduct = 'Term';
        modeOfPayement = policyObj.Mode_Of_Payment__c;
        billingFreq = policyObj.Quote_Name__r.Payment_Term__c;
        selectedRider = policyObj.Quote_Name__r.Recommended_Rider__c;
        //if(leadObj.rider__c) selectedRider ='Critical Illness';else selectedRider ='None';  
        if(oppList.size() > 0)
        {
            coverageAmt = oppObj.Cover_Amount__c;
        }
        if(accObjs[0].LifeDisabilityInsurance__c == true){
            TextQus1 = 'Yes';
        }
        else{
            TextQus1 = 'No';
        }
        if(accObjs[0].Insuredflownaircraft__c == true){
            TextQus2 = 'Yes';
        }
        else{
            TextQus2 = 'No';
        }
        if(accObjs[0].InsuredTobaccoConsumption__c == true){
            TextQus3 = 'Yes';
        }
        else{
            TextQus3 = 'No';
        }
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
    }
                          set;}
}