public with sharing class CountrySelector {

    public static List<Country__c> getByCaseIds(Set<Id> caseIds) {
        return [SELECT Id, SuccessMessage__c, ClosedCases__c
        FROM Country__c
        WHERE Id IN :caseIds
        ];
    }
    public static List<AggregateResult> getAmountOfClosedCaseForCountry(Set<Id> ids){
        return [SELECT Status, COUNT(Id) countId
        FROM CASE
        WHERE Status = 'Closed'
        AND Id IN : ids
        GROUP BY Status
        ];
    }
}