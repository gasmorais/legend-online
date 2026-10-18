package com.map.vehicle.view
{
   import com.greensock.TweenMax;
   import com.map.vehicle.SkillEffectFactory;
   import com.map.vehicle.data.VehicleBufferDamageInfo;
   import com.map.vehicle.data.VehicleSkillEffectType;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.utils.VehicleUtil;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.view.tools.SimpleMovie;
   
   public class EffectsLayer extends Component
   {
      
      public var posA:int = -160;
      
      private var _data:EventDispatcher;
      
      private var _buffA:MovieClip;
      
      private var _buffB:MovieClip;
      
      private var _tweenA:TweenMax;
      
      private var _tweenB:TweenMax;
      
      private var _tankBody:DisplayObject;
      
      private var _buffBIds:int;
      
      private var _colorDatas:Object = {
         "normal":{
            "rm":1,
            "gm":1,
            "bm":1,
            "am":1,
            "ro":0,
            "go":0,
            "bo":0,
            "ao":0
         },
         "slow":{
            "rm":1,
            "gm":1,
            "bm":1,
            "am":1,
            "ro":0,
            "go":42,
            "bo":57,
            "ao":0
         },
         "poisoning":{
            "rm":1,
            "gm":1,
            "bm":1,
            "am":1,
            "ro":0,
            "go":51,
            "bo":0,
            "ao":0
         }
      };
      
      public function EffectsLayer()
      {
         super();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      public function get data() : EventDispatcher
      {
         return _data;
      }
      
      public function set data(param1:EventDispatcher) : void
      {
         removeEvent();
         _data = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         drawBuffEffect();
         var _loc1_:Dictionary = _data["buffList"];
         if(_loc1_)
         {
            for each(var _loc2_:VehicleBufferDamageInfo in _loc1_)
            {
               addBuff(_loc2_);
            }
         }
      }
      
      private function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("ADD_BUFF",__addBuffHandler);
            _data.addEventListener("REMOVE_BUFF",__removeBuffHandler);
            _data.addEventListener("CLEAR_BUFF",__clearBuffHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("ADD_BUFF",__addBuffHandler);
            _data.removeEventListener("REMOVE_BUFF",__removeBuffHandler);
            _data.removeEventListener("CLEAR_BUFF",__clearBuffHandler);
         }
      }
      
      private function __addBuffHandler(param1:VehicleEvent) : void
      {
         var _loc2_:VehicleBufferDamageInfo = param1.data as VehicleBufferDamageInfo;
         addBuff(_loc2_);
      }
      
      private function addBuff(param1:VehicleBufferDamageInfo) : void
      {
         var _loc3_:* = null;
         var _loc5_:MovieClip = null;
         var _loc2_:int = param1.buffId;
         var _loc4_:VehicleSkillBuffTemplate = VehicleUtil.getBuffTemplate(_loc2_);
         drawBuffEffect(_loc4_);
         if(_loc4_ && _loc4_.LastEffect)
         {
            if(_loc4_.Duration <= 0)
            {
               _loc5_ = SkillEffectFactory.instance.createBuffEffect(_loc2_);
               if(_loc5_)
               {
                  addChild(new SimpleMovie(_loc5_));
               }
            }
            else if(StringUtils.endsWith(_loc4_.LastEffect,"_a"))
            {
               clearTweenA();
               clearBuff(_buffA);
               _buffA = SkillEffectFactory.instance.createBuffEffect(_loc2_);
               if(_buffA)
               {
                  addChild(_buffA);
                  setEffectY(_buffA);
                  _tweenA = TweenMax.delayedCall(param1.leftTime,clearBuff,[_buffA]);
               }
            }
            else if(StringUtils.endsWith(_loc4_.LastEffect,"_b"))
            {
               clearTweenB();
               clearBuff(_buffB);
               _buffB = SkillEffectFactory.instance.createBuffEffect(_loc2_);
               if(_buffB)
               {
                  _buffBIds = param1.id;
                  addChild(_buffB);
                  _tweenB = TweenMax.delayedCall(param1.leftTime,clearBuff,[_buffB]);
               }
            }
         }
      }
      
      private function drawBuffEffect(param1:VehicleSkillBuffTemplate = null) : void
      {
         if(!tankBody)
         {
            return;
         }
         var _loc2_:ColorTransform = new ColorTransform();
         if(!param1)
         {
            checkColor(_loc2_,"normal");
         }
         else if(param1.EffectType == VehicleSkillEffectType.SPEED_CHANGE && (param1.EffectPercent < 0 || param1.EffectValue < 0))
         {
            checkColor(_loc2_,"slow");
         }
         else if(param1.EffectType == VehicleSkillEffectType.HP_CHANGE && param1.Duration > 0)
         {
            checkColor(_loc2_,"poisoning");
         }
         tankBody.transform.colorTransform = _loc2_;
      }
      
      private function checkColor(param1:ColorTransform, param2:String) : void
      {
         param1.redMultiplier = _colorDatas[param2].rm;
         param1.greenMultiplier = _colorDatas[param2].gm;
         param1.blueMultiplier = _colorDatas[param2].bm;
         param1.alphaMultiplier = _colorDatas[param2].am;
         param1.redOffset = _colorDatas[param2].ro;
         param1.greenOffset = _colorDatas[param2].go;
         param1.blueOffset = _colorDatas[param2].bo;
         param1.alphaOffset = _colorDatas[param2].ao;
      }
      
      private function clearTweenA() : void
      {
         if(_tweenA)
         {
            _tweenA.kill();
            _tweenA = null;
         }
      }
      
      private function clearTweenB() : void
      {
         if(_tweenB)
         {
            _tweenB.kill();
            _tweenB = null;
         }
      }
      
      private function clearBuff(param1:MovieClip) : void
      {
         if(param1)
         {
            param1.gotoAndStop(1);
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
               param1 = null;
            }
         }
         _buffBIds = 0;
      }
      
      private function __removeBuffHandler(param1:VehicleEvent) : void
      {
         var _loc2_:VehicleBufferDamageInfo = param1.data as VehicleBufferDamageInfo;
         if(_loc2_ && _loc2_.id == _buffBIds)
         {
            clearTweenB();
            clearBuff(_buffB);
            _buffB = null;
         }
         drawBuffEffect();
         var _loc3_:Dictionary = _data["buffList"];
         if(_loc3_)
         {
            for each(var _loc4_:VehicleBufferDamageInfo in _loc3_)
            {
               addBuff(_loc4_);
            }
         }
      }
      
      private function __clearBuffHandler(param1:VehicleEvent) : void
      {
         clearTweenA();
         clearTweenB();
         clearBuff(_buffA);
         clearBuff(_buffB);
         _buffA = null;
         _buffB = null;
         drawBuffEffect();
      }
      
      private function setEffectY(param1:MovieClip) : void
      {
         var _loc3_:int = posA;
         param1.gotoAndStop(1);
         var _loc4_:BitmapData = new BitmapData(int(param1.width / 2),int(param1.height / 2),true,0);
         _loc4_.draw(param1);
         var _loc2_:Rectangle = _loc4_.getColorBoundsRect(4294967295,0,false);
         _loc3_ = _loc3_ - _loc2_.height - 5;
         _loc4_.dispose();
         param1.play();
         param1.y = _loc3_;
      }
      
      override public function dispose() : void
      {
         clearTweenA();
         clearTweenB();
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         _data = null;
         _buffA = null;
         _buffB = null;
      }
      
      public function get tankBody() : DisplayObject
      {
         return _tankBody;
      }
      
      public function set tankBody(param1:DisplayObject) : void
      {
         _tankBody = param1;
         if(!_data)
         {
            return;
         }
         var _loc2_:Dictionary = _data["buffList"];
         if(_loc2_)
         {
            drawBuffEffect();
            for each(var _loc3_:VehicleBufferDamageInfo in _loc2_)
            {
               addBuff(_loc3_);
            }
         }
      }
   }
}

