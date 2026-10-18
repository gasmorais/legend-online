package skytreasure
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SkyTreasureEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import managers.ShopManager;
   import mvc.module.mounts.WildSoulInfo;
   import mvc.module.skytreasure.SkyTreasureActTemplateInfo;
   import mvc.module.skytreasure.SkyTreasureExchangeData;
   import mvc.module.skytreasure.SkyTreasureExchangeItemInfo;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GoodsManager;
   import yishi.manager.SkyTreasureManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SkyShopBuyFrame extends Frame
   {
      
      protected var _canTotalText:FilterFrameText;
      
      protected var _canTotalValueText:FilterFrameText;
      
      protected var _canOneText:FilterFrameText;
      
      protected var _canOneValueText:FilterFrameText;
      
      protected var _addBtn:BaseButton;
      
      protected var _deleteBtn:BaseButton;
      
      protected var _icon:BaseItemView;
      
      protected var _buyNumTxt:FilterFrameText;
      
      protected var _buyImage:Bitmap;
      
      protected var _priceTxt:FilterFrameText;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _friendBack:MutipleImage;
      
      protected var _selfBack:MutipleImage;
      
      protected var _friendConfirmBtn:BaseButton;
      
      protected var _selfConfirmBtn:BaseButton;
      
      protected var _selfSelectBtn:SelectedIconButton;
      
      protected var _selectGroup:SelectedButtonGroup;
      
      protected var _callBack:Function;
      
      protected var _data:SkyTreasureExchangeItemInfo;
      
      protected var _buyNum:int = 1;
      
      protected var _isuseBindPointBtn:SelectedCheckButton;
      
      protected var _isUseBindPoint:Boolean = false;
      
      protected var _notJoinActPrompt:FilterFrameText;
      
      private var showPrompt:int = 0;
      
      private var _parm:Object;
      
      public function SkyShopBuyFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         ShopManager.Instance.isHandsel = 0;
         _selfBack = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfBuyFrameBack");
         _friendBack = ComponentFactory.Instance.creatComponentByStylename("quickbuy.FriendBuyFrameBack");
         _selfSelectBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfSelectedBackBtn");
         _friendConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.FriendConfirmBtn");
         _selfConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.selfConfirmBtn");
         _icon = ComponentFactory.Instance.creatCustomObject("quickbuy.BuyBaseItemView");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.AddButton");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.DeleteButton");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyNumTextStyle");
         _buyImage = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.DiamondIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyGoodsNameStyle");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.TotalPriceTextStyle");
         _canTotalText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanTotalTextStyle");
         _canTotalValueText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanTotalValueTextStyle");
         _canOneText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanOneTextStyle");
         _canOneValueText = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyCanOneValueTextStyle");
         _isuseBindPointBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.useBindPointBtn");
         _notJoinActPrompt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.useBindPoint_notJoinActTxt");
         _buyImage.x = 112;
         _buyImage.y = 125;
         addToContent(_selfBack);
         addToContent(_friendBack);
         addToContent(_selfSelectBtn);
         addToContent(_friendConfirmBtn);
         addToContent(_selfConfirmBtn);
         _selfConfirmBtn.x = 80;
         addToContent(_icon);
         addToContent(_addBtn);
         addToContent(_deleteBtn);
         addToContent(_buyNumTxt);
         addToContent(_buyImage);
         addToContent(_nameTxt);
         addToContent(_priceTxt);
         addToContent(_canTotalText);
         addToContent(_canTotalValueText);
         addToContent(_canOneText);
         addToContent(_canOneValueText);
         addToContent(_isuseBindPointBtn);
         _isuseBindPointBtn.text = LanguageMgr.GetTranslation("yishi.view.frame.BuyFrameI.priorityUse");
         addToContent(_notJoinActPrompt);
         _notJoinActPrompt.x = -1;
         _notJoinActPrompt.text = LanguageMgr.GetTranslation("yishi.view.frame.BuyFrameI.promptTxt");
         titleText = LanguageMgr.GetTranslation("campaign.TrailShop.BuyBtnTxt");
         _selectGroup = new SelectedButtonGroup();
         _selectGroup.addSelectItem(_selfSelectBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selfConfirmBtn.addEventListener("click",__confirmHandler);
         _friendConfirmBtn.addEventListener("click",__confirmHandler);
         _selectGroup.addEventListener("change",__selectedeChangehandler);
         _addBtn.addEventListener("click",__addHandler);
         _deleteBtn.addEventListener("click",__deleteHandler);
         _buyNumTxt.addEventListener("change",__buyNumChange);
         _buyNumTxt.addEventListener("keyDown",__onKeydownHandler);
         _isuseBindPointBtn.addEventListener("select",__useBindPointHandler);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_EXCHANGEINFO_UPDATE",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _selfConfirmBtn.removeEventListener("click",__confirmHandler);
         _friendConfirmBtn.removeEventListener("click",__confirmHandler);
         _selectGroup.removeEventListener("change",__selectedeChangehandler);
         _addBtn.removeEventListener("click",__addHandler);
         _deleteBtn.removeEventListener("click",__deleteHandler);
         _buyNumTxt.removeEventListener("change",__buyNumChange);
         _buyNumTxt.removeEventListener("keyDown",__onKeydownHandler);
         _isuseBindPointBtn.removeEventListener("select",__useBindPointHandler);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_EXCHANGEINFO_UPDATE",__updateHandler);
      }
      
      private function __updateHandler(param1:SkyTreasureEvent) : void
      {
         _data = null;
         dispose();
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmHandler(null);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               ShopManager.Instance.count = 0;
               ShopManager.Instance.type = 1;
               if(_callBack != null)
               {
                  _callBack(false,_parm);
               }
               _callBack = null;
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      public function data(param1:SkyTreasureExchangeItemInfo) : void
      {
         var _loc3_:int = 0;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:int = 0;
         _data = param1;
         if(_data is SkyTreasureExchangeItemInfo)
         {
            _loc3_ = int(_data.templateId);
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_);
            _loc2_ = int(_loc4_.SonType);
            _addBtn.visible = true;
            _deleteBtn.visible = true;
            _buyNumTxt.type = "input";
            if(_data.limitType == 0)
            {
               _addBtn.enable = true;
            }
         }
         _buyNum = 1;
         refreshView();
         buyNumChangeHandler();
         _selectGroup.selectIndex = 0;
      }
      
      public function set callback(param1:Function) : void
      {
         _callBack = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         StageReferance.stage.focus = _buyNumTxt;
      }
      
      protected function checkExist(param1:int) : String
      {
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         if(_loc3_.SonType != 218)
         {
            return "";
         }
         var _loc2_:WildSoulInfo = MountsManager.instance.avatarList.getWildSoulInfo(_loc3_.Property1);
         if(_loc3_.Property2 > 0)
         {
            _loc2_ = null;
         }
         if(_loc2_)
         {
            return LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.mopupexitst");
         }
         return "";
      }
      
      protected function __useBindPointHandler(param1:Event) : void
      {
         buyNumChangeHandler();
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc4_:SkyTreasureActTemplateInfo = null;
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         var _loc2_:Array = pumpModel.getAllSkyTreasureFrameOpenActTempData();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(pumpModel.actIsExchangeType(_loc2_[_loc3_].actType))
            {
               _loc4_ = _loc2_[_loc3_];
            }
            _loc3_++;
         }
         SkyTreasureManager.Instance.sendSkyTreasureExchangeReq(_loc4_.actId,_data.templateId,_buyNum);
      }
      
      private function __selectedeChangehandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(_selectGroup.getSelectedItem() == _selfSelectBtn)
         {
            _selfBack.visible = true;
            _friendBack.visible = false;
            _selfConfirmBtn.visible = true;
            _friendConfirmBtn.visible = false;
            _selfSelectBtn.selected = true;
            showPrompt = 0;
            ShopManager.Instance.isHandsel = 0;
            titleText = LanguageMgr.GetTranslation("campaign.TrailShop.BuyBtnTxt");
            _isuseBindPointBtn.visible = _isuseBindPointBtn.selected = _isUseBindPoint;
         }
      }
      
      protected function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = _data.templateId;
         _icon.data = _loc1_;
         _nameTxt.text = _loc1_.templateInfo.TemplateName;
         _nameTxt.y = 55 - (_nameTxt.numLines - 1) * 16;
         _selfSelectBtn.x = 85;
      }
      
      private function get pumpModel() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      protected function buyNumChangeHandler() : void
      {
         var _loc1_:SkyTreasureExchangeData = pumpModel.findSkyTreasureExchangeDataInfo(pumpModel.currShowActId);
         var _loc2_:int = _data.limitNum - _loc1_.findTempExchangeNum(_data.templateId);
         if(_data.limitType == 0)
         {
            _loc2_ = 999;
         }
         if(_loc2_ < _buyNum)
         {
            _buyNum = _loc2_;
         }
         _buyNum = _buyNum < 1 ? 1 : _buyNum;
         _buyNum = _buyNum > 999 ? 999 : _buyNum;
         _buyNumTxt.text = _buyNum.toString();
         _priceTxt.text = _data.exchangeCostNum * _buyNum + "";
         if(int(_priceTxt.text) > PayMoney)
         {
            _priceTxt.setFrame(2);
         }
         else
         {
            _priceTxt.setFrame(1);
         }
         _buyNum <= 1 ? (_deleteBtn.enable = false) : (Boolean(_deleteBtn.enable = true));
         _buyNum >= 999 ? (_addBtn.enable = false) : (Boolean(_addBtn.enable = true));
         if(_buyNum >= _loc2_)
         {
            _addBtn.enable = false;
         }
         _buyImage.x = _priceTxt.x + _priceTxt.textWidth + 5;
         refreshLimitView();
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
      
      private function __buyNumChange(param1:Event) : void
      {
         _buyNum = int(_buyNumTxt.text);
         buyNumChangeHandler();
      }
      
      public function get PayMoney() : int
      {
         return GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208802);
      }
      
      private function refreshLimitView() : void
      {
         _notJoinActPrompt.visible = _isuseBindPointBtn.visible = _isUseBindPoint && Boolean(_selfSelectBtn.selected);
         _isuseBindPointBtn.text = LanguageMgr.GetTranslation("yishi.view.frame.BuyFrameI.priorityUse");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_notJoinActPrompt);
         _notJoinActPrompt = null;
         ObjectUtils.disposeObject(_canTotalText);
         _canTotalText = null;
         ObjectUtils.disposeObject(_canTotalValueText);
         _canTotalValueText = null;
         ObjectUtils.disposeObject(_canOneText);
         _canOneText = null;
         ObjectUtils.disposeObject(_canOneValueText);
         _canOneValueText = null;
         ObjectUtils.disposeObject(_canOneValueText);
         _canOneValueText = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_deleteBtn);
         _deleteBtn = null;
         ObjectUtils.disposeObject(_buyNumTxt);
         _buyNumTxt = null;
         ObjectUtils.disposeObject(_buyImage);
         _buyImage = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_friendBack);
         _friendBack = null;
         ObjectUtils.disposeObject(_selfBack);
         _selfBack = null;
         ObjectUtils.disposeObject(_friendConfirmBtn);
         _friendConfirmBtn = null;
         ObjectUtils.disposeObject(_selfConfirmBtn);
         _selfConfirmBtn = null;
         ObjectUtils.disposeObject(_selfSelectBtn);
         _selfSelectBtn = null;
         ObjectUtils.disposeObject(_selectGroup);
         _selectGroup = null;
         ObjectUtils.disposeObject(_isuseBindPointBtn);
         _isuseBindPointBtn = null;
         _callBack = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

