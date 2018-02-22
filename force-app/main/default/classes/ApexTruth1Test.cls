@isTest
private class ApexTruth1Test {

    @isTest
    private static void insertRecord() {

        // Given
        List<ApexTruth1__c> givenTruths = getApexTruth1s();

        System.assertEquals(0, givenTruths.size());

        List<LogEntry__c> givenEntries = getLogEntries(null);

        System.assertEquals(0, givenEntries.size());

        // When
        Test.startTest();

        insert new ApexTruth1__c(Name = 'test');

        // Then
        Test.stopTest();

        List<ApexTruth1__c> thenTruths = getApexTruth1s();

        System.assertEquals(1, thenTruths.size());

        System.assertEquals('TEST', thenTruths[0].Name);

        System.assertEquals(false, thenTruths[0].IsRerun__c);

        List<LogEntry__c> thenOrphanEntries = getLogEntries(null);

        System.assertEquals(1, thenOrphanEntries.size());

        System.assertEquals(
                'before insert: 1', thenOrphanEntries[0].Message__c);

        List<LogEntry__c> thenTruthEntries = getLogEntries(thenTruths[0].Id);

        System.assertEquals(5, thenTruthEntries.size());
    }

    private static List<ApexTruth1__c> getApexTruth1s() {
        return [
            SELECT
                IsRerun__c,
                Name,
                Id
            FROM ApexTruth1__c
        ];
    }

    private static List<LogEntry__c> getLogEntries(Id apexTruth1Id) {
        return [
            SELECT
                Message__c,
                Id
            FROM LogEntry__c
            WHERE ApexTruth1__c = :apexTruth1Id
        ];
    }
}