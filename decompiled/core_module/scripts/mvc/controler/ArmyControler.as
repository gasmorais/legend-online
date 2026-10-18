package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import mvc.FrameController;
   import mvc.module.armyII.ArmyModel;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.RuneInfo;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.armyII.UserArmy;
   import mvc.module.buildings.BuildInfo;
   import ui.events.UIBarEvent;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.LoadingSceneView;
   import yishi.view.frame.ChangeHeadIconFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ArmyControler extends FrameController
   {
      
      public var currOpRuneInfo:RuneInfo;
      
      public var currentPage:int = 1;
      
      private var _model:ArmyModel;
      
      public var isAdjustPawn:Boolean = false;
      
      private var _dissmissFrame:Frame;
      
      private var _casernRecruitFrame:Frame;
      
      public function ArmyControler()
      {
         super();
         _model = new ArmyModel();
      }
      
      public function get model() : ArmyModel
      {
         return _model;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function getSkillFrame() : Frame
      {
         return _frame;
      }
      
      public function getPawnUpgradeFrame() : Frame
      {
         return _frame;
      }
      
      public function setOldData() : void
      {
         _model.oldEquip = GoodsManager.instance.getHeroEquipListById(_model.uArmy.baseHero.id);
         var _loc1_:ArmyPawn = _model.uArmy.getPawnByIndex(0);
         _model.tempId1 = _loc1_ ? _loc1_.templateId : 0;
         _model.count1 = _loc1_ ? _loc1_.ownPawns : 0;
      }
      
      public function startFrameByType(param1:String, param2:Object = null) : void
      {
         _loadedCount = 0;
         _model.currentOpenPanel = param1;
         if(param1 == ArmyPanelEnum.RECRUIT_PAWN)
         {
            FrameControllerManager.instance.openControllerByInfo("recruit_pawn",null,param2);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("army",null,param2);
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_model.currentOpenPanel == ArmyPanelEnum.ATTRIBUTE_PANEL || _model.currentOpenPanel == ArmyPanelEnum.EQUIP_PANEL || _model.currentOpenPanel == ArmyPanelEnum.INFORMATION_PANEL || _model.currentOpenPanel == ArmyPanelEnum.BATTLEGUARD_PANEL || _model.currentOpenPanel == ArmyPanelEnum.DRAGON_SOUL_PANEL || _model.currentOpenPanel == ArmyPanelEnum.TATTOO_PANEL || _model.currentOpenPanel == ArmyPanelEnum.HOLY_DRAGON_SOUL_PANEL)
         {
            return "army.ArmyFrameII";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.PAWN_PANEL)
         {
            return "army.PawnFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.SKILL_PANEL)
         {
            MainToolBar.instance.getButtnByType(4).buttonBtn.isPlaying = false;
            MainToolBar.instance.getButtnByType(4).buttonBtn.stopEffect();
            return "army.SkillFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.RECRUIT_PAWN)
         {
            return "army.RecruitPawnFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.SORT_PAWN)
         {
            return "army.SortPawnFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.PAWNUPGRADE)
         {
            return "army.PawnLevelUpFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.FUWEN_EQUI)
         {
            return "armyII.viewII.stone.ArmyStoneOpFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.FUSHI_BAG)
         {
            return "armyII.viewII.stone.ArmyStoneBagFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.FUSHI_DIAOKE)
         {
            return "armyII.viewII.stone.ArmyStoneDKFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.FUSHI_DIAOKE_TIP)
         {
            return "armyII.viewII.stone.ArmyStoneTipFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.FUSHI_INSTENSIFY)
         {
            return "armyII.viewII.stone.ArmyStoneIntensifyFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.FUSHI_GET_SHOW)
         {
            return "armyII.viewII.stone.ArmyShowGetFrame";
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.FUSHI_PRE_VIEW)
         {
            return "armyII.viewII.stone.StonePreFrame";
         }
         throw new Error("no such Frame" + _model.currentOpenPanel);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_model.currentOpenPanel == ArmyPanelEnum.ATTRIBUTE_PANEL || _model.currentOpenPanel == ArmyPanelEnum.EQUIP_PANEL || _model.currentOpenPanel == ArmyPanelEnum.INFORMATION_PANEL || _model.currentOpenPanel == ArmyPanelEnum.BATTLEGUARD_PANEL || _model.currentOpenPanel == ArmyPanelEnum.DRAGON_SOUL_PANEL || _model.currentOpenPanel == ArmyPanelEnum.HOLY_DRAGON_SOUL_PANEL || _model.currentOpenPanel == ArmyPanelEnum.TATTOO_PANEL)
         {
            _frame["show"]();
            _frame["defaultContent"] = _model.currentOpenPanel;
            NotificationManager.instance.dispatchEvent(new UIBarEvent("bagFrameOpened",this));
            if(_data.frameData)
            {
               _data.frameData();
            }
         }
         else if(_model.currentOpenPanel == ArmyPanelEnum.PAWNUPGRADE)
         {
            _frame["show"]();
            _frame["defaultSelected"] = _data.frameData as ArmyPawn;
         }
         else if(_model.currentOpenPanel == ArmyPanelEnum.SKILL_PANEL || _model.currentOpenPanel == ArmyPanelEnum.FUWEN_EQUI || _model.currentOpenPanel == ArmyPanelEnum.FUSHI_DIAOKE || _model.currentOpenPanel == ArmyPanelEnum.FUSHI_INSTENSIFY || _model.currentOpenPanel == ArmyPanelEnum.FUSHI_DIAOKE_TIP || _model.currentOpenPanel == ArmyPanelEnum.FUSHI_GET_SHOW || _model.currentOpenPanel == ArmyPanelEnum.FUSHI_PRE_VIEW)
         {
            if(_data.frameData)
            {
               _frame["show"](_data.frameData);
            }
            else
            {
               _frame["show"]();
            }
         }
         else
         {
            _frame["show"]();
         }
         NotificationManager.instance.dispatchEvent(new UIBarEvent("heroFrameOpened",_frame));
      }
      
      override protected function createFrame() : void
      {
         var _loc1_:BuildInfo = null;
         if(_model.currentOpenPanel == ArmyPanelEnum.RECRUIT_PAWN || _model.currentOpenPanel == ArmyPanelEnum.SORT_PAWN)
         {
            _loc1_ = BuildingManager.instance.model.getBuildingInfoBySonType(402);
            if(!_loc1_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.ArmyControler.command01"));
               if(_isLoadingLock)
               {
                  LoadingSceneView.instance.hide();
               }
               return;
            }
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.SORT_PAWN && userArmy.countAllArmyPawnNmber() <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.ArmyControler.command02"));
            if(_isLoadingLock)
            {
               LoadingSceneView.instance.hide();
            }
            return;
         }
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         if(_model.currentOpenPanel == ArmyPanelEnum.ATTRIBUTE_PANEL || _model.currentOpenPanel == ArmyPanelEnum.EQUIP_PANEL || _model.currentOpenPanel == ArmyPanelEnum.INFORMATION_PANEL)
         {
            sendEquipChange();
            NotificationManager.instance.dispatchEvent(new UIBarEvent("heroFrameClosed"));
         }
         if(_model.currentOpenPanel == ArmyPanelEnum.PAWN_PANEL)
         {
            if(_dissmissFrame)
            {
               _dissmissFrame["dispose"]();
            }
         }
         _dissmissFrame = null;
         super.exitFrame();
      }
      
      public function hide() : void
      {
         if(_frame)
         {
            _frame.visible = false;
         }
      }
      
      public function show() : void
      {
         if(_frame)
         {
            _frame.visible = true;
         }
      }
      
      public function openChangeHeadFrame(param1:Boolean = false) : void
      {
         var _loc2_:ChangeHeadIconFrame = ComponentFactory.Instance.creatComponentByStylename("core.ChangeHeadIconFrame");
         _loc2_.openFromBag = param1;
         _loc2_.show();
         if(param1)
         {
            hide();
         }
      }
      
      public function openStoreFarme() : void
      {
         FrameControllerManager.instance.storeController.setPreFrame("army",ArmyPanelEnum.EQUIP_PANEL);
         FrameControllerManager.instance.storeController.startFrameByType("STORE_PANEL_INTENSIFY");
         if(_frame)
         {
            _frame.dispose();
         }
         _frame = null;
         exitFrame();
      }
      
      public function openDissmissFrame(param1:Object) : void
      {
         _dissmissFrame = ComponentFactory.Instance.creatComponentByStylename("army.DissmissPawnFrame");
         _dissmissFrame["initControl"](this,_model);
         _dissmissFrame["data"] = param1;
         _dissmissFrame["show"]();
      }
      
      public function closeDissmissFrame() : void
      {
         _dissmissFrame = null;
      }
      
      public function openJewelFrame() : void
      {
         CheckUIModuleUtil.instance.tryCall("army",callBack);
      }
      
      private function callBack() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("army.JewelFrame");
         _loc1_["show"]();
      }
      
      public function openMedalFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame");
         _loc1_["show"]();
      }
      
      public function openConciseFrame() : void
      {
         CheckUIModuleUtil.instance.tryCall("army",callBackConcise);
      }
      
      private function callBackConcise() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame");
         _loc1_["show"]();
      }
      
      public function openCasernRecruitFrame(param1:ArmyPawn) : void
      {
         if(!_casernRecruitFrame)
         {
            _casernRecruitFrame = ComponentFactory.Instance.creatComponentByStylename("core.RecruitFrame");
            _casernRecruitFrame.addEventListener("dispose",__casernRecruitFrameDispose);
            _casernRecruitFrame["data"] = param1;
            _casernRecruitFrame["show"]();
         }
      }
      
      private function __casernRecruitFrameDispose(param1:Event) : void
      {
         _casernRecruitFrame.removeEventListener("dispose",__casernRecruitFrameDispose);
         _casernRecruitFrame = null;
      }
      
      public function closeCasernRecruitFrame() : void
      {
         if(_casernRecruitFrame)
         {
            _casernRecruitFrame.dispose();
         }
         _casernRecruitFrame = null;
      }
      
      public function get casernRecruitFrame() : Frame
      {
         return _casernRecruitFrame;
      }
      
      public function sendMovePawnInfo() : void
      {
         var _loc2_:ArmyPawn = _model.uArmy.getPawnByIndex(0);
         var _loc3_:int = int(_loc2_ ? _loc2_.templateId : 0);
         var _loc1_:int = int(_loc2_ ? _loc2_.ownPawns : 0);
         if(_model.tempId1 != _loc3_ || _model.count1 != _loc1_)
         {
            sendEditArmyPawn(0,_loc3_,_loc1_);
            setOldData();
         }
      }
      
      public function autoAllocate() : void
      {
         setOldData();
         model.autoAllocate();
         sendMovePawnInfo();
      }
      
      public function sendEditArmyPawn(param1:int, param2:int, param3:int) : void
      {
         ArmySocketOutManager.sendEditArmyPawn(param1,param2,param3);
      }
      
      public function sendRecruitPawn(param1:int, param2:int) : void
      {
         ArmySocketOutManager.sendRecruitPawn(param1,param2);
      }
      
      public function sendUpgradePawn(param1:int) : void
      {
         ArmySocketOutManager.sendUpgradePawn(param1);
      }
      
      public function sendPawnChange(param1:int, param2:int, param3:int, param4:Boolean = true) : void
      {
         ArmySocketOutManager.sendPawnChange(param1,param2,param3,param4);
      }
      
      public function sendWashPoint() : void
      {
         model.addAbility = 0;
         model.addAgility = 0;
         model.addCaptain = 0;
         model.addPhysique = 0;
         model.addStrength = 0;
         ArmySocketOutManager.sendWashPoint();
      }
      
      public function sendStudyRune(param1:int, param2:int) : void
      {
         ArmySocketOutManager.sendStudyRune(param1,param2);
      }
      
      public function sendUpgradeRune(param1:int) : void
      {
         ArmySocketOutManager.sendUpgradeRune(param1);
      }
      
      public function sendTakeRune(param1:String) : void
      {
         ArmySocketOutManager.sendTakeRune(param1);
      }
      
      public function sendAddSkillPoint(param1:SkillInfo) : void
      {
         ArmySocketOutManager.sendAddSkillpoint(param1.nextTemplateInfo.TemplateId);
      }
      
      public function sendWashSkillPoint(param1:int, param2:Boolean) : void
      {
         ArmySocketOutManager.sendWashSkillPoint(param1,0,param2);
      }
      
      public function sendSetFastKey(param1:String) : void
      {
         ArmySocketOutManager.sendSetFastKey(param1);
      }
      
      public function sendDismissPawn(param1:int, param2:int) : void
      {
         ArmySocketOutManager.sendDismissPawn(param1,param2);
      }
      
      public function sendEquipChange() : void
      {
         var _loc1_:int = equipChange();
         if(_loc1_ != 0)
         {
            if(PlayerManager.instance.currentPlayerModel.spaceMapId == 0)
            {
               return;
            }
            ArmySocketOutManager.sendChangeHeroInfo(_loc1_);
            thane.beginChanges();
            thane.commit();
         }
      }
      
      private function equipChange() : int
      {
         var _loc3_:int = _model.uArmy.baseHero.id;
         var _loc2_:SimpleDictionary = GoodsManager.instance.getHeroEquipListById(_loc3_);
         var _loc1_:SimpleDictionary = _model.oldEquip;
         if(_loc1_ && _loc2_)
         {
            if(_loc2_.getList().length != _loc1_.getList().length)
            {
               return _loc3_;
            }
            for each(var _loc4_:GoodsInfo in _loc1_)
            {
               if(_loc2_[_loc4_.id] != _loc4_)
               {
                  return _loc3_;
               }
            }
         }
         return 0;
      }
      
      public function sendActiveSecond(param1:Boolean) : void
      {
         ArmySocketOutManager.sendActiveSecondSkill(param1);
      }
      
      public function sendSkillChange(param1:int) : void
      {
         ArmySocketOutManager.sendSkillChange(param1);
      }
      
      public function sendWashTalentSkillPoint(param1:int, param2:int = 0, param3:Boolean = true) : void
      {
         ArmySocketOutManager.sendWashSkillPoint(param1,param2,param3);
      }
      
      public function sendAddTalentSkillPoint(param1:int, param2:int = 0, param3:int = 0) : void
      {
         ArmySocketOutManager.sendAddSkillpoint(param1,param2,param3);
      }
      
      public function sendUpTalentGrade(param1:Boolean = false, param2:int = 2) : void
      {
         ArmySocketOutManager.sendUpTalentGrade(param1,param2);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get userArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
   }
}

