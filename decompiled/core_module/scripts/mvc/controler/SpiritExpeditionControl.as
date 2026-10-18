package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class SpiritExpeditionControl extends FrameController
   {
      
      public static const MAIN_FRAME:int = 1;
      
      public static const CHAPTER_FRAME:int = 2;
      
      public static const FORMATION_FRAME:int = 3;
      
      private var _isInSpiritExpeditionFrame:Boolean = false;
      
      public function SpiritExpeditionControl()
      {
         super();
      }
      
      public function set isInSpiritExpeditionFrame(param1:Boolean) : void
      {
         _isInSpiritExpeditionFrame = param1;
      }
      
      public function get isInSpiritExpeditionFrame() : Boolean
      {
         return _isInSpiritExpeditionFrame;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 2)
         {
            return "spiritexpedition.SpiritExpeditionChapterFrame";
         }
         if(_data.openType == 3)
         {
            return "spiritexpedition.SpiritExpeditionFormationFrame";
         }
         return "spiritExpedition.spiritExpeditionFrame";
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
   }
}

