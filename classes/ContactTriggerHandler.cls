public with sharing class ContactTriggerHandler {

    public static void ContactAfterInsert(List<Contact> contactList){
        Id recordTypeId =
                Schema.SObjectType.Boutique_Resource__c.getRecordTypeInfosByName().get('Team Member').getRecordTypeId();
        List<Boutique_Resource__c> newBoutiques = new List<Boutique_Resource__c>();
        for(Contact contact: contactList){
            Boutique_Resource__c boutiqueResource= new Boutique_Resource__c(
                    RecordTypeId = recordTypeId,
                    Name='Name',
                    Boutique__c = contact.AccountId,
                    Contact__c = contact.Id
                    );
            newBoutiques.add(boutiqueResource);
        }
        insert newBoutiques;
    }

    public static void ContactAfterUpdate(List<Contact> contacts){
        List<Id> contactIds = new List<Id>();
        for(Contact contact: contacts){
            contactIds.add(contact.Id);
        }
        List<Boutique_Resource__c> brs = [
                SELECT Id, Name, Contact__c
                FROM Boutique_Resource__c
                WHERE Contact__c IN :contactIds
        ];
        for(Boutique_Resource__c br: brs){
            br.Name='ToUpdate';
        }
        update brs;
    }
}