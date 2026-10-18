package map.internals.data
{
   import flash.geom.Point;
   import map.space.SpaceModel;
   
   public class SpaceNode extends NodeMapPhysics
   {
      
      public var sonType:int;
      
      public var nodeId:int;
      
      public var tempData:Object;
      
      public var npcId:int;
      
      public var curPosX:int;
      
      public var curPosY:int;
      
      public var resetPosX:int;
      
      public var resetPosY:int;
      
      public var fixX:int;
      
      public var fixY:int;
      
      public var moveToMapId:int;
      
      public var moveToNodeId:int;
      
      public var patrolPos:String;
      
      public var nameColor:int;
      
      public var sizeType:int;
      
      public var toward:int;
      
      public var resource:int;
      
      public var handlerRange:int;
      
      public var dialogue:String;
      
      public var param1:int;
      
      public var param2:int;
      
      public var param3:String;
      
      public var param4:String;
      
      public var param5:String;
      
      public var ItemExchange:String;
      
      public var sort:int;
      
      public var funcType:String;
      
      public var uid:String;
      
      public var layer:int;
      
      public var stateId:int = 0;
      
      private var _handlerRangePoints:Array;
      
      public function SpaceNode()
      {
         super();
      }
      
      public function get handlerRangePoints() : Array
      {
         return _handlerRangePoints;
      }
      
      public function initHandlerRangePoints(param1:SpaceModel) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Point = null;
         _handlerRangePoints = [];
         _loc2_ = 0;
         _loc3_ = handlerRange;
         while(_loc2_ <= handlerRange)
         {
            if(param1.getWalkable(curPosX + _loc2_,curPosY + _loc3_))
            {
               _loc4_ = new Point(curPosX + _loc2_,curPosY + _loc3_);
               _handlerRangePoints.push(_loc4_);
            }
            if(param1.getWalkable(curPosX + _loc2_,curPosY - _loc3_))
            {
               _loc4_ = new Point(curPosX + _loc2_,curPosY - _loc3_);
               _handlerRangePoints.push(_loc4_);
            }
            if(param1.getWalkable(curPosX + _loc3_,curPosY + _loc2_))
            {
               _loc4_ = new Point(curPosX + _loc3_,curPosY + _loc2_);
               _handlerRangePoints.push(_loc4_);
            }
            if(param1.getWalkable(curPosX - _loc3_,curPosY + _loc2_))
            {
               _loc4_ = new Point(curPosX - _loc3_,curPosY + _loc2_);
               _handlerRangePoints.push(_loc4_);
            }
            _loc2_++;
            _loc3_--;
         }
      }
   }
}

