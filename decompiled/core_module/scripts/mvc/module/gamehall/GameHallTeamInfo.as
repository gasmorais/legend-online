package mvc.module.gamehall
{
   public class GameHallTeamInfo
   {
      
      public var teamId:int;
      
      public var gameId:int;
      
      public var difficulty:int;
      
      public var teamState:int;
      
      public var captainId:int;
      
      public var isLock:Boolean;
      
      public var password:String;
      
      public var players:Vector.<GameHallUserInfo>;
      
      public var isMine:Boolean;
      
      public var autoType:int;
      
      public function GameHallTeamInfo()
      {
         super();
         players = new Vector.<GameHallUserInfo>();
      }
   }
}

