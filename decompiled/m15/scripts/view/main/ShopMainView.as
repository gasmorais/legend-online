package view.main
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import managers.MysteryShopManager;
   import mvc.module.auction.MysteryShopModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class ShopMainView extends Sprite
   {
      
      private var _bgHomepage:ScaleBitmapImage;
      
      private var _bgHomepageBack:Bitmap;
      
      private var _bgHomepageRightBack:Bitmap;
      
      private var _homepageRight:HomepageRightView;
      
      private var _homepageNew:HomepageNewView;
      
      private var _homepageTop:HomepageTopView;
      
      private var _recharge:IconButton;
      
      private var _giftTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _pointBg:MutipleImage;
      
      private var _giftBg:MutipleImage;
      
      public function ShopMainView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgHomepage = ComponentFactory.Instance.creatComponentByStylename("shop.HomepageBack");
         _bgHomepageBack = ComponentFactory.Instance.creatBitmap("asset.shop.HomepageBackImg");
         _bgHomepageRightBack = ComponentFactory.Instance.creatBitmap("asset.shop.HomepageRightBackImg");
         _recharge = ComponentFactory.Instance.creatComponentByStylename("shop.ChargeBtn");
         _pointBg = ComponentFactory.Instance.creatComponentByStylename("shop.pointImage");
         _giftBg = ComponentFactory.Instance.creatComponentByStylename("shop.giftImage");
         _giftTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GiftTextStyle1");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PointTextStyle1");
         _homepageTop = new HomepageTopView();
         _homepageNew = new HomepageNewView();
         _homepageRight = new HomepageRightView();
         addChild(_bgHomepage);
         addChild(_bgHomepageBack);
         addChild(_bgHomepageRightBack);
         addChild(_recharge);
         addChild(_pointBg);
         addChild(_giftBg);
         addChild(_giftTxt);
         addChild(_pointTxt);
         addChild(_homepageRight);
         addChild(_homepageNew);
         addChild(_homepageTop);
         _recharge.x = 511;
         _recharge.y = 439;
         _giftTxt.x = 357;
         _giftTxt.y = 462;
         _pointTxt.x = 115;
         _pointTxt.y = 462;
         _pointBg.x = 33;
         _pointBg.y = 456;
         _giftBg.x = 277;
         _giftBg.y = 456;
         _pointTxt.text = playerInfo.point + "";
         _giftTxt.text = playerInfo.giftToken + "";
      }
      
      private function initEvent() : void
      {
         _recharge.addEventListener("click",__onRechargeHandler);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
      }
      
      private function removeEvent() : void
      {
         _recharge.removeEventListener("click",__onRechargeHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
      }
      
      private function __refreshPlayerInfoHandler(param1:Event) : void
      {
         _pointTxt.text = playerInfo.point + "";
         _giftTxt.text = playerInfo.giftToken + "";
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __onRechargeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function get mysteryShopModel() : MysteryShopModel
      {
         return MysteryShopManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_homepageRight)
         {
            _homepageRight.dispose();
         }
         if(_homepageNew)
         {
            _homepageNew.dispose();
         }
         if(_homepageTop)
         {
            _homepageTop.dispose();
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

