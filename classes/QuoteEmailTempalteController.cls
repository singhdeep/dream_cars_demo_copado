public without sharing class QuoteEmailTempalteController {
  public Lead leadobj {get;set;}
  public Quote lquotes {get;set;}
   
    public QuoteEmailTempalteController() {
        lquotes = New Quote();
        String OppId = apexpages.currentpage().getparameters().get('id'); 
        lquotes = [Select id,Account.PersonEmail,Opportunity.Name,Recommended_Rider__c, account.name, Payment_Term__c,Premium__c, Product__c, Rider__c, Sum_Insured__c, Term_Length__c, Tobacco_Nicotine__c from Quote where OpportunityId = :OppId Order by QuoteNumber desc limit 1] ;
        String email = lquotes.Account.PersonEmail;
    } 
       public String getTobacco(){
           string tob;
            if(lquotes.Tobacco_Nicotine__c == true){
                tob = 'Yes';
                }
            else{
               tob = 'No';
                }
            return tob;
     }
}