package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class CultureActiveControler extends FrameController
   {
      
      public function CultureActiveControler()
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
            return "cultureactive.CultureActiveSortFrame";
         }
         return "cultureactive.CultureActiveFrame";
      }
   }
}

