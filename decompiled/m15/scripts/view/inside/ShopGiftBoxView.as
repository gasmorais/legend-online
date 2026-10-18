package view.inside
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.shop.BuyInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.MainShopInfo;
   import mvc.module.shop.ShopModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ShopGiftBoxView extends BaseItemView implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _getedBitmap:Bitmap;
      
      private var _light:MovieClip;
      
      private var _boxIndex:int;
      
      private var _giftArr:Array = [];
      
      private var _giftId:int;
      
      private var _data:MainShopInfo;
      
      private var _lastClickTime:int = 0;
      
      public function ShopGiftBoxView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _getedBitmap = ComponentFactory.Instance.creatBitmap("asset.shop.IntergalBoxGeted");
         _light = ComponentFactory.Instance.creatCustomObject("shop.GemBoxLight");
         _light.effect_01.stop();
         _light.mouseChildren = _light.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("SHOP_TIME_GIFT_REFRESH",shopTimeGiftRefresh);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SHOP_TIME_GIFT_REFRESH",shopTimeGiftRefresh);
      }
      
      private function shopTimeGiftRefresh(param1:NotificationEvent) : void
      {
         var _loc2_:BuyInfo = param1.data as BuyInfo;
         if(_loc2_ && _data && _giftId == _loc2_.goodId && _data.type == _loc2_.type)
         {
            isDisable(_loc2_.count);
         }
      }
      
      private function isDisable(param1:int = 0) : void
      {
         if(!_data)
         {
            return;
         }
         var _loc2_:int = int(_data.canOneCount);
         if(param1 > 1)
         {
            _loc2_ = _data.oneDayCount - param1;
         }
         if(_loc2_ <= 0)
         {
            if(this.contains(_light))
            {
               removeChild(_light);
            }
            addChild(_getedBitmap);
            this.filters = [UIFilter.getGrayFilter()];
            this.removeEventListener("click",onClick);
         }
      }
      
      public function updateView(param1:MainShopInfo) : void
      {
         var _loc2_:String = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc5_:Object = null;
         _boxIndex = param1.templateId;
         _giftId = param1.id;
         _data = param1;
         ShopManager.Instance.getGoodsBuyNum(_data.id,_data.type);
         setId(_boxIndex);
         this.buttonMode = false;
         if(param1)
         {
            if(_data.isGift)
            {
               this.icon.icon = PathManager.info.REQUEST_PATH + _data.url;
               _loc2_ = _data.content;
               _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
               if(_loc4_ && _loc4_.SonType == 206)
               {
                  _loc2_ += "<br/><font color=\'#00ff00\'>" + _loc4_.Description + "</font>";
               }
               _loc5_ = {
                  "name":_data.names,
                  "content":_loc2_
               };
               this.icon.tipData = _loc5_;
               this.icon.tipStyle = "yishi.view.tips.ShopMainTips";
            }
            else
            {
               _data = param1;
            }
         }
         var _loc3_:Boolean = Boolean(PlayerManager.instance.currentPlayerModel.playerInfo.isCost);
         this.removeEventListener("click",onClick);
         if(param1.type == 6 && _loc3_)
         {
            this.filters = [];
            this.buttonMode = true;
            this.buttonMode = false;
            addChild(_light);
            _light.effect_01.gotoAndPlay(1);
            this.addEventListener("click",onClick);
         }
         if(param1.type == 5)
         {
            this.filters = [];
            this.buttonMode = true;
            addChild(_light);
            _light.effect_01.gotoAndPlay(1);
            this.addEventListener("click",onClick);
         }
         isDisable();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastClickTime < 400)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastClickTime = _loc2_;
         ShopManager.Instance.getGift(_giftId);
         ShopManager.Instance.getGoodsBuyNum(_data.id,_data.type);
      }
      
      private function setId(param1:int) : void
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = param1;
         this.data = _loc2_;
      }
      
      private function get model() : ShopModel
      {
         return ShopManager.Instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         if(_data)
         {
            _data = null;
         }
         _light.effect_01.stop();
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_getedBitmap);
         _getedBitmap = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

