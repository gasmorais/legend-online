package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class OldPlayerReturnController extends FrameController
   {
      
      public static const MAIN_FRAME:int = 1;
      
      public static const CONTRACT_FRAME:int = 2;
      
      public static const FIND_FRAME:int = 3;
      
      public static const BUY_FRAME:int = 4;
      
      public function OldPlayerReturnController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData != null)
         {
            _frame["show"](_data);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 2)
         {
            return "oldplayerreturn.OldPlayerReturnContractFrame";
         }
         if(_data.openType == 3)
         {
            return "oldplayerreturn.OldPlayerReturnFindFrame";
         }
         if(_data.openType == 4)
         {
            return "oldplayerreturn.shop.OldPlayerReturnShopBuyFrame";
         }
         return "oldplayerreturn.OldPlayerReturnFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

