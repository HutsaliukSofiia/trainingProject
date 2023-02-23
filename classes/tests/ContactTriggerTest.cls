@IsTest
private class ContactTriggerTest {

    @IsTest
    static void AfterInsertPositive() {
        Account acc = new Account(Name='ContactTriggerTestAccount');
        insert acc;
        List<Contact> contacts = new List<Contact>();
        for(Integer i=0; i<5; i++){
            Contact cont = new Contact(
                    LastName='Test Contact ' + i,
                    AccountId=acc.Id
            );
            contacts.add(cont);
        }

        Test.startTest();
        List<Boutique_Resource__c> brsBefore = [SELECT Id, Name FROM Boutique_Resource__c];
        insert contacts;

        List<Boutique_Resource__c> brsAfter = [SELECT Id, Name FROM Boutique_Resource__c];


        Test.stopTest();

        System.assertEquals(brsAfter.size()-brsBefore.size(), 5);
    }


    @IsTest
    static void afterUpdatePositive(){
        Account acc = new Account(Name='ContactTriggerTestAccount');
        insert acc;
        List<Contact> contacts = new List<Contact>();
        for(Integer i=0; i<5; i++){
            Contact cont = new Contact(
                    LastName='Test Contact ' + i,
                    AccountId=acc.Id
            );
            contacts.add(cont);
        }
        insert contacts;

        Test.startTest();
        Contact toUpdate = [SELECT Id, LastName FROM Contact LIMIT 1];
        Boutique_Resource__c brBefore = [
                SELECT Id, Name
                FROM Boutique_Resource__c
                WHERE Contact__c=:toUpdate.Id LIMIT 1];
        toUpdate.LastName = 'Updated Name';

        update (toUpdate);

        Boutique_Resource__c brAfter = [
                SELECT Id, Name
                FROM Boutique_Resource__c
                WHERE Contact__c=:toUpdate.Id LIMIT 1];
        Test.stopTest();

        System.assertNotEquals(brBefore.Name, brAfter.Name);
    }

}