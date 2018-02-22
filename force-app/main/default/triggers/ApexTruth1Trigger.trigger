trigger ApexTruth1Trigger on ApexTruth1__c (
        before insert, after insert,
        before update, after update) {
    for (ApexTruth1__c eachRecord : Trigger.new) {
        
        // Reset the Rerun checkbox
        if (Trigger.isBefore) {
            eachRecord.IsRerun__c = false;
        }

        // Count the number of trigger executions
        ApexTruth1Info.counter++;

        // Construct a message to log       
        String message = TriggerInfo.getEventName()
                + ': ' + ApexTruth1Info.counter;
        
        // Log the message
        insert new LogEntry__c(
                ApexTruth1__c = eachRecord.Id,
                Message__c = message);
    }
}