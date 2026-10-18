package mvc.controler
{
   import mvc.FrameController;
   
   public class FarmController extends FrameController
   {
      
      public static const HOME_NEW_FRAME:String = "HOME_NEW_FRAME";
      
      public static const FARM_MAKE_FRAME:String = "FARM_MAKE_FRAME";
      
      public static const FARM_PROCESSING_FRAME:String = "FARM_PROCESSING_FRAME";
      
      public static const FARM_INVIDE_FRAME:String = "FARM_INVIDE_FRAME";
      
      public static const FARM_ENTER_NEW_FRAME:String = "CastleBuildingView.FarmEnterNewFrame";
      
      public function FarmController()
      {
         super();
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
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "CastleBuildingView.FarmEnterNewFrame";
         if(_data.openType == "FARM_MAKE_FRAME")
         {
            _loc1_ = "farm.FarmMakeFrame";
         }
         else if(_data.openType == "FARM_PROCESSING_FRAME")
         {
            _loc1_ = "farm.FarmProcessingFrame";
         }
         else if(_data.openType == "FARM_INVIDE_FRAME")
         {
            _loc1_ = "farm.FarmInvideFrame";
         }
         else if(_data.openType == "HOME_NEW_FRAME")
         {
            _loc1_ = "farm.newview.HomeFrame";
         }
         else if(_data.openType == "CastleBuildingView.FarmEnterNewFrame")
         {
            _loc1_ = "farm.FarmEnterNewFrame";
         }
         return _loc1_;
      }
   }
}

