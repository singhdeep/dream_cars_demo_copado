public class TaskUtil {
    public static String getTaskPriority(String leadState) {
       //TEST RUNALLTEST test
        // Validate input
        // test line 1
        if (String.isBlank(leadState) || leadState.length() > 2) {
            return null;
        }
           
        String taskPriority;
        // test line 2
       
        if (leadState == 'CA') {
             taskPriority = 'High';
        } else {
             taskPriority = 'Normal';
        }
       // test line 3
        return taskPriority;
    }
}