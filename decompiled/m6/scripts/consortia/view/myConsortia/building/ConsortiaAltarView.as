package consortia.view.myConsortia.building
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.helper.ConsortiaAltarHelper;
   import events.ConsortiaEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaTemplete;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaAltarView extends Sprite implements Disposeable
   {
      
      private var _title:FilterFrameText;
      
      private var _blessBtn:IconButton;
      
      private var _quickBlessBtn:IconButton;
      
      private var _bg:Image;
      
      private var _resetText:FilterFrameText;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _consumeTxt:FilterFrameText;
      
      private var _currentOfferTxt:FilterFrameText;
      
      private var _centerItem:BaseItemView;
      
      private var _staticEffectMC:MovieClip;
      
      private var _altarEffectMC:MovieClip;
      
      private var _centerContainer:Sprite;
      
      private var _itemBg:Image;
      
      private var _data:ConsortiaModel;
      
      public function ConsortiaAltarView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _data = FrameControllerManager.instance.consortiaController.model;
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("consortia.AltarFrameCenterIconBg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.altarNewBg");
         _blessBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.AltarFrameBlessBtn");
         _quickBlessBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.AltarFrameQuickBlessBtn");
         _resetText = ComponentFactory.Instance.creatComponentByStylename("consortia.AltarFrame.resetText");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.AltarFrameLeftTimeTextStyle");
         _consumeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.AltarFrameConsumeTextStyle");
         _currentOfferTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.AltarFrameCurrentOfferTextStyle");
         _centerItem = ComponentFactory.Instance.creatCustomObject("consortia.AltarFrameBaseItemView");
         _staticEffectMC = ComponentFactory.Instance.creat("asset.consortia.altarStaticEffctMC");
         _altarEffectMC = ComponentFactory.Instance.creat("asset.consortia.altarEffctMC");
         _title = ComponentFactory.Instance.creatComponentByStylename("core.FrameTitleText");
         _leftTimeTxt.text = LanguageMgr.GetTranslation("consortia.ConsortiaAltarView.leftTimeTxt") + "0/0";
         _consumeTxt.text = LanguageMgr.GetTranslation("consortia.ConsortiaAltarView.consumeTxt") + consume.toString();
         _currentOfferTxt.text = LanguageMgr.GetTranslation("consortia.ConsortiaAltarView.currentOfferTxt") + playerInfo.consortiaOffer.toString();
         _quickBlessBtn.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaAltarView.QuickBlessTipTxt");
         addChild(_bg);
         addChild(_title);
         _title.x = 227;
         _title.y = 31;
         _title.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaAltarFrame.titleText",consortiaInfo.altarLevel);
         addChild(_staticEffectMC);
         addChild(_altarEffectMC);
         _altarEffectMC.gotoAndStop(1);
         _altarEffectMC.visible = false;
         addChild(_resetText);
         addChild(_blessBtn);
         addChild(_quickBlessBtn);
         addChild(_leftTimeTxt);
         addChild(_consumeTxt);
         addChild(_currentOfferTxt);
         _centerContainer = new Sprite();
         _centerContainer.x = 222;
         _centerContainer.y = -1;
         _centerContainer.visible = false;
         addChild(_centerContainer);
         _centerContainer.addChild(_centerItem);
         _resetText.text = LanguageMgr.GetTranslation("consortia.AltarFrame.resetText.text");
      }
      
      public function playAltarEffect() : void
      {
         _altarEffectMC.visible = true;
         _altarEffectMC.addFrameScript(20,function():void
         {
            altarCallback();
            _centerContainer.visible = true;
            _centerContainer.x = 255;
            _centerContainer.y = 32;
            _centerContainer.scaleX = 0.1;
            _centerContainer.scaleY = 0.1;
            TweenLite.to(_centerContainer,0.15,{
               "x":222,
               "y":-1,
               "scaleX":1,
               "scaleY":1
            });
         });
         _altarEffectMC.addFrameScript(_altarEffectMC.totalFrames - 1,function():void
         {
            _altarEffectMC.stop();
         });
         _altarEffectMC.gotoAndPlay(1);
      }
      
      private function altarCallback() : void
      {
         this.parent.parent["refreshGoods"]();
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeViolentMc(_staticEffectMC);
         _staticEffectMC = null;
         ObjectUtils.disposeViolentMc(_altarEffectMC);
         _altarEffectMC = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_blessBtn);
         _blessBtn = null;
         ObjectUtils.disposeObject(_quickBlessBtn);
         _quickBlessBtn = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_consumeTxt);
         _consumeTxt = null;
         ObjectUtils.disposeObject(_currentOfferTxt);
         _currentOfferTxt = null;
         ObjectUtils.disposeObject(_centerItem);
         _centerItem = null;
         ObjectUtils.disposeObject(_centerContainer);
         _centerContainer = null;
         ObjectUtils.disposeObject(_resetText);
         _resetText = null;
         _data = null;
      }
      
      private function addEvent() : void
      {
         _centerContainer.addEventListener("click",__onIconClickHandler);
         _data.addEventListener("CONSORTIA_UPGRADE",__onConsortiaUpgrade);
         _data.addEventListener("UPDA_ALTAR_BLESS_LEFT_TIME",__onBlessLeftTimeUpdata);
         _data.addEventListener("UPDE_ALTAR_GOODS",__updateAltarGoods);
         playerInfo.addEventListener("CONSORTIA_OFFER_CHANGE",__onSelfConsortiaOfferUpdata);
      }
      
      private function removeEvent() : void
      {
         if(_centerContainer)
         {
            _centerContainer.removeEventListener("click",__onIconClickHandler);
         }
         _data.removeEventListener("CONSORTIA_UPGRADE",__onConsortiaUpgrade);
         _data.removeEventListener("UPDA_ALTAR_BLESS_LEFT_TIME",__onBlessLeftTimeUpdata);
         _data.removeEventListener("UPDE_ALTAR_GOODS",__updateAltarGoods);
         playerInfo.removeEventListener("CONSORTIA_OFFER_CHANGE",__onSelfConsortiaOfferUpdata);
      }
      
      private function __onIconClickHandler(param1:MouseEvent) : void
      {
         __onDrawClickHandler(param1);
      }
      
      public function __onDrawClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.getConsortiaAddFreshItem();
         _altarEffectMC.gotoAndStop(1);
         _altarEffectMC.visible = false;
      }
      
      private function __onConsortiaUpgrade(param1:ConsortiaEvent) : void
      {
         _consumeTxt.text = LanguageMgr.GetTranslation("consortia.ConsortiaAltarView.consumeTxt") + consume.toString();
      }
      
      private function __onBlessLeftTimeUpdata(param1:ConsortiaEvent) : void
      {
         var _loc2_:int = int(_data.alTarBlessLeftTime);
         _loc2_ = totalTime - _loc2_ < 0 ? 0 : totalTime - _loc2_;
         _leftTimeTxt.text = LanguageMgr.GetTranslation("consortia.ConsortiaAltarView.leftTimeTxt") + _loc2_ + " / " + totalTime;
      }
      
      private function __updateAltarGoods(param1:ConsortiaEvent) : void
      {
         _centerItem.data = _data.lastaltarGoods;
      }
      
      public function setCenterItem() : void
      {
         _centerItem.x = _centerItem.y = 0;
         _centerItem.data = ConsortiaAltarHelper.getGoodsInfo(_data);
      }
      
      private function __onSelfConsortiaOfferUpdata(param1:PlayerEvent) : void
      {
         _currentOfferTxt.text = LanguageMgr.GetTranslation("consortia.ConsortiaAltarView.currentOfferTxt") + playerInfo.consortiaOffer + "";
      }
      
      private function get totalTime() : int
      {
         var _loc1_:ConsortiaTemplete = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,consortiaInfo.altarLevel);
         return _loc1_.Property2;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get consume() : int
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,consortiaInfo.altarLevel).Property1;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return _data.consortiaInfo;
      }
      
      public function clearCenterGoods() : void
      {
         _centerItem.data = _data.lastaltarGoods = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get quickBlessBtn() : IconButton
      {
         return _quickBlessBtn;
      }
      
      public function get blessBtn() : IconButton
      {
         return _blessBtn;
      }
   }
}

