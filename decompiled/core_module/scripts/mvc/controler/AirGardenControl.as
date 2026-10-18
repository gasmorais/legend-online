package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import manager.LanguageMgr;
   import managers.AirGardenManager;
   import map.internals.data.CampaignNode;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.datas.templates.AirGardenBedTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class AirGardenControl extends FrameController
   {
      
      public static const CREATE_PARTY:String = "CREATE_PARTY";
      
      public static const JOIN_PARTY:String = "JOIN_PARTY";
      
      public static const BED_CAMPAIGN_SHOW:String = "BED_CAMPAIGN_SHOW";
      
      public static const GAME_TYPE_LLK:String = "GAME_TYPE_LLK";
      
      public static const GAME_TYPE_MEMORYCARD:String = "GAME_TYPE_MEMORYCARD";
      
      public static const GAME_TYPE_FIVECARD:String = "GAME_TYPE_FIVECARD";
      
      public function AirGardenControl()
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
         _frame["show"](_data);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == "CREATE_PARTY")
         {
            return "airGarden.AirGardenCreatePartyFrame";
         }
         if(_data.openType == "JOIN_PARTY")
         {
            return "airGarden.AirGardenJoinPartyFrame";
         }
         if(_data.openType == "GAME_TYPE_LLK")
         {
            return "airGarden.AirGardenGameLlkFrame";
         }
         if(_data.openType == "GAME_TYPE_FIVECARD")
         {
            return "airGarden.AirGardenGameFivecardFrame";
         }
         if(_data.openType == "GAME_TYPE_MEMORYCARD")
         {
            return "airGarden.AirGardenGameMemoryCardFrame";
         }
         if(_data.openType == "BED_CAMPAIGN_SHOW")
         {
            return "airGarden.AirGardenCampaignShowFrame";
         }
         return "airGarden.AirGardenJoinPartyFrame";
      }
      
      public function showAirGardenBedSelect(param1:CampaignNode) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(!param1)
         {
            return;
         }
         if(AirGardenManager.instance.model.campaignInfo.masterUserId != ArmyManager.instance.thane.userId)
         {
            return;
         }
         var _loc2_:AirGardenBedTempInfo = TempleteManager.instance.airGardenBedTempCate.getTemplateById(int(param1.param3));
         if(!_loc2_)
         {
            return;
         }
         var _loc5_:int = 0;
         if(_loc2_.NodeType == 902)
         {
            _loc5_ = 1;
         }
         else if(_loc2_.NodeType == 903)
         {
            _loc5_ = 2;
         }
         else if(_loc2_.NodeType == 904)
         {
            _loc5_ = 3;
         }
         if(_loc5_ != 0)
         {
            FrameControllerManager.instance.openControllerByInfo("airgarden","BED_CAMPAIGN_SHOW",{
               "type":_loc5_,
               "node":param1
            });
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("airgarden.saveHero.alert");
            SimpleAlertHelper.instance.data = [showSureFrameBack,param1];
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc4_,true,true,true,2,"SIMPLE_ALERT",0,"",null);
         }
      }
      
      private function showSureFrameBack(param1:Boolean, param2:Boolean, param3:CampaignNode) : void
      {
         if(!param1)
         {
            return;
         }
         AirGardenManager.instance.reqAirGardenBed(0,param3.nodeId);
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

