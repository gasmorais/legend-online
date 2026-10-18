package events
{
   import flash.events.Event;
   
   public class QuestionnaireEvent extends Event
   {
      
      public static const QUESTIONNAIRE_FRESH:String = "QUESTIONNAIRE_FRESH";
      
      public static const QUESTIONNAIRE_CHECKED:String = "QUESTIONNAIRE_CHECKED";
      
      public static const QUESTIONNAIRE_CHANGE:String = "QUESTIONNAIRE_CHANGE";
      
      public function QuestionnaireEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

