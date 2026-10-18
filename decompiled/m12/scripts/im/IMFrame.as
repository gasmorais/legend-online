package im
{
   import chat.datas.ChatData;
   import chat.view.ExpressionList;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import events.FriendUpdateEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import im.view.IMChatInfoView;
   import im.view.IMChatInputView;
   import im.view.IMFriendInfoView;
   import im.view.IMHistoryView;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.FriendSocketOutManager;
   import managers.IMManager;
   import managers.MarryManager;
   import mvc.module.friends.BaseIMInfo;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.friends.IMEvent;
   import mvc.module.friends.IMFrameEvent;
   import simplegame.roses.IMQuickRosePresentView;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.RequestInfoEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SpaceTemplateManager;
   import yishi.scene.SceneManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class IMFrame extends Frame implements IManualSize
   {
      
      public var needDispose:Boolean = false;
      
      private var _scaleFrameBg:ScaleBitmapImage;
      
      private var _friendInfoView:IMFriendInfoView;
      
      private var _chatInfoView:IMChatInfoView;
      
      private var _chatInputView:IMChatInputView;
      
      private var _expressionList:ExpressionList;
      
      private var _expressionBtn:SelectedButton;
      
      private var _presentBtn:SelectedButton;
      
      private var _consortiaBtn:SelectedButton;
      
      private var _marryBtn:SelectedButton;
      
      private var _addFriendBtn:SelectedButton;
      
      private var _delFriendBtn:SelectedButton;
      
      private var _shieldBtn:SelectedButton;
      
      private var _copyBtn:SelectedButton;
      
      private var _cleanBtn:SelectedButton;
      
      private var _inviteBtn:SelectedButton;
      
      private var _checkHistoryBtn:TextButton;
      
      private var _btnContainer:Sprite;
      
      private var _sendMsgBtn:TextButton;
      
      private var _closeBtn:TextButton;
      
      private var _miniBtn:BaseButton;
      
      private var _data:ThaneInfo;
      
      private var _isMini:Boolean = false;
      
      private var _timeLimit:Boolean = false;
      
      private var _timerID:uint;
      
      private var _isRobot:Boolean = false;
      
      private var _timeId:int;
      
      private var _historyView:IMHistoryView;
      
      private var reg:RegExp = /\r/g;
      
      private var reg1:RegExp = /\n/g;
      
      public function IMFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _scaleFrameBg = ComponentFactory.Instance.creatComponentByStylename("core.IMFrameScaleBg");
         _friendInfoView = ComponentFactory.Instance.creatCustomObject("core.IMFriendInfoView");
         _chatInfoView = ComponentFactory.Instance.creatCustomObject("core.IMChatInfoView");
         _chatInputView = ComponentFactory.Instance.creatCustomObject("core.IMChatInputView");
         _expressionBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMExpressionBtn");
         _presentBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMPresentBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMConsortiaBtn");
         _marryBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMMarryBtn");
         _addFriendBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMAddFriendBtn");
         _delFriendBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMDelFriendBtn");
         _shieldBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMShieldBtn");
         _copyBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMCopyBtn");
         _cleanBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMCleanBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMInviteBtn");
         _checkHistoryBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMCheckHistoryBtn");
         _checkHistoryBtn.text = LanguageMgr.GetTranslation("friends.im.IMFrame.checkHistory");
         _sendMsgBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMSendMsgBtn");
         _sendMsgBtn.text = LanguageMgr.GetTranslation("friends.im.IMFrame.sendMsg");
         _sendMsgBtn.tipData = LanguageMgr.GetTranslation("friends.im.IMFrame.send");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMCloseBtn");
         _closeBtn.text = LanguageMgr.GetTranslation("public.close");
         _miniBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMMiniBtn");
         _presentBtn.tipData = LanguageMgr.GetTranslation("friends.im.IMFrame.present");
         _consortiaBtn.tipData = LanguageMgr.GetTranslation("friends.im.IMFrame.consortia");
         _marryBtn.tipData = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.propose");
         _addFriendBtn.tipData = LanguageMgr.GetTranslation("friends.im.IMFrame.addFriend");
         _delFriendBtn.tipData = LanguageMgr.GetTranslation("friends.im.IMFrame.delFriend");
         _shieldBtn.tipData = LanguageMgr.GetTranslation("friends.im.IMFrame.shield");
         _copyBtn.tipData = LanguageMgr.GetTranslation("friends.im.IMFrame.copy");
         _cleanBtn.tipData = LanguageMgr.GetTranslation("friends.im.IMFrame.clean");
         _inviteBtn.tipData = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.invite");
         addToContent(_scaleFrameBg);
         addToContent(_friendInfoView);
         addToContent(_chatInfoView);
         addToContent(_chatInputView);
         addToContent(_expressionBtn);
         addToContent(_presentBtn);
         addToContent(_consortiaBtn);
         addToContent(_marryBtn);
         addToContent(_addFriendBtn);
         addToContent(_delFriendBtn);
         addToContent(_shieldBtn);
         addToContent(_inviteBtn);
         addToContent(_copyBtn);
         addToContent(_cleanBtn);
         addToContent(_checkHistoryBtn);
         addToContent(_miniBtn);
         addToContent(_closeBtn);
         addToContent(_sendMsgBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _checkHistoryBtn.addEventListener("click",__onCheckHistoryClick);
         _closeBtn.addEventListener("click",__onCloseBtnClick);
         _miniBtn.addEventListener("click",__onMiniClick);
         _sendMsgBtn.addEventListener("click",__onSendMsgBtnClick);
         _expressionBtn.addEventListener("mouseDown",___expressionBtnDownHandler);
         _expressionBtn.addEventListener("click",___expressionBtnClickHandler);
         _expressionBtn.addEventListener("rollOver",___expressionBtnRollOverHandler);
         _presentBtn.addEventListener("click",__presentBtnClickHandler);
         _consortiaBtn.addEventListener("click",__consortiaBtnClickHandler);
         _marryBtn.addEventListener("click",__marryBtnClickHandler);
         _addFriendBtn.addEventListener("click",__addFriendBtnClickHandler);
         _delFriendBtn.addEventListener("click",__delFriendBtnClickHandler);
         _shieldBtn.addEventListener("click",__shieldBtnClickHandler);
         _copyBtn.addEventListener("click",__copyBtnClickHandler);
         _cleanBtn.addEventListener("click",__cleanBtnClickHandler);
         _inviteBtn.addEventListener("click",__inviteBtnClickHandler);
         _chatInputView.addEventListener("keyDown",__keyDownHandler);
         friendManager.addEventListener("FRIEND_UPDATE",__friendUpdateHandler);
         friendManager.addEventListener("REMOVE_FRIEND",__removeFriendHandler);
         playerManager.addEventListener("REQUEST_SIMPLEANDSNS_INFO",__requestPlayerInfoHandler);
         MsgMan.addObserver("CROSS_FRIENDS_UPDATE",this,__updateCrossState);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _checkHistoryBtn.removeEventListener("click",__onCheckHistoryClick);
         _closeBtn.removeEventListener("click",__onCloseBtnClick);
         _miniBtn.removeEventListener("click",__onMiniClick);
         _sendMsgBtn.removeEventListener("click",__onSendMsgBtnClick);
         _expressionBtn.removeEventListener("mouseDown",___expressionBtnDownHandler);
         _expressionBtn.removeEventListener("click",___expressionBtnClickHandler);
         _expressionBtn.removeEventListener("rollOver",___expressionBtnRollOverHandler);
         _presentBtn.removeEventListener("click",__presentBtnClickHandler);
         _consortiaBtn.removeEventListener("click",__consortiaBtnClickHandler);
         _marryBtn.removeEventListener("click",__marryBtnClickHandler);
         _addFriendBtn.removeEventListener("click",__addFriendBtnClickHandler);
         _delFriendBtn.removeEventListener("click",__delFriendBtnClickHandler);
         _shieldBtn.removeEventListener("click",__shieldBtnClickHandler);
         _copyBtn.removeEventListener("click",__copyBtnClickHandler);
         _cleanBtn.removeEventListener("click",__cleanBtnClickHandler);
         _inviteBtn.removeEventListener("click",__inviteBtnClickHandler);
         _chatInputView.removeEventListener("keyDown",__keyDownHandler);
         friendManager.removeEventListener("FRIEND_UPDATE",__friendUpdateHandler);
         friendManager.removeEventListener("REMOVE_FRIEND",__removeFriendHandler);
         playerManager.removeEventListener("REQUEST_SIMPLEANDSNS_INFO",__requestPlayerInfoHandler);
         MsgMan.removeObserver("CROSS_FRIENDS_UPDATE",this,__updateCrossState);
      }
      
      private function __updateCrossState(param1:String, param2:Object) : void
      {
         if(_data && isCross)
         {
            _data = friendManager.getCrossThaneInfoByUuid(_data.uuid);
            if(_data)
            {
               refreshView();
            }
         }
      }
      
      private function __inviteBtnClickHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            FreedomTeamManager.instance.inviteMember(_data.userId);
         }
      }
      
      private function __requestPlayerInfoHandler(param1:RequestInfoEvent) : void
      {
         var _loc2_:ThaneInfo = null;
         if(_data && param1.data && !isCross && _data.userId == param1.data.userId)
         {
            _loc2_ = imManager.getFriendInfo(_data.userId);
            if(_loc2_)
            {
               _data = _loc2_;
            }
            else
            {
               _data = param1.data;
            }
            refreshView();
         }
         else if(param1.data && param1.data.userId == 0)
         {
            if(!_data)
            {
               dispose();
               return;
            }
            _loc2_ = FriendManager.getInstance().getCrossThaneInfoByUuid(_data.uuid);
            if(!_loc2_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("chat.view.ChatItemMenu.addFriend.alert"));
               dispose();
               return;
            }
         }
      }
      
      private function __removeFriendHandler(param1:FriendUpdateEvent) : void
      {
         var _loc2_:int = int(param1.object);
         if(!data || _loc2_ == data.userId)
         {
            dispose();
         }
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               needDispose = true;
               dispose();
         }
      }
      
      private function ___expressionBtnDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function ___expressionBtnClickHandler(param1:MouseEvent) : void
      {
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
         _expressionList.y = localToGlobal(_loc2_).y - _expressionList.height + 55;
         _expressionList.input = _chatInputView.textField;
         LayerManager.Instance.addToLayer(_expressionList,7);
      }
      
      private function ___expressionBtnRollOverHandler(param1:MouseEvent) : void
      {
         if(_expressionList)
         {
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
         _expressionList.y = localToGlobal(_loc2_).y - _expressionList.height + 55;
         _expressionList.input = _chatInputView.textField;
         LayerManager.Instance.addToLayer(_expressionList,7);
      }
      
      private function __onExpressionListDispose(param1:Event) : void
      {
         _expressionList.removeEventListener("dispose",__onExpressionListDispose);
         _expressionList = null;
      }
      
      private function __presentBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_data)
         {
            if(_isRobot)
            {
               _loc2_ = LanguageMgr.GetTranslation("friends.im.IMFrame.present.NotFriends");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(IMQuickRosePresentView.getFriendInfoByName(_data.nickName) == null)
            {
               _loc2_ = LanguageMgr.GetTranslation("friends.im.IMFrame.present.NotFriends");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(IMQuickRosePresentView.getHaveRoseNumber() == 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("friends.im.IMFrame.present.TipTxt");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            FrameControllerManager.instance.friendControler.startFrameByType(6,[_data.nickName]);
         }
      }
      
      private function __marryBtnClickHandler(param1:MouseEvent) : void
      {
         if(ArmyManager.instance.thane.grades < 36)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",36));
         }
         else if(!MarryManager.instance.model.isSingle)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.IMFrame.hasLover"));
         }
         else if(_data)
         {
            MarryManager.instance.creatProposeQuestFrame(_data.userId);
         }
      }
      
      private function __consortiaBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_data)
         {
            if(_isRobot)
            {
               return;
            }
            if(!FrameControllerManager.instance.consortiaController.getRightsByIndex(9))
            {
               _loc2_ = LanguageMgr.GetTranslation("friends.im.IMFrame.consortia.TipTxt1");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(playerManager.currentPlayerModel.playerInfo.consortiaID <= 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("friends.im.IMFrame.consortia.TipTxt2");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            FrameControllerManager.instance.consortiaController.sendConsortiaInvitePlayer(_data.userId);
         }
      }
      
      private function __addFriendBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_data)
         {
            if(_isRobot)
            {
               _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatItemMenu.RobotTips01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(isCross)
            {
               if(friendManager.crossFriendList[_data.uuid] || friendManager.crossStrangerList[_data.uuid])
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.FriendManager.command05"));
                  return;
               }
               FriendManager.getInstance().sendCrossFriendRequest(0,_data.uuid);
            }
            else
            {
               friendManager.sendAddFriendRequest(_data.nickName,1);
            }
         }
      }
      
      private function __delFriendBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc7_:int = 0;
         var _loc5_:FriendItemCellInfo = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         if(_data)
         {
            if(_isRobot)
            {
               return;
            }
            _loc7_ = 0;
            if(isCross && Boolean(_data.hasOwnProperty("uuid")) && _data["uuid"])
            {
               if(FriendManager.getInstance().crossFriendList[_data.uuid])
               {
                  _loc7_ = 1;
               }
               else if(FriendManager.getInstance().crossBlackList[_data.uuid])
               {
                  _loc7_ = 2;
               }
               else if(FriendManager.getInstance().crossStrangerList[_data.uuid])
               {
                  _loc7_ = 3;
               }
            }
            else
            {
               _loc5_ = IMManager.instance.getFriendInfo(_data.userId);
               if(_loc5_)
               {
                  _loc7_ = int(_loc5_.relation);
               }
            }
            switch(_loc7_ - 2)
            {
               case 0:
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.str02");
                  break;
               case 1:
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.delStrangerTip");
                  break;
               case 2:
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.str01");
                  break;
               default:
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.str03");
            }
            if(_loc7_ == 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.view.IMFrame.delAlert"));
               return;
            }
            SimpleAlertHelper.instance.data = [_delFriendResponse,_loc5_,_loc7_];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc2_,_loc3_,_loc4_,true,false,false);
         }
      }
      
      private function _delFriendResponse(param1:Boolean, param2:Boolean, param3:FriendItemCellInfo, param4:int) : void
      {
         if(param1)
         {
            if(isCross)
            {
               if(param4 == 2)
               {
                  FriendManager.getInstance().sendCrossFriendRequest(3,_data.uuid);
               }
               else
               {
                  FriendManager.getInstance().sendCrossFriendRequest(1,_data.uuid);
               }
            }
            else if(param3)
            {
               if(param3.relation == 4)
               {
                  FriendManager.getInstance().removePrivatePerson(param3.userId);
               }
               else
               {
                  FriendManager.getInstance().sendRemoveFriendRequest(param3.userId);
               }
            }
            dispose();
         }
      }
      
      private function __shieldBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_data)
         {
            if(_isRobot)
            {
               _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatItemMenu.RobotTips02");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(isCross)
            {
               if(friendManager.crossBlackList[_data.uuid])
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.FriendManager.command05"));
                  return;
               }
               FriendManager.getInstance().sendCrossFriendRequest(2,_data.uuid);
            }
            else
            {
               FriendManager.getInstance().sendAddFriendRequest(_data.nickName,2);
            }
         }
      }
      
      private function __copyBtnClickHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            System.setClipboard(_data.nickName);
         }
      }
      
      private function __cleanBtnClickHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _chatInfoView.cleanView();
         }
      }
      
      private function __friendUpdateHandler(param1:FriendUpdateEvent) : void
      {
         if(!_data)
         {
         }
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __onSendMsgBtnClick(null);
            if(_timeId > 0)
            {
               clearInterval(_timeId);
            }
            _timeId = 0;
            _timeId = setInterval(clear,30);
         }
         param1.stopPropagation();
      }
      
      private function clear() : void
      {
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         if(_chatInputView)
         {
            _chatInputView.clear();
            _chatInputView.setFocus();
         }
      }
      
      private function __onCheckHistoryClick(param1:MouseEvent) : void
      {
         if(!_historyView)
         {
            _historyView = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryView");
            _historyView.addEventListener("dispose",__disposeHandler);
            _historyView.data = _data;
            _historyView.show(this);
         }
         else
         {
            _historyView.dispose();
         }
      }
      
      private function __disposeHandler(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("dispose",__disposeHandler);
         _historyView = null;
      }
      
      private function __onCloseBtnClick(param1:MouseEvent) : void
      {
         needDispose = true;
         dispose();
      }
      
      private function __onMiniClick(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         _isMini = true;
         if(_historyView)
         {
            _historyView.dispose();
         }
         if(_friendInfoView && _friendInfoView.moodTxt)
         {
            _friendInfoView.moodTxt.visible = false;
         }
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            _loc2_ = new Point(StageReferance.stageWidth / 2 + 188,StageReferance.stageHeight - 108);
         }
         else
         {
            _loc2_ = new Point(MainToolBar.instance.x + MainToolBar.instance.getFriendsBtnX(),StageReferance.stageHeight - 40);
         }
         TweenMax.to(this,1,{
            "x":_loc2_.x,
            "y":_loc2_.y,
            "scaleX":0,
            "scaleY":0,
            "onComplete":miniCompleteHandler
         });
      }
      
      private function miniCompleteHandler() : void
      {
         if(parent)
         {
            parent.removeChild(this);
            imManager.dispatchFrameRemoveEvent();
         }
      }
      
      private function __onSendMsgBtnClick(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:ChatData = null;
         var _loc5_:BaseIMInfo = null;
         var _loc6_:FriendItemCellInfo = null;
         var _loc2_:String = _chatInputView.text;
         if(_data)
         {
            _loc2_ = _loc2_.replace(reg,"");
            _loc2_ = _loc2_.replace(reg1,"");
            _loc3_ = "";
            if(StringHelper.isNullOrEmpty(_loc2_))
            {
               if(param1)
               {
                  _loc3_ = LanguageMgr.GetTranslation("friends.im.IMFrame.command01");
                  MessageTipManager.instance().show(_loc3_);
               }
               return;
            }
            if(!_isRobot && !_data.isOnline)
            {
               _loc3_ = LanguageMgr.GetTranslation("friends.im.IMFrame.command02");
               MessageTipManager.instance().show(_loc3_);
               _loc4_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc4_.channel = 3;
               _loc4_.msg = _loc3_;
               _loc4_.commit();
               NotificationManager.instance.sendNotification("ADD_CHAT",_loc4_);
               return;
            }
            if(_timeLimit)
            {
               _loc3_ = LanguageMgr.GetTranslation("friends.im.IMFrame.command03");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            _loc2_ = FilterWordManager.filterWrod(_loc2_);
            if(_isRobot)
            {
               _loc5_ = new BaseIMInfo();
               _loc5_.userId = playerManager.currentPlayerModel.playerInfo.userId;
               _loc5_.nickName = playerManager.currentPlayerModel.playerInfo.nickName;
               _loc5_.toId = _data.userId;
               _loc5_.msg = _loc2_;
               _loc5_.date = new Date();
               _loc5_.sendResult = 0;
               imManager.saveMsgCache(_loc5_);
               imManager.dispatchEvent(new IMEvent("MSG_SEND_RESPONSE",_loc5_));
               _loc6_ = friendManager.checkIsExistFriendInfo(_loc5_.toId);
               if(!_loc6_)
               {
                  playerManager.sendRequestSimpleAndSnsInfo(_loc5_.toId,0);
               }
               else
               {
                  friendManager.addPrivatePerson(_loc6_);
               }
            }
            else if(isCross)
            {
               FriendSocketOutManager.requestCrossFriendMsg(5,_data.uuid,_loc2_);
            }
            else
            {
               imManager.sendIMMsg(_data.userId,_loc2_);
            }
            _timeLimit = true;
            _timerID = setTimeout(limitTimeOutHandler,1000);
            _chatInputView.clear();
            _chatInputView.setFocus();
         }
      }
      
      private function limitTimeOutHandler() : void
      {
         clearTimeout(_timerID);
         _timeLimit = false;
      }
      
      private function get imManager() : IMManager
      {
         return IMManager.instance;
      }
      
      private function get friendManager() : FriendManager
      {
         return FriendManager.getInstance();
      }
      
      private function get playerManager() : PlayerManager
      {
         return PlayerManager.instance;
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _isRobot = _data.isRobot;
            playerManager.sendRequestSimpleAndSnsInfo(_data.userId,2);
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:ThaneInfo = null;
         if(_isRobot)
         {
            _loc1_ = SpaceTemplateManager.instance.getRobotInfo(_data.userId);
            _data.nickName = _loc1_.nickName;
            _data.state = _loc1_.state;
            _data.isRobot = _isRobot;
         }
         _presentBtn.enable = _consortiaBtn.enable = _marryBtn.enable = _inviteBtn.enable = !isCross;
         _friendInfoView.data = _data;
         _chatInfoView.data = _data;
      }
      
      public function show() : void
      {
         _isMini = false;
         scaleX = scaleY = 1;
         if(_friendInfoView && _friendInfoView.moodTxt)
         {
            _friendInfoView.moodTxt.visible = true;
         }
         LayerManager.Instance.addToLayer(this,3,true,false);
         if(_chatInputView)
         {
            _chatInputView.setFocus();
         }
         if(_historyView && _historyView.parent)
         {
            _historyView.show(this);
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get chatInputView() : IMChatInputView
      {
         return _chatInputView;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,475,505);
      }
      
      private function get isCross() : Boolean
      {
         return _data.serviceName != null && _data.serviceName != "" && _data.serviceName != playerManager.currentPlayerModel.playerInfo.serviceName;
      }
      
      override public function dispose() : void
      {
         if(needDispose)
         {
            removeEvent();
            clearTimeout(_timerID);
            TweenMax.killTweensOf(this,false);
            ObjectUtils.disposeAllChildren(this);
            if(_historyView)
            {
               _historyView.dispose();
            }
            if(_scaleFrameBg)
            {
               _scaleFrameBg.dispose();
            }
            _scaleFrameBg = null;
            if(_friendInfoView)
            {
               _friendInfoView.dispose();
            }
            _friendInfoView = null;
            if(_chatInfoView)
            {
               _chatInfoView.dispose();
            }
            _chatInfoView = null;
            if(_chatInputView)
            {
               _chatInputView.dispose();
            }
            _chatInputView = null;
            if(_addFriendBtn)
            {
               _addFriendBtn.dispose();
            }
            _addFriendBtn = null;
            if(_checkHistoryBtn)
            {
               _checkHistoryBtn.dispose();
            }
            _checkHistoryBtn = null;
            if(_miniBtn)
            {
               _miniBtn.dispose();
            }
            _miniBtn = null;
            if(_closeBtn)
            {
               _closeBtn.dispose();
            }
            _closeBtn = null;
            if(_sendMsgBtn)
            {
               _sendMsgBtn.dispose();
            }
            _sendMsgBtn = null;
            if(_cleanBtn)
            {
               _cleanBtn.dispose();
            }
            _cleanBtn = null;
            if(_inviteBtn)
            {
               _inviteBtn.dispose();
            }
            _inviteBtn = null;
            super.dispose();
            dispatchEvent(new IMFrameEvent("IMFRAME_DISPOSE",_data));
            _data = null;
            reg = null;
            reg1 = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         StageReferance.stage.focus = null;
         imManager.dispatchFrameRemoveEvent();
      }
   }
}

