package mvc.controler
{
   import mvc.FrameController;
   
   public class SecretAdventureController extends FrameController
   {
      
      public static const EVENT_DES:int = 1;
      
      public static const EVENT_SHOP:int = 2;
      
      public static const EVENT_DIALOG:int = 3;
      
      public function SecretAdventureController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == 1 || _data.openType == 2 || _data.openType == 3)
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
            return "secretadventure.SecretAdEventFrame";
         }
         if(_data.openType == 2)
         {
            return "secretadventure.SecretShopFrame";
         }
         if(_data.openType == 3)
         {
            return "secretadventure.SecretDialogFrame";
         }
         return "secretadventure.SecretAdventureFrame";
      }
   }
}

