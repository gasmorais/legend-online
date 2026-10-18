package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import managers.SaleManager;
   import mvc.FrameController;
   
   public class SaleControler extends FrameController
   {
      
      public function SaleControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "sale.SaleFrame";
         if(_data && _data.openType == "TITAN_DATA_CHECK")
         {
            _loc1_ = "sale.SaleFrame";
         }
         return _loc1_;
      }
      
      override protected function showFrame() : void
      {
         SaleManager.instance.sendGetSaleInfos();
         super.showFrame();
         _frame["show"]();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

