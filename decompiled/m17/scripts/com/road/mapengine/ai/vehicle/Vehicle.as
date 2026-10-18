package com.road.mapengine.ai.vehicle
{
   import com.road.mapengine.bitmap.logic.BitmapAvatarLogic;
   import flash.display.Stage;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class Vehicle extends EventDispatcher
   {
      
      public static const WRAP:String = "wrap";
      
      public static const BOUNCE:String = "bounce";
      
      protected var _edgeBehavior:String = "wrap";
      
      protected var _mass:Number = 1;
      
      protected var _maxSpeed:Number = 10;
      
      protected var _position:Vector2D = new Vector2D();
      
      protected var _velocity:Vector2D = new Vector2D();
      
      private var _view:BitmapAvatarLogic;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _rotation:Number;
      
      public var stage:Stage;
      
      public function Vehicle(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get view() : BitmapAvatarLogic
      {
         return _view;
      }
      
      public function set view(param1:BitmapAvatarLogic) : void
      {
         _view = param1;
         if(_view)
         {
            _view.x = x;
            _view.y = y;
            _view.angle = rotation;
         }
      }
      
      public function update() : void
      {
         _velocity.truncate(_maxSpeed);
         _position = _position.add(_velocity);
         if(_edgeBehavior == "wrap")
         {
            wrap();
         }
         else if(_edgeBehavior == "bounce")
         {
            bounce();
         }
         x = position.x;
         y = position.y;
         rotation = _velocity.angle * 180 / 3.141592653589793;
      }
      
      private function wrap() : void
      {
         if(stage != null)
         {
            if(position.x > stage.stageWidth)
            {
               position.x = 0;
            }
            if(position.x < 0)
            {
               position.x = stage.stageWidth;
            }
            if(position.y > stage.stageHeight)
            {
               position.y = 0;
            }
            if(position.y < 0)
            {
               position.y = stage.stageHeight;
            }
         }
      }
      
      private function bounce() : void
      {
         if(stage != null)
         {
            if(position.x > stage.stageWidth)
            {
               position.x = stage.stageWidth;
               velocity.x *= -1;
            }
            else if(position.x < 0)
            {
               position.x = 0;
               velocity.x *= -1;
            }
            if(position.y > stage.stageHeight)
            {
               position.y = stage.stageHeight;
               velocity.y *= -1;
            }
            else if(position.y < 0)
            {
               position.y = 0;
               velocity.y *= -1;
            }
         }
      }
      
      public function set x(param1:Number) : void
      {
         _x = param1;
         _position.x = param1;
         if(_view)
         {
            _view.x = param1;
         }
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
         _position.y = param1;
         if(_view)
         {
            _view.y = param1;
         }
      }
      
      public function get rotation() : Number
      {
         return _rotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         _rotation = param1;
         if(_view)
         {
            _view.angle = param1;
         }
      }
      
      public function get position() : Vector2D
      {
         return _position;
      }
      
      public function set position(param1:Vector2D) : void
      {
         _position = param1;
         x = _position.x;
         y = _position.y;
      }
      
      public function get velocity() : Vector2D
      {
         return _velocity;
      }
      
      public function set velocity(param1:Vector2D) : void
      {
         _velocity = param1;
      }
      
      public function get maxSpeed() : Number
      {
         return _maxSpeed;
      }
      
      public function set maxSpeed(param1:Number) : void
      {
         _maxSpeed = param1;
      }
      
      public function get mass() : Number
      {
         return _mass;
      }
      
      public function set mass(param1:Number) : void
      {
         _mass = param1;
      }
      
      public function get edgeBehavior() : String
      {
         return _edgeBehavior;
      }
      
      public function set edgeBehavior(param1:String) : void
      {
         _edgeBehavior = param1;
      }
   }
}

