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

    public static void updateAmountClosedCasesOnCountry(List<Case> cases){

        Set<Id> ids = new Set<Id>();

        for (Case caseItem : cases) {
            ids.add(caseItem.Country__c);
        }

        List<AggregateResult> aggregateResults = CountrySelector.getAmountOfClosedCaseForCountry(ids);

        List<Country__c> countries = new List<Country__c>();

        for (AggregateResult ar : aggregateResults){
            countries.add(new Country__c(Id = (Id)ar.get('Status'),
                    ClosedCases__c = (Integer)ar.get('countId')));
        }
        update countries;
    }
}