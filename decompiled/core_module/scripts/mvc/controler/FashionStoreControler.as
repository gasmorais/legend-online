package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.fashion.FashionModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class FashionStoreControler extends FrameController
   {
      
      private var _model:FashionModel;
      
      private var _openType:int;
      
      private var _enterFromeDragonTalker:Boolean;
      
      public function FashionStoreControler()
      {
         super();
      }
      
      public function get model() : FashionModel
      {
         if(!_model)
         {
            _model = new FashionModel();
         }
         return _model;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(param1)
         {
            _openType = int(param1.openType);
            _enterFromeDragonTalker = false;
            if(param1.frameData)
            {
               _enterFromeDragonTalker = Boolean(param1.frameData);
            }
         }
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_openType,_enterFromeDragonTalker);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
         KeyBoardRegister.instance.keyEnable = true;
         FrameControllerManager.instance.armyController.sendEquipChange();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         return "fashion.FashionStoreFrame";
      }
      
      public function openHelpFrame(param1:String) : void
      {
         (ComponentFactory.Instance.creatComponentByStylename(param1) as SimpleHelpFrame).show(_openType);
      }
   }
}

