package poker
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.poker.PokerPlayerInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PokerManager;
   
   public class PokerScrollView extends Component
   {
      
      public static const ALL_IN:int = 0;
      
      public static const BET:int = 1;
      
      public static const BIG_BLIND:int = 2;
      
      public static const CALL:int = 3;
      
      public static const CHECK:int = 4;
      
      public static const FOLD:int = 5;
      
      public static const RAISE:int = 6;
      
      public static const SMALL_BLIND:int = 7;
      
      private var _thumbBg:Bitmap;
      
      private var _thumbBtn:BaseButton;
      
      private var _scrollAddBtn:BaseButton;
      
      private var _scrollSubtraBtn:BaseButton;
      
      private var _scrollSprite:Sprite;
      
      private var _scrollBarValue:int;
      
      private const _totalFrame:int = 105;
      
      private const initialX:int = 100;
      
      private const initialMax:int = 205;
      
      private var _abandonBtn:TextButton;
      
      private var _raiseBtn1:TextButton;
      
      private var _raiseBtn2:TextButton;
      
      private var _allinBtn:TextButton;
      
      private var _checkBtn:TextButton;
      
      private var _foldBtn1:TextButton;
      
      private var _foldBtn2:TextButton;
      
      private var _foldBtn3:TextButton;
      
      private var _foldBtn4:TextButton;
      
      private var _info:PokerPlayerInfo;
      
      private var MAX_RAISES:int = 3;
      
      private var _bet:int;
      
      private var _minBet:int;
      
      private var _currentBet:int;
      
      private var _raises:int;
      
      private var _list:Array;
      
      private var _splitNum:int;
      
      protected var _thumbDownOffset:int;
      
      protected var _thumbRect:Rectangle = new Rectangle();
      
      public function PokerScrollView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _thumbBg = ComponentFactory.Instance.creatBitmap("asset.poker.thumbBg");
         _thumbBtn = ComponentFactory.Instance.creatComponentByStylename("poker.thumbBtn");
         _scrollAddBtn = ComponentFactory.Instance.creatComponentByStylename("poker.scrollAddBtn");
         _scrollSubtraBtn = ComponentFactory.Instance.creatComponentByStylename("poker.scrollSubtraBtn");
         _scrollSprite = ComponentFactory.Instance.creatCustomObject("poker.scrollSprite");
         _abandonBtn = ComponentFactory.Instance.creatComponentByStylename("poker.abandonBtn");
         _raiseBtn1 = ComponentFactory.Instance.creatComponentByStylename("poker.raiseBtn1");
         _raiseBtn2 = ComponentFactory.Instance.creatComponentByStylename("poker.raiseBtn2");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("poker.checkBtn");
         _foldBtn1 = ComponentFactory.Instance.creatComponentByStylename("poker.foldBtn1");
         _foldBtn2 = ComponentFactory.Instance.creatComponentByStylename("poker.foldBtn2");
         _foldBtn3 = ComponentFactory.Instance.creatComponentByStylename("poker.foldBtn3");
         _foldBtn4 = ComponentFactory.Instance.creatComponentByStylename("poker.foldBtn4");
         _allinBtn = ComponentFactory.Instance.creatComponentByStylename("poker.allinBtn");
         _scrollSprite.addChild(_thumbBg);
         _scrollSprite.addChild(_thumbBtn);
         _scrollSprite.addChild(_scrollAddBtn);
         _scrollSprite.addChild(_scrollSubtraBtn);
         _scrollSprite.addChild(_foldBtn1);
         _scrollSprite.addChild(_foldBtn2);
         _scrollSprite.addChild(_foldBtn3);
         _scrollSprite.addChild(_foldBtn4);
         _scrollSprite.addChild(_raiseBtn2);
         addChild(_scrollSprite);
         addChild(_abandonBtn);
         addChild(_raiseBtn1);
         addChild(_checkBtn);
         addChild(_allinBtn);
         _abandonBtn.text = LanguageMgr.GetTranslation("poker.PokerScrollView.abandonBtnTxt");
         _raiseBtn1.text = LanguageMgr.GetTranslation("poker.PokerScrollView.raiseBtnTxt1",10);
         _raiseBtn2.text = LanguageMgr.GetTranslation("poker.PokerScrollView.raiseBtnTxt2",10);
         _checkBtn.text = LanguageMgr.GetTranslation("poker.PokerScrollView.checkBtnTxt");
         _allinBtn.text = LanguageMgr.GetTranslation("poker.PokerScrollView.allinBtnTxt");
         _foldBtn1.text = "50";
         _foldBtn2.text = "100";
         _foldBtn3.text = "200";
         _foldBtn4.text = "500";
         refreshScrollVisible();
      }
      
      private function addEvent() : void
      {
         _thumbBtn.addEventListener("mouseDown",__onThumbDown);
         _abandonBtn.addEventListener("click",__onFoldHandler);
         _raiseBtn1.addEventListener("click",__onFoldHandler);
         _raiseBtn2.addEventListener("click",__onFoldHandler);
         _allinBtn.addEventListener("click",__onFoldHandler);
         _checkBtn.addEventListener("click",__onFoldHandler);
         _foldBtn1.addEventListener("click",__onFoldHandler);
         _foldBtn2.addEventListener("click",__onFoldHandler);
         _foldBtn3.addEventListener("click",__onFoldHandler);
         _foldBtn4.addEventListener("click",__onFoldHandler);
         _scrollAddBtn.addEventListener("click",__onScrollBtnHandler);
         _scrollSubtraBtn.addEventListener("click",__onScrollBtnHandler);
         NotificationManager.instance.addEventListener("POKER_ROTATE",__playerRotateHandler);
         NotificationManager.instance.addEventListener("POKER_BOARD",__playerBoardHandler);
      }
      
      private function removeEvent() : void
      {
         _thumbBtn.removeEventListener("mouseDown",__onThumbDown);
         _abandonBtn.removeEventListener("click",__onFoldHandler);
         _raiseBtn1.removeEventListener("click",__onFoldHandler);
         _raiseBtn2.removeEventListener("click",__onFoldHandler);
         _allinBtn.removeEventListener("click",__onFoldHandler);
         _checkBtn.removeEventListener("click",__onFoldHandler);
         _foldBtn1.removeEventListener("click",__onFoldHandler);
         _foldBtn2.removeEventListener("click",__onFoldHandler);
         _foldBtn3.removeEventListener("click",__onFoldHandler);
         _foldBtn4.removeEventListener("click",__onFoldHandler);
         _scrollAddBtn.removeEventListener("click",__onScrollBtnHandler);
         _scrollSubtraBtn.removeEventListener("click",__onScrollBtnHandler);
         NotificationManager.instance.removeEventListener("POKER_ROTATE",__playerRotateHandler);
         NotificationManager.instance.removeEventListener("POKER_BOARD",__playerBoardHandler);
         StageReferance.stage.removeEventListener("mouseUp",__onThumbUp);
         StageReferance.stage.removeEventListener("mouseMove",__onThumbMoved);
      }
      
      private function __onFoldHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("022");
         var _loc3_:BaseButton = param1.currentTarget as BaseButton;
         switch(_loc3_)
         {
            case _abandonBtn:
               PokerManager.instance.OperatePoker(5);
               break;
            case _checkBtn:
               PokerManager.instance.OperatePoker(4);
               break;
            case _raiseBtn1:
               PokerManager.instance.OperatePoker(3);
               break;
            case _raiseBtn2:
               OperatePoker(_scrollBarValue);
               break;
            case _foldBtn1:
               OperatePoker(50 - (_bet - _info.bet));
               break;
            case _foldBtn2:
               OperatePoker(100 - (_bet - _info.bet));
               break;
            case _foldBtn3:
               OperatePoker(200 - (_bet - _info.bet));
               break;
            case _foldBtn4:
               OperatePoker(500 - (_bet - _info.bet));
               break;
            case _allinBtn:
               PokerManager.instance.OperatePoker(3);
         }
         this.visible = false;
      }
      
      public function refreshScrollVisible() : void
      {
         if(PokerManager.instance.checkPlayerActive() && PokerManager.instance.actorInfo.userId == palyerInfo.userId)
         {
            this.visible = true;
            __playerActNotifyHandler();
         }
         else
         {
            this.visible = false;
         }
      }
      
      private function OperatePoker(param1:int) : void
      {
         if(_list.indexOf(1) != -1)
         {
            PokerManager.instance.OperatePoker(1,param1);
         }
         else
         {
            PokerManager.instance.OperatePoker(6,param1);
         }
      }
      
      private function __onScrollBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("022");
         var _loc4_:int = _scrollBarValue;
         var _loc5_:BaseButton;
         switch(_loc5_ = param1.currentTarget as BaseButton)
         {
            case _scrollAddBtn:
               _loc2_ = _splitNum;
               break;
            case _scrollSubtraBtn:
               _loc2_ = -_splitNum;
         }
         if(_loc4_ + _loc2_ < _currentBet)
         {
            _loc4_ = _currentBet;
         }
         else if(_loc4_ + _loc2_ > _info.cash)
         {
            _loc4_ = int(_info.cash);
         }
         else
         {
            _loc4_ += _loc2_;
         }
         var _loc3_:int = 105 / (_info.cash - _currentBet) * (_loc4_ - _currentBet) + 100;
         _loc3_ = Math.min(_loc3_,205);
         setThumbPosAndSize(_loc3_,_thumbBtn.y,_thumbBtn.width,_thumbBtn.height);
      }
      
      private function __playerRotateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:PokerPlayerInfo = param1.data as PokerPlayerInfo;
         if(checkRotate(_loc2_))
         {
            this.visible = false;
         }
         else
         {
            this.visible = true;
            __playerActNotifyHandler();
         }
      }
      
      private function checkRotate(param1:PokerPlayerInfo) : Boolean
      {
         var _loc4_:int = 0;
         if(param1.userId != palyerInfo.userId)
         {
            return true;
         }
         if(param1.userId == palyerInfo.userId && PokerManager.instance.getPokerMyself().cash == 0)
         {
            return true;
         }
         var _loc3_:Boolean = true;
         var _loc2_:Array = PokerManager.instance.activePlayersArr;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].userId != palyerInfo.userId && _loc2_[_loc4_].cash != 0)
            {
               _loc3_ = false;
            }
            _loc4_++;
         }
         if(PokerManager.instance.checkPlayerActive() && _loc3_)
         {
            return true;
         }
         return false;
      }
      
      private function __playerBoardHandler(param1:NotificationEvent) : void
      {
         _bet = PokerManager.instance.boardInfo.bet;
         _minBet = PokerManager.instance.boardInfo.minBet;
         _raises = PokerManager.instance.boardInfo.raises;
      }
      
      private function __playerActNotifyHandler() : void
      {
         var _loc1_:int = 0;
         _bet = PokerManager.instance.boardInfo.bet;
         _minBet = PokerManager.instance.boardInfo.minBet;
         _raises = PokerManager.instance.boardInfo.raises;
         _info = PokerManager.instance.getPokerMyself();
         _splitNum = _info.cash / 4;
         _list = actionList();
         if(_list.indexOf(1) != -1)
         {
            _currentBet = Math.max(_minBet,10);
         }
         else
         {
            _currentBet = Math.max(_minBet,10);
         }
         clean();
         if(_info.cash == 0)
         {
            return;
         }
         if(_info)
         {
            _loc1_ = 0;
            while(_loc1_ < _list.length)
            {
               switch(_list[_loc1_])
               {
                  case 0:
                     break;
                  case 1:
                     _scrollSprite.visible = true;
                     setThumbPosAndSize(100);
                     checkAllIn();
                     break;
                  case 2:
                     break;
                  case 3:
                     _raiseBtn1.visible = true;
                     _raiseBtn1.text = LanguageMgr.GetTranslation("poker.PokerScrollView.raiseBtnTxt1",_bet - _info.bet);
                     break;
                  case 4:
                     _checkBtn.visible = true;
                     break;
                  case 5:
                     _abandonBtn.visible = true;
                     break;
                  case 6:
                     _scrollSprite.visible = true;
                     setThumbPosAndSize(100);
                     checkAllIn();
                     break;
                  case 7:
               }
               _loc1_++;
            }
         }
      }
      
      private function actionList() : Array
      {
         var _loc2_:Array = [];
         var _loc1_:int = int(_info.bet);
         if(_bet == 0)
         {
            _loc2_.push(4);
            _loc2_.push(1);
         }
         else if(_loc1_ < _bet)
         {
            _loc2_.push(3);
            _loc2_.push(6);
         }
         else
         {
            _loc2_.push(4);
            _loc2_.push(6);
         }
         _loc2_.push(5);
         return _loc2_;
      }
      
      private function checkAllIn() : void
      {
         if(_info.cash + _info.bet <= _bet)
         {
            _scrollSprite.visible = false;
            _raiseBtn1.visible = false;
            _allinBtn.visible = true;
         }
         else
         {
            _foldBtn1.enable = 50 >= _bet - _info.bet + _currentBet && _info.cash >= 50;
            _foldBtn2.enable = 100 >= _bet - _info.bet + _currentBet && _info.cash >= 100;
            _foldBtn3.enable = 200 >= _bet - _info.bet + _currentBet && _info.cash >= 200;
            _foldBtn4.enable = 500 >= _bet - _info.bet + _currentBet && _info.cash >= 500;
         }
      }
      
      private function clean() : void
      {
         _abandonBtn.visible = false;
         _raiseBtn1.visible = false;
         _checkBtn.visible = false;
         _allinBtn.visible = false;
         _scrollSprite.visible = false;
      }
      
      protected function __onThumbDown(param1:MouseEvent) : void
      {
         var _loc2_:Point = getMousePosition();
         var _loc3_:int = _loc2_.x;
         var _loc4_:int = _loc2_.y;
         _thumbDownOffset = _loc3_ - _thumbBtn.x;
         StageReferance.stage.addEventListener("mouseUp",__onThumbUp);
         StageReferance.stage.addEventListener("mouseMove",__onThumbMoved);
      }
      
      protected function __onThumbMoved(param1:MouseEvent) : void
      {
         scrollThumbToCurrentMousePosition();
      }
      
      protected function __onThumbUp(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__onThumbUp);
         StageReferance.stage.removeEventListener("mouseMove",__onThumbMoved);
      }
      
      protected function scrollThumbToCurrentMousePosition() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = int(mouseX);
         var _loc6_:int = int(mouseY);
         var _loc3_:Rectangle = new Rectangle(100,39,137,50);
         _loc1_ = _loc3_.x;
         _loc4_ = _loc3_.x + _loc3_.width - _thumbRect.width;
         _loc5_ = Math.min(_loc4_,Math.max(_loc1_,_loc2_ - _thumbDownOffset));
         setThumbPosAndSize(_loc5_,_thumbBtn.y,_thumbBtn.width,_thumbBtn.height);
      }
      
      protected function setThumbPosAndSize(param1:int, param2:int = 39, param3:int = 32, param4:int = 24) : void
      {
         _thumbRect.x = _thumbBtn.x = param1;
         _thumbRect.y = _thumbBtn.y = param2;
         _thumbRect.width = param3;
         _thumbRect.height = param4;
         if(!_info)
         {
            return;
         }
         var _loc5_:int = _info.cash - _currentBet;
         _scrollBarValue = (_thumbBtn.x - 100) / 105 * _loc5_ + _currentBet;
         if(_scrollBarValue == _info.cash || _bet - _info.bet + _scrollBarValue >= _info.cash)
         {
            _raiseBtn2.text = LanguageMgr.GetTranslation("poker.PokerScrollView.allinBtnTxt");
         }
         else
         {
            _raiseBtn2.text = LanguageMgr.GetTranslation("poker.PokerScrollView.raiseBtnTxt2",_bet - _info.bet + _scrollBarValue);
         }
      }
      
      private function get palyerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_thumbBg);
         _thumbBg = null;
         ObjectUtils.disposeObject(_thumbBtn);
         _thumbBtn = null;
         ObjectUtils.disposeObject(_scrollAddBtn);
         _scrollAddBtn = null;
         ObjectUtils.disposeObject(_scrollSubtraBtn);
         _scrollSubtraBtn = null;
         ObjectUtils.disposeAllChildren(_scrollSprite);
         ObjectUtils.disposeObject(_scrollSprite);
         _scrollSprite = null;
         ObjectUtils.disposeObject(_abandonBtn);
         _abandonBtn = null;
         ObjectUtils.disposeObject(_raiseBtn1);
         _raiseBtn1 = null;
         ObjectUtils.disposeObject(_raiseBtn2);
         _raiseBtn2 = null;
         ObjectUtils.disposeObject(_allinBtn);
         _allinBtn = null;
         ObjectUtils.disposeObject(_checkBtn);
         _checkBtn = null;
         ObjectUtils.disposeObject(_foldBtn1);
         _foldBtn1 = null;
         ObjectUtils.disposeObject(_foldBtn2);
         _foldBtn2 = null;
         ObjectUtils.disposeObject(_foldBtn3);
         _foldBtn3 = null;
         ObjectUtils.disposeObject(_foldBtn4);
         _foldBtn4 = null;
         _info = null;
         super.dispose();
      }
   }
}

