package sandbox.transaction
{
   import battle.transaction.TransactionBase;
   import com.road.yishi.proto.simple.PropertyMsg;
   import sandbox.SandboxManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class SandboxOverTransaction extends TransactionBase
   {
      
      public function SandboxOverTransaction()
      {
         super();
      }
      
      override public function handlePackage() : void
      {
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_ = _pkg.readBody(_loc1_) as PropertyMsg;
         if(_loc1_.param2 == 0)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_ENTER_SCENE"));
            SandboxManager.instance.uninit();
         }
      }
      
      override public function getCode() : int
      {
         return 4856;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

