public with sharing class BoutiqueResourceTriggerHandler {
    public static void UpdateNames(List<Boutique_Resource__c> boutiques){
        Map<Id, String> recordTypesList = GetRecordTypes();
        for(Boutique_Resource__c br: boutiques){
            String rtName = recordTypesList.get(br.RecordTypeId);
            br.Name=CreateName(br, rtName);
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

    public static String CreateName(Boutique_Resource__c br, String rtName){
        String name='';
        switch on rtName{
            when 'Location'{
                name = '[' + br.Boutique__r.Name + '] ' + br.Location__c;
            }
            when 'Team Member'{
                name = '[' + br.Boutique__r.Name + '] ' + br.Contact__r.Name;
            }
            when 'Purpose of Visit'{
                name = '[' + br.Boutique__r.Name + '] Watches';
            }
        }
        return name;
    }
}