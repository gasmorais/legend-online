package mvc.module.questionnaire
{
   import events.QuestionnaireEvent;
   import flash.events.EventDispatcher;
   
   public class QuestionnaireModel extends EventDispatcher
   {
      
      private var _questionList:Array;
      
      private var _questionId:int;
      
      private var _questionGoodList:Array;
      
      private var _answerList:Array;
      
      private var _questionContent:String;
      
      private var _questionnaireVisible:Boolean;
      
      public function QuestionnaireModel()
      {
         super();
      }
      
      public function set questionList(param1:Array) : void
      {
         _questionList = param1;
      }
      
      public function get questionList() : Array
      {
         return _questionList;
      }
      
      public function set questionId(param1:int) : void
      {
         _questionId = param1;
      }
      
      public function get questionId() : int
      {
         return _questionId;
      }
      
      public function set questionContent(param1:String) : void
      {
         _questionContent = param1;
      }
      
      public function get questionContent() : String
      {
         return _questionContent;
      }
      
      public function set questionnaireVisible(param1:Boolean) : void
      {
         _questionnaireVisible = param1;
         dispatchEvent(new QuestionnaireEvent("QUESTIONNAIRE_CHANGE"));
      }
      
      public function get questionnaireVisible() : Boolean
      {
         return _questionnaireVisible;
      }
      
      public function set questionGoodList(param1:Array) : void
      {
         _questionGoodList = param1;
      }
      
      public function get questionGoodList() : Array
      {
         return _questionGoodList;
      }
      
      public function set answerList(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 && param1.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(param1[_loc2_].answer != 0)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _questionList.length)
                  {
                     if(_questionList[_loc3_].id == param1[_loc2_].questId)
                     {
                        _questionList.splice(_loc3_,1);
                        _loc3_--;
                     }
                     _loc3_++;
                  }
               }
               _loc2_++;
            }
         }
         dispatchEvent(new QuestionnaireEvent("QUESTIONNAIRE_FRESH"));
      }
      
      public function questionnaireCheck() : void
      {
         dispatchEvent(new QuestionnaireEvent("QUESTIONNAIRE_CHECKED"));
      }
   }
}

