package mvc.module.newactiveleed
{
   import com.road.yishi.proto.activitydaily.ActivityDailyRspMsg;
   import yishi.utils.SimpleDictionary;
   
   public class NewActiveLeedModel
   {
      
      public var buffTime:String;
      
      public var dailyArr:SimpleDictionary;
      
      public var masterType:int;
      
      public var vipNum:int;
      
      public function NewActiveLeedModel()
      {
         super();
         dailyArr = new SimpleDictionary();
      }
      
      public function get dailyNum() : int
      {
         var _loc1_:ActivityDailyRspMsg = dailyArr[masterType];
         if(_loc1_)
         {
            return _loc1_.totalNum;
         }
         return 0;
      }
      
      public function get weekNum() : int
      {
         var _loc1_:ActivityDailyRspMsg = dailyArr[masterType];
         if(_loc1_)
         {
            return _loc1_.weekTotalNum;
         }
         return 0;
      }
      
      public function get dailyProcessArr() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:ActivityDailyRspMsg = dailyArr[masterType];
         if(_loc2_)
         {
            _loc1_ = _loc2_.activityDailyProcess.split("|");
         }
         return _loc1_;
      }
      
      public function get weekProcessArr() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:ActivityDailyRspMsg = dailyArr[masterType];
         if(_loc2_)
         {
            _loc1_ = _loc2_.weekActivityDailyProcess.split("|");
         }
         return _loc1_;
      }
   }
}

