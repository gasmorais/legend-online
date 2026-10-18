package map.campaign.view.ui.activevehicle
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ArmyEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import im.view.IMMsgBoxView;
   import manager.LanguageMgr;
   import managers.IMManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.ActiveVehicleModel;
   import map.campaign.data.CampaignArmy;
   import mvc.module.armyII.BaseArmy;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.TimerUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.component.MovieButton;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ActiveVehicleBottomViewII extends Component
   {
      
      private var _head:BaseIconView;
      
      private var _bg:Image;
      
      private var _hpTxt:FilterFrameText;
      
      private var _hpComponent:Component;
      
      private var _bloodmc:MovieClip;
      
      private var _icon01:CrossSkillIcon;
      
      private var _icon02:CrossSkillIcon;
      
      private var _icon03:CrossSkillIcon;
      
      private var _icon04:CrossSkillIcon;
      
      private var _iconList:Array;
      
      private var _helpBtn:BaseButton;
      
      private var _settingBtn:BaseButton;
      
      private var _chatMessageBtn:MovieButton;
      
      private var _consortiaChatBtn:MovieButton;
      
      private var _buffBar:ActiveVehicleBufferBar;
      
      private var _exitBtn:BaseButton;
      
      private var _model:ActiveVehicleModel = CampaignManager.instance.activeVehicleModel;
      
      private var _selfArmy:CampaignArmy = CampaignManager.instance.mapModel.selfMemberData;
      
      public function ActiveVehicleBottomViewII()
      {
         super();
         this.width = 620;
         this.height = 85;
         initView();
         addEvent();
         refreshActiveVehicleSkills();
      }
      
      public function show() : void
      {
         this.visible = true;
         LayerManager.Instance.addToLayer(this,4,false,false,0,2);
      }
      
      private function initView() : void
      {
         _head = ComponentFactory.Instance.creatCustomObject("ui.snowball.Head");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.snowball.skillBack");
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBottomBar.HpTxt");
         _hpComponent = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingBottomBar.HpComponent");
         _bloodmc = ComponentFactory.Instance.creat("asset.snowball.BloodBar");
         _icon01 = new CrossSkillIcon("Q");
         _icon02 = new CrossSkillIcon("W");
         _icon03 = new CrossSkillIcon("E");
         _icon04 = new CrossSkillIcon("Space",true);
         _buffBar = new ActiveVehicleBufferBar();
         _settingBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBottomBar.SettingBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBottomBar.HelpBtn");
         _chatMessageBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBottomBar.ChatMessageBtn");
         _consortiaChatBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBottomBar.ConsortiaChatBtn");
         _exitBtn = ComponentFactory.Instance.creatComponentByStylename("ui.snowball.ExitBtn");
         _hpComponent.addChild(_hpTxt);
         _hpComponent.x = 138;
         _hpComponent.y = 68;
         _bloodmc.gotoAndStop(100);
         _bloodmc.x = 135;
         _bloodmc.y = 68;
         _icon01.x = 144;
         _icon02.x = 196;
         _icon03.x = 246;
         _icon04.x = 298;
         _icon01.y = _icon02.y = _icon03.y = _icon04.y = 22;
         _iconList = [_icon01,_icon02,_icon03,_icon04];
         _buffBar.x = 152;
         _buffBar.y = -15;
         _settingBtn.y = -15;
         _chatMessageBtn.y = -14;
         _chatMessageBtn.stopEffect();
         _consortiaChatBtn.y = -13;
         _hpComponent.tipData = LanguageMgr.GetTranslation("battle.view.bottomSelfBloodView.tip");
         _settingBtn.tipData = LanguageMgr.GetTranslation("setting.SettingFrame.title");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _chatMessageBtn.tipData = LanguageMgr.GetTranslation("battle.view.ui.BattleUIView.msgBoxTip");
         _consortiaChatBtn.tipData = LanguageMgr.GetTranslation("consortiagroupchat.msgBoxItemNameTxt");
         _exitBtn.tipData = LanguageMgr.GetTranslation("crossBottomBar.exitBtn.tip");
         addChild(_bg);
         addChild(_head);
         addChild(_bloodmc);
         addChild(_hpComponent);
         addChild(_icon01);
         addChild(_icon02);
         addChild(_icon03);
         addChild(_icon04);
         addChild(_buffBar);
         addChild(_settingBtn);
         if(ArmyManager.instance.thane.grades >= 6)
         {
            addChild(_chatMessageBtn);
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID > 0)
         {
            addChild(_consortiaChatBtn);
         }
         setMsgBtnShining();
         setConsortiaChatBtnShining();
         addChild(_exitBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_head);
         _head = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_exitBtn);
         _exitBtn = null;
         ObjectUtils.disposeObject(_hpTxt);
         _hpTxt = null;
         ObjectUtils.disposeObject(_hpComponent);
         _hpComponent = null;
         ObjectUtils.disposeViolentMc(_bloodmc);
         _bloodmc = null;
         ObjectUtils.disposeObject(_icon01);
         _icon01 = null;
         ObjectUtils.disposeObject(_icon02);
         _icon02 = null;
         ObjectUtils.disposeObject(_icon03);
         _icon03 = null;
         ObjectUtils.disposeObject(_icon04);
         _icon04 = null;
         ObjectUtils.disposeObject(_settingBtn);
         _settingBtn = null;
         ObjectUtils.disposeObject(_chatMessageBtn);
         _chatMessageBtn = null;
         ObjectUtils.disposeObject(_consortiaChatBtn);
         _consortiaChatBtn = null;
         ObjectUtils.disposeObject(_buffBar);
         _buffBar = null;
         ObjectUtils.disposeObject(_exitBtn);
         _exitBtn = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _iconList = null;
      }
      
      private function addEvent() : void
      {
         _exitBtn.addEventListener("click",__onExitHandler);
         _settingBtn.addEventListener("click",__openSettingFrameHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         NotificationManager.instance.addEventListener("MAP_USE_SKILL_CD",__startCDHandler);
         _chatMessageBtn.addEventListener("rollOut",__onMsgBtnRollOut);
         _chatMessageBtn.addEventListener("rollOver",__onMsgBtnRollOver);
         _chatMessageBtn.addEventListener("click",__mouseClickHandler);
         _consortiaChatBtn.addEventListener("click",__consortiaChatClickHandler);
         NotificationManager.instance.addEventListener("CHAT_FROM_CONSORTIA",__receiveGroupChatHandler);
         IMManager.instance.addEventListener("MSGBOX_SHINING_UPDATE",__chatMsgbtnShineHandler);
         if(_selfArmy)
         {
            _selfArmy.addEventListener("ACTIVEVEHICLE_HP_CHANGE",__hpChangeHandler);
            _selfArmy.addEventListener("ACTIVEVEHICLE_SKILL_CHANGE",__skillChangeHandler);
            _selfArmy.addEventListener("ACTIVEVEHICLE_SKILL_COUNT_CHANGE",__skillCountChangeHandler);
            _selfArmy.addEventListener("ACTIVEVEHICLE_INFO_CHANGE",__activeArmyInfoHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_exitBtn)
         {
            _exitBtn.removeEventListener("click",__onExitHandler);
         }
         if(_chatMessageBtn)
         {
            _chatMessageBtn.removeEventListener("rollOut",__onMsgBtnRollOut);
            _chatMessageBtn.removeEventListener("rollOver",__onMsgBtnRollOver);
            _chatMessageBtn.removeEventListener("click",__mouseClickHandler);
         }
         if(_consortiaChatBtn)
         {
            _consortiaChatBtn.removeEventListener("click",__consortiaChatClickHandler);
         }
         NotificationManager.instance.removeEventListener("CHAT_FROM_CONSORTIA",__receiveGroupChatHandler);
         NotificationManager.instance.removeEventListener("MAP_USE_SKILL_CD",__startCDHandler);
         IMManager.instance.removeEventListener("MSGBOX_SHINING_UPDATE",__chatMsgbtnShineHandler);
         if(_settingBtn)
         {
            _settingBtn.removeEventListener("click",__openSettingFrameHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         }
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("ACTIVEVEHICLE_HP_CHANGE",__hpChangeHandler);
            _selfArmy.removeEventListener("ACTIVEVEHICLE_SKILL_CHANGE",__skillChangeHandler);
            _selfArmy.removeEventListener("ACTIVEVEHICLE_SKILL_COUNT_CHANGE",__skillCountChangeHandler);
            _selfArmy.removeEventListener("ACTIVEVEHICLE_INFO_CHANGE",__activeArmyInfoHandler);
         }
      }
      
      private function __activeArmyInfoHandler(param1:ArmyEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:VehicleSkillTempInfo = null;
         changeHead();
         if(_selfArmy && _selfArmy.activeVehicleTempInfo)
         {
            _loc2_ = int(_selfArmy.activeVehicleTempInfo.NormalSkill);
            _loc3_ = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_loc2_);
            if(_loc3_)
            {
               _icon01.icon = IconFactory.getCommonIconPath(_loc3_.Icons);
               _icon01.coolDown = _loc3_.CoolDown;
               _icon01.skillInfo = _loc3_;
               _icon01.state = CrossSkillIcon.OPEN;
            }
            else
            {
               _icon01.state = CrossSkillIcon.LOCK;
            }
         }
      }
      
      public function resize() : void
      {
         var _loc1_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         this.x = (_loc1_ - this.width) / 2;
         this.y = _loc2_ - this.height;
      }
      
      private function userCount() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:CampaignArmy in CampaignManager.instance.mapModel.allUserArmy)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      private function __onExitHandler(param1:MouseEvent) : void
      {
         if(userCount() <= 1)
         {
            return;
         }
         SoundManager.instance.play("008");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("QUIT_CAMPAIGN"));
         SimpleAlertHelper.instance.data = [__returnCampaignHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("mainBar.MainToolBar.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.exitSnowVehicleCampaign");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
      }
      
      private function __returnCampaignHandler(param1:Boolean, param2:Boolean) : void
      {
         if(CampaignManager.CampaignOverState)
         {
            return;
         }
         if(param1)
         {
            CampaignSocketOutManager.instance.sendReturnCampaignRoom(currentArmyId);
         }
      }
      
      private function get currentArmyId() : int
      {
         var _loc1_:BaseArmy = ArmyManager.instance.army;
         if(_loc1_)
         {
            return _loc1_.id;
         }
         return 0;
      }
      
      private function __startCDHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         for each(var _loc3_:CrossSkillIcon in _iconList)
         {
            if(_loc3_.skillInfo && _loc3_.skillInfo.TemplateId == _loc2_)
            {
               _loc3_.startCD();
               break;
            }
         }
      }
      
      private function __onMsgBtnRollOut(param1:MouseEvent) : void
      {
         IMManager.instance.model.removeMsgBoxTimeOut = setTimeout(removeIMMsgBox,300);
      }
      
      private function removeIMMsgBox() : void
      {
         clearTimeout(IMManager.instance.model.removeMsgBoxTimeOut);
         IMManager.instance.removeIMMsgBox();
      }
      
      private function __onMsgBtnRollOver(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:IMMsgBoxView = IMManager.instance.createIMMsgBox();
         if(_loc3_)
         {
            ShowTipManager.Instance.removeCurrentTip();
            _loc2_ = new Point(_chatMessageBtn.x - (_loc3_.width - _chatMessageBtn.width) / 2,_chatMessageBtn.y - _loc3_.height);
            _loc2_ = this.localToGlobal(_loc2_);
            _loc3_.x = _loc2_.x;
            _loc3_.y = _loc2_.y;
            _loc2_ = null;
            LayerManager.Instance.addToLayer(_loc3_,3);
         }
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         StageReferance.stage.dispatchEvent(new KeyboardEvent("keyDown",true,false,0,13));
         param1.stopPropagation();
      }
      
      private function __consortiaChatClickHandler(param1:MouseEvent) : void
      {
         if(!FrameControllerManager.instance.consortiaGroupChatControler.isVisible())
         {
            setConsortiaChatBtnShining(false);
            FrameControllerManager.instance.openControllerByInfo("consortiagroupchat");
         }
      }
      
      private function __receiveGroupChatHandler(param1:NotificationEvent) : void
      {
         setConsortiaChatBtnShining();
      }
      
      private function __chatMsgbtnShineHandler(param1:Event) : void
      {
         setMsgBtnShining();
      }
      
      private function setMsgBtnShining() : void
      {
         if(IMManager.instance.friendBtnShining)
         {
            _chatMessageBtn.isPlaying = true;
            _chatMessageBtn.playEffect();
         }
         else
         {
            _chatMessageBtn.isPlaying = false;
            _chatMessageBtn.stopEffect();
         }
      }
      
      private function setConsortiaChatBtnShining(param1:Boolean = true) : void
      {
         if(param1 && Boolean(FrameControllerManager.instance.consortiaGroupChatControler.groupChatShining))
         {
            _consortiaChatBtn.isPlaying = true;
            _consortiaChatBtn.playEffect();
         }
         else
         {
            _consortiaChatBtn.isPlaying = false;
            _consortiaChatBtn.stopEffect();
         }
      }
      
      private function __openSettingFrameHandler(param1:MouseEvent) : void
      {
         TimerUtils.setTimeout(openFrame,10);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.HelperFrame");
         _loc2_.show();
      }
      
      private function openFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("setting");
      }
      
      private function refreshActiveVehicleSkills(param1:Boolean = false) : void
      {
         if(_selfArmy == null || !_selfArmy.activeVehicleTempInfo)
         {
            return;
         }
         changeHead();
         var _loc5_:int = int(_selfArmy.activeVehicleTempInfo.NormalSkill);
         var _loc4_:int = int(_selfArmy.activeVehicleSkillIdW);
         var _loc3_:int = int(_selfArmy.activeVehicleSkillIdE);
         var _loc2_:int = int(_selfArmy.activeVehicleSkillIdSpace);
         updateSKill(_loc5_,_loc4_,_loc3_,_loc2_);
         __hpChangeHandler(null);
      }
      
      private function changeHead() : void
      {
         var _loc1_:String = PathManager.getVehicleShowAvatarPath(_selfArmy.activeVehicleTempInfo.Avatar);
         if(_loc1_ != String(_head.icon))
         {
            _head.icon = _loc1_;
         }
      }
      
      private function updateSKill(param1:int = 1, param2:int = 6, param3:int = 0, param4:int = 0) : void
      {
         var _loc5_:VehicleSkillTempInfo = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(param1);
         if(_loc5_)
         {
            _icon01.icon = IconFactory.getCommonIconPath(_loc5_.Icons);
            _icon01.coolDown = _loc5_.CoolDown;
            _icon01.skillInfo = _loc5_;
            _icon01.state = CrossSkillIcon.OPEN;
         }
         else
         {
            _icon01.state = CrossSkillIcon.LOCK;
         }
         _loc5_ = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(param2);
         if(_loc5_)
         {
            _icon02.icon = IconFactory.getCommonIconPath(_loc5_.Icons);
            _icon02.coolDown = _loc5_.CoolDown;
            _icon02.skillInfo = _loc5_;
            _icon02.state = CrossSkillIcon.OPEN;
         }
         else
         {
            _icon02.state = CrossSkillIcon.LOCK;
         }
         _loc5_ = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(param3);
         if(_loc5_)
         {
            _icon03.icon = IconFactory.getCommonIconPath(_loc5_.Icons);
            _icon03.coolDown = _loc5_.CoolDown;
            _icon03.skillInfo = _loc5_;
            _icon03.state = CrossSkillIcon.OPEN;
         }
         else
         {
            _icon03.skillInfo = null;
            _icon03.state = CrossSkillIcon.LOCK;
         }
         _loc5_ = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(param4);
         if(_loc5_)
         {
            _icon04.icon = IconFactory.getCommonIconPath(_loc5_.Icons);
            _icon04.coolDown = _loc5_.CoolDown;
            _icon04.skillInfo = _loc5_;
            _icon04.state = CrossSkillIcon.OPEN;
         }
         else
         {
            _icon04.state = CrossSkillIcon.LOCK;
         }
      }
      
      private function __hpChangeHandler(param1:ArmyEvent = null) : void
      {
         var _loc2_:int = int(_selfArmy.activeTotalHp);
         var _loc3_:int = int(_selfArmy.activeCurHp);
         _hpTxt.text = LanguageMgr.GetTranslation("public.slash",_loc3_,_loc2_);
         var _loc4_:int = 100;
         if(_loc2_ != 0)
         {
            _loc4_ = _loc3_ * 100 / _loc2_;
         }
         _bloodmc.gotoAndStop(_loc4_);
      }
      
      private function __skillChangeHandler(param1:ArmyEvent) : void
      {
         refreshActiveVehicleSkills();
      }
      
      private function __skillCountChangeHandler(param1:ArmyEvent) : void
      {
         refreshActiveVehicleSkills(true);
      }
      
      override public function get width() : Number
      {
         return 448;
      }
      
      override public function get height() : Number
      {
         return 93;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         _model = null;
         super.dispose();
      }
   }
}

