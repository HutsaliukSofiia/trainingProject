trigger BoutiqueResourceTrigger on Boutique_Resource__c (before insert, before update) {
    BoutiqueResourceTriggerHandler.UpdateNames(Trigger.new);
}