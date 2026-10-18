package mvc.module.gloryGame
{
   import yishi.utils.HashMap;
   
   public class GloryGameModel
   {
      
      public var isSelfSigned:Boolean = false;
      
      public var teamPlayers:Array;
      
      public var currentRound:int;
      
      public var currentState:int;
      
      public var currentTurn:int;
      
      public var myBetInfos:HashMap;
      
      public var scheduleInfos:Array;
      
      public var teamNameMap:HashMap;
      
      public var isJumpToBet:Boolean;
      
      public var isJumpToSchedule:Boolean;
      
      public var myScore:int;
      
      public var myGroup:int;
      
      public var myWin:int;
      
      public var extraTimeParam:Boolean;
      
      public var isOpen:Boolean = true;
      
      public function GloryGameModel()
      {
         super();
      }
      
      public function get myTurn() : int
      {
         var _loc1_:int = currentTurn - (myGroup - 1) * 3;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
   }
}

