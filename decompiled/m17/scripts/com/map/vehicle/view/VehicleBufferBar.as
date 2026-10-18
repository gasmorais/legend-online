package com.map.vehicle.view
{
   import com.greensock.TweenMax;
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.VehicleBufferDamageInfo;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.map.vehicle.utils.VehicleUtil;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class VehicleBufferBar extends Component
   {
      
      private var _dic:Dictionary = new Dictionary(true);
      
      private var _iconDic:Dictionary = new Dictionary(true);
      
      private var _hBox:HBox;
      
      private var _model:VehicleModel = VehicleSocketManager.instance.model;
      
      private var _playerVehicleInfo:PlayerVehicleInfo;
      
      private var _timer:Timer;
      
      public function VehicleBufferBar()
      {
         super();
         initView();
         addEvent();
         this.mouseEnabled = false;
         _hBox.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _hBox = new HBox();
         _hBox.spacing = 1;
         addChild(_hBox);
      }
      
      private function addEvent() : void
      {
         if(_playerVehicleInfo)
         {
            _playerVehicleInfo.addEventListener("ADD_BUFF",__addBuffHandler);
            _playerVehicleInfo.addEventListener("REMOVE_BUFF",__removeBuffHandler);
            _playerVehicleInfo.addEventListener("CLEAR_BUFF",__clearBuffHandler);
         }
         if(!_timer)
         {
            _timer = new Timer(1000);
            _timer.start();
            _timer.addEventListener("timer",__onTimerHandler);
         }
      }
      
      private function __addBuffHandler(param1:VehicleEvent) : void
      {
         var _loc2_:VehicleBufferDamageInfo = param1.data as VehicleBufferDamageInfo;
         addBuff(_loc2_);
      }
      
      private function addBuff(param1:VehicleBufferDamageInfo) : void
      {
         var _loc3_:BaseIconView = null;
         var _loc5_:MovieClip = null;
         var _loc4_:VehicleSkillBuffTemplate = null;
         var _loc7_:MovieClip = null;
         var _loc2_:int = param1.buffId;
         var _loc6_:int = param1.id;
         if(_dic[_loc6_] && _iconDic[_loc6_])
         {
            _loc3_ = _iconDic[_loc6_] as BaseIconView;
            _loc3_.tipData = param1;
         }
         else
         {
            _loc4_ = VehicleUtil.getBuffTemplate(_loc2_);
            if(_loc4_ && _loc4_.Duration != 0)
            {
               _loc5_ = ComponentFactory.Instance.creat("asset.vehiclemap.CdIcon");
               _loc5_.gotoAndStop(1);
               _loc3_ = ComponentFactory.Instance.creatCustomObject("vehiclemap.buffIcon");
               _loc3_.icon = IconFactory.getCommonIconPath(_loc4_.Icon);
               _loc3_.tipData = param1;
               _loc5_.gotoAndStop(1);
               _loc5_["icon"].addChild(_loc3_);
               _loc7_ = _loc5_["iconMask"] as MovieClip;
               _loc7_.gotoAndStop(1);
               if(_loc7_.parent)
               {
                  _loc7_.parent.removeChild(_loc7_);
               }
               _dic[_loc6_] = _loc5_;
               _iconDic[_loc6_] = _loc3_;
               _hBox.addChild(_loc5_);
            }
         }
      }
      
      public function __clearBuffHandler(param1:VehicleEvent) : void
      {
         clear();
      }
      
      public function get playerVehicleInfo() : PlayerVehicleInfo
      {
         return _playerVehicleInfo;
      }
      
      public function set playerVehicleInfo(param1:PlayerVehicleInfo) : void
      {
         if(_playerVehicleInfo != param1)
         {
            removeEvent();
            _playerVehicleInfo = param1;
            initBuff();
            addEvent();
         }
      }
      
      private function __onTimerHandler(param1:TimerEvent) : void
      {
         var _loc3_:VehicleBufferDamageInfo = null;
         if(isDie)
         {
            return;
         }
         for each(var _loc2_:BaseIconView in _iconDic)
         {
            if(_loc2_.tipData && _loc2_.tipData is VehicleBufferDamageInfo)
            {
               _loc3_ = _loc2_.tipData as VehicleBufferDamageInfo;
               if(_loc3_.leftTime <= 1)
               {
                  startRemoveMovie(_loc3_.id);
               }
            }
         }
      }
      
      private function __removeBuffHandler(param1:VehicleEvent) : void
      {
         var _loc2_:VehicleBufferDamageInfo = param1.data as VehicleBufferDamageInfo;
         if(_dic[_loc2_.id])
         {
            startRemoveMovie(_loc2_.id);
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
      }
      
      private function createPassiveBuff() : BaseIconView
      {
         var _loc2_:BaseIconView = null;
         var _loc1_:VehicleSkillTempInfo = _model.skillBag.getSkillByPos(2).tempalte;
         if(_loc1_ && _loc1_.InjuryEffect == 3)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("vehiclemap.buffIcon");
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
         createPassiveBuff();
         var _loc1_:Dictionary = playerVehicleInfo.buffList;
         for each(var _loc2_:VehicleBufferDamageInfo in _loc1_)
         {
            addBuff(_loc2_);
         }
      }
      
      private function removeEvent() : void
      {
         if(_playerVehicleInfo)
         {
            _playerVehicleInfo.removeEventListener("ADD_BUFF",__addBuffHandler);
            _playerVehicleInfo.removeEventListener("REMOVE_BUFF",__removeBuffHandler);
            _playerVehicleInfo.removeEventListener("CLEAR_BUFF",__clearBuffHandler);
            _playerVehicleInfo = null;
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerHandler);
            _timer = null;
         }
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
         _model = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

