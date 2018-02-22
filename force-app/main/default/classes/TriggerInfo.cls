public class TriggerInfo {
    public static String getEventName() {
        return getBeforeAfter() + ' ' + getCrud();
    }
    
    public static String getBeforeAfter() {
        return Trigger.isBefore == true ? 'before'
            	: Trigger.isAfter == true ? 'after'
                : 'unknown';
    }
    
    public static String getCrud() {
        return Trigger.isInsert == true ? 'insert'
            	: Trigger.isUpdate == true ? 'update'
                : Trigger.isDelete == true ? 'delete'
                : Trigger.isUndelete == true ? 'undelete'
                : 'unknown';
    }
}