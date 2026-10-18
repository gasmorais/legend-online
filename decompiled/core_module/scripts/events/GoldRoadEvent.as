package events
{
   import flash.events.Event;
   
   public class GoldRoadEvent extends Event
   {
      
      public static const GOLDROADRE_FRESH:String = "GOLDROADRE_FRESH";
      
      public static const GOLDROADRE_DICE:String = "GOLDROADRE_DICE";
      
      public static const GOLDROADRE_ARRIVE:String = "GOLDROADRE_ARRIVE";
      
      public static const GOLDROADRE_CELLFRESH:String = "GOLDROADRE_CELLFRESH";
      
      public static const GOLDROADRE_SUPERDICE:String = "GOLDROADRE_SUPERDICE";
      
      public var data:Object;
      
      public function GoldRoadEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

