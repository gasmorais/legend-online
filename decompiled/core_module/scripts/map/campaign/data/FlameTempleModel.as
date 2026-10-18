package map.campaign.data
{
   import flash.events.EventDispatcher;
   
   public class FlameTempleModel extends EventDispatcher
   {
      
      public static const REWARD_TEMPLATE_ID:int = 208031;
      
      public static const REWARD_TEMPLATE_ID2:int = 208014;
      
      public var teamAScore:int = 0;
      
      public var teamBScore:int = 0;
      
      public var teamAEnergyGap:int = 0;
      
      public var teamBEnergyGap:int = 0;
      
      public var startDate:Date;
      
      public var falmePlayers:Array;
      
      public function FlameTempleModel()
      {
         super();
      }
   }
}

