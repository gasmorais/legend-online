package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class ChristmasController extends FrameController
   {
      
      public static const MAIN_FRAME:int = 0;
      
      public static const PRAY_FRAME:int = 1;
      
      public static const GIFT_FRAME:int = 2;
      
      public static const ANSWER_FRAME:int = 3;
      
      public static const LUCKY_FRAME:int = 4;
      
      public static const REWARD_FRAME:int = 5;
      
      public static const SNOWYMIST_FRAME:int = 6;
      
      public static const HIRT_FRAME:int = 7;
      
      public static const CHENG_JIU_FRAME:int = 8;
      
      public static const ANSWER_PREVIEW_FRAME:int = 11;
      
      public static const PRAY_PREVIEW_FRAME:int = 12;
      
      public static const SNOW_REWARD_FRAME:int = 13;
      
      public function ChristmasController()
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
         if(_data.openType == 1)
         {
            return "christmas.ChristmasPrayFrame";
         }
         if(_data.openType == 2)
         {
            return "christmas.ChristmasGiftFrame";
         }
         if(_data.openType == 4)
         {
            return "christmas.ChristmasLuckyFrame";
         }
         if(_data.openType == 3)
         {
            return "christmas.ChristmasAnswerFrame";
         }
         if(_data.openType == 11)
         {
            return "christmas.ChristmasAnswerPreviewFrame";
         }
         if(_data.openType == 12)
         {
            return "christmas.ChristmasPrayPreviewFrame";
         }
         if(_data.openType == 13)
         {
            return "christmas.ChristmasSnowRewardFrame";
         }
         if(_data.openType == 5)
         {
            return "christmas.ChristmasRewardFrame";
         }
         if(_data.openType == 6)
         {
            return "christmas.ChristmasSnowymistFrame";
         }
         if(_data.openType == 7)
         {
            return "christmas.ChristmasHirtFrame";
         }
         if(_data.openType == 8)
         {
            return "christmas.ChristmasChengjiuFrame";
         }
         return "christmas.ChristmasFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

