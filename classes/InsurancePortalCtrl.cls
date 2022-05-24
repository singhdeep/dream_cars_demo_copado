/**
* @author Sachin Raykar 
* @date 5/13/2015
* @description Class creates the leads based on given methods.
* @Devops Testing 2:52 PM 1/18/2017
              
*/ 


public class InsurancePortalCtrl{


    public Lead leadVar{get;set;}
    public Integer counter{get;set;}
    public String promoProduct{get;set;}
    public String promoCoverage{get;set;}
    public String promoTerm{get;set;}
    public String promoPremium{get;set;}
    public String userName{get;set;}
    public String userPassword{get;set;}
    public String Quote{get;set;}
    public boolean displayPopup {get; set;}
    public boolean flagRemind {get; set;}
    public boolean flagBuy {get; set;}
    public boolean flagBilling {get; set;}
    public Date dob;
    public String FirstName {get; set;}
    public String lastName {get; set;}
    public String middleName {get; set;}
    public String YourHealth {get; set;}
    public String gender {get; set;}
    public Boolean tobacconicotineuse{get; set;}
    public Decimal termlength {get; set;}
  // public integer coverageamount{get; set;}
    public String city {get; set;}
    public String state{get; set;}
    Public String PostalCode{get; set;}
    Public String Email{get; set;}
    Public string Phone{get; set;}
    Public string PhotoURL{get; set;}
    Public string LikeCategory{get; set;}    
     public string coverageamount {get; set;}
        
    public Integer dateofbirth{get;set;}
    public Integer monthofbirth{get;set;}
    public Integer yearofbirth{get;set;}
    
    public String FacebookID{get; set;}
    public String maritalstatus{get; set;}
    public String  referencenumber {get;private set;}
    
