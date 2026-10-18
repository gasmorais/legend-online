package mvc.module.children
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class ChildApplyInfo
   {
      
      public var isApply:Boolean;
      
      public var userIdA:int;
      
      public var userIdB:int;
      
      private var _time:String;
      
      public var state:int = -1;
      
      private var _timer:Timer;
      
      private var _leftTime:int = 0;
      
      public function ChildApplyInfo()
      {
         super();
      }
      
      public function get leftTime() : int
      {
         return _leftTime;
      }
      
      public function set leftTime(param1:int) : void
      {
         _leftTime = param1;
      }
      
      public function set time(param1:String) : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
         _time = param1;
         var _loc5_:int = 86400000;
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("create_child_time");
         if(_loc2_)
         {
            _loc5_ = parseInt(_loc2_.ConfigValue);
         }
         var _loc6_:Date = DateFormatter.parse(_time,"YYYY-MM-DD hh:mm:ss");
         var _loc7_:Number = _loc6_.time + _loc5_;
         var _loc3_:Date = new Date(_loc7_);
         var _loc4_:Object = DateFormatter.compareDate(PlayerManager.instance.currentPlayerModel.sysCurtime,_loc3_);
         if(_loc4_["flag"])
         {
            leftTime = (_loc3_.time - PlayerManager.instance.currentPlayerModel.sysCurtime.time) / 1000;
            _timer = new Timer(1000);
            _timer.addEventListener("timer",__timerHandler);
            _timer.start();
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _leftTime = _leftTime - 1;
         NotificationManager.instance.sendNotification("CHILDAPPLYTIMERCHANGE");
         if(leftTime <= 0)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
            NotificationManager.instance.sendNotification("CHILDAPPLYTIMERCOMPLETE");
         }
      }
      
      public function get time() : String
      {
         return _time;
      }
   }
}

