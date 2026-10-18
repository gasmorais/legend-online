package yishi.datas.ai
{
   import flash.geom.Point;
   import yishi.events.AiEvents;
   
   public class NpcAiInfo extends AIBaseInfo
   {
      
      private var _centerPoint:Point;
      
      private var _nextPoint:Point;
      
      private var _attackArmyId:int;
      
      private var _attackArmyServerName:String;
      
      public function NpcAiInfo()
      {
         super();
      }
      
      public function get attackArmyServerName() : String
      {
         return _attackArmyServerName;
      }
      
      public function set attackArmyServerName(param1:String) : void
      {
         _attackArmyServerName = param1;
      }
      
      public function get attackArmyId() : int
      {
         return _attackArmyId;
      }
      
      public function set attackArmyId(param1:int) : void
      {
         _attackArmyId = param1;
      }
      
      public function get nextPoint() : Point
      {
         return _nextPoint;
      }
      
      public function set nextPoint(param1:Point) : void
      {
         _nextPoint = param1;
         dispatchEvent(new AiEvents("updateNextPoint",param1));
      }
      
      public function get centerPoint() : Point
      {
         return _centerPoint;
      }
      
      public function set centerPoint(param1:Point) : void
      {
         _centerPoint = param1;
         dispatchEvent(new AiEvents("updateCenterPoint",param1));
      }
   }
}

