package mvc.module.gvgcross
{
   public class GvgCrossGuildInfo
   {
      
      public var uid:String;
      
      public var guildId:int;
      
      public var consortiaName:String;
      
      public var totalScore:int;
      
      public var fightPower:int;
      
      public var site:String;
      
      public var crossServerId:int;
      
      public var warIndex:int;
      
      public var groupId:int;
      
      public var crossOrder:int;
      
      public var playerCount:int;
      
      public var winCount:int;
      
      public var result1:int;
      
      public var result2:int;
      
      public var result3:int;
      
      public var states:int;
      
      public var finalTeam:int;
      
      public var serverName:String;
      
      public function GvgCrossGuildInfo()
      {
         super();
      }
      
      public function get finalWinCount() : int
      {
         return result1 * 4 + result2 * 2 + result3;
      }
      
      public function get isFinalWinner() : Boolean
      {
         return result1 + result2 + result3 == 3;
      }
   }
}

