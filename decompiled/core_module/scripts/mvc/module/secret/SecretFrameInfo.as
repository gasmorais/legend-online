package mvc.module.secret
{
   import yishi.manager.NotificationManager;
   
   public class SecretFrameInfo
   {
      
      public var mapId:int;
      
      public var levelId:int;
      
      public var remainingTimes:int;
      
      public var fight:int;
      
      public var remainTime:String;
      
      public var initHp:Number;
      
      public var isFirst:Boolean;
      
      private var _currHp:Number;
      
      private var _isDie:Boolean = true;
      
      private var _passMapId:int;
      
      public function SecretFrameInfo()
      {
         super();
      }
      
      public function get currHp() : Number
      {
         return _currHp;
      }
      
      public function set currHp(param1:Number) : void
      {
         if(_currHp == param1)
         {
            return;
         }
         _currHp = param1;
         isDie = _currHp <= 0;
      }
      
      public function get isDie() : Boolean
      {
         return _isDie;
      }
      
      public function set isDie(param1:Boolean) : void
      {
         if(_isDie == param1)
         {
            return;
         }
         _isDie = param1;
         NotificationManager.instance.sendNotification("SecretAdEvent.lifeUpdate");
      }
      
      public function get passMapId() : int
      {
         return _passMapId;
      }
      
      public function set passMapId(param1:int) : void
      {
         if(_passMapId == param1)
         {
            return;
         }
         _passMapId = param1;
         NotificationManager.instance.sendNotification("SecretAdEvent.updateTaskState");
      }
   }
}

