@isTest
private class CodeUtilTest {
  //TEST RUNALLTEST
    @isTest static void testTaskPriority() {
        String pri = CodeUtil.getTaskPriority('NY');
        System.assertEquals('Normal', pri);
    }
   
    @isTest static void testTaskHighPriority() {
        String pri = CodeUtil.getTaskPriority('CA');
        System.assertEquals('High', pri);
    }
   
    @isTest static void testTaskPriorityInvalid() {
        String pri = CodeUtil.getTaskPriority('Montana');
        System.assertEquals(null, pri);
    }
    
    @isTest static void testTaskPriorityInvalidr() {
        String pri = CodeUtil.getTaskPriority('Raven');
        System.assertEquals(null, pri);
    }
}
// demo purpose