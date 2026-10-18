package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.appell.AppellModel;
   
   public class AppellControler extends FrameController
   {
      
      private var _model:AppellModel;
      
      public function AppellControler()
      {
         super();
         _model = new AppellModel();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "appell.AppellGetView";
         }
         return "appell.AppellFrame";
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      override protected function showFrame() : void
      {
         var _loc1_:int = 0;
         super.showFrame();
         if(_data.frameData && _data.openType != 1)
         {
            _loc1_ = int(_data.frameData);
            _frame["show"](_loc1_);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      public function get model() : AppellModel
      {
         return _model;
      }
   }
}

