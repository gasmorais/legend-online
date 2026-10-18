package oldplayerreturn.alliance
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.RequestInfoEvent;
   import yishi.manager.FriendManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.ConsortiaSelectedButton;
   
   public class OldPlayerReturnHeadMenu extends Sprite implements Disposeable
   {
      
      protected var _back:ScaleBitmapImage;
      
      protected var _separatorBarImg:Bitmap;
      
      protected var _nickNameTxt:FilterFrameText;
      
      protected var _consortiaNameTxt1:FilterFrameText;
      
      protected var _consortiaNameTxt2:FilterFrameText;
      
      protected var _playerLevelTxt1:FilterFrameText;
      
      protected var _playerLevelTxt2:FilterFrameText;
      
      protected var _apTxt1:FilterFrameText;
      
      protected var _apTxt2:FilterFrameText;
      
      protected var _applyJoinBtn:ConsortiaSelectedButton;
      
      protected var _addFriendBtn:ConsortiaSelectedButton;
      
      protected var _infoBtn:ConsortiaSelectedButton;
      
      protected var _inviteBtn:ConsortiaSelectedButton;
      
      protected var _thane:ThaneInfo;
      
      protected var _data:Object;
      
      private var _vBox:VBox;
      
      protected var _terminateBtn:ConsortiaSelectedButton;
      
      private var _isBinding:Boolean = false;
      
      public function OldPlayerReturnHeadMenu(param1:Boolean)
      {
         super();
         _isBinding = param1;
         initView();
         addEvent();
         this.mouseEnabled = false;
         this.mouseChildren = true;
      }
      
      protected function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuBack");
         _separatorBarImg = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.TipsSeparatorbarImg");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuNicknameTextStyle");
         _consortiaNameTxt1 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaNameTextStyle1");
         _consortiaNameTxt2 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaNameTextStyle2");
         _playerLevelTxt1 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaLevelTextStyle1");
         _playerLevelTxt2 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaLevelTextStyle2");
         _apTxt1 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaAPTextStyle1");
         _apTxt2 = ComponentFactory.Instance.creatComponentByStylename("tips.PlayerMenuConsortiaAPTextStyle2");
         _addFriendBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsAddFriendsBtn");
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsInfoBtn");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsInviteBtn");
         _applyJoinBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsApplyBtn");
         _addFriendBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.addFriend");
         _infoBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.info");
         _inviteBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.invite");
         _applyJoinBtn.text = LanguageMgr.GetTranslation("chatII.view.ChatItemMenu.applyJoinBtn");
         _consortiaNameTxt1.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.consortia");
         _playerLevelTxt1.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.playerLevel");
         _apTxt1.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.ap");
         _apTxt2.text = "0";
         addChild(_back);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("consortia.TipsVBox");
         _terminateBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnHeadItem.terminateBtn");
         _terminateBtn.text = LanguageMgr.GetTranslation("oldPlayerReturnHeadMenu.terminateBtn.text");
         _vBox.addChild(_addFriendBtn);
         _vBox.addChild(_infoBtn);
         _vBox.addChild(_inviteBtn);
         _vBox.addChild(_applyJoinBtn);
         if(_isBinding)
         {
            _vBox.addChild(_terminateBtn);
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
         _back.height = 120 + _vBox.numChildren * 23;
      }
      
      protected function addEvent() : void
      {
         _addFriendBtn.addEventListener("click",__onAddFriendHandler);
         _infoBtn.addEventListener("click",__onInfoHandler);
         _inviteBtn.addEventListener("click",__inviteHandler);
         _applyJoinBtn.addEventListener("click",__applyJoinHandler);
         _terminateBtn.addEventListener("click",__terminateBtnClickHandler);
         playerManager.addEventListener("REQUEST_SIMPLEANDSNS_INFO",__getInfoHandler);
         StageReferance.stage.addEventListener("click",__stageMouseDown);
      }
      
      protected function removeEvent() : void
      {
         if(_addFriendBtn)
         {
            _addFriendBtn.removeEventListener("click",__onAddFriendHandler);
         }
         if(_infoBtn)
         {
            _infoBtn.removeEventListener("click",__onInfoHandler);
         }
         if(_inviteBtn)
         {
            _inviteBtn.removeEventListener("click",__inviteHandler);
         }
         if(_applyJoinBtn)
         {
            _applyJoinBtn.removeEventListener("click",__applyJoinHandler);
         }
         _terminateBtn.removeEventListener("click",__terminateBtnClickHandler);
         playerManager.removeEventListener("REQUEST_SIMPLEANDSNS_INFO",__getInfoHandler);
         StageReferance.stage.removeEventListener("click",__stageMouseDown);
      }
      
      private function __terminateBtnClickHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [callBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("oldPlayerReturnHeadMenu.terminate.content.txt");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
      }
      
      private function callBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            OldPlayerReturnManager.instance.send(8,_thane.userId);
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
      
      private function __getInfoHandler(param1:RequestInfoEvent) : void
      {
         if(param1.orientation != 3)
         {
            return;
         }
         setData(_data);
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:String = null;
         _data = param1;
         if(!_data)
         {
            return;
         }
         _thane = _data as ThaneInfo;
         _loc2_ = _thane.serviceName;
         _nickNameTxt.text = _thane.nickName;
         _consortiaNameTxt2.text = _thane.consortiaName ? _thane.consortiaName : LanguageMgr.GetTranslation("yishi.view.PlayerMenu.consortiaName");
         _playerLevelTxt2.text = _thane.grades.toString();
         _apTxt2.text = _thane.fightingCapacity.toString();
         _back.height = 120 + _vBox.numChildren * 23;
      }
      
      private function __onAddFriendHandler(param1:MouseEvent) : void
      {
         FriendManager.getInstance().sendAddFriendRequest(_thane.nickName,1);
         dispose();
      }
      
      protected function __onInfoHandler(param1:MouseEvent) : void
      {
         PlayerInfoManager.instance.show(_data,0);
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
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_separatorBarImg);
         _separatorBarImg = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeObject(_consortiaNameTxt1);
         _consortiaNameTxt1 = null;
         ObjectUtils.disposeObject(_consortiaNameTxt2);
         _consortiaNameTxt2 = null;
         ObjectUtils.disposeObject(_playerLevelTxt1);
         _playerLevelTxt1 = null;
         ObjectUtils.disposeObject(_playerLevelTxt2);
         _playerLevelTxt2 = null;
         ObjectUtils.disposeObject(_apTxt1);
         _apTxt1 = null;
         ObjectUtils.disposeObject(_apTxt2);
         _apTxt2 = null;
         ObjectUtils.disposeObject(_applyJoinBtn);
         _applyJoinBtn = null;
         ObjectUtils.disposeObject(_addFriendBtn);
         _addFriendBtn = null;
         ObjectUtils.disposeObject(_infoBtn);
         _infoBtn = null;
         ObjectUtils.disposeObject(_inviteBtn);
         _inviteBtn = null;
         ObjectUtils.disposeObject(_terminateBtn);
         _terminateBtn = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

