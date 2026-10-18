package yishi.datas.templates
{
   public class MinosNodeTempInfo
   {
      
      public var Id:int;
      
      public var NodeId:int;
      
      public var ForLevel:int;
      
      public var NodeType:int;
      
      public var NodeName:String;
      
      public var NodeValueMax:int;
      
      public var NodeGrade:int;
      
      public var GardenValue:int;
      
      public var Heroes:String;
      
      public var Pawns:String;
      
      public var RewardItem1:int;
      
      public var RewardNum1:int;
      
      public var RewardItem2:int;
      
      public var RewardNum2:int;
      
      public var RewardItem3:int;
      
      public var RewardNum3:int;
      
      public function MinosNodeTempInfo()
      {
         super();
      }
      
      public function get size() : int
      {
         var _loc1_:int = 1;
         switch(NodeType - 3)
         {
            case 0:
            case 1:
            case 2:
               _loc1_ = 4;
         }
         return _loc1_;
      }
   }
}

