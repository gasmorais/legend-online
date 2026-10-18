package com.road.mapengine.ai.astar
{
   import flash.geom.Point;
   import map.internals.data.MapInfo;
   import map.internals.findPath.AcorrsLineGrid;
   import map.internals.findPath.FindPath8;
   
   public class AIManager
   {
      
      private static var _instance:AIManager;
      
      private var _finPath:FindPath8;
      
      private var _algUtils:AcorrsLineGrid;
      
      private var _neterFrameCount:int;
      
      public function AIManager()
      {
         super();
      }
      
      public static function get instance() : AIManager
      {
         if(!_instance)
         {
            _instance = new AIManager();
         }
         return _instance;
      }
      
      public function set data(param1:MapInfo) : void
      {
         var _loc2_:int = param1.mapTempInfo.Width / 20;
         var _loc3_:int = param1.mapTempInfo.Height / 20;
         _finPath = new FindPath8(_loc2_,_loc3_,param1.mapTielsData,true);
         _algUtils = new AcorrsLineGrid(_finPath,param1);
      }
      
      public function find(param1:Point, param2:Point) : Array
      {
         var _loc3_:Array = _finPath.find(param1,param2);
         return _algUtils.getPsnode2(_loc3_);
      }
      
      public function enterFrame() : void
      {
         _neterFrameCount = _neterFrameCount + 1;
         if(_neterFrameCount % 20 == 0)
         {
            lockNpc();
            sendNpcsPoint();
         }
      }
      
      private function sendNpcsPoint() : void
      {
      }
      
      private function lockNpc() : void
      {
      }
   }
}

