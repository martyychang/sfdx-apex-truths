public virtual class ApexTruth3Service {

    private Integer counter;
    
    public static ApexTruth3Service instance = new ApexTruth3Service();

    public ApexTruth3Service() {
        this.counter = 0;
    }

    public virtual Integer countByOne() {
        return ++this.counter;
    }

    public Integer getCounter() {
        return this.counter;
    }

    public static ApexTruth3Service getInstance() {
        return instance;
    }

    public static void setInstance(ApexTruth3Service value) {
        instance = value;
    }
}
