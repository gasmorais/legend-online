package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.events.ResourceEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.utils.FormularySets;
   
   public class FarmResourcesView extends Sprite implements Disposeable
   {
      
      public static const STEP:Number = 9999999;
      
      private var _bg:Image;
      
      private var _goldImg:Bitmap;
      
      private var _crystalImg:Bitmap;
      
      private var _soulImg:Bitmap;
      
      private var _giftImg:Bitmap;
      
      private var _diamondImg:Bitmap;
      
      private var _goldTxt:FilterFrameText;
      
      private var _crystalTxt:FilterFrameText;
      
      private var _soulTxt:FilterFrameText;
      
      private var _giftTxt:FilterFrameText;
      
      private var _diamondTxt:FilterFrameText;
      
      private var _goldContainer:StripView;
      
      private var _crystalContainer:StripView;
      
      private var _soulContainer:StripView;
      
      private var _giftContainer:StripView;
      
      private var _diamondContainer:StripView;
      
      public function FarmResourcesView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewBg");
         _goldImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmResourcesViewGoldImg");
         _crystalImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmResourcesViewCrystalImg");
         _soulImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmResourcesViewSoulImg");
         _giftImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmResourcesViewGiftImg");
         _diamondImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmResourcesViewDiamondImg");
         _goldTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewGoldTxt");
         _crystalTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewCrystalTxt");
         _soulTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewSoulTxt");
         _giftTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewGiftTxt");
         _diamondTxt = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewDiamondTxt");
         _goldContainer = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewGoldContainer");
         _crystalContainer = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewCrystalContainer");
         _soulContainer = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewSoulContainer");
         _giftContainer = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewGiftContainer");
         _diamondContainer = ComponentFactory.Instance.creatComponentByStylename("farm.FarmResourcesViewDiamondContainer");
         _goldContainer.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.gold");
         _crystalContainer.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.crystal");
         _soulContainer.tipData = LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips03");
         _giftContainer.tipData = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.giftToken");
         _diamondContainer.tipData = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.point");
         addChild(_bg);
         _goldContainer.addChild(_goldImg);
         _goldContainer.addChild(_goldTxt);
         _crystalContainer.addChild(_crystalImg);
         _crystalContainer.addChild(_crystalTxt);
         _soulContainer.addChild(_soulImg);
         _soulContainer.addChild(_soulTxt);
         _giftContainer.addChild(_giftImg);
         _giftContainer.addChild(_giftTxt);
         _diamondContainer.addChild(_diamondImg);
         _diamondContainer.addChild(_diamondTxt);
         addChild(_goldContainer);
         addChild(_crystalContainer);
         addChild(_soulContainer);
         addChild(_giftContainer);
         addChild(_diamondContainer);
      }
      
      private function addEvent() : void
      {
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__resourcesUpdateHandler);
         gold.addEventListener(ResourceEvent.RESOURCE_UPDATE,__resourcesUpdateHandler);
         crystal.addEventListener(ResourceEvent.RESOURCE_UPDATE,__resourcesUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         gold.removeEventListener(ResourceEvent.RESOURCE_UPDATE,__resourcesUpdateHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__resourcesUpdateHandler);
         crystal.removeEventListener(ResourceEvent.RESOURCE_UPDATE,__resourcesUpdateHandler);
      }
      
      private function __resourcesUpdateHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         _goldTxt.text = FormularySets.toStringSelf(gold.count,9999999);
         _crystalTxt.text = FormularySets.toStringSelf(crystal.count,9999999);
         _soulTxt.text = FormularySets.toStringSelf(playerInfo.strategy,9999999);
         _giftTxt.text = FormularySets.toStringSelf(playerInfo.giftToken,9999999);
         _diamondTxt.text = FormularySets.toStringSelf(playerInfo.point,9999999);
         gold.count >= gold.limit ? _goldTxt.setFrame(2) : _goldTxt.setFrame(1);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function get crystal() : ResourceData
      {
         return ResourceManager.instance.waterCrystal;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_goldContainer)
         {
            _goldContainer.dispose();
         }
         _goldContainer = null;
         if(_crystalContainer)
         {
            _crystalContainer.dispose();
         }
         _crystalContainer = null;
         if(_soulContainer)
         {
            _soulContainer.dispose();
         }
         _soulContainer = null;
         if(_giftContainer)
         {
            _giftContainer.dispose();
         }
         _giftContainer = null;
         if(_diamondContainer)
         {
            _diamondContainer.dispose();
         }
         _diamondContainer = null;
         if(_goldTxt)
         {
            _goldTxt.dispose();
         }
         _goldTxt = null;
         if(_crystalTxt)
         {
            _crystalTxt.dispose();
         }
         _crystalTxt = null;
         if(_soulTxt)
         {
            _soulTxt.dispose();
         }
         _soulTxt = null;
         if(_giftTxt)
         {
            _giftTxt.dispose();
         }
         _giftTxt = null;
         if(_diamondTxt)
         {
            _diamondTxt.dispose();
         }
         _diamondTxt = null;
         _bg = null;
         _goldImg = null;
         _crystalImg = null;
         _soulImg = null;
         _giftImg = null;
         _diamondImg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

