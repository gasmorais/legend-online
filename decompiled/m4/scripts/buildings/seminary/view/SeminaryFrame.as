package buildings.seminary.view
{
   import buildings.BaseBuildFrame;
   import buildings.seminary.event.TechnologyItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.BuildingEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.component.MovieButton;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SeminaryFrame extends BaseBuildFrame
   {
      
      private var _back1:ScaleBitmapImage;
      
      private var _contain:Sprite;
      
      private var _bottomView:SeminaryFrameBottomView;
      
      private var _helpBtn:BaseButton;
      
      private var _blessBtn:MovieButton;
      
      private var _strip:StripView;
      
      private var _prePage:IconButton;
      
      private var _nextPage:IconButton;
      
      private var _pageBack:ScaleBitmapImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var itemGroup:SelectedButtonGroup;
      
      private var _itemList:Array;
      
      private var _firstBuild:BuildInfo;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      public function SeminaryFrame()
      {
         super();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back1 = ComponentFactory.Instance.creatComponentByStylename("seminary.Back1");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("seminary.HelpBtn");
         _blessBtn = ComponentFactory.Instance.creatComponentByStylename("seminary.BlessBtn");
         _blessBtn.stopEffect();
         _strip = ComponentFactory.Instance.creatCustomObject("seminary.BlessBtnTip");
         _contain = ComponentFactory.Instance.creatCustomObject("seminary.MilitaryTechnologyList");
         _prePage = ComponentFactory.Instance.creatComponentByStylename("seminary.PrePageBtn");
         _nextPage = ComponentFactory.Instance.creatComponentByStylename("seminary.NextPageBtn");
         _pageBack = ComponentFactory.Instance.creatComponentByStylename("seminary.PageBack");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("seminary.PageTxt");
         addToContent(_back1);
         addToContent(_contain);
         _helpBtn.tipData = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrame.HelpBtn.Tipdata");
         showImp();
         refreshTec();
      }
      
      private function showImp() : void
      {
         var _loc4_:int = 0;
         var _loc1_:TechnologyItem = null;
         _itemList = [];
         itemGroup = new SelectedButtonGroup();
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("seminary.TechnologyItem");
            _loc1_.x = _loc4_ % 4 * 181;
            _loc1_.y = int(_loc4_ / 4) * 90;
            _loc1_.addEventListener(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OVER,_itemRollOverHandler);
            _loc1_.addEventListener(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OUT,_itemRollOutHandler);
            _loc1_.data = null;
            _loc1_.tipData = null;
            itemGroup.addSelectItem(_loc1_);
            _itemList.push(_loc1_);
            _contain.addChild(_loc1_);
            _loc4_++;
         }
         _bottomView = new SeminaryFrameBottomView();
         _bottomView.x = 3;
         _bottomView.y = 376;
         addToContent(_bottomView);
         resetSize(741);
         var _loc3_:Boolean = false;
         var _loc2_:int = int(ArmyManager.instance.thane.grades);
         if(_loc3_)
         {
            _describeBackground.width = 345;
            addToContent(_strip);
            if(_loc2_ >= 41)
            {
               _blessBtn.enable = true;
               if(PlayerManager.instance.currentPlayerModel.playerInfo.isFirstSeminary)
               {
                  _blessBtn.playEffect();
               }
               _strip.tipData = "";
            }
            else
            {
               _blessBtn.enable = false;
               _strip.tipData = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrame.BlessAlert");
            }
         }
         addToContent(_prePage);
         addToContent(_nextPage);
         addToContent(_pageBack);
         addToContent(_pageTxt);
      }
      
      override protected function resetSize(param1:int) : void
      {
         _describeBackground.width = 592;
         _lineBg.width = param1;
         _upgradeBtn.x = _describeBackground.x + _describeBackground.width + 10;
      }
      
      private function _itemRollOverHandler(param1:TechnologyItemEvent) : void
      {
         if(_bottomView)
         {
            _bottomView.changeRed();
         }
      }
      
      private function _itemRollOutHandler(param1:TechnologyItemEvent) : void
      {
         if(_bottomView)
         {
            _bottomView.revertColor();
         }
      }
      
      private function refreshTec() : void
      {
         var _loc5_:BuildInfo = null;
         var _loc7_:BuildingTempInfo = null;
         var _loc2_:TechnologyItem = null;
         var _loc6_:int = 0;
         var _loc1_:Array = BuildingManager.instance.model.buildingListByID.getList();
         _loc1_.sortOn("sonType");
         var _loc3_:Array = [];
         for each(_loc5_ in _loc1_)
         {
            _loc7_ = _loc5_.templeteInfo;
            if(_loc7_.MasterType == 13 || _loc7_.MasterType == 14)
            {
               _loc3_.push(_loc5_);
            }
         }
         var _loc4_:int = int(_loc3_.length);
         _totalPage = Math.ceil(_loc4_ / 12);
         _loc6_ = 0;
         while(_loc6_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc6_] as TechnologyItem;
            _loc2_.data = null;
            _loc2_.tipData = null;
            _loc5_ = _loc3_[_loc6_ + (_currentPage - 1) * 12] as BuildInfo;
            if(!_firstBuild)
            {
               _firstBuild = _loc5_;
            }
            _loc2_.data = _loc5_;
            _loc2_.tipData = _loc5_;
            _loc6_++;
         }
         _pageTxt.htmlText = "<font size=\'16\'>" + _currentPage + "/" + _totalPage + "</font>";
         _prePage.enable = _currentPage != 1;
         _nextPage.enable = _totalPage != _currentPage;
      }
      
      override protected function uninit() : void
      {
         super.uninit();
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_contain);
         _contain = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_blessBtn);
         _blessBtn = null;
         ObjectUtils.disposeObject(_strip);
         _strip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         BuildingManager.instance.addEventListener("BUILDING_UPGRADE_RECEIVE",__technologyUpdateHandler);
         BuildingManager.instance.addEventListener("CREATE_NEW_BUILDING",__createNewTechItemHandler);
         _helpBtn.addEventListener("click",__onHelpClick);
         _blessBtn.addEventListener("click",__blessHandler);
         _prePage.addEventListener("click",__preClickHandler);
         _nextPage.addEventListener("click",__nextPageHandler);
      }
      
      override protected function removeEvent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TechnologyItem = null;
         super.removeEvent();
         BuildingManager.instance.removeEventListener("BUILDING_UPGRADE_RECEIVE",__technologyUpdateHandler);
         BuildingManager.instance.removeEventListener("CREATE_NEW_BUILDING",__createNewTechItemHandler);
         _helpBtn.removeEventListener("click",__onHelpClick);
         _blessBtn.removeEventListener("click",__blessHandler);
         _prePage.removeEventListener("click",__preClickHandler);
         _nextPage.removeEventListener("click",__nextPageHandler);
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = _itemList[_loc2_] as TechnologyItem;
            if(_loc1_)
            {
               _loc1_.removeEventListener(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OVER,_itemRollOverHandler);
            }
            if(_loc1_)
            {
               _loc1_.removeEventListener(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OUT,_itemRollOutHandler);
            }
            _loc2_++;
         }
      }
      
      private function __preClickHandler(param1:MouseEvent) : void
      {
         if(_currentPage > 1)
         {
            _currentPage = _currentPage - 1;
         }
         if(_currentPage == 1)
         {
            _prePage.enable = false;
         }
         refreshTec();
      }
      
      private function __nextPageHandler(param1:MouseEvent) : void
      {
         if(_currentPage < _totalPage)
         {
            _currentPage = _currentPage + 1;
         }
         if(_currentPage == _totalPage)
         {
            _nextPage.enable = false;
         }
         refreshTec();
      }
      
      private function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("seminary.SeminaryHelpFrame");
         _loc2_.show();
      }
      
      private function __blessHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         PlayerManager.instance.currentPlayerModel.playerInfo.isFirstSeminary = false;
         _blessBtn.stopEffect();
         FrameControllerManager.instance.openControllerByInfo("seminarybless");
         dispose();
      }
      
      private function __technologyUpdateHandler(param1:BuildingEvent) : void
      {
         var _loc2_:BuildInfo = param1.buildingInfo;
         var _loc3_:BuildingTempInfo = _loc2_.templeteInfo;
         if(_loc3_.MasterType == 13 || _loc3_.MasterType == 14)
         {
            NotificationManager.instance.dispatchEvent(new TechnologyItemEvent(TechnologyItemEvent.UPDATA,_loc2_));
         }
      }
      
      private function __createNewTechItemHandler(param1:BuildingEvent) : void
      {
         refreshTec();
      }
      
      override public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      public function getTechItemByIndex(param1:int) : TechnologyItem
      {
         return _itemList[param1];
      }
      
      override public function dispose() : void
      {
         super.dispose();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
      }
   }
}

