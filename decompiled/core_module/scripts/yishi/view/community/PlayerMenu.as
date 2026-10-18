package yishi.view.community
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.System;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.FriendSocketOutManager;
   import managers.IMManager;
   import managers.MarryManager;
   import managers.RoomSocketOutManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.internals.constant.ArmyState;
   import mvc.module.friends.FriendGroupInfo;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.sort.SortData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.RequestInfoEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.base.ConsortiaSelectedButton;
   import yishi.view.tips.MessageTipManager;
   
   public class PlayerMenu extends Sprite implements Disposeable
   {
      
      protected var _back:ScaleBitmapImage;
      
      protected var _back2:ScaleBitmapImage;
      
      protected var _separatorBarImg:Bitmap;
      
      protected var _nickNameTxt:FilterFrameText;
      
      protected var _consortiaNameTxt1:FilterFrameText;
      
      protected var _consortiaNameTxt2:FilterFrameText;
      
      protected var _playerLevelTxt1:FilterFrameText;
      
      protected var _playerLevelTxt2:FilterFrameText;
      
      protected var _apTxt1:FilterFrameText;
      
      protected var _apTxt2:FilterFrameText;
      
      protected var _serverName:FilterFrameText;
      
      protected var _chatBtn:ConsortiaSelectedButton;
      
      protected var _moveFriendBtn:ConsortiaSelectedButton;
      
      protected var _applyJoinBtn:ConsortiaSelectedButton;
      
      protected var _addFriendBtn:ConsortiaSelectedButton;
      
      protected var _copyNameBtn:ConsortiaSelectedButton;
      
      protected var _blacklistBtn:ConsortiaSelectedButton;
      
      protected var _infoBtn:ConsortiaSelectedButton;
      
      protected var _marryBtn:ConsortiaSelectedButton;
      
      protected var _delFriendBtn:ConsortiaSelectedButton;
      
      protected var _delRecentBtn:ConsortiaSelectedButton;
      
      protected var _pkBtn:ConsortiaSelectedButton;
      
      protected var _inviteBtn:ConsortiaSelectedButton;
      
      protected var _followBtn:ConsortiaSelectedButton;
      
      protected var _appointBtn:ConsortiaSelectedButton;
      
      protected var _kickBtn:IconButton;
      
      protected var _consortiaBtn:IconButton;
      
      protected var _changeMastBtn1:IconButton;
      
      protected var _groupListPanel:ListPanel;
      
      protected var _thane:ThaneInfo;
      
      protected var _data:Object;
      
      protected var _isRecentContact:Boolean;
      
      private var _vBox:VBox;
      
      private var _showPkButton:Boolean = false;
      
      private var _showChatButton:Boolean = false;
      
      private var _cross:Boolean = false;
      
      private var _showKickBtn:Boolean = false;
      
      private var _showInviteBtn:Boolean = false;
      
      private var _showFollowBtn:Boolean = true;
      
      private var _showChangeMastBtn1:Boolean = false;
      
      private var _showChangeMastBtn2:Boolean = false;
      
      public function PlayerMenu(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false)
      {
         super();
         _showPkButton = param1;
         _showChatButton = param2;
         _cross = param3;
         _showKickBtn = param4;
         _showInviteBtn = param5;
         _showFollowBtn = param6;
         _showChangeMastBtn1 = param7;
         _showChangeMastBtn2 = param8;
         initView();
         addEvent();
         this.mouseEnabled = false;
         this.mouseChildren = true;
      }
      
      public function set showChatButton(param1:Boolean) : void
      {
         _showChatButton = param1;
      }
      
      protected function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuBack");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("tips.ConsortiaPlayerMenuBack");
         _separatorBarImg = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.TipsSeparatorbarImg");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuNicknameTextStyle");
         _consortiaNameTxt1 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaNameTextStyle1");
         _consortiaNameTxt2 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaNameTextStyle2");
         _playerLevelTxt1 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaLevelTextStyle1");
         _playerLevelTxt2 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaLevelTextStyle2");
         _apTxt1 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaAPTextStyle1");
         _apTxt2 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaAPTextStyle2");
         _serverName = ComponentFactory.Instance.creatComponentByStylename("PlayerMenu.serverName");
         _chatBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsChatBtn");
         _moveFriendBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsMoveFriendBtn");
         _addFriendBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsAddFriendsBtn");
         _copyNameBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsCopyNameBtn");
         _blacklistBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsBlacklistBtn");
         _delFriendBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsDelFriendBtn");
         _delRecentBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsDelFriendBtn");
         _pkBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsPKBtn");
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsInfoBtn");
         _marryBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsMarryBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsInviteBtn");
         _applyJoinBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsApplyBtn");
         _followBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsFollowBtn");
         _appointBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsAppointBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaBtn");
         _groupListPanel = ComponentFactory.Instance.creatComponentByStylename("core.FriendGroupListPanel");
         _chatBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.chat");
         _moveFriendBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.moveFriend");
         _addFriendBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.addFriend");
         _copyNameBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.copyName");
         _blacklistBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.blacklist");
         _delFriendBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.delFriend");
         _delRecentBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.delRecent");
         _pkBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.pk");
         if(_showKickBtn)
         {
            _kickBtn = ComponentFactory.Instance.creatComponentByStylename("tips.KickBtn");
            _kickBtn.text = LanguageMgr.GetTranslation("map.campaign.view.ui.MenuListView.kicking");
         }
         if(_showChangeMastBtn1)
         {
            _changeMastBtn1 = ComponentFactory.Instance.creatComponentByStylename("tips.ChangeMastBtn");
         }
         _moveFriendBtn.enable = false;
         _delFriendBtn.enable = false;
         _marryBtn.text = LanguageMgr.GetTranslation("marry.propose.MarryQuestFrame.titleText");
         _infoBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.info");
         _inviteBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.invite");
         _applyJoinBtn.text = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.applyJoinBtn");
         _followBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.follow");
         _appointBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.changeMastBtn2");
         _consortiaNameTxt1.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.consortia");
         _playerLevelTxt1.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.playerLevel");
         _apTxt1.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.ap");
         _apTxt2.text = "0";
         addChild(_back);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsVBox");
         if(_showChatButton)
         {
            _vBox.addChild(_chatBtn);
         }
         if(_showPkButton)
         {
            _vBox.addChild(_pkBtn);
         }
         if(!_showFollowBtn)
         {
            _vBox.addChild(_moveFriendBtn);
            _vBox.addChild(_addFriendBtn);
         }
         _vBox.addChild(_copyNameBtn);
         if(!_showFollowBtn)
         {
            _vBox.addChild(_blacklistBtn);
            _vBox.addChild(_delFriendBtn);
         }
         _vBox.addChild(_infoBtn);
         if(_showInviteBtn)
         {
            _vBox.addChild(_inviteBtn);
            if(!isCrossAllowTeam)
            {
               _vBox.addChild(_applyJoinBtn);
            }
         }
         if(_showFollowBtn)
         {
            _vBox.addChild(_followBtn);
         }
         if(_showChangeMastBtn2)
         {
            _vBox.addChild(_appointBtn);
         }
         addChild(_vBox);
         addChild(_separatorBarImg);
         addChild(_nickNameTxt);
         addChild(_consortiaNameTxt1);
         addChild(_consortiaNameTxt2);
         addChild(_playerLevelTxt1);
         addChild(_playerLevelTxt2);
         addChild(_apTxt1);
         addChild(_apTxt2);
         addChild(_serverName);
         _back.height = 120 + _vBox.numChildren * 23;
      }
      
      private function get isCrossAllowTeam() : Boolean
      {
         var _loc1_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc1_)
         {
            if(WorldBossHelper.checkSvs(_loc1_.mapId))
            {
               return true;
            }
         }
         return false;
      }
      
      private function showChangeMastBtn() : void
      {
         if(!_showChangeMastBtn1)
         {
            return;
         }
         addChildAt(_back2,1);
         addChild(_changeMastBtn1);
         _changeMastBtn1.y = _back.y + _back.height - 1;
         _back2.y = _back.y + _back.height - 1;
      }
      
      private function showKickButton() : void
      {
         if(!_showKickBtn)
         {
            return;
         }
         addChildAt(_back2,1);
         addChild(_kickBtn);
         _kickBtn.y = _back.y + _back.height - 1;
         _back2.y = _back.y + _back.height - 1;
      }
      
      protected function showConsortia() : void
      {
         var _loc1_:Boolean = false;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0)
         {
            _loc1_ = FrameControllerManager.instance.consortiaController.getRightsByIndex(9);
            if(_data is SortData)
            {
               _thane = (_data as SortData).army.baseHero;
            }
            else if(_data is ThaneInfo)
            {
               _thane = _data as ThaneInfo;
            }
            _loc1_ = _loc1_ && _thane.consortiaID <= 0 && StringHelper.isNullOrEmpty(_thane.consortiaName);
         }
         if(_showKickBtn)
         {
            _loc1_ = false;
         }
         if(isCrossFriend)
         {
            _loc1_ = false;
         }
         if(_loc1_ && !_cross)
         {
            addChildAt(_back2,1);
            addChild(_consortiaBtn);
            _consortiaBtn.y = _back.y + _back.height - 1;
            _back2.y = _back.y + _back.height - 1;
         }
      }
      
      protected function uninit() : void
      {
         ObjectUtils.disposeObject(_chatBtn);
         _chatBtn = null;
         ObjectUtils.disposeObject(_moveFriendBtn);
         _moveFriendBtn = null;
         ObjectUtils.disposeObject(_addFriendBtn);
         _addFriendBtn = null;
         ObjectUtils.disposeObject(_copyNameBtn);
         _copyNameBtn = null;
         ObjectUtils.disposeObject(_blacklistBtn);
         _blacklistBtn = null;
         ObjectUtils.disposeObject(_delFriendBtn);
         _delFriendBtn = null;
         ObjectUtils.disposeObject(_delRecentBtn);
         _delRecentBtn = null;
         ObjectUtils.disposeObject(_infoBtn);
         _infoBtn = null;
         ObjectUtils.disposeObject(_marryBtn);
         _marryBtn = null;
         ObjectUtils.disposeObject(_consortiaBtn);
         _consortiaBtn = null;
         ObjectUtils.disposeObject(_groupListPanel);
         _groupListPanel = null;
         ObjectUtils.disposeObject(_kickBtn);
         _kickBtn = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_applyJoinBtn);
         _applyJoinBtn = null;
         ObjectUtils.disposeObject(_followBtn);
         _followBtn = null;
         ObjectUtils.disposeObject(_appointBtn);
         _appointBtn = null;
         ObjectUtils.disposeObject(_changeMastBtn1);
         _changeMastBtn1 = null;
         ObjectUtils.disposeObject(_serverName);
         _serverName = null;
      }
      
      protected function addEvent() : void
      {
         _chatBtn.addEventListener("click",__chatHandler);
         _moveFriendBtn.addEventListener("click",__onMoveFriendHandler);
         _addFriendBtn.addEventListener("click",__onAddFriendHandler);
         _copyNameBtn.addEventListener("click",__onCopynameHandler);
         _blacklistBtn.addEventListener("click",__onBlacklistHandler);
         _delFriendBtn.addEventListener("click",__onDelFriendHandler);
         _delRecentBtn.addEventListener("click",__onDelRecentClick);
         _infoBtn.addEventListener("click",__onInfoHandler);
         _marryBtn.addEventListener("click",__onMarryHandler);
         _groupListPanel.list.addEventListener("listItemClick",__groupSelectHandler);
         playerManager.addEventListener("REQUEST_SIMPLEANDSNS_INFO",__getInfoHandler);
         StageReferance.stage.addEventListener("click",__stageMouseDown);
         if(_consortiaBtn)
         {
            _consortiaBtn.addEventListener("click",__consortiaHandler);
         }
         _pkBtn && _pkBtn.addEventListener("click",__onPkHandler);
         if(_kickBtn)
         {
            _kickBtn.addEventListener("click",__kickHandler);
         }
         if(_inviteBtn)
         {
            _inviteBtn.addEventListener("click",__inviteHandler);
         }
         if(_applyJoinBtn)
         {
            _applyJoinBtn.addEventListener("click",__applyJoinHandler);
         }
         if(_followBtn)
         {
            _followBtn.addEventListener("click",__followHandler);
         }
         if(_changeMastBtn1)
         {
            _changeMastBtn1.addEventListener("click",__changeMast1Handler);
         }
         if(_appointBtn)
         {
            _appointBtn.addEventListener("click",__appointBtnHandler);
         }
      }
      
      protected function removeEvent() : void
      {
         if(_moveFriendBtn)
         {
            _moveFriendBtn.removeEventListener("click",__onMoveFriendHandler);
         }
         if(_addFriendBtn)
         {
            _addFriendBtn.removeEventListener("click",__onAddFriendHandler);
         }
         if(_copyNameBtn)
         {
            _copyNameBtn.removeEventListener("click",__onCopynameHandler);
         }
         if(_chatBtn)
         {
            _chatBtn.removeEventListener("click",__chatHandler);
         }
         if(_blacklistBtn)
         {
            _blacklistBtn.removeEventListener("click",__onBlacklistHandler);
         }
         if(_delFriendBtn)
         {
            _delFriendBtn.removeEventListener("click",__onDelFriendHandler);
         }
         if(_delRecentBtn)
         {
            _delRecentBtn.removeEventListener("click",__onDelRecentClick);
         }
         if(_infoBtn)
         {
            _infoBtn.removeEventListener("click",__onInfoHandler);
         }
         if(_marryBtn)
         {
            _marryBtn.removeEventListener("click",__onMarryHandler);
         }
         if(_groupListPanel && _groupListPanel.list)
         {
            _groupListPanel.list.removeEventListener("listItemClick",__groupSelectHandler);
         }
         playerManager.removeEventListener("REQUEST_SIMPLEANDSNS_INFO",__getInfoHandler);
         StageReferance.stage.removeEventListener("click",__stageMouseDown);
         if(_consortiaBtn)
         {
            _consortiaBtn.removeEventListener("click",__consortiaHandler);
         }
         _pkBtn && _pkBtn.removeEventListener("click",__onPkHandler);
         if(_kickBtn)
         {
            _kickBtn.removeEventListener("click",__kickHandler);
         }
         if(_inviteBtn)
         {
            _inviteBtn.removeEventListener("click",__inviteHandler);
         }
         if(_applyJoinBtn)
         {
            _applyJoinBtn.removeEventListener("click",__applyJoinHandler);
         }
         if(_followBtn)
         {
            _followBtn.removeEventListener("click",__followHandler);
         }
         if(_changeMastBtn1)
         {
            _changeMastBtn1.removeEventListener("click",__changeMast1Handler);
         }
         if(_appointBtn)
         {
            _appointBtn.removeEventListener("click",__appointBtnHandler);
         }
      }
      
      private function __onMarryHandler(param1:MouseEvent) : void
      {
         if(_thane)
         {
            MarryManager.instance.creatProposeQuestFrame(_thane.userId);
         }
      }
      
      protected function __stageMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(parent)
         {
            _loc2_ = parent.localToGlobal(new Point(this.x,this.y));
            if(isNaN(param1.stageX) || isNaN(param1.stageY) || param1.stageX < _loc2_.x || param1.stageX > _loc2_.x + width || param1.stageY < _loc2_.y || param1.stageY > _loc2_.y + height)
            {
               dispose();
            }
         }
      }
      
      private function __changeMast1Handler(param1:MouseEvent) : void
      {
         if(_data is ThaneInfo)
         {
            FrameControllerManager.instance.steelController.sendSteelChangeMast((_data as ThaneInfo).userId);
         }
         dispose();
      }
      
      private function __appointBtnHandler(param1:MouseEvent) : void
      {
         if(_data is ThaneInfo)
         {
         }
         dispose();
      }
      
      private function __followHandler(param1:MouseEvent) : void
      {
         if(_data is ThaneInfo)
         {
            FreedomTeamManager.instance.model.followId = (_data as ThaneInfo).userId;
            NotificationManager.instance.sendNotification("LOCK_TEAM_FOLLOW_TARGET",(_data as ThaneInfo).userId);
         }
         dispose();
      }
      
      private function __inviteHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_data is ThaneInfo)
         {
            _loc2_ = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
            FreedomTeamManager.instance.inviteMember((_data as ThaneInfo).userId,_loc2_);
         }
         dispose();
      }
      
      private function __applyJoinHandler(param1:MouseEvent) : void
      {
         FreedomTeamManager.instance.joinTeam((_data as ThaneInfo).userId);
         dispose();
      }
      
      private function __kickHandler(param1:MouseEvent) : void
      {
         if(_data is ThaneInfo)
         {
            RoomSocketOutManager.sendKickPlayerAlert((_data as ThaneInfo).userId);
         }
      }
      
      private function __getInfoHandler(param1:RequestInfoEvent) : void
      {
         if(param1.orientation != 3)
         {
            return;
         }
         setData(_data,_isRecentContact);
      }
      
      private function __groupSelectHandler(param1:ListItemEvent) : void
      {
         var _loc2_:FriendGroupInfo = param1.cellValue as FriendGroupInfo;
         if(_loc2_ && friendManager.groupDic[_loc2_.groupId] && _thane && friendManager.friendList[_thane.userId])
         {
            FriendSocketOutManager.sendMoveFriend(_thane.userId,_loc2_.groupId);
         }
         dispose();
      }
      
      private function __consortiaHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(_data is SortData)
         {
            _loc2_ = (_data as SortData).army.userId;
         }
         else if(_data is ThaneInfo)
         {
            _loc2_ = (_data as ThaneInfo).userId;
         }
         else if(_thane)
         {
            _loc2_ = _thane.userId;
         }
         FrameControllerManager.instance.consortiaController.sendConsortiaInvitePlayer(_loc2_);
         dispose();
      }
      
      private function __onPkHandler(param1:MouseEvent) : void
      {
         var _loc2_:CampaignArmy = null;
         SoundManager.instance.play("022");
         if(_data && _data is CampaignArmy)
         {
            _loc2_ = _data as CampaignArmy;
            if(ArmyState.checkCampaignAttack(_loc2_.state))
            {
               CampaignSocketOutManager.instance.sendMapPkInviteTo(_loc2_.baseHero.userId);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("playermenu.command01"));
            }
         }
         dispose();
      }
      
      private function __chatHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatItemMenu.command01");
            MessageTipManager.instance().show(_loc2_);
            dispose();
            return;
         }
         IMManager.instance.createIMFrame(_thane);
         dispose();
      }
      
      private function __onMoveFriendHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:FriendItemCellInfo = null;
         var _loc5_:Array = friendManager.groupDic.getList();
         _loc5_.sortOn("groupId",16);
         if(_loc5_.length < 2)
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_thane && friendManager.friendList[_thane.userId])
         {
            _loc3_ = friendManager.friendList[_thane.userId];
            _groupListPanel.vectorListModel.clear();
            for each(var _loc4_:FriendGroupInfo in _loc5_)
            {
               if(_loc4_.groupId != _loc3_.groupId)
               {
                  _groupListPanel.vectorListModel.append(_loc4_);
               }
            }
            _groupListPanel.height = (_loc5_.length - 1) * 22 + 2;
            _groupListPanel.x = _back.width + 5;
            _groupListPanel.y = _vBox.y;
            addChild(_groupListPanel);
            return;
         }
         dispose();
      }
      
      public function setData(param1:Object, param2:Boolean = false) : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc3_:FriendItemCellInfo = null;
         _data = param1;
         _isRecentContact = param2;
         if(!_data)
         {
            return;
         }
         if(_data is SortData)
         {
            _thane = (_data as SortData).army.baseHero;
            _loc4_ = _data.serverName;
         }
         else if(_data is ThaneInfo)
         {
            _thane = _data as ThaneInfo;
            _loc4_ = _thane.serviceName;
         }
         else if(_data is CampaignArmy)
         {
            _thane = (_data as CampaignArmy).baseHero;
            _loc4_ = _thane.serviceName;
         }
         _nickNameTxt.text = _thane.nickName;
         _consortiaNameTxt2.text = _thane.consortiaName ? _thane.consortiaName : LanguageMgr.GetTranslation("yishi.view.PlayerMenu.consortiaName");
         _playerLevelTxt2.text = _thane.grades.toString();
         _apTxt2.text = _thane.fightingCapacity.toString();
         if(_loc4_ && _loc4_ != "")
         {
            _serverName.text = LanguageMgr.GetTranslation("playerMenu.serverName.text",_loc4_);
         }
         if(!isCrossFriend && playerInfo.userId == _thane.userId)
         {
            _addFriendBtn.enable = _delFriendBtn.enable = _moveFriendBtn.enable = _blacklistBtn.enable = false;
            return;
         }
         if(isCrossFriend && _data.hasOwnProperty("uuid") && _data["uuid"])
         {
            if(FriendManager.getInstance().crossFriendList[_data.uuid])
            {
               _loc5_ = 1;
            }
            else if(FriendManager.getInstance().crossBlackList[_data.uuid])
            {
               _loc5_ = 2;
            }
            else if(FriendManager.getInstance().crossStrangerList[_data.uuid])
            {
               _loc5_ = 3;
            }
         }
         else
         {
            _loc3_ = IMManager.instance.getFriendInfo(_thane.userId);
            if(_loc3_)
            {
               _loc5_ = _loc3_.relation;
            }
         }
         switch(_loc5_ - 1)
         {
            case 0:
               _addFriendBtn.enable = false;
               _moveFriendBtn.enable = true;
               _delFriendBtn.enable = true;
               break;
            case 1:
               _blacklistBtn.enable = false;
               _delFriendBtn.enable = true;
               break;
            case 2:
               _addFriendBtn.enable = false;
               _blacklistBtn.enable = true;
               _delFriendBtn.enable = true;
               break;
            default:
               _addFriendBtn.enable = true;
               _blacklistBtn.enable = false;
               _delFriendBtn.enable = false;
         }
         if(_isRecentContact)
         {
            _vBox.removeAllChild();
            _vBox.addChild(_moveFriendBtn);
            _vBox.addChild(_addFriendBtn);
            _vBox.addChild(_copyNameBtn);
            _vBox.addChild(_blacklistBtn);
            _vBox.addChild(_delRecentBtn);
            _vBox.addChild(_infoBtn);
         }
         if(!(_data is SortData))
         {
            if(MarryManager.instance.model.isSingle && ArmyManager.instance.thane.grades >= 36 && !_cross)
            {
               _vBox.addChild(_marryBtn);
            }
         }
         if(!isCrossFriend && MarryManager.instance.model.isMarry && MarryManager.instance.model.selfMarryInfo.userId == _thane.userId)
         {
            _blacklistBtn.enable = false;
            _delFriendBtn.enable = false;
            _delRecentBtn.enable = false;
            _moveFriendBtn.enable = false;
         }
         if(friendManager.groupDic.getList().length < 2)
         {
            _moveFriendBtn.enable = false;
         }
         if(isCrossFriend)
         {
            _moveFriendBtn.enable = false;
            _delRecentBtn.enable = false;
            _pkBtn.enable = false;
            _inviteBtn.enable = false;
            _applyJoinBtn.enable = false;
            _followBtn.enable = false;
            _marryBtn.enable = false;
            _appointBtn.enable = false;
            _infoBtn.enable = false;
            if(_data is SortData)
            {
               _infoBtn.enable = true;
            }
         }
         _back.height = 120 + _vBox.numChildren * 23;
         showConsortia();
         showKickButton();
         showChangeMastBtn();
      }
      
      private function __onAddFriendHandler(param1:MouseEvent) : void
      {
         if(isCrossFriend)
         {
            FriendManager.getInstance().sendCrossFriendRequest(0,_data["uuid"]);
         }
         else
         {
            FriendManager.getInstance().sendAddFriendRequest(_thane.nickName,1);
         }
         dispose();
      }
      
      private function __onCopynameHandler(param1:MouseEvent) : void
      {
         System.setClipboard(_thane.nickName);
         dispose();
      }
      
      private function __onBlacklistHandler(param1:MouseEvent) : void
      {
         if(isCrossFriend)
         {
            FriendManager.getInstance().sendCrossFriendRequest(2,_data["uuid"]);
         }
         else
         {
            FriendManager.getInstance().sendAddFriendRequest(_thane.nickName,2);
         }
         dispose();
      }
      
      private function __onDelRecentClick(param1:MouseEvent) : void
      {
         if(_thane)
         {
            FriendManager.getInstance().removePrivatePerson(_thane.userId);
         }
         dispose();
      }
      
      private function __onDelFriendHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc7_:int = 0;
         var _loc5_:FriendItemCellInfo = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         if(_thane)
         {
            if(isCrossFriend && _data.hasOwnProperty("uuid") && _data["uuid"])
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
               _loc5_ = IMManager.instance.getFriendInfo(_thane.userId);
               if(_loc5_)
               {
                  _loc7_ = _loc5_.relation;
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
            SimpleAlertHelper.instance.data = [_delFriendResponse,_loc5_,_loc7_];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc2_,_loc3_,_loc4_,true,false,false);
         }
         dispose();
      }
      
      private function _delFriendResponse(param1:Boolean, param2:Boolean, param3:FriendItemCellInfo, param4:int) : void
      {
         if(param1)
         {
            if(isCrossFriend)
            {
               if(param4 == 2)
               {
                  FriendManager.getInstance().sendCrossFriendRequest(3,_data["uuid"]);
               }
               else
               {
                  FriendManager.getInstance().sendCrossFriendRequest(1,_data["uuid"]);
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
      
      protected function __onInfoHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = _cross ? 10000 : 0;
         if(_data is CampaignArmy)
         {
            PlayerInfoManager.instance.show(_thane,_loc2_);
         }
         else
         {
            PlayerInfoManager.instance.show(_data,_loc2_);
         }
         dispose();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get friendManager() : FriendManager
      {
         return FriendManager.getInstance();
      }
      
      private function get playerManager() : PlayerManager
      {
         return PlayerManager.instance;
      }
      
      private function get isCrossFriend() : Boolean
      {
         if(_data is SortData)
         {
            return _cross;
         }
         if(_data is ThaneInfo)
         {
            return (_data as ThaneInfo).serviceName != null && (_data as ThaneInfo).serviceName != "" && (_data as ThaneInfo).serviceName != playerInfo.serviceName;
         }
         if(_data is CampaignArmy)
         {
            return (_data as ThaneInfo).serviceName != null && (_data as ThaneInfo).serviceName != "" && (_data as CampaignArmy).baseHero.serviceName != playerInfo.serviceName;
         }
         return false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

