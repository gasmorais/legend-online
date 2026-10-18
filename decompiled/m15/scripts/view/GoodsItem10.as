package view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.bingo.BingoBuyInfoMsg;
   import com.road.yishi.proto.bingo.BingoCardTempMsg;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.BingoManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.NumberViewUtils;
   import yishi.view.frame.BingoBuyFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class GoodsItem10 extends Sprite implements Disposeable
   {
      
      protected var _bg:ScaleFrameImage;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _valueTxt:FilterFrameText;
      
      protected var _goods:Component;
      
      protected var _rankBmp:Image;
      
      protected var _buyBtn:IconButton;
      
      protected var _tips:FilterFrameText;
      
      protected var _lineImg:ScaleFrameImage;
      
      protected var _data:BingoCardTempMsg;
      
      protected var _filter:IFilterFormat;
      
      protected var _canTotalText:FilterFrameText;
      
      protected var _cardAsset:BitmapData;
      
      public function GoodsItem10()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsNameTextStyle");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemContributeTxtImg");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemBuyBtn");
         _canTotalText = ComponentFactory.Instance.creatComponentByStylename("shop.bingo.buyCanTotalTxt");
         _rankBmp = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsItem10.rankNumBmp");
         _cardAsset = ComponentFactory.Instance.creatBitmapData("asset.shop.rankNumAsset");
         _goods = new Component();
         _bg.setFrame(1);
         addChild(_bg);
         addChild(_lineImg);
         addChild(_nameTxt);
         addChild(_tips);
         addChild(_valueTxt);
         addChild(_buyBtn);
         addChild(_rankBmp);
         addChild(_goods);
         addChild(_canTotalText);
         _goods.mouseEnabled = _goods.mouseChildren = false;
      }
      
      protected function addEvent() : void
      {
         this.addEventListener("click",__clickHandler);
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         NotificationManager.instance.addEventListener("BALL_BUY",__refreshHandler);
      }
      
      protected function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         NotificationManager.instance.removeEventListener("BALL_BUY",__refreshHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BingoBuyInfoMsg = null;
         if(param1.target == _buyBtn)
         {
            _loc2_ = BingoManager.instance.buyInfo;
            if(_loc2_ && _loc2_.detail.length >= 4)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.GoodsItem10.hasBuyEnough"));
               return;
            }
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:BingoBuyFrame = ComponentFactory.Instance.creatComponentByStylename("bingo.buyFrame");
         _loc1_.data(_data);
         _loc1_.show();
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.setFrame(2);
         }
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __refreshHandler(param1:NotificationEvent) : void
      {
         setHasOwn();
      }
      
      public function get data() : BingoCardTempMsg
      {
         return _data;
      }
      
      public function set data(param1:BingoCardTempMsg) : void
      {
         _data = param1;
         if(param1)
         {
            addEvent();
            setHasOwn();
            _nameTxt.text = getName();
            _valueTxt.text = String(ConfigInfoManager.instance.getBingoBuy()[0]);
            _nameTxt.visible = true;
            _valueTxt.visible = true;
            _buyBtn.visible = true;
            _lineImg.visible = true;
            _rankBmp.visible = true;
            _goods.visible = true;
            _canTotalText.visible = true;
            _rankBmp.tipData = _data;
            setFilter();
         }
         else
         {
            clean();
            removeEvent();
         }
      }
      
      public function setHasOwn(param1:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Array = BingoManager.instance.globalBuyArr;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            if(_data.cardId == _loc2_[_loc5_].cardId)
            {
               _loc4_ = int(_loc2_[_loc5_].amount);
               break;
            }
            _loc5_++;
         }
         _canTotalText.htmlText = LanguageMgr.GetTranslation("view.GoodsItem10.hasSoldTxt",_loc4_);
         var _loc6_:Boolean = false;
         var _loc3_:BingoBuyInfoMsg = BingoManager.instance.buyInfo;
         if(_loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.detail.length)
            {
               if(_loc3_.detail[_loc5_].cardId == _data.cardId)
               {
                  _loc6_ = true;
               }
               _loc5_++;
            }
         }
         _buyBtn.enable = !_loc6_;
      }
      
      protected function setFilter() : void
      {
         _lineImg.setFrame(1);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function getName() : String
      {
         var _loc1_:int = int(_data.cardId);
         NumberViewUtils.refreshValue(_loc1_,_goods,_cardAsset,21,29,18,21,"0123456789");
         _goods.x = _rankBmp.x + (_rankBmp.width - _goods.displayWidth) / 2 - 2;
         _goods.y = 29;
         return LanguageMgr.GetTranslation("view.GoodsItem10.titleTxt",_data.cardId);
      }
      
      protected function clean() : void
      {
         _nameTxt.visible = false;
         _valueTxt.visible = false;
         _buyBtn.visible = false;
         _lineImg.visible = false;
         _rankBmp.visible = false;
         _goods.visible = false;
         _tips.text = "";
         _canTotalText.visible = false;
         _rankBmp.tipData = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

