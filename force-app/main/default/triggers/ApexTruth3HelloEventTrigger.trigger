trigger ApexTruth3HelloEventTrigger on ApexTruth3HelloEvent__e (after insert) {
    
    // Get _the_ instance of `ApexTruth3Service`
    ApexTruth3Service apexTruth3 = ApexTruth3Service.getInstance();

    // Count by one for each record in the batch
    for (ApexTruth3HelloEvent__e eachEVent : Trigger.new) {
        apexTruth3.countByOne();
    }
}