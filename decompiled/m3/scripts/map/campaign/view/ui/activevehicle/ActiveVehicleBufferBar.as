package map.campaign.view.ui.activevehicle
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.ArmyEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.skill.MapBuffHurtData;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ActiveVehicleBufferBar extends Component
   {
      
      private var _dic:Dictionary = new Dictionary(true);
      
      private var _iconDic:Dictionary = new Dictionary(true);
      
      private var _hBox:HBox;
      
      private var _timer:Timer;
      
      private var _selfArmy:CampaignArmy;
      
      public function ActiveVehicleBufferBar()
      {
         super();
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         initView();
         addEvent();
         this.mouseEnabled = false;
         _hBox.mouseEnabled = false;
         initBuff();
      }
      
      private function initView() : void
      {
         _hBox = new HBox();
         _hBox.spacing = 1;
         addChild(_hBox);
      }
      
      private function addEvent() : void
      {
         if(_selfArmy)
         {
            _selfArmy.addEventListener("ACTIVEVEHICLE_HP_CHANGE",__dieHandler);
            _selfArmy.addEventListener("ADD_BUFF",__addBuffHandler);
            _selfArmy.addEventListener("REMOVE_BUFF",__removeBuffHandler);
            _selfArmy.addEventListener("ACTIVEVEHICLE_INFO_CHANGE",__onActiveInfoChangeHandler);
            _selfArmy.addEventListener("ACTIVEVEHICLE_SKILL_CHANGE",__bufferChangeHandler);
         }
         if(!_timer)
         {
            _timer = new Timer(1000);
            _timer.start();
            _timer.addEventListener("timer",__onTimerHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("ACTIVEVEHICLE_HP_CHANGE",__dieHandler);
            _selfArmy.removeEventListener("ADD_BUFF",__addBuffHandler);
            _selfArmy.removeEventListener("REMOVE_BUFF",__removeBuffHandler);
            _selfArmy.removeEventListener("ACTIVEVEHICLE_INFO_CHANGE",__onActiveInfoChangeHandler);
            _selfArmy.removeEventListener("ACTIVEVEHICLE_SKILL_CHANGE",__bufferChangeHandler);
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerHandler);
            _timer = null;
         }
      }
      
      public function __dieHandler(param1:ArmyEvent) : void
      {
         if(_selfArmy.activeCurHp <= 0)
         {
            initBuff();
         }
      }
      
      private function __bufferChangeHandler(param1:ArmyEvent) : void
      {
         initBuff();
      }
      
      private function __addBuffHandler(param1:ArmyEvent) : void
      {
         var _loc2_:MapBuffHurtData = param1.data as MapBuffHurtData;
         _hBox.beginChanges();
         addBuff(_loc2_);
         _hBox.commitChanges();
      }
      
      private function addBuff(param1:MapBuffHurtData) : void
      {
         var _loc3_:BaseIconView = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc2_:int = int(param1.buffId);
         var _loc4_:VehicleSkillBuffTemplate = TempleteManager.instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(_loc2_);
         if(_dic[_loc2_] && _iconDic[_loc2_])
         {
            _loc3_ = _iconDic[_loc2_] as BaseIconView;
            _loc3_.tipData = param1;
            _loc5_ = _dic[_loc2_] as MovieClip;
            if(_loc5_ && !_loc5_.parent)
            {
               _hBox.addChild(_loc5_);
            }
         }
         else if(_loc4_ && _loc4_.Duration != 0)
         {
            _loc5_ = ComponentFactory.Instance.creat("asset.vehiclemap.CdIcon");
            _loc5_.gotoAndStop(1);
            _loc3_ = ComponentFactory.Instance.creatCustomObject("map.buffIcon");
            _loc3_.icon = IconFactory.getCommonIconPath(_loc4_.Icon);
            _loc3_.tipData = param1;
            _loc5_.gotoAndStop(1);
            _loc5_["icon"].addChild(_loc3_);
            _loc6_ = _loc5_["iconMask"] as MovieClip;
            _loc6_.gotoAndStop(1);
            if(_loc6_.parent)
            {
               _loc6_.parent.removeChild(_loc6_);
            }
            _dic[_loc2_] = _loc5_;
            _iconDic[_loc2_] = _loc3_;
            _hBox.addChild(_loc5_);
         }
      }
      
      private function __removeBuffHandler(param1:ArmyEvent) : void
      {
         var _loc2_:MapBuffHurtData = param1.data as MapBuffHurtData;
         if(_dic[_loc2_.buffId])
         {
            startRemoveMovie(_loc2_.buffId);
         }
         ObjectUtils.disposeObject(_iconDic[_loc2_.buffId]);
         ObjectUtils.disposeObject(_dic[_loc2_.buffId]);
         delete _iconDic[_loc2_.buffId];
         delete _dic[_loc2_.buffId];
      }
      
      private function __onActiveInfoChangeHandler(param1:ArmyEvent) : void
      {
         _selfArmy.removeEventListener("ACTIVEVEHICLE_INFO_CHANGE",__onActiveInfoChangeHandler);
         initBuff();
      }
      
      private function __onTimerHandler(param1:TimerEvent) : void
      {
         var _loc4_:MapBuffHurtData = null;
         var _loc3_:VehicleSkillBuffTemplate = null;
         if(isDie)
         {
            return;
         }
         for each(var _loc2_:BaseIconView in _iconDic)
         {
            if(_loc2_.tipData && _loc2_.tipData is MapBuffHurtData)
            {
               _loc4_ = _loc2_.tipData as MapBuffHurtData;
               _loc3_ = TempleteManager.instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(_loc4_.buffId);
               if(_loc3_ && _loc3_.Duration != -1)
               {
                  if(_loc4_.leftTime <= 1)
                  {
                     startRemoveMovie(_loc4_.buffId);
                  }
               }
            }
         }
      }
      
      private function clear() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:String = null;
         for each(var _loc1_:DisplayObject in _dic)
         {
            _loc3_ = _loc1_["iconMask"];
            if(_loc3_)
            {
               TweenMax.killTweensOf(_loc3_);
            }
            TweenMax.killTweensOf(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
         }
         for(_loc2_ in _dic)
         {
            delete _dic[_loc2_];
            delete _iconDic[_loc2_];
         }
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function createPassiveBuff() : BaseIconView
      {
         var _loc2_:BaseIconView = null;
         if(!_selfArmy)
         {
            return null;
         }
         if(!_selfArmy.activeVehicleTempInfo)
         {
            return null;
         }
         var _loc3_:int = int(_selfArmy.activeVehicleTempInfo.GeniusSkill);
         var _loc1_:VehicleSkillTempInfo = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_loc3_);
         if(_loc1_ && _loc1_.InjuryEffect == 3)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("map.buffIcon");
            _loc2_.icon = IconFactory.getCommonIconPath(_loc1_.Icons);
            _loc2_.tipData = _loc1_;
            _hBox.addChild(_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      private function initBuff() : void
      {
         ObjectUtils.disposeAllChildren(_hBox);
         if(!_selfArmy)
         {
            return;
         }
         createPassiveBuff();
         _hBox.beginChanges();
         for each(var _loc1_:MapBuffHurtData in _selfArmy.activeBuffList)
         {
            addBuff(_loc1_);
         }
         _hBox.commitChanges();
      }
      
      private function startRemoveMovie(param1:int) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:MovieClip = _dic[param1];
         if(_loc2_)
         {
            _loc3_ = _loc2_["iconMask"] as MovieClip;
            _loc2_.addChild(_loc3_);
            TweenMax.to(_loc3_,0.8,{
               "frame":_loc3_.totalFrames,
               "onComplete":__maskComplete,
               "onCompleteParams":[_loc2_]
            });
            delete _dic[param1];
            delete _iconDic[param1];
         }
      }
      
      private function __maskComplete(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = param1["iconMask"] as MovieClip;
         if(_loc2_)
         {
            TweenMax.killTweensOf(_loc2_);
            _loc2_.stop();
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         TweenMax.to(param1,0.2,{
            "frame":param1.totalFrames,
            "onComplete":__mcComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function __mcComplete(param1:MovieClip) : void
      {
         TweenMax.killTweensOf(param1);
         ObjectUtils.disposeObject(param1);
      }
      
      private function uintView() : void
      {
         clear();
         _dic = null;
         _hBox = null;
         _dic = null;
         _iconDic = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

