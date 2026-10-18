package consortia.view.myConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import mvc.module.consortia.ConsortiaBusinessInfo;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConsortiaBusinessTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaBusinessBuyFrame extends Frame
   {
      
      private var _buyBack:MutipleImage;
      
      private var _icon:BaseItemView;
      
      private var _nameText:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _buyNumTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _deleteBtn:BaseButton;
      
      private var _buyBtn:IconButton;
      
      private var _stockText:FilterFrameText;
      
      private var _limitText:FilterFrameText;
      
      private var _buyNum:int = 1;
      
      private var buyType:int;
      
      private var tempInfo:ConsortiaBusinessTempInfo;
      
      private var businessInfo:ConsortiaBusinessInfo;
      
      public function ConsortiaBusinessBuyFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _buyBack = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessBuyFrame.buyBack");
         _icon = ComponentFactory.Instance.creatCustomObject("ConsortiaBusinessBuyFrame.icon");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessBuyFrame.nameText");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessBuyFrame.priceTxt");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessBuyFrame.buyNumTxt");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessBuyFrame.addBtn");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessBuyFrame.deleteBtn");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessBuyFrame.buyBtn");
         _stockText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessBuyFrame.stockText");
         _limitText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessBuyFrame.limitText");
         addToContent(_buyBack);
         addToContent(_icon);
         addToContent(_nameText);
         addToContent(_priceTxt);
         addToContent(_stockText);
         addToContent(_limitText);
         addToContent(_buyNumTxt);
         addToContent(_addBtn);
         addToContent(_deleteBtn);
         addToContent(_buyBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _addBtn.addEventListener("click",__addHandler);
         _deleteBtn.addEventListener("click",__deleteHandler);
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
         _buyNumTxt.addEventListener("change",__buyNumChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addHandler);
         }
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("click",__deleteHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         }
         if(_buyNumTxt)
         {
            _buyNumTxt.removeEventListener("change",__buyNumChange);
         }
      }
      
      private function __buyNumChange(param1:Event) : void
      {
         _buyNum = int(_buyNumTxt.text);
         buyNumChangeHandler();
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _buyNum = _buyNum + 1;
         buyNumChangeHandler();
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _buyNum = _buyNum - 1;
         buyNumChangeHandler();
      }
      
      protected function buyNumChangeHandler() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = curCanCount;
         if(_loc2_ < _buyNum)
         {
            _buyNum = _loc2_;
         }
         _buyNum = _buyNum > 9999 ? 9999 : _buyNum;
         _buyNumTxt.text = _buyNum.toString();
         if(buyType == 1)
         {
            _priceTxt.text = tempInfo.CostConsortiaAsset * _buyNum + "";
            _loc1_ = int(businessInfo ? tempInfo.MaxSupplyCount - businessInfo.consortiaStockCount : tempInfo.MaxSupplyCount);
         }
         else
         {
            _priceTxt.text = tempInfo.CostPersonReputation * _buyNum + "";
            _loc1_ = int(businessInfo ? tempInfo.PersonBuyLimit - businessInfo.selfBoughtCount : tempInfo.PersonBuyLimit);
         }
         _limitText.text = LanguageMgr.GetTranslation("shop.view.GoodsItem.limited02") + _loc1_;
         _buyNum <= 1 ? (_deleteBtn.enable = false) : (Boolean(_deleteBtn.enable = true));
         _buyNum >= 9999 ? (_addBtn.enable = false) : (Boolean(_addBtn.enable = true));
         if(_buyNum >= _loc2_)
         {
            _addBtn.enable = false;
         }
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         if(_buyNum <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ConsortiaBusinessBuyFrame.buyGoods.limitAlert"));
            return;
         }
         if(buyType == 1 && int(_priceTxt.text) > model.consortiaInfo.consortiaAsset)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.noAsset.alert"));
            return;
         }
         if(buyType == 2 && int(_priceTxt.text) > model.reputation)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.noreputation.alert"));
            return;
         }
         ConsortiaSocketOutManager.businessBuyRequest(tempInfo.TemplateId,_buyNum,buyType);
         dispose();
      }
      
      private function refreshView(param1:Object = null) : void
      {
         var _loc3_:GoodsInfo = null;
         if(!param1)
         {
            return;
         }
         buyType = param1.viewType;
         titleText = LanguageMgr.GetTranslation("ConsortiaBusinessBuyFrame.titleTxt.text" + buyType);
         tempInfo = param1.tempInfo;
         businessInfo = model.getBusinessInfoBytempId(tempInfo.TemplateId);
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(tempInfo.ItemTempId);
         if(_loc2_)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc2_.TemplateId;
            _icon.data = _loc3_;
            _nameText.text = _loc2_.TemplateName;
         }
         var _loc4_:int = businessInfo ? businessInfo.consortiaStockCount - businessInfo.userBoughtTotalCount : 0;
         _stockText.text = LanguageMgr.GetTranslation("ConsortiaBusinessItem.stockText.text",_loc4_);
         buyNumChangeHandler();
      }
      
      private function get curCanCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(buyType == 1)
         {
            _loc1_ = int(businessInfo ? tempInfo.MaxSupplyCount - businessInfo.consortiaStockCount : tempInfo.MaxSupplyCount);
         }
         else if(!businessInfo)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc2_ = tempInfo.PersonBuyLimit - businessInfo.selfBoughtCount;
            _loc3_ = businessInfo.consortiaStockCount - businessInfo.userBoughtTotalCount;
            _loc1_ = Math.min(_loc2_,_loc3_);
         }
         return _loc1_ < 0 ? 0 : _loc1_;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
         KeyBoardRegister.instance.keyEnable = false;
         StageReferance.stage.focus = _buyNumTxt;
         if(param1)
         {
            refreshView(param1);
         }
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_buyBack);
         _buyBack = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_buyNumTxt);
         _buyNumTxt = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_deleteBtn);
         _deleteBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_stockText);
         _stockText = null;
         ObjectUtils.disposeObject(_limitText);
         _limitText = null;
         super.dispose();
      }
   }
}

