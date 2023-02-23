public with sharing class BoutiqueResourceTriggerHandler {
    public static void UpdateNames(List<Boutique_Resource__c> boutiques){
        Map<Id, String> recordTypesList = GetRecordTypes();

        List<Id> ids = new List<Id>();
        Boolean isTeamMember;
        for(Boutique_Resource__c br: boutiques){
            ids.add(br.Boutique__c);
            ids.add(br.Contact__c);
            isTeamMember= (recordTypesList.get(br.RecordTypeId) == 'Team Member') ? true : false;
        }
        Map<Id, Account> accs = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Id IN :ids]);
        Map<Id, Contact> conts = new Map<Id, Contact>();
        if(isTeamMember){
            conts = new Map<Id, Contact>([SELECT Id, Name FROM Contact WHERE Id IN :ids]);
        }


        for(Boutique_Resource__c br: boutiques){
            String rtName = recordTypesList.get(br.RecordTypeId);
            String contName = conts.containsKey(br.Contact__c) ? conts.get(br.Contact__c).Name : null;
            br.Name=CreateName(br, rtName, accs.get(br.Boutique__c).Name, contName);
        }
    }

    public static Map<Id, String> GetRecordTypes(){
        Map<Id, String> recordTypesList = new Map<Id, String>();
        List<Schema.RecordTypeInfo> RT = Boutique_Resource__c.SObjectType.getDescribe().getRecordTypeInfos();
        for(Schema.RecordTypeInfo rti: RT){
            recordTypesList.put(rti.getRecordTypeId(), rti.getName());
        }
        return recordTypesList;
    }

    public static String CreateName(Boutique_Resource__c br, String rtName, String accName, String contName){
        String name='';
        switch on rtName{
            when 'Location'{
                name = '[' + accName + '] ' + br.Location__c;
            }
            when 'Team Member'{
                name = '[' + accName + '] ' + contName;
            }
            when 'Purpose of Visit'{
                name = '[' + accName + '] Watches';
            }
        }
        return name;
    }
}