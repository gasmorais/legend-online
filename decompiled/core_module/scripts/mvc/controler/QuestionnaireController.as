package mvc.controler
{
   import mvc.FrameController;
   import yishi.manager.QuestionnaireManager;
   
   public class QuestionnaireController extends FrameController
   {
      
      public function QuestionnaireController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "questionnaire.QuestionnaireFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         var _loc1_:Array = [];
         QuestionnaireManager.instance.sendQuestionAnswer(0,QuestionnaireManager.instance.model.questionId,_loc1_);
      }
   }
}

