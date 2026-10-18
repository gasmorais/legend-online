package yishi.datas.battle
{
   import yishi.actions.map.ResistDelayAction;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.NotificationManager;
   
   public class ResistModel
   {
      
      private var _resistTotal:int = 0;
      
      private var _currentResistSide:int = -1;
      
      private var _attackOver:Boolean = false;
      
      private var _curSide:int;
      
      public function ResistModel()
      {
         super();
      }
      
      public function get resistTotal() : int
      {
         return _resistTotal;
      }
      
      public function set resistTotal(param1:int) : void
      {
         _resistTotal = param1;
      }
      
      public function get currentResistSide() : int
      {
         return _currentResistSide;
      }
      
      public function set currentResistSide(param1:int) : void
      {
         _currentResistSide = param1;
      }
      
      public function get attackOver() : Boolean
      {
         return _attackOver;
      }
      
      public function set attackOver(param1:Boolean) : void
      {
         _attackOver = param1;
         if(_attackOver)
         {
            if(_curSide != _currentResistSide)
            {
               NotificationManager.instance.sendNotification("SET_RESIST_TOTAL_DAMAGE",{
                  "value":_resistTotal,
                  "side":currentResistSide
               });
               NotificationManager.instance.sendNotification("SET_RESIST_VISIBLE",{
                  "value":true,
                  "side":currentResistSide
               });
            }
            else
            {
               GameBaseQueueManager.instance.addAction(new ResistDelayAction(_attackOver,resistTotal,currentResistSide,15));
            }
            _curSide = _currentResistSide;
         }
         else
         {
            _resistTotal = 0;
         }
      }
   }
}

