package gamebox.vo
{
   public class GameBoxGameVO
   {
      
      public var gameId:int;
      
      private var _openDay:Array;
      
      public var rewards:Array;
      
      public function GameBoxGameVO()
      {
         super();
         _openDay = [];
      }
      
      public function get openDay() : Array
      {
         return _openDay;
      }
      
      public function setAndSort() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < openDay.length)
         {
            if(openDay[_loc1_] == 7)
            {
               openDay[_loc1_] = 0;
            }
            _loc1_++;
         }
         openDay.sort();
      }
   }
}

