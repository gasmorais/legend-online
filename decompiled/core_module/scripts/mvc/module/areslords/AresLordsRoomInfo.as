package mvc.module.areslords
{
   public class AresLordsRoomInfo
   {
      
      public var season:int;
      
      public var warIndex:int;
      
      public var currentTurn:int;
      
      public var maxTurnCount:int;
      
      public var totalScore:int;
      
      public var teamType:int;
      
      public var order:int;
      
      public var leftTime:int;
      
      public var rankList:Vector.<AresLordsPlayerInfo>;
      
      public var skillInfo:AresLordsSkillListInfo;
      
      public function AresLordsRoomInfo()
      {
         super();
         skillInfo = new AresLordsSkillListInfo();
      }
   }
}

