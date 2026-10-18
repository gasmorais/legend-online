package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class MopupController extends FrameController
   {
      
      public static const CAMPAIGN_MOPUP_PREPARE:int = 1;
      
      public static const CAMPAIGN_MOPUP_ING:int = 2;
      
      public static const MAZE_MOPUP_PREPARE:int = 3;
      
      public static const MAZE_MOPUP_INT:int = 4;
      
      public static const REMOTE_MOPUP_PREPARE:int = 5;
      
      public static const REMOTE_MOPUP_INT:int = 6;
      
      public static const ABYSM_MOPUP_PREPARE:int = 7;
      
      public static const ABYSM_MOPUP_INT:int = 8;
      
      public static const LORDTRIAL_MOPUP_PREPARE:int = 9;
      
      public static const LORDTRIAL_MOPUP_ING:int = 10;
      
      public static const TIME_VORTEX_MOPUP_PREPARE:int = 11;
      
      public static const TIME_VORTEX_MOPUP_ING:int = 12;
      
      public static const DEMON_LAND_MOPUP_PREPARE:int = 13;
      
      public static const DEMON_LAND_MOPUP_ING:int = 14;
      
      public static const REVENGE_ROAD_MOPUP_PREPARE:int = 15;
      
      public static const REVENGE_ROAD_MOPUP_ING:int = 16;
      
      public static const Hell_ABYSM_MOPUP_PREPARE:int = 17;
      
      public static const Hell_ABYSM_MOPUP_INT:int = 18;
      
      public static const SHADOW_LAND_MOPUP_PREPARE:int = 19;
      
      public static const SHADOW_LAND_MOPUP_ING:int = 20;
      
      public function MopupController()
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
         _frame["show"](_data.frameData);
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "mopup.view.CampaignMopupPrepareFrame";
         }
         if(_data.openType == 2)
         {
            return "mopup.view.CampaignMopupIngFrame";
         }
         if(_data.openType == 3)
         {
            return "mopup.view.MazeMopupPrepareFrame";
         }
         if(_data.openType == 4)
         {
            return "mopup.view.MazeMopupIngFrame";
         }
         if(_data.openType == 5)
         {
            return "mopup.view.RemoteMopupPrepareFrame";
         }
         if(_data.openType == 6)
         {
            return "mopup.view.RemoteMopupIngFrame";
         }
         if(_data.openType == 7)
         {
            return "mopup.view.AbysmMopupPrepareFrame";
         }
         if(_data.openType == 8)
         {
            return "mopup.view.AbysmMopupIngFrame";
         }
         if(_data.openType == 9)
         {
            return "mopup.view.LordTrialMopupPrepareFrame";
         }
         if(_data.openType == 10)
         {
            return "mopup.view.LordTrialMopupIngFrame";
         }
         if(_data.openType == 11)
         {
            return "mopup.view.TimeVortexMopupPrepareFrame";
         }
         if(_data.openType == 12)
         {
            return "mopup.view.TimeVortexMopupIngFrame";
         }
         if(_data.openType == 13)
         {
            return "mopup.view.DemonLandMopupPrepareFrame";
         }
         if(_data.openType == 14)
         {
            return "mopup.view.DemonLandMopupIngFrame";
         }
         if(_data.openType == 15)
         {
            return "mopup.view.RevengeRoadMopupPrepareFrame";
         }
         if(_data.openType == 16)
         {
            return "mopup.view.RevengeRoadMopupIngFrame";
         }
         if(_data.openType == 17)
         {
            return "mopup.view.HellAbysmMopupPrepareFrame";
         }
         if(_data.openType == 18)
         {
            return "mopup.view.HellAbysmMopupIngFrame";
         }
         if(_data.openType == 19)
         {
            return "mopup.view.ShadowLandMopupPrepareFrame";
         }
         if(_data.openType == 20)
         {
            return "mopup.view.ShadowLandMopupIngFrame";
         }
         return "mopup.view.CampaignMopupPrepareFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

