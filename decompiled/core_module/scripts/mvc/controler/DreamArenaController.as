package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import manager.LanguageMgr;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.utils.SimpleAlertHelper;
   
   public class DreamArenaController extends FrameController
   {
      
      public static const MAIN_FRAME:String = "MAIN_FRAME";
      
      public static const FORMATION_FRAME:String = "FORMATION_FRAME";
      
      public static const RANK_REWARD_FRAME:String = "RANK_REWARD_FRAME";
      
      public static const REPORT_FRAME:String = "REPORT_FRAME";
      
      public static const PREVIEW_REWARD_FRAME:String = "PREVIEW_REWARD_FRAME";
      
      public var dreamArenaMatching:Boolean;
      
      public function DreamArenaController()
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
         if(_data.openType == "MAIN_FRAME")
         {
            return "dreamArena.DreamArenaFrame";
         }
         if(_data.openType == "FORMATION_FRAME")
         {
            return "dreamArena.DreamArenaFormationFrame";
         }
         if(_data.openType == "RANK_REWARD_FRAME")
         {
            return "dreamArena.DreamArenaRankRewardFrame";
         }
         if(_data.openType == "REPORT_FRAME")
         {
            return "dreamArena.DreamAreanaReportFrame";
         }
         if(_data.openType == "PREVIEW_REWARD_FRAME")
         {
            return "dreamArena.DreamAreanaPreviewRewardFrame";
         }
         return "dreamArena.DreamArenaFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      public function showChangeSaveAlert(param1:int, param2:Function = null, param3:int = -1) : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = param1 == 20 ? LanguageMgr.GetTranslation("DreamArena.change.saveAlert" + param1) : LanguageMgr.GetTranslation("DreamArena.change.saveAlert");
         SimpleAlertHelper.instance.data = [showSaveFrameBack,param2,param3];
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc4_,_loc5_,true,true,true,2,"SIMPLE_ALERT",0,"",null);
      }
      
      private function showSaveFrameBack(param1:Boolean, param2:Boolean, param3:Function, param4:int) : void
      {
         if(!param1)
         {
            return;
         }
         if(param3 != null)
         {
            if(param4 != -1)
            {
               param3(param4);
            }
            else
            {
               param3();
            }
         }
      }
   }
}

