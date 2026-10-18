package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.answer.AnswerModel;
   import yishi.manager.AnswerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class AnswerControler extends FrameController
   {
      
      public function AnswerControler()
      {
         super();
      }
      
      public function get model() : AnswerModel
      {
         return AnswerManager.Instance.model;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         AnswerManager.Instance.sendRequestOpenUI();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
         AnswerManager.Instance.sendRequestCloseUI();
      }
      
      override public function get frameClassName() : String
      {
         return "answer.AnswerFrame";
      }
      
      public function showHelpFrame() : void
      {
         var _loc1_:SimpleHelpFrame = null;
         _loc1_ = ComponentFactory.Instance.creatComponentByStylename("answer.helpframe");
         _loc1_.show();
      }
   }
}

