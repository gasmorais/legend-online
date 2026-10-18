package view.inside
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.shop.ShopModel;
   import mvc.module.vip.VIPModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.view.tips.MessageTipManager;
   
   public class ShopInsideView extends Sprite implements Disposeable
   {
      
      private var _bg1:ScaleBitmapImage;
      
      private var _prePage:IconButton;
      
      private var _nextPage:IconButton;
      
      private var _recharge:IconButton;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _itemListView:MainGoodsListView;
      
      private var _sexwoman:Bitmap;
      
      private var _giftTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _data:ShopModel;
      
      private var _linkTxt:FilterFrameText;
      
      private var _linkInfoTxt:FilterFrameText;
      
      private var _preVipLevel:int;
      
      private var _pageNumBg:Bitmap;
      
      public var state:String;
      
      private var _boxMc:MovieClip;
      
      private var _fireMc:MovieClip;
      
      public function ShopInsideView(param1:String)
      {
         super();
         this.state = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _data = FrameControllerManager.instance.shopController.model;
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("shop.Back1");
         _nextPage = ComponentFactory.Instance.creatComponentByStylename("shop.NextPageBtn");
         _prePage = ComponentFactory.Instance.creatComponentByStylename("shop.LastPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PageTextStyle1");
         _recharge = ComponentFactory.Instance.creatComponentByStylename("shop.ChargeBtn");
         _giftTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GiftTextStyle1");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PointTextStyle1");
         _sexwoman = ComponentFactory.Instance.creatBitmap("asset.shop.sexwoman");
         _pageNumBg = ComponentFactory.Instance.creatBitmap("asset.shop.pageNumBg");
         _boxMc = ComponentFactory.Instance.creatCustomObject("shop.boxMc");
         _fireMc = ComponentFactory.Instance.creatCustomObject("shop.fireMc");
         _itemListView = new MainGoodsListView(state);
         _itemListView.y = -6;
         addChild(_sexwoman);
         addChild(_boxMc);
         addChild(_fireMc);
         addChild(_bg1);
         addChild(_itemListView);
         addChild(_pageNumBg);
         addChild(_prePage);
         addChild(_nextPage);
         addChild(_pageNumTxt);
         addChild(_recharge);
         addChild(_giftTxt);
         _giftTxt.y = 465;
         addChild(_pointTxt);
         _pointTxt.y = 465;
         _prePage.enable = false;
         _pageNumTxt.text = "";
         _giftTxt.text = playerInfo.giftToken1 + "";
         _pointTxt.text = playerInfo.point + "";
         _boxMc.gotoAndPlay(1);
         _fireMc.gotoAndPlay(1);
      }
      
      private function initEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("GOODS_LIST_UPDATE",__onListUpdateHandler);
         }
         if(_data)
         {
            _data.addEventListener("PAGE_UPDATE",__onPageUpdateHandler);
         }
         _prePage.addEventListener("click",__onPageBtnHandler);
         _nextPage.addEventListener("click",__onPageBtnHandler);
         _recharge.addEventListener("click",__onRechargeHandler);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         if(_linkInfoTxt)
         {
            _linkInfoTxt.addEventListener("click",__onInfoHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("GOODS_LIST_UPDATE",__onListUpdateHandler);
         }
         if(_data)
         {
            _data.removeEventListener("PAGE_UPDATE",__onPageUpdateHandler);
         }
         _prePage.removeEventListener("click",__onPageBtnHandler);
         _nextPage.removeEventListener("click",__onPageBtnHandler);
         _recharge.removeEventListener("click",__onRechargeHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         if(_linkInfoTxt)
         {
            _linkInfoTxt.removeEventListener("click",__onInfoHandler);
         }
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePage);
      }
      
      private function __onRechargeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __onPageUpdateHandler(param1:ShopEvent) : void
      {
         _pageNumTxt.text = _data.currentPage + "/" + _data.totalPage;
         _prePage.enable = _data.currentPage != 1;
         _nextPage.enable = _data.currentPage != _data.totalPage;
      }
      
      private function __onListUpdateHandler(param1:ShopEvent) : void
      {
         _itemListView.showList(_data.showGoodsList);
      }
      
      private function __refreshPlayerInfoHandler(param1:Event) : void
      {
         _pointTxt.text = playerInfo.point + "";
         _giftTxt.text = playerInfo.giftToken1 + "";
         if(vipModel.vipInfo.VipGrade)
         {
            if(_linkInfoTxt)
            {
               _linkInfoTxt.visible = false;
            }
            if(_linkTxt)
            {
               _linkTxt.visible = false;
            }
         }
         if(vipModel.vipInfo.VipGrade != _preVipLevel && !"SHOP_MAIN")
         {
            _preVipLevel = vipModel.vipInfo.VipGrade;
            FrameControllerManager.instance.shopController.setCurrentGoodsList(_data.currentGoodsList,9,false);
         }
         _itemListView.update();
      }
      
      private function __onInfoHandler(param1:Event) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("shop.view.ShopFrame.command01");
         MessageTipManager.instance().show(_loc2_);
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _data = null;
         if(_itemListView)
         {
            _itemListView.dispose();
         }
         _itemListView = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_prePage);
         _prePage = null;
         ObjectUtils.disposeObject(_nextPage);
         _nextPage = null;
         ObjectUtils.disposeObject(_recharge);
         _recharge = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_sexwoman);
         _sexwoman = null;
         ObjectUtils.disposeViolentMc(_boxMc);
         _boxMc = null;
         ObjectUtils.disposeViolentMc(_fireMc);
         _fireMc = null;
         ObjectUtils.disposeObject(_giftTxt);
         _giftTxt = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_linkTxt);
         _linkTxt = null;
         ObjectUtils.disposeObject(_linkInfoTxt);
         _linkInfoTxt = null;
         ObjectUtils.disposeObject(_pageNumBg);
         _pageNumBg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

