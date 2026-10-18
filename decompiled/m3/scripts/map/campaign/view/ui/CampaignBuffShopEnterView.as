package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import map.campaign.view.frame.CampaignBuffFrame;
   import yishi.manager.SharedManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class CampaignBuffShopEnterView extends Sprite implements Disposeable
   {
      
      private var _helpBtb:BaseButton;
      
      private var _trailShop:BaseButton;
      
      private var _trailShopMC:MovieClip;
      
      private var _timeId:int;
      
      public function CampaignBuffShopEnterView()
      {
         super();
         initView();
         initEvent();
         playEffect();
      }
      
      private function initView() : void
      {
         _helpBtb = ComponentFactory.Instance.creatComponentByStylename("campaign.randomboos.HelpBtn");
         _trailShop = ComponentFactory.Instance.creatComponentByStylename("campaign.randomboos.enterBtn");
         _trailShopMC = ComponentFactory.Instance.creatCustomObject("campaign.TrailShopMC");
         addChild(_helpBtb);
         addChild(_trailShopMC);
         _trailShopMC["pos"].addChild(_trailShop);
      }
      
      private function playEffect() : void
      {
         var _loc1_:Boolean = Boolean(SharedManager.instance.isCampaignBuffFirst);
         if(!_loc1_)
         {
            SharedManager.instance.isCampaignBuffFirst = true;
            SharedManager.instance.saveFistCampaignBuff();
            _trailShopMC.gotoAndPlay(1);
            _timeId = setTimeout(stopEffect,5000);
         }
         else
         {
            stopEffect();
         }
      }
      
      private function stopEffect() : void
      {
         clearTimeout(_timeId);
         _timeId = 0;
         _trailShopMC.gotoAndStop(1);
      }
      
      private function initEvent() : void
      {
         _helpBtb.addEventListener("click",__helpHandler);
         _trailShop.addEventListener("click",__openShopHandler);
      }
      
      private function removeEvent() : void
      {
         _trailShop.removeEventListener("click",__openShopHandler);
         _helpBtb.removeEventListener("click",__helpHandler);
      }
      
      private function __openShopHandler(param1:MouseEvent) : void
      {
         var _loc2_:CampaignBuffFrame = ComponentFactory.Instance.creatComponentByStylename("campaign.CampaignBuffFrame");
         _loc2_.show();
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("room.bloody.helpFrame");
         _loc2_.show();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_trailShop);
         _trailShop = null;
         ObjectUtils.disposeObject(_helpBtb);
         _helpBtb = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