    public InsurancePortalCtrl(){
        displayPopup = false;
        flagRemind = false;
        flagBuy = false;
        flagBilling = true;
        leadVar = new lead();
        leadVar.Tobacco_nicotine_use__c = false;
        referencenumber ='A - ' + Math.Round((Math.random()*10000));// added by shilpa on 22/07/2015
        //apexpages.currentpage().getparameters().get('id');
    
        System.debug('firstname=====' + apexpages.currentpage().getparameters().get('firstname'));
        System.debug('lastname=====' + apexpages.currentpage().getparameters().get('lastname'));
        System.debug('email=====' + apexpages.currentpage().getparameters().get('email'));
                        
        String strFirstName =apexpages.currentpage().getparameters().get('firstname');
        if(String.IsNotBlank(strFirstName)){
           FirstName = strFirstName;
        }

        String strLastName =apexpages.currentpage().getparameters().get('lastname');
        if(String.IsNotBlank(strFirstName)){
           LastName = strLastName;
        }
                
        String strbirthday = apexpages.currentpage().getparameters().get('birthday');
        if(String.IsNotBlank(strbirthday) && strbirthday.length() > 0){
            dateofbirth = Integer.ValueOf(strbirthday);
        }                    
          
        String strmonthofbirth =apexpages.currentpage().getparameters().get('birthmonth');
        if(String.IsNotBlank(strmonthofbirth)){
           monthofbirth = Integer.ValueOf(strmonthofbirth);
        }
        
        String strbirthyear = apexpages.currentpage().getparameters().get('birthyear');
        if(strbirthyear != null && strbirthyear.length() > 0){
            yearofbirth = Integer.ValueOf(strbirthyear);
        }  
        
        String strEmail =apexpages.currentpage().getparameters().get('email');
        if(String.IsNotBlank(strEmail)){
           Email = strEmail ;
        }
        
        String strGender =apexpages.currentpage().getparameters().get('gender');
        if(String.IsNotBlank(strGender)){
           if(strGender.equalsIgnorecase('F') || strGender.equalsIgnorecase('Female')){
               gender = 'Female';
           }else{
               gender = 'Male';           
           }           
        }
        
        String strCity =apexpages.currentpage().getparameters().get('city');
        if(String.IsNotBlank(strCity)){
           City= strCity;
        }

        String strState=apexpages.currentpage().getparameters().get('state');
        if(String.IsNotBlank(strState)){
           State= strState;
        }         
        
        String strPhotoURL=apexpages.currentpage().getparameters().get('PhotoURL');
        if(String.IsNotBlank(strPhotoURL)){
           PhotoURL= strPhotoURL;
        }
        
        String strLikeCategory=apexpages.currentpage().getparameters().get('LikeCategory');
        if(String.IsNotBlank(strLikeCategory)){
           LikeCategory= strLikeCategory;
        }  
        
        String strmaritalstatus =apexpages.currentpage().getparameters().get('Relationship');
        system.debug('strmaritalstatus  is '+strmaritalstatus );
        if(String.IsNotBlank(strmaritalstatus)){
           maritalstatus= strmaritalstatus;
        }
        String strFacebookID=apexpages.currentpage().getparameters().get('ID');
        system.debug('strFacebookID is '+strFacebookID);
        if(String.IsNotBlank(strFacebookID)){
           FacebookID= strFacebookID;
        }                                  
}
    //Create custom picklist for Term as it is a number field and changing the data type may create obstacles as it is laready used in various triggers and webservices.    
 /*   public List<SelectOption> getTermOptions() {
        List<SelectOption> TermOptions= new List<SelectOption>();
        TermOptions.add(new SelectOption('','-None-'));
        TermOptions.add(new SelectOption('10','10'));
        TermOptions.add(new SelectOption('15','15'));
        TermOptions.add(new SelectOption('20','20'));
        TermOptions.add(new SelectOption('25','25'));
        TermOptions.add(new SelectOption('30','30'));
 
        return TermOptions;
    }
    public List<SelectOption> getHealthOptions() {
        List<SelectOption> YourHealthOptions= new List<SelectOption>();
        YourHealthOptions.add(new SelectOption('','-None-'));
        YourHealthOptions.add(new SelectOption('Excellent','Excellent'));
        YourHealthOptions.add(new SelectOption('Very Good','Very Good'));
        YourHealthOptions.add(new SelectOption('Good','Good'));
        YourHealthOptions.add(new SelectOption('Fair','Fair'));
       
        return YourHealthOptions;
    }
    public List<SelectOption> getGenderOptions() {
        List<SelectOption> GenderOptions= new List<SelectOption>();
        GenderOptions.add(new SelectOption('','-None-'));
        GenderOptions.add(new SelectOption('Male','Male'));
        GenderOptions.add(new SelectOption('Female','Female'));
       
        return GenderOptions;
    } */
  
   
    public PageReference redirectToPortal(){
        PageReference portalPage = new pagereference('/apex/InsurancePortalui');
        return portalPage ;

            
    
    } 
    public String getQuoteAmnt()
        {  
             /*Decimal Quote =0;
             integer Daytoday = Date.Today().Year(); 
             integer dateofbirth = dob.Year(); 
             Integer Age = Daytoday - dateofbirth ;
             Decimal Rateper1000 = Quote__c.getValues(leadVar.Gender__c+Age ).Value__c ;
             Decimal Rate = Rateper1000*1000;System.debug('______'+Rateper1000 );
             Decimal Coverage = leadVar.Coverage_Amount__c;
             //String cvg = Coverage.toPlainString();
             String Gender = leadVar.Gender__c;
             Decimal TermFactor = Quote__c.getValues(leadVar.Term_Length__c+ 'years').Value__c ;
             Decimal PaymentModeFactor= Quote__c.getValues('Quarterly').Value__c ;
             Decimal RiderFactor = Quote__c.getValues('RiderTrue').Value__c ;
             System.debug('This is nicotine value------'+leadVar.Tobacco_nicotine_use__c);
             Decimal  TobaccoUserfactor= Quote__c.getValues('Tobacco'+leadVar.Tobacco_nicotine_use__c).Value__c ;*/
             String isTobaccouser;
             if (tobacconicotineuse) {isTobaccouser = 'Yes';}
             else {isTobaccouser = 'No';}
             //String quote = new QuotePageController().getQuote('My Insurance',leadVar.Coverage_Amount__c.toPlainString(),leadVar.Gender__c,leadVar.Term_Length__c.toPlainString(),'Monthly',null,isTobaccouser,dob);
           //  String quote = new QuotePageController().getQuote('My Insurance',String.valueOf(coverageamount),gender ,termlength.toPlainString() ,'Monthly',null,isTobaccouser,dob);
             quote = new QuotePageController().getQuote('My Insurance',coverageamount,gender ,termlength.toPlainString() ,'Monthly',null,isTobaccouser,dob);
             return Quote;  
            // return null;
             
            
        }
        
