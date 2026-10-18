package map.internals.view.team
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FreedomTeamEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import map.internals.view.team.manage.FreedomTeamManageHeroItem;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.team.FreedomTeamModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   
   public class FreedomTeamManageFrame extends Frame
   {
      
      private var _hBox:HBox;
      
      private var _back:ScaleBitmapImage;
      
      private var _addBtn:TextButton;
      
      private var _changeBtn:TextButton;
      
      private var _lineUpBtn:TextButton;
      
      private var _kickBtn:TextButton;
      
      private var _quitBtn:TextButton;
      
      private var _hero1:FreedomTeamManageHeroItem;
      
      private var _hero2:FreedomTeamManageHeroItem;
      
      private var _hero3:FreedomTeamManageHeroItem;
      
      private var _hero4:FreedomTeamManageHeroItem;
      
      private var _hero0:FreedomTeamManageHeroItem;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _playerList:Dictionary;
      
      private var _currentSelected:FreedomTeamManageHeroItem;
      
      public function FreedomTeamManageFrame()
      {
         super();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.Back");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("team.FreedomTeamManageFrame.AddBtn");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("team.FreedomTeamManageFrame.ChangeBtn");
         _lineUpBtn = ComponentFactory.Instance.creatComponentByStylename("team.FreedomTeamManageFrame.AdjustmentLineUp");
         _kickBtn = ComponentFactory.Instance.creatComponentByStylename("team.FreedomTeamManageFrame.KickBtn");
         _quitBtn = ComponentFactory.Instance.creatComponentByStylename("team.FreedomTeamManageFrame.QuitBtn");
         _addBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.add");
         _changeBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.change");
         _lineUpBtn.text = LanguageMgr.GetTranslation("armyII.viewII.allocate.AllocateView.sort");
         _kickBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.kick");
         _quitBtn.text = LanguageMgr.GetTranslation("map.internals.view.team.FreedomTeamManageFrame.quit");
         addToContent(_back);
         addToContent(_addBtn);
         addToContent(_changeBtn);
         addToContent(_lineUpBtn);
         addToContent(_kickBtn);
         addToContent(_quitBtn);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.Box");
         addToContent(_hBox);
         _buttonGroup = new SelectedButtonGroup();
         _playerList = new Dictionary();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            this["_hero" + _loc1_] = new FreedomTeamManageHeroItem();
            _hBox.addChild(this["_hero" + _loc1_]);
            _buttonGroup.addSelectItem(this["_hero" + _loc1_] as ISelectable);
            _playerList[_loc1_] = this["_hero" + _loc1_];
            (this["_hero" + _loc1_] as FreedomTeamManageHeroItem).index = _loc1_;
            _loc1_++;
         }
      }
      
      private function uninitView() : void
      {
         if(_buttonGroup)
         {
            _buttonGroup.removeAllItem();
         }
         ObjectUtils.disposeAllChildren(_hBox);
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         for each(var _loc1_:FreedomTeamManageHeroItem in _playerList)
         {
            _loc1_.addEventListener("click",__itemClickHandler);
         }
         addEventListener("response",__frameResponse);
         _addBtn.addEventListener("click",__addBtnClickHandler);
         _changeBtn.addEventListener("click",__changeBtnClickHandler);
         _lineUpBtn.addEventListener("click",__lineUpBtnClickHandler);
         _kickBtn.addEventListener("click",__kickBtnClickHandler);
         _quitBtn.addEventListener("click",__quitBtnClickHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         for each(var _loc1_:FreedomTeamManageHeroItem in _playerList)
         {
            _loc1_.removeEventListener("click",__itemClickHandler);
         }
         removeEventListener("response",__frameResponse);
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addBtnClickHandler);
         }
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",__changeBtnClickHandler);
         }
         if(_lineUpBtn)
         {
            _lineUpBtn.removeEventListener("click",__lineUpBtnClickHandler);
         }
         if(_kickBtn)
         {
            _kickBtn.removeEventListener("click",__kickBtnClickHandler);
         }
         if(_quitBtn)
         {
            _quitBtn.removeEventListener("click",__quitBtnClickHandler);
         }
         NotificationManager.instance.removeEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         _currentSelected = param1.currentTarget as FreedomTeamManageHeroItem;
         if(!_currentSelected)
         {
            return;
         }
         if(_currentSelected.data)
         {
            refreshContrl();
            _currentSelected.selected = true;
         }
      }
      
      private function __addBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("freedomteam","OPEN_INVITEFRAME");
      }
      
      private function __changeBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_currentSelected && playerInfo.userId == captainId && _currentSelected.data && playerInfo.userId != _currentSelected.data.baseHero.userId)
         {
            FreedomTeamManager.instance.changeCaptain(_currentSelected.data.userId,_currentSelected.data.baseHero.serviceName);
         }
      }
      
      private function __lineUpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("freedomteam","OPEN_SORTFRAME");
      }
      
      private function __kickBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_currentSelected || !_currentSelected.data)
         {
            return;
         }
         var _loc5_:String = LanguageMgr.GetTranslation("map.internals.view.team.FreedomTeamManageFrame.kickTipTxt");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [__requestKickBtnHandler,_currentSelected.data.userId,_currentSelected.data.baseHero.serviceName];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function __requestKickBtnHandler(param1:Boolean, param2:Boolean, param3:int, param4:String = "") : void
      {
         if(param1)
         {
            FreedomTeamManager.instance.kickMember(param3,param4);
         }
      }
      
      private function __quitBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc5_:String = LanguageMgr.GetTranslation("map.internals.view.team.FreedomTeamManageFrame.quitTipTxt");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [__requestQuitBtnHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function __requestQuitBtnHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FreedomTeamManager.instance.quit();
         }
      }
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         if(FreedomTeamManager.instance.hasTeam)
         {
            refreshData();
            refreshContrl();
            setCaptain();
         }
         else
         {
            dispose();
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function refreshData() : void
      {
         var _loc4_:BaseArmy = null;
         var _loc3_:int = 0;
         if(!FreedomTeamManager.instance.hasTeam)
         {
            return;
         }
         var _loc1_:Array = [];
         var _loc2_:Array = FreedomTeamManager.instance.model.allMembers;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc4_ = _loc2_[_loc3_] as BaseArmy;
            (_playerList[_loc3_] as FreedomTeamManageHeroItem).data = _loc4_;
            _loc3_++;
         }
      }
      
      private function refreshContrl() : void
      {
         if(captainId == playerInfo.userId)
         {
            _changeBtn.enable = isCurrentSelectedSelf ? false : true;
            _kickBtn.enable = isCurrentSelectedSelf ? false : true;
            _lineUpBtn.text = LanguageMgr.GetTranslation("armyII.viewII.allocate.AllocateView.sort");
         }
         else
         {
            _changeBtn.enable = false;
            _kickBtn.enable = false;
            _lineUpBtn.text = LanguageMgr.GetTranslation("map.internals.view.team.FreedomTeamManageFrame.sortCheck");
         }
         if(SceneManager.instance.currentType == "PLANE_CRISRIS")
         {
            if(_kickBtn)
            {
               _kickBtn.enable = false;
            }
            if(_quitBtn)
            {
               _quitBtn.enable = false;
            }
            if(_addBtn)
            {
               _addBtn.enable = false;
            }
         }
      }
      
      private function setCaptain() : void
      {
         for each(var _loc1_:FreedomTeamManageHeroItem in _playerList)
         {
            if(_loc1_.data && _loc1_.data.userId == captainId)
            {
               _loc1_.isCaptain = true;
            }
            else
            {
               _loc1_.isCaptain = false;
            }
         }
      }
      
      private function get isCurrentSelectedSelf() : Boolean
      {
         if(_currentSelected && _currentSelected.data && _currentSelected.data.userId == playerInfo.userId)
         {
            return true;
         }
         return false;
      }
      
      private function get model() : FreedomTeamModel
      {
         return FreedomTeamManager.instance.model;
      }
      
      public function get captainId() : int
      {
         return model.captainId;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show(param1:int = 0) : void
      {
         CheckUIModuleUtil.instance.tryCall("teammanager",initShow);
      }
      
      private function initShow() : void
      {
         initView();
         refreshData();
         refreshContrl();
         setCaptain();
         addEvent();
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

