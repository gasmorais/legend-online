package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class SecretWarController extends FrameController
   {
      
      public function SecretWarController()
      {
         super();
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
            return "war2023.SecretwarNodeFrame";
         }
         if(_data.openType == 2)
         {
            return "war2023.SecretwarWinFrame";
         }
         if(_data.openType == 3)
         {
            return "war2023.SecretwarRankFrame";
         }
         if(_data.openType == 4)
         {
            return "war2023.SecretwarResultFrame";
         }
         if(_data.openType == 5)
         {
            return "war2023.SecretwarShopFrame";
         }
         return "war2023.SecretwarEnterFrame";
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

