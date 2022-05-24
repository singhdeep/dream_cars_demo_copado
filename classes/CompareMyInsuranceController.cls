/**
Author : Shilpa 
Name : CompareMyInsuranceController
Description : This is a apex page controller for comparing insurance
**/
public without Sharing class CompareMyInsuranceController {
    public Lead l {get;set;}
   // public decimal coverageamount {get;set;}
   public String coverageamount {get;set;}                // Created by Himanshu
    public Decimal term {get;set;}
    public string firstname {get;set;}
    public string middleName {get;set;}
    public string lastname {get;set;}
    public Date dob{get; set;}
    public boolean tobacconicotineuse{get;set;}
    public String gender {get; set;}
    public boolean levelterm {get;set;}
    public string title {get;set;}
    public boolean DecreasingTerm{get;set;}
    public String Quote {get;set;}
    public String Quotewithoutrider {get;set;}
    public String Email {get;set;}
    public integer Phone {get;set;}
    public String City {get;set;}
    public String State {get;set;}    
    public String Zipcode {get;set;}
    public String Quote1 ;
    public String Quote2;
    public String quote3;                        //By Himanshu
    public String quote4;                       //By Himanshu
    public string test {get;set;}
    public string rider {get;set;}
    public boolean riderFlag;
    public boolean isCoverButtonDisabled{get;set;}
    public String  referencenumber {get;private set;}
    String isTobaccouser;
    public String updatequote{get;set;}
    public Integer dateofbirth{get;set;}
    public Integer monthofbirth{get;set;}
    public Integer yearofbirth{get;set;}
    public integer height {get;set;}
    public integer weight {get;set;}
    Public string PhotoURL{get; set;}
    Public string LikeCategory{get; set;}    
    public String FacebookID{get; set;}
    public String maritalstatus{get; set;}
   
    
    public CompareMyInsuranceController() {
    
            l = new lead();
            riderFlag = false;
            isCoverButtonDisabled = false;
         
            rider = 'No';
            if(tobacconicotineuse ==true){ 
                isTobaccouser = 'Yes';
            }
            else{isTobaccouser = 'No';
            }
            referencenumber ='A - ' + Math.Round((Math.random()*10000));
            levelterm =true;
            
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
               l.Email = strEmail ;
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
            
            String strmaritalstatus =apexpages.currentpage().getparameters().get('Relationship');
            system.debug('strmaritalstatus : '+strmaritalstatus );
            if(String.IsNotBlank(strmaritalstatus)){
               maritalstatus= strmaritalstatus;
            }
            
            String strFacebookID=apexpages.currentpage().getparameters().get('ID');
                        system.debug('strFacebookID: '+strFacebookID);
            if(String.IsNotBlank(strFacebookID)){
               FacebookID= strFacebookID;
            }      
            
            String strLikeCategory=apexpages.currentpage().getparameters().get('LikeCategory');
            if(String.IsNotBlank(strLikeCategory)){
               LikeCategory= strLikeCategory;
            }
    }
/*
    This method prepares the list of openPresentationOptions
    @name <getopenPresentationOptions>
    @Param <NA>
    @Return List<SelectOption>
*/
    
    public List<SelectOption> getopenPresentationOptions(){
        Try{    
            List<SelectOption> optns = new List<Selectoption>();
            // before getting here you must populate your queryResult list with required fields
            for(Integer i=1;i<=31;i++){
            optns.add(new selectOption(i+'',i+''));
            }            

            return optns;
        }
        catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
                Return null;
        }
    }
/*
    This method prepares the list Date, month in a picklist
    @name <getmonthOptions>
    @param <NA> 
    @return List<SelectOption> 
*/      
    public List<SelectOption> getmonthOptions() {
        Try{
            List<SelectOption> mOptions= new List<SelectOption>();   
            mOptions.add(new SelectOption('1','Jan'));
            mOptions.add(new SelectOption('2','Feb'));
            mOptions.add(new SelectOption('3','Mar'));
            mOptions.add(new SelectOption('4','Apr'));
            mOptions.add(new SelectOption('5','May'));
            mOptions.add(new SelectOption('6','Jun'));
            mOptions.add(new SelectOption('7','Jul'));
            mOptions.add(new SelectOption('8','Aug'));
            mOptions.add(new SelectOption('9','Sept'));
            mOptions.add(new SelectOption('10','Oct'));
            mOptions.add(new SelectOption('11','Nov'));
            mOptions.add(new SelectOption('12','Dec'));
            return mOptions;
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information'));
            Return null;
        }
    }
    
