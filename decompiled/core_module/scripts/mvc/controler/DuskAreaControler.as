package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class DuskAreaControler extends FrameController
   {
      
      private var _frameClassName:String;
      
      public function DuskAreaControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return _frameClassName;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         _frameClassName = "duskarea.DuskAreaAccountFrame";
         super.start(param1);
      }
   }
}

