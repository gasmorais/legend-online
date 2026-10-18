package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ExpBackControler extends FrameController
   {
      
      public function ExpBackControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      override public function get frameClassName() : String
      {
         return "expback.ExperienceBackNewFrame";
      }
      
      public function showHelpFrame() : void
      {
         var _loc1_:SimpleHelpFrame = null;
         _loc1_ = ComponentFactory.Instance.creatComponentByStylename("expback.helpframe");
         _loc1_.show();
      }
   }
}

