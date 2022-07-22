public with sharing class OpportunityUtility {

    public static List<Opportunity> updateOpportunityStage(String stageNew, String stageOld) {

        if (!isValidStages(stageNew, stageOld)) {
            throw new ExternalObjectException('Invalid stage');
        }

        List<Opportunity> opportunities = [
                SELECT Id, Name, StageName
                FROM Opportunity
                WHERE StageName = :stageOld
        ];

        for (Opportunity opportunity : opportunities) {
            opportunity.StageName = stageNew;
        }
        update opportunities;

        List<Opportunity> opportunityResult = new List<Opportunity>(opportunities);
        return [
                SELECT Id, Name, StageName
                FROM Opportunity
                WHERE Id IN :opportunityResult
        ];
    }

    private static Boolean isValidStages(String stageNew, String stageOld) {

        Set<String> listStages = new Set<String>();
        List<Schema.PicklistEntry> opportunityStages = Opportunity.StageName.getDescribe().getPicklistValues();

        for (Schema.PicklistEntry opportunityStage : opportunityStages) {
            listStages.add(opportunityStage.getValue());
        }
        return (listStages.contains(stageOld) && listStages.contains(stageNew)) ? true : false;
    }
}