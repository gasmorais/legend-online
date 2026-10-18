package mvc.module.airgarden.game
{
   import yishi.utils.HashMap;
   
   public class MemoryCardModel
   {
      
      public var op:int;
      
      public var curTurn:int;
      
      public var score:int;
      
      public var addScore:int;
      
      public var addScore2:int;
      
      public var cIndex1:int;
      
      public var cIndex2:int;
      
      public var result:Boolean;
      
      public var leftAutoChance:int;
      
      public var leftCheckChance:int;
      
      public var duration:int;
      
      public var cards:HashMap;
      
      public var openCards:Array = [];
      
      public var secondIndex:int;
      
      public var lock:Boolean = false;
      
      public var cardShow:HashMap;
      
      public function MemoryCardModel()
      {
         super();
      }
      
      public function clear() : void
      {
         lock = false;
         cardShow = null;
         secondIndex = 0;
         if(cards)
         {
            cards.clear();
            cards = null;
         }
      }
   }
}

