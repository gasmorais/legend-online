package mvc.controler
{
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.WorldBossSocketOutManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class WorldBossControler extends FrameController
   {
      
      private var _openType:int;
      
      public function WorldBossControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         if(_openType == 1)
         {
            return "worldboss.WorldBossFrame";
         }
         if(_openType == 2)
         {
            return "worldboss.WorldBossFrame";
         }
         if(_openType == 3)
         {
            return "worldboss.PvpSelectFrame";
         }
         return "worldboss.WorldBossFrame";
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         _openType = 0;
         if(param1.openType != null)
         {
            _openType = int(param1.openType);
         }
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_openType != 3)
         {
            _frame["show"](_openType);
         }
         else
         {
            _frame["show"]();
         }
         if(_data.frameData)
         {
            _data.frameData();
         }
      }
      
      public function sendEnterWorldBossBattle() : void
      {
         var _loc1_:String = null;
         var _loc2_:CampaignTemplate = null;
         var _loc3_:Dictionary = TempleteManager.instance.worldBossTemplateDict;
         for each(var _loc4_:CampaignTemplate in _loc3_)
         {
            if(_loc4_.Types == 1)
            {
               _loc2_ = _loc4_;
            }
         }
         if(_loc2_.MinLevel > ArmyManager.instance.thane.grades)
         {
            _loc1_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command02");
            MessageTipManager.instance().show(_loc1_);
         }
         else if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            MessageTipManager.instance().show(WorldBossHelper.getCampaignTips());
         }
         else if(!PlayerManager.instance.currentPlayerModel.playerInfo.worldbossState)
         {
            _loc1_ = LanguageMgr.GetTranslation("mvc.controler.WorldBossControler.unopen",_loc2_.OpenTime,_loc2_.StopTime);
            MessageTipManager.instance().show(_loc1_);
         }
         else
         {
            sendEnterBattle(_loc2_);
         }
      }
      
      public function sendEnterBattle(param1:CampaignTemplate) : void
      {
         if(param1)
         {
            WorldBossSocketOutManager.sendWorldBossCmd(param1.CampaignId);
         }
      }
      
      public function sendCancelStunmanFor(param1:int) : void
      {
         WorldBossSocketOutManager.sendCancelStunmanFor(param1);
      }
   }
}

