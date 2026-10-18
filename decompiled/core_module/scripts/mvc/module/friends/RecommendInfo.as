package mvc.module.friends
{
   import flash.events.EventDispatcher;
   
   public class RecommendInfo extends EventDispatcher
   {
      
      public var id:int;
      
      public var name:String;
      
      public var level:int;
      
      public var sex:int;
      
      public var attack:int;
      
      public var mapname:String;
      
      public var vocationGrades:int;
      
      public var vocationIndex:int;
      
      public var job:int;
      
      public function RecommendInfo()
      {
         super();
      }
   }
}

