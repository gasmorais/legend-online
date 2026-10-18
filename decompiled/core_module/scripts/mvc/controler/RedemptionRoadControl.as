package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class RedemptionRoadControl extends FrameController
   {
      
      public static const CHAPTER_FRAME:String = "CHAPTER_FRAME";
      
      public function RedemptionRoadControl()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == "CHAPTER_FRAME")
         {
            return "redemption.RedemptionRoadChapterFrame";
         }
         return "redemption.RedemptionRoadMainFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

