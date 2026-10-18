package mvc.module.poker
{
   public class PokerPlayerInfo
   {
      
      public var userId:int;
      
      public var userName:String;
      
      public var serverName:String;
      
      public var cash:int;
      
      public var bet:int;
      
      public var action:int;
      
      public var headId:int;
      
      public var hasCard:Boolean;
      
      public var handType:int;
      
      public var handValue:int;
      
      public var rankings:Array;
      
      public var cardArr:Array = [];
      
      public function PokerPlayerInfo()
      {
         super();
      }
      
      public function set player_card(param1:Array) : void
      {
         var _loc2_:int = 0;
         cardArr = [];
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            cardArr.push(param1[_loc2_]);
            _loc2_++;
         }
      }
   }
}

