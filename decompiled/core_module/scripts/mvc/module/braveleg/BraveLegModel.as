package mvc.module.braveleg
{
   import flash.events.EventDispatcher;
   
   public class BraveLegModel extends EventDispatcher
   {
      
      public var isSign:Boolean;
      
      public var isOpen:Boolean;
      
      public var isOver:Boolean;
      
      public var teamInfo:BraveLegTeamInfo;
      
      public var rankInfo:BraveLegRankInfo;
      
      public var inviteList:Vector.<BraveLegPlayerInfo>;
      
      public var teamList:Vector.<BraveLegPlayerInfo>;
      
      public function BraveLegModel()
      {
         super();
         rankInfo = new BraveLegRankInfo();
         teamList = new Vector.<BraveLegPlayerInfo>();
         inviteList = new Vector.<BraveLegPlayerInfo>();
      }
   }
}

