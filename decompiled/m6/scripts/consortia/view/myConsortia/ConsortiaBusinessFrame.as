package consortia.view.myConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.view.myConsortia.item.ConsortiaBusinessItem;
   import events.ConsortiaEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import mvc.module.consortia.ConsortiaModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotAlertManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.MsgMan;
   import yishi.view.base.PageBar;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ConsortiaBusinessFrame extends Frame
   {
      
      private var _alertText:FilterFrameText;
      
      private var _descText:FilterFrameText;
      
      private var _assetText:FilterFrameText;
      
      private var _reputationText:FilterFrameText;
      
      private var _bottomImage:Image;
      
      private var _border:ScaleBitmapImage;
      
      private var _assetImage:Image;
      
      private var _reputationImage:Image;
      
      private var _businessItem:ConsortiaBusinessItem;
      
      private var _btnHbox:HBox;
      
      private var _supportBtn:SelectedIconButton;
      
      private var _tradeBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _pageBar:PageBar;
      
      private var itemList:Vector.<ConsortiaBusinessItem>;
      
      private var pageCount:int = 6;
      
      private var _isShow:Boolean = false;
      
      private var _openFromConsortiaFrame:int;
      
      private var _previewTxt:FilterFrameText;
      
      private var _bottomImage2:Image;
      
      private var _unOpenText:FilterFrameText;
      
      private var _refreshBtn:IconButton;
      
      private var _pointTxt:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      public function ConsortiaBusinessFrame()
      {
         super();
         initView();
         initListView();
         addEvent();
         _btnGroup.selectIndex = 0;
         ConsortiaSocketOutManager.businessBuyRequest(0,0,4);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _alertText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.alertText");
         _descText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.descText");
         _assetText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.assetText");
         _reputationText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.wealthText");
         _bottomImage = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.bottomImage");
         _border = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.border");
         _assetImage = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.assetImage");
         _reputationImage = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.reputationImage");
         _businessItem = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaBusinessFrame.businessItem");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessFrame.btnHbox");
         _supportBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessView.supportBtn");
         _tradeBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessView.tradeBtn");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessFrame.pageBar");
         _previewTxt = ComponentFactory.Instance.creatComponentByStylename("ConsortiaBusinessFrame.previewTxt");
         _bottomImage2 = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.bottomImage2");
         _unOpenText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.unOpenText");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.refreshBtn");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.pointTxt");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBusinessFrame.countTxt");
         addToContent(_border);
         addToContent(_bottomImage);
         addToContent(_btnHbox);
         addToContent(_assetImage);
         addToContent(_pageBar);
         addToContent(_assetText);
         addToContent(_previewTxt);
         addToContent(_bottomImage2);
         addToContent(_reputationImage);
         addToContent(_reputationText);
         addToContent(_alertText);
         addToContent(_descText);
         addToContent(_refreshBtn);
         addToContent(_pointTxt);
         addToContent(_countTxt);
         _btnHbox.addChild(_supportBtn);
         _btnHbox.addChild(_tradeBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_supportBtn);
         _btnGroup.addSelectItem(_tradeBtn);
         _bottomImage2.visible = false;
         _previewTxt.text = LanguageMgr.GetTranslation("Consortia.ConsortiaBusinessFrame.previewText.text");
         _previewTxt.mouseEnabled = true;
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.consoetiaShop.helpBtn");
         addToContent(_helpBtn);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortiaBusinessItem = null;
         var _loc3_:Array = new Array(12);
         _pageBar.setAutoPagingData(_loc3_,pageCount);
         _pageBar.setCurPage(1);
         itemList = new Vector.<ConsortiaBusinessItem>();
         _loc2_ = 0;
         while(_loc2_ < pageCount)
         {
            _loc1_ = new ConsortiaBusinessItem();
            _loc1_.x = int(_loc2_ % 3) * 225 + 50;
            _loc1_.y = int(_loc2_ / 3) * 130 + 130;
            addToContent(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         addToContent(_unOpenText);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _pageBar.addEventListener("change",_pageChangeHandler);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         MsgMan.addObserver("UPDATE_BUSINESS_INFO",this,__updateBusinessHandler);
         MsgMan.addObserver("UPDATE_QUEST_INFO",this,__updateReputationHandler);
         model.addEventListener("UPDA_CONSORTIA_INFO",__updateAssetHandler);
         _previewTxt.addEventListener("click",__previewTxtClickHandler);
         _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
         _helpBtn.addEventListener("click",_helpCilckHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_pageBar)
         {
            _pageBar.removeEventListener("change",_pageChangeHandler);
         }
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         MsgMan.removeObserver("UPDATE_BUSINESS_INFO",this,__updateBusinessHandler);
         MsgMan.removeObserver("UPDATE_QUEST_INFO",this,__updateReputationHandler);
         model.removeEventListener("UPDA_CONSORTIA_INFO",__updateAssetHandler);
         _previewTxt.removeEventListener("click",__previewTxtClickHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
         _helpBtn.removeEventListener("click",_helpCilckHandler);
      }
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = "ConsortiaBusinessFrame.refreshBtn.content";
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation(_loc2_,point);
         NotAlertManager.ins.needAlert("ConsortiaBusinessFrame.refreshBtn.content",refreshResultHandler,_loc3_,_loc4_,false);
      }
      
      private function refreshResultHandler() : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < point)
         {
            RechargeAlertMannager.show();
            return;
         }
         ConsortiaSocketOutManager.businessBuyRequest(0,0,3);
      }
      
      private function __previewTxtClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortia",13);
      }
      
      private function __updateAssetHandler(param1:ConsortiaEvent) : void
      {
         _assetText.text = model.consortiaInfo.consortiaAsset + "";
      }
      
      private function __updateReputationHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateBusinessHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function _pageChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         _pageBar.setCurPage(1);
         if(_btnGroup.selectIndex == 0)
         {
            _assetImage.visible = true;
            _reputationImage.visible = false;
            _previewTxt.visible = true;
            _alertText.y = 452;
            _unOpenText.visible = false;
         }
         else
         {
            _assetImage.visible = false;
            _reputationImage.visible = true;
            _previewTxt.visible = false;
            _alertText.y = 442;
            _unOpenText.visible = true;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:ConsortiaBusinessItem = null;
         var _loc6_:int = 0;
         _assetText.text = _btnGroup.selectIndex == 0 ? model.consortiaInfo.consortiaAsset + "" : "";
         _reputationText.text = _btnGroup.selectIndex == 1 ? model.reputation + "" : "";
         var _loc12_:Array = ConfigInfoManager.instance.commerceTime;
         var _loc7_:String = "";
         var _loc2_:Array = [];
         var _loc4_:String = LanguageMgr.GetTranslation("secret.day.tip");
         var _loc11_:Array = _loc4_.split(",");
         var _loc10_:String = "";
         _loc7_ = _loc12_[1];
         _loc2_ = _loc7_.split(",");
         _loc8_ = int(_loc2_[0]);
         _loc10_ = LanguageMgr.GetTranslation("ConsortiaBusinessFrame.alertText.text" + _btnGroup.selectIndex,_loc11_[_loc8_],_loc2_[1]);
         _descText.visible = true;
         _refreshBtn.visible = _pointTxt.visible = _countTxt.visible = false;
         _alertText.text = "";
         var _loc3_:String = "#ff0000";
         if(model.supplyList.length >= ConfigInfoManager.instance.commerceBusinessCondition)
         {
            _loc3_ = "#dd9b4d";
         }
         _descText.htmlText = "";
         var _loc9_:Array = _pageBar.getCurPageDatas();
         var _loc13_:int = int(_pageBar.getCurPage());
         _loc5_ = 0;
         while(_loc5_ < itemList.length)
         {
            _loc1_ = itemList[_loc5_];
            _loc1_.setViewType(_btnGroup.selectIndex + 1);
            _loc6_ = (_loc13_ - 1) * pageCount + _loc5_;
            _loc1_.index = _loc6_;
            _loc5_++;
         }
      }
      
      private function get point() : int
      {
         var _loc1_:Array = ConfigInfoManager.instance.commerceBusinessRandom;
         return _loc1_[0];
      }
      
      private function get count() : int
      {
         var _loc1_:Array = ConfigInfoManager.instance.commerceBusinessRandom;
         return _loc1_[1];
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _isShow = true;
               dispose();
         }
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      public function show(param1:int) : void
      {
         _openFromConsortiaFrame = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ConsortiaFacilitiesView.assassinCampText.text");
      }
      
      private function _helpCilckHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ui.consoetiaShop.helpFrame");
         _loc2_.show();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_assetText);
         _assetText = null;
         ObjectUtils.disposeObject(_reputationText);
         _reputationText = null;
         ObjectUtils.disposeObject(_bottomImage);
         _bottomImage = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_assetImage);
         _assetImage = null;
         ObjectUtils.disposeObject(_reputationImage);
         _reputationImage = null;
         ObjectUtils.disposeObject(_businessItem);
         _businessItem = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_supportBtn);
         _supportBtn = null;
         ObjectUtils.disposeObject(_tradeBtn);
         _tradeBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         ObjectUtils.disposeObject(_previewTxt);
         _previewTxt = null;
         ObjectUtils.disposeObject(_bottomImage2);
         _bottomImage2 = null;
         ObjectUtils.disposeObject(_unOpenText);
         _unOpenText = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
         FrameControllerManager.instance.consortiaController.closeSkillFrame(_openFromConsortiaFrame,_isShow);
      }
   }
}

