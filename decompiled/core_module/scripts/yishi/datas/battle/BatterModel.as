package yishi.datas.battle
{
   import yishi.manager.NotificationManager;
   
   public class BatterModel
   {
      
      private var _isStart:Boolean = false;
      
      private var _batterCount:int = 0;
      
      private var _damageTotal:int = 0;
      
      private var _isSendVisible:Boolean = false;
      
      private var _lock:Boolean = false;
      
      public var maxBatterCount:int;
      
      public function BatterModel()
      {
         super();
      }
      
      public function get isStart() : Boolean
      {
         return _isStart;
      }
      
      public function set isStart(param1:Boolean) : void
      {
         if(_isStart == param1)
         {
            return;
         }
         if(param1 == false)
         {
            batterCount = 0;
            damageTotal = 0;
            _isSendVisible = false;
         }
         _isStart = param1;
         if(_isStart == false)
         {
            NotificationManager.instance.sendNotification("SET_BATTERUI_VISIBLE_BattleNotic",false);
         }
      }
      
      public function get batterCount() : int
      {
         return _batterCount;
      }
      
      public function set batterCount(param1:int) : void
      {
         if(_isStart == false)
         {
            return;
         }
         _batterCount = param1;
         if(maxBatterCount < _batterCount)
         {
            maxBatterCount = _batterCount;
         }
         if(_lock == false)
         {
            NotificationManager.instance.sendNotification("SET_BATTER_COUNT_BattleNotic",_batterCount);
         }
         if(!_isSendVisible && _batterCount > 2)
         {
            NotificationManager.instance.sendNotification("SET_BATTERUI_VISIBLE_BattleNotic",true);
            _isSendVisible = true;
         }
      }
      
      public function get damageTotal() : int
      {
         return _damageTotal;
      }
      
      public function set damageTotal(param1:int) : void
      {
         if(_isStart == false)
         {
            return;
         }
         _damageTotal = param1;
         if(_lock == false)
         {
            NotificationManager.instance.sendNotification("SET_TOTAL_DAMAGE_BattleNotic",_damageTotal);
         }
      }
      
      public function get lock() : Boolean
      {
         return _lock;
      }
      
      public function set lock(param1:Boolean) : void
      {
         if(_lock == param1)
         {
            return;
         }
         _lock = param1;
         if(_lock == false)
         {
            NotificationManager.instance.sendNotification("SET_BATTER_COUNT_BattleNotic",_batterCount);
            NotificationManager.instance.sendNotification("SET_TOTAL_DAMAGE_BattleNotic",_damageTotal);
         }
      }
   }
}

