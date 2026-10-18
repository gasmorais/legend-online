package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.securitycode.SecrityCodeModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConfigManager;
   import yishi.view.community.LoadingSceneView;
   
   public class SecurityCodeControl extends FrameController
   {
      
      private var _model:SecrityCodeModel;
      
      public function SecurityCodeControl()
      {
         super();
      }
      
      public function get model() : SecrityCodeModel
      {
         if(!_model)
         {
            _model = new SecrityCodeModel();
         }
         return _model;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(!ConfigManager.info.SECURITY_CODE)
         {
            return;
         }
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         if(_frame)
         {
            _frame["show"]();
         }
         else
         {
            _frame = ComponentFactory.Instance.createComponentGroupByStylename(frameClassName,true);
            if(_isLoadingLock)
            {
               LoadingSceneView.instance.hide();
            }
            _isLoadingLock = false;
            showFrame();
         }
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function get frameClassName() : String
      {
         return "securityCode.SecurityCodeFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