/*
    This method prepares the list Years in a picklist
    @name <getyearOptions>
    @param <NA> 
    @return List<SelectOption> 
*/  
     public List<SelectOption> getyearOptions(){
        Try{ 
            List<SelectOption> optns = new List<Selectoption>();
            // before getting here you must populate your queryResult list with required fields
            for(Integer i=1960;i<=2015;i++){
            optns.add(new selectOption(i+'',i+''));
        }            
            return optns;
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
            Return null;
        }
            }
/*
    This method prepares the list of Years(Range)in a picklist
    @name <getyearOptions>
    @param <NA> 
    @return List<SelectOption> 
*/
    public List<SelectOption> getTermOptions(){
        Try{
            List<SelectOption> TermOptions= new List<SelectOption>();
            TermOptions.add(new SelectOption('','-None-'));
            TermOptions.add(new SelectOption('10','10'));
            TermOptions.add(new SelectOption('15','15'));
            TermOptions.add(new SelectOption('20','20'));
            TermOptions.add(new SelectOption('25','25'));
            TermOptions.add(new SelectOption('30','30'));
            return TermOptions;
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
            Return null;
        }
    }
/*
    This method prepares the list of Prefix in a picklist
    @name <getNameOptions>
    @param <NA> 
    @return List<SelectOption> 
*/    
    public List<SelectOption> getNameOptions() {
        Try{
            List<SelectOption> NameOptions= new List<SelectOption>();
            NameOptions.add(new SelectOption('','-None-'));
            NameOptions.add(new SelectOption('Mr','Mr'));
            NameOptions.add(new SelectOption('Mrs','Mrs'));
            NameOptions.add(new SelectOption('Ms','Ms'));
            NameOptions.add(new SelectOption('Dr','Dr'));
            NameOptions.add(new SelectOption('Prof','Prof'));
            return NameOptions;
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
            Return null;
        }
    }
/*
    This method prepares the list of Gender in a picklist
    @name <getGenderOptions>
    @param <NA> 
    @return List<SelectOption> 
*/  
    public List<SelectOption> getGenderOptions() {
        Try{
            List<SelectOption> GenderOptions= new List<SelectOption>();
            GenderOptions.add(new SelectOption('','-None-'));
            GenderOptions.add(new SelectOption('Male','Male'));
            GenderOptions.add(new SelectOption('Female','Female'));       
            return GenderOptions;
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
            Return null;
        }
    }
/*
    This method is the pagereference for backtoresults
    @name <backtoresults>
    @param <Referring to Page apex/ApplyMyInsurance'> 
    @return pageReference
*/      
    public pageReference backtoresults(){
        pageReference pg= new pageReference('/apex/ApplyMyInsuranceui');
        return pg;
    }
/*
    This method will seeresult of the Insurance what installment one has to pay and redirect to apply myInsurance
    @name <seeresult>
    @param <NA> 
    @return pageReference
*/      
    public pageReference seeresult()
        { 
            try{
                Date dob= Date.parse((monthofbirth+'/'+dateofbirth +'/'+yearofbirth).trim());
                integer today = Date.Today().Year(); 
                integer dateofb = dob.Year(); 
                Integer Dobcalculate = today - dateofb ;
                // Checking the criteria for applying the Insurance
                if(Dobcalculate <= 18){
                //displaying error message 
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Age should be greater than equal to 18 years.Enter a Valid Date of Birth')); 
                    return NULL;
                    }   
               /* if(coverageamount < 1000){
                //displaying error message 
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Coverage Amount cannot be leass than 1000')); 
                    return NULL;
                    }      */ 
                                 
                }      
            catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
                }
                pageReference pg= new pageReference('/apex/ApplyMyInsuranceui');
                return pg; 
        }
