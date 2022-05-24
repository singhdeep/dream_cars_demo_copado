global Class GenerateXMLforALIPFinal
     {
        public static String sendRequesttoALIP(String PolicyId){    
        try{            
             Policy__c policy = [SELECT Account_Name__c,CreatedById,CreatedDate,Id,Initial_Premium_Payment__c,IsDeleted,
                             LastModifiedById,LastModifiedDate,Mode_Of_Payment__c,
                                     Name,OwnerId,Policy_End_Date__c,Policy_Start_Date__c,Product__c,Quote_Name__c,
                                                 SystemModstamp,Tax_Qualification_Status__c FROM Policy__c WHERE ID=:PolicyId LIMIT 1];  
                                                 
             Quote quote = [SELECT AccountId,AdditionalAddress,AdditionalCity,AdditionalCountry,AdditionalLatitude,
                           AdditionalLongitude,AdditionalName,AdditionalPostalCode,AdditionalState,AdditionalStreet,
                               BillingAddress,BillingCity,BillingCountry,BillingLatitude,BillingLongitude,BillingName,
                                   BillingPostalCode,BillingState,BillingStreet,ContactId,ContractId,CreatedById,
                                       CreatedDate,Description,Discount,Email,ExpirationDate,Fax,GrandTotal,Id,IsDeleted,
                                           IsSyncing,LastModifiedById,LastModifiedDate,
                                               LineItemCount,Name,OpportunityId,Payment_Term__c,Phone,Premium__c,
                                                   Pricebook2Id,Product__c,QuoteNumber,QuoteToAddress,QuoteToCity,
                                                       QuoteToCountry,QuoteToLatitude,QuoteToLongitude,QuoteToName,
                                                           QuoteToPostalCode,QuoteToState,QuoteToStreet,Rider__c,ShippingAddress,
                                                               ShippingCity,ShippingCountry,ShippingHandling,ShippingLatitude,ShippingLongitude,
                                                                   ShippingName,ShippingPostalCode,ShippingState,ShippingStreet,Status,Subtotal,
                                                                       Sum_Insured__c,Sum_Insured_Amount__c,SystemModstamp,Tax,Term_Length__c,Tobacco_Nicotine__c,
                                                                           TotalPrice FROM Quote WHERE ID=:policy.Quote_Name__c LIMIT 1]; 
             Account acc = [SELECT AccountSource,AnnualRevenue,BillingAddress,BillingCity,BillingCountry,BillingLatitude,BillingLongitude,
                                     BillingPostalCode,BillingState,BillingStreet,Birth_Date__c,Children__c,CreatedById,CreatedDate,Description,
                                             Distribution__c,Facebook_ID__c,Fax,FirstName,Gender__c,Id,Industry,IsDeleted,IsPersonAccount,Jigsaw,
                                                 JigsawCompanyId,LastActivityDate,LastModifiedById,LastModifiedDate,LastName,
                                                         Marital_Status__c,MasterRecordId,Name,NumberOfEmployees,Occupation__c,
                                                                 OwnerId,ParentId,PersonAssistantName,PersonAssistantPhone,PersonBirthdate,PersonContactId,
                                                                     PersonDepartment,PersonEmail,PersonEmailBouncedDate,PersonEmailBouncedReason,
                                                                         PersonHomePhone,PersonLastCURequestDate,PersonLastCUUpdateDate,PersonLeadSource,
                                                                             PersonMailingAddress,PersonMailingCity,PersonMailingCountry,PersonMailingLatitude,
                                                                                 PersonMailingLongitude,PersonMailingPostalCode,PersonMailingState,
                                                                                     PersonMailingStreet,PersonMobilePhone,PersonOtherAddress,PersonOtherCity,
                                                                                         PersonOtherCountry,PersonOtherLatitude,PersonOtherLongitude,PersonOtherPhone,
                                                                                             PersonOtherPostalCode,PersonOtherState,PersonOtherStreet,PersonTitle,Phone,PhotoUrl,
                                                                                                 Primary_Beneficiary__c,ProspectProfilePictureDocId__c,RecordTypeId,Relationship__c,
                                                                                                     Salutation,ShippingAddress,ShippingCity,ShippingCountry,ShippingLatitude,
                                                                                                         ShippingLongitude,ShippingPostalCode,ShippingState,ShippingStreet,SicDesc,
                                                                                                             Social_Security_Number__c,SystemModstamp,Tobacco_Nicotine_Use__c,Type,Type__c,US_Citizen__c,
                                                                                                                 Website,Your_Health__c,Tax_ID__c,Weight__c,Height__c FROM Account WHERE IsPersonAccount = true AND ID=:policy.Account_Name__c LIMIT 1];   
                                                                                                                                                                                                                                                            
         
          String flagTobaccoUseText = 'No';
          String flagTobaccoUseAttribute = 'no';  
            if(quote.Tobacco_Nicotine__c){
            flagTobaccoUseText = 'Yes';
            flagTobaccoUseAttribute = 'yes';
            }else{
            flagTobaccoUseText = 'No';
            flagTobaccoUseAttribute = 'no';
            }

          String flagUsCitizenText = 'No';
          String flagUsCitizenAttribute = 'no';          
              if(acc.US_Citizen__c){
                  flagUsCitizenText = 'Yes';
                  flagUsCitizenAttribute = 'yes';
              }
                    
         String street1 = acc.BillingStreet;
         DateTime dT = System.now();
         String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
         //String servicePrefix ='typ';
         String serviceNS = null;//
         //String ServiceNSType = 'http://alip.accenture.com/types';
          
         // Create the request envelope
            DOM.Document doc = new DOM.Document();
            dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
              //envelope.setNamespace(servicePrefix, serviceNS);
            envelope.addChildElement('Header', soapNS, null);
            dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
            dom.XmlNode applicationSaveFlowIn = body.addChildElement('ApplicationSaveFlowIn', serviceNS, null);
                applicationSaveFlowIn.setAttribute('xmlns','http://alip.accenture.com/types');
            dom.XmlNode payLoad = applicationSaveFlowIn.addChildElement('payload', serviceNS, null);
            dom.XmlNode applicationDetail = payLoad.addChildElement('ApplicationDetail', serviceNS, null);  
            applicationDetail.addChildElement('TotalAnnPrem', serviceNS, null).addTextNode(policy.Initial_Premium_Payment__c != null ? policy.Initial_Premium_Payment__c.format() : '0.0');  
            applicationDetail.addChildElement('ContractDurationYear', serviceNS, null).addTextNode('10');
            dom.XmlNode billingPremiumModeNew = applicationDetail.addChildElement('BillingPremiumMode', serviceNS, null);
               billingPremiumModeNew.setAttribute('code','M');
               billingPremiumModeNew.addTextNode('Monthly');        
                
            dom.XmlNode billing = applicationDetail.addChildElement('Billing', serviceNS, null);
            //dom.XmlNode billingPremiumMode = billing.addChildElement('BillingPremiumMode', serviceNS, null);
                //billingPremiumMode.setAttribute('code','M');
                //billingPremiumMode.addTextNode('Monthly');
                billing.addChildElement('MaturityAtAttainedAge', serviceNS, null).addTextNode('50');
                billing.addChildElement('BillingLeadTime', serviceNS, null).addTextNode('10'); //quote.Term_Length__c.format()                
                dom.XmlNode howBillPremium = billing.addChildElement('HowBillPremium', serviceNS, null);
                    howBillPremium.setAttribute('code','1');
                    howBillPremium.addTextNode('Direct');
                    //howBillPremium.addTextNode(policy.Initial_Premium_Payment__c.format());

                //Create dom for applicationdetail
                applicationDetail.addChildElement('BaseFaceUnits', serviceNS, null).addTextNode(String.ValueOf(quote.Sum_Insured_Amount__c));
                applicationDetail.addChildElement('TotalAmountAtRisk', serviceNS, null).addTextNode(String.ValueOf(quote.Sum_Insured_Amount__c));
                applicationDetail.addChildElement('PolicyDate', serviceNS, null).addTextNode(dT.format('yyyyMMdd'));
                applicationDetail.addChildElement('AppDate', serviceNS, null).addTextNode(dT.format('yyyyMMdd'));
            Dom.XmlNode applicationState = applicationDetail.addChildElement('ApplicationState', serviceNS, null);
                 applicationState.setAttribute('code', (String.IsNotBlank(acc.BillingState) ? acc.BillingState: ''));
                 applicationState.addTextNode((String.IsNotBlank(acc.BillingState) ? acc.BillingState: '')); 
            Dom.XmlNode contractState = applicationDetail.addChildElement('ContractState', serviceNS, null);
                contractState.setAttribute('code', (String.IsNotBlank(acc.BillingState) ? acc.BillingState: ''));
                contractState.addTextNode((String.IsNotBlank(acc.BillingState) ? acc.BillingState: ''));  
            Dom.XmlNode residentState = applicationDetail.addChildElement('ResidentState', serviceNS, null);
                residentState.setAttribute('code', (String.IsNotBlank(acc.BillingState) ? acc.BillingState: ''));
                residentState.addTextNode((String.IsNotBlank(acc.BillingState) ? acc.BillingState: '')); 
            Dom.XmlNode isNetCommApplicable= applicationDetail.addChildElement('IsNetCommApplicable', serviceNS, null);
                isNetCommApplicable.setAttribute('code', 'no');
                isNetCommApplicable.addTextNode('No');  
            Dom.XmlNode distChannel = applicationDetail.addChildElement('DistributionChannel', serviceNS, null);
                distChannel.setAttribute('code', '0');
                distChannel.addTextNode('Default');  
            Dom.XmlNode ownerSameAs = applicationDetail.addChildElement('OwnerSameAs',serviceNS,null);
                ownerSameAs.setAttribute('code', 'yes');
                ownerSameAs.addTextNode('Yes');        
            applicationDetail.addChildElement('SubstandardTableRating',serviceNS,null).addTextNode('2');
            Dom.XmlNode repReplaceLifeAnnuityContracts= applicationDetail.addChildElement('RepReplaceLifeAnnuityContracts',serviceNS,null);
                repReplaceLifeAnnuityContracts.setAttribute('code', 'no');
                repReplaceLifeAnnuityContracts.addTextNode('No');                                
            Dom.XmlNode benefInd = applicationDetail.addChildElement('BeneficiaryIndicator',serviceNS,null);
                benefInd.setAttribute('code', 'no');
                benefInd.addTextNode('No');
            dom.XmlNode agentPreferences = applicationDetail.addChildElement('AgentPreferences', serviceNS, null);
                agentPreferences.addChildElement('SystemParaMed', serviceNS, null).addTextNode('Yes');
                agentPreferences.addChildElement('SystemAPS', serviceNS, null).addTextNode('Yes');
                agentPreferences.addChildElement('SystemRequirementInd', serviceNS, null).addTextNode('Yes');
                applicationDetail.addChildElement('ContractCountry', serviceNS, null).addTextNode('USA');
                applicationDetail.addChildElement('ProductName', serviceNS, null).addTextNode('Level Term');
           
             //Start Client 1
            dom.XmlNode client1 = payLoad.addChildElement('Client', serviceNS, null);
            dom.XmlNode relation = client1.addChildElement('Relation',serviceNS, null);
                relation.setAttribute('code','Owner');
                relation.addTextNode('Owner'); 
            dom.XmlNode cRMDetails = client1.addChildElement('CRMDetails',serviceNS, null);
            dom.XmlNode address = cRMDetails.addChildElement('Address', serviceNS, null);
                address.addChildElement('Address1', serviceNS, null).addTextNode(String.IsnotBlank(street1) ?street1 : '');
            dom.XmlNode state = address.addChildElement('State', serviceNS, null); 
                state.setAttribute('code', (String.IsNotBlank(acc.BillingState) ? acc.BillingState: ''));
                state.addTextNode( (String.IsNotBlank(acc.BillingState) ? acc.BillingState: ''));
                address.addChildElement('City', serviceNS, null).addTextNode((String.IsNotBlank(acc.BillingCity)? acc.BillingCity :  ''));
                address.addChildElement('PostalCode', serviceNS, null).addTextNode(String.IsNotBlank(acc.BillingPostalCode) ? acc.BillingPostalCode : '');
                address.addChildElement('Country', serviceNS, null).addTextNode((String.IsNotBlank(acc.BillingCountry) ? acc.BillingCountry : ''));
            dom.XmlNode addressType2 =  address.addChildElement('AddressType', serviceNS, null);
               addressType2.setAttribute('code','1');
               addressType2.addTextNode('1');
               cRMDetails.addChildElement('EmailAddress',serviceNS, null).addTextNode((String.IsNotBlank(acc.PersonEmail) ? acc.PersonEmail : ''));
               cRMDetails.addChildElement('TaxID',serviceNS, null).addTextNode((String.IsNotBlank(acc.Tax_ID__C) ? acc.Tax_ID__C : ''));
               cRMDetails.addChildElement('CellPhone',serviceNS, null).addTextNode((String.IsNotBlank(acc.Phone) ? acc.Phone : ''));
               cRMDetails.addChildElement('LastName',serviceNS, null).addTextNode(acc.LastName);
               cRMDetails.addChildElement('FirstName',serviceNS, null).addTextNode(acc.FirstName);
               dom.XmlNode gender = cRMDetails.addChildElement('Gender',serviceNS, null);
                      String genderCode = '1';
                        if (acc.Gender__c == 'Female'){
                                genderCode = '2';
                           }
                   gender.setAttribute('code', genderCode);
                   gender.addTextNode(acc.Gender__c);
               Datetime dob_local = acc.Birth_Date__c;
               cRMDetails.addChildElement('DOB',serviceNS, null).addTextNode(dob_local.format('yyyyMMdd'));
                 String heightFtIn = '5';
                 if(acc.Height__c != null){
                     Decimal height = acc.Height__c;
                     System.debug('height====='+height);
                     Integer ht = height.intValue();
                     Decimal Ft = height.divide(12,2);
                     String feet = String.valueof(Ft.intValue());
                     String inches = String.valueof(math.mod(ht,12));
                            If(inches.length()<2)
                                {
                                    inches = '0'+inches;
                                }
                        heightFtIn = feet + inches;
                 }  
                
                cRMDetails.addChildElement('Height',serviceNS, null).addTextNode(heightFtIn);
                cRMDetails.addChildElement('Weight',serviceNS, null).addTextNode((acc.Weight__c != null ? acc.Weight__c.format(): '65'));
            dom.XmlNode uscitizen = cRMDetails.addChildElement('USCitizenInd',serviceNS, null);
             uscitizen.setAttribute('code',flagUsCitizenAttribute);
             uscitizen.addTextNode(flagUsCitizenText);
             cRMDetails.addChildElement('W8_Status',serviceNS, null).addTextNode('No');
            dom.XmlNode type1 = cRMDetails.addChildElement('Type',serviceNS, null);
            type1.setAttribute('code', 'Individual');
            type1.addTextNode('Individual');
             dom.XmlNode appDetails1 = client1.addChildElement('AppDetails', serviceNS, null);
             dom.XmlNode search1 = appDetails1.addChildElement('Search',serviceNS,null);
                search1.addChildElement('AllClientsInd',serviceNS,null).addTextNode('Yes');
            Dom.XmlNode indicator2 = search1.addChildElement('Indicator',serviceNS,null);
                indicator2.setAttribute('code', 'no');
                indicator2.addTextNode('No');
                appDetails1.addChildElement('Sequence',serviceNS,null).addTextNode('1');
            dom.XmlNode policyRole1 = client1.addChildElement('PolicyRole', serviceNS, null);
            dom.XmlNode relationship2 = policyRole1.addChildElement('Relationship', serviceNS, null);
                relationship2.setAttribute('code','62');
                relationship2.addTextNode('Self'); 
        
            //Start Client 2
            dom.XmlNode client2 = payLoad.addChildElement('Client', serviceNS, null);
            dom.XmlNode appDetails2 = client2.addChildElement('AppDetails', serviceNS, null);
            dom.XmlNode search2 = appDetails2.addChildElement('Search',serviceNS,null);
                search2.addChildElement('AllClientsInd',serviceNS,null).addTextNode('Yes');
            Dom.XmlNode indicator3 = search2.addChildElement('Indicator',serviceNS,null);
                indicator3.setAttribute('code', 'no');
                indicator3.addTextNode('No');      
                appDetails2.addChildElement('Sequence',serviceNS,null).addTextNode('1');        
                dom.XmlNode underwriting = appDetails2.addChildElement('Underwriting',serviceNS,null);
                Dom.XmlNode avocation= underwriting.addChildElement('Avocation',serviceNS,null);        
                    avocation.setAttribute('code', 'no');
                    avocation.addTextNode('No');    
                Dom.XmlNode Driving= underwriting.addChildElement('Driving',serviceNS,null);        
                    Driving.setAttribute('code', 'no');
                    Driving.addTextNode('No');
                Dom.XmlNode medOrTreatment= underwriting.addChildElement('MedOrTreatment',serviceNS,null);        
                    medOrTreatment.setAttribute('code', 'no');
                    medOrTreatment.addTextNode('No');                    
                Dom.XmlNode dUI= underwriting.addChildElement('DUI',serviceNS,null);        
                    dUI.setAttribute('code', 'no');
                    dUI.addTextNode('No');
                Dom.XmlNode tobaccoUse = underwriting.addChildElement('TobaccoUse',serviceNS,null);        
                    tobaccoUse.setAttribute('code', flagTobaccoUseAttribute);
                    tobaccoUse.addTextNode(flagTobaccoUseText);
                Dom.XmlNode HIV= underwriting.addChildElement('HIV',serviceNS,null);        
                    HIV.setAttribute('code', 'no');
                    HIV.addTextNode('No');
                Dom.XmlNode BP= underwriting.addChildElement('BP',serviceNS,null);        
                    BP.setAttribute('code', 'no');
                    BP.addTextNode('No');
                Dom.XmlNode mentalPhysicalDisorder= underwriting.addChildElement('MentalPhysicalDisorder',serviceNS,null);        
                    mentalPhysicalDisorder.setAttribute('code', 'no');
                    mentalPhysicalDisorder.addTextNode('No');
                Dom.XmlNode Alcohol= underwriting.addChildElement('Alcohol',serviceNS,null);        
                    Alcohol.setAttribute('code', 'no');
                    Alcohol.addTextNode('No');    
                Dom.XmlNode FamilyHistory= underwriting.addChildElement('FamilyHistory',serviceNS,null);        
                    FamilyHistory.setAttribute('code', 'no');
                    FamilyHistory.addTextNode('No');
                Dom.XmlNode FlyingActivity= underwriting.addChildElement('FlyingActivity',serviceNS,null);        
                    FlyingActivity.setAttribute('code', 'no');
                    FlyingActivity.addTextNode('No');

            dom.XmlNode relation2 = client2.addChildElement('Relation',serviceNS, null);
                relation2.setAttribute('code','Primary');
                relation2.addTextNode('Primary');
            dom.XmlNode wasSearched = client2.addChildElement('WasSearched',serviceNS, null); 
                wasSearched.setAttribute('code','no');
                wasSearched.addTextNode('No');
                client2.addChildElement('Insured',serviceNS,null).addTextNode('Yes');
            dom.XmlNode cRMDetail2 = client2.addChildElement('CRMDetails',serviceNS, null);
            dom.XmlNode address2 = cRMDetail2.addChildElement('Address', serviceNS, null);
                address2.setAttribute('validate','true');
                address2.addChildElement('Address1', serviceNS, null).addTextNode(String.IsNotBlank(street1)?street1:'');
            dom.XmlNode state2 = address2.addChildElement('State', serviceNS, null);
                 state2.setAttribute('code',(String.IsNotBlank(acc.BillingState) ? acc.BillingState: ''));
                 state2.addTextNode((String.IsNotBlank(acc.BillingState) ? acc.BillingState: ''));
                 address2.addChildElement('City', serviceNS, null).addTextNode((String.IsNotBlank(acc.BillingCity) ? acc.BillingCity : ''));
                 address2.addChildElement('PostalCode', serviceNS, null).addTextNode((String.IsNotBlank(acc.BillingPostalCode) ? acc.BillingPostalCode : ''));
            dom.XmlNode addressType3 =  address2.addChildElement('AddressType', serviceNS, null);
                addressType3.setAttribute('code','1');
                addressType3.addTextNode('1');
                address2.addChildElement('Country', serviceNS, null).addTextNode((String.IsNotBlank(acc.BillingCountry) ? acc.BillingCountry : 'USA'));
                cRMDetail2.addChildElement('EmailAddress',serviceNS, null).addTextNode((String.IsNotBlank(acc.PersonEmail)? acc.PersonEmail : '' ));
                cRMDetail2.addChildElement('TaxID',serviceNS, null).addTextNode((String.IsNotBlank(acc.Tax_ID__C) ? acc.Tax_ID__C : ''));
                cRMDetail2.addChildElement('CellPhone',serviceNS, null).addTextNode((String.IsNotBlank(acc.Phone) ? acc.Phone : ''));
                cRMDetail2.addChildElement('LastName',serviceNS, null).addTextNode(acc.LastName);
                cRMDetail2.addChildElement('FirstName',serviceNS, null).addTextNode(acc.FirstName);
            dom.XmlNode gender2 = cRMDetail2.addChildElement('Gender',serviceNS, null);
                    String genderCode2 = '1';
                       if (acc.Gender__c == 'Female'){
                                genderCode2 = '2';
                                }
                    gender2.setAttribute('code', genderCode2);
                    gender2.addTextNode(acc.Gender__c);
                    Datetime dob_local2 = acc.Birth_Date__c;
                    cRMDetail2.addChildElement('DOB',serviceNS, null).addTextNode(dob_local2.format('yyyyMMdd'));
                    cRMDetail2.addChildElement('Height',serviceNS, null).addTextNode(heightFtIn); //heightFtIn
                    cRMDetail2.addChildElement('Weight',serviceNS, null).addTextNode((acc.Weight__c != null ? acc.Weight__c.format(): '65'));
                    dom.XmlNode uscitizen2 = cRMDetail2.addChildElement('USCitizenInd',serviceNS, null);
                        uscitizen2.setAttribute('code','yes');
                        uscitizen2.addTextNode('Yes');
                   cRMDetail2.addChildElement('W8_Status',serviceNS, null).addTextNode('No');
                
            //Client 3
            dom.XmlNode client3 = payLoad.addChildElement('Client', serviceNS, null);
            dom.XmlNode relation3 = client3.addChildElement('Relation', serviceNS, null);
                relation3.setAttribute('code', 'Agent');
                relation3.addTextNode('Agent');
                client3.addChildElement('ID', serviceNS, null).addTextNode('35');
                client3.addChildElement('Insured', serviceNS, null).addTextNode('No');
                client3.addChildElement('Percent', serviceNS, null).addTextNode('100');
            dom.XmlNode agentDetails3 = client3.addChildElement('AgentDetails', serviceNS, null);
                agentDetails3.addChildElement('WritingCode', serviceNS, null).addTextNode('VL730');
                agentDetails3.addChildElement('CommissionPercentage', serviceNS, null).addTextNode('100');
            dom.XmlNode crmDetails3 = client3.addChildElement('CRMDetails', serviceNS, null);
            dom.XmlNode type4 = crmDetails3.addChildElement('Type', serviceNS, null);
                type4.setAttribute('code', 'Individual');
                type4.addTextNode('Individual');
                crmDetails3.addChildElement('FirstName', serviceNS, null).addTextNode('Lisa');
                crmDetails3.addChildElement('LastName', serviceNS, null).addTextNode('Spencer');
        
            //App Source
            payLoad.addChildElement('AppSource', serviceNS, null).addTextNode('SalesForce');
        
            //User
            dom.XmlNode user = payLoad.addChildElement('User', serviceNS, null);
            dom.XmlNode current = user.addChildElement('Current', serviceNS, null);
                current.addChildElement('UserLogin', serviceNS, null).addTextNode('SUPERVIS');
                current.addChildElement('UserType', serviceNS, null).addTextNode('SU');        
            dom.XmlNode creator = user.addChildElement('Creator', serviceNS, null);
                creator.addChildElement('UserLogin', serviceNS, null).addTextNode('SUPERVIS');
                creator.addChildElement('UserType', serviceNS, null).addTextNode('SU');
        
            //AppType and AppStatus
                payLoad.addChildElement('AppType', serviceNS, null).addTextNode('Original');
                payLoad.addChildElement('AppStatus', serviceNS, null).addTextNode('Incomplete');
        
            //ApplicationSummary
            dom.XmlNode applicationSummary = payLoad.addChildElement('ApplicationSummary', serviceNS, null);
                applicationSummary.addChildElement('ProductID', serviceNS, null).addTextNode('076');
                applicationSummary.addChildElement('SystemID', serviceNS, null).addTextNode('8');
        
            //Product
            dom.XmlNode prod = payLoad.addChildElement('Product', serviceNS, null);
            dom.XmlNode prodID = prod.addChildElement('ProductID', serviceNS, null);
                prodID.setAttribute('code', '246');
                prodID.addTextNode('246');
                prod.addChildElement('ProductType', serviceNS, null).addTextNode('Term');
            dom.XmlNode prodTypeId = prod.addChildElement('ProductTypeID', serviceNS, null);
                prodTypeId.setAttribute('code','2');
                prodTypeId.addTextNode('2');
                prod.addChildElement('ProductCurrency', serviceNS, null).addTextNode('USD');
                prod.addChildElement('LineOfBusiness', serviceNS, null).addTextNode('Life - Both');
                prod.addChildElement('IsTrad', serviceNS, null).addTextNode('true');
                prod.addChildElement('IsNonTradLife', serviceNS, null).addTextNode('false');
                prod.addChildElement('RequiredPremium', serviceNS, null).addTextNode('true');
                prod.addChildElement('SystemID', serviceNS, null).addTextNode('8');
                prod.addChildElement('RemoteID', serviceNS, null).addTextNode('860');
            dom.XmlNode prodName = prod.addChildElement('ProductName', serviceNS, null);
                prodName.setAttribute('code', 'Level Term');
                prodName.addTextNode('Term Life SFDC');       
                prod.addChildElement('ProductDesc', serviceNS, null).addTextNode('Term Life Insurance');
            dom.XmlNode tempProdID = prod.addChildElement('TempProductID', serviceNS, null);
                    tempProdID.setAttribute('code', '246');
                    tempProdID.addTextNode('Term Life SFDC');
        
          //ResultSet
            dom.XmlNode resultSet = payLoad.addChildElement('ResultSet', serviceNS, null);
            dom.XmlNode workflowNavigation = resultSet.addChildElement('WorkflowNavigation', serviceNS, null);
                workflowNavigation.addChildElement('ComingFrom', serviceNS, null).addTextNode('E-SERVICE');
                workflowNavigation.addChildElement('UserDestinationURL', serviceNS, null).addTextNode('');
            dom.XmlNode basePlanType = workflowNavigation.addChildElement('BasePlanType', serviceNS, null);
                basePlanType.setAttribute('code', '2');
                basePlanType.addTextNode('2'); 
        
                System.debug('Request XML:**********' + doc.toXmlString());     
                
                String resp = '';
                Http h = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint('https://alip-ext.asw.accenture.com/dpidemo/servlet/rules');
                Blob headerValue = Blob.valueOf('RAGENT' + ':' + '123456');
                String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
                request.setHeader('Authorization', authorizationHeader);
                request.setHeader('Content-Type', 'text/xml; charset=utf-8');
                request.setMethod('POST');
                request.setBodyDocument(doc);
                HttpResponse response = h.send(request);
                system.debug('======response1=save==='+ response.getbody());
                
                /*Dom.Document resDoc = response.getBodyDocument();
                System.debug('resDoc ==' + resDoc );
                Dom.XMLNode rootNode= resDoc.getRootElement();
                
                for(Dom.XMLNode child : rootNode.getChildElements()){
                    system.debug('child==' + child.getName());
                    system.debug('child==' + child.getNamespace());
                    
                    system.debug('==child==application==' + child.getChildElement('ApplicationSubmitFlowIn', null));
                    system.debug('==child==application12==' + child.getChildElement('ApplicationSubmitFlowIn', 'soapenv'));
                }
                
                Dom.XMLNode bodyNode = rootNode.getChildElement('Body', rootNode.getNamespace());                
                System.debug('bodyNode ==' + bodyNode );
                //Dom.XMLNode applicationNode = bodyNode.getChildElement('ApplicationSubmitFlowIn', null);                
                for(Dom.XMLNode child : bodyNode.getChildElements()){
                    system.debug('child==' + child.getName());
                    system.debug('child type==' + child.getNamespace());
                    system.debug('==child==application1==' + child.getChildElement('ApplicationSaveFlowOut', child.getNamespace()));
                    system.debug('==child==application2==' + child.getChildElement('ApplicationSaveFlowOut', null));
                    system.debug('==child==application3==' + child.getChildElement('ApplicationSaveFlowOut', 'soapenv'));
                }
                Dom.XMLNode applicationNode = bodyNode.getChildElement('ApplicationSaveFlowOut', 'http://alip.accenture.com/types');                
                System.debug('applicationNode===' + applicationNode );
                Dom.XMLNode paramsNode= applicationNode.addChildElement('params', serviceNS, null);
                Dom.XMLNode paramNode= paramsNode.addChildElement('param', serviceNS, null);
                paramsNode.addChildElement('name', serviceNS, null).addTextNode('PersistenceProvider');
                paramsNode.addChildElement('value', serviceNS, null).addTextNode('ApplicationSave');                
                */
                
                /*Dom.Document doc2 = response.getBodyDocument();
                //Retrieve the root element for this document.
                Dom.XMLNode appRoot = doc2.getRootElement();
                Dom.XmlNode appBody = appRoot.getChildElement('Body',soapNS);
                Dom.XmlNode appSaveFlowOut = appBody.getChildElement('ApplicationSaveFlowOut','http://alip.accenture.com/types');
                //String applicationId = appSaveFlowOut.getChildElement('AppID', serviceNS).getText();
                System.debug('appSaveFlowOut===' + appSaveFlowOut);
                */
                String xmlString = response.getBody();
                String strSaveOut1 = '<ApplicationSaveFlowOut xmlns="http://alip.accenture.com/types">';
                String strSubmitIn1 = '<ApplicationSubmitFlowIn xmlns="http://alip.accenture.com/types"> <payload> ';
                
                String strSaveOut2 = '</ApplicationSaveFlowOut></soapenv:Body>';
                String strSubmitIn2 = '</payload><params> <param> <name>PersistenceProvider</name><value>ApplicationSave</value> </param> </params> </ApplicationSubmitFlowIn></soapenv:Body>';
                
                String strXmlSubmit = xmlString.replace(strSaveOut1, strSubmitIn1).replace(strSaveOut2, strSubmitIn2);
            
                System.debug('======strXmlSubmit===' + strXmlSubmit);
                DOM.Document submitDoc = new DOM.Document();
                submitDoc.load(strXmlSubmit);
                
                
                Http h2 = new Http();
                HttpRequest request2 = new HttpRequest();
                request2.setEndpoint('https://alip-ext.asw.accenture.com/dpidemo/servlet/rules');
                
                //Blob headerValue2 = Blob.valueOf('RAGENT' + ':' + '123456');
                //String authorizationHeader2 = 'BASIC ' + EncodingUtil.base64Encode(headerValue2);
                //request2.setHeader('Authorization', authorizationHeader2);
                request2.setHeader('Authorization', authorizationHeader);
                request2.setHeader('Content-Type', 'text/xml; charset=utf-8');
                request2.setMethod('POST');
                request2.setBodyDocument(submitDoc);
                HttpResponse response2 = h2.send(request2);
                system.debug('response1=submit==='+ response2.getbody());
                
                
                Dom.Document doc2 = response2.getBodyDocument();
                Dom.XMLNode appRoot = doc2.getRootElement();
                Dom.XmlNode appBody = appRoot.getChildElement('Body',soapNS);
                Dom.XmlNode appSubmitFlowOut= appBody.getChildElement('ApplicationSubmitFlowOut','http://alip.accenture.com/types');
                /*for(Dom.XmlNode xmlnode : appSubmitFlowOut.getChildElements() ){
                    System.debug('=xmlnode ====' + xmlnode.getName());
                    System.debug('=getNamespace====' + xmlnode.getNamespace());
                }*/
                System.debug('=appSubmitFlowOut.getChildElement(appID, serviceNS).getText()====' + appSubmitFlowOut.getChildElement('AppID', 'http://alip.accenture.com/types').getText());
                String appId = appSubmitFlowOut.getChildElement('AppID', 'http://alip.accenture.com/types').getText();
                String appStatus = appSubmitFlowOut.getChildElement('AppStatus', 'http://alip.accenture.com/types').getText();
                System.debug('appId===' + appId);
                System.debug('appStatus===' + appStatus);                    
                return appId + ',' +appStatus;
                    
            }catch(Exception ex){             
                System.debug('Exception====='+ ex);   
                return '';
            }
          }
        }