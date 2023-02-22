trigger BoutiqueResourceTrigger on Boutique_Resource__c (before insert) {
    BoutiqueResourceTriggerHandler.UpdateNames(Trigger.new);
}