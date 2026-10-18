package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class ProficiencyControler extends FrameController
   {
      
      public static const MAIN_FRAME:String = "MAIN_FRAME";
      
      public static const EXCHANGE_FRAME:String = "EXCHANGE_FRAME";
      
      public function ProficiencyControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == "EXCHANGE_FRAME")
         {
            return "proficiency.ProficiencyExchangeFrame";
         }
         return "proficiency.ProficiencyFrame";
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

