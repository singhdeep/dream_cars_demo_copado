/***************************************************************************************************************************
########################################################################################
Project Name..........: <Solar Turbines>
File..................: <Account_SSController >
Version...............: <1.0>
Created by............: <Sibasish Samal>
Created Date..........: <27/03/2017>
Last Modified by......: <Infosys Technologies>
Email.................: <Sibasish_Samal@infosys.com>
Last Modified Date....: 
Description...........: <Controller class for Account Sales Strategy>
History...............: 
######################################################################################### 
******************************************************************************************************************************/
public with sharing class Account_SSController {
  
    User loggedInUser;
    string accId;
    
/*  
* Author     : Sibasish Samal
* 
* Constructor
* 
*/
    public Account_SSController (ApexPages.StandardController stdCtrl) {
       this(stdCtrl, true);
    }
    
/*  
* Author     : Sibasish Samal
* 
* Constructor
* 
*/
    public Account_SSController (ApexPages.StandardController stdCtrl, Boolean ssl){ 
        accId = ApexPages.currentPage().getParameters().get('id');
       // loggedInUser= [select Business_Unit__c from user where Id=:UserInfo.getUserId() limit 1];
    }

/*  
* Author     : Sibasish Samal
* 
* redirectOpp : To redirect to Account Sales Strategy based on Business Unit
* 
*/
    
}