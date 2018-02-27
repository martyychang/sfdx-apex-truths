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

    /**
     * Prove that a singular static instance of a _stubbed_ service 
     * is preserved throughout a unit test, even in the resolution of
     * a platform event trigger
     *
     * - Before `Test.startTest()` is called
     * - After `Test.startTest()` is called, within the trigger context
     *   of a platform even trigger executed asynchronously
     * - After `Test.stopTest()` is called
     */     
    @isTest
    private static void countThreeRecordsWithServiceStub() {

        // Given
        ApexTruth3ServiceStub apexTruth3Stub = new ApexTruth3ServiceStub();

        // Count two times to prime the test
        apexTruth3Stub.countByOne();
        apexTruth3Stub.countByOne();

        // Verify the counter, then override the static instance
        System.assertEquals(200,
                apexTruth3Stub.getBigCounter(),
                'given BIG counter');

        ApexTruth3Service apexTruth3 = (ApexTruth3Service)apexTruth3Stub;
        ApexTruth3Service.setInstance(apexTruth3);

        // When
        Test.startTest();

        EventBus.publish(new List<ApexTruth3HelloEvent__e> {
            new ApexTruth3HelloEvent__e(),
            new ApexTruth3HelloEvent__e(),
            new ApexTruth3HelloEvent__e()
        });

        // Then
        Test.stopTest();

        System.assertEquals(500,
                apexTruth3Stub.getBigCounter(),
                'then BIG counter');
    }

    private class ApexTruth3ServiceStub extends ApexTruth3Service {

        private Integer bigCounter;

        public ApexTruth3ServiceStub() {
            super();
            this.bigCounter = 0;
        }

        public override Integer countByOne() {
            this.bigCounter += 100;
            return this.bigCounter;
        }

        public Integer getBigCounter() {
            return this.bigCounter;
        }
    }
}
