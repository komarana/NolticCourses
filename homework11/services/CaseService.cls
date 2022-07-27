public with sharing class CaseService {

    public static Set<Id> getCaseIdWithCountry(List<Case> cases) {
        Set<Id> caseIds = new Set<Id>();

        for (Case caseItem : cases) {
            caseIds.add(caseItem.Country__c);
        }
        return caseIds;
    }

    public static void updateSuccessMessageForCases(List<Case> cases) {

        List<Country__c> countries = CountrySelector.getByCaseIds(getCaseIdWithCountry(cases));

        for (Country__c country : countries) {
            for (Case caseItem : cases) {
                if (caseItem.Status == 'Closed') {
                    caseItem.SuccessMessage__c = country.SuccessMessage__c;
                }
            }
        }
    }

    public static void updateAmountClosedCasesOnCountry(List<Case> cases){

        List<AggregateResult> aggregateResults = CaseSelector.getAmountOfClosedCaseForCountry(getCaseIdWithCountry(cases));

        List<Country__c> countries = new List<Country__c>();

        for (AggregateResult ar : aggregateResults){
            countries.add(new Country__c(Id = (Id)ar.get('Country__c'),
                    ClosedCases__c = (Integer)ar.get('countId')));
        }
        update countries;
    }
}