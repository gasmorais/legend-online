package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.AirGardenBedTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.PageBar;
   
   public class AirGardenShopFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _bg1:Bitmap;
      
      private var _back:ScaleBitmapImage;
      
      private var _displayShow:Bitmap;
      
      private var _propBtn:SelectedButton;
      
      private var _bedBtn:SelectedButton;
      
      private var _btGroup:SelectedButtonGroup;
      
      private var _pageBar:PageBar;
      
      private var _signButton:IconButton;
      
      private var _coinIcon:ScaleFrameImage;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _data:ShopModel;
      
      private var _propView:AirGardenShopPropView;
      
      private var _bedView:AirGardenShopBedView;
      
      private var pageCount:int = 9;
      
      public function AirGardenShopFrame()
      {
         super();
         initView();
         addEvent();
         _btGroup.selectIndex = 0;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _data = FrameControllerManager.instance.shopController.model;
         titleText = LanguageMgr.GetTranslation("AirGardenShopFrame.title.titleText");
         _propBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenShopFrame.propBtn");
         _bedBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenShopFrame.bedBtn");
         _bg = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _back = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _coinIcon = ComponentFactory.Instance.creatComponentByStylename("AirGardenShopFrame.coinIcon");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("AirGardenShopFrame.pageBar");
         addToContent(_bg1);
         _bg1.x = 10;
         _bg.y = 0;
         _bg1.y = 0;
         addToContent(_bg);
         _bg.scaleX = -1;
         _bg.x = 2 * _bg1.width + 10;
         addToContent(_back);
         addToContent(_propBtn);
         addToContent(_bedBtn);
         addToContent(_displayShow);
         _displayShow.x = 11;
         _displayShow.y = 426;
         addToContent(_signButton);
         addToContent(_pageBar);
         addToContent(_coinIcon);
         addToContent(_contributeTxt);
         _contributeTxt.x = 105;
         _btGroup = new SelectedButtonGroup();
         _btGroup.addSelectItem(_propBtn);
         _btGroup.addSelectItem(_bedBtn);
      }
      
      private function addEvent() : void
      {
         if(_btGroup)
         {
            _btGroup.addEventListener("change",__onTabBtnHandler);
         }
         addEventListener("response",__frameResponse);
         _pageBar.addEventListener("change",_pageChangeHandler);
         _signButton.addEventListener("click",__onSignClick);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateAmountHandler);
         MsgMan.addObserver("CAMPAIGN_DETAIL_UPDATE",this,__updateCampaignInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btGroup)
         {
            _btGroup.removeEventListener("change",__onTabBtnHandler);
         }
         if(_pageBar)
         {
            _pageBar.removeEventListener("change",_pageChangeHandler);
         }
         if(_signButton)
         {
            _signButton.removeEventListener("click",__onSignClick);
         }
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateAmountHandler);
         MsgMan.removeObserver("CAMPAIGN_DETAIL_UPDATE",this,__updateCampaignInfoHandler);
      }
      
      private function __updateCampaignInfoHandler(param1:String, param2:Object) : void
      {
         refreshListView(false);
      }
      
      private function __updateAmountHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         if(_btGroup.selectIndex == 0)
         {
            _contributeTxt.text = currencyInfo.airGardenPropCoin ? currencyInfo.airGardenPropCoin.amount.toString() : "0";
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-5000);
            _coinIcon.setFrame(1);
         }
         else
         {
            _contributeTxt.text = currencyInfo.airGardenBedCoin ? currencyInfo.airGardenBedCoin.amount.toString() : "0";
            _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-5100);
            _coinIcon.setFrame(2);
         }
         if(_loc1_)
         {
            _coinIcon.tipData = _loc1_.Description;
         }
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(int(_btGroup.selectIndex))
         {
            case 0:
               ObjectUtils.disposeObject(_bedView);
               _bedView = null;
               if(!_propView)
               {
                  _propView = ComponentFactory.Instance.creatCustomObject("AirGardenShopFrame.propView");
               }
               addToContent(_propView);
               break;
            case 1:
               ObjectUtils.disposeObject(_propView);
               _propView = null;
               if(!_bedView)
               {
                  _bedView = ComponentFactory.Instance.creatCustomObject("AirGardenShopFrame.bedView");
               }
               addToContent(_bedView);
         }
         refreshView();
         refreshListView(true);
      }
      
      private function _pageChangeHandler(param1:Event) : void
      {
         refreshListView(false);
      }
      
      private function refreshListView(param1:Boolean) : void
      {
         var _loc3_:Array = _btGroup.selectIndex == 0 ? propList : bedList;
         _pageBar.setAutoPagingData(_loc3_,pageCount);
         if(param1)
         {
            _pageBar.setCurPage(1);
         }
         var _loc2_:Array = _pageBar.getCurPageDatas();
         if(_propView)
         {
            _propView.refreshListView(_loc2_);
         }
         if(_bedView)
         {
            _bedView.refreshListView(_loc2_);
         }
      }
      
      private function get propList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in TempleteManager.instance.getAirGardenPropTemplateDic())
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         return _loc1_;
      }
      
      private function get bedList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:AirGardenBedTempInfo in TempleteManager.instance.airGardenBedTempCate.getTemplates())
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("TemplateId",16);
         return _loc1_;
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
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
      
      public function show(param1:Object = null) : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(param1 && _btGroup)
         {
            _btGroup.selectIndex = int(param1["type"]);
         }
      }
      
      private function get currencyInfo() : PlayerCurrencyInfo
      {
         return PlayerCurrencyManager.instance.currencyInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_displayShow);
         _displayShow = null;
         ObjectUtils.disposeObject(_signButton);
         _signButton = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeObject(_contributeTxt);
         _contributeTxt = null;
         ObjectUtils.disposeObject(_propBtn);
         _propBtn = null;
         ObjectUtils.disposeObject(_bedBtn);
         _bedBtn = null;
         ObjectUtils.disposeObject(_propView);
         _propView = null;
         ObjectUtils.disposeObject(_bedView);
         _bedView = null;
         ObjectUtils.disposeAllChildren(this);
         KeyBoardRegister.instance.keyEnable = true;
         super.dispose();
      }
   }
}

