package yishi.datas.templates
{
   public class PlaneCrisisTempInfo
   {
      
      public var MapId:int;
      
      public var NodeId:int;
      
      public var X:int;
      
      public var Y:int;
      
      public var NodeType:int;
      
      public var LineNode:String;
      
      private var _lineList:Array;
      
      public function PlaneCrisisTempInfo()
      {
         super();
      }
      
      public function isConnect(param1:int) : Boolean
      {
         if(_lineList == null)
         {
            _lineList = LineNode.split(",");
         }
         var _loc2_:String = param1 + "";
         var _loc3_:int = _lineList.indexOf(_loc2_);
         if(_loc3_ >= 0)
         {
            return true;
         }
         return false;
      }
   }
}

