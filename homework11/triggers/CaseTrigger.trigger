trigger CaseTrigger on Case (before update, after update) {
    CaseTriggerHandler.handler(
            Trigger.new,
            Trigger.operationType
    );
}