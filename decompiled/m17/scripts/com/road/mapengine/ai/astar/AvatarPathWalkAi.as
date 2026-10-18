package com.road.mapengine.ai.astar
{
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.map.vehicle.net.VehicleSocketOutManager;
   import com.map.vehicle.objects.TankAvatarView;
   import com.map.vehicle.objects.VehicleBoxView;
   import com.road.mapengine.bitmap.logic.BitmapAvatarLogic;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class AvatarPathWalkAi extends BasePathWalkAi
   {
      
      private var _avatar:BitmapAvatarLogic;
      
      private var _moveAngel:Number;
      
      private var _moveX:Number;
      
      private var _moveY:Number;
      
      private var _tempNextPoint:Point = new Point();
      
      private var _notePaths:Array = [];
      
      private var _walkStep:int = 0;
      
      public function AvatarPathWalkAi(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get moveAngel() : Number
      {
         var _loc1_:Number = _moveAngel / 3.141592653589793 * 180;
         return _loc1_ < 0 ? _loc1_ + 360 : _loc1_;
      }
      
      public function get avatar() : BitmapAvatarLogic
      {
         return _avatar;
      }
      
      public function set avatar(param1:BitmapAvatarLogic) : void
      {
         _avatar = param1;
      }
      
      override protected function nextFrame() : void
      {
         super.nextFrame();
         _avatar.x += _moveX;
         _avatar.y += _moveY;
      }
      
      override protected function nextPoint(param1:Point) : void
      {
         _tempNextPoint.x = param1.x * 20 + 10;
         _tempNextPoint.y = param1.y * 20 + 10;
         super.nextPoint(_tempNextPoint);
         var _loc3_:int = _tempNextPoint.x - _avatar.x;
         var _loc4_:int = _tempNextPoint.y - _avatar.y;
         _moveAngel = Math.atan2(_loc4_,_loc3_);
         _moveX = _avatar.speed * Math.cos(_moveAngel);
         _moveY = _avatar.speed * Math.sin(_moveAngel);
         _avatar.angle = moveAngel;
         var _loc2_:int = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
         _totalFrame = Math.ceil(_loc2_ / _avatar.speed);
         nextFrame();
         nodePaths(param1);
      }
      
      private function nodePaths(param1:Point) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         if((_avatar as TankAvatarView).data.playerId != PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            return;
         }
         if(_walkStep == 0)
         {
            _loc3_ = this._index + 3;
            if(_loc3_ > _paths.length)
            {
               _loc3_ = int(_paths.length);
            }
            _loc2_ = this.paths.slice(this._index,_loc3_);
            _loc4_ = (_avatar as TankAvatarView).data.playerId;
            VehicleSocketOutManager.instance.sendCampaignArmyMove(_loc4_,_loc2_);
         }
         _walkStep = _walkStep + 1;
         if(_walkStep >= 2)
         {
            _walkStep = 0;
         }
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         _avatar.state = 3;
         var _loc3_:int = (_avatar as TankAvatarView).data.playerId;
         if(_loc3_ != PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            return;
         }
         _walkStep = 0;
         this.dispatchEvent(new VehicleEvent("WALK_OVER",null));
         var _loc1_:Point = new Point(int(_avatar.x / 20),int(_avatar.y / 20));
         VehicleSocketOutManager.instance.sendCampaignArmyMove(_loc3_,[_loc1_]);
         NotificationManager.instance.dispatchEvent(new VehicleEvent("UPDATE_WALK_TARGET",null));
         if(!mapModel)
         {
            return;
         }
         var _loc2_:VehicleNode = mapModel.getHandlerNode(_avatar.x / 20,_avatar.y / 20);
         if(!_loc2_)
         {
            _loc2_ = goSelectPoint(_avatar);
         }
         if(!_loc2_)
         {
            return;
         }
         _loc1_ = getResetPoint(_loc2_,_avatar,new Point(int(_avatar.x / 20),int(_avatar.y / 20)));
         sendMessage(_loc1_,_loc2_);
      }
      
      private function goSelectPoint(param1:BitmapAvatarLogic) : VehicleNode
      {
         var _loc5_:VehicleNode = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc6_:int = 0;
         var _loc2_:BitmapSimpleLogic = VGlobal.logicWorld.selectedLogic;
         if(_loc2_)
         {
            if(_loc2_ is VehicleBoxView)
            {
               _loc5_ = (_loc2_ as VehicleBoxView).data;
               if(_loc5_)
               {
                  if(_loc5_.state != 1)
                  {
                     _loc3_ = new Point(param1.x,param1.y);
                     _loc4_ = new Point(_loc5_.logicView.x,_loc5_.logicView.y);
                     _loc6_ = Point.distance(_loc3_,_loc4_);
                     if(_loc6_ < (_loc5_.handlerRange + 1) * 20)
                     {
                        return _loc5_;
                     }
                  }
               }
            }
         }
         return null;
      }
      
      private function getResetPoint(param1:VehicleNode, param2:BitmapAvatarLogic, param3:Point) : Point
      {
         var _loc4_:Point = null;
         if(param1.resetPosX > 0 && param1.resetPosY > 0)
         {
            _loc4_ = new Point(param1.resetPosX,param1.resetPosY);
         }
         else
         {
            _loc4_ = new Point(int(param2.x / 20),int(param2.y / 20));
         }
         return _loc4_;
      }
      
      private function sendMessage(param1:Point, param2:VehicleNode) : void
      {
         var _loc3_:int = (_avatar as TankAvatarView).data.playerId;
         if(param2.type != 0)
         {
            (_avatar as TankAvatarView).data.pickup(param2);
         }
      }
      
      private function get mapModel() : VehicleModel
      {
         return VehicleSocketManager.instance.model;
      }
      
      override public function set paths(param1:Array) : void
      {
         super.paths = param1;
         if(paths && paths.length > 0)
         {
            _avatar.state = 4;
         }
         else
         {
            NotificationManager.instance.dispatchEvent(new VehicleEvent("UPDATE_WALK_TARGET",null));
            _avatar.state = 3;
         }
      }
   }
}

