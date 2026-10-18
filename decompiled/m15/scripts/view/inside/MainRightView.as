package view.inside
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.MysteryShopManager;
   import managers.ShopManager;
   import mvc.module.auction.MysteryShopModel;
   import mvc.module.shop.MainShopInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class MainRightView extends Sprite implements Disposeable
   {
      
      private var _bgHomepageRightBack:Bitmap;
      
      private var _dayGift:Bitmap;
      
      private var _consumeGift:Image;
      
      private var _mysteryShop:IconButton;
      
      private var _shopItem:ShopTimeItem;
      
      private var _goodList:Array;
      
      private var _boxArr:Array;
      
      private var b:Boolean = true;
      
      private var _mainRightTime:Timer;
      
      private var remainTime:Number;
      
      public function MainRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc3_:int = 0;
         _bgHomepageRightBack = ComponentFactory.Instance.creatBitmap("asset.shop.HomepageRightBackImg");
         _dayGift = ComponentFactory.Instance.creatBitmap("asset.shop.daygift");
         _consumeGift = ComponentFactory.Instance.creatComponentByStylename("shop.consumegif");
         _mysteryShop = ComponentFactory.Instance.creatComponentByStylename("shop.mysteryShopBtn");
         _shopItem = ComponentFactory.Instance.creatCustomObject("shop.shoptimeitem");
         _goodList = [];
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = new BaseItemView();
            _loc2_.x = _loc1_ * (_loc2_.width + 10) + 20;
            _loc2_.y = 30;
            addChild(_loc2_);
            _goodList.push(_loc2_);
            _loc1_++;
         }
         _boxArr = [];
         addChild(_bgHomepageRightBack);
         addChild(_dayGift);
         addChild(_consumeGift);
         _consumeGift.tipData = LanguageMgr.GetTranslation("shop.dayCost.alertData");
         addChild(_mysteryShop);
         addChild(_shopItem);
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            _boxArr[_loc3_] = ComponentFactory.Instance.creatCustomObject("shop.ShopGiftBoxView");
            _boxArr[_loc3_].x = 487 + 85 * _loc3_;
            _boxArr[_loc3_].y = 348;
            addChild(_boxArr[_loc3_]);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         _mysteryShop.addEventListener("click",__onMysteryHandler);
         NotificationManager.instance.addEventListener("SHOPHOMEPAGE_UPDATA",updateView);
      }
      
      private function removeEvent() : void
      {
         _mysteryShop.removeEventListener("click",__onMysteryHandler);
         NotificationManager.instance.removeEventListener("SHOPHOMEPAGE_UPDATA",updateView);
      }
      
      private function __onMysteryHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(ArmyManager.instance.thane.grades < 26)
         {
            _loc2_ = LanguageMgr.GetTranslation("auction.view.supermarket.MysteryShopView.gradesTipData");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("outercityshop");
      }
      
      private function get mysteryShopModel() : MysteryShopModel
      {
         return MysteryShopManager.instance.model;
      }
      
      private function get mysteryShopManager() : MysteryShopManager
      {
         return MysteryShopManager.instance;
      }
      
      public function updateView(param1:NotificationEvent = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = ShopManager.Instance.model.getPromotionalGoodsList();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].type == 4)
            {
               _shopItem.data = _loc2_[_loc3_] as MainShopInfo;
            }
            updateBox(_loc2_);
            _loc3_++;
         }
         if(_shopItem && _mainRightTime == null)
         {
            addTimer();
         }
      }
      
      private function updateShopItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = ShopManager.Instance.model.getPromotionalGoodsList();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].type == 4)
            {
               _shopItem.data = _loc1_[0] as MainShopInfo;
            }
            _loc2_++;
         }
      }
      
      private function updateBox(param1:Array) : void
      {
         var _loc2_:int = 0;
         param1 = ShopManager.Instance.model.getPromotionalGoodsList();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].type == 5)
            {
               _boxArr[0].updateView(param1[_loc2_]);
            }
            else if(param1[_loc2_].type == 6)
            {
               _boxArr[1].updateView(param1[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      private function addTimer() : void
      {
         _mainRightTime = new Timer(1000);
         _mainRightTime.addEventListener("timer",__updateTimeHandler);
         _mainRightTime.start();
      }
      
      private function removeTimer() : void
      {
         if(_mainRightTime)
         {
            _mainRightTime.stop();
            _mainRightTime.removeEventListener("timer",__updateTimeHandler);
            _mainRightTime = null;
         }
      }
      
      private function __updateTimeHandler(param1:TimerEvent) : void
      {
         try
         {
            if(_shopItem.data)
            {
               remainTime = _shopItem.data.remainTime;
            }
            else
            {
               _shopItem.data = null;
               updateShopItem();
            }
            if(_shopItem.data && _shopItem.data.type == 4)
            {
               if(remainTime > 0)
               {
                  _shopItem.timeText = remainTime;
                  b = true;
               }
               else if(b)
               {
                  b = false;
                  ShopManager.Instance.refreshTimeGoods();
                  ShopManager.Instance.refreshGoodsCount();
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         removeTimer();
         if(_boxArr)
         {
            _loc1_ = 0;
            while(_loc1_ < _boxArr.length)
            {
               _boxArr[_loc1_].dispose();
               _loc1_++;
            }
            _boxArr = [];
         }
         if(_bgHomepageRightBack)
         {
            _bgHomepageRightBack = null;
         }
         if(_mysteryShop)
         {
            _bgHomepageRightBack = null;
         }
         if(_shopItem)
         {
            _shopItem = null;
         }
         if(_dayGift)
         {
            _dayGift = null;
         }
         if(_consumeGift)
         {
            _consumeGift = null;
         }
         ObjectUtils.disposeObject(_bgHomepageRightBack);
         _bgHomepageRightBack = null;
         ObjectUtils.disposeObject(_mysteryShop);
         _mysteryShop = null;
         ObjectUtils.disposeObject(_shopItem);
         _shopItem = null;
         ObjectUtils.disposeObject(_dayGift);
         _dayGift = null;
         ObjectUtils.disposeObject(_consumeGift);
         _consumeGift = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

