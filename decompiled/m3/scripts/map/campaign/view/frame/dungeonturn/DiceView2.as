package map.campaign.view.frame.dungeonturn
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class DiceView2 extends Component
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
      
      public var currentNum:int;
      
      public function DiceView2()
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
         _isRuningTurn = false;
      }
      
      private function startTurn() : void
      {
      }
      
      private function stopTurn() : void
      {
      }
      
      private function addEvent() : void
      {
         _num1.addEventListener("click",_num1Clickhandler);
         _num2.addEventListener("click",_num2Clickhandler);
         _num3.addEventListener("click",_num3Clickhandler);
      }
      
      private function _num1Clickhandler(param1:MouseEvent) : void
      {
         selectBox(1);
      }
      
      private function _num2Clickhandler(param1:MouseEvent) : void
      {
         selectBox(2);
      }
      
      private function _num3Clickhandler(param1:MouseEvent) : void
      {
         selectBox(3);
      }
      
      public function selectBox(param1:int) : void
      {
         this._currentIndex = param1;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_ROLL_SELECTED"));
         _bring1.visible = _bring2.visible = _bring3.visible = false;
         if(param1 != 0)
         {
            this["_bring" + param1].visible = true;
         }
         currentNum = param1;
      }
      
      private function removeEvent() : void
      {
         _num1.removeEventListener("click",_num1Clickhandler);
         _num2.removeEventListener("click",_num2Clickhandler);
         _num3.removeEventListener("click",_num3Clickhandler);
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
         super.dispose();
      }
   }
}

