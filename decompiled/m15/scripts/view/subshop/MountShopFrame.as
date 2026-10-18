package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MountsEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import managers.PlayerCurrencyManager;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MountShopFrame extends Frame implements IManualSize
   {
      
      private var _boardBack:ScaleBitmapImage;
      
      private var _displayShow:Image;
      
      private var _bottomBack:ScaleBitmapImage;
      
      private var _mountCoinTxt:FilterFrameText;
      
      private var _coinImage:Image;
      
      private var _coinTypeImage:Image;
      
      private var _coinStrip:StripView;
      
      private var _tipText:Bitmap;
      
      private var _listBtn:IconButton;
      
      private var _refreshBtn:IconButton;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _list:SimpleTileList;
      
      private var _itemList:Vector.<MountShopGoodsItem>;
      
      private var col:int = 3;
      
      private var refreshInfo:ConfigInfosTempInfo;
      
      private var mountCountInfo:ConfigInfosTempInfo;
      
      private var _data:Array;
      
      private var _lastClickTime:int = 0;
      
      public function MountShopFrame()
      {
         super();
         refreshInfo = TempleteManager.instance.getConfigInfoByConfigName("mount_shop_refresh_cost");
         mountCountInfo = TempleteManager.instance.getConfigInfoByConfigName("mount_shop_item_count");
         initView();
         addEvent();
         MountsManager.instance.mountOperateSend(8);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,800,610);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("view.subshop.MountShopFrame.title");
         _boardBack = ComponentFactory.Instance.creatComponentByStylename("mountShop.boardBack");
         _bottomBack = ComponentFactory.Instance.creatComponentByStylename("mountShop.bottomBack");
         _coinStrip = ComponentFactory.Instance.creatComponentByStylename("mountShopFrame.coinStrip");
         _displayShow = ComponentFactory.Instance.creatComponentByStylename("mountShop.ShopDisplayShow01");
         _mountCoinTxt = ComponentFactory.Instance.creatComponentByStylename("mountShopFrame.mountCoinTxt");
         _coinImage = ComponentFactory.Instance.creatComponentByStylename("mountShopFrame.mazeCoinImage");
         _coinTypeImage = ComponentFactory.Instance.creatComponentByStylename("mountShopFrame.priceIcon");
         _tipText = ComponentFactory.Instance.creatBitmap("asset.mountShopFrame.tipText");
         _listBtn = ComponentFactory.Instance.creatComponentByStylename("mountShopFrame.listBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("mountShopFrame.refreshBtn");
         _list = ComponentFactory.Instance.creatCustomObject("mountShopFrame.SimpleTileList",[col]);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("mountShopFrame.scrollPanel");
         addToContent(_boardBack);
         addToContent(_bottomBack);
         addToContent(_coinStrip);
         _coinStrip.addChild(_displayShow);
         _coinStrip.addChild(_mountCoinTxt);
         _coinStrip.addChild(_coinImage);
         _coinStrip.addChild(_coinTypeImage);
         addToContent(_tipText);
         addToContent(_listBtn);
         addToContent(_refreshBtn);
         addToContent(_scrollPanel);
         _scrollPanel.setView(_list);
         _scrollPanel.invalidateViewport();
         _coinStrip.tipData = LanguageMgr.GetTranslation("MountShopFrame._coinStrip.tipdata");
         _itemList = new Vector.<MountShopGoodsItem>();
         initGoodsListView();
      }
      
      private function addEvent() : void
      {
         MountsManager.instance.avatarList.addEventListener("mountShopInfoChange",__shopInfoUpdateHandler);
         addEventListener("response",__frameResponse);
         _listBtn.addEventListener("click",__goodsLinkHandler);
         _refreshBtn.addEventListener("click",__refreshGoodsHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateMountCoinCountHandler);
         MountsManager.instance.avatarList.addEventListener("mountListChange",__shopInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         MountsManager.instance.avatarList.removeEventListener("mountShopInfoChange",__shopInfoUpdateHandler);
         removeEventListener("response",__frameResponse);
         _listBtn.removeEventListener("click",__goodsLinkHandler);
         _refreshBtn.removeEventListener("click",__refreshGoodsHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateMountCoinCountHandler);
         MountsManager.instance.avatarList.removeEventListener("mountListChange",__shopInfoUpdateHandler);
      }
      
      private function __goodsLinkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.openMountPreviewFrame();
      }
      
      private function __refreshGoodsHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc4_:int = getTimer();
         if(_loc4_ - _lastClickTime < 400)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastClickTime = _loc4_;
         SoundManager.instance.play("022");
         var _loc3_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(_loc3_ >= parseInt(refreshInfo.ConfigValue))
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc5_ = LanguageMgr.GetTranslation("view.subshop.MountShopFrame.refresh.alertText",refreshInfo.ConfigValue);
            SharedManagerHelper.ins.needAlert("mounts.MountKingTrainView.refreshAlert",refreshResultHandler,_loc2_,_loc5_);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __updateMountCoinCountHandler(param1:NotificationEvent) : void
      {
         _mountCoinTxt.text = PlayerCurrencyManager.instance.currencyInfo.mountCoin.amount.toString();
      }
      
      private function refreshResultHandler() : void
      {
         MountsManager.instance.mountOperateSend(10,0,0,0,0);
      }
      
      private function __shopInfoUpdateHandler(param1:MountsEvent) : void
      {
         _data = MountsManager.instance.mountShopList;
         refreshView();
      }
      
      private function initGoodsListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MountShopGoodsItem = null;
         _loc2_ = 0;
         while(_loc2_ < parseInt(mountCountInfo.ConfigValue))
         {
            _loc1_ = new MountShopGoodsItem();
            _list.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _list.commitChanges();
         _scrollPanel.invalidateViewport();
         _list.beginChanges();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         _mountCoinTxt.text = PlayerCurrencyManager.instance.currencyInfo.mountCoin.amount.toString();
         _refreshBtn.tipData = LanguageMgr.GetTranslation("view.subshop.MountShopFrame.alertRefreshText",refreshInfo.ConfigValue);
         _refreshBtn.enable = false;
         if(_data && _data.length > 0)
         {
            _refreshBtn.enable = true;
         }
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].data = _loc1_ < _data.length ? _data[_loc1_] : null;
            _loc1_++;
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
         KeyBoardRegister.instance.keyEnable = true;
         if(_boardBack)
         {
            ObjectUtils.disposeObject(_boardBack);
         }
         _boardBack = null;
         if(_bottomBack)
         {
            ObjectUtils.disposeObject(_bottomBack);
         }
         _bottomBack = null;
         if(_coinStrip)
         {
            ObjectUtils.disposeObject(_coinStrip);
         }
         _coinStrip = null;
         if(_displayShow)
         {
            ObjectUtils.disposeObject(_displayShow);
         }
         _displayShow = null;
         if(_mountCoinTxt)
         {
            ObjectUtils.disposeObject(_mountCoinTxt);
         }
         _mountCoinTxt = null;
         if(_coinImage)
         {
            ObjectUtils.disposeObject(_coinImage);
         }
         _coinImage = null;
         if(_coinTypeImage)
         {
            ObjectUtils.disposeObject(_coinTypeImage);
         }
         _coinTypeImage = null;
         if(_tipText)
         {
            ObjectUtils.disposeObject(_tipText);
         }
         _tipText = null;
         if(_listBtn)
         {
            ObjectUtils.disposeObject(_listBtn);
         }
         _listBtn = null;
         if(_refreshBtn)
         {
            ObjectUtils.disposeObject(_refreshBtn);
         }
         _refreshBtn = null;
         if(_list)
         {
            _list.removeAllChild();
            ObjectUtils.disposeObject(_list);
            _list = null;
         }
         if(_itemList)
         {
            while(_itemList.length > 0)
            {
               _itemList.pop().dispose();
            }
            _itemList = null;
         }
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

