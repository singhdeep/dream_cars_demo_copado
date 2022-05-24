/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class LinkComponentBatch implements Database.AllowsCallouts, Database.Batchable<String>, Database.Stateful {
    global String defAPIName;
    global String defQryStr;
    global String dfPattern;
    global String lastUpdDate;
    global Map<String,String> pmoObjNameMap;
    global CommandCenter__RM_Configuration__c respositoryDetails;
    global String syncToday;
    global String usrConfig;
    global String usrPattern;
    global List<CommandCenter__ScheduledJob_UsrSetting__c> usrSetting;
    global String usrStrAPIName;
    global String usrStryQryStr;
    global LinkComponentBatch() {

    }
    global LinkComponentBatch(String syncToday) {

    }
    global System.Iterable Start(Database.BatchableContext info) {
        return null;
    }
    global void execute(Database.BatchableContext info, List<String> scope) {

    }
    global void finish(Database.BatchableContext info) {

    }
}
