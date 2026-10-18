package poker
{
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import chat.view.ExpressionList;
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.pet.PokerPlayerMsg;
   import com.road.yishi.proto.pet.TableChannelMessage;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.poker.PokerPlayerInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PokerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class PokerExchangeView extends Component
   {
      
      private var _blackGound:Sprite;
      
      private var _quitBtn:IconButton;
      
      private var _patternBtn:BaseButton;
      
      private var _expressionBtn:BaseButton;
      
      private var _quickerBtn:BaseButton;
      
      private var _sortList:PokerPatternList;
      
      private var _expressionList:ExpressionList;
      
      private var _quickerList:PokerChatList;
      
      private var _expressionTxt:FilterFrameText;
      
      private var _overTimeTxt:FilterFrameText;
      
      private var _chatBg:ScaleBitmapImage;
      
      private var _chatScroll:ScrollPanel;
      
      private var _chatVBox:VBox;
      
      private var _pokerData:Array = [];
      
      private var _clickTime:Number;
      
      public function PokerExchangeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _blackGound = new Sprite();
         _blackGound.graphics.clear();
         _blackGound.graphics.beginFill(0,0.8);
         _blackGound.graphics.drawRect(20,454,240,50);
         _blackGound.graphics.endFill();
         _quitBtn = ComponentFactory.Instance.creatComponentByStylename("poker.quitBtn");
         _patternBtn = ComponentFactory.Instance.creatComponentByStylename("poker.patternBtn");
         _expressionBtn = ComponentFactory.Instance.creatComponentByStylename("poker.expressionBtn");
         _quickerBtn = ComponentFactory.Instance.creatComponentByStylename("poker.quickerBtn");
         _expressionTxt = ComponentFactory.Instance.creatComponentByStylename("poker.exchangeTxt1");
         _overTimeTxt = ComponentFactory.Instance.creatComponentByStylename("poker.overTimeTxt");
         _chatBg = ComponentFactory.Instance.creatComponentByStylename("poker.chatBg");
         _chatScroll = ComponentFactory.Instance.creatComponentByStylename("poker.chatScroll");
         _chatVBox = ComponentFactory.Instance.creatComponentByStylename("poker.chatVBox");
         addChild(_blackGound);
         addChild(_quitBtn);
         addChild(_patternBtn);
         addChild(_expressionBtn);
         addChild(_quickerBtn);
         addChild(_expressionTxt);
         addChild(_overTimeTxt);
         addChild(_chatBg);
         addChild(_chatScroll);
         _chatScroll.setView(_chatVBox);
         _overTimeTxt.mask = _blackGound;
         _overTimeTxt.text = LanguageMgr.GetTranslation("poker.overTimeTxt.txt");
         _expressionTxt.visible = false;
      }
      
      private function addEvent() : void
      {
         _quitBtn.addEventListener("click",__onQuitHandler);
         _patternBtn.addEventListener("mouseDown",__patternDownHandler);
         _patternBtn.addEventListener("click",__patternHandler);
         _expressionBtn.addEventListener("click",__expressionBtnClickHandler);
         _quickerBtn.addEventListener("click",__quickerHandler);
         NotificationManager.instance.addEventListener("POKER_NEW_ROUND",__newRoundHandler);
         NotificationManager.instance.addEventListener("POKER_PLAYER_ACTED",__refreshPokerChatMsg);
         NotificationManager.instance.addEventListener("POKER_HAND_START",__handStartHandler);
         NotificationManager.instance.addEventListener("POKER_HAND_END",__handEndHandler);
      }
      
      private function removeEvent() : void
      {
         _quitBtn.removeEventListener("click",__onQuitHandler);
         _patternBtn.removeEventListener("mouseDown",__patternDownHandler);
         _patternBtn.removeEventListener("click",__patternHandler);
         _expressionBtn.removeEventListener("click",__expressionBtnClickHandler);
         _quickerBtn.removeEventListener("click",__quickerHandler);
         if(_sortList)
         {
            _sortList.removeEventListener("dispose",__onSortListDispose);
         }
         if(_expressionList)
         {
            _expressionList.removeEventListener("dispose",__onExpressionListDispose);
         }
         if(_quickerList)
         {
            _quickerList.removeEventListener("dispose",__onQuickerListDispose);
         }
         NotificationManager.instance.removeEventListener("POKER_NEW_ROUND",__newRoundHandler);
         NotificationManager.instance.removeEventListener("POKER_PLAYER_ACTED",__refreshPokerChatMsg);
         NotificationManager.instance.removeEventListener("POKER_HAND_START",__handStartHandler);
         NotificationManager.instance.removeEventListener("POKER_HAND_END",__handEndHandler);
      }
      
      public function refreshView(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         _overTimeTxt.x = 259;
         TweenMax.killTweensOf(_overTimeTxt);
         TweenMax.to(_overTimeTxt,10,{
            "delay":1,
            "x":-475,
            "ease":Linear.easeNone
         });
         _chatVBox.disposeAllChildren();
         createChatNotice(LanguageMgr.GetTranslation("PokerExchangeView.game.welcome"));
      }
      
      private function __refreshPokerChatMsg(param1:NotificationEvent) : void
      {
         var _loc2_:PokerPlayerInfo = param1.data as PokerPlayerInfo;
         if(!_loc2_)
         {
            return;
         }
         createChatNotice(getChatMsgByPokerPlayerInfo(_loc2_));
      }
      
      private function __handStartHandler(param1:NotificationEvent) : void
      {
         createChatNotice(LanguageMgr.GetTranslation("PokerExchangeView.game.start"));
      }
      
      private function __handEndHandler(param1:NotificationEvent) : void
      {
         createChatNotice(LanguageMgr.GetTranslation("PokerExchangeView.game.over"));
      }
      
      private function createChatNotice(param1:String) : void
      {
         _chatVBox.beginChanges();
         var _loc2_:PokerNotic = new PokerNotic();
         var _loc3_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc3_.channel = 107;
         _loc3_.msg = param1;
         _loc3_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc3_);
         _loc2_.data = _loc3_;
         _chatVBox.addChild(_loc2_);
         _chatVBox.commitChanges();
         _chatScroll.invalidateViewport(true);
      }
      
      private function __newRoundHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         _pokerData = [];
         var _loc2_:Array = PokerManager.instance.pokerPlayerArr;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _pokerData.push({
               "userId":_loc2_[_loc3_].userId,
               "bet":_loc2_[_loc3_].bet
            });
            _loc3_++;
         }
      }
      
      private function getChatMsgByPokerPlayerInfo(param1:PokerPlayerInfo) : String
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc2_:String = "";
         var _loc5_:String = "";
         var _loc6_:String = "";
         switch(int(param1.action) - 1)
         {
            case 0:
            case 1:
            case 6:
               _loc5_ = LanguageMgr.GetTranslation("PokerExchangeView.game.action1");
               break;
            default:
               _loc5_ = LanguageMgr.GetTranslation("PokerExchangeView.game.action" + param1.action);
         }
         _loc4_ = 0;
         while(_loc4_ < _pokerData.length)
         {
            if(_pokerData[_loc4_].userId == param1.userId)
            {
               _loc3_ = _pokerData[_loc4_];
            }
            _loc4_++;
         }
         if(_loc3_ && param1.bet != 0 && param1.bet - _loc3_.bet > 0)
         {
            _loc6_ = (param1.bet - _loc3_.bet).toString();
         }
         if(_loc3_)
         {
            _loc3_.bet = param1.bet;
         }
         return LanguageMgr.GetTranslation("PokerExchangeView.game.chatNotic.chatMsg",param1.userName,_loc5_,_loc6_);
      }
      
      private function __onQuitHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!PokerManager.instance.checkPlayerActive())
         {
            __alertBackHandler(true,true);
            return;
         }
         SimpleAlertHelper.instance.data = [__alertBackHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("poker.PokerFrame.quitPool");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:PlayerInfo = null;
         var _loc5_:int = 0;
         var _loc4_:String = null;
         if(param1)
         {
            _loc3_ = PlayerManager.instance.currentPlayerModel.playerInfo;
            _loc5_ = int(_loc3_.userId);
            _loc4_ = _loc3_.serviceName;
            PokerManager.instance.StopPoker(_loc5_,_loc4_);
         }
      }
      
      private function __patternDownHandler(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function __patternHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(_sortList)
         {
            _sortList.dispose();
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_sortList)
         {
            _sortList = new PokerPatternList();
         }
         _sortList.addEventListener("dispose",__onSortListDispose);
         var _loc2_:Point = new Point(_patternBtn.x,_patternBtn.y);
         _sortList.x = localToGlobal(_loc2_).x + 70;
         _sortList.y = localToGlobal(_loc2_).y + 10;
         LayerManager.Instance.addToLayer(_sortList,7);
      }
      
      private function __onSortListDispose(param1:Event) : void
      {
         _sortList.removeEventListener("dispose",__onSortListDispose);
         _sortList = null;
      }
      
      private function __expressionBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _expressionTxt.text = "";
         if(_expressionList)
         {
            _expressionList.dispose();
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_expressionList)
         {
            _expressionList = new ExpressionList();
         }
         _expressionList.addEventListener("dispose",__onExpressionListDispose);
         var _loc2_:Point = new Point(_expressionBtn.x,_expressionBtn.y);
         _expressionList.x = localToGlobal(_loc2_).x - _expressionList.width / 2 + 50;
         _expressionList.y = localToGlobal(_loc2_).y - _expressionList.height - 10;
         _expressionList.input = _expressionTxt;
         LayerManager.Instance.addToLayer(_expressionList,7);
      }
      
      private function __onExpressionListDispose(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:TableChannelMessage = null;
         _expressionList.removeEventListener("dispose",__onExpressionListDispose);
         _expressionList = null;
         if(_expressionTxt.text != "")
         {
            if(getTimer() - _clickTime < 5000)
            {
               _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            _clickTime = getTimer();
            _loc3_ = new TableChannelMessage();
            _loc3_.type = 1;
            _loc3_.msg = _expressionTxt.text;
            _loc3_.source = new PokerPlayerMsg();
            _loc3_.source.userId = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
            _loc3_.source.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
            PokerManager.instance.StartPoker(5,0,_loc3_);
         }
      }
      
      private function __quickerHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(_quickerList)
         {
            _quickerList.dispose();
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_quickerList)
         {
            _quickerList = new PokerChatList();
         }
         _quickerList.addEventListener("dispose",__onQuickerListDispose);
         var _loc2_:Point = new Point(_quickerBtn.x,_quickerBtn.y);
         _quickerList.x = localToGlobal(_loc2_).x + 10;
         _quickerList.y = localToGlobal(_loc2_).y - _quickerList.height - 10;
         LayerManager.Instance.addToLayer(_quickerList,7);
      }
      
      private function __onQuickerListDispose(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:TableChannelMessage = null;
         var _loc4_:String = _quickerList.msgStr;
         _quickerList.removeEventListener("dispose",__onQuickerListDispose);
         _quickerList = null;
         if(_loc4_ != "")
         {
            if(getTimer() - _clickTime < 5000)
            {
               _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            _clickTime = getTimer();
            _loc3_ = new TableChannelMessage();
            _loc3_.type = 2;
            _loc3_.msg = _loc4_;
            _loc3_.source = new PokerPlayerMsg();
            _loc3_.source.userId = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
            _loc3_.source.serverName = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
            PokerManager.instance.StartPoker(5,0,_loc3_);
         }
      }
      
      private function get palyerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _pokerData = null;
         _overTimeTxt.mask = null;
         TweenMax.killTweensOf(_overTimeTxt);
         ObjectUtils.disposeObject(_blackGound);
         _blackGound = null;
         ObjectUtils.disposeObject(_quitBtn);
         _quitBtn = null;
         ObjectUtils.disposeObject(_patternBtn);
         _patternBtn = null;
         ObjectUtils.disposeObject(_expressionBtn);
         _expressionBtn = null;
         ObjectUtils.disposeObject(_quickerBtn);
         _quickerBtn = null;
         ObjectUtils.disposeObject(_sortList);
         _sortList = null;
         ObjectUtils.disposeObject(_expressionList);
         _expressionList = null;
         ObjectUtils.disposeObject(_quickerList);
         _quickerList = null;
         ObjectUtils.disposeObject(_expressionTxt);
         _expressionTxt = null;
         ObjectUtils.disposeObject(_overTimeTxt);
         _overTimeTxt = null;
         ObjectUtils.disposeObject(_chatBg);
         _chatBg = null;
         ObjectUtils.disposeAllChildren(_chatVBox);
         _chatVBox = null;
         ObjectUtils.disposeObject(_chatVBox);
         _chatVBox = null;
         ObjectUtils.disposeObject(_chatScroll);
         _chatScroll = null;
         super.dispose();
      }
   }
}

