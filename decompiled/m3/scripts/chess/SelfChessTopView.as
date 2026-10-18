package chess
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.chess.SelfChessModel;
   import mvc.module.chess.SelfChessPlayerInfo;
   import yishi.view.base.NumberBitmap;
   
   public class SelfChessTopView extends Sprite
   {
      
      public var _second:NumberBitmap;
      
      public var _trun:NumberBitmap;
      
      public var _xBit:NumberBitmap;
      
      private var _state:int = -1;
      
      private var _secondNum:int;
      
      private var _time:Timer;
      
      private const SECOND_MAX:int = 31;
      
      private var _round:int = -1;
      
      private var _waitFlg:Bitmap;
      
      private var currTurn:int = -1;
      
      public function SelfChessTopView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function set round(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_round == param1)
         {
            return;
         }
         _round = param1;
         if(_round <= 2)
         {
            currTurn = 1;
            _loc3_ = _round;
         }
         else
         {
            currTurn = Math.ceil((_round - 2) / 5 + 1);
            _loc2_ = (_round - 2) % 5;
            if(_loc2_ == 0)
            {
               _loc2_ = 5;
            }
            _loc3_ = _loc2_;
         }
         _trun.num = _loc3_;
         _xBit.num = currTurn;
      }
      
      private function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         if(_state == 1)
         {
            _second.visible = true;
            _waitFlg.visible = false;
            _secondNum = model.round == 1 ? 46 : 31;
            _time.start();
         }
         else
         {
            _second.visible = false;
            _waitFlg.visible = true;
            _secondNum = 0;
            _time.stop();
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:SelfChessPlayerInfo = model.selfInfo;
         if(_loc1_)
         {
            state = model.state;
            round = model.round;
         }
      }
      
      private function get model() : SelfChessModel
      {
         return SelfChessManager.Ins.model;
      }
      
      private function initView() : void
      {
         _second = ComponentFactory.Instance.creatCustomObject("ui.selfchess.second");
         _trun = ComponentFactory.Instance.creatCustomObject("ui.selfchess.trun");
         _xBit = ComponentFactory.Instance.creatCustomObject("ui.selfchess.x");
         _waitFlg = ComponentFactory.Instance.creatBitmap("asset.selfchess.waitFt");
         _trun.initParams("asset.selfchess.trun","asset.selfchess.yellow",18,23,15,18,"0123456789",74,1,0,44);
         _xBit.initParams("asset.selfchess.x","asset.selfchess.yellow",18,23,15,18,"0123456789",99,1,0,30);
         _second.initParams("asset.selfchess.second","asset.selfchess.yellow",18,23,15,18,"0123456789",180,-1,0,52);
         addChild(_second);
         addChild(_trun);
         addChild(_xBit);
         addChild(_waitFlg);
         _second.visible = false;
         _time = new Timer(1000);
         _time.stop();
      }
      
      private function initEvent() : void
      {
         _time.addEventListener("timer",timerHandler);
      }
      
      private function removeEvent() : void
      {
         _time.removeEventListener("timer",timerHandler);
         _time.stop();
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         _secondNum = _secondNum - 1;
         if(_secondNum <= 0)
         {
            _time.stop();
            _secondNum = 0;
         }
         _second.num = _secondNum;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_second);
         _second = null;
         ObjectUtils.disposeObject(_trun);
         _trun = null;
         ObjectUtils.disposeObject(_xBit);
         _xBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _time = null;
      }
   }
}

