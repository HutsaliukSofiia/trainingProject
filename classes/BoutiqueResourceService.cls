public with sharing class BoutiqueResourceService {
    public static void UpdateNames(List<Boutique_Resource__c> boutiques){
        Map<Id, String> recordTypesList = GetRecordTypes();
        for(Boutique_Resource__c br: boutiques){
            String rtName = recordTypesList.get(br.RecordTypeId);
            switch on rtName{
                when 'Location'{
                    br.Name = '[' + br.Boutique__r.Name + '] ' + br.Location__c;
                    break;
                }
                when 'Team Member'{
                    br.Name = '[' + br.Boutique__r.Name + '] ' + br.Contact__r.Name;
                    break;
                }
                when 'Purpose of Visit'{
                    br.Name = '[' + br.Boutique__r.Name + '] Watches';
                    break;
                }
            }
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

}