package mvc.module.airgarden.game
{
   import com.road.yishi.proto.minigame.MemoryCard;
   
   public class MemoryCardData
   {
      
      public var index:int;
      
      public var type:int;
      
      public function MemoryCardData(param1:MemoryCard)
      {
         super();
         index = param1.index;
         type = param1.type;
      }
   }
}

