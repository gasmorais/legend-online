package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaNewBossModel;
   import mvc.module.shop.ShopModel;
   import view.GoodsItem13;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.ConsortiaNewBossManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class ConsortiaNewBossBufferShopFrame extends Frame
   {
      
      private var _data:ShopModel;
      
      private var _signButton:IconButton;
      
      private var _displayShow:Bitmap;
      
      private var _displayShowTxt:Bitmap;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _stripView:StripView;
      
      private var _itemList:Vector.<GoodsItem13>;
      
      private var frameBg:MutipleImage;
      
      private var _hintTxt:FilterFrameText;
      
      private var _leftBuyCountTxt:FilterFrameText;
      
      private var _bufferMaxCount:int;
      
      public function ConsortiaNewBossBufferShopFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:GoodsItem13 = null;
         _data = FrameControllerManager.instance.shopController.model;
         frameBg = ComponentFactory.Instance.creatComponentByStylename("shop.ConsortiaNewBossBufferShopFrame.bg");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _hintTxt = ComponentFactory.Instance.creatComponentByStylename("shop.consortianewboss.hint");
         _displayShowTxt = ComponentFactory.Instance.creatBitmap("asset.shop.consortianewboss.moneyStr");
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.areslordsShopTip.StripView");
         _contributeTxt.text = consortiaInfo.offer.toString();
         _leftBuyCountTxt = ComponentFactory.Instance.creatComponentByStylename("shop.consortianewboss.leftBuyCountTxt");
         addToContent(frameBg);
         addToContent(_displayShow);
         _displayShow.x = 38;
         _displayShow.y = 493;
         addToContent(_displayShowTxt);
         _displayShowTxt.x = 55;
         _displayShowTxt.y = 497;
         addToContent(_signButton);
         _signButton.x = 594;
         _signButton.y = 472;
         addToContent(_prePageBtn);
         _prePageBtn.x = 278;
         _prePageBtn.y = 443;
         addToContent(_nextPageBtn);
         _nextPageBtn.x = 438;
         _nextPageBtn.y = 443;
         addToContent(_pageNumTxt);
         _pageNumTxt.x = 358;
         _pageNumTxt.y = 446;
         addToContent(_contributeTxt);
         _contributeTxt.x = 139;
         _contributeTxt.y = 499;
         addToContent(_hintTxt);
         _hintTxt.x = 273;
         _hintTxt.y = 497;
         _hintTxt.wordWrap = true;
         _hintTxt.width = 320;
         _hintTxt.height = 40;
         addToContent(_stripView);
         _stripView.x = 39;
         _stripView.y = 497;
         addToContent(_leftBuyCountTxt);
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _itemList = new Vector.<GoodsItem13>();
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc1_ = new GoodsItem13();
            _loc4_ = _loc3_ / 3;
            _loc2_ = _loc3_ % 3;
            _loc1_.x = _loc2_ * _loc1_.width + 33;
            _loc1_.y = _loc4_ * (_loc1_.height + 3) + 62;
            addToContent(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
         _hintTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossBufferShopFrame.desc");
         _bufferMaxCount = consortiaNewBossModel.getBufferCount();
         _leftBuyCountTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossBufferShopFrame.leftBuyCountTxt",_bufferMaxCount - consortiaNewBossModel.bufferBuyCount,_bufferMaxCount);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         _signButton.addEventListener("click",__onSignClick);
         consortiaModel.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
         consortiaModel.addEventListener("CONSORTIA_NEW_BOSS_BUFFER_CLEAR",bossInfoUpdate);
         NotificationManager.instance.addEventListener("CONSORTIA_NEW_BOSS_INFO_UPDATE",bossInfoUpdate);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         _signButton.removeEventListener("click",__onSignClick);
         consortiaModel.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
         consortiaModel.removeEventListener("CONSORTIA_NEW_BOSS_BUFFER_CLEAR",bossInfoUpdate);
         NotificationManager.instance.removeEventListener("CONSORTIA_NEW_BOSS_INFO_UPDATE",bossInfoUpdate);
      }
      
      private function __refreshPage(param1:ShopEvent) : void
      {
         _pageNumTxt.text = _data.currentPage + "/" + _data.totalPage;
         _prePageBtn.enable = _data.currentPage != 1;
         _nextPageBtn.enable = _data.currentPage != _data.totalPage;
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.initConsortiaNewBossBufferShopFrame();
      }
      
      private function __refreshGoods(param1:ShopEvent) : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         if(_data.showGoodsList)
         {
            _data.showGoodsList.sortOn("templateId",16);
            _loc2_ = 0;
            while(_loc2_ < 9)
            {
               _loc3_ = GoodsInfo(_data.showGoodsList[_loc2_]);
               if(_loc3_ && _loc3_.templateId == consortiaNewBossModel.bufferId && !consortiaNewBossModel.bufferIsOver())
               {
                  _itemList[_loc2_].isCurrentBuffer = true;
               }
               else
               {
                  _itemList[_loc2_].isCurrentBuffer = false;
               }
               _itemList[_loc2_].data = _loc2_ < _data.showGoodsList.length ? _loc3_ : null;
               _loc2_++;
            }
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __onConsortiaInfoUpdata(param1:ConsortiaEvent) : void
      {
         if(_contributeTxt)
         {
            _contributeTxt.text = consortiaInfo.offer.toString();
         }
      }
      
      private function bossInfoUpdate(param1:Event) : void
      {
         __refreshGoods(null);
         _leftBuyCountTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossBufferShopFrame.leftBuyCountTxt",_bufferMaxCount - consortiaNewBossModel.bufferBuyCount,_bufferMaxCount);
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return ConsortiaManager.instance.model.consortiaInfo;
      }
      
      private function get consortiaModel() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get consortiaNewBossModel() : ConsortiaNewBossModel
      {
         return ConsortiaNewBossManager.instance.model;
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _data = null;
         ObjectUtils.disposeObject(_displayShow);
         _displayShow = null;
         ObjectUtils.disposeObject(_signButton);
         _signButton = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_contributeTxt);
         _contributeTxt = null;
         ObjectUtils.disposeObject(_displayShowTxt);
         _displayShowTxt = null;
         ObjectUtils.disposeObject(_stripView);
         _stripView = null;
         ObjectUtils.disposeObject(frameBg);
         frameBg = null;
         ObjectUtils.disposeObject(_hintTxt);
         _hintTxt = null;
         if(_itemList)
         {
            while(_itemList.length)
            {
               ObjectUtils.disposeObject(_itemList.pop());
            }
            _itemList = null;
         }
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

