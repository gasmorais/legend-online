package bingo
{
   import flash.events.Event;
   import yishi.actions.map.MapBaseAction;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class BingoDelayAction extends MapBaseAction
   {
      
      private var _count:int;
      
      private var _num:int = 0;
      
      private var _delay:int;
      
      public function BingoDelayAction(param1:int = 0, param2:int = 60)
      {
         super();
         _num = param1;
         _delay = param2;
      }
      
      override public function update() : void
      {
         if(_count >= _delay)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("BALL_START",_num));
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

