package mvc.module.consortia
{
   import yishi.utils.DateFormatter;
   
   public class TreasureGroupInfo
   {
      
      public var treasureId:int;
      
      public var payType:int;
      
      public var errorID:int;
      
      public var NoOpen:Boolean = false;
      
      public var leftCount:int;
      
      private var _freeTime:String;
      
      private var _nFreeTime:Number = 0;
      
      public var totalTime:Number;
      
      public var refreshTimes:int;
      
      public var treasureIndex:int;
      
      public var treasures:Array = [];
      
      public var myTreasures:Array = [];
      
      public var helpOpenId:int;
      
      public var helpLeftCount:int;
      
      public var helpList:Array = [];
      
      public var open_treasure:Array = [];
      
      public function TreasureGroupInfo()
      {
         super();
      }
      
      public function set freeTime(param1:String) : void
      {
         _freeTime = param1;
         _nFreeTime = DateFormatter.parse(param1,"YYYY-MM-DD hh:mm:ss").time;
      }
      
      public function get newFreeTime() : Number
      {
         return _nFreeTime;
      }
   }
}

