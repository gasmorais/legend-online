package com.road.mapengine.bitmap
{
   import com.pickgliss.toplevel.StageReferance;
   import com.road.mapengine.ai.astar.AIManager;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class EngineManager implements IEnterFrame
   {
      
      private static var _instance:EngineManager;
      
      private var _map:BaseMapScene;
      
      private var _tick:int;
      
      public function EngineManager()
      {
         super();
      }
      
      public static function get instance() : EngineManager
      {
         if(!_instance)
         {
            _instance = new EngineManager();
         }
         return _instance;
      }
      
      public function setup(param1:BaseMapScene) : void
      {
         _map = param1;
         _tick = 1000 / StageReferance.stage.frameRate;
         addEvent();
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         run();
      }
      
      private function run() : void
      {
         if(_map)
         {
            AIManager.instance.enterFrame();
            _map.enterFrame();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _map = null;
      }
   }
}

