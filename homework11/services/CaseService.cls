public with sharing class CaseService {

    public static void updateSuccessMessageForCases(List<Case> cases) {

        Set<Id> caseIds = new Set<Id>();

        for (Case caseItem : cases) {
            caseIds.add(caseItem.Country__c);
        }

        List<Country__c> countries = CountrySelector.getByCaseIds(caseIds);

        for (Country__c country : countries) {
            for (Case caseItem : cases) {
                if (caseItem.Status == 'Closed') {
                    caseItem.SuccessMessage__c = country.SuccessMessage__c;
                }
            }
        }
    }

//    public static void updateClosedCasesForCountry(List<Case> cases){
//
//    }
}