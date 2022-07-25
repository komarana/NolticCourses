public with sharing class CountrySelector {

    public static List<Country__c> getByCaseIds(Set<Id> caseIds) {
        return [SELECT Id, SuccessMessage__c, ClosedCases__c
        FROM Country__c
        WHERE Id IN :caseIds
        ];
    }
}