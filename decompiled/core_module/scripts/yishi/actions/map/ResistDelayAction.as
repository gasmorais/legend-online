package yishi.actions.map
{
   import flash.events.Event;
   import yishi.manager.NotificationManager;
   
   public class ResistDelayAction extends MapBaseAction
   {
      
      private var _count:int;
      
      private var _resistTotal:int = 0;
      
      private var _currentResistSide:int = -1;
      
      private var _isShow:Boolean;
      
      private var _delay:int;
      
      public function ResistDelayAction(param1:Boolean, param2:int, param3:int, param4:int = 0)
      {
         super();
         _isShow = param1;
         _resistTotal = param2;
         _currentResistSide = param3;
         _delay = param4;
      }
      
      override public function update() : void
      {
         if(_count >= _delay)
         {
            NotificationManager.instance.sendNotification("SET_RESIST_TOTAL_DAMAGE",{
               "value":_resistTotal,
               "side":_currentResistSide
            });
            NotificationManager.instance.sendNotification("SET_RESIST_VISIBLE",{
               "value":_isShow,
               "side":_currentResistSide
            });
            dispose();
         }
         _count = _count + 1;
      }
      
      override public function prepare() : void
      {
      }
      
      override protected function actionOver() : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

