package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class CampaignCountDownView extends Sprite implements Disposeable
   {
      
      private var titleTxt:FilterFrameText;
      
      public function CampaignCountDownView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleTxt = ComponentFactory.Instance.creatComponentByStylename("CampaignCountDownView.TitleTxt");
         addChild(titleTxt);
         try
         {
            onUpdate(null);
         }
         catch(e:Error)
         {
         }
         onUpdate();
      }
      
      private function onUpdate(param1:NotificationEvent = null) : void
      {
         var _loc2_:int = int(CampaignManager.instance.bloodyCurrentWave);
         if(_loc2_ < 1)
         {
            _loc2_ = 1;
         }
         titleTxt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.title",_loc2_);
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("RANDOM_CAMPAIGN_UPDATE_TIME",onUpdate);
         NotificationManager.instance.addEventListener("RANDOM_CAMPAIGN_UPDATE_BUFF",onUpdate);
         NotificationManager.instance.addEventListener("RANDOM_CAMPAIGN_CD",onUpdate);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("RANDOM_CAMPAIGN_UPDATE_TIME",onUpdate);
         NotificationManager.instance.removeEventListener("RANDOM_CAMPAIGN_UPDATE_BUFF",onUpdate);
         NotificationManager.instance.removeEventListener("RANDOM_CAMPAIGN_CD",onUpdate);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

