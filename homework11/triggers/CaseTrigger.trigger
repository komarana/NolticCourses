trigger CaseTrigger on Case (before insert, before update, after update) {
    CaseTriggerHandler.handler(
            Trigger.new,
            Trigger.operationType
    );
}