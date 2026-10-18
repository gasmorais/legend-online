package mvc.module.rapidThrough
{
   public class RapidThroughRankInfo
   {
      
      public var updateTime:String;
      
      public var myOrder:int;
      
      public var pass:Vector.<RapidThroughRankItemInfo>;
      
      public function RapidThroughRankInfo()
      {
         super();
         pass = new Vector.<RapidThroughRankItemInfo>();
      }
   }
}