/*
    This method Calculates the Insurance Value
    @name <getQuote1Amnt>
    @param <NA> 
    @return <Decimal> 
*/  
    public Decimal getQuote1Amnt()
        {
            Decimal quote1=0.0;
            try{
                if(tobacconicotineuse == true){  
                    isTobaccouser = 'Yes';
                    }
                else{isTobaccouser = 'No';
                    }       
                Date dob= Date.parse((monthofbirth+'/'+dateofbirth +'/'+yearofbirth).trim());  
              //  Quote = new QuotePageController().getQuote('My Insurance',String.valueOf(coverageamount), gender ,term.toPlainString() ,'Monthly',rider ,isTobaccouser,dob);
              Quote = new QuotePageController().getQuote('My Insurance', coverageamount, gender ,term.toPlainString() ,'Monthly',rider ,isTobaccouser,dob);
              Quotewithoutrider = new QuotePageController().getQuote('My Insurance', coverageamount, gender ,term.toPlainString() ,'Monthly','No',isTobaccouser,dob);
                System.debug('------Value of Rider----------'+rider);
                if(Quote != '$ 1.0')
                {
                quote1 = Decimal.Valueof(Quotewithoutrider.substring(0,Quotewithoutrider.length()).trim())*1.01;
                         System.debug('This is new------'+quote1);
                }
            }             
            catch(Exception e)
            {
                System.debug('***********'+e.getMessage());
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
            }
                return quote1.SetScale(2);
        }
 /*
    This method gets the Quote Amount
    @name <getQuoteAmnt>
    @param <NA> 
    @return <String> 
*/
    public String getQuoteAmnt(){
        Try{
            if(tobacconicotineuse ==true){ 
            isTobaccouser = 'Yes';
            }
            else{
            isTobaccouser = 'No';
            }    
        //String quote = new QuotePageController().getQuote('My Insurance',leadVar.Coverage_Amount__c.toPlainString(),leadVar.Gender__c,leadVar.Term_Length__c.toPlainString(),'Monthly','No',isTobaccouser,dob);
        //quote = new QuotePageController().getQuote('My Insurance',String.valueOf(coverageamount), gender ,term.toPlainString() ,'Monthly',rider ,isTobaccouser,dob);
            System.debug('This is quote------'+quote);
            return Quote;
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
            Return null;
        }
    }
/*
    This method gets the Quote Amount
    @name <getQuote2Amnt>
    @param <NA> 
    @return <Decimal>
*/    
    public Decimal getQuote2Amnt(){
        try{
            if(tobacconicotineuse ==true){
                isTobaccouser = 'Yes';
            }
            else {isTobaccouser = 'No';
            }    
            //Quote2 = new QuotePageController().getQuote('My Insurance',String.valueOf(coverageamount), gender ,term.toPlainString() ,'Monthly',rider ,isTobaccouser,dob);
            Decimal quote2 = 0.0;
            if(Quote!='$ 1.0'){
                quote2=Decimal.Valueof(Quotewithoutrider.substring(0,Quotewithoutrider.length()).trim())*1.015;
            }
            else{
                quote2=1.2;
            }
            System.debug('This is quote222222------'+quote2);
            return quote2.SetScale(2);
            }             
            catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
            }
                return 1.2;
    }
  /*
      By Himanshu
    This method is the pagereference for Calculating Premium amount for MarkSmith Insurance
    @name <apply>
    @param <NA> 
    @return pageReference
*/    
    
    
  public Decimal getQuote3Amnt(){
        try{
            if(tobacconicotineuse ==true){
                isTobaccouser = 'Yes';
            }
            else {isTobaccouser = 'No';
            }    
            //Quote3 = new QuotePageController().getQuote('My Insurance',String.valueOf(coverageamount), gender ,term.toPlainString() ,'Monthly',rider ,isTobaccouser,dob);
            Decimal quote3 = 0.0;
            if(Quote!='$ 1.0'){
                quote3=Decimal.Valueof(Quotewithoutrider.substring(0,Quotewithoutrider.length()).trim())*1.018;
            }
            else{
                quote3=1.2;
            }
            System.debug('This is quote222222------'+quote3);
            return quote3.SetScale(2);
            }             
            catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
            }
                return 1.2;
    }
    
     /*
      By Himanshu
    This method is the pagereference for Calculating Premium amount for Family Health Plan Insurance
    @name <apply>
    @param <NA> 
    @return pageReference
*/    
    
    
  public Decimal getQuote4Amnt(){
        try{
            if(tobacconicotineuse ==true){
                isTobaccouser = 'Yes';
            }
            else {isTobaccouser = 'No';
            }    
            //Quote4 = new QuotePageController().getQuote('My Insurance',String.valueOf(coverageamount), gender ,term.toPlainString() ,'Monthly',rider ,isTobaccouser,dob);
            Decimal quote4 = 0.0;
            if(Quote!='$ 1.0'){
                quote4=Decimal.Valueof(Quotewithoutrider.substring(0,Quotewithoutrider.length()).trim())*1.019;
            }
            else{
                quote4=1.2;
            }
            System.debug('This is quote222222------'+quote3);
            return quote4.SetScale(2);
            }             
            catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
            }
                return 1.2;
    }
    
/*
    This method is the pagereference for applying Insurance
    @name <apply>
    @param <NA> 
    @return pageReference
*/  
    public pageReference apply(){
        pageReference pg= new pageReference('/apex/ApplyMyInsuranceConfirmui');
        return pg;
    }
