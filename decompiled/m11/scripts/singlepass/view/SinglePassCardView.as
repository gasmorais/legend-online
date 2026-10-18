package singlepass.view
{
   import com.greensock.TweenMax;
   import com.greensock.events.TweenEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.singlepass.SinglePassCardInfo;
   import mvc.module.singlepass.SinglePassCardStateInfo;
   
   public class SinglePassCardView extends Sprite implements Disposeable
   {
      
      private const TWEEN_CARD_TIME:Number = 0.7;
      
      private const TWEEN_BTN_CARD_TIME:Number = 0.3;
      
      private const TO_TOP_PROGRESS:Number = 0.4;
      
      private var _cards:Vector.<SinglePassCardItemView>;
      
      private var _effectCards:Vector.<SinglePassCardItemView>;
      
      private var _cardInfos:Vector.<SinglePassCardInfo>;
      
      private var _prevTollgateBtn:BaseButton;
      
      private var _nextTollgateBtn:BaseButton;
      
      private var _stateLeft0:SinglePassCardStateInfo;
      
      private var _stateLeft1:SinglePassCardStateInfo;
      
      private var _stateCenter:SinglePassCardStateInfo;
      
      private var _stateRight1:SinglePassCardStateInfo;
      
      private var _stateRight0:SinglePassCardStateInfo;
      
      private var _index:int;
      
      private var _currentCard:SinglePassCardItemView;
      
      private var _turnFlag:Boolean = false;
      
      private var _topFlag:Boolean = false;
      
      private var _btnFlag:Boolean = false;
      
      private var _turnFunction:Function;
      
      public function SinglePassCardView()
      {
         super();
         _cards = new Vector.<SinglePassCardItemView>();
         _effectCards = new Vector.<SinglePassCardItemView>();
         _cardInfos = new Vector.<SinglePassCardInfo>();
         _stateLeft0 = new SinglePassCardStateInfo(0,120,70,0.7,"left");
         _stateLeft1 = new SinglePassCardStateInfo(1,120,70,0.7,"left");
         _stateCenter = new SinglePassCardStateInfo(1,222,5,1,"center");
         _stateRight1 = new SinglePassCardStateInfo(1,400,70,0.7,"right");
         _stateRight0 = new SinglePassCardStateInfo(0,400,70,0.7,"right");
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:SinglePassCardItemView = null;
         var _loc1_:int = 0;
         _prevTollgateBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.SinglePassCardView.PrevTollgateBtn");
         _nextTollgateBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.SinglePassCardView.NextTollgateBtn");
         addChild(_prevTollgateBtn);
         addChild(_nextTollgateBtn);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = new SinglePassCardItemView();
            addChild(_loc2_);
            _cards.push(_loc2_);
            _loc1_++;
         }
         refreshView();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_prevTollgateBtn);
         _prevTollgateBtn = null;
         ObjectUtils.disposeObject(_nextTollgateBtn);
         _nextTollgateBtn = null;
      }
      
      private function initEvent() : void
      {
         _prevTollgateBtn.addEventListener("click",__prevTollgateBtnClickHandler);
         _nextTollgateBtn.addEventListener("click",__nextTollgateBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _prevTollgateBtn.removeEventListener("click",__prevTollgateBtnClickHandler);
         _nextTollgateBtn.removeEventListener("click",__nextTollgateBtnClickHandler);
      }
      
      private function __prevTollgateBtnClickHandler(param1:MouseEvent) : void
      {
         _btnFlag = false;
         if(_turnFlag)
         {
            return;
         }
         prevTollgate();
      }
      
      private function __nextTollgateBtnClickHandler(param1:MouseEvent) : void
      {
         _btnFlag = false;
         if(_turnFlag)
         {
            return;
         }
         nextTollgate();
      }
      
      public function prevTollgate() : void
      {
         _index = _index - 1;
         if(_index < 0)
         {
            _index = 0;
         }
         else
         {
            _currentCard.selected = false;
            _currentCard = _cards[_index];
            _turnFlag = true;
            _topFlag = true;
            turnPrev();
         }
         refreshBtn();
      }
      
      public function nextTollgate() : void
      {
         _index = _index + 1;
         if(_index >= 10)
         {
            _index = 10 - 1;
         }
         else
         {
            _currentCard.selected = false;
            _currentCard = _cards[_index];
            _turnFlag = true;
            _topFlag = true;
            turnNext();
         }
         refreshBtn();
      }
      
      public function turnTollgate(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _btnFlag = true;
         if(param1 > _index)
         {
            _loc2_ = param1 - _index;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               nextTollgate();
               _loc3_++;
            }
         }
         else if(param1 < _index)
         {
            _loc2_ = _index - param1;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               prevTollgate();
               _loc3_++;
            }
         }
         _index = param1;
      }
      
      private function refreshBtn() : void
      {
         if(_index == 0)
         {
            _prevTollgateBtn.visible = false;
            _nextTollgateBtn.visible = true;
         }
         else if(_index == 10 - 1)
         {
            _prevTollgateBtn.visible = true;
            _nextTollgateBtn.visible = false;
         }
         else
         {
            _prevTollgateBtn.visible = true;
            _nextTollgateBtn.visible = true;
         }
         if(_turnFunction != null)
         {
            _turnFunction();
         }
      }
      
      private function turnPrev() : void
      {
         _effectCards.length = 0;
         checkCard(_index - 1,_stateLeft1);
         checkCard(_index,_stateCenter);
         checkCard(_index + 1,_stateRight1);
         checkCard(_index + 2,_stateRight0);
      }
      
      private function turnNext() : void
      {
         _effectCards.length = 0;
         checkCard(_index - 2,_stateLeft0);
         checkCard(_index - 1,_stateLeft1);
         checkCard(_index,_stateCenter);
         checkCard(_index + 1,_stateRight1);
      }
      
      private function checkCard(param1:int, param2:SinglePassCardStateInfo) : void
      {
         var _loc3_:SinglePassCardItemView = null;
         if(isValidateIndex(param1))
         {
            _loc3_ = _cards[param1];
            _loc3_.turning = true;
            _loc3_.selected = true;
            tweenCard(_loc3_,param2);
            _effectCards.push(_loc3_);
         }
      }
      
      private function isValidateIndex(param1:int) : Boolean
      {
         if(param1 >= 0 && param1 < 10)
         {
            return true;
         }
         return false;
      }
      
      private function tweenCard(param1:SinglePassCardItemView, param2:SinglePassCardStateInfo) : void
      {
         var _loc3_:Object = {};
         _loc3_["alpha"] = param2.alpha;
         _loc3_["x"] = param2.x;
         _loc3_["y"] = param2.y;
         _loc3_["scaleX"] = param2.scale;
         _loc3_["scaleY"] = param2.scale;
         _loc3_["onCompleteListener"] = tweenCardCompleteHandler;
         if(param1 == _currentCard)
         {
            _loc3_["onUpdateListener"] = tweenCardUpdateHandler;
         }
         if(_btnFlag)
         {
            TweenMax.to(param1,0.3,_loc3_);
         }
         else
         {
            TweenMax.to(param1,0.7,_loc3_);
         }
         param1.stateInfo = param2;
      }
      
      private function tweenCardCompleteHandler(param1:TweenEvent) : void
      {
         var _loc2_:SinglePassCardItemView = param1.target.target as SinglePassCardItemView;
         if(_loc2_ == _currentCard)
         {
            _turnFlag = false;
         }
         else
         {
            _loc2_.selected = false;
         }
         _loc2_.refreshPositionByState();
         _loc2_.turning = false;
         TweenMax.killTweensOf(_loc2_);
      }
      
      private function tweenCardUpdateHandler(param1:TweenEvent) : void
      {
         if(_topFlag)
         {
            if(param1.target.currentProgress - 0.4 > 0)
            {
               currentCardTop();
               _topFlag = false;
            }
         }
      }
      
      private function killTweens() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _effectCards)
         {
            TweenMax.killTweensOf(_loc1_);
         }
      }
      
      private function currentCardSelect() : void
      {
         _currentCard.selected = true;
      }
      
      private function currentCardTop() : void
      {
         addChild(_currentCard);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         if(_index != param1)
         {
            _index = param1;
            refreshView();
         }
      }
      
      public function set turnFunction(param1:Function) : void
      {
         _turnFunction = param1;
      }
      
      public function get cardInfos() : Vector.<SinglePassCardInfo>
      {
         return _cardInfos;
      }
      
      public function set cardInfos(param1:Vector.<SinglePassCardInfo>) : void
      {
         var _loc3_:SinglePassCardItemView = null;
         var _loc2_:int = 0;
         _cardInfos = param1;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc3_ = _cards[_loc2_];
            _loc3_.data = _cardInfos[_loc2_];
            _loc2_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:SinglePassCardItemView = null;
         var _loc1_:int = 0;
         killTweens();
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = _cards[_loc1_];
            _loc2_.selected = false;
            if(_loc1_ == _index)
            {
               _loc2_.stateInfo = _stateCenter;
               _currentCard = _loc2_;
               currentCardSelect();
               currentCardTop();
            }
            else if(_loc1_ < _index)
            {
               if(_loc1_ == _index - 1)
               {
                  _loc2_.stateInfo = _stateLeft1;
               }
               else
               {
                  _loc2_.stateInfo = _stateLeft0;
               }
            }
            else if(_loc1_ > _index)
            {
               if(_loc1_ == _index + 1)
               {
                  _loc2_.stateInfo = _stateRight1;
               }
               else
               {
                  _loc2_.stateInfo = _stateRight0;
               }
            }
            _loc2_.refreshPositionByState();
            _loc2_.refreshViewByState();
            _loc1_++;
         }
         refreshBtn();
         _turnFlag = false;
      }
      
      public function dispose() : void
      {
         killTweens();
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

