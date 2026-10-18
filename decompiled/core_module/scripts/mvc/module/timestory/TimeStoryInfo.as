package mvc.module.timestory
{
   public class TimeStoryInfo
   {
      
      public static const ALERTS:int = 0;
      
      public static const ACTIVE:int = 1;
      
      public static const CARTOON:int = 2;
      
      public static const REWARD:int = 3;
      
      public var type:int;
      
      public var count:int;
      
      public var resList:Array = [];
      
      public function TimeStoryInfo()
      {
         super();
      }
   }
}

