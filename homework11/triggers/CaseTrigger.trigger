trigger CaseTrigger on Case (before update, after update, after delete) {
    CaseTriggerHandler.handler(
            Trigger.new,
            Trigger.old,
            Trigger.operationType
    );
}