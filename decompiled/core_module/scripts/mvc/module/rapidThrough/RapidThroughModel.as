package mvc.module.rapidThrough
{
   import events.RapidInfoEvent;
   import flash.events.EventDispatcher;
   
   public class RapidThroughModel extends EventDispatcher
   {
      
      public var pass:int = 0;
      
      public var passTime:Number = 0;
      
      public var activityTime:Number = 0;
      
      public var passInfos:Array = [];
      
      public var isStart:Boolean = false;
      
      public var beginDate:String;
      
      private var _rankList:RapidThroughRankInfo;
      
      public var currentPage:int = 1;
      
      public var totalPage:int = 1;
      
      public function RapidThroughModel()
      {
         super();
         _rankList = new RapidThroughRankInfo();
      }
      
      public function updateRankList() : void
      {
         dispatchEvent(new RapidInfoEvent("rapid_rank_update"));
      }
      
      public function get rankList() : RapidThroughRankInfo
      {
         return _rankList;
      }
   }
}

