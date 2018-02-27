@isTest
private class ApexTruth3HelloEventTriggerTest {

    /**
     * Prove that a singular static instance of a service is preserved
     * throughout an Apex unit test method, even in the resolution of
     * a platform event trigger
     *
     * - Before `Test.startTest()` is called
     * - After `Test.startTest()` is called, within the trigger context
     *   of a platform even trigger executed asynchronously
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

        EventBus.publish(new List<ApexTruth3HelloEvent__e> {
            new ApexTruth3HelloEvent__e(),
            new ApexTruth3HelloEvent__e(),
            new ApexTruth3HelloEvent__e()
        });

        // Then
        Test.stopTest();

        System.assertEquals(5,
                ApexTruth3Service.getInstance().getCounter(),
                'then counter');
    }
}
