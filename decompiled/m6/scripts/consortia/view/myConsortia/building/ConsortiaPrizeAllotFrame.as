package consortia.view.myConsortia.building
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaPrizeAllotFrame extends Frame implements IManualSize
   {
      
      private var _topBg:Scale9CornerImage;
      
      private var _downBg:ScaleLeftRightImage;
      
      private var _titleBarBg:MutipleImage;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _allotCountTitle:Bitmap;
      
      private var _allotCountText:FilterFrameText;
      
      private var _allotBtn:IconButton;
      
      private var _itemList:Vector.<ConsortiaPrizeAllotItem>;
      
      private var _prizeList:Array;
      
      private var _nameTitle:FilterFrameText;
      
      private var _gradeTitle:FilterFrameText;
      
      private var _fightingCapacityTitle:FilterFrameText;
      
      private var _receivedCountTitle:FilterFrameText;
      
      private var _searchBack:ScaleBitmapImage;
      
      private var _searchTxt:FilterFrameText;
      
      private var _searchTip:FilterFrameText;
      
      private var _searchBtn:SimpleBitmapButton;
      
      private var _currentPrizeListCount:int;
      
      private var _resetBtn:TextButton;
      
      private var _searchFlag:Boolean;
      
      public function ConsortiaPrizeAllotFrame()
      {
         super();
         _prizeList = [];
         initView();
         initEvents();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,this.width,this.height);
      }
      
      private function initView() : void
      {
         _topBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotTopBg");
         _downBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotDownBg");
         _titleBarBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotTitleBarBg");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotVbox");
         _nameTitle = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotNameTitle");
         _gradeTitle = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotGradeTitle");
         _fightingCapacityTitle = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotFightingCapacityTitle");
         _receivedCountTitle = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotReceivedCountTitle");
         _allotCountTitle = ComponentFactory.Instance.creatBitmap("asset.consortia.ConsortiaPrizeAllotCountTitle");
         _allotCountText = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotCountText");
         _allotBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotButton");
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllot.ResetBtn");
         _resetBtn.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotFrame.resetBtnText");
         search(false);
         addToContent(_topBg);
         addToContent(_downBg);
         addToContent(_titleBarBg);
         addToContent(_scrolPanel);
         addToContent(_nameTitle);
         addToContent(_gradeTitle);
         addToContent(_fightingCapacityTitle);
         addToContent(_receivedCountTitle);
         addToContent(_allotCountTitle);
         addToContent(_allotCountText);
         addToContent(_allotBtn);
         addToContent(_resetBtn);
         _searchBack = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllot.BagSearchBack");
         _searchTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllot.BagSearchTxt");
         _searchTip = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllot.BagSearchTxt");
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllot.BagSearchBtn");
         addToContent(_searchBack);
         addToContent(_searchTip);
         addToContent(_searchTxt);
         addToContent(_searchBtn);
         _searchTip.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotFrame.searchTip");
         _searchTip.mouseEnabled = false;
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotFrame.titleText");
         _nameTitle.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotFrame.tableTitle1");
         _gradeTitle.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotFrame.tableTitle2");
         _fightingCapacityTitle.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotFrame.tableTitle3");
         _receivedCountTitle.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotFrame.tableTitle4");
         _currentPrizeListCount = model.currentPrizeListCount;
         _allotCountText.text = _currentPrizeListCount.toString();
         _allotBtn.enable = false;
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vBox,true);
         _scrolPanel.invalidateViewport();
         refreshData();
         refreshView();
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__frameResponse);
         model.addEventListener("PRIZE_LIST_COUNT_UPDATE",__prizeListCountUpdateHandler);
         _allotBtn.addEventListener("click",__allotBtnClickHandler);
         _searchTxt.addEventListener("change",__searchChangeHandler);
         _searchTxt.addEventListener("focusIn",__focusInHandler);
         _searchTxt.addEventListener("focusOut",__focusOutHandler);
         _searchBtn.addEventListener("click",__onSerachHandler);
         _resetBtn.addEventListener("click",__resetBtnClickHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__frameResponse);
         model.removeEventListener("PRIZE_LIST_COUNT_UPDATE",__prizeListCountUpdateHandler);
         _allotBtn.removeEventListener("click",__allotBtnClickHandler);
         _searchTxt.removeEventListener("change",__searchChangeHandler);
         _searchTxt.removeEventListener("focusIn",__focusInHandler);
         _searchTxt.removeEventListener("focusOut",__focusOutHandler);
         _searchBtn.removeEventListener("click",__onSerachHandler);
         _resetBtn.removeEventListener("click",__resetBtnClickHandler);
      }
      
      private function __resetBtnClickHandler(param1:MouseEvent) : void
      {
         _searchTxt.text = "";
         _searchTip.visible = true;
         search(false);
         refreshData();
         refreshView();
      }
      
      private function __onSerachHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(StringHelper.isNullOrEmpty(_searchTxt.text))
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotFrame.searchTip");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         search();
         refreshData();
         refreshView();
      }
      
      private function search(param1:Boolean = true) : void
      {
         _resetBtn.visible = param1;
         _searchFlag = param1;
      }
      
      private function __focusInHandler(param1:FocusEvent) : void
      {
         _searchTip.visible = false;
      }
      
      private function __focusOutHandler(param1:FocusEvent) : void
      {
         if(_searchTxt.text == "")
         {
            _searchTip.visible = true;
         }
      }
      
      private function __searchChangeHandler(param1:Event) : void
      {
      }
      
      private function __prizeListCountUpdateHandler(param1:ConsortiaEvent) : void
      {
         _allotCountText.text = model.currentPrizeListCount.toString();
         if(_currentPrizeListCount == model.currentPrizeListCount)
         {
            _allotBtn.enable = false;
         }
         else
         {
            _allotBtn.enable = true;
         }
         refreshData();
         refreshView();
      }
      
      private function __allotBtnClickHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [allotConfirm];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotFrame.allotConfirmContent");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
      }
      
      private function allotConfirm(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Object = null;
         if(!param1)
         {
            return;
         }
         var _loc4_:Array = [];
         for each(var _loc5_:ThaneInfo in _prizeList)
         {
            if(_loc5_.receivedCount > 0)
            {
               _loc3_ = {
                  "userId":_loc5_.userId,
                  "count":_loc5_.receivedCount
               };
               _loc4_.push(_loc3_);
            }
         }
         ConsortiaSocketOutManager.consortiaPrizeAllotConfirm(model.currentPrizeTemplateId,_loc4_);
         dispose();
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function clearList() : void
      {
         for each(var _loc1_:ConsortiaPrizeAllotItem in _itemList)
         {
            _loc1_.dispose();
         }
         while(_itemList && _itemList.length > 0)
         {
            _itemList.pop();
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:ConsortiaPrizeAllotItem = null;
         var _loc3_:Boolean = model.currentPrizeListCount == 0;
         _vBox.removeAllChild();
         clearList();
         _vBox.beginChanges();
         if(!_itemList)
         {
            _itemList = new Vector.<ConsortiaPrizeAllotItem>();
         }
         var _loc2_:int = 0;
         for each(var _loc4_:ThaneInfo in _prizeList)
         {
            if(_searchFlag)
            {
               if(_loc4_.nickName.indexOf(StringHelper.trim(_searchTxt.text)) == -1)
               {
                  continue;
               }
            }
            _loc1_ = new ConsortiaPrizeAllotItem();
            _loc1_.data = _loc4_;
            _itemList.push(_loc1_);
            _vBox.addChild(_loc1_);
            if(_loc4_.receivedCount <= 0)
            {
               _loc1_.refresh(_loc3_);
            }
         }
         _vBox.refreshChildPos();
         _vBox.commitChanges();
         _scrolPanel.invalidateViewport();
      }
      
      private function refreshData() : void
      {
         _prizeList = model.prizeMemberList.getList();
         _prizeList.sortOn(["receivedCount","fightingCapacity","nickName"],[0x10 | 2,0x10 | 2,1]);
         var _loc1_:int = _prizeList.indexOf(model.prizeMemberList[model.consortiaInfo.chairmanID]);
         _prizeList.splice(_loc1_,1);
         _prizeList.unshift(model.prizeMemberList[model.consortiaInfo.chairmanID]);
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_topBg);
         _topBg = null;
         ObjectUtils.disposeObject(_downBg);
         _downBg = null;
         ObjectUtils.disposeObject(_titleBarBg);
         _titleBarBg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_scrolPanel);
         _scrolPanel = null;
         ObjectUtils.disposeObject(_allotCountTitle);
         _allotCountTitle = null;
         ObjectUtils.disposeObject(_allotCountText);
         _allotCountText = null;
         ObjectUtils.disposeObject(_allotBtn);
         _allotBtn = null;
         ObjectUtils.disposeObject(_nameTitle);
         _nameTitle = null;
         ObjectUtils.disposeObject(_gradeTitle);
         _gradeTitle = null;
         ObjectUtils.disposeObject(_fightingCapacityTitle);
         _fightingCapacityTitle = null;
         ObjectUtils.disposeObject(_receivedCountTitle);
         _receivedCountTitle = null;
         ObjectUtils.disposeObject(_searchBack);
         _searchBack = null;
         ObjectUtils.disposeObject(_searchTxt);
         _searchTxt = null;
         ObjectUtils.disposeObject(_searchTip);
         _searchTip = null;
         ObjectUtils.disposeObject(_searchBtn);
         _searchBtn = null;
         clearList();
         _prizeList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

