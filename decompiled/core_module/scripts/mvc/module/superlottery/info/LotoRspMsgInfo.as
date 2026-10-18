package mvc.module.superlottery.info
{
   public class LotoRspMsgInfo
   {
      
      public var op:int;
      
      public var phase:int;
      
      public var self_bet:LotoInfoMsgInfo;
      
      public var last_bet:LotoInfoMsgInfo;
      
      public var last_opened:LotoInfoMsgInfo;
      
      public function LotoRspMsgInfo()
      {
         super();
      }
   }
}

