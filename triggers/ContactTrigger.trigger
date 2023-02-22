trigger ContactTrigger on Contact (after insert, after update) {
    if(Trigger.isAfter && Trigger.isInsert){
        ContactTriggerHandler.ContactAfterInsert(Trigger.new);
    }
    else if( Trigger.isAfter && Trigger.isUpdate){
        ContactTriggerHandler.ContactAfterUpdate(Trigger.new);
    }
}