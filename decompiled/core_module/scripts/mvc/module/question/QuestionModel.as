package mvc.module.question
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class QuestionModel extends EventDispatcher
   {
      
      public var isOpen:Boolean;
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var selectedString:String = "";
      
      public function QuestionModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
   }
}

