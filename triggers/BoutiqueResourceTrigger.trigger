trigger BoutiqueResourceTrigger on Boutique_Resource__c (after insert) {
    BoutiqueResourceService.UpdateNames(Trigger.new);
}