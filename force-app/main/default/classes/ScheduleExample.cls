global class ScheduleExample implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Account> AccountList = [Select Id,Name from Account];
        for(Account acc : AccountList){
            acc.Name=acc.Name +'A';
        }
        update AccountList;
    }
}