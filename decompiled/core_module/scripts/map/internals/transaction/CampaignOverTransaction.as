package map.internals.transaction
{
   import battle.transaction.TransactionBase;
   import managers.GameHallManager;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import yishi.SwitchPageHelp;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   
   public class CampaignOverTransaction extends TransactionBase
   {
      
      public function CampaignOverTransaction()
      {
         super();
      }
      
      override public function handlePackage() : void
      {
         CampaignManager.instance.exit = true;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_ENTER_SCENE"));
         var _loc1_:CampaignTemplate = TempleteManager.instance.campaignTemplateDic[mapModel.mapTempInfo.CampaignId];
         if(_loc1_ && _loc1_.Capacity == 1)
         {
            RoomManager.instance.dispose();
            SwitchPageHelp.returnToSpace();
            return;
         }
         if(GameHallManager.instance.model.selfTeam)
         {
            RoomManager.instance.dispose();
            GameHallManager.instance.enterGameHallScene();
            return;
         }
         SceneManager.instance.setScene("PVE_ROOM_SCENE");
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      override public function getCode() : int
      {
         return 134;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

