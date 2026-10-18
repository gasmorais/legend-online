package com.road.mapengine.ai.astar
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import map.internals.utils.MapUtisl;
   
   public class BasePathWalkAi extends EventDispatcher
   {
      
      protected var _paths:Array;
      
      protected var _index:int = -1;
      
      protected var _curFrame:int;
      
      protected var _totalFrame:int;
      
      protected var _id:int = MapUtisl.instanceId;
      
      public function BasePathWalkAi(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function execute() : void
      {
         if(!_paths)
         {
            return;
         }
         if(_paths.length == 0)
         {
            walkOver();
            return;
         }
         if(_paths.length > _index)
         {
            if(_curFrame < _totalFrame)
            {
               nextFrame();
            }
            else
            {
               _index = _index + 1;
               if(_index < _paths.length)
               {
                  nextPoint(_paths[_index]);
               }
               else
               {
                  walkOver();
               }
            }
         }
         else
         {
            walkOver();
         }
      }
      
      protected function nextFrame() : void
      {
         _curFrame = _curFrame + 1;
      }
      
      protected function nextPoint(param1:Point) : void
      {
         _curFrame = 0;
      }
      
      protected function walkOver() : void
      {
         _index = -1;
         _curFrame = 0;
         _totalFrame = 0;
         _paths = null;
      }
      
      public function get paths() : Array
      {
         return _paths;
      }
      
      public function set paths(param1:Array) : void
      {
         _index = -1;
         _curFrame = 0;
         _totalFrame = 0;
         _paths = param1;
      }
   }
}

