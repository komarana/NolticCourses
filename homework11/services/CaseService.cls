public with sharing class CaseService {

    public static Set<Id> getCountriesIds(List<Case> cases) {

        Set<Id> countryIds = new Set<Id>();

        for (Case caseItem : cases) {
            countryIds.add(caseItem.Country__c);
        }
        return countryIds;
    }

    public static void updateSuccessMessageForCases(List<Case> cases) {

        List<Country__c> countries = CountrySelector.getByCaseIds(getCountriesIds(cases));

        for (Country__c country : countries) {
            for (Case caseItem : cases) {
                if (caseItem.country__c == country.Id && caseItem.Status == 'Closed') {
                    caseItem.SuccessMessage__c = country.SuccessMessage__c;
                }
            }
        }
    }

    public static void updateAmountClosedCasesOnCountry(List<Case> cases) {

        List<AggregateResult> aggregateResults = CaseSelector.getAmountOfClosedCaseForCountry(getCountriesIds(cases));

        List<Country__c> countries = new List<Country__c>();

        for (AggregateResult ar : aggregateResults){
            countries.add(new Country__c(Id = (Id)ar.get('Country__c'),
                    ClosedCases__c = (Integer)ar.get('countId')));
        }
        update countries;
    }
}