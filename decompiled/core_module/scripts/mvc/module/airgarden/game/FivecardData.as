package mvc.module.airgarden.game
{
   import com.road.yishi.proto.minigame.FiveCardPoker;
   
   public class FivecardData
   {
      
      public var index:int;
      
      public var color:int;
      
      public var number:int;
      
      public function FivecardData(param1:FiveCardPoker)
      {
         super();
         index = param1.index;
         color = param1.color;
         number = param1.number;
      }
   }
}

