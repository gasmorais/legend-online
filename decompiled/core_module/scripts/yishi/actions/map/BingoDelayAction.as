package yishi.actions.map
{
   import com.road.yishi.proto.bingo.BingoResultDataMsg;
   import flash.events.Event;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class BingoDelayAction extends MapBaseAction
   {
      
      private var _count:int;
      
      private var _num:int = 0;
      
      private var _resultMsg:BingoResultDataMsg;
      
      private var _luckNum:Boolean;
      
      private var _delay:int;
      
      public function BingoDelayAction(param1:int = 0, param2:BingoResultDataMsg = null, param3:Boolean = false, param4:int = 60)
      {
         super();
         _num = param1;
         _resultMsg = param2;
         _luckNum = param3;
         _delay = param4;
      }
      
      override public function update() : void
      {
      }
      
      public function handOut() : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("BALL_START",{
            "num":_num,
            "resultMsg":_resultMsg,
            "luckNum":_luckNum
         }));
      }
      
      public function get resultLength() : int
      {
         return _resultMsg.lotteryNum.length;
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

