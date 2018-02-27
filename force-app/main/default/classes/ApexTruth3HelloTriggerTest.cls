@isTest
private class ApexTruth3HelloTriggerTest {

    /**
     * Prove that a singular static instance of a service is preserved
     * throughout an Apex unit test method
     *
     * - Before `Test.startTest()` is called
     * - After `Test.startTest()` is called, within the trigger context
     *   of a DML operation
     * - After `Test.stopTest()` is called
     */     
    @isTest
    private static void countThreeRecords() {

        // Given
        ApexTruth3Service apexTruth3 = new ApexTruth3Service();

        // Count two times to prime the test
        apexTruth3.countByOne();
        apexTruth3.countByOne();

        // Override the static instance and verify the counter
        ApexTruth3Service.setInstance(apexTruth3);

        System.assertEquals(2,
                ApexTruth3Service.getInstance().getCounter(),
                'given counter');

        // When
        Test.startTest();

        insert new List<ApexTruth3Hello__c> {
            new ApexTruth3Hello__c(),
            new ApexTruth3Hello__c(),
            new ApexTruth3Hello__c()
        };

        // Then
        Test.stopTest();

        System.assertEquals(5,
                ApexTruth3Service.getInstance().getCounter(),
                'then counter');
    }
}
