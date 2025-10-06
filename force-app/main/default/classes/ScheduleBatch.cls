global class ScheduleBatch implements schedulable {
    
    global void execute(SchedulableContext sc){
        batchExample be = new batchExample();
        database.executeBatch(be, 2);
    }
    
    
}