package mvc.module.poker
{
   public class PokerBoardInfo
   {
      
      public var bet:int;
      
      public var minBet:int;
      
      public var raises:int;
      
      public var potArr:Array = [];
      
      public var totalPot:int;
      
      public var cardArr:Array = [];
      
      public function PokerBoardInfo()
      {
         super();
      }
      
      public function set card_arr(param1:Array) : void
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
      
      public function set pot_arr(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         potArr = [];
         totalPot = 0;
         var _loc6_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            totalPot += param1[_loc3_].bet * param1[_loc3_].contributor.length;
            _loc4_ = int(param1[_loc3_].contributor.length);
            if(_loc6_.indexOf(_loc3_) == -1)
            {
               _loc6_.push(_loc3_);
               _loc2_ = param1[_loc3_].bet * param1[_loc3_].contributor.length;
               _loc5_ = 0;
               while(_loc5_ < param1.length)
               {
                  if(_loc6_.indexOf(_loc5_) == -1)
                  {
                     if(_loc4_ == param1[_loc5_].contributor.length)
                     {
                        _loc6_.push(_loc5_);
                        _loc2_ += param1[_loc5_].bet * param1[_loc5_].contributor.length;
                     }
                  }
                  _loc5_++;
               }
               potArr.push(_loc2_);
            }
            _loc3_++;
         }
      }
   }
}