        /**

* @date 07/03/2015
* @This method helps to insert the lead data in to the model.
*/   
    public pageReference createlead()
        {
        pageReference pg = null;
        try{
            pg = new pageReference('/apex/InsuranceThankui');
            leadVar.FirstName = FirstName ;
            leadVar.LastName = lastName ;
            leadVar.Middle_Name__c = middleName ;
            leadVar.Your_Health__c = YourHealth ;
            leadVar.D_O_B__c =dob;
            leadVar.Gender__c = gender ;
            leadVar.Tobacco_nicotine_use__c =tobacconicotineuse;
            leadVar.Term_Length__c =termlength ; 
            //leadVar.Coverage_Amount__c = coverageamount;
         leadVar.Coverage__c = coverageamount;
            leadVar.City =city ;
            leadVar.State = state;
            leadVar.Country ='USA';
            leadVar.Interest__c= LikeCategory; //'Cars';
            leadVar.Facebook_Profile_URL__c = PhotoURL;
            system.debug('FacebookID is '+FacebookID);
            leadVar.Facebook_ID__c= FacebookID;
            system.debug('maritalstatus is '+maritalstatus);
            leadVar.Marital_Status__c= maritalstatus;
            leadVar.intial_premium__c= Quote;
            //leadVar.PostalCode = PostalCode;
            leadVar.Email = Email; //added by Nitin
            leadVar.Reference_Number__c = referencenumber ;//added by shilpa on 22/07/2015
            //leadVar.Phone = Phone; 
            leadVar.Product_Interest__c = Label.CL_ProductInterest;
            leadVar.Company = Label.CL_CompanyName;
            //leadVar.First_Name__c =leadVar.FirstName;
            //leadVar.Last_Name__c=leadVar.LastName;
            
            if(String.IsNotBlank(leadVar.PostalCode)){
                String strResponse = getLocationDetails.getLocation(leadVar.PostalCode);            
                if(String.IsNotBlank(strResponse) ){
                    leadVar.City = strResponse.Split(',')[0];
                    leadVar.State = strResponse.Split(',')[1]; 
                }                
            }
            
            try{
             System.debug('==leadVar before==='+ leadVar);
            insert leadVar;
            System.debug('==leadVar after==='+ leadVar);
            }
            catch(DmlException e)
            {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getDmlMessage(0)));
            pg = null;
            }
            catch(exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Enter Email id correctly'));
            }
            
           }
           catch(Exception e)  {
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
                  }
            
          //pageReference pg = new pageReference('/apex/InsuranceThankui');
          // pageReference pg = new pageReference(Lable.InsuranceThank);
          
          
            return pg;

        }
        public void showPopup()
          {
          
            displayPopup = true;
           
          }
        public void calculatequote()
            {
            
            }
            /**

* @date 07/03/2015
* @This method calculates the age and gives an exception if the lead's age is less than 18.  

*/
          public pageReference seequote()
              { 
              
                  try{
                  
                  dob= Date.parse((monthofbirth+'/'+dateofbirth +'/'+yearofbirth).trim());
                  integer today = Date.Today().Year(); 
                  integer dateofb = dob.Year(); 
                  Integer Dobcalculate = today - dateofb ; System.debug('------------'+Dobcalculate );
                  if(Dobcalculate <= 18){
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Age should be greater than equal to 18 years.Enter a Valid Date of Birth')); 
                   return NULL;} 
                    }    
                  catch(Exception e)  {
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select a valid Date of Birth.')); 
                   return NULL;
                  }
                  
                         pageReference pg= new pageReference('/apex/InsuranceApplyui');
                         // pageReference pg= new pageReference(Lable.InsuranceApply);
                          return pg; 
                  
              }
              
              public pageReference editQuote()
              {
                  pageReference pgRef = new pageReference('/apex/InsurancePortalui');
                  //pageReference pgRef = new pageReference(Label.InsurancePortal);
                  return pgRef;
              } 
              
              /**

* @date 07/03/2015
* @This method will be called when user will try to select the day form date of birth field.  

*/  
              
              
               public List<SelectOption> getopenPresentationOptions(){
                List<SelectOption> optns = new List<Selectoption>();
                // before getting here you must populate your queryResult list with required fields
                for(Integer i=1;i<=31;i++){
                optns.add(new selectOption(i+'',i+''));
                   }            

                return optns;
               }
               
                /**

* @date 07/03/2015
* @This method will be called when user will try to select the month form date of birth field.  

*/

               public List<SelectOption> getmonthOptions() {
                List<SelectOption> mOptions= new List<SelectOption>();
               
                mOptions.add(new SelectOption('01','Jan'));
                mOptions.add(new SelectOption('02','Feb'));
                mOptions.add(new SelectOption('03','Mar'));
                mOptions.add(new SelectOption('04','Apr'));
                mOptions.add(new SelectOption('05','May'));
                mOptions.add(new SelectOption('06','Jun'));
                mOptions.add(new SelectOption('07','Jul'));
                mOptions.add(new SelectOption('08','Aug'));
                mOptions.add(new SelectOption('09','Sept'));
                mOptions.add(new SelectOption('10','Oct'));
                mOptions.add(new SelectOption('11','Nov'));
                mOptions.add(new SelectOption('12','Dec'));
 
                    return mOptions;
                }
                
                /**

* @date 07/03/2015
* @This method will be called when user will try to select the Year form date of birth field.  

*/
     public List<SelectOption> getyearOptions(){
        List<SelectOption> optns = new List<Selectoption>();
        // before getting here you must populate your queryResult list with required fields
        for(Integer i=1960;i<=2015;i++){
           optns.add(new selectOption(i+'',i+''));
        }            

                return optns;
     } 
     public Void popupRemind(){
         flagRemind=true;
         system.debug('counter : '+counter);
         if (counter == 1){
             promoProduct = 'I-Select';
             promoCoverage = '$100,000';
             promoTerm = '20 years';
             promoPremium = '$17.49/month';
         }else if(counter == 2){
             promoProduct = 'I-Flex';
             promoCoverage = '$200,000';
             promoTerm = '25 years';
             promoPremium = '$35.49/month';
         }else if(counter == 3){
             promoProduct = 'I-Protect';
             promoCoverage = '$350,000';
             promoTerm = '30 years';
             promoPremium = '$46.99/month';
         }
     }
      public Void popupBuy(){
         flagBuy=true;
         system.debug('counter : '+counter);
         if (counter == 1){
             promoProduct = 'I-Select';
             promoCoverage = '$100,000';
             promoTerm = '20 years';
             promoPremium = '$17.49/month';
         }else if(counter == 2){
             promoProduct = 'I-Flex';
             promoCoverage = '$200,000';
             promoTerm = '25 years';
             promoPremium = '$35.49/month';
         }else if(counter == 3){
             promoProduct = 'I-Protect';
             promoCoverage = '$350,000';
             promoTerm = '30 years';
             promoPremium = '$46.99/month';
         }
     }
     

     public Void closeRemind(){
         flagRemind=false;
     }
      public Void closeBuy(){
         flagBuy=false;
     }
   Public PageReference BackPortal(){
        return new pagereference('http://myinsurance.force.com/InsurancePortalui');
      }  
     
   
}