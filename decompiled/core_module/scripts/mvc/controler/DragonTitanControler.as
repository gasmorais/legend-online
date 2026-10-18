package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.module.dragonTitan.DragonTitanData;
   
   public class DragonTitanControler extends FrameController
   {
      
      public var titanData:DragonTitanData;
      
      public function DragonTitanControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "dragontitan.DragonTitanFrame";
         if(_data && _data.openType == "TITAN_DATA_CHECK")
         {
            _loc1_ = "dragontitan.DragonTitanInfoView";
         }
         return _loc1_;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

