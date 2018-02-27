@isTest
private class ApexTruth2MegaserviceTest {

    /**
     * This test proves that an overridden method in a subclass will always
     * execute the method as defined in the subclass, even when the method
     * is invoked after casting an instance of the subclass as the superclass.
     */
    @isTest
    private static void getName() {

        // Given
        ApexTruth2Megaservice apexTruth2Mega = new ApexTruth2Megaservice();

        System.assertEquals(
                'ApexTruth2Service',
                new ApexTruth2Service().getName(),
                '`name` property of `ApexTruth2Service` instance');

        System.assertEquals(
                'ApexTruth2Megaservice',
                apexTruth2Mega.getName(),
                '`name` property of `ApexTruth2Megaservice` instance');

        // When
        Test.startTest();

        ApexTruth2Service apexTruth2 = (ApexTruth2Service)apexTruth2Mega;
        String name = apexTruth2.getName();

        // Then
        Test.stopTest();

        // Prove that `getName` still returns the same value as expected
        // from the overridden subclass method
        System.assertEquals('ApexTruth2Megaservice', name,
                '`name` property after casting instance as `ApexTruth2Service`');
        
        System.assertEquals(
                'Megaservice says hello',
                apexTruth2Mega.getMessage(),
                '`message` property on original instance');
    }
}
