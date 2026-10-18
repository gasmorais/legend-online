package mvc.controler
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.pvp.PvPModel;
   import yishi.manager.FrameControllerManager;
   
   public class PvPControler extends FrameController
   {
      
      public static var defaultIndex:int = 1;
      
      private var _model:PvPModel;
      
      public function PvPControler()
      {
         super();
      }
      
      public function get model() : PvPModel
      {
         return _model;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(!_model)
         {
            _model = new PvPModel();
         }
         super.start(param1);
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
         _model = null;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](defaultIndex);
         defaultIndex = 1;
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
      }
      
      public function openShopFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",3);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         return "pvp.PvPFrame";
      }
      
      private function get PvPFrame() : Object
      {
         return DisplayLoader.Context.applicationDomain.getDefinition("pvp.PvPFrame");
      }
   }
}

