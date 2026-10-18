package mvc.module.apex
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.player.CommonMsg;
   
   public class ApexBattleState
   {
      
      public var currentTurn:int;
      
      public var maxTurn:int;
      
      public var nextStartTime:Number;
      
      public function ApexBattleState(param1:CommonMsg)
      {
         super();
         currentTurn = param1.param1;
         maxTurn = param1.param2;
         nextStartTime = Int64Utils.int64ToNumber(param1.param6);
      }
   }
}

