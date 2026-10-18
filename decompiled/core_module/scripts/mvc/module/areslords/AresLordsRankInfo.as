package mvc.module.areslords
{
   public class AresLordsRankInfo
   {
      
      public var order:int;
      
      public var totalScore:int;
      
      public var teamType:int;
      
      public var lastUpdate:String;
      
      public var rankList:Vector.<AresLordsPlayerInfo>;
      
      public function AresLordsRankInfo()
      {
         super();
         rankList = new Vector.<AresLordsPlayerInfo>();
      }
   }
}

