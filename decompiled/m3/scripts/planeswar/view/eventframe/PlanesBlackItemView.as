package planeswar.view.eventframe
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.view.community.BaseItemView;
   
   public class PlanesBlackItemView extends Component
   {
      
      private var back:MutipleImage;
      
      private var goodItem:BaseItemView;
      
      private var discountText:FilterFrameText;
      
      private var priceText:FilterFrameText;
      
      private var buyBtn:IconButton;
      
      private var _dataArr:Array;
      
      public var index:int;
      
      private var price:int;
      
      public function PlanesBlackItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("planesBlackItem.back");
         discountText = ComponentFactory.Instance.creatComponentByStylename("planesBlackItem.discountText");
         priceText = ComponentFactory.Instance.creatComponentByStylename("planesBlackItem.priceText");
         buyBtn = ComponentFactory.Instance.creatComponentByStylename("planesBlackItem.buyBtn");
         goodItem = ComponentFactory.Instance.creatCustomObject("planesBlackItem.goodsItem");
         addChild(back);
         addChild(goodItem);
         addChild(priceText);
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
         SharedManagerHelper.ins.needAlert("PlanesBlackItemView.buyGoods.alert",buyGoodsResuletHandler,_loc2_,_loc3_);
      }
      
      private function buyGoodsResuletHandler() : void
      {
         PlanesWarManager.instance.sendPlanesOpMsg(4,[index]);
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
         discountText.text = _dataArr[3].toString();
         price = _dataArr[2] * _dataArr[3] / 100;
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
         super.dispose();
      }
   }
}

