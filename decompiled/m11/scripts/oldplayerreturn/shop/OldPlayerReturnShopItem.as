package oldplayerreturn.shop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OldPlayerReturnShopTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class OldPlayerReturnShopItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _buyBtn:IconButton;
      
      private var _goods:BaseItemView;
      
      private var _limitedTxt:FilterFrameText;
      
      private var _data:OldPlayerReturnShopTempInfo;
      
      private var _limit:int = 0;
      
      private var _goodsTempInfo:GoodsTemplateInfo;
      
      public function OldPlayerReturnShopItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsItemBg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnTaskItem.icon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsNameTextStyle");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemBuyBtn");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.ItemBaseItemView");
         _limitedTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsLimitedTextStyle");
         addChild(_bg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_valueTxt);
         addChild(_buyBtn);
         addChild(_goods);
         addChild(_limitedTxt);
         _icon.x = 195;
         _icon.y = 50;
         _nameTxt.text = "";
         _valueTxt.text = "";
         _buyBtn.visible = false;
         _icon.visible = false;
         _goods.data = null;
         _limitedTxt.text = "";
         _bg.setFrame(1);
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         _buyBtn.removeEventListener("click",__buyBtnClickHandler);
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(_limit == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.utils.ShopingHelper.command06"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("oldplayerreturn",4,_data);
      }
      
      private function buyCallBack() : void
      {
         OldPlayerReturnManager.instance.send(7,_data.Id,1);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.setFrame(2);
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      public function set data(param1:OldPlayerReturnShopTempInfo) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         _data = param1;
         if(_data)
         {
            addEvent();
            _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.CommodityId);
            if(_goodsTempInfo)
            {
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _data.CommodityId;
               _loc5_.count = _data.CommodityAmount;
               _goods.data = _loc5_;
               _nameTxt.text = _goodsTempInfo.TemplateName;
            }
            _valueTxt.text = _data.MoneyNum.toString();
            _buyBtn.visible = true;
            _icon.visible = true;
            _icon.setFrame(_data.PlayerType);
            _loc4_ = 0;
            _loc3_ = 0;
            if(model.shopLimitList[_data.Id])
            {
               _loc4_ = int(model.shopLimitList[_data.Id]);
            }
            _loc2_ = _data.Limited.split(",");
            if(_loc2_[model.contractLevel - 1])
            {
               _loc3_ = int(_loc2_[model.contractLevel - 1]);
            }
            _limit = _loc3_ - _loc4_ < 0 ? 0 : _loc3_ - _loc4_;
            _limitedTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnShopItem.limitedTxt.text",_limit,_loc3_);
         }
         else
         {
            removeEvent();
            _nameTxt.text = "";
            _valueTxt.text = "";
            _buyBtn.visible = false;
            _icon.visible = false;
            _goods.data = null;
            _limitedTxt.text = "";
         }
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_limitedTxt);
         _limitedTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

