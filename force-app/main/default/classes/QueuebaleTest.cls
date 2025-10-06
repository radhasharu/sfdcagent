public class QueuebaleTest implements Queueable {

     public void execute(QueueableContext context) {
            System.debug(AsyncInfo.getCurrentQueueableStackDepth());
            System.debug(AsyncInfo.getMaximumQueueableStackDepth());
            System.debug(AsyncInfo.hasMaxStackDepth());
     }
}