package finaldefense.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import managers.FinalDefenseManager;
   import mvc.module.finaldefense.FinalDefenseModel;
   import mvc.module.finaldefense.info.DitchNpcInfoData;
   import yishi.datas.templates.DitchTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class FinalDefenseRoleView extends Component
   {
      
      protected var _parent:DisplayObject;
      
      protected var _defaultView:MovieClip;
      
      protected var _data:DitchNpcInfoData;
      
      protected var _tempInfo:DitchTemplateInfo;
      
      protected var _roleMc:MovieClip;
      
      private var _loader:Loader;
      
      protected var _uintFlag:uint;
      
      private var _filter:SimpleBuildingFilter;
      
      private var _skillHelper:FinalDefenseSkillHelper;
      
      private var _lvUpBtn:BaseButton;
      
      private var _cannotLvUpBtn:BaseButton;
      
      private var _upLvLifeBtn:BaseButton;
      
      private var _upLvIceBtn:BaseButton;
      
      private var _upLvFireBtn:BaseButton;
      
      protected var _attackFlag:uint;
      
      private var _setNormalFlag:uint;
      
      public function FinalDefenseRoleView(param1:DisplayObject)
      {
         super();
         _parent = param1;
         initView();
         initLvUpBtn();
         addEvent();
      }
      
      protected function initView() : void
      {
         _defaultView = ComponentFactory.Instance.creatCustomObject("finaldefense.RoleLoadingView");
         _filter = new SimpleBuildingFilter();
         _skillHelper = new FinalDefenseSkillHelper();
         addChild(_defaultView);
      }
      
      protected function initLvUpBtn() : void
      {
         _lvUpBtn = ComponentFactory.Instance.creatComponentByStylename("finaldefense.canLvUpBtn");
         _cannotLvUpBtn = ComponentFactory.Instance.creatComponentByStylename("finaldefense.cannotLvUpBtn");
         _upLvLifeBtn = ComponentFactory.Instance.creatComponentByStylename("finaldefense.lifeLvUpBtn");
         _upLvIceBtn = ComponentFactory.Instance.creatComponentByStylename("finaldefense.iceLvUpBtn");
         _upLvFireBtn = ComponentFactory.Instance.creatComponentByStylename("finaldefense.fireLvUpBtn");
         addChild(_lvUpBtn);
         addChild(_cannotLvUpBtn);
         addChild(_upLvLifeBtn);
         addChild(_upLvIceBtn);
         addChild(_upLvFireBtn);
         _lvUpBtn.visible = _cannotLvUpBtn.visible = _upLvLifeBtn.visible = _upLvIceBtn.visible = _upLvFireBtn.visible = false;
      }
      
      protected function __completeHandler(param1:Event) : void
      {
         if(_loader == null)
         {
            return;
         }
         _loader.contentLoaderInfo.removeEventListener("complete",__completeHandler);
         _loader.unloadAndStop(true);
         _loader = null;
         createRole();
      }
      
      public function set data(param1:DitchNpcInfoData) : void
      {
         var _loc3_:String = null;
         _data = param1;
         if(_skillHelper != null)
         {
            _skillHelper.data = param1;
         }
         if(this.x == 0)
         {
            setPoint();
         }
         _tempInfo = TempleteManager.instance.dichTemplateCate.getTemplateById(_data.templateId);
         onInfoUpdate();
         var _loc2_:String = "slg.resource.movie.MovieAsset" + _tempInfo.ResPath;
         if(ApplicationDomain.currentDomain.hasDefinition(_loc2_))
         {
            createRole();
         }
         else
         {
            _loc3_ = PathManager.getFinalDefenseRes(_tempInfo.ResPath);
            LoaderManagerII.instance.load(_loc3_,1,8,__onLoaderComplete);
            if(_defaultView != null)
            {
               addChild(_defaultView);
            }
         }
         if(FinalDefenseManager.ins.model.isGameStar)
         {
            gameStar();
         }
      }
      
      protected function setPoint() : void
      {
         this.x = 50 + _parent.width * _data.bornPoint / 100 + (4 - _data.rowIndex) * 35;
         this.y = 50 + _parent.height * _data.rowIndex * 0.18;
      }
      
      public function gameStar() : void
      {
         attack();
      }
      
      protected function attack() : void
      {
         clearInterval(_attackFlag);
         _attackFlag = setInterval(attackAction,2000);
      }
      
      protected function attackAction() : void
      {
         if(FinalDefenseManager.ins.model.hasMonsterByRow(_data.rowIndex))
         {
            if(_roleMc != null)
            {
               _roleMc.gotoAndPlay("Attack01");
               sendAttack();
            }
         }
      }
      
      protected function sendAttack() : void
      {
         var _loc1_:int = int(FinalDefenseManager.ins.model.getMonsterIdByRow(_data.rowIndex));
         FinalDefenseManager.ins.sendAttack(_data.id,_loc1_);
         NotificationManager.instance.sendNotification("FINAL_DEFENSE_ATTACK_MONSTER",_data);
      }
      
      protected function __onLoaderComplete(param1:LoaderInfo, param2:Object) : void
      {
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__completeHandler);
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loader.loadBytes(param2 as ByteArray,_loc3_);
      }
      
      protected function createRole() : void
      {
         ObjectUtils.disposeViolentMc(_roleMc);
         _roleMc = null;
         if(_defaultView != null && _defaultView.parent)
         {
            _defaultView.parent.removeChild(_defaultView);
         }
         var _loc1_:String = "slg.resource.movie.MovieAsset" + _tempInfo.ResPath;
         var _loc2_:Class = ApplicationDomain.currentDomain.getDefinition(_loc1_) as Class;
         _roleMc = new _loc2_() as MovieClip;
         addChild(_roleMc);
         if(FinalDefenseManager.ins.model.isGameStar)
         {
            gameStar();
         }
      }
      
      private function onInfoUpdate(param1:Event = null) : void
      {
         if(_lvUpBtn == null || _cannotLvUpBtn == null)
         {
            return;
         }
         _lvUpBtn.visible = _cannotLvUpBtn.visible = false;
         if(_tempInfo.upgradeNeedEnergy <= model.info.energy)
         {
            _lvUpBtn.visible = true;
         }
         else
         {
            _cannotLvUpBtn.visible = true;
         }
         if(_tempInfo.NextTemplateIds == "")
         {
            if(_lvUpBtn != null && _cannotLvUpBtn != null)
            {
               _lvUpBtn.visible = _cannotLvUpBtn.visible = false;
            }
         }
      }
      
      private function get model() : FinalDefenseModel
      {
         return FinalDefenseManager.ins.model;
      }
      
      private function onLvUpClick(param1:MouseEvent) : void
      {
         var _loc2_:Array = _tempInfo.NextTemplateIds.split(",");
         if(_loc2_.length != 1)
         {
            _upLvLifeBtn.visible = _upLvIceBtn.visible = _upLvFireBtn.visible = !_upLvLifeBtn.visible;
         }
         else
         {
            FinalDefenseManager.ins.npcLvUp(_data.id,_data.rowIndex,int(_tempInfo.NextTemplateIds));
         }
      }
      
      protected function addEvent() : void
      {
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_BATTLE_RESULT",onBattleResult);
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_INFO",onInfoUpdate);
         if(_lvUpBtn != null)
         {
            _lvUpBtn.addEventListener("click",onLvUpClick);
         }
         if(_upLvLifeBtn != null)
         {
            _upLvLifeBtn.addEventListener("click",onLifeLvUpBtnClick);
         }
         if(_upLvIceBtn != null)
         {
            _upLvIceBtn.addEventListener("click",onIceLvUpClick);
         }
         if(_upLvFireBtn != null)
         {
            _upLvFireBtn.addEventListener("click",onFireLvUpClick);
         }
         StageReferance.stage.addEventListener("click",onStageClick);
      }
      
      protected function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_BATTLE_RESULT",onBattleResult);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_INFO",onInfoUpdate);
         if(_lvUpBtn != null)
         {
            _lvUpBtn.removeEventListener("click",onLvUpClick);
         }
         if(_upLvLifeBtn != null)
         {
            _upLvLifeBtn.removeEventListener("click",onLifeLvUpBtnClick);
         }
         if(_upLvIceBtn != null)
         {
            _upLvIceBtn.removeEventListener("click",onIceLvUpClick);
         }
         if(_upLvFireBtn != null)
         {
            _upLvFireBtn.removeEventListener("click",onFireLvUpClick);
         }
         StageReferance.stage.removeEventListener("click",onStageClick);
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         if(_upLvLifeBtn == null)
         {
            StageReferance.stage.removeEventListener("click",onStageClick);
            return;
         }
         if(param1.target != _lvUpBtn)
         {
            _upLvLifeBtn.visible = _upLvIceBtn.visible = _upLvFireBtn.visible = false;
         }
      }
      
      private function onLifeLvUpBtnClick(param1:MouseEvent) : void
      {
         FinalDefenseManager.ins.npcLvUp(_data.id,_data.rowIndex,101);
      }
      
      private function onIceLvUpClick(param1:MouseEvent) : void
      {
         FinalDefenseManager.ins.npcLvUp(_data.id,_data.rowIndex,201);
      }
      
      private function onFireLvUpClick(param1:MouseEvent) : void
      {
         FinalDefenseManager.ins.npcLvUp(_data.id,_data.rowIndex,301);
      }
      
      protected function onBattleResult(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:DitchNpcInfoData = null;
         var _loc2_:Array = param1.data as Array;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_.id == _data.id && Boolean(_loc3_.isBeaten))
            {
               _filter.setLightFilter(_roleMc);
               _setNormalFlag = setTimeout(setNormal,500);
               if(_loc3_.hp <= 0)
               {
                  roleDea();
               }
            }
            _loc4_++;
         }
      }
      
      private function setNormal() : void
      {
         if(_roleMc != null)
         {
            _filter.setNormalFilter(_roleMc);
         }
      }
      
      protected function roleDea() : void
      {
         NotificationManager.instance.sendNotification("FINAL_DEFENSE_ROLE_DEA",_data.id);
         FinalDefenseManager.ins.model.delDeaSelfNPC(_data.id);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearInterval(_attackFlag);
         clearInterval(_uintFlag);
         clearTimeout(_setNormalFlag);
         ObjectUtils.disposeObject(_defaultView);
         _defaultView = null;
         ObjectUtils.disposeViolentMc(_roleMc);
         _roleMc = null;
         if(_skillHelper != null)
         {
            _skillHelper.dispose();
            _skillHelper = null;
         }
         if(_loader != null)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__completeHandler);
            _loader.unloadAndStop(true);
            _loader = null;
         }
         super.dispose();
      }
   }
}

