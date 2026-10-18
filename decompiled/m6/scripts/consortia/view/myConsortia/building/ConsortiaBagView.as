package consortia.view.myConsortia.building
{
   import bag.BaseBagListManager;
   import bag.events.BagEvent;
   import bag.helper.BagHelper;
   import bag.view.EquipBagSortList;
   import bag.view.GeneralBag;
   import bag.view.StoreBag;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.armyII.ArmyModel;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaBagView extends Sprite implements Disposeable
   {
      
      protected var _buttongroup:SelectedButtonGroup;
      
      protected var _page1:SelectedIconButton;
      
      protected var _page2:SelectedIconButton;
      
      protected var _page3:SelectedIconButton;
      
      protected var _page4:SelectedIconButton;
      
      protected var _page5:SelectedIconButton;
      
      protected var _page6:SelectedIconButton;
      
      protected var _tidyButton:TextButton;
      
      protected var _splitButton:TextButton;
      
      protected var _sellButton:TextButton;
      
      protected var _generalBag:GeneralBag;
      
      protected var _sortBtn:TextButton;
      
      private var _storeBagBagBtn:SelectedIconButton;
      
      private var _storeBagStoreBtn:SelectedIconButton;
      
      private var _rightBtnGroup:SelectedButtonGroup;
      
      private var _storeBag:StoreBag;
      
      private var _sortList:EquipBagSortList;
      
      public function ConsortiaBagView()
      {
         super();
         initView();
         initEvent();
         initDate();
      }
      
      protected function initView() : void
      {
         _buttongroup = new SelectedButtonGroup();
         _tidyButton = ComponentFactory.Instance.creatComponentByStylename("consortia.CaseTidyButton");
         _tidyButton.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaBagView.tidyButton.text");
         _splitButton = ComponentFactory.Instance.creatComponentByStylename("consortia.CaseSplitButton");
         _splitButton.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaBagView.splitButton.text");
         _sellButton = ComponentFactory.Instance.creatComponentByStylename("consortia.CaseSellButton");
         _sellButton.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaBagView.sellButton.text");
         _page1 = ComponentFactory.Instance.creatComponentByStylename("consortia.CasePage1Button");
         _page2 = ComponentFactory.Instance.creatComponentByStylename("consortia.CasePage2Button");
         _page3 = ComponentFactory.Instance.creatComponentByStylename("consortia.CasePage3Button");
         _page6 = ComponentFactory.Instance.creatComponentByStylename("consortia.CasePage4Button");
         _page4 = ComponentFactory.Instance.creatComponentByStylename("consortia.CasePage5Button");
         _page5 = ComponentFactory.Instance.creatComponentByStylename("consortia.CasePage6Button");
         _storeBagBagBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.BagStroeBagBtn");
         _storeBagStoreBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.BagStroeStroeBtn");
         _buttongroup.addSelectItem(_page1);
         _buttongroup.addSelectItem(_page2);
         _buttongroup.addSelectItem(_page3);
         _buttongroup.addSelectItem(_page6);
         _buttongroup.addSelectItem(_page4);
         _buttongroup.addSelectItem(_page5);
         addChild(_tidyButton);
         addChild(_splitButton);
         addChild(_sellButton);
         addChild(_page1);
         addChild(_page2);
         addChild(_page6);
         addChild(_page3);
         addChild(_page4);
         addChild(_page5);
         addChild(_storeBagBagBtn);
         addChild(_storeBagStoreBtn);
         if(playerInfo.stoneBagCount == 0)
         {
            _storeBagStoreBtn.enable = false;
         }
         _rightBtnGroup = new SelectedButtonGroup();
         _rightBtnGroup.addSelectItem(_storeBagBagBtn);
         _rightBtnGroup.addSelectItem(_storeBagStoreBtn);
         _rightBtnGroup.selectIndex = 0;
         ConsortiaManager.instance.model.currentBagType = 1;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.stoneBagCount > 0)
         {
            _storeBag = new StoreBag(7,8,6,1);
            _storeBag.x = 5;
            _storeBag.y = 4;
            _storeBag.reFreshAll();
         }
         _generalBag = new GeneralBag(7,8,6,-7,-6);
         _generalBag.x = 5;
         _generalBag.y = 4;
         _generalBag.reFreshAll();
         addChild(_generalBag);
         _buttongroup.selectIndex = 0;
         model.bagView = this;
         armyModel.currentBag = _generalBag;
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.BagSortBtn");
         _sortBtn.x = 230;
         _sortBtn.y = 382;
         addChild(_sortBtn);
         var _loc1_:int = int(BaseBagListManager.instance.model.lastBagSortType);
         _sortBtn.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder" + _loc1_);
      }
      
      private function initDate() : void
      {
         _buttongroup.selectIndex = model.currentPage - 1;
         _generalBag.gotoPage(model.currentPage);
      }
      
      private function get model() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      protected function initEvent() : void
      {
         _page1.addEventListener("click",__pageIClick);
         _page2.addEventListener("click",__pageIIClick);
         _page3.addEventListener("click",__pageIIIClick);
         _page6.addEventListener("click",__page6Click);
         _page4.addEventListener("click",__pageIVClick);
         _page5.addEventListener("click",__pageVClick);
         _tidyButton.addEventListener("click",__tidyHandler);
         _splitButton.addEventListener("click",__splitHandler);
         _sellButton.addEventListener("click",__sellHandler);
         playerInfo.addEventListener("BAG_CAPICITY_INCRESS",__infoChange);
         GoodsManager.instance.addEventListener("BAG_FULL",__bagIsFullHandler);
         _sortBtn.addEventListener("mouseDown",__sortBtnDownHandler);
         _sortBtn.addEventListener("click",__sortBtnClickHandler);
         NotificationManager.instance.addEventListener("BAG_SORT_SELECT",__bagSortSelectHandler);
         NotificationManager.instance.addEventListener("BAG_SORT_CHANGE",__bagSortChangeHandler);
         if(_rightBtnGroup != null)
         {
            _rightBtnGroup.addEventListener("change",onRightBtnChange);
         }
      }
      
      protected function removeEvent() : void
      {
         _page1.removeEventListener("click",__pageIClick);
         _page2.removeEventListener("click",__pageIIClick);
         _page3.removeEventListener("click",__pageIIIClick);
         _page6.removeEventListener("click",__page6Click);
         _page4.removeEventListener("click",__pageIVClick);
         _page5.removeEventListener("click",__pageVClick);
         _tidyButton.removeEventListener("click",__tidyHandler);
         _splitButton.removeEventListener("click",__splitHandler);
         _sellButton.removeEventListener("click",__sellHandler);
         playerInfo.removeEventListener("BAG_CAPICITY_INCRESS",__infoChange);
         GoodsManager.instance.removeEventListener("BAG_FULL",__bagIsFullHandler);
         _sortBtn.removeEventListener("mouseDown",__sortBtnDownHandler);
         _sortBtn.removeEventListener("click",__sortBtnClickHandler);
         NotificationManager.instance.removeEventListener("BAG_SORT_SELECT",__bagSortSelectHandler);
         NotificationManager.instance.removeEventListener("BAG_SORT_CHANGE",__bagSortChangeHandler);
         if(_rightBtnGroup != null)
         {
            _rightBtnGroup.removeEventListener("change",onRightBtnChange);
         }
      }
      
      private function onRightBtnChange(param1:Event) : void
      {
         if(_generalBag == null)
         {
            return;
         }
         if(_rightBtnGroup.selectIndex == 0)
         {
            _page5.visible = true;
            addChild(_generalBag);
            if(_storeBag != null && _storeBag.parent != null)
            {
               _storeBag.parent.removeChild(_storeBag);
            }
            _sortBtn.enable = true;
            armyModel.currentBag = _generalBag;
            ConsortiaManager.instance.model.currentBagType = 1;
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            _page5.visible = false;
            if(_generalBag != null && _generalBag.parent != null)
            {
               _generalBag.parent.removeChild(_generalBag);
            }
            if(_storeBag != null)
            {
               addChild(_storeBag);
            }
            _sortBtn.enable = false;
            armyModel.currentBag = _storeBag;
            ConsortiaManager.instance.model.currentBagType = 34;
         }
         if(_rightBtnGroup.selectIndex == 0)
         {
            _generalBag.gotoPage(model.currentPage);
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            if(_storeBag != null)
            {
               if(model.currentPage == 6)
               {
                  _buttongroup.selectIndex = 0;
                  model.currentPage = 0;
               }
               _storeBag.gotoPage(model.currentPage);
            }
         }
      }
      
      private function __bagSortSelectHandler(param1:NotificationEvent) : void
      {
         BagHelper.instance.onTidyHandler(_generalBag,param1.data);
      }
      
      private function __bagSortChangeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = "";
         switch(param1.data)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder0");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder1");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder2");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder3");
               break;
            case 4:
               _loc2_ = LanguageMgr.GetTranslation("armyII.ArmyFrameII.SortOrder4");
         }
         _sortBtn.text = _loc2_;
         BaseBagListManager.instance.model.lastBagSortType = param1.data;
         GoodsManager.instance.filterFlag = true;
      }
      
      private function __sortBtnDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __sortBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_sortList)
         {
            _sortList.dispose();
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_sortList)
         {
            _sortList = new EquipBagSortList();
         }
         _sortList.addEventListener("dispose",__onSortListDispose);
         var _loc2_:Point = new Point(_sortBtn.x,_sortBtn.y);
         _sortList.x = localToGlobal(_loc2_).x + 4;
         _sortList.y = localToGlobal(_loc2_).y - _sortList.height + 4;
         LayerManager.Instance.addToLayer(_sortList,7);
      }
      
      private function __onSortListDispose(param1:Event) : void
      {
         _sortList.removeEventListener("dispose",__onSortListDispose);
         _sortList = null;
      }
      
      private function __sellHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         BagHelper.instance.onSellButtonClickHandler(this);
      }
      
      private function __infoChange(param1:PlayerEvent) : void
      {
         model.currentPage = Math.ceil(playerInfo.bagTotalCount / 56);
         initDate();
      }
      
      private function __bagIsFullHandler(param1:BagEvent) : void
      {
         GoodsManager.instance.filterGoodsInGeneralAndConsortiaBag();
      }
      
      private function __splitHandler(param1:MouseEvent) : void
      {
         BagHelper.instance.onSplitHandler(this);
      }
      
      private function __pageIClick(param1:MouseEvent) : void
      {
         model.currentPage = 1;
         if(_rightBtnGroup.selectIndex == 0)
         {
            _generalBag.gotoPage(model.currentPage);
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            _storeBag && _storeBag.gotoPage(model.currentPage);
         }
      }
      
      private function __pageIIClick(param1:MouseEvent) : void
      {
         model.currentPage = 2;
         if(_rightBtnGroup == null)
         {
            _generalBag.gotoPage(model.currentPage);
            return;
         }
         if(_rightBtnGroup.selectIndex == 0)
         {
            _generalBag.gotoPage(model.currentPage);
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            _storeBag && _storeBag.gotoPage(model.currentPage);
         }
      }
      
      private function __pageIIIClick(param1:MouseEvent) : void
      {
         model.currentPage = 3;
         if(_rightBtnGroup == null)
         {
            _generalBag.gotoPage(model.currentPage);
            return;
         }
         if(_rightBtnGroup.selectIndex == 0)
         {
            _generalBag.gotoPage(model.currentPage);
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            _storeBag && _storeBag.gotoPage(model.currentPage);
         }
      }
      
      private function __page6Click(param1:MouseEvent) : void
      {
         model.currentPage = 4;
         if(_rightBtnGroup == null)
         {
            _generalBag.gotoPage(model.currentPage);
            return;
         }
         if(_rightBtnGroup.selectIndex == 0)
         {
            _generalBag.gotoPage(model.currentPage);
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            _storeBag && _storeBag.gotoPage(model.currentPage);
         }
      }
      
      private function __pageIVClick(param1:MouseEvent) : void
      {
         model.currentPage = 5;
         if(_rightBtnGroup == null)
         {
            _generalBag.gotoPage(model.currentPage);
            return;
         }
         if(_rightBtnGroup.selectIndex == 0)
         {
            _generalBag.gotoPage(model.currentPage);
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            _storeBag && _storeBag.gotoPage(model.currentPage);
         }
      }
      
      private function __pageVClick(param1:MouseEvent) : void
      {
         model.currentPage = 6;
         if(_rightBtnGroup == null)
         {
            _generalBag.gotoPage(model.currentPage);
            return;
         }
         if(_rightBtnGroup.selectIndex == 0)
         {
            _generalBag.gotoPage(model.currentPage);
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            _storeBag && _storeBag.gotoPage(model.currentPage);
         }
      }
      
      private function __tidyHandler(param1:MouseEvent) : void
      {
         if(_rightBtnGroup.selectIndex == 0)
         {
            BagHelper.instance.onTidyHandler(_generalBag);
         }
         else if(_rightBtnGroup.selectIndex == 1)
         {
            BagHelper.instance.onTidyHandler(_storeBag);
         }
      }
      
      public function getBaseBagItemByType(param1:int) : BaseItemView
      {
         var _loc2_:BaseItemView = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<BaseItemView> = _generalBag.itemList;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc4_[_loc3_].data && _loc4_[_loc3_].data.templateInfo.SonType == param1)
            {
               _loc2_ = _loc4_[_loc3_];
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function set operEnble(param1:Boolean) : void
      {
         if(_splitButton)
         {
            _splitButton.enable = param1;
         }
         if(_tidyButton)
         {
            _tidyButton.enable = param1;
         }
         if(_sortBtn)
         {
            _sortBtn.enable = param1;
            if(currentIndex == 1)
            {
               _sortBtn.enable = false;
            }
         }
      }
      
      public function get page1() : SelectedIconButton
      {
         return _page1;
      }
      
      public function get page2() : SelectedIconButton
      {
         return _page2;
      }
      
      public function get page3() : SelectedIconButton
      {
         return _page3;
      }
      
      public function get page4() : SelectedIconButton
      {
         return _page4;
      }
      
      public function get page5() : SelectedIconButton
      {
         return _page5;
      }
      
      public function get page6() : SelectedIconButton
      {
         return _page6;
      }
      
      public function get currentIndex() : int
      {
         if(_rightBtnGroup)
         {
            return _rightBtnGroup.selectIndex;
         }
         return 0;
      }
      
      public function get armyModel() : ArmyModel
      {
         return FrameControllerManager.instance.armyController.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      protected function uninit() : void
      {
         model.bagView = null;
         _generalBag.dispose();
         _generalBag = null;
         _buttongroup.dispose();
         _buttongroup = null;
         DragManager.getInstance().stopDrag();
         CursorManagerII.instance.resetCursor();
         ObjectUtils.disposeAllChildren(this);
         _page1 = null;
         _page2 = null;
         _page3 = null;
         _page4 = null;
         _page5 = null;
         _tidyButton = null;
         _splitButton = null;
         _sellButton = null;
         _sortBtn = null;
         GoodsManager.instance.filterFlag = false;
         ObjectUtils.disposeObject(_storeBagBagBtn);
         _storeBagBagBtn = null;
         ObjectUtils.disposeObject(_storeBagStoreBtn);
         _storeBagStoreBtn = null;
      }
   }
}

