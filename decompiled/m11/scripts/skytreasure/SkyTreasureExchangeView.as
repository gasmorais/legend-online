package skytreasure
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import events.SkyTreasureEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureActTemplateInfo;
   import mvc.module.skytreasure.SkyTreasureExchangeItemInfo;
   import mvc.module.skytreasure.SkyTreasureModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.SkyTreasureManager;
   
   public class SkyTreasureExchangeView extends Component
   {
      
      private var currentinfo:SkyTreasureActTemplateInfo;
      
      private var currentPage:int;
      
      private var totalPage:int;
      
      private var _bg:MutipleImage;
      
      private var _back:ScaleBitmapImage;
      
      private var _displayShow:Bitmap;
      
      private var _pvpIcon:Bitmap;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _itemList:Vector.<SkyGoodItem>;
      
      private var _contributenameTxt:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      public function SkyTreasureExchangeView()
      {
         super();
         currentPage = 1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:SkyGoodItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsListViewBGSKY");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _pvpIcon = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.DiamondIcon");
         _contributenameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _pageNumTxt.text = "1/1";
         _contributenameTxt.x = 40;
         _contributenameTxt.y = 430;
         _contributenameTxt.text = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle7");
         _contributenameTxt.wordWrap = true;
         _contributenameTxt.height = 60;
         _contributenameTxt.width = 70;
         _contributeTxt.text = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208802) + "";
         addChild(_bg);
         _bg.x = 7;
         _bg.y = 5;
         addChild(_displayShow);
         _displayShow.x = 12;
         _displayShow.y = 434;
         addChild(_pvpIcon);
         _pvpIcon.x = 14;
         _pvpIcon.y = 437;
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         addChild(_pageNumTxt);
         addChild(_contributeTxt);
         addChild(_contributenameTxt);
         _contributeTxt.x = 105;
         _contributeTxt.y = 439;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _itemList = new Vector.<SkyGoodItem>();
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc1_ = new SkyGoodItem();
            _loc4_ = _loc3_ / 3;
            _loc2_ = _loc3_ % 3;
            _loc1_.x = _loc2_ * _loc1_.width + 7;
            _loc1_.y = _loc4_ * (_loc1_.height + 3) + 5;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_EXCHANGEINFO_UPDATE",__onLotteryResult);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_LOTTERYINFO_UPDATE",__onLotteryResult);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_prePageBtn)
         {
            _prePageBtn.removeEventListener("click",__onPageHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",__onPageHandler);
         }
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_EXCHANGEINFO_UPDATE",__onLotteryResult);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_LOTTERYINFO_UPDATE",__onLotteryResult);
      }
      
      private function __onLotteryResult(param1:SkyTreasureEvent = null) : void
      {
         _contributeTxt.text = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208802) + "";
      }
      
      private function __refreshPage(param1:ShopEvent) : void
      {
         _pageNumTxt.text = currentPage + "/" + totalPage;
         _prePageBtn.enable = currentPage != 1;
         _nextPageBtn.enable = currentPage != totalPage;
      }
      
      private function __refreshGoods(param1:SkyTreasureActTemplateInfo = null) : void
      {
         var _loc2_:SkyTreasureExchangeItemInfo = null;
         var _loc3_:int = (currentPage - 1) * 9;
         _loc3_;
         while(_loc3_ < (currentPage - 1) * 9 + 9)
         {
            _loc2_ = param1.getSkyTreasureExchangeInfoByTempleteId(param1.skyTreasureExchangeTempleteIdArray[_loc3_]);
            _itemList[_loc3_ - (currentPage - 1) * 9].data = _loc2_;
            _loc3_++;
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
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         if(param1.target.iconStyle == "asset.core.nextPageImg")
         {
            currentPage < totalPage ? currentPage++ : currentPage;
         }
         else
         {
            currentPage == 1 ? currentPage : int(currentPage--);
         }
         __refreshGoods(currentinfo);
         SoundManager.instance.play("022");
         _pageNumTxt.text = currentPage + "/" + totalPage;
         _prePageBtn.enable = currentPage != 1;
         _nextPageBtn.enable = currentPage != totalPage;
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get pumpModel() : SkyTreasureModel
      {
         return SkyTreasureManager.Instance.model;
      }
      
      public function update(param1:SkyTreasureActTemplateInfo) : void
      {
         currentinfo = param1;
         __refreshGoods(param1);
         totalPage = param1.skyTreasureExchangeTempleteIdArray.length / 9 < 1 ? 1 : Math.ceil(param1.skyTreasureExchangeTempleteIdArray.length / 9);
         _pageNumTxt.text = currentPage + "/" + totalPage;
         _prePageBtn.enable = currentPage != 1;
         _nextPageBtn.enable = currentPage != totalPage;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_contributenameTxt);
         _contributenameTxt = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_displayShow);
         _displayShow = null;
         if(_prePageBtn)
         {
            ObjectUtils.disposeObject(_prePageBtn);
            _prePageBtn = null;
         }
         if(_nextPageBtn)
         {
            ObjectUtils.disposeObject(_nextPageBtn);
            _nextPageBtn = null;
         }
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_contributeTxt);
         _contributeTxt = null;
         ObjectUtils.disposeObject(_pvpIcon);
         _pvpIcon = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}

