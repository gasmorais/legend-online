package mvc.module.chess
{
   public class SelfChessPlayerInfo
   {
      
      public var userId:int;
      
      public var serverName:String;
      
      public var name:String;
      
      public var hp:int;
      
      public var gold:int;
      
      public var grade:int;
      
      public var exp:int;
      
      public var winCount:int;
      
      public var lock:int;
      
      public var battleAry:Array = [];
      
      public var alternateAry:Array = [];
      
      public var cardPool:Array = [];
      
      public var rank:int;
      
      public var isSelf:Boolean;
      
      public function SelfChessPlayerInfo()
      {
         super();
      }
      
      public function get isFull() : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Boolean = true;
         var _loc1_:int = int(alternateAry.length);
         if(_loc1_ == 0)
         {
            _loc2_ = false;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = int(alternateAry[_loc4_]);
            if(_loc3_ == 0)
            {
               _loc2_ = false;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get isBattleFull() : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Boolean = true;
         var _loc1_:int = int(battleAry.length);
         if(_loc1_ == 0)
         {
            _loc2_ = false;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = int(battleAry[_loc4_]);
            if(_loc3_ == 0)
            {
               _loc2_ = false;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}

