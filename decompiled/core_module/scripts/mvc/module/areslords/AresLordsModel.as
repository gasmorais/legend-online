package mvc.module.areslords
{
   import flash.events.EventDispatcher;
   
   public class AresLordsModel extends EventDispatcher
   {
      
      public var isSign:Boolean;
      
      public var isOpen:Boolean;
      
      public var season:int;
      
      public var warIndex:int;
      
      public var currentTurn:int;
      
      public var maxTurnCount:int;
      
      public var totalScore:int;
      
      public var teamType:int;
      
      public var order:int;
      
      public var isOver:Boolean;
      
      public var leftWarIndex:int;
      
      public var roomInfo:AresLordsRoomInfo = new AresLordsRoomInfo();
      
      public var rankInfo:AresLordsRankInfo = new AresLordsRankInfo();
      
      public function AresLordsModel()
      {
         super();
      }
   }
}

