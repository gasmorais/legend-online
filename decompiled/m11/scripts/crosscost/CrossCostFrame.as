package crosscost
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import crosscost.view.CrossCostRewardView;
   import crosscost.view.CrossCostView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.FunnyEvent;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.controler.CrossCostController;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.DateFormatter;
   
   public class CrossCostFrame extends Frame implements IManualSize
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _leftVBox:VBox;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _helpBtn:BaseButton;
      
      private var _crossCostBtn:SelectedIconButton;
      
      private var _crossCostRewardBtn:SelectedIconButton;
      
      private var _noCrossCostRewardBtn:SelectedIconButton;
      
      private var _todayBg:Bitmap;
      
      private var _todayCostBmp:Bitmap;
      
      private var _totalCountBmp:Bitmap;
      
      private var _todayTxtBg:Bitmap;
      
      private var _todayTxtBg1:Bitmap;
      
      private var _myTodayCostText:FilterFrameText;
      
      private var _myTotalCount:FilterFrameText;
      
      private var _tipText:FilterFrameText;
      
      private var _crossCostView:CrossCostView;
      
      private var _crossCostRewardView:CrossCostRewardView;
      
      private var _controller:CrossCostController;
      
      public function CrossCostFrame()
      {
         super();
         _controller = FrameControllerManager.instance.crossCostControler;
         _controller.isOpenCrossCostFrame = true;
         FunnyManager.instance.sendGetBag(1);
         initDay();
         if(_controller)
         {
            _controller.sendInfo();
         }
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("crossCostFrame.back");
         _leftVBox = ComponentFactory.Instance.creatComponentByStylename("crossCostFrame.leftVBox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("crossCostFrame.helpbtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("exchargerankFrame.helpBtn.tipText");
         _crossCostBtn = ComponentFactory.Instance.creatComponentByStylename("crossCostFrame.crossCostBtn");
         _crossCostRewardBtn = ComponentFactory.Instance.creatComponentByStylename("crossCostFrame.crossCostRewardBtn");
         _noCrossCostRewardBtn = ComponentFactory.Instance.creatComponentByStylename("crossCostFrame.noCrossCostRewardBtn");
         _selectedBtnGroup = new SelectedButtonGroup();
         _todayBg = ComponentFactory.Instance.creatBitmap("asset.exchargerank.todayBg");
         _todayCostBmp = ComponentFactory.Instance.creatBitmap("asset.exchargerank.todayCostBmp");
         _totalCountBmp = ComponentFactory.Instance.creatBitmap("asset.exchargerank.totalCountBmp");
         _todayTxtBg = ComponentFactory.Instance.creatBitmap("asset.exchargerank.todayTxtBg");
         _todayTxtBg1 = ComponentFactory.Instance.creatBitmap("asset.exchargerank.todayTxtBg1");
         _myTodayCostText = ComponentFactory.Instance.creatComponentByStylename("crosscost.MyTodayCostText");
         _myTotalCount = ComponentFactory.Instance.creatComponentByStylename("crosscost.MyTotalCount");
         _tipText = ComponentFactory.Instance.creatComponentByStylename("crosscost.MainFrameTipText");
         addToContent(_bg);
         addToContent(_helpBtn);
         addToContent(_leftVBox);
         addToContent(_todayBg);
         addToContent(_todayCostBmp);
         addToContent(_totalCountBmp);
         addToContent(_todayTxtBg);
         addToContent(_todayTxtBg1);
         addToContent(_myTodayCostText);
         addToContent(_myTotalCount);
         addToContent(_tipText);
         _tipText.text = LanguageMgr.GetTranslation("crosscost.CrossCostFrame.Tip01");
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftVBox);
         _leftVBox = null;
         ObjectUtils.disposeObject(_selectedBtnGroup);
         _selectedBtnGroup = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_crossCostBtn);
         _crossCostBtn = null;
         ObjectUtils.disposeObject(_crossCostRewardBtn);
         _crossCostRewardBtn = null;
         ObjectUtils.disposeObject(_noCrossCostRewardBtn);
         _noCrossCostRewardBtn = null;
         ObjectUtils.disposeObject(_todayBg);
         _todayBg = null;
         ObjectUtils.disposeObject(_todayCostBmp);
         _todayCostBmp = null;
         ObjectUtils.disposeObject(_totalCountBmp);
         _totalCountBmp = null;
         ObjectUtils.disposeObject(_todayTxtBg);
         _todayTxtBg = null;
         ObjectUtils.disposeObject(_todayTxtBg1);
         _todayTxtBg1 = null;
         ObjectUtils.disposeObject(_myTodayCostText);
         _myTodayCostText = null;
         ObjectUtils.disposeObject(_myTotalCount);
         _myTotalCount = null;
         ObjectUtils.disposeObject(_tipText);
         _tipText = null;
         ObjectUtils.disposeObject(_crossCostView);
         _crossCostView = null;
         ObjectUtils.disposeObject(_crossCostRewardView);
         _crossCostRewardView = null;
         _controller.isOpenCrossCostFrame = false;
         _controller = null;
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      private function initDay() : void
      {
         var _loc2_:Date = FunnyManager.instance.model.openDate;
         var _loc1_:int = int(DateFormatter.compareDay(_loc2_));
         if(_loc1_ > 3)
         {
            _loc1_ = 3;
         }
         FrameControllerManager.instance.crossCostControler.model.len = _loc1_;
      }
      
      private function initData() : void
      {
         if(_leftVBox)
         {
            _leftVBox.disposeAllChildren();
         }
         if(FunnyManager.instance.model.crossCostFunnyData && FunnyManager.instance.model.notCrossCostFunnyData)
         {
            if(_leftVBox && _selectedBtnGroup)
            {
               _leftVBox.addChild(_crossCostBtn);
               _selectedBtnGroup.addSelectItem(_crossCostBtn);
               _leftVBox.addChild(_crossCostRewardBtn);
               _selectedBtnGroup.addSelectItem(_crossCostRewardBtn);
               _leftVBox.addChild(_noCrossCostRewardBtn);
               _selectedBtnGroup.addSelectItem(_noCrossCostRewardBtn);
            }
         }
         else if(FunnyManager.instance.model.crossCostFunnyData && !FunnyManager.instance.model.notCrossCostFunnyData)
         {
            if(_leftVBox && _selectedBtnGroup)
            {
               _leftVBox.addChild(_crossCostBtn);
               _selectedBtnGroup.addSelectItem(_crossCostBtn);
               _leftVBox.addChild(_crossCostRewardBtn);
               _selectedBtnGroup.addSelectItem(_crossCostRewardBtn);
            }
         }
         else if(!FunnyManager.instance.model.crossCostFunnyData && FunnyManager.instance.model.notCrossCostFunnyData)
         {
            if(_leftVBox && _selectedBtnGroup)
            {
               _leftVBox.addChild(_noCrossCostRewardBtn);
               _selectedBtnGroup.addSelectItem(_noCrossCostRewardBtn);
               _noCrossCostRewardBtn.y = 0;
            }
         }
         if(_selectedBtnGroup && _selectedBtnGroup.itemLength > 0)
         {
            _selectedBtnGroup.selectIndex = 0;
            _selectedHandler(null);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_frameResponse);
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",_helpBtnHandler);
         }
         if(_selectedBtnGroup)
         {
            _selectedBtnGroup.addEventListener("change",_selectedHandler);
         }
         FunnyManager.instance.addEventListener("REFRESH_NOTCROSSCOST_REWARD",_refreshData);
         FunnyManager.instance.addEventListener("REFRESH_CROSSCOST_REWARD",_refreshCrossData);
         FunnyManager.instance.addEventListener("REFRESH_CURRENT_COST",_refreshCrossData);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_frameResponse);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",_helpBtnHandler);
         }
         if(_selectedBtnGroup)
         {
            _selectedBtnGroup.removeEventListener("change",_selectedHandler);
         }
         FunnyManager.instance.removeEventListener("REFRESH_NOTCROSSCOST_REWARD",_refreshData);
         FunnyManager.instance.removeEventListener("REFRESH_CROSSCOST_REWARD",_refreshCrossData);
         FunnyManager.instance.removeEventListener("REFRESH_CURRENT_COST",_refreshCrossData);
      }
      
      private function _refreshCrossData(param1:FunnyEvent) : void
      {
         if(_crossCostRewardView && _selectedBtnGroup && _selectedBtnGroup.getSelectedItem() == _crossCostRewardBtn)
         {
            _crossCostRewardView.data = FunnyManager.instance.model.crossCostFunnyData;
         }
         if(FunnyManager.instance.model.currentCost)
         {
            _myTodayCostText.text = FunnyManager.instance.model.currentCost.dayTotalCount + "";
            _myTotalCount.text = FunnyManager.instance.model.currentCost.myTotalCount + "";
         }
      }
      
      private function _refreshData(param1:FunnyEvent) : void
      {
         if(_crossCostRewardView && _selectedBtnGroup && _selectedBtnGroup.getSelectedItem() == _noCrossCostRewardBtn)
         {
            _crossCostRewardView.data = FunnyManager.instance.model.notCrossCostFunnyData;
         }
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function _helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("crosscost.help");
         _loc2_["show"]();
      }
      
      private function _selectedHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_selectedBtnGroup.getSelectedItem())
         {
            case _crossCostBtn:
               crossCostBtnHandlde(null);
               break;
            case _crossCostRewardBtn:
               crossCostRewardBtnHandler(null);
               break;
            case _noCrossCostRewardBtn:
               noCrossCostRewardBtnHandler(null);
         }
      }
      
      private function crossCostBtnHandlde(param1:MouseEvent) : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.TopToolsBar.crosscost.title1");
         if(_crossCostRewardView && _crossCostRewardView.parent)
         {
            _crossCostRewardView.parent.removeChild(_crossCostRewardView);
         }
         if(_crossCostView == null)
         {
            _crossCostView = new CrossCostView();
            _crossCostView.x = 158;
            _crossCostView.y = -59;
         }
         if(_controller)
         {
            _controller.loadXML();
         }
         addToContent(_crossCostView);
      }
      
      private function crossCostRewardBtnHandler(param1:MouseEvent) : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.TopToolsBar.crosscost.title2");
         if(_crossCostView && _crossCostView.parent)
         {
            _crossCostView.parent.removeChild(_crossCostView);
         }
         if(_crossCostRewardView == null)
         {
            _crossCostRewardView = new CrossCostRewardView();
            _crossCostRewardView.x = 158;
            _crossCostRewardView.y = 20;
         }
         _crossCostRewardView.data = FunnyManager.instance.model.crossCostFunnyData;
         addToContent(_crossCostRewardView);
      }
      
      private function noCrossCostRewardBtnHandler(param1:MouseEvent) : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.TopToolsBar.crosscost.title3");
         if(_crossCostView && _crossCostView.parent)
         {
            _crossCostView.parent.removeChild(_crossCostView);
         }
         if(_crossCostRewardView == null)
         {
            _crossCostRewardView = new CrossCostRewardView();
            _crossCostRewardView.x = 158;
            _crossCostRewardView.y = 20;
         }
         _crossCostRewardView.data = FunnyManager.instance.model.notCrossCostFunnyData;
         addToContent(_crossCostRewardView);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,765,515);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

