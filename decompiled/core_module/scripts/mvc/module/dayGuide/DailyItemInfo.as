package mvc.module.dayGuide
{
   public class DailyItemInfo
   {
      
      public var TemplateId:String;
      
      public var Type:int;
      
      public var Levels:int;
      
      public var ActiveTime:String;
      
      public var ActiveName:String;
      
      public var MaxCount:int = 0;
      
      public var Sort:int;
      
      public var currentFinsh:int = 0;
      
      public var condition:String;
      
      public var reward:String;
      
      public var starCount:int = 0;
      
      public var state:int = 0;
      
      public var Detail:String;
      
      public var DropList:String;
      
      public var ActiveType:int;
      
      public function DailyItemInfo()
      {
         super();
      }
   }
}

