public with sharing class CaseSelector {

    public static List<AggregateResult> getAmountOfClosedCaseForCountry(Set<Id> ids){
        return [SELECT Country__c,  COUNT(Id) countId
        FROM CASE
        WHERE Country__c IN : ids
        AND Status = 'Closed'
        GROUP BY Country__c
        ];
    }
}