package yishi.utils
{
   import com.road.yishi.proto.leed.LeedData;
   import mvc.module.dayGuide.LeedInfo;
   
   public class DayGuideHelper
   {
      
      public function DayGuideHelper()
      {
         super();
      }
      
      public static function readLeedInfo(param1:LeedData) : LeedInfo
      {
         var _loc2_:LeedInfo = new LeedInfo();
         _loc2_.templateId = param1.templateId;
         _loc2_.userId = param1.userId;
         _loc2_.currentCount = param1.currentCount;
         _loc2_.beginDate = DateFormatter.parse(param1.beginDate,"YYYY-MM-DD hh:mm:ss");
         _loc2_.isComplete = param1.isComplete;
         return _loc2_;
      }
   }
}

