package chat.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.System;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.IMManager;
   import managers.MarryManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.internals.constant.ArmyState;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import map.space.manager.SpaceSocketOutManager;
   import mvc.module.friends.FriendItemCellInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.RequestInfoEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ChatItemMenu extends Sprite implements Disposeable
   {
      
      private var _chatMessage:TextButton;
      
      private var _addfriend:TextButton;
      
      private var _copyName:TextButton;
      
      private var _blacklist:TextButton;
      
      private var _message:TextButton;
      
      private var _consortiaBtn:TextButton;
      
      private var _attackBtn:TextButton;
      
      private var _inviteBtn:TextButton;
      
      private var _proposeBtn:TextButton;
      
      private var _applyJoin:TextButton;
      
      private var _pkBtn:TextButton;
      
      private var _back:DisplayObject;
      
      private var _vBox:VBox;
      
      private var _uuid:String;
      
      private var _userId:int;
      
      private var _name:String;
      
      private var _showConsortia:Boolean;
      
      private var _serverName:String;
      
      private var _showAttack:Boolean;
      
      private var _isRobot:Boolean;
      
      private var _showInvite:Boolean;
      
      private var _showPropose:Boolean;
      
      private var _showPk:Boolean;
      
      public function ChatItemMenu(param1:String, param2:int, param3:Boolean, param4:String = null, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = true, param10:String = null)
      {
         var _loc11_:String = null;
         var _loc12_:int = 0;
         super();
         _uuid = param10;
         _name = param1;
         _userId = param2;
         _showConsortia = param3;
         _serverName = param4;
         _showAttack = param5;
         _showPk = param6;
         _isRobot = param7;
         _showInvite = param8;
         _showPropose = param9;
         if(_userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            _showConsortia = false;
         }
         if(WorldBossHelper.checkMarket(CampaignManager.instance.mapId))
         {
            _showConsortia = false;
         }
         if(SceneManager.instance.currentType != "SPACE_SCENE")
         {
            _showPk = false;
         }
         if(!sameServiceName())
         {
            _showConsortia = _showPk = param5 = param8 = param9 = false;
         }
         else
         {
            _loc11_ = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
            _loc12_ = _name.indexOf(_loc11_);
            if(_loc12_ != -1)
            {
               _name = _name.substr(_loc12_ + _loc11_.length + 1,_name.length - (_loc12_ + _loc11_.length + 2));
            }
         }
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _back = ComponentFactory.Instance.creat("core.commonTipBg");
         _back.width = 145;
         _back.height = 128;
         addChild(_back);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ChatItemMenu.VBox");
         _chatMessage = ComponentFactory.Instance.creatComponentByStylename("chatII.chatMessageSelectBtn");
         _addfriend = ComponentFactory.Instance.creatComponentByStylename("chatII.addfriendSelectBtn");
         _copyName = ComponentFactory.Instance.creatComponentByStylename("chatII.copyNameSelectBtn");
         _blacklist = ComponentFactory.Instance.creatComponentByStylename("chatII.blacklistSelectBtn");
         _message = ComponentFactory.Instance.creatComponentByStylename("chatII.messageSelectBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.consortiaSelectBtn");
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.consortiaSelectBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.consortiaSelectBtn");
         _proposeBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.proposeBtn");
         _applyJoin = ComponentFactory.Instance.creatComponentByStylename("chatII.applyJoinBtn");
         _pkBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.pkBtn");
         _chatMessage.text = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.chatMessageText");
         _addfriend.text = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.addfriendText");
         _copyName.text = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.copyNametext");
         _blacklist.text = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.blacklistText");
         _message.text = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.messageText");
         _consortiaBtn.text = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.consortiaBtnText");
         _attackBtn.text = LanguageMgr.GetTranslation("ChatItemMenu.attack");
         _inviteBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.invite");
         _proposeBtn.text = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.propose");
         _applyJoin.text = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.applyJoinBtn");
         _pkBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.pk");
         addChild(_vBox);
         _vBox.addChild(_chatMessage);
         _vBox.addChild(_addfriend);
         _vBox.addChild(_copyName);
         _vBox.addChild(_blacklist);
         _vBox.addChild(_message);
         if(_showConsortia)
         {
            _vBox.addChild(_consortiaBtn);
         }
         if(_showAttack)
         {
            _vBox.addChild(_attackBtn);
         }
         if(_showInvite)
         {
            _vBox.addChild(_inviteBtn);
            _vBox.addChild(_applyJoin);
         }
         if(_showPropose && isSingle && thane.grades >= 36)
         {
            _vBox.addChild(_proposeBtn);
         }
         if(_showPk)
         {
            _vBox.addChild(_pkBtn);
         }
         _back.height = _vBox.height + 10;
         setBtnState();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function setBtnState() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FriendItemCellInfo = null;
         if(!sameServiceName() && _uuid != "" && _uuid != null)
         {
            if(FriendManager.getInstance().crossFriendList[_uuid])
            {
               _loc2_ = 1;
            }
            else if(FriendManager.getInstance().crossBlackList[_uuid])
            {
               _loc2_ = 2;
            }
            else if(FriendManager.getInstance().crossStrangerList[_uuid])
            {
               _loc2_ = 3;
            }
         }
         else
         {
            _loc1_ = IMManager.instance.getFriendInfo(_userId);
            if(_loc1_)
            {
               _loc2_ = _loc1_.relation;
            }
         }
         switch(_loc2_ - 1)
         {
            case 0:
            case 2:
               _addfriend.enable = false;
               _blacklist.enable = true;
               break;
            case 1:
               _addfriend.enable = true;
               _blacklist.enable = false;
               break;
            default:
               _addfriend.enable = true;
               _blacklist.enable = false;
         }
         if(!sameServiceName())
         {
            _message.enable = false;
            _proposeBtn.enable = false;
            _consortiaBtn && (_consortiaBtn.visible = false);
         }
         else if(isSelf())
         {
            _addfriend.enable = false;
            _chatMessage.enable = false;
            _consortiaBtn.enable = false;
            _attackBtn.enable = false;
            _inviteBtn.enable = false;
            _proposeBtn.enable = false;
            _applyJoin.enable = false;
            _pkBtn.enable = false;
         }
      }
      
      private function isSelf() : Boolean
      {
         return sameServiceName() && sameUserId();
      }
      
      private function sameServiceName() : Boolean
      {
         if(_serverName)
         {
            return _serverName == PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
         }
         return true;
      }
      
      private function sameUserId() : Boolean
      {
         return _userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId;
      }
      
      private function initEvent() : void
      {
         _chatMessage.addEventListener("click",__chatmessageHandler);
         _copyName.addEventListener("click",__copyNameHandler);
         _blacklist.addEventListener("click",__blacklistHandler);
         _message.addEventListener("click",__messageHandler);
         _addfriend.addEventListener("click",__addfriendHandler);
         if(_consortiaBtn)
         {
            _consortiaBtn.addEventListener("click",__consortiaHandler);
         }
         if(_attackBtn)
         {
            _attackBtn.addEventListener("click",__attackHandler);
         }
         if(_inviteBtn)
         {
            _inviteBtn.addEventListener("click",__inviteHandler);
         }
         if(_proposeBtn)
         {
            _proposeBtn.addEventListener("click",__proposeHandler);
         }
         if(_applyJoin)
         {
            _applyJoin.addEventListener("click",__applyJoinHandler);
         }
         if(_pkBtn)
         {
            _pkBtn.addEventListener("click",__pkBtnClickHandler);
         }
      }
      
      private function get isSingle() : Boolean
      {
         return MarryManager.instance.model.isSingle;
      }
      
      private function removeEvent() : void
      {
         if(_blacklist)
         {
            _blacklist.removeEventListener("click",__blacklistHandler);
         }
         if(_message)
         {
            _message.removeEventListener("click",__messageHandler);
         }
         if(_addfriend)
         {
            _addfriend.removeEventListener("click",__addfriendHandler);
         }
         if(_copyName)
         {
            _copyName.removeEventListener("click",__copyNameHandler);
         }
         if(_chatMessage)
         {
            _chatMessage.removeEventListener("click",__chatmessageHandler);
         }
         if(_consortiaBtn)
         {
            _consortiaBtn.removeEventListener("click",__consortiaHandler);
         }
         PlayerManager.instance.removeEventListener("REQUEST_SIMPLEINFO",__recentContactHandler);
         if(_attackBtn)
         {
            _attackBtn.removeEventListener("click",__attackHandler);
         }
         if(_inviteBtn)
         {
            _inviteBtn.removeEventListener("click",__inviteHandler);
         }
         if(_pkBtn)
         {
            _pkBtn.removeEventListener("click",__pkBtnClickHandler);
         }
      }
      
      private function __chatmessageHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ThaneInfo = null;
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatItemMenu.command01");
            MessageTipManager.instance().show(_loc2_);
            dispose();
            return;
         }
         _loc3_ = new ThaneInfo();
         _loc3_.userId = _userId;
         _loc3_.nickName = _name;
         _loc3_.isRobot = _isRobot;
         _loc3_.uuid = _uuid;
         _loc3_.serviceName = _serverName;
         IMManager.instance.createIMFrame(_loc3_);
         dispose();
      }
      
      private function __consortiaHandler(param1:MouseEvent) : void
      {
         if(_isRobot)
         {
            dispose();
            return;
         }
         FrameControllerManager.instance.consortiaController.sendConsortiaInvitePlayer(_userId);
         dispose();
      }
      
      private function __copyNameHandler(param1:MouseEvent) : void
      {
         System.setClipboard(_name);
         dispose();
      }
      
      private function __blacklistHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatItemMenu.command01");
            MessageTipManager.instance().show(_loc2_);
            dispose();
            return;
         }
         if(_isRobot)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatItemMenu.RobotTips02");
            MessageTipManager.instance().show(_loc2_);
            dispose();
            return;
         }
         if(!sameServiceName())
         {
            FriendManager.getInstance().sendCrossFriendRequest(2,_uuid);
         }
         else
         {
            FriendManager.getInstance().sendAddFriendRequest(_name,2);
         }
         dispose();
      }
      
      private function __messageHandler(param1:MouseEvent) : void
      {
         PlayerManager.instance.addEventListener("REQUEST_SIMPLEINFO",__recentContactHandler);
         if(_serverName && _serverName != PlayerManager.instance.currentPlayerModel.playerInfo.serviceName)
         {
            PlayerInfoManager.instance.sendRequestSimpleInfoCross(_userId,_serverName);
         }
         else
         {
            PlayerInfoManager.instance.sendRequestSimpleInfo(_userId);
         }
      }
      
      private function __recentContactHandler(param1:RequestInfoEvent) : void
      {
         PlayerManager.instance.removeEventListener("REQUEST_SIMPLEINFO",__recentContactHandler);
         var _loc2_:ThaneInfo = param1.data;
         _loc2_.isRobot = _isRobot;
         if(!(_loc2_ && _loc2_.nickName))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChatItemMenu.cannotSearchPlayerInfo"));
            return;
         }
         if(param1.orientation == 10000)
         {
            PlayerInfoManager.instance.show(_loc2_,10000);
         }
         else
         {
            PlayerInfoManager.instance.show(_loc2_);
         }
         dispose();
      }
      
      private function __addfriendHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatItemMenu.command01");
            MessageTipManager.instance().show(_loc2_);
            dispose();
            return;
         }
         if(_isRobot)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatItemMenu.RobotTips01");
            MessageTipManager.instance().show(_loc2_);
            dispose();
            return;
         }
         if(!sameServiceName())
         {
            FriendManager.getInstance().sendCrossFriendRequest(0,_uuid);
         }
         else
         {
            FriendManager.getInstance().sendAddFriendRequest(_name,1);
         }
         dispose();
      }
      
      public function enablePlayerInfoButton(param1:Boolean) : void
      {
         if(_message)
         {
            _message.enable = param1;
         }
      }
      
      private function __attackHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:CampaignArmy = null;
         var _loc5_:int = 0;
         var _loc7_:Boolean = false;
         var _loc4_:String = null;
         var _loc6_:ThaneInfo = ArmyManager.instance.thane;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc3_ = CampaignManager.instance.mapModel.getUserArmyByUserId(_userId);
            if(_loc3_)
            {
               _loc5_ = Math.abs(_loc3_.baseHero.grades - _loc6_.grades);
               _loc7_ = false;
               _loc4_ = _loc3_.baseHero.consortiaName;
               if(_loc4_ && _loc4_ == _loc6_.consortiaName)
               {
                  _loc7_ = true;
               }
               if(_loc5_ >= 10 && !WorldBossHelper.checkMineral(CampaignManager.instance.mapModel.mapId))
               {
                  _loc2_ = LanguageMgr.GetTranslation("ChatItemMenu.gradeDiff");
                  MessageTipManager.instance().show(_loc2_);
               }
               else if(_loc7_)
               {
                  _loc2_ = LanguageMgr.GetTranslation("map.outercity.mediator.mapview.OuterCityPkMediator.command01");
                  MessageTipManager.instance().show(_loc2_);
               }
               else
               {
                  NotificationManager.instance.sendNotification("LOCK_PVP_WARFIGHT",_loc3_);
               }
            }
         }
         dispose();
      }
      
      private function __pkBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SpaceArmy = null;
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            _loc2_ = SpaceManager.instance.model.getUserArmyByUserId(_userId);
            if(!_loc2_)
            {
               dispose();
               return;
            }
            if(ArmyState.checkCampaignAttack(_loc2_.state))
            {
               SpaceSocketOutManager.instance.sendMapPkInviteTo(_loc2_.baseHero.userId);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("playermenu.command01"));
            }
         }
         dispose();
      }
      
      private function __inviteHandler(param1:MouseEvent) : void
      {
         FreedomTeamManager.instance.inviteMember(_userId,_serverName);
         dispose();
      }
      
      private function __proposeHandler(param1:MouseEvent) : void
      {
         MarryManager.instance.creatProposeQuestFrame(_userId);
         dispose();
      }
      
      private function __applyJoinHandler(param1:MouseEvent) : void
      {
         FreedomTeamManager.instance.joinTeam(_userId);
         dispose();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_blacklist);
         _blacklist = null;
         ObjectUtils.disposeObject(_message);
         _message = null;
         ObjectUtils.disposeObject(_addfriend);
         _addfriend = null;
         ObjectUtils.disposeObject(_copyName);
         _copyName = null;
         ObjectUtils.disposeObject(_chatMessage);
         _chatMessage = null;
         ObjectUtils.disposeObject(_attackBtn);
         _attackBtn = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_applyJoin);
         _applyJoin = null;
         ObjectUtils.disposeObject(_pkBtn);
         _pkBtn = null;
      }
   }
}

