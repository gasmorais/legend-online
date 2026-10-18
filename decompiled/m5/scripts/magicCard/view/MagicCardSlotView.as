package magicCard.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MagicCardEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import magicCard.view.base.MagicCardSlotItem;
   import magicCard.view.base.MagicCardSlotOrgItem;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.TreasureHuntManager;
   import mvc.module.card.MagicCardModel;
   import mvc.module.treasurehunt.HuntEvent;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MagicCardManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.SharedManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseIconView;
   
   public class MagicCardSlotView extends Sprite implements Disposeable
   {
      
      private var _back:Scale9CornerImage;
      
      private var _upBack:MutipleImage;
      
      private var _downBack:Bitmap;
      
      private var _treasureBtn:IconButton;
      
      private var _explainBtn:IconButton;
      
      private var _wingBg:Bitmap;
      
      private var _suitName:BaseIconView;
      
      private var _itemCountBg:Bitmap;
      
      private var _itemIcon:Bitmap;
      
      private var _itemTxt:Bitmap;
      
      private var _itemCountTxt:FilterFrameText;
      
      private var _itemCountComponent:Component;
      
      private var _itemList:Vector.<MagicCardSlotItem>;
      
      private var _cardInfoList:SimpleDictionary;
      
      private var _suitId:int;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _treasureEffect:MainToolBtnGlowEffect;
      
      private var _treasureEffectUint:uint;
      
      private var _cardDscTxt:FilterFrameText;
      
      private var _type:int;
      
      public function MagicCardSlotView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("magicCard.CardSlotViewBack");
         _upBack = ComponentFactory.Instance.creatComponentByStylename("magicCard.CardSlotView.upBack");
         _downBack = ComponentFactory.Instance.creatBitmap("asset.magicCardSlotView.downBack");
         _treasureBtn = ComponentFactory.Instance.creatComponentByStylename("magicCardSlotView.magicpubBtn");
         _wingBg = ComponentFactory.Instance.creatBitmap("asset.magicCardSlotView.wing");
         _suitName = ComponentFactory.Instance.creatCustomObject("magicCard.suitName");
         _explainBtn = ComponentFactory.Instance.creatComponentByStylename("MagicCardSlotView.explainBtn");
         _itemCountBg = ComponentFactory.Instance.creatBitmap("asset.magicCardSlotView.NeedItemBg");
         _itemIcon = ComponentFactory.Instance.creatBitmap("asset.magicCardSlotView.NeedItemIcon");
         _itemTxt = ComponentFactory.Instance.creatBitmap("asset.magicCardSlotView.NeedItemTxt");
         _itemCountTxt = ComponentFactory.Instance.creatComponentByStylename("MagicCardSlotView.ItemCountTxt");
         _itemCountComponent = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotItem.itemCountComponent");
         _itemCountComponent.addChild(_itemCountTxt);
         _itemCountComponent.addChild(_itemTxt);
         _itemCountComponent.addChild(_itemIcon);
         _itemCountComponent.tipData = LanguageMgr.GetTranslation("magicCard.view.itemCountComponent.tipdata");
         _cardDscTxt = ComponentFactory.Instance.creatComponentByStylename("magicCard.MagicCardSlotView.cardDscTxt");
         addChild(_back);
         addChild(_upBack);
         addChild(_downBack);
         addChild(_treasureBtn);
         addChild(_wingBg);
         addChild(_suitName);
         addChild(_explainBtn);
         addChild(_itemCountBg);
         addChild(_itemCountComponent);
         addChild(_cardDscTxt);
         _explainBtn.visible = false;
         if(magicCardModel.hasCanExplainCard)
         {
            _explainBtn.visible = true;
            _effect = new MainToolBtnGlowEffect(_explainBtn);
            _effect.play();
         }
         _cardInfoList = new SimpleDictionary();
         initSlotItem();
         __refreshHandler();
      }
      
      private function stopEffect() : void
      {
         if(_effect != null)
         {
            _effect.stop();
         }
      }
      
      private function initSlotItem() : void
      {
         var _loc3_:int = 0;
         var _loc1_:MagicCardSlotItem = null;
         _itemList = new Vector.<MagicCardSlotItem>();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = new MagicCardSlotItem();
            _itemList.push(_loc1_);
            addChild(_loc1_);
            _loc1_.x = _loc3_ % 2 * 393 + 32;
            _loc1_.y = int(_loc3_ / 2) * 200 + 37;
            _loc3_++;
         }
         var _loc2_:MagicCardSlotOrgItem = new MagicCardSlotOrgItem();
         _itemList.push(_loc2_);
         addChild(_loc2_);
         _loc2_.x = 204;
         _loc2_.y = 160;
      }
      
      private function initEvent() : void
      {
         _treasureBtn.addEventListener("click",__treasureHandler);
         MagicCardManager.Instance.addEventListener("MAGICCARD_SUITINFO",__suitClickHandler);
         MagicCardManager.Instance.addEventListener("MAGICCARD_UPDATE",__magicCardUpdateHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",onDuskNumChange);
         _explainBtn.addEventListener("click",onExplainClick);
         TreasureHuntManager.instance.addEventListener("HUNT_TEM",__refreshHandler);
      }
      
      private function __refreshHandler(param1:HuntEvent = null) : void
      {
         if(TreasureHuntManager.instance.model.seekCount > 0)
         {
            _treasureEffect = new MainToolBtnGlowEffect(_treasureBtn);
            _treasureEffect.play();
         }
      }
      
      protected function __magicCardUpdateHandler(param1:MagicCardEvent) : void
      {
         updateView();
      }
      
      private function __treasureHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("magicpub");
      }
      
      private function __todayNotAlertTidy(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.quickMouseWorkDate = new Date();
            SharedManager.instance.saveQuickMouseWorkDate();
         }
         SoundManager.instance.play("022");
         MagicCardManager.Instance.updateMagicCard(3);
      }
      
      private function __todayNotAlertTidyTwo(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.quickActiveMouseWorkDate = new Date();
            SharedManager.instance.saveQuickActiveMouseWorkDate();
         }
         SoundManager.instance.play("022");
         MagicCardManager.Instance.updateMagicCard(2);
      }
      
      private function updateView() : void
      {
         onDuskNumChange();
         _suitName.icon = PathManager.getCardTabNamePath(_type);
         updateCardData();
         _cardDscTxt.text = LanguageMgr.GetTranslation("magicCard.view.cardDscTxt" + _type);
      }
      
      protected function __suitClickHandler(param1:MagicCardEvent) : void
      {
         _type = param1.data;
         updateView();
      }
      
      private function updateCardData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MagicCardSlotItem = null;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.setTypeAndPos(_type,_loc2_ + 1,1);
            _loc2_++;
         }
      }
      
      private function onDuskNumChange(param1:NotificationEvent = null) : void
      {
         if(!magicCardModel.hasCanExplainCard)
         {
            _explainBtn.visible = false;
            if(_effect)
            {
               _effect.stop();
            }
         }
         else
         {
            _explainBtn.visible = true;
            if(_effect)
            {
               _effect.play();
            }
         }
         _itemCountTxt.text = PlayerCurrencyManager.instance.currencyInfo.magicDust.amount.toString();
      }
      
      private function removeEvent() : void
      {
         _treasureBtn.removeEventListener("click",__treasureHandler);
         MagicCardManager.Instance.removeEventListener("MAGICCARD_SUITINFO",__suitClickHandler);
         MagicCardManager.Instance.removeEventListener("MAGICCARD_UPDATE",__magicCardUpdateHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",onDuskNumChange);
         _explainBtn.removeEventListener("click",onExplainClick);
         TreasureHuntManager.instance.removeEventListener("HUNT_TEM",__refreshHandler);
      }
      
      private function onExplainClick(param1:MouseEvent) : void
      {
         MagicCardManager.Instance.updateMagicCard(3);
      }
      
      private function get magicCardModel() : MagicCardModel
      {
         return MagicCardManager.Instance.cardModel;
      }
      
      public function get treasureBtn() : IconButton
      {
         return _treasureBtn;
      }
      
      public function dispose() : void
      {
         clearTimeout(_treasureEffectUint);
         removeEvent();
         _itemList = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_upBack);
         _upBack = null;
         ObjectUtils.disposeObject(_downBack);
         _downBack = null;
         ObjectUtils.disposeObject(_treasureBtn);
         _treasureBtn = null;
         ObjectUtils.disposeObject(_wingBg);
         _wingBg = null;
         ObjectUtils.disposeObject(_cardInfoList);
         _cardInfoList = null;
         ObjectUtils.disposeObject(_explainBtn);
         _explainBtn = null;
         ObjectUtils.disposeObject(_itemCountBg);
         _itemCountBg = null;
         ObjectUtils.disposeObject(_itemIcon);
         _itemIcon = null;
         ObjectUtils.disposeObject(_itemTxt);
         _itemTxt = null;
         ObjectUtils.disposeObject(_itemCountTxt);
         _itemCountTxt = null;
         ObjectUtils.disposeObject(_cardDscTxt);
         _cardDscTxt = null;
         if(_suitName)
         {
            _suitName.icon = null;
         }
         ObjectUtils.disposeObject(_suitName);
         _suitName = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

