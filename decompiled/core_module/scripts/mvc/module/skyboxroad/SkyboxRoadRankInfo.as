package mvc.module.skyboxroad
{
   public class SkyboxRoadRankInfo
   {
      
      public var uuid:String;
      
      public var nickName:String;
      
      public var serverName:String;
      
      public var dayTime:int;
      
      public var weekTime:int;
      
      public var dayOrder:int;
      
      public var weekOrder:int;
      
      public var rankType:int;
      
      public function SkyboxRoadRankInfo()
      {
         super();
      }
      
      public function get showOrder() : int
      {
         if(rankType == 1)
         {
            return dayOrder;
         }
         if(rankType == 2)
         {
            return weekOrder;
         }
         return 0;
      }
      
      public function get showTime() : int
      {
         if(rankType == 1)
         {
            return dayTime;
         }
         if(rankType == 2)
         {
            return weekTime;
         }
         return 0;
      }
   }
}

