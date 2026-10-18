package mvc.module.stargazing
{
   public class StarPalaceInfo
   {
      
      public static const POINT_NUM:int = 9;
      
      public var index:int;
      
      public var totalLightStar:int;
      
      public var starChartInfoList:Array;
      
      public function StarPalaceInfo()
      {
         super();
         starChartInfoList = [];
      }
      
      public function get timeCount() : int
      {
         return int(totalLightStar / 9);
      }
      
      public function get addPrecent() : int
      {
         return timeCount * 20 + totalLightStar % 9 * 1;
      }
      
      public function get successRate() : int
      {
         return 100 - totalLightStar % 9 * 10;
      }
      
      public function getChartInfoByIndex(param1:int) : StarChartInfo
      {
         for each(var _loc2_:StarChartInfo in starChartInfoList)
         {
            if(_loc2_.mapIndex == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChartAddByIndex(param1:int) : StarGazingPropertyInfo
      {
         for each(var _loc2_:StarChartInfo in starChartInfoList)
         {
            if(_loc2_.mapIndex == param1)
            {
               return _loc2_.chartProerty;
            }
         }
         return null;
      }
      
      public function get chartAllOpen() : Boolean
      {
         if(starChartInfoList.length < 12)
         {
            return false;
         }
         for each(var _loc1_:StarChartInfo in starChartInfoList)
         {
            if(!_loc1_.openNine)
            {
               return false;
            }
         }
         return true;
      }
   }
}

