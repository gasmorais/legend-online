package mvc.module.braveleg
{
   public class BraveLegTeamInfo
   {
      
      public var currentTurn:int;
      
      public var maxTurnCount:int;
      
      public var leftTime:uint;
      
      public var isMaster:Boolean;
      
      public var inspireCount:int;
      
      public var maxInspireCount:int;
      
      public var teammate:Vector.<BraveLegPlayerInfo>;
      
      public var inspire:BraveLegInspireInfo;
      
      public function BraveLegTeamInfo()
      {
         super();
         teammate = new Vector.<BraveLegPlayerInfo>();
         inspire = new BraveLegInspireInfo();
      }
      
      public function destroy() : void
      {
         if(teammate)
         {
            teammate.length = 0;
            teammate = null;
         }
      }
   }
}

