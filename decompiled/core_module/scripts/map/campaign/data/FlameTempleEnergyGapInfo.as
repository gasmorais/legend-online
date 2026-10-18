package map.campaign.data
{
   import flash.events.EventDispatcher;
   
   public class FlameTempleEnergyGapInfo extends EventDispatcher
   {
      
      public var nodeId:int = 0;
      
      public var bluePlayerCount:int = 0;
      
      public var redPlayerCount:int = 0;
      
      public var progress:int = 0;
      
      public var team:int = 0;
      
      public function FlameTempleEnergyGapInfo(param1:int = 0)
      {
         super();
         nodeId = param1;
      }
   }
}

