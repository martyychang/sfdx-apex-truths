public class ApexTruth2Megaservice extends ApexTruth2Service {
    public ApexTruth2Megaservice() {
        /* do nothing */
    }

    public override String getName() {
        return ApexTruth2Megaservice.class.getName();
    }

    public String getMessage() {
        return 'Megaservice says hello';
    }
}
