package com.map.vehicle.mediator
{
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.MapInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   
   public class MapCameraMediator extends Sprite implements IMediator, IEnterFrame
   {
      
      private var _role:*;
      
      private var _target:Object;
      
      private var _isLocked:Boolean;
      
      private var _updatePoint:Point = new Point();
      
      private var _xLimen:int = 20;
      
      private var _yLimen:int = 20;
      
      private var _yLimenOff:int = 0;
      
      private var _bevelSpeed:int;
      
      private var _tweenValue:Number = 0.2;
      
      private var _unLockTime:int;
      
      private var _mapWidth:int;
      
      private var _mapHeight:int;
      
      public function MapCameraMediator()
      {
         super();
         setMapSize();
      }
      
      private function setMapSize() : void
      {
         var _loc1_:MapInfo = VehicleSocketManager.instance.model;
         var _loc2_:int = int(_loc1_ ? _loc1_.mapTempInfo.Width : 100000);
         var _loc3_:int = int(_loc1_ ? _loc1_.mapTempInfo.Height : 100000);
         _mapWidth = _xLimen + bevelSpeed + _loc2_;
         _mapHeight = _yLimen + bevelSpeed + _loc3_;
      }
      
      private function get bevelSpeed() : int
      {
         return 7;
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         EnterFrameManager.instance.registeEnterFrame(this);
         param1.addEventListener("render",__onScreenRend);
         param1.addEventListener("LOOK_AT_ROLE",__lookAtRoleHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _target.removeEventListener("render",__onScreenRend);
         _target.removeEventListener("LOOK_AT_ROLE",__lookAtRoleHandler);
      }
      
      protected function upDateNextRend() : void
      {
         if(_target.stage)
         {
            _target.stage.invalidate();
         }
      }
      
      protected function __onScreenRend(param1:Event) : void
      {
      }
      
      public function locked() : void
      {
         _isLocked = true;
      }
      
      public function unLocked() : void
      {
         _isLocked = false;
      }
      
      private function moveTweenEnd() : void
      {
         unLocked();
         if(_unLockTime > 0)
         {
            clearInterval(_unLockTime);
         }
         _unLockTime = 0;
         _target.dispatchEvent(new CampaignMapEvent("MOVE_SCENET_END",_target));
      }
      
      private function __lookAtRoleHandler(param1:CampaignMapEvent) : void
      {
         setMapSize();
         _role = param1.data;
         var _loc2_:int = int(StageReferance.stageWidth);
         var _loc3_:int = int(StageReferance.stageHeight);
         _target.x = _loc2_ / 2 - _role.x;
         _target.y = _loc3_ / 2 - _role.y;
      }
      
      public function enterFrame() : void
      {
         moveXY();
      }
      
      public function moveXY(param1:Boolean = false) : void
      {
         var _loc12_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         if(_isLocked || !_role)
         {
            return;
         }
         var _loc2_:int = int(StageReferance.stageWidth);
         var _loc14_:int = int(StageReferance.stageHeight);
         var _loc8_:int = _role.x - (_loc2_ >> 1);
         var _loc7_:int = _role.y - (_loc14_ >> 1) - _yLimenOff;
         var _loc15_:int = int(_target.x);
         var _loc16_:int = int(_target.y);
         var _loc4_:int = _loc2_ >> 1;
         var _loc3_:int = _loc14_ >> 1;
         var _loc9_:int = _role.x + _target.x;
         var _loc5_:int = _role.y + _target.y;
         var _loc10_:int = _loc9_ - _loc4_;
         var _loc13_:int = _loc5_ - _loc3_;
         var _loc11_:VehicleModel = VGlobal.model;
         var _loc6_:int = int(_loc11_.mapTempInfo.Width);
         var _loc19_:int = int(_loc11_.mapTempInfo.Height);
         if(Math.abs(_loc10_) >= _xLimen || Math.abs(_loc13_) >= _yLimen)
         {
            _loc12_ = 40;
            _loc17_ = _loc15_;
            _loc18_ = _loc16_;
            if(_loc10_ > _loc12_)
            {
               if(_loc2_ - _target.x >= _loc6_)
               {
                  _target.x = _loc2_ - _loc6_;
               }
               else
               {
                  _loc17_ -= (_loc10_ - _loc12_) * _tweenValue;
                  _target.x = _loc17_ + 0.5 >> 0;
               }
            }
            else if(_target.x >= 0)
            {
               _target.x = 0;
            }
            else if(_loc10_ < -_loc12_)
            {
               _loc17_ -= (_loc10_ + _loc12_) * _tweenValue;
               _target.x = _loc17_ + 0.5 >> 0;
            }
            if(_loc13_ > _loc12_)
            {
               if(_loc14_ - _target.y >= _loc19_)
               {
                  _target.y = _loc14_ - _loc19_;
               }
               else
               {
                  _loc18_ -= (_loc13_ - _loc12_) * _tweenValue;
                  _target.y = _loc18_ + 0.5 >> 0;
               }
            }
            else if(_target.y >= 0)
            {
               _target.y = 0;
            }
            else if(_loc13_ < -_loc12_)
            {
               _loc18_ -= (_loc13_ + _loc12_) * _tweenValue;
               _target.y = _loc18_ + 0.5 >> 0;
            }
         }
         if(_loc2_ - _target.x >= _loc6_)
         {
            _target.x = _loc2_ - _loc6_;
         }
         if(_target.x >= 0)
         {
            _target.x = 0;
         }
         if(_loc14_ - _target.y >= _loc19_)
         {
            _target.y = _loc14_ - _loc19_;
         }
         if(_target.y >= 0)
         {
            _target.y = 0;
         }
      }
      
      protected function get mapWidth() : int
      {
         return _mapWidth;
      }
      
      protected function get mapHeight() : int
      {
         return _mapHeight;
      }
   }
}

