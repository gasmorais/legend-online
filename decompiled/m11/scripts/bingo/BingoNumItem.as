package bingo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.bingo.BingoResultDataMsg;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import yishi.events.NotificationEvent;
   import yishi.manager.BingoManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.NumberViewUtils;
   
   public class BingoNumItem extends Component
   {
      
      private var _inkMc:MovieClip;
      
      private var _numberContain:Component;
      
      private var _numberAsset:BitmapData;
      
      private var _data:int;
      
      private var _resultMsg:BingoResultDataMsg;
      
      private var _marked:Boolean;
      
      public function BingoNumItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _inkMc = ComponentFactory.Instance.creatCustomObject("asset.bingo.inkMc");
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.bingo.cardNumAsset");
         _numberContain = new Component();
         addChild(_numberContain);
         addChild(_inkMc);
         _inkMc.gotoAndStop(1);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("BALL_START",__ballStartHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("BALL_START",__ballStartHandler);
      }
      
      private function __ballStartHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = int(param1.data.num);
         var _loc5_:BingoResultDataMsg = BingoResultDataMsg(param1.data.resultMsg);
         var _loc4_:Array = _loc5_.luckNum;
         var _loc2_:Array = _loc5_.lotteryNum;
         if(_loc4_.length < 2 || _loc4_.length == 2 && _loc2_.length == 0)
         {
            return;
         }
         if(_loc3_ == _data && !_marked)
         {
            _inkMc.play();
            _marked = true;
         }
      }
      
      public function set data(param1:int) : void
      {
         _data = param1;
         NumberViewUtils.refreshValue(_data,_numberContain,_numberAsset,15,20,13,15,"0123456789");
         _numberContain.x = _data < 10 ? 17 : 10;
         _numberContain.y = 15;
         _resultMsg = BingoManager.instance.resultMsg;
         if(_resultMsg && _resultMsg.lotteryNum.indexOf(_data) != -1)
         {
            _inkMc.gotoAndStop(_inkMc.totalFrames);
            _marked = true;
         }
         else
         {
            _inkMc.gotoAndStop(1);
            _marked = false;
         }
         if(_data == 0)
         {
            _numberContain.visible = false;
            _inkMc.visible = false;
            _marked = true;
         }
      }
      
      public function get marked() : Boolean
      {
         return _marked;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_inkMc);
         _inkMc = null;
         ObjectUtils.disposeObject(_numberContain);
         _numberContain = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         _resultMsg = null;
         super.dispose();
      }
   }
}

