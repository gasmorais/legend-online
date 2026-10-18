package exchargerank.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.exchargerank.ExchargeRankData;
   import yishi.manager.FrameControllerManager;
   
   public class ExchargeCrossSerRankView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _titleShineBg:Scale9CornerImage;
      
      private var _firstDayBtn:SelectedIconButton;
      
      private var _secondDayBtn:SelectedIconButton;
      
      private var _thirdDayBtn:SelectedIconButton;
      
      private var _fourDayBtn:SelectedIconButton;
      
      private var _fiveDayBtn:SelectedIconButton;
      
      private var _accumulativeBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _buttonHBox:HBox;
      
      private var _rankText:FilterFrameText;
      
      private var _userNameText:FilterFrameText;
      
      private var _powerText:FilterFrameText;
      
      private var _agencySeverText:FilterFrameText;
      
      private var _exchanrgeNumberText:FilterFrameText;
      
      private var _titleGap:MutipleImage;
      
      private var _itemList:Array;
      
      private var _itemVBox:VBox;
      
      private var _preBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _bottomBg:Bitmap;
      
      private var _pageBg:Bitmap;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _rightBg:ScaleBitmapImage;
      
      private var _nowPage:int = 1;
      
      private var _total:Number;
      
      public function ExchargeCrossSerRankView()
      {
         super();
         initView();
         initEvent();
         initButton();
         initVBoxData();
         refreshVBoxData();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return null;
      }
      
      private function initView() : void
      {
         _titleGap = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rightView.titileGap");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("exchargeRankFrame.rightBack");
         _firstDayBtn = ComponentFactory.Instance.creatComponentByStylename("exchargerank,rightView.firstBtn");
         _secondDayBtn = ComponentFactory.Instance.creatComponentByStylename("exchargerank,rightView.secondBtn");
         _thirdDayBtn = ComponentFactory.Instance.creatComponentByStylename("exchargerank,rightView.thirdBtn");
         _fourDayBtn = ComponentFactory.Instance.creatComponentByStylename("exchargerank,rightView.fourBtn");
         _fiveDayBtn = ComponentFactory.Instance.creatComponentByStylename("exchargerank,rightView.fiveBtn");
         _accumulativeBtn = ComponentFactory.Instance.creatComponentByStylename("exchargerank,rightView.accumulativeBtn");
         _buttonHBox = ComponentFactory.Instance.creatComponentByStylename("exchargerank.selectedIconButtonHbox");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rightView.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rightView.nextBtn");
         _titleShineBg = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rightView.titleShineBg");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rightView.rankTextStyle");
         _userNameText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rightView.userNameTextStyle");
         _powerText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rightView.powerTextStyle");
         _agencySeverText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rightView.agencySeverTextStyle");
         _exchanrgeNumberText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rightView.exchanrgeNumberTextStyle");
         _pageBg = ComponentFactory.Instance.creatBitmap("asset.exchargerank.rightView.pageBg");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rightView.pageTextStyle1");
         addChild(_rightBg);
         addChild(_titleShineBg);
         addChild(_titleGap);
         addChild(_pageBg);
         addChild(_rankText);
         addChild(_userNameText);
         addChild(_powerText);
         addChild(_agencySeverText);
         addChild(_exchanrgeNumberText);
         addChild(_pageNumTxt);
         _buttonHBox.addChild(_firstDayBtn);
         _buttonHBox.addChild(_secondDayBtn);
         _buttonHBox.addChild(_thirdDayBtn);
         _buttonHBox.addChild(_fourDayBtn);
         _buttonHBox.addChild(_fiveDayBtn);
         _firstDayBtn.visible = false;
         _secondDayBtn.visible = false;
         _thirdDayBtn.visible = false;
         _fourDayBtn.visible = false;
         _fiveDayBtn.visible = false;
         addChild(_buttonHBox);
         addChild(_accumulativeBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_firstDayBtn);
         _btnGroup.addSelectItem(_secondDayBtn);
         _btnGroup.addSelectItem(_thirdDayBtn);
         _btnGroup.addSelectItem(_fourDayBtn);
         _btnGroup.addSelectItem(_fiveDayBtn);
         _btnGroup.addSelectItem(_accumulativeBtn);
         addChild(_preBtn);
         addChild(_nextBtn);
         _itemVBox = new VBox();
         _itemVBox.spacing = 4;
         _itemVBox.x = 160;
         _itemVBox.y = 30;
         _itemList = [];
         addChild(_itemVBox);
         _rankText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.rankText");
         _userNameText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.userNameText");
         _powerText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.powerText1");
         _agencySeverText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.agencyServerText");
         _exchanrgeNumberText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.exchargeNumberText");
         initPageText();
         _nextBtn.enable = false;
         _preBtn.enable = false;
      }
      
      private function initPageText() : void
      {
         var _loc1_:int = 0;
         if(_itemList)
         {
            _loc1_ = int(_itemList.length);
            if(_loc1_ > 10)
            {
               if(_loc1_ % 10 == 0)
               {
                  _total = _loc1_ / 10;
               }
               else
               {
                  _total = Math.floor(_loc1_ / 10) + 1;
               }
            }
            else
            {
               _total = 1;
            }
            _pageNumTxt.text = _nowPage + "/" + _total;
         }
         else
         {
            _pageNumTxt.text = "1/1";
         }
      }
      
      private function initButton() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Array = FrameControllerManager.instance.exchargeAllControler.model.exchargeRankList;
         if(_loc2_)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_.length)
            {
               if(_loc2_[_loc1_] != null && _loc2_[_loc1_][0].day == 1)
               {
                  _firstDayBtn.visible = true;
                  _btnGroup.selectIndex = 0;
                  __selectedChangHandler(null);
               }
               if(_loc2_[_loc1_] != null && _loc2_[_loc1_][0].day == 2)
               {
                  _firstDayBtn.visible = true;
                  _secondDayBtn.visible = true;
                  _btnGroup.selectIndex = 1;
                  __selectedChangHandler(null);
               }
               if(_loc2_[_loc1_] != null && _loc2_[_loc1_][0].day == 3)
               {
                  _firstDayBtn.visible = true;
                  _secondDayBtn.visible = true;
                  _thirdDayBtn.visible = true;
                  _btnGroup.selectIndex = 2;
                  __selectedChangHandler(null);
               }
               if(_loc2_[_loc1_] != null && _loc2_[_loc1_][0].day == 4)
               {
                  _firstDayBtn.visible = true;
                  _secondDayBtn.visible = true;
                  _thirdDayBtn.visible = true;
                  _fourDayBtn.visible = true;
                  _btnGroup.selectIndex = 3;
                  __selectedChangHandler(null);
               }
               if(_loc2_[_loc1_] != null && _loc2_[_loc1_][0].day == 5)
               {
                  _firstDayBtn.visible = true;
                  _secondDayBtn.visible = true;
                  _thirdDayBtn.visible = true;
                  _fourDayBtn.visible = true;
                  _fiveDayBtn.visible = true;
                  _btnGroup.selectIndex = 4;
                  __selectedChangHandler(null);
               }
               _loc1_++;
            }
         }
      }
      
      private function initEvent() : void
      {
         _preBtn.addEventListener("click",__preBtnHandler);
         _nextBtn.addEventListener("click",__nextBtnHandler);
         _btnGroup.addEventListener("change",__selectedChangHandler);
      }
      
      private function refreshPageButtonState() : void
      {
         _pageNumTxt.text = _nowPage + "/" + _total;
         _preBtn.enable = _nowPage > 1;
         _nextBtn.enable = _nowPage < _total;
      }
      
      private function __preBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _nowPage = _nowPage - 1;
         initPageText();
         initVBoxData();
         refreshPageButtonState();
         var _loc4_:Array = [];
         _loc2_ = (_nowPage - 1) * 10;
         while(_loc2_ < _nowPage * 10)
         {
            _loc4_.push(_itemList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            (_itemVBox.getChildAt(_loc3_) as ExchargeDataItem).data = _loc4_[_loc3_] as ExchargeRankData;
            _loc3_++;
         }
      }
      
      private function __nextBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _nowPage = _nowPage + 1;
         initPageText();
         initVBoxData();
         refreshPageButtonState();
         var _loc4_:Array = [];
         _loc2_ = (_nowPage - 1) * 10;
         while(_loc2_ < _nowPage * 10)
         {
            _loc4_.push(_itemList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            (_itemVBox.getChildAt(_loc3_) as ExchargeDataItem).data = _loc4_[_loc3_] as ExchargeRankData;
            _loc3_++;
         }
      }
      
      private function removeEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnHandler);
         }
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__selectedChangHandler);
         }
      }
      
      private function initVBoxData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ExchargeDataItem = null;
         if(_itemVBox)
         {
            _itemVBox.removeAllChild();
         }
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new ExchargeDataItem();
            _itemVBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshVBoxData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         initVBoxData();
         if(!_itemList)
         {
            return;
         }
         var _loc1_:int = int(_itemList.length);
         if(_loc1_ > 10)
         {
            _loc2_ = 0;
            while(_loc2_ < 10)
            {
               (_itemVBox.getChildAt(_loc2_) as ExchargeDataItem).data = _itemList[_loc2_] as ExchargeRankData;
               _loc2_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               (_itemVBox.getChildAt(_loc3_) as ExchargeDataItem).data = _itemList[_loc3_] as ExchargeRankData;
               _loc3_++;
            }
         }
      }
      
      private function accumulativeBtn() : void
      {
         _itemList = FrameControllerManager.instance.exchargeAllControler.model.exchargeRankList[0];
         initPageData(_itemList);
      }
      
      private function firstDayBtn() : void
      {
         _itemList = FrameControllerManager.instance.exchargeAllControler.model.exchargeRankList[1];
         initPageData(_itemList);
      }
      
      private function secondDayBtn() : void
      {
         _itemList = FrameControllerManager.instance.exchargeAllControler.model.exchargeRankList[2];
         initPageData(_itemList);
      }
      
      private function thirdDayBtn() : void
      {
         _itemList = FrameControllerManager.instance.exchargeAllControler.model.exchargeRankList[3];
         initPageData(_itemList);
      }
      
      private function fourDayBtn() : void
      {
         _itemList = FrameControllerManager.instance.exchargeAllControler.model.exchargeRankList[4];
         initPageData(_itemList);
      }
      
      private function fiveDayBtn() : void
      {
         _itemList = FrameControllerManager.instance.exchargeAllControler.model.exchargeRankList[5];
         initPageData(_itemList);
      }
      
      private function initPageData(param1:Array) : void
      {
         if(param1)
         {
            param1.sortOn("rank",16);
            if(param1.length <= 10)
            {
               _preBtn.enable = false;
               _nextBtn.enable = false;
            }
            else
            {
               _preBtn.enable = false;
               _nextBtn.enable = true;
            }
         }
         else
         {
            _preBtn.enable = false;
            _nextBtn.enable = false;
         }
         refreshVBoxData();
         _nowPage = 1;
         initPageText();
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_btnGroup.getSelectedItem())
         {
            case _firstDayBtn:
               firstDayBtn();
               break;
            case _secondDayBtn:
               secondDayBtn();
               break;
            case _thirdDayBtn:
               thirdDayBtn();
               break;
            case _fourDayBtn:
               fourDayBtn();
               break;
            case _fiveDayBtn:
               fiveDayBtn();
               break;
            case _accumulativeBtn:
               accumulativeBtn();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleGap);
         _titleGap = null;
         ObjectUtils.disposeObject(_titleShineBg);
         _titleShineBg = null;
         ObjectUtils.disposeObject(_firstDayBtn);
         _firstDayBtn = null;
         ObjectUtils.disposeObject(_secondDayBtn);
         _secondDayBtn = null;
         ObjectUtils.disposeObject(_thirdDayBtn);
         _thirdDayBtn = null;
         ObjectUtils.disposeObject(_fourDayBtn);
         _fourDayBtn = null;
         ObjectUtils.disposeObject(_fiveDayBtn);
         _fiveDayBtn = null;
         ObjectUtils.disposeObject(_accumulativeBtn);
         _accumulativeBtn = null;
         ObjectUtils.disposeObject(_buttonHBox);
         _buttonHBox = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
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
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         if(_itemList)
         {
            ObjectUtils.disposeObject(_itemList);
            _itemList = null;
         }
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

