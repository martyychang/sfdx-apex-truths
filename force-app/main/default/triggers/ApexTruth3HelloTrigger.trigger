trigger ApexTruth3HelloTrigger on ApexTruth3Hello__c (after insert) {
    
    // Get _the_ instance of `ApexTruth3Service`
    ApexTruth3Service apexTruth3 = ApexTruth3Service.getInstance();

    // Count by one for each record in the batch
    for (ApexTruth3Hello__c eachHello : Trigger.new) {
        apexTruth3.countByOne();
    }
}