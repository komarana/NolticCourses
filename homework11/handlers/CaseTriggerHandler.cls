public with sharing class CaseTriggerHandler {
    public static void handler(List<Case> cases, System.TriggerOperation triggerOperation) {
        switch on triggerOperation {
            when BEFORE_UPDATE {
                CaseService.updateSuccessMessageForCases(cases);
            }
            when AFTER_UPDATE {
                CaseService.updateAmountClosedCasesOnCountry(cases);
            }
        }
    }
}