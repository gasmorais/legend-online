package mvc.module.blackjack
{
   public class BlackjackBoardInfo
   {
      
      public var rewardId:int;
      
      public var bankerCard:Array;
      
      public var playerCard:Array;
      
      public var stoped:Boolean;
      
      public function BlackjackBoardInfo()
      {
         super();
      }
      
      public static function countPoints(param1:Array) : int
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = 0;
         for(; _loc4_ < param1.length; _loc4_++)
         {
            if(param1[_loc4_] < 0)
            {
               continue;
            }
            switch(_loc6_ = param1[_loc4_] % 13)
            {
               case 0:
                  _loc3_ += 2;
                  break;
               case 1:
                  _loc3_ += 3;
                  break;
               case 2:
                  _loc3_ += 4;
                  break;
               case 3:
                  _loc3_ += 5;
                  break;
               case 4:
                  _loc3_ += 6;
                  break;
               case 5:
                  _loc3_ += 7;
                  break;
               case 6:
                  _loc3_ += 8;
                  break;
               case 7:
                  _loc3_ += 9;
                  break;
               case 8:
                  _loc3_ += 10;
                  break;
               case 9:
                  _loc3_ += 10;
                  break;
               case 10:
                  _loc3_ += 10;
                  break;
               case 11:
                  _loc3_ += 10;
                  break;
               case 12:
                  _loc5_++;
            }
         }
         while(_loc5_ > 0)
         {
            _loc2_ = 0;
            if(_loc3_ <= 10)
            {
               _loc2_ = 11;
            }
            else
            {
               _loc2_ = 1;
            }
            _loc3_ += _loc2_;
            _loc5_--;
         }
         return _loc3_;
      }
      
      public function set banker_card(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            bankerCard.push(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function set player_card(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            playerCard.push(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function get bankerCardPoint() : int
      {
         return countCardPoint(bankerCard);
      }
      
      public function get playerCardPoint() : int
      {
         return countCardPoint(playerCard);
      }
      
      private function countCardPoint(param1:Array) : int
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = 0;
         for(; _loc4_ < param1.length; _loc4_++)
         {
            if(param1[_loc4_] < 0)
            {
               continue;
            }
            switch(_loc6_ = param1[_loc4_] % 13)
            {
               case 0:
                  _loc3_ += 2;
                  break;
               case 1:
                  _loc3_ += 3;
                  break;
               case 2:
                  _loc3_ += 4;
                  break;
               case 3:
                  _loc3_ += 5;
                  break;
               case 4:
                  _loc3_ += 6;
                  break;
               case 5:
                  _loc3_ += 7;
                  break;
               case 6:
                  _loc3_ += 8;
                  break;
               case 7:
                  _loc3_ += 9;
                  break;
               case 8:
                  _loc3_ += 10;
                  break;
               case 9:
                  _loc3_ += 10;
                  break;
               case 10:
                  _loc3_ += 10;
                  break;
               case 11:
                  _loc3_ += 10;
                  break;
               case 12:
                  _loc5_++;
            }
         }
         while(_loc5_ > 0)
         {
            _loc2_ = 0;
            if(_loc3_ <= 10)
            {
               _loc2_ = 11;
            }
            else
            {
               _loc2_ = 1;
            }
            _loc3_ += _loc2_;
            _loc5_--;
         }
         return _loc3_;
      }
   }
}