/*
    This method is the pagereference for Creating a Lead
    @name <createlead>
    @param <NA> 
    @return pageReference
*/   
    public pageReference createlead(){
        try{
            // Getting the details of the user          
           // dob = Date.valueOf(birth );
            Date dob= Date.parse((monthofbirth+'/'+dateofbirth +'/'+yearofbirth).trim());
            l.FirstName = FirstName ;
            l.LastName = lastName ;
            l.Middle_Name__c= middleName;
            //l.Your_Health__c = YourHealth ;
            l.D_O_B__c =dob;
            l.Salutation=title ;
            l.Gender__c = gender ;
            l.Tobacco_nicotine_use__c =tobacconicotineuse;
            l.Term_Length__c =term ; 
           // l.Coverage_Amount__c = coverageamount;
             l.Coverage__c = coverageamount;
            l.rider__c = riderFlag;
            l.Interest__c= LikeCategory;
            l.Facebook_Profile_URL__c = PhotoURL;
            system.debug(FacebookID);
            l.Facebook_ID__c= FacebookID;
             system.debug(maritalstatus);
            l.Marital_Status__c= maritalstatus;            
            l.City =city ;
            l.State = state;
            l.Country ='USA';
            l.intial_premium__c = Quote;
            //l.PostalCode =Zipcode ;
            //l.Email = Email;
            //l.Phone = Phone;
            l.Product_Interest__c = Label.CL_ProductInterest;
            //l.Product_Interest__c = Label.CL_ProductInterest;
            l.Company = Label.CL_CompanyName;
            l.Reference_Number__c = referencenumber ;
            //l.Weight__c = weight;
            //l.Height__c = height;
             if(String.IsNotBlank(l.PostalCode)){
                String strResponse = getLocationDetails.getLocation(l.PostalCode);            
                if(String.IsNotBlank(strResponse) ){
                    l.City = strResponse.Split(',')[0];
                    l.State = strResponse.Split(',')[1]; 
                }                
            }
            
            //leadVar.First_Name__c =leadVar.FirstName;
            //leadVar.Last_Name__c=leadVar.LastName;
            insert l;
        }      
        catch(Exception e)  {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
        }
        pageReference pg= new pageReference('/apex/ApplyMyInsuranceThanksui');
            return pg; 
        }
 /*
    This method which tells what all the Insurance Cover.
    @name <addcover>
    @param <NA> 
    @return <NA>
*/         
    public void addcover(){
        Try{
            rider = 'Critical Illness';
            riderFlag = true;
            isCoverButtonDisabled = true;
            levelterm =true;
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
        }
    }
/*
    This method which tells what all the Insurance if one removes the Cover.
    @name <removecover>
    @param <NA> 
    @return <NA>
*/ 
    public void removecover(){
        Try{
            rider= NULL;
            riderFlag = false;
            isCoverButtonDisabled = false;
            levelterm =true;
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
        }
    }
/*
    This method tells the total amount the one has to pay including the cover charge.
    @name <addcovergaeamount>
    @param <NA> 
    @return <NA>
*/  
   
    public void addcovergaeamount(){
        Try{
            /* coverageamount = coverageamount+10000 ;*/
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
        }
    }
/*
    This method tells the total amount the one has to pay Excluding the cover charge.
    @name <subcovergaeamount>
    @param <NA> 
    @return <NA>
*/  
    
   public void subcovergaeamount(){
        Try{
           /* coverageamount = coverageamount-10000 ;*/
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
        }
    }
/*
    This method tells Norms of the Insurance.
    @name <addterm>
    @param <NA> 
    @return <NA>
*/  
    
    public void addterm(){
        Try{
            if(term==30){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,'Term cannot be more than 30 years')); 
            }else{
                term =term+5 ;
            }
        }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
        }
    }
/*
    This method tells Subterms .
    @name <subterm>
    @param <NA> 
    @return <NA>
*/  
    
    public void subterm(){
        Try{
            if(term==10){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Term cannot be less than 10 years')); 
                }
            else{
                term =term-5 ;
                }
            }
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check the data. Contact your administrator for more information')); 
        }   
    }
        
/*
    This method Return default as null value.
    @name <updatecovgAmount>
    @param <NA> 
    @return <String>
*/ 
    public String updatecovgAmount(){
            return NULL;
        }
    Public PageReference BackconfirmApplInsu(){
        return new pagereference('http://myinsurance.force.com/ApplyMyInsuranceui');
      }
        
}