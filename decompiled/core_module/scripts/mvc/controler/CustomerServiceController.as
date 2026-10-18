package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.module.customerService.CustomerServiceModel;
   import yishi.manager.CustomerServiceManager;
   
   public class CustomerServiceController extends FrameController
   {
      
      public function CustomerServiceController()
      {
         super();
      }
      
      public function get model() : CustomerServiceModel
      {
         return CustomerServiceManager.instance.model;
      }
      
      override public function get frameClassName() : String
      {
         return "customerService.CustomerServiceFrame";
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

