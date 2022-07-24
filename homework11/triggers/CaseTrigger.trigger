trigger CaseTrigger on Case (before insert, before update, after insert, after update) {
    CaseTriggerHandler.handler(
            Trigger.new,
            Trigger.operationType
    );
}