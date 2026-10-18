package mvc.module.finalroad
{
   public class FinalRoadModel
   {
      
      public static const LEVEL:int = 5;
      
      public var currentChapter:int = 0;
      
      public var surplusChapterTimes:int = 5;
      
      public var buyChapterTimes:int = 0;
      
      public var passChapterRecord:int = 0;
      
      public var groupInfo:FinalRoadGroupInfo;
      
      public var isOpen:Boolean = true;
      
      public function FinalRoadModel()
      {
         super();
         groupInfo = new FinalRoadGroupInfo();
      }
   }
}

