trigger AccountTrigger on Account (after insert,after Update) {

    List<Account> accList = new List<Account> ();
    accList = [Select Id,Industry from Account where Id IN :Trigger.NewMap.keySet()];
    for(Account acc : accList){
        acc.Industry = 'Agriculture';
    }
    update accList;


}