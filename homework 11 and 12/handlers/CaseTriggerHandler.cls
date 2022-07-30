public with sharing class CaseTriggerHandler {
    public static void handler(List<Case> newListCases, List<Case> oldListCases, System.TriggerOperation triggerOperation) {
        switch on triggerOperation {
            when BEFORE_UPDATE {
                CaseService.updateSuccessMessageForCases(newListCases);
            }
            when AFTER_UPDATE {
                CaseService.updateAmountClosedCasesOnCountry(oldListCases);
            }
            when AFTER_DELETE {
                CaseService.updateAmountClosedCasesOnCountry(oldListCases);
            }
        }
    }
}