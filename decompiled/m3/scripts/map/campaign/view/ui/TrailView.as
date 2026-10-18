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
   import map.campaign.CampaignManager;
   import map.campaign.data.TrialModel;
   import map.campaign.view.frame.TrailShopFrame;
   import yishi.manager.SharedManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class TrailView extends Sprite implements Disposeable
   {
      
      private var _helpBtb:BaseButton;
      
      private var _trailShop:BaseButton;
      
      private var _trailShopMC:MovieClip;
      
      private var _timeId:int;
      
      public function TrailView()
      {
         super();
         initView();
         initEvent();
         playEffect();
      }
      
      private function initView() : void
      {
         _helpBtb = ComponentFactory.Instance.creatComponentByStylename("campaign.Trailmap.HelpBtn");
         _trailShop = ComponentFactory.Instance.creatComponentByStylename("campaign.Trailmap.ShopIconButton");
         _trailShopMC = ComponentFactory.Instance.creatCustomObject("campaign.TrailShopMC");
         addChild(_helpBtb);
         addChild(_trailShopMC);
         _trailShopMC["pos"].addChild(_trailShop);
      }
      
      private function playEffect() : void
      {
         var _loc1_:Boolean = Boolean(SharedManager.instance.isTrailFirst);
         if(!_loc1_)
         {
            SharedManager.instance.isTrailFirst = true;
            SharedManager.instance.saveFistTrail();
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
         var _loc2_:TrailShopFrame = ComponentFactory.Instance.creatComponentByStylename("campaign.Trailmap.TrailShopFrame");
         _loc2_.show();
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("campaign.Trailmap.HelpFrame");
         _loc2_.show();
      }
      
      private function get model() : TrialModel
      {
         return CampaignManager.instance.trialModel;
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

