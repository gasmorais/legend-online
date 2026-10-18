package secretadventure.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.secret.SecretEventInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.view.community.BaseItemView;
   
   public class SecretShopItem extends Component
   {
      
      private var back:MutipleImage;
      
      private var goodItem:BaseItemView;
      
      private var discountText:FilterFrameText;
      
      private var oldPriceTxt:FilterFrameText;
      
      private var oldPriceBit:Image;
      
      private var oldLine:Shape;
      
      private var priceText:FilterFrameText;
      
      private var priceBit:Image;
      
      private var buyBtn:IconButton;
      
      private var _dataArr:Array;
      
      public var index:int;
      
      private var price:int;
      
      public var eventInfo:SecretEventInfo;
      
      public function SecretShopItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("secret.shopf.back");
         discountText = ComponentFactory.Instance.creatComponentByStylename("secret.shopf.discountText");
         priceText = ComponentFactory.Instance.creatComponentByStylename("planesBlackItem.priceText");
         priceBit = ComponentFactory.Instance.creatComponentByStylename("secret.shopf.priceIcon");
         oldPriceTxt = ComponentFactory.Instance.creatComponentByStylename("secret.shopf.OldpriceText");
         oldPriceBit = ComponentFactory.Instance.creatComponentByStylename("secret.shopf.OldpriceIcon");
         buyBtn = ComponentFactory.Instance.creatComponentByStylename("planesBlackItem.buyBtn");
         goodItem = ComponentFactory.Instance.creatCustomObject("planesBlackItem.goodsItem");
         oldLine = new Shape();
         oldLine.graphics.lineStyle(2,10066329);
         oldLine.graphics.moveTo(0,0);
         oldLine.graphics.lineTo(80,16);
         oldLine.x = 81;
         oldLine.y = 52;
         addChild(back);
         addChild(goodItem);
         addChild(priceText);
         addChild(priceBit);
         addChild(oldPriceTxt);
         addChild(oldPriceBit);
         addChild(oldLine);
         addChild(discountText);
         addChild(buyBtn);
      }
      
      private function addEvent() : void
      {
         buyBtn.addEventListener("click",__buyClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(buyBtn)
         {
            buyBtn.removeEventListener("click",__buyClickHandler);
         }
      }
      
      private function __buyClickHandler(param1:MouseEvent) : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < price)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("dungeonexplore.view.DungeonExploreBlackFrame.buyTips",price);
         SharedManagerHelper.ins.needAlert("SecretItemView.buyGoods.alert",buyGoodsResuletHandler,_loc2_,_loc3_);
      }
      
      private function buyGoodsResuletHandler() : void
      {
         SecretAdventerManager.Instance.opBuy(eventInfo.mapDataId,eventInfo.nodeId,index);
      }
      
      public function set dataArr(param1:Array) : void
      {
         _dataArr = param1;
         if(!_dataArr || _dataArr.length <= 0)
         {
            return;
         }
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _dataArr[0];
         _loc2_.count = _dataArr[1];
         goodItem.data = _loc2_;
         priceText.text = (int(_dataArr[2] * _dataArr[3] / 100)).toString();
         oldPriceTxt.text = "" + _dataArr[2];
         discountText.text = _dataArr[3].toString();
         price = _dataArr[2] * _dataArr[3] / 100;
         isCanBuy = int(_dataArr[4]) == 1 ? false : true;
      }
      
      public function set isCanBuy(param1:Boolean) : void
      {
         buyBtn.enable = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(goodItem)
         {
            ObjectUtils.disposeObject(goodItem);
         }
         goodItem = null;
         if(discountText)
         {
            ObjectUtils.disposeObject(discountText);
         }
         discountText = null;
         if(priceText)
         {
            ObjectUtils.disposeObject(priceText);
         }
         priceText = null;
         if(buyBtn)
         {
            ObjectUtils.disposeObject(buyBtn);
         }
         buyBtn = null;
         if(priceBit)
         {
            ObjectUtils.disposeObject(priceBit);
         }
         priceBit = null;
         if(oldPriceTxt)
         {
            ObjectUtils.disposeObject(oldPriceTxt);
         }
         oldPriceTxt = null;
         if(oldPriceBit)
         {
            ObjectUtils.disposeObject(oldPriceBit);
         }
         oldPriceBit = null;
         super.dispose();
         eventInfo = null;
      }
   }
}

