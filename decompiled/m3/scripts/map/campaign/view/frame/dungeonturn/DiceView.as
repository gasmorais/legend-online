package map.campaign.view.frame.dungeonturn
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import managers.DungeoTurnManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class DiceView extends Component
   {
      
      private var _bring3:Image;
      
      private var _bring2:Image;
      
      private var _bring1:Image;
      
      private var _num2:Image;
      
      private var _num1:Image;
      
      private var _num3:Image;
      
      private var _bg:Image;
      
      private var _currentIndex:int = 1;
      
      private var _diceCount:int = 3;
      
      private var _isRuningTurn:Boolean;
      
      private var _timer:Timer;
      
      public var canClick:Boolean = false;
      
      public var maxRollCount:int = 8;
      
      public var currentCount:int;
      
      public var targetNum:int;
      
      public function DiceView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bring1 = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DiceView.bring1");
         _bring2 = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DiceView.bring2");
         _bring3 = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DiceView.bring3");
         _num1 = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DiceView.num1");
         _num2 = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DiceView.num2");
         _num3 = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DiceView.num3");
         _bg = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DiceView.bg");
         addChild(_bg);
         addChild(_bring1);
         addChild(_bring2);
         addChild(_bring3);
         addChild(_num1);
         addChild(_num2);
         addChild(_num3);
         _bring1.visible = _bring2.visible = _bring3.visible = false;
         _timer = new Timer(200);
         _isRuningTurn = false;
      }
      
      public function roll(param1:int) : void
      {
         targetNum = param1;
         if(DungeoTurnManager.instance.model.isByControl)
         {
            selectBox(param1);
            NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_PREPARE_FIGHT"));
            return;
         }
         _timer.start();
      }
      
      private function moveToNext() : void
      {
         currentCount = currentCount + 1;
         selectBox(currentCount);
      }
      
      private function _startTurn(param1:TimerEvent) : void
      {
         if(currentCount <= maxRollCount)
         {
            moveToNext();
         }
         else
         {
            selectBox(targetNum);
            _timer.stop();
            currentCount = 0;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_PREPARE_FIGHT"));
         }
      }
      
      private function addEvent() : void
      {
         _timer.addEventListener("timer",_startTurn);
      }
      
      public function selectBox(param1:int) : void
      {
         this._currentIndex = param1;
         _bring1.visible = _bring2.visible = _bring3.visible = false;
         if(param1 != 0)
         {
            param1 %= 3;
            param1 = int(param1 == 0 ? 3 : param1);
            this["_bring" + param1].visible = true;
         }
      }
      
      private function removeEvent() : void
      {
         _timer.removeEventListener("timer",_startTurn);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bring3);
         _bring3 = null;
         ObjectUtils.disposeObject(_bring2);
         _bring2 = null;
         ObjectUtils.disposeObject(_bring1);
         _bring1 = null;
         ObjectUtils.disposeObject(_num2);
         _num2 = null;
         ObjectUtils.disposeObject(_num1);
         _num1 = null;
         ObjectUtils.disposeObject(_num3);
         _num3 = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_timer)
         {
            _timer.stop();
         }
         _timer = null;
         super.dispose();
      }
   }
}

