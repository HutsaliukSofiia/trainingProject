trigger BoutiqueResourceTrigger on Boutique_Resource__c (before insert) {
    BoutiqueResourceService.UpdateNames(Trigger.new);
}