package battle.view.bottom
{
   import battle.BattleManager;
   import battle.view.ui.AvengerBattleSkillView;
   import battle.view.ui.SelfBufferView;
   import battle.view.ui.SkillItemListView;
   import battle.view.ui.SkillWarsoulView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import org.aswing.KeyboardManager;
   import yishi.datas.BattleModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.RoleEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.TimerUtils;
   
   public class BottomBar extends Sprite
   {
      
      private var _back:MovieClip;
      
      private var _skillList:SkillItemListView;
      
      private var _warsoulSkill:SkillWarsoulView;
      
      private var _selfBloodView:SelfBloodView;
      
      private var _bufferContainer:SelfBufferView;
      
      private var _selfSpView:SelfSpView;
      
      private var _avengerView:AvengerBattleSkillView;
      
      private var _childAwakenView:ChildAwakenView;
      
      private var _ballRotate:Boolean;
      
      private var _settingBtn:BaseButton;
      
      private var _leftAwakenFigure:SelfAwakenView;
      
      private var _selfHitPointView:SelfHitPointView;
      
      private var _beliefView:BattleBeliefProgressView;
      
      private var _selfInfo:HeroRoleInfo;
      
      private var _childInfo:HeroRoleInfo;
      
      private var _battleModel:BattleModel;
      
      public function BottomBar(param1:Boolean = true)
      {
         super();
         _battleModel = BattleManager.getInstance().battleModel;
         _selfInfo = _battleModel.selfHero;
         _childInfo = _battleModel.childHero;
         _ballRotate = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("asset.battle.BottomBack");
         _back.smoothing = true;
         _back.x = -_back.width * 0.5;
         _back.y = -_back.height;
         _back.gotoAndStop(1);
         addChild(_back);
         _childAwakenView = new ChildAwakenView(this);
         _selfBloodView = new SelfBloodView(this);
         _selfSpView = new SelfSpView(this,_selfInfo.spMax);
         _selfHitPointView = new SelfHitPointView();
         _selfHitPointView.x = _back.x + 150;
         _selfHitPointView.y = _back.y + 66;
         _selfHitPointView.updateHeroHitPoint(_selfInfo.hitPoint);
         _back.gotoAndStop(1);
         if(_selfInfo.heroInfo && _selfInfo.heroInfo.dragonTalkerInfo.isDragonTalker)
         {
            addChild(_selfHitPointView);
            _back.gotoAndStop(3);
         }
         else
         {
            _back.gotoAndStop(1);
         }
         if(_selfInfo.heroInfo && _selfInfo.heroInfo.isAvenger && _selfInfo.avengerFightSkills.length > 0)
         {
            _avengerView = new AvengerBattleSkillView();
            _avengerView.x = _back.x - 110;
            _avengerView.y = _back.y + 100;
            _avengerView.updateAvengerSp(_selfInfo.avengerSp);
            _avengerView.updateAvengerSkills();
            addChild(_avengerView);
         }
         onHeroSpChanged(null);
         __childAwakenChangeHandler(null);
         if(VersionSwitch.WARSOUL)
         {
            _warsoulSkill = new SkillWarsoulView();
            _warsoulSkill.x = -235;
            _warsoulSkill.y = -116;
            addChild(_warsoulSkill);
         }
         _skillList = new SkillItemListView();
         _skillList.x = -235;
         _skillList.y = -65;
         addChild(_skillList);
         redrawBack();
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.battle.BottomTextBack");
         _loc1_.x = _back.x + 154;
         _loc1_.y = _back.y + 178;
         addChild(_loc1_);
         _loc1_ = new Bitmap(_loc1_.bitmapData);
         _loc1_.x = _back.x + 745;
         _loc1_.y = _back.y + 178;
         addChild(_loc1_);
         addChild(_selfSpView.heroSpNumContainer);
         addChild(_selfBloodView.heroHpNumContainer);
         if(GodDessManager.instance.isOpen)
         {
            _beliefView = new BattleBeliefProgressView();
            _beliefView.x = _back.x + 830;
            _beliefView.y = _back.y + 60;
            addChild(_beliefView);
         }
         _bufferContainer = new SelfBufferView();
         _bufferContainer.x = -190;
         _bufferContainer.y = -99;
         addChild(_bufferContainer);
         if(VersionSwitch.WARSOUL)
         {
            _bufferContainer.y = -144;
            _bufferContainer.x = -165;
         }
         _settingBtn = ComponentFactory.Instance.creatComponentByStylename("battle.settingBtn");
         addChild(_settingBtn);
         _settingBtn.tipData = LanguageMgr.GetTranslation("battle.view.bottom.BottomBar.settingBtn.tipData");
         showVesselBall();
         switchSkills(_selfInfo.isPetState);
      }
      
      private function addEvent() : void
      {
         if(_settingBtn)
         {
            _settingBtn.addEventListener("click",onSettingBtnClick);
         }
         if(_selfInfo)
         {
            _selfInfo.addEventListener("sp",onHeroSpChanged);
            _selfInfo.addEventListener("MORPH",__morphHandler);
            _selfInfo.addEventListener("HIT_POINT",__hitPointChangeHandler);
         }
         if(_childInfo)
         {
            _childInfo.addEventListener("AWAKEN",__childAwakenChangeHandler);
         }
         KeyboardManager.getInstance().addEventListener("keyDown",onKeyDown);
         NotificationManager.instance.addEventListener("sceneEffectClose",onSceneEffecCloseHandler);
      }
      
      private function removeEvent() : void
      {
         if(_settingBtn)
         {
            _settingBtn.removeEventListener("click",onSettingBtnClick);
         }
         if(_selfInfo)
         {
            _selfInfo.removeEventListener("sp",onHeroSpChanged);
            _selfInfo.removeEventListener("MORPH",__morphHandler);
            _selfInfo.removeEventListener("HIT_POINT",__hitPointChangeHandler);
         }
         if(_childInfo)
         {
            _childInfo.removeEventListener("AWAKEN",__childAwakenChangeHandler);
         }
         KeyboardManager.getInstance().removeEventListener("keyDown",onKeyDown);
         NotificationManager.instance.removeEventListener("sceneEffectClose",onSceneEffecCloseHandler);
      }
      
      private function __hitPointChangeHandler(param1:Event) : void
      {
         var _loc2_:int = int(_selfInfo.hitPoint);
         if(_selfHitPointView && _selfHitPointView.parent)
         {
            _selfHitPointView.updateHeroHitPoint(_selfInfo.hitPoint);
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode != 32)
         {
            return;
         }
         if(_leftAwakenFigure)
         {
            _leftAwakenFigure.onKeyDown(param1);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function redrawBack() : void
      {
         var _loc1_:int = int(_selfInfo.heroInfo ? _selfInfo.heroInfo.templateInfo.Job : int(thane.templateInfo.Job));
         if(_loc1_ == 100)
         {
            _loc1_ = 1;
         }
         _leftAwakenFigure = new SelfAwakenView(_loc1_);
         _leftAwakenFigure.direction = 1;
         addChild(_leftAwakenFigure);
         if(_selfInfo)
         {
            _leftAwakenFigure.updateTo(_selfInfo.awaken);
         }
         if(_loc1_ == 1)
         {
            _leftAwakenFigure.x = -357;
            _leftAwakenFigure.y = -119;
         }
         else if(_loc1_ == 2)
         {
            _leftAwakenFigure.x = -367;
            _leftAwakenFigure.y = -119;
         }
         else
         {
            _leftAwakenFigure.x = -362;
            _leftAwakenFigure.y = -118;
         }
      }
      
      private function onSceneEffecCloseHandler(param1:Event) : void
      {
         setBallRotation(false);
      }
      
      private function setBallRotation(param1:Boolean) : void
      {
         if(_selfBloodView)
         {
            _selfBloodView.setRotation(param1);
         }
         if(_selfSpView)
         {
            _selfSpView.setRotation(param1);
         }
      }
      
      private function showVesselBall() : void
      {
         _selfBloodView.showBall(_ballRotate);
         _selfSpView.showBall(_ballRotate);
      }
      
      private function onHeroSpChanged(param1:RoleEvent) : void
      {
         var _loc2_:int = int(_selfInfo.sp);
         _selfSpView.updateHeroSp(_loc2_);
      }
      
      private function __childAwakenChangeHandler(param1:RoleEvent) : void
      {
         var _loc2_:int = 0;
         if(_childInfo)
         {
            _loc2_ = int(_childInfo.awaken);
            _childAwakenView.updateChildAwaken(_loc2_);
         }
      }
      
      private function __morphHandler(param1:Event) : void
      {
         if(!_selfInfo)
         {
            return;
         }
         switchSkills(_selfInfo.isPetState);
         _skillList.startAppearCd();
      }
      
      public function switchSkills(param1:Boolean) : void
      {
         _skillList.switchSkills(param1);
      }
      
      public function getSpGlobalPos() : Point
      {
         return this.localToGlobal(new Point(280,-73));
      }
      
      public function getHitPointGlobalPos() : Point
      {
         return this.localToGlobal(new Point(-330,-110));
      }
      
      public function getSkillList() : SkillItemListView
      {
         return _skillList;
      }
      
      public function getSelfBloodView() : SelfBloodView
      {
         return _selfBloodView;
      }
      
      public function get activeAwakenFigure() : SelfAwakenView
      {
         return _leftAwakenFigure;
      }
      
      private function onSettingBtnClick(param1:MouseEvent) : void
      {
         TimerUtils.setTimeout(openFrame,10);
      }
      
      private function openFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("setting");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_settingBtn);
         _settingBtn = null;
         ObjectUtils.disposeObject(_selfBloodView);
         _selfBloodView = null;
         ObjectUtils.disposeObject(_selfSpView);
         _selfSpView = null;
         ObjectUtils.disposeObject(_childAwakenView);
         _childAwakenView = null;
         ObjectUtils.disposeObject(_leftAwakenFigure);
         _leftAwakenFigure = null;
         ObjectUtils.disposeObject(_skillList);
         _skillList = null;
         ObjectUtils.disposeViolentMc(_back);
         _back = null;
         ObjectUtils.disposeObject(_bufferContainer);
         _bufferContainer = null;
         ObjectUtils.disposeObject(_warsoulSkill);
         _warsoulSkill = null;
         ObjectUtils.disposeObject(_beliefView);
         _beliefView = null;
         ObjectUtils.disposeObject(_selfHitPointView);
         _selfHitPointView = null;
         ObjectUtils.disposeObject(_avengerView);
         _avengerView = null;
         _selfInfo = null;
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

