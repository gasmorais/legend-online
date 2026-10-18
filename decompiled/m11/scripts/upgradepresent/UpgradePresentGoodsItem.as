package upgradepresent
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.upgradepresent.UpgradePresentInfo;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.CommonBoxDropTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.manager.UpgradePresentManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class UpgradePresentGoodsItem extends Component
   {
      
      private var _back:ScaleFrameImage;
      
      private var _hbox1:HBox;
      
      private var _hbox2:HBox;
      
      private var _buyBtn:IconButton;
      
      private var _costItem:TextAddBitmap;
      
      private var _buyCountText:FilterFrameText;
      
      private var _data:UpgradePresentInfo;
      
      private var index:int;
      
      private var parentCount:int;
      
      private var boughtCount:int;
      
      private var limitCount:int;
      
      private var shopId:int;
      
      private var shopInfo:ShopGoodsInfo;
      
      public function UpgradePresentGoodsItem(param1:int, param2:int)
      {
         super();
         index = param1;
         parentCount = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("UpgradePresentGoodsItem.back");
         _hbox1 = ComponentFactory.Instance.creatComponentByStylename("UpgradePresentGoodsItem.hbox1");
         _hbox2 = ComponentFactory.Instance.creatComponentByStylename("UpgradePresentGoodsItem.hbox2");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("UpgradePresentGoodsItem.buyBtn");
         _buyCountText = ComponentFactory.Instance.creatComponentByStylename("UpgradePresentGoodsItem.buyCountText");
         _costItem = new TextAddBitmap();
         _costItem.initView("UpgradePresentGoodsItem.costPointText","asset.core.SmallPointImg","left");
         addChild(_back);
         _back.setFrame(parentCount);
         addChild(_hbox1);
         addChild(_hbox2);
         addChild(_buyBtn);
         _buyBtn.addChild(_costItem);
         _costItem.x = 20;
         _costItem.y = 8;
         _buyBtn.addChild(_buyCountText);
         this.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _buyBtn.addEventListener("click",_buyBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",_buyBtnClickHandler);
         }
      }
      
      private function _buyBtnClickHandler(param1:MouseEvent) : void
      {
         if(data.isExpire)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("UpgradePresentFrame.expire.alert"));
            return;
         }
         var _loc7_:int = limitCount - boughtCount;
         var _loc4_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(shopInfo.ItemId).TemplateName;
         SimpleAlertHelper.instance.data = [buyResultHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("UpgradePresentGoodsItem.buyGoods.alert",shopInfo.price,_loc4_,_loc7_,limitCount);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true,true,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
      }
      
      private function buyResultHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(shopInfo.price,false))
         {
            return;
         }
         UpgradePresentManager.instance.sendUpgradePresentBuy(shopId);
      }
      
      public function get data() : UpgradePresentInfo
      {
         return _data;
      }
      
      public function set data(param1:UpgradePresentInfo) : void
      {
         var _loc5_:String = null;
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         boughtCount = data.boughtCountArr[index];
         limitCount = data.limitCountArr[index];
         _buyBtn.enable = boughtCount < limitCount;
         var _loc6_:int = limitCount - boughtCount;
         _buyCountText.text = LanguageMgr.GetTranslation("public.numPrecent",_loc6_,limitCount);
         shopId = data.shopIdArr[index];
         shopInfo = TempleteManager.instance.getUpgradePresentShopTemplateDic()[shopId];
         if(playerInfo.point >= shopInfo.price)
         {
            _loc5_ = LanguageMgr.GetTranslation("UpgradePresentGoodsItem.btnCost.text1",shopInfo.price);
         }
         else
         {
            _loc5_ = LanguageMgr.GetTranslation("UpgradePresentGoodsItem.btnCost.text2",shopInfo.price);
         }
         _costItem.setText(_loc5_,true);
         var _loc2_:Array = data.rewardArr[index];
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = Math.ceil(_loc3_ / 2);
         createHboxView(_loc4_,_loc2_.slice(0,_loc4_),_hbox1);
         createHboxView(_loc3_ - _loc4_,_loc2_.slice(_loc4_,_loc3_),_hbox2);
      }
      
      private function createHboxView(param1:int, param2:Array, param3:HBox) : void
      {
         var _loc4_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc7_:CommonBoxDropTempInfo = null;
         ObjectUtils.disposeAllChildren(param3);
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param1)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("UpgradePresentGoodsItem.item");
            _loc6_ = new GoodsInfo();
            _loc7_ = param2[_loc5_];
            _loc6_.templateId = _loc7_.ItemTempId;
            _loc6_.count = _loc7_.Count;
            _loc4_.data = _loc6_;
            param3.addChild(_loc4_);
            _loc5_++;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_hbox1);
         _hbox1 = null;
         ObjectUtils.disposeObject(_hbox2);
         _hbox2 = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_costItem);
         _costItem = null;
         ObjectUtils.disposeObject(_buyCountText);
         _buyCountText = null;
         super.dispose();
      }
   }
}

