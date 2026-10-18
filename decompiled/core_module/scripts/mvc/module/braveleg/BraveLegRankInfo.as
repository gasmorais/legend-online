package mvc.module.braveleg
{
   public class BraveLegRankInfo
   {
      
      public var order:int;
      
      public var totalScore:int;
      
      public var teamType:int;
      
      public var lastUpdate:String;
      
      public var rankList:Vector.<BraveLegPlayerInfo>;
      
      public function BraveLegRankInfo()
      {
         super();
         rankList = new Vector.<BraveLegPlayerInfo>();
      }
      
      public function clear() : void
      {
         rankList.length = 0;
      }
   }
}

