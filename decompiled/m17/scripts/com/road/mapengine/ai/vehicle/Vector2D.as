package com.road.mapengine.ai.vehicle
{
   public class Vector2D
   {
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function Vector2D(param1:Number = 0, param2:Number = 0)
      {
         super();
         _x = param1;
         _y = param2;
      }
      
      public static function angleBetween(param1:Vector2D, param2:Vector2D) : Number
      {
         if(!param1.isNormalized())
         {
            param1 = param1.clone().normalize();
         }
         if(!param2.isNormalized())
         {
            param2 = param2.clone().normalize();
         }
         return Math.acos(param1.dotProd(param2));
      }
      
      public function clone() : Vector2D
      {
         return new Vector2D(x,y);
      }
      
      public function zero() : Vector2D
      {
         _x = 0;
         _y = 0;
         return this;
      }
      
      public function isZero() : Boolean
      {
         return _x == 0 && _y == 0;
      }
      
      public function set length(param1:Number) : void
      {
         var _loc2_:Number = angle;
         _x = Math.cos(_loc2_) * param1;
         _y = Math.sin(_loc2_) * param1;
      }
      
      public function get length() : Number
      {
         return Math.sqrt(lengthSQ);
      }
      
      public function get lengthSQ() : Number
      {
         return _x * _x + _y * _y;
      }
      
      public function set angle(param1:Number) : void
      {
         var _loc2_:Number = length;
         _x = Math.cos(param1) * _loc2_;
         _y = Math.sin(param1) * _loc2_;
      }
      
      public function get angle() : Number
      {
         return Math.atan2(_y,_x);
      }
      
      public function normalize() : Vector2D
      {
         if(length == 0)
         {
            _x = 1;
            return this;
         }
         var _loc1_:Number = length;
         _x /= _loc1_;
         _y /= _loc1_;
         return this;
      }
      
      public function truncate(param1:Number) : Vector2D
      {
         length = Math.min(param1,length);
         return this;
      }
      
      public function reverse() : Vector2D
      {
         _x = -_x;
         _y = -_y;
         return this;
      }
      
      public function isNormalized() : Boolean
      {
         return length == 1;
      }
      
      public function dotProd(param1:Vector2D) : Number
      {
         return _x * param1.x + _y * param1.y;
      }
      
      public function crossProd(param1:Vector2D) : Number
      {
         return _x * param1.y - _y * param1.x;
      }
      
      public function sign(param1:Vector2D) : int
      {
         return perp.dotProd(param1) < 0 ? -1 : 1;
      }
      
      public function get perp() : Vector2D
      {
         return new Vector2D(-y,x);
      }
      
      public function dist(param1:Vector2D) : Number
      {
         return Math.sqrt(distSQ(param1));
      }
      
      public function distSQ(param1:Vector2D) : Number
      {
         var _loc2_:Number = param1.x - x;
         var _loc3_:Number = param1.y - y;
         return _loc2_ * _loc2_ + _loc3_ * _loc3_;
      }
      
      public function add(param1:Vector2D) : Vector2D
      {
         return new Vector2D(_x + param1.x,_y + param1.y);
      }
      
      public function subtract(param1:Vector2D) : Vector2D
      {
         return new Vector2D(_x - param1.x,_y - param1.y);
      }
      
      public function multiply(param1:Number) : Vector2D
      {
         return new Vector2D(_x * param1,_y * param1);
      }
      
      public function divide(param1:Number) : Vector2D
      {
         return new Vector2D(_x / param1,_y / param1);
      }
      
      public function equals(param1:Vector2D) : Boolean
      {
         return _x == param1.x && _y == param1.y;
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function toString() : String
      {
         return "[Vector2D (x:" + _x + ", y:" + _y + ")]";
      }
   }
}

