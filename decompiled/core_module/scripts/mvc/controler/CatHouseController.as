package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class CatHouseController extends FrameController
   {
      
      public function CatHouseController()
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
         if(_data.openType == 1)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "cathouse.CatHouseExchangeFame";
         }
         return "cathouse.CatHouseFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

