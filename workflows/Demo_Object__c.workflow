<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_email_to_dealer</fullName>
        <description>Send email to dealer</description>
        <protected>false</protected>
        <recipients>
            <field>User_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Dealer_Created</template>
    </alerts>
</Workflow>
