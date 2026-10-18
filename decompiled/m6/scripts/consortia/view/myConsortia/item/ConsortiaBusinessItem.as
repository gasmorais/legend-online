package consortia.view.myConsortia.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConsortiaCommerceShopTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotAlertManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaBusinessItem extends Component
   {
      
      private var _priceText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _stockText:FilterFrameText;
      
      private var _itemBg:Image;
      
      private var _buyBtn:IconButton;
      
      private var _goodsItem:BaseItemView;
      
      private var viewType:int;
      
      private var _descTxt:FilterFrameText;
      
      private var _icon:Bitmap;
      
      private var _unLockBtn:IconButton;
      
      private var _data:ConsortiaCommerceShopTempInfo;
      
      private var _index:int;
      
      private var _goodsTemp:GoodsTemplateInfo;
      
      public function ConsortiaBusinessItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _priceText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessItem.priceText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessItem.nameText");
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessItem.itemBg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessItem.buyBtn");
         _stockText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessItem.stockText");
         _goodsItem = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaBusinessItem.goodsItem");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessItem.descTxt");
         _icon = ComponentFactory.Instance.creatBitmap("asset.ConsortiaBusinessItem.icon");
         _unLockBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessItem.unLockBtn");
         addChild(_itemBg);
         addChild(_goodsItem);
         addChild(_nameText);
         addChild(_descTxt);
         addChild(_priceText);
         addChild(_stockText);
         addChild(_buyBtn);
         addChild(_unLockBtn);
         addChild(_icon);
         _descTxt.text = LanguageMgr.GetTranslation("ConsortiaBusinessItem.descTxt.text");
      }
      
      private function addEvent() : void
      {
         _buyBtn.addEventListener("click",_buyBtnClickHandler);
         _unLockBtn.addEventListener("click",__unLockBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",_buyBtnClickHandler);
         }
         _unLockBtn.removeEventListener("click",__unLockBtnClickHandler);
      }
      
      private function __unLockBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!consortiaControl.getRightsByIndex(1))
         {
            if(!consortiaControl.getRightsByNum(43))
            {
               _loc2_ = LanguageMgr.GetTranslation("ConsortiaBusinessItem.callTips");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
         }
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("ConsortiaBusinessItem.unlock.content",count);
         SimpleAlertHelper.instance.data = [unLockResultHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,true,false);
      }
      
      private function get consortiaControl() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      private function unLockResultHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(model.consortiaInfo.consortiaAsset < count)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.noAsset.alert"));
               return;
            }
            ConsortiaSocketOutManager.businessBuyRequest(0,0,1);
         }
      }
      
      private function _buyBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = "";
         if(_data.Point <= 0)
         {
            _loc2_ = "ConsortiaBusinessItem.buyBtn.content1";
         }
         else
         {
            _loc2_ = "ConsortiaBusinessItem.buyBtn.content2";
         }
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation(_loc2_,_data.CostPersonReputation,_goodsTemp.TemplateName,_data.Count,_data.Point);
         NotAlertManager.ins.needAlert("ConsortiaBusinessItem.buyBtn.content",buyResultHandler,_loc3_,_loc4_,false);
      }
      
      private function buyResultHandler() : void
      {
         if(model.reputation < _data.CostPersonReputation)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.noreputation.alert"));
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < _data.Point)
         {
            RechargeAlertMannager.show();
            return;
         }
         ConsortiaSocketOutManager.businessBuyRequest(_data.MapShopId,0,2);
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc4_:Array = null;
         var _loc2_:GoodsInfo = null;
         var _loc3_:int = 0;
         if(viewType == 1)
         {
            _loc4_ = model.supplyList;
         }
         else if(viewType == 2)
         {
            _loc4_ = model.tradeList;
         }
         else
         {
            _loc4_ = TempleteManager.instance.consortiaCommerceShopTempCate.getTempArray();
         }
         var _loc1_:int = int(_loc4_[_index]);
         _data = TempleteManager.instance.consortiaCommerceShopTempCate.getTemplateByID(_loc1_);
         if(_data)
         {
            _icon.visible = false;
            _goodsTemp = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemTempId);
            if(_goodsTemp)
            {
               _loc2_ = new GoodsInfo();
               _loc2_.templateId = _goodsTemp.TemplateId;
               _loc2_.count = _data.Count;
               _goodsItem.data = _loc2_;
               _nameText.text = _goodsTemp.TemplateName;
            }
            _priceText.text = LanguageMgr.GetTranslation("ConsortiaBusinessItem.priceText.text",_data.CostPersonReputation);
            _stockText.text = _data.Point > 0 ? LanguageMgr.GetTranslation("ConsortiaBusinessItem.stockText.text",_data.Point) : "";
            _loc3_ = int(model.tradeStateList[_index]);
            _buyBtn.enable = _loc3_ == 0;
            _buyBtn.visible = viewType == 2;
            _unLockBtn.visible = false;
            _descTxt.text = LanguageMgr.GetTranslation("ConsortiaBusinessItem.descTxt.text");
         }
         else
         {
            _icon.visible = true;
            _nameText.text = "";
            _priceText.text = "";
            _stockText.text = "";
            _buyBtn.visible = false;
            _goodsItem.data = null;
            _unLockBtn.visible = false;
            _descTxt.text = "";
            if(viewType == 1)
            {
               _descTxt.text = LanguageMgr.GetTranslation("ConsortiaBusinessItem.descTxt.text1",count);
               _unLockBtn.visible = true;
               if(model.supplyList.length == _index)
               {
                  _unLockBtn.enable = true;
               }
               else
               {
                  _unLockBtn.enable = false;
               }
            }
         }
      }
      
      private function get count() : int
      {
         return ConfigInfoManager.instance.commerceSupplyDeblocking[_index];
      }
      
      public function setViewType(param1:int) : void
      {
         viewType = param1;
      }
      
      private function get control() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_priceText);
         _priceText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_stockText);
         _stockText = null;
         ObjectUtils.disposeObject(_goodsItem);
         _goodsItem = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_unLockBtn);
         _unLockBtn = null;
         super.dispose();
      }
   }
}

