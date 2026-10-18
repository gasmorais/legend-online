package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class ApexController extends FrameController
   {
      
      public static const TYPE_MAINVIEW:int = 1;
      
      public static const TYPE_GUESS:int = 2;
      
      public static const TYPE_GUESS_DETAIL:int = 3;
      
      public static const TYPE_AWARD:int = 4;
      
      public static const TYPE_RANK:int = 5;
      
      public static const TYPE_AWARD_LIST:int = 6;
      
      public static const TYPE_REPORT:int = 7;
      
      public static const TYPE_TEAM:int = 8;
      
      public var openBlackFrame:Boolean;
      
      public function ApexController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
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
      
      override public function get frameClassName() : String
      {
         openBlackFrame = true;
         if(int(_data.openType) == 1)
         {
            return "apex.ApexHallFrame";
         }
         if(int(_data.openType) == 2)
         {
            return "apex.guess.ApexGuessFrame";
         }
         if(int(_data.openType) == 3)
         {
            return "apex.guess.ApexGuessDetailFrame";
         }
         if(int(_data.openType) == 4)
         {
            return "apex.award.ApexAwardFrame";
         }
         if(int(_data.openType) == 5)
         {
            return "apex.rank.ApexRankFrame";
         }
         if(int(_data.openType) == 6)
         {
            return "apex.award.ApexAwardListFrame";
         }
         if(int(_data.openType) == 7)
         {
            return "apex.report.ApexReportView";
         }
         if(int(_data.openType) == 8)
         {
            return "apex.team.ApexTeamView";
         }
         return "apex.ApexHallFrame";
      }
      
      override protected function exitFrame() : void
      {
         openBlackFrame = false;
         super.exitFrame();
      }
   }
}

