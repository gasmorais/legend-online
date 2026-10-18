package map.internals.transaction
{
   import battle.transaction.TransactionBase;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.campaign.CampaignReportMsg;
   import map.internals.view.displaye.CampaignResultView;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   
   public class CampaignResultTransaction extends TransactionBase
   {
      
      public function CampaignResultTransaction()
      {
         super();
      }
      
      override public function handlePackage() : void
      {
         var _loc1_:CampaignReportMsg = new CampaignReportMsg();
         _loc1_ = _pkg.readBody(_loc1_) as CampaignReportMsg;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_OUT_SCENE"));
         var _loc2_:CampaignResultView = new CampaignResultView(_loc1_);
         SoundManager.instance.playMusic("campaign_succeed",-1,false,true);
         _loc2_.show();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function getCode() : int
      {
         return 137;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         super.dispose();
      }
   }
}

