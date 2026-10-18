package crosscost.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.FunnyEvent;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.module.crosscost.CrossCostItemData;
   import mvc.module.crosscost.CrossCostModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.NumberViewUtils;
   
   public class CrossCostView extends Sprite implements Disposeable, IManualSize
   {
      
      public static const MAXNUMBER:int = 10;
      
      private var _bg1:Bitmap;
      
      private var _bg2:MutipleImage;
      
      private var _bg5:ScaleBitmapImage;
      
      private var _bg6:ScaleBitmapImage;
      
      private var _titleGap:MutipleImage;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Bitmap;
      
      private var _pageText:FilterFrameText;
      
      private var _firstBtn:SelectedIconButton;
      
      private var _secondBtn:SelectedIconButton;
      
      private var _thirdBtn:SelectedIconButton;
      
      private var _AllBtn:SelectedIconButton;
      
      private var _hBox:HBox;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _currentCostBg:Bitmap;
      
      private var _currentCostSprite:Sprite;
      
      private var _diaglod:Bitmap;
      
      private var _firstCostBg:Bitmap;
      
      private var _firstCostSprite:Sprite;
      
      private var _firstTotalBg:Bitmap;
      
      private var _numberBmp:BitmapData;
      
      private var _currentCostNumber:int = 0;
      
      private var _currentTotalCostNumber:Number = 0;
      
      private var _rankText:FilterFrameText;
      
      private var _userNameText:FilterFrameText;
      
      private var _powerText:FilterFrameText;
      
      private var _agencySeverText:FilterFrameText;
      
      private var _exchanrgeNumberText:FilterFrameText;
      
      private var _itemList:Array;
      
      private var _itemVBox:VBox;
      
      private var _nowPage:int = 1;
      
      private var _total:int;
      
      private var _dataLen:int;
      
      private var _model:CrossCostModel;
      
      public function CrossCostView()
      {
         super();
         _model = FrameControllerManager.instance.crossCostControler.model;
         initView();
         initData();
         _refreshCostHandler(null);
         initEvent();
      }
      
      private function initView() : void
      {
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.crossCostView.bg1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("crosscostView.titile.bg");
         _bg5 = ComponentFactory.Instance.creatComponentByStylename("crossCostView.bg5");
         _bg6 = ComponentFactory.Instance.creatComponentByStylename("crossCostView.bg6");
         _titleGap = ComponentFactory.Instance.creatComponentByStylename("crosscost.rightView.titileGap");
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("crossCostView.firstBtn");
         _secondBtn = ComponentFactory.Instance.creatComponentByStylename("crossCostView.secondBtn");
         _thirdBtn = ComponentFactory.Instance.creatComponentByStylename("crossCostView.thirdBtn");
         _AllBtn = ComponentFactory.Instance.creatComponentByStylename("crosscost,rightView.accumulativeBtn");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("crossCostView.hBox");
         _pageBg = ComponentFactory.Instance.creatBitmap("asset.crossCostView.pageBg");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("crossCostView.prePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("crossCostView.nextPageBtn");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("crossCostView.pageText");
         _currentCostSprite = new Sprite();
         _firstCostSprite = new Sprite();
         _numberBmp = ComponentFactory.Instance.creatBitmapData("asset.crossCostView.numberBg");
         _currentCostBg = ComponentFactory.Instance.creatBitmap("asset.crossCostView.currentCostBg");
         _diaglod = ComponentFactory.Instance.creatBitmap("asset.crossCostView.diaglod");
         _firstCostBg = ComponentFactory.Instance.creatBitmap("asset.crossCostView.firstCostBg");
         _firstTotalBg = ComponentFactory.Instance.creatBitmap("asset.crossCostView.firstTotalBg");
         _currentCostSprite.x = _currentCostBg.x + _currentCostBg.width;
         _diaglod.x = _currentCostSprite.x + _currentCostSprite.width;
         _firstCostSprite.x = _firstCostBg.x + _firstCostBg.width;
         _firstTotalBg.x = _firstCostSprite.x + _firstCostSprite.width;
         _diaglod.y = _currentCostBg.y + 2;
         _currentCostSprite.y = _currentCostBg.y + 2;
         _firstTotalBg.y = _firstCostBg.y;
         _firstCostSprite.y = _firstCostBg.y + 2;
         _rankText = ComponentFactory.Instance.creatComponentByStylename("crosscost.title.rankTextStyle");
         _userNameText = ComponentFactory.Instance.creatComponentByStylename("crosscost.title.userNameTextStyle");
         _powerText = ComponentFactory.Instance.creatComponentByStylename("crosscost.title.powerTextStyle");
         _agencySeverText = ComponentFactory.Instance.creatComponentByStylename("crosscost.title.agencySeverTextStyle");
         _exchanrgeNumberText = ComponentFactory.Instance.creatComponentByStylename("crosscost.title.exchanrgeNumberTextStyle");
         _rankText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.rankText");
         _userNameText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.userNameText");
         _powerText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.powerText1");
         _agencySeverText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.agencyServerText");
         _exchanrgeNumberText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.exchargeNumberText2");
         _selectedBtnGroup = new SelectedButtonGroup();
         addChild(_bg6);
         addChild(_bg5);
         addChild(_bg2);
         addChild(_titleGap);
         addChild(_hBox);
         addChild(_pageBg);
         addChild(_pageText);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         addChild(_rankText);
         addChild(_userNameText);
         addChild(_powerText);
         addChild(_agencySeverText);
         addChild(_exchanrgeNumberText);
         _itemVBox = new VBox();
         _itemVBox.spacing = 2;
         _itemVBox.x = 4;
         _itemVBox.y = 148;
         _itemList = [];
         addChild(_itemVBox);
         _prePageBtn.enable = false;
         _nextPageBtn.enable = false;
      }
      
      private function _refreshData(param1:FunnyEvent) : void
      {
         initView();
         initData();
         _refreshCostHandler(null);
         initEvent();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_bg6);
         _bg6 = null;
         ObjectUtils.disposeObject(_bg5);
         _bg5 = null;
         ObjectUtils.disposeObject(_titleGap);
         _titleGap = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageText);
         _pageText = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_currentCostBg);
         _currentCostBg = null;
         ObjectUtils.disposeObject(_currentCostSprite);
         _currentCostSprite = null;
         ObjectUtils.disposeObject(_diaglod);
         _diaglod = null;
         ObjectUtils.disposeObject(_firstCostBg);
         _firstCostBg = null;
         ObjectUtils.disposeObject(_firstCostSprite);
         _firstCostSprite = null;
         ObjectUtils.disposeObject(_firstTotalBg);
         _firstTotalBg = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_userNameText);
         _userNameText = null;
         ObjectUtils.disposeObject(_powerText);
         _powerText = null;
         ObjectUtils.disposeObject(_agencySeverText);
         _agencySeverText = null;
         ObjectUtils.disposeObject(_exchanrgeNumberText);
         _exchanrgeNumberText = null;
         ObjectUtils.disposeObject(_selectedBtnGroup);
         _selectedBtnGroup = null;
      }
      
      private function initData() : void
      {
         if(_model.len == 1)
         {
            _hBox.addChild(_firstBtn);
            _selectedBtnGroup.addSelectItem(_firstBtn);
         }
         else if(_model.len == 2)
         {
            _hBox.addChild(_firstBtn);
            _selectedBtnGroup.addSelectItem(_firstBtn);
            _hBox.addChild(_secondBtn);
            _selectedBtnGroup.addSelectItem(_secondBtn);
         }
         else if(_model.len >= 3)
         {
            _hBox.addChild(_firstBtn);
            _selectedBtnGroup.addSelectItem(_firstBtn);
            _hBox.addChild(_secondBtn);
            _selectedBtnGroup.addSelectItem(_secondBtn);
            _hBox.addChild(_thirdBtn);
            _selectedBtnGroup.addSelectItem(_thirdBtn);
         }
         if(_selectedBtnGroup && _selectedBtnGroup.itemLength > 0)
         {
            _selectedBtnGroup.selectIndex = _model.len - 1 > 2 ? 2 : _model.len - 1;
            _selectedBtnGroup.addSelectItem(_AllBtn);
            addChild(_AllBtn);
            _selectedHandler(null);
         }
         NumberViewUtils.refreshValue(_currentCostNumber,_currentCostSprite,_numberBmp,12,16,9,12,"0123456789",true);
         NumberViewUtils.refreshValue(_currentTotalCostNumber,_firstCostSprite,_numberBmp,12,16,9,12,"0123456789",true);
         _diaglod.x = _currentCostSprite.x + _currentCostSprite.width;
         _firstTotalBg.x = _firstCostSprite.x + _firstCostSprite.width;
      }
      
      private function initEvent() : void
      {
         if(_selectedBtnGroup)
         {
            _selectedBtnGroup.addEventListener("change",_selectedHandler);
         }
         if(_prePageBtn)
         {
            _prePageBtn.addEventListener("click",_preBtnHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.addEventListener("click",_nextBtnHandler);
         }
         FunnyManager.instance.addEventListener("REFRESH_CURRENT_COST",_refreshCostHandler);
         if(_model)
         {
            _model.addEventListener("REFRESH_CROSS_RANKDATA",_refreshData);
         }
      }
      
      private function removeEvent() : void
      {
         if(_selectedBtnGroup)
         {
            _selectedBtnGroup.removeEventListener("change",_selectedHandler);
         }
         if(_prePageBtn)
         {
            _prePageBtn.removeEventListener("click",_preBtnHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",_nextBtnHandler);
         }
         FunnyManager.instance.removeEventListener("REFRESH_CURRENT_COST",_refreshCostHandler);
         if(_model)
         {
            _model.removeEventListener("REFRESH_CROSS_RANKDATA",_refreshData);
         }
      }
      
      private function _refreshCostHandler(param1:FunnyEvent) : void
      {
         var _loc2_:Object = FunnyManager.instance.model.currentCost;
         if(FunnyManager.instance.model.crossCostFunnyData)
         {
            _currentTotalCostNumber = Number(FunnyManager.instance.model.crossCostFunnyData.appendParam);
         }
         NumberViewUtils.refreshValue(_currentTotalCostNumber,_firstCostSprite,_numberBmp,12,16,9,12,"0123456789",false);
         if(_loc2_)
         {
            _currentCostNumber = _loc2_.threeTotalValue;
            NumberViewUtils.refreshValue(_currentCostNumber,_currentCostSprite,_numberBmp,12,16,9,12,"0123456789",false);
         }
         _diaglod.x = _currentCostSprite.x + _currentCostSprite.width;
         _firstTotalBg.x = _firstCostSprite.x + _firstCostSprite.width;
      }
      
      private function _selectedHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_selectedBtnGroup.getSelectedItem())
         {
            case _firstBtn:
               initDayRankData(0);
               break;
            case _secondBtn:
               initDayRankData(1);
               break;
            case _thirdBtn:
               initDayRankData(2);
               break;
            case _AllBtn:
               initDayRankData(3);
         }
      }
      
      private function initDayRankData(param1:int) : void
      {
         _itemList = _model.crossCostRankList[param1];
         _dataLen = 0;
         if(_itemList)
         {
            _dataLen = _itemList.length;
         }
         _nowPage = 1;
         refreshView(_itemList);
      }
      
      private function refreshView(param1:Array) : void
      {
         if(param1)
         {
            param1.sortOn("rank",16);
            if(param1.length <= 10)
            {
               _prePageBtn.enable = false;
               _nextPageBtn.enable = false;
            }
            else
            {
               _prePageBtn.enable = false;
               _nextPageBtn.enable = true;
            }
         }
         else
         {
            _prePageBtn.enable = false;
            _nextPageBtn.enable = false;
         }
         initVBoxData();
         refreshPageText();
      }
      
      private function _preBtnHandler(param1:MouseEvent) : void
      {
         if(_nowPage > 1)
         {
            _nowPage = _nowPage - 1;
         }
         _prePageBtn.enable = _nowPage > 1;
         _nextPageBtn.enable = _nowPage < _total;
         refreshPageText();
         changeVBoxData();
      }
      
      private function _nextBtnHandler(param1:MouseEvent) : void
      {
         if(_nowPage < _total)
         {
            _nowPage = _nowPage + 1;
         }
         _prePageBtn.enable = _nowPage > 1;
         _nextPageBtn.enable = _nowPage < _total;
         refreshPageText();
         changeVBoxData();
      }
      
      private function refreshPageText() : void
      {
         _total = Math.ceil(_dataLen / 10);
         if(_total == 0)
         {
            _total = 1;
         }
         _pageText.text = _nowPage + "/" + _total;
      }
      
      private function initVBoxData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CrossCostItem = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(_itemVBox)
         {
            _itemVBox.disposeAllChildren();
         }
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new CrossCostItem();
            _itemVBox.addChild(_loc1_);
            _loc2_++;
         }
         if(_dataLen > 10)
         {
            _loc4_ = 0;
            while(_loc4_ < 10)
            {
               (_itemVBox.getChildAt(_loc4_) as CrossCostItem).data = _itemList[_loc4_] as CrossCostItemData;
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _dataLen)
            {
               (_itemVBox.getChildAt(_loc3_) as CrossCostItem).data = _itemList[_loc3_] as CrossCostItemData;
               _loc3_++;
            }
         }
      }
      
      private function changeVBoxData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:CrossCostItem = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(_itemVBox)
         {
            _itemVBox.disposeAllChildren();
         }
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc1_ = new CrossCostItem();
            _itemVBox.addChild(_loc1_);
            _loc3_++;
         }
         var _loc6_:Array = new Array(10);
         var _loc2_:int = 0;
         _loc5_ = (_nowPage - 1) * 10;
         while(_loc5_ < _nowPage * 10)
         {
            if(_dataLen >= _loc5_)
            {
               _loc2_++;
               _loc6_[_loc2_ - 1] = _itemList[_loc5_];
            }
            _loc5_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            (_itemVBox.getChildAt(_loc4_) as CrossCostItem).data = _loc6_[_loc4_] as CrossCostItemData;
            _loc4_++;
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         KeyBoardRegister.instance.keyEnable = true;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

