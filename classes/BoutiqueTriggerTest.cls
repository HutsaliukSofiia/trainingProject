/**
 * Created by shutsaliuk on 23.02.2023.
 */

@IsTest
private class BoutiqueTriggerTest {
    @IsTest
    static void testBehavior() {
        Account acc = new Account (Name='Test');
        insert acc;
        Contact cont = new Contact (LastName='Test', AccountId=acc.Id);
        Map<Id, String> recordTypesList = BoutiqueResourceTriggerHandler.GetRecordTypes();

        Test.startTest();

        List<Boutique_Resource__c> brBefore = [SELECT Id, Name FROM Boutique_Resource__c];
        List<Boutique_Resource__c> boutiqueResources = new List<Boutique_Resource__c>();
        for(Id key: recordTypesList.keySet()){
            Boutique_Resource__c boutiqueResource = new Boutique_Resource__c(
                    Name='Name', Boutique__c=acc.Id, RecordTypeId=key
            );
            switch on recordTypesList.get(key){
                when 'Location'{
                    boutiqueResource.Location__c='Location';
                    boutiqueResource.Description__c='Description';
                }
                when 'Team Member'{
                    boutiqueResource.Contact__c=cont.Id;
                }
                when 'Purpose of Visit'{
                    boutiqueResource.Product_Family__c='Accessories';
                    boutiqueResource.Service__c='Other Services';
                }
            }
            boutiqueResources.add(boutiqueResource);
        }
        insert boutiqueResources;

        List<Boutique_Resource__c> brAfter = [SELECT Id, Name FROM Boutique_Resource__c];

        Test.stopTest();
        System.assertEquals(brAfter.size() - brBefore.size(), recordTypesList.size());

    }
}