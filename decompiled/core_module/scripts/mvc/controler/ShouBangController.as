package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.manager.FrameControllerManager;
   
   public class ShouBangController extends FrameController
   {
      
      public function ShouBangController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      public function startFrameByType(param1:Object = null) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shoubang",null,param1);
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
         return "shoubang.frame";
      }
   }
}

