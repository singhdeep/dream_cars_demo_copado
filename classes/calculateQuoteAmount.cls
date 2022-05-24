public class calculateQuoteAmount{

    public static decimal calculateQuote(Integer age,String selectedSumInsured,String gender,Integer term, String isTobaccoUser){
        System.debug('age==' + age);
        System.debug('selectedSumInsured==' + selectedSumInsured);
        System.debug('gender==' + gender);
        System.debug('term==' + term);
        System.debug('isTobaccoUser==' + isTobaccoUser);
        
        String strTobaccoUser = 'Non Smoker';
        if(String.IsNotBlank(isTobaccoUser) && isTobaccoUser.equalsignorecase('yes')){
            strTobaccoUser = 'Smoker';
        }
        System.debug('strTobaccoUser ==' + strTobaccoUser );
        System.debug('Himanshu Jenkins Commit 2 - Test Gerrit -- HB Changed-- For demo');
       
                                                
        List<Premium_Calculation__c> matchedRecord = [select Value__c from Premium_Calculation__c where 
                Age_Upper__c >=: age and Age_Lower__c <=: age  and Coverage__c =:selectedSumInsured 
                  and Gender__c =: gender and Nicotine__c =: strTobaccoUser and Term__c =: term];
        Decimal amount = 10.00;
        if(matchedRecord.size()>0)
            amount = matchedRecord[0].value__c;
            
        return amount;
    }
    
}