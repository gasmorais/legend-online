package mvc.module.stargazing
{
   import yishi.utils.StringHelper;
   
   public class StarChartInfo
   {
      
      public var mapIndex:int;
      
      public var repeatTimes:int;
      
      public var fragmentChar:String;
      
      public var chartProerty:StarGazingPropertyInfo;
      
      public function StarChartInfo()
      {
         super();
         chartProerty = new StarGazingPropertyInfo();
      }
      
      public function get openNine() : Boolean
      {
         if(StringHelper.isNullOrEmpty(fragmentChar))
         {
            return false;
         }
         return fragmentChar.split(",").length >= 9;
      }
   }
}

