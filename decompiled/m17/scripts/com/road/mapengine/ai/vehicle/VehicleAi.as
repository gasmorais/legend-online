package com.road.mapengine.ai.vehicle
{
   public class VehicleAi extends Vehicle
   {
      
      private var _maxForce:Number = 1;
      
      private var _steeringForce:Vector2D = new Vector2D();
      
      private var _arrivalThreshold:Number = 100;
      
      private var _wanderAngle:Number = 0;
      
      private var _wanderDistance:Number = 10;
      
      private var _wanderRadius:Number = 5;
      
      private var _wanderRange:Number = 1;
      
      private var _pathIndex:int = 0;
      
      private var _pathThreshold:Number = 20;
      
      private var _avoidDistance:Number = 300;
      
      private var _avoidBuffer:Number = 20;
      
      private var _inSightDist:Number = 200;
      
      private var _tooCloseDist:Number = 260;
      
      public function VehicleAi()
      {
         super();
      }
      
      public function set maxForce(param1:Number) : void
      {
         _maxForce = param1;
      }
      
      public function get maxForce() : Number
      {
         return _maxForce;
      }
      
      public function set arriveThreshold(param1:Number) : void
      {
         _arrivalThreshold = param1;
      }
      
      public function get arriveThreshold() : Number
      {
         return _arrivalThreshold;
      }
      
      public function set wanderDistance(param1:Number) : void
      {
         _wanderDistance = param1;
      }
      
      public function get wanderDistance() : Number
      {
         return _wanderDistance;
      }
      
      public function set wanderRadius(param1:Number) : void
      {
         _wanderRadius = param1;
      }
      
      public function get wanderRadius() : Number
      {
         return _wanderRadius;
      }
      
      public function set wanderRange(param1:Number) : void
      {
         _wanderRange = param1;
      }
      
      public function get wanderRange() : Number
      {
         return _wanderRange;
      }
      
      public function set pathIndex(param1:int) : void
      {
         _pathIndex = param1;
      }
      
      public function get pathIndex() : int
      {
         return _pathIndex;
      }
      
      public function set pathThreshold(param1:Number) : void
      {
         _pathThreshold = param1;
      }
      
      public function get pathThreshold() : Number
      {
         return _pathThreshold;
      }
      
      public function set avoidDistance(param1:Number) : void
      {
         _avoidDistance = param1;
      }
      
      public function get avoidDistance() : Number
      {
         return _avoidDistance;
      }
      
      public function set avoidBuffer(param1:Number) : void
      {
         _avoidBuffer = param1;
      }
      
      public function get avoidBuffer() : Number
      {
         return _avoidBuffer;
      }
      
      public function set inSightDist(param1:Number) : void
      {
         _inSightDist = param1;
      }
      
      public function get inSightDist() : Number
      {
         return _inSightDist;
      }
      
      public function set tooCloseDist(param1:Number) : void
      {
         _tooCloseDist = param1;
      }
      
      public function get tooCloseDist() : Number
      {
         return _tooCloseDist;
      }
      
      override public function update() : void
      {
         _steeringForce.truncate(_maxForce);
         _steeringForce = _steeringForce.divide(_mass);
         _velocity = _velocity.add(_steeringForce);
         _steeringForce = new Vector2D();
         super.update();
      }
      
      public function seek(param1:Vector2D) : void
      {
         var _loc3_:Vector2D = param1.subtract(_position);
         _loc3_.normalize();
         _loc3_ = _loc3_.multiply(_maxSpeed);
         var _loc2_:Vector2D = _loc3_.subtract(_velocity);
         _steeringForce = _steeringForce.add(_loc2_);
      }
      
      public function flee(param1:Vector2D) : void
      {
         var _loc3_:Vector2D = param1.subtract(_position);
         _loc3_.normalize();
         _loc3_ = _loc3_.multiply(_maxSpeed);
         var _loc2_:Vector2D = _loc3_.subtract(_velocity);
         _steeringForce = _steeringForce.subtract(_loc2_);
      }
      
      public function arrive(param1:Vector2D) : void
      {
         var _loc4_:Vector2D = param1.subtract(_position);
         _loc4_.normalize();
         var _loc2_:Number = _position.dist(param1);
         if(_loc2_ > _arrivalThreshold)
         {
            _loc4_ = _loc4_.multiply(_maxSpeed);
         }
         else
         {
            _loc4_ = _loc4_.multiply(_maxSpeed * _loc2_ / _arrivalThreshold);
         }
         var _loc3_:Vector2D = _loc4_.subtract(_velocity);
         _steeringForce = _steeringForce.add(_loc3_);
      }
      
      public function pursue(param1:Vehicle) : void
      {
         var _loc3_:Number = position.dist(param1.position) / _maxSpeed;
         var _loc2_:Vector2D = param1.position.add(param1.velocity.multiply(_loc3_));
         seek(_loc2_);
      }
      
      public function evade(param1:Vehicle) : void
      {
         var _loc3_:Number = position.dist(param1.position) / _maxSpeed;
         var _loc2_:Vector2D = param1.position.subtract(param1.velocity.multiply(_loc3_));
         flee(_loc2_);
      }
      
      public function wander() : void
      {
         var _loc2_:Vector2D = velocity.clone().normalize().multiply(_wanderDistance);
         var _loc1_:Vector2D = new Vector2D(0);
         _loc1_.length = _wanderRadius;
         _loc1_.angle = _wanderAngle;
         _wanderAngle += Math.random() * _wanderRange - _wanderRange * 0.5;
         var _loc3_:Vector2D = _loc2_.add(_loc1_);
         _steeringForce = _steeringForce.add(_loc3_);
      }
      
      public function followPath(param1:Array, param2:Boolean = false) : void
      {
         var _loc3_:Vector2D = param1[_pathIndex];
         if(_loc3_ == null)
         {
            return;
         }
         if(_position.dist(_loc3_) < _pathThreshold)
         {
            if(_pathIndex >= param1.length - 1)
            {
               if(param2)
               {
                  _pathIndex = 0;
               }
            }
            else
            {
               _pathIndex = _pathIndex + 1;
            }
         }
         if(_pathIndex >= param1.length - 1 && !param2)
         {
            arrive(_loc3_);
         }
         else
         {
            seek(_loc3_);
         }
      }
      
      public function flock(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc6_:Vehicle = null;
         var _loc3_:Vector2D = _velocity.clone();
         var _loc4_:Vector2D = new Vector2D();
         var _loc5_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc6_ = param1[_loc2_] as Vehicle;
            if(_loc6_ != this && inSight(_loc6_))
            {
               _loc3_ = _loc3_.add(_loc6_.velocity);
               _loc4_ = _loc4_.add(_loc6_.position);
               if(tooClose(_loc6_))
               {
                  flee(_loc6_.position);
               }
               _loc5_++;
            }
            _loc2_++;
         }
         if(_loc5_ > 0)
         {
            _loc3_ = _loc3_.divide(_loc5_);
            _loc4_ = _loc4_.divide(_loc5_);
            seek(_loc4_);
            _steeringForce.add(_loc3_.subtract(_velocity));
         }
      }
      
      public function inSight(param1:Vehicle) : Boolean
      {
         if(_position.dist(param1.position) > _inSightDist)
         {
            return false;
         }
         var _loc3_:Vector2D = _velocity.clone().normalize();
         var _loc4_:Vector2D = param1.position.subtract(_position);
         var _loc2_:Number = _loc4_.dotProd(_loc3_);
         if(_loc2_ < 0)
         {
            return false;
         }
         return true;
      }
      
      public function tooClose(param1:Vehicle) : Boolean
      {
         return _position.dist(param1.position) < _tooCloseDist;
      }
   }
}

