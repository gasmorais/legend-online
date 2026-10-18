package chat.view
{
   import chat.ChatManager;
   import chat.ChatModel;
   import chat.ChatSocketOutManager;
   import chat.datas.ChatChannel;
   import chat.utils.ChatHelper;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.pb.helper.item.ItemHelper;
   import com.road.yishi.proto.chat.ChatItemInfoMsg;
   import com.road.yishi.proto.chat.ChatPowCardInfoMsg;
   import com.road.yishi.proto.chat.ChatStarInfoMsg;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import mainBar.ChatBar;
   import manager.LanguageMgr;
   import mvc.module.card.MagicCardInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.star.StarInfo;
   import org.aswing.KeyboardManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.MagicCardTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.IMEManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.StringHelper;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class ChatInputViewII extends Sprite implements Disposeable
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _inputBack:ScaleBitmapImage;
      
      private var _inputChannelBtn:ChatPanelButton;
      
      private var _text:FilterFrameText;
      
      private var _friendsBtn:SelectedButton;
      
      private var _sendBtn:BaseButton;
      
      private var _expressionBtn:BaseButton;
      
      private var _cleanBtn:BaseButton;
      
      private var _channelList:InputChannelList;
      
      private var _expressionList:ExpressionList;
      
      private var _sendItemList:Vector.<GoodsInfo>;
      
      private var _sendStarList:Vector.<StarInfo>;
      
      private var _sendCardList:Vector.<MagicCardInfo>;
      
      private var _sendShareSpaceTime:Vector.<String>;
      
      private var _currentInChannel:int;
      
      private var _smallBugleCache:Object;
      
      private var _smallBulgeFlag:Boolean;
      
      private var _compareSpaceTimeStr:String = "";
      
      private var _currentChatStr:String = "";
      
      private var _flag:Boolean;
      
      public function ChatInputViewII()
      {
         super();
         IMEManager.enable();
         initView();
         initEvent();
         _sendItemList = new Vector.<GoodsInfo>();
         _sendStarList = new Vector.<StarInfo>();
         _sendCardList = new Vector.<MagicCardInfo>();
         _sendShareSpaceTime = new Vector.<String>();
         currentInChannel = chatModel.currentInChannel;
         _smallBugleCache = {};
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatInputBack1");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatInputBack2");
         _inputChannelBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.InputChannelBtn");
         _friendsBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatInputFriendsBtn");
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatSendBtn");
         _expressionBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatExpressionBtn");
         _cleanBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatCleanBtn");
         _text = ComponentFactory.Instance.creatComponentByStylename("chatII.InPutTxt");
         _text.maxChars = 84;
         addChild(_back);
         addChild(_inputBack);
         addChild(_text);
         addChild(_inputChannelBtn);
         addChild(_sendBtn);
         addChild(_expressionBtn);
         addChild(_cleanBtn);
         _sendBtn.tipData = LanguageMgr.GetTranslation("chat.view.ChatView.command03");
         _expressionBtn.tipData = LanguageMgr.GetTranslation("chat.view.ChatView.command06");
         _cleanBtn.tipData = LanguageMgr.GetTranslation("chat.view.ChatView.command02");
         _inputChannelBtn.text = ChatChannel.getChatChannelName(chatModel.currentInChannel);
         _inputChannelBtn.textField["textColor"] = ChatChannel.getChatChannelColoer(chatModel.currentInChannel);
      }
      
      public function initEvent() : void
      {
         KeyboardManager.getInstance().addEventListener("keyDown",__enterKeyDownHandler);
         NotificationManager.instance.addEventListener("INPUT_CHANNEL_CHANGE",__inputChannelChangeHandler);
         NotificationManager.instance.addEventListener("SEND_GOODS",__sendGoodsinfoHandler);
         NotificationManager.instance.addEventListener("SEND_STAR",__sendstarInfoHandler);
         NotificationManager.instance.addEventListener("SEND_CARD",__sendCardInfoHandler);
         NotificationManager.instance.addEventListener("SEND_SPACETIME_SHARE",__sendShareSpaceTimeHandler);
         thane.addEventListener("SMALL_BUGLE_FREE_COUNT",__smallBugleFreeCountHandler);
         _inputChannelBtn.addEventListener("mouseDown",__channelBtnDown);
         _inputChannelBtn.addEventListener("click",__channelBtnClick);
         _sendBtn.addEventListener("click",__sendClick);
         _expressionBtn.addEventListener("mouseDown",___expressionBtnDownHandler);
         _expressionBtn.addEventListener("click",___expressionBtnClickHandler);
         _cleanBtn.addEventListener("click",__clickHandler);
         _text.addEventListener("keyDown",__keyDown);
         _text.addEventListener("keyUp",__upDown);
         _text.addEventListener("focusIn",__focusIn);
         _text.addEventListener("focusOut",__focusOut);
      }
      
      public function removeEvent() : void
      {
         KeyboardManager.getInstance().removeEventListener("keyDown",__enterKeyDownHandler);
         NotificationManager.instance.removeEventListener("INPUT_CHANNEL_CHANGE",__inputChannelChangeHandler);
         NotificationManager.instance.removeEventListener("SEND_GOODS",__sendGoodsinfoHandler);
         NotificationManager.instance.removeEventListener("SEND_STAR",__sendstarInfoHandler);
         NotificationManager.instance.removeEventListener("SEND_CARD",__sendCardInfoHandler);
         NotificationManager.instance.removeEventListener("SEND_SPACETIME_SHARE",__sendShareSpaceTimeHandler);
         thane.removeEventListener("SMALL_BUGLE_FREE_COUNT",__smallBugleFreeCountHandler);
         _inputChannelBtn.removeEventListener("mouseDown",__channelBtnDown);
         _inputChannelBtn.removeEventListener("click",__channelBtnClick);
         _sendBtn.removeEventListener("click",__sendClick);
         _expressionBtn.removeEventListener("mouseDown",___expressionBtnDownHandler);
         _expressionBtn.removeEventListener("click",___expressionBtnClickHandler);
         _cleanBtn.removeEventListener("click",__clickHandler);
         _text.removeEventListener("keyDown",__keyDown);
         _text.removeEventListener("keyUp",__upDown);
         _text.removeEventListener("focusIn",__focusIn);
         _text.removeEventListener("focusOut",__focusOut);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         chatModel.clean();
      }
      
      private function __channelBtnDown(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __channelBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_channelList)
         {
            _channelList.dispose();
            return;
         }
         if(_expressionList)
         {
            _expressionList.dispose();
         }
         if(!_channelList)
         {
            _channelList = new InputChannelList();
         }
         _channelList.addEventListener("dispose",__onChannelListDispose);
         var _loc2_:Point = new Point(_inputChannelBtn.x,_inputChannelBtn.y);
         _channelList.x = _inputChannelBtn.localToGlobal(_loc2_).x - 7;
         _channelList.y = _inputChannelBtn.localToGlobal(_loc2_).y - _channelList.height - 5;
         LayerManager.Instance.addToLayer(_channelList,0);
      }
      
      public function closeChannel() : void
      {
         if(_channelList)
         {
            _channelList.dispose();
         }
         _channelList = null;
      }
      
      private function __onChannelListDispose(param1:Event) : void
      {
         _channelList.removeEventListener("dispose",__onChannelListDispose);
         _channelList = null;
      }
      
      private function __focusIn(param1:FocusEvent) : void
      {
         IMEManager.enable();
      }
      
      private function __focusOut(param1:FocusEvent) : void
      {
         IMEManager.disable();
      }
      
      private function __sendClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("006");
         sendChat();
         if(ChatBar.inBattleFlag)
         {
            visible = false;
         }
      }
      
      private function ___expressionBtnDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function ___expressionBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_expressionList)
         {
            _expressionList.dispose();
            return;
         }
         if(_channelList)
         {
            _channelList.dispose();
         }
         if(!_expressionList)
         {
            _expressionList = new ExpressionList();
         }
         _expressionList.addEventListener("dispose",__onExpressionListDispose);
         var _loc2_:Point = new Point(_expressionBtn.x,_expressionBtn.y);
         _expressionList.x = localToGlobal(_loc2_).x;
         _expressionList.y = localToGlobal(_loc2_).y - _expressionList.height - 10;
         _expressionList.input = _text;
         LayerManager.Instance.addToLayer(_expressionList,0);
      }
      
      private function __onExpressionListDispose(param1:Event) : void
      {
         _expressionList.removeEventListener("dispose",__onExpressionListDispose);
         _expressionList = null;
      }
      
      private function __cleanHandler(param1:MouseEvent) : void
      {
         chatModel.clean();
      }
      
      private function __enterKeyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:Object = null;
         if(param1.keyCode == 13)
         {
            _loc2_ = StageReferance.stage.focus;
            if(_loc2_ is Frame)
            {
               return;
            }
            if(_loc2_ is TextField && _loc2_.type == "input")
            {
               return;
            }
            StageReferance.stage.focus = _text;
         }
      }
      
      private function __sendGoodsinfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:GoodsInfo = param1.data as GoodsInfo;
         _sendItemList.push(_loc2_);
         _text.text += "[" + _loc2_.templateInfo.TemplateName + "]";
         checkLength();
      }
      
      private function __sendstarInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:StarInfo = param1.data as StarInfo;
         _sendStarList.push(_loc2_);
         _text.text += "[" + _loc2_.template.TemplateName + "]";
         checkLength();
      }
      
      private function __sendShareSpaceTimeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = param1.data as String;
         var _loc3_:XML = new XML(_loc2_);
         _sendShareSpaceTime.push(_loc2_);
         _text.text += "[" + _loc3_.@name + "]";
         checkLength();
         if(_compareSpaceTimeStr == "")
         {
            _compareSpaceTimeStr += _loc3_.@data;
         }
         else
         {
            _compareSpaceTimeStr += "@" + _loc3_.@data;
         }
      }
      
      private function __sendCardInfoHandler(param1:NotificationEvent) : void
      {
         var _loc3_:MagicCardInfo = param1.data as MagicCardInfo;
         _sendCardList.push(_loc3_);
         var _loc2_:MagicCardTemplateInfo = TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(_loc3_.types,_loc3_.pos,_loc3_.grades);
         _text.text += "[" + _loc2_.TemplateName + "]";
         checkLength();
      }
      
      private function checkLength() : void
      {
         var _loc1_:int = _text.text.length;
         if(_loc1_ > 84)
         {
            _text.text = _text.text.substr(0,84);
         }
         _text.setSelection(_loc1_,_loc1_);
      }
      
      private function __inputChannelChangeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = param1.data;
         if(_loc2_ == 3 || _loc2_ == 2 || _loc2_ == 11 || _loc2_ == 12 || _loc2_ == 108 || _loc2_ == 13)
         {
            return;
         }
         currentInChannel = param1.data;
      }
      
      public function get currentInChannel() : int
      {
         return _currentInChannel;
      }
      
      public function set currentInChannel(param1:int) : void
      {
         chatModel.currentInChannel = param1;
         if(_currentInChannel == param1)
         {
            return;
         }
         _currentInChannel = param1;
         _inputChannelBtn.text = ChatChannel.getChatChannelName(_currentInChannel);
         _inputChannelBtn.textField["textColor"] = ChatChannel.getChatChannelColoer(_currentInChannel);
         StageReferance.stage.focus = _text;
         _text.defaultTextFormat = ChatChannel.getChannelFormat(currentInChannel);
         _text.setTextFormat(ChatChannel.getChannelFormat(currentInChannel));
      }
      
      private function __upDown(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
         if(param1.keyCode == 38)
         {
            _text.setSelection(_text.length,_text.length);
         }
      }
      
      private function __keyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:String = null;
         if(param1.keyCode == 13)
         {
            if(_text.text)
            {
               sendChat();
               param1.stopPropagation();
               if(ChatBar.inBattleFlag)
               {
                  visible = false;
               }
            }
            else if(!ChatBar.inBattleFlag)
            {
               StageReferance.stage.focus = StageReferance.stage;
               param1.stopPropagation();
            }
         }
         else if(param1.keyCode == 38)
         {
            if(chatModel.allSendChats.length <= 0)
            {
               return;
            }
            _loc2_ = chatModel.allSendChats[chatModel.sendIndex];
            if(_loc2_)
            {
               _text.text = _loc2_;
               _text.setSelection(_text.length,_text.length);
            }
            chatModel.sendIndex--;
            if(chatModel.sendIndex < 0)
            {
               chatModel.sendIndex = 0;
            }
         }
         else if(param1.keyCode == 40)
         {
            if(chatModel.allSendChats.length <= 0)
            {
               return;
            }
            chatModel.sendIndex++;
            if(chatModel.allSendChats.length == chatModel.sendIndex)
            {
               chatModel.sendIndex = chatModel.allSendChats.length - 1;
               return;
            }
            _loc2_ = chatModel.allSendChats[chatModel.sendIndex];
            if(_loc2_)
            {
               _text.text = _loc2_;
            }
         }
      }
      
      private function sendChat() : void
      {
         var _loc7_:int = 0;
         var _loc18_:String = null;
         var _loc8_:Array = null;
         var _loc9_:ChatItemInfoMsg = null;
         var _loc5_:ChatStarInfoMsg = null;
         var _loc16_:ChatPowCardInfoMsg = null;
         var _loc2_:XML = null;
         var _loc12_:String = _text.text;
         var _loc6_:int = 0;
         var _loc21_:String = _loc12_.toLocaleLowerCase();
         var _loc3_:Array = ChatChannel.chanel_key_set.slice(0);
         var _loc17_:Array = ChatChannel.channels.slice(0);
         if(FrameControllerManager.instance.outyardControler.isOutyardMapApply)
         {
            _loc3_.splice(2,1);
            _loc17_.splice(2,1);
         }
         else
         {
            _loc3_.splice(7,1);
            _loc17_.splice(7,1);
         }
         if(_loc21_.indexOf("/") == 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               _loc7_ = _loc21_.indexOf("/" + _loc3_[_loc6_]);
               if(_loc7_ == 0)
               {
                  _loc12_ = _loc12_.substring(2,_loc12_.length);
                  _currentInChannel == _loc3_[_loc6_];
                  NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",_loc17_[_loc6_]);
               }
               _loc6_++;
            }
         }
         var _loc11_:Array = _loc12_.match(/\[([^\]]*)\]*/g);
         var _loc13_:int = int(_loc11_.length);
         var _loc19_:Array = [];
         var _loc20_:Array = [];
         var _loc10_:Array = [];
         var _loc14_:Array = [];
         if(_loc13_ > 0)
         {
            _loc8_ = _compareSpaceTimeStr.split("@");
            _loc6_ = 0;
            while(_loc6_ < _loc13_)
            {
               for each(var _loc22_:GoodsInfo in _sendItemList)
               {
                  _loc18_ = _loc11_[_loc6_].toString().substr(1,_loc11_[_loc6_].toString().length - 2);
                  if(_loc22_.templateInfo.TemplateName == _loc18_)
                  {
                     _loc9_ = ItemHelper.createChatItemInfoMsg(_loc22_,_loc18_);
                     _loc19_.push(_loc9_);
                     break;
                  }
               }
               for each(var _loc4_:StarInfo in _sendStarList)
               {
                  _loc18_ = _loc11_[_loc6_].toString().substr(1,_loc11_[_loc6_].toString().length - 2);
                  if(_loc4_.template.TemplateName == _loc18_)
                  {
                     _loc5_ = new ChatStarInfoMsg();
                     _loc5_.templateId = _loc4_.tempId;
                     _loc5_.grade = _loc4_.grade;
                     _loc5_.starName = _loc18_;
                     _loc20_.push(_loc5_);
                     break;
                  }
               }
               for each(var _loc15_:MagicCardInfo in _sendCardList)
               {
                  _loc18_ = _loc11_[_loc6_].toString().substr(1,_loc11_[_loc6_].toString().length - 2);
                  if(_loc15_.magicCardTemplate.TemplateName == _loc18_)
                  {
                     _loc16_ = new ChatPowCardInfoMsg();
                     _loc16_.templateId = _loc15_.templateId;
                     _loc16_.grade = _loc15_.grades;
                     _loc16_.powcardName = _loc18_;
                     _loc10_.push(_loc16_);
                     break;
                  }
               }
               for each(var _loc1_:String in _sendShareSpaceTime)
               {
                  _loc18_ = String(_loc8_[_loc6_]);
                  _loc2_ = new XML(_loc1_);
                  if(_loc18_ == _loc2_.@data)
                  {
                     _loc14_.push(_loc1_);
                     break;
                  }
               }
               _loc6_++;
            }
         }
         _currentChatStr = ChatHelper.parasMsgs(_loc12_);
         if(!ChatHelper.checkCanSend(_currentChatStr,_currentInChannel))
         {
            _text.text = "";
            _compareSpaceTimeStr = "";
            return;
         }
         SoundManager.instance.play("006");
         if(playerInfo.right != 1)
         {
            _currentChatStr = StringHelper.rePlaceHtmlTextField(_loc12_);
         }
         if(_currentInChannel == 8 && playerInfo.right == 1)
         {
            if(ChatHelper.checkSceneType())
            {
               ChatHelper.lastSendTime1 = getTimer();
            }
            else
            {
               ChatHelper.lastSendTime2 = getTimer();
            }
         }
         else
         {
            if(_currentInChannel == 1)
            {
               bigBugleHandler(_currentChatStr,_loc19_,_loc20_,_loc10_,_loc14_);
               return;
            }
            if(_currentInChannel == 10)
            {
               ChatHelper.lastSendTime3 = getTimer();
               smallBugleHandler(_currentChatStr,_loc19_,_loc20_,_loc10_,_loc14_);
               return;
            }
            if(_currentInChannel == 109)
            {
               ChatHelper.lastSendTime3 = getTimer();
               outyardHandler(_currentChatStr,_loc19_,_loc20_,_loc10_,_loc14_);
               return;
            }
            if(_currentInChannel == 13)
            {
               crossBugleHandler(_currentChatStr,_loc19_,_loc20_,_loc10_,_loc14_);
               return;
            }
         }
         ChatManager.instance.chatNormal(_currentChatStr,_currentInChannel,"",_loc19_,_loc20_,_loc10_,_loc14_);
         _text.text = "";
         _compareSpaceTimeStr = "";
      }
      
      private function crossBugleHandler(param1:String, param2:Array, param3:Array, param4:Array, param5:Array = null) : void
      {
         var _loc6_:int = 0;
         var _loc7_:String = null;
         if(!_flag)
         {
            _loc6_ = GoodsManager.instance.getGoodsNumByTempId(2170005);
            if(_loc6_ == 0)
            {
               _loc7_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command06");
               MessageTipManager.instance().show(_loc7_);
               CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback,[2170005,param2,param3,null,param5]);
               return;
            }
         }
         ChatManager.instance.chatByCross(param1,param2,param3,param4,param5);
         _text.text = "";
         _compareSpaceTimeStr = "";
      }
      
      private function outyardHandler(param1:String, param2:Array, param3:Array, param4:Array, param5:Array = null) : void
      {
         if(_flag)
         {
         }
         ChatManager.instance.chatByOutyard(param1,param2,param3,param4,param5);
         _text.text = "";
         _compareSpaceTimeStr = "";
      }
      
      private function bigBugleHandler(param1:String, param2:Array, param3:Array, param4:Array, param5:Array = null) : void
      {
         var _loc6_:int = 0;
         var _loc7_:String = null;
         if(!_flag)
         {
            _loc6_ = GoodsManager.instance.getGoodsNumByTempId(208002);
            if(_loc6_ == 0)
            {
               _loc7_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command06");
               MessageTipManager.instance().show(_loc7_);
               CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback,[208002,param2,param3,null,param5]);
               return;
            }
         }
         ChatManager.instance.chatByBugle(param1,param2,param3,param4,param5);
         _text.text = "";
         _compareSpaceTimeStr = "";
      }
      
      private function quickUIcallback(param1:Array) : void
      {
         var _loc2_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc3_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(param1[0]);
         _loc2_.data(_loc3_,1,param1);
         _loc2_.show();
         _loc2_.callback = shopBugleBack;
      }
      
      private function smallBugleHandler(param1:String, param2:Array, param3:Array, param4:Array, param5:Array = null) : void
      {
         var _loc6_:int = 0;
         var _loc7_:String = null;
         _smallBugleCache["str"] = param1;
         _smallBugleCache["itemList"] = param2;
         _smallBugleCache["starList"] = param3;
         _smallBugleCache["cardList"] = param4;
         _smallBugleCache["shareSpaceList"] = param5;
         if(!_flag)
         {
            _loc6_ = GoodsManager.instance.getGoodsNumByTempId(208003);
            if(_loc6_ == 0)
            {
               if(thane.smallBugleFreeCount <= 0)
               {
                  _loc7_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command06");
                  MessageTipManager.instance().show(_loc7_);
                  CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback,[208003,param2,param3,null,param5]);
                  return;
               }
               _smallBulgeFlag = true;
               ChatSocketOutManager.sendSmallBugleFreeCount();
               return;
            }
         }
         ChatManager.instance.chatBySmallBugle(param1,param2,param3,param4,param5);
         _text.text = "";
         _compareSpaceTimeStr = "";
      }
      
      private function __smallBugleFreeCountHandler(param1:PlayerEvent) : void
      {
         var _loc5_:int = 0;
         var _loc8_:String = null;
         if(!_smallBulgeFlag)
         {
            return;
         }
         _smallBulgeFlag = false;
         var _loc2_:String = _smallBugleCache["str"];
         var _loc6_:Array = _smallBugleCache["itemList"];
         var _loc7_:Array = _smallBugleCache["starList"];
         var _loc3_:Array = _smallBugleCache["cardList"];
         var _loc4_:Array = _smallBugleCache["shareSpaceList"];
         if(!_flag)
         {
            _loc5_ = GoodsManager.instance.getGoodsNumByTempId(208003);
            if(_loc5_ == 0)
            {
               if(thane.smallBugleFreeCount <= 0)
               {
                  _loc8_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command06");
                  MessageTipManager.instance().show(_loc8_);
                  CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback,[208003,_loc6_,_loc7_,null,_loc4_]);
                  return;
               }
            }
         }
         ChatManager.instance.chatBySmallBugle(_loc2_,_loc6_,_loc7_,_loc3_,_loc4_);
         _text.text = "";
         _compareSpaceTimeStr = "";
      }
      
      private function shopBugleBack(param1:Boolean, param2:Object) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            _flag = true;
            _loc3_ = int(param2[0]);
            if(_loc3_ == 208003)
            {
               ChatManager.instance.chatBySmallBugle(_currentChatStr,param2[1] as Array,param2[2] as Array,param2[3] as Array,param2[4] as Array);
            }
            else if(_loc3_ == 208002)
            {
               ChatManager.instance.chatByBugle(_currentChatStr,param2[1] as Array,param2[2] as Array,param2[3] as Array,param2[4] as Array);
            }
            else if(_loc3_ == 2170005)
            {
               ChatManager.instance.chatByCross(_currentChatStr,param2[1] as Array,param2[2] as Array,param2[3] as Array,param2[4] as Array);
            }
            _text.text = "";
            _compareSpaceTimeStr = "";
            _flag = false;
         }
      }
      
      private function get chatModel() : ChatModel
      {
         return ChatManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get inputText() : FilterFrameText
      {
         return _text;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_inputBack);
         _inputBack = null;
         ObjectUtils.disposeObject(_inputChannelBtn);
         _inputChannelBtn = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_friendsBtn);
         _friendsBtn = null;
         ObjectUtils.disposeObject(_sendBtn);
         _sendBtn = null;
         ObjectUtils.disposeObject(_expressionBtn);
         _expressionBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

