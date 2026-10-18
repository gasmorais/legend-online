package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class PublicEggControler extends FrameController
   {
      
      public function PublicEggControler()
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
            _frame["show"]();
         }
         else if(_data.openType == 2)
         {
            _frame["show"]();
         }
         else if(_data.openType == 3)
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
            return "publicegg.frame.PublicEggFrame";
         }
         if(_data.openType == 2)
         {
            return "publicegg.frame.PublicGiftFrame";
         }
         if(_data.openType == 3)
         {
            return "publicegg.PublicEggConfirmFrame";
         }
         return "publicegg.PublicEggGiftExchargeFrame";
      }
   }
}

