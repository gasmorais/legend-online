package map.campaign.data
{
   public class OutyardAttackInfo
   {
      
      public var fromPos:int;
      
      public var toPos:int;
      
      public var totalCount:int;
      
      public var changeCount:int;
      
      public function OutyardAttackInfo(param1:int, param2:int)
      {
         super();
         fromPos = param1;
         toPos = param2;
      }
      
      public function get key() : String
      {
         return fromPos + "_" + toPos;
      }
   }
}

