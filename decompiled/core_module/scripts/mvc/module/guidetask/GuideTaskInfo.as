package mvc.module.guidetask
{
   import com.road.yishi.proto.leed.SingleDayMsg;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class GuideTaskInfo extends EventDispatcher
   {
      
      private var _startTime:Date;
      
      private var _statu:int;
      
      private var _singleDayArr:Array;
      
      public function GuideTaskInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get startTime() : Date
      {
         return _startTime;
      }
      
      public function set startTime(param1:Date) : void
      {
         _startTime = param1;
      }
      
      public function get statu() : int
      {
         return _statu;
      }
      
      public function set statu(param1:int) : void
      {
         _statu = param1;
      }
      
      public function get singleDayArr() : Array
      {
         return _singleDayArr;
      }
      
      public function set singleDayArr(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:SingleDayMsg = null;
         var _loc5_:SingleDayInfo = null;
         _singleDayArr = [];
         var _loc3_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1[_loc4_] as SingleDayMsg;
            _loc5_ = new SingleDayInfo();
            _loc5_.day = _loc2_.day;
            _loc5_.isGetReward = _loc2_.getReward;
            _loc5_.simpleTaskArr = _loc2_.simpleTask;
            _singleDayArr.push(_loc5_);
            _loc4_++;
         }
      }
   }
}

