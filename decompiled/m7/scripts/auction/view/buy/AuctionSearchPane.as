package auction.view.buy
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.auction.AuctionModel;
   import yishi.utils.MsgMan;
   
   public class AuctionSearchPane extends Sprite implements Disposeable
   {
      
      private var _nameLabel:Bitmap;
      
      private var _nameInputBack:Bitmap;
      
      public var nameInput:TextInput;
      
      private var _gradeLabel:Bitmap;
      
      public var gradeCombo:ComboBox;
      
      private var _qualityLabel:Bitmap;
      
      public var qualityCombo:ComboBox;
      
      private var _jobLabel:Bitmap;
      
      public var jobCombo:ComboBox;
      
      public var availableCheckBtn:SelectedButton;
      
      private var _availableLabel:Bitmap;
      
      public var searchBtn:BaseButton;
      
      public var resetBtn:BaseButton;
      
      public var nameTextClicked:Boolean;
      
      private var _hotSearchImage:Bitmap;
      
      private var _hotSearchList:Vector.<HotSearchItem>;
      
      private var _txtChange:String = "";
      
      public function AuctionSearchPane()
      {
         super();
         initView();
         initData();
         addEvent();
         refreshResetBtnState();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:HotSearchItem = null;
         _nameLabel = ComponentFactory.Instance.creatBitmap("asset.auction.searchNameLabelBMD");
         _nameInputBack = ComponentFactory.Instance.creatBitmap("asset.auction.searchNameInputBackBMD");
         nameInput = ComponentFactory.Instance.creatComponentByStylename("auction.searchInputTxt");
         _gradeLabel = ComponentFactory.Instance.creatBitmap("asset.auction.searchGradeLabelBMD");
         _qualityLabel = ComponentFactory.Instance.creatBitmap("asset.auction.searchQualityLabelBMD");
         _jobLabel = ComponentFactory.Instance.creatBitmap("asset.auction.searchJobLabelBMD");
         _availableLabel = ComponentFactory.Instance.creatBitmap("asset.auction.searchAvailableLabelBMD");
         resetBtn = ComponentFactory.Instance.creatComponentByStylename("auction.search.resetBtn");
         searchBtn = ComponentFactory.Instance.creatComponentByStylename("auction.search.searchBtn");
         availableCheckBtn = ComponentFactory.Instance.creatComponentByStylename("auction.search.availableBtn");
         gradeCombo = ComponentFactory.Instance.creatComponentByStylename("auction.SearchGradeComboBox");
         qualityCombo = ComponentFactory.Instance.creatComponentByStylename("auction.SearchQualityComboBox");
         jobCombo = ComponentFactory.Instance.creatComponentByStylename("auction.SearchJobComboBox");
         _hotSearchImage = ComponentFactory.Instance.creatBitmap("asset.auction.hotSearchImage");
         _nameInputBack.x = 44.5;
         _nameInputBack.y = 5.25;
         addChild(_nameLabel);
         addChild(_nameInputBack);
         addChild(nameInput);
         nameInput.textField.maxChars = 16;
         nameInput.textField.wordWrap = false;
         nameInput.text = LanguageMgr.GetTranslation("Auction.Search.EnterGoodName");
         gradeCombo.textField.text = LanguageMgr.GetTranslation("Auction.Search.PleaseSelect");
         qualityCombo.textField.text = LanguageMgr.GetTranslation("Auction.Search.PleaseSelect");
         jobCombo.textField.text = LanguageMgr.GetTranslation("Auction.Search.PleaseSelect");
         addChild(_gradeLabel);
         addChild(_qualityLabel);
         addChild(_jobLabel);
         addChild(_availableLabel);
         addChild(resetBtn);
         addChild(searchBtn);
         addChild(availableCheckBtn);
         addChild(gradeCombo);
         addChild(qualityCombo);
         addChild(jobCombo);
         addChild(_hotSearchImage);
         _hotSearchList = new Vector.<HotSearchItem>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new HotSearchItem();
            _loc1_.index = _loc2_;
            addChild(_loc1_);
            _hotSearchList.push(_loc1_);
            if(_loc2_ == 0)
            {
               _loc1_.x = 208;
            }
            else
            {
               _loc1_.x = _hotSearchList[_loc2_ - 1].x + _hotSearchList[_loc2_ - 1].displayWidth + 40 + (_loc2_ - 1) * 5;
            }
            _loc1_.y = 31;
            if(_loc2_ == 3 || _loc2_ == 4 || _loc2_ == 5)
            {
               _loc1_.x = _hotSearchList[_loc2_ - 3].x;
               _loc1_.y = 56;
            }
            _loc2_++;
         }
      }
      
      private function initData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = null;
         _loc1_ = AuctionModel.getGradeComboData();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            gradeCombo.listPanel.vectorListModel.append(_loc1_[_loc2_]);
            _loc2_++;
         }
         _loc1_ = AuctionModel.getQualityComboData();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            qualityCombo.listPanel.vectorListModel.append(_loc1_[_loc2_]);
            _loc2_++;
         }
         _loc1_ = AuctionModel.getJobComboData();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            jobCombo.listPanel.vectorListModel.append(_loc1_[_loc2_]);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         resetBtn.addEventListener("click",onResetBtnClick);
         nameInput.addEventListener("change",__onTxtChange);
         nameInput.addEventListener("click",onNameInputClick);
         nameInput.textField.addEventListener("focusOut",outNameInput);
         gradeCombo.addEventListener("stateChange",onComboStateChange);
         qualityCombo.addEventListener("stateChange",onComboStateChange);
         jobCombo.addEventListener("stateChange",onComboStateChange);
         availableCheckBtn.addEventListener("select",onAvailableBtnSelect);
         MsgMan.addObserver("ICON_DOUBLE_CLICK",this,clickIconHandler);
      }
      
      private function clickIconHandler(param1:String, param2:Object) : void
      {
         nameInput.text = param2 as String;
         nameTextClicked = true;
      }
      
      private function removeEvent() : void
      {
         if(resetBtn)
         {
            resetBtn.removeEventListener("click",onResetBtnClick);
         }
         if(nameInput)
         {
            nameInput.removeEventListener("change",__onTxtChange);
            nameInput.removeEventListener("click",onNameInputClick);
            if(nameInput.textField)
            {
               nameInput.textField.removeEventListener("focusOut",outNameInput);
            }
         }
         if(gradeCombo)
         {
            gradeCombo.removeEventListener("stateChange",onComboStateChange);
         }
         if(qualityCombo)
         {
            qualityCombo.removeEventListener("stateChange",onComboStateChange);
         }
         if(jobCombo)
         {
            jobCombo.removeEventListener("stateChange",onComboStateChange);
         }
         if(availableCheckBtn)
         {
            availableCheckBtn.removeEventListener("select",onAvailableBtnSelect);
         }
         MsgMan.removeObserver("ICON_DOUBLE_CLICK",this,clickIconHandler);
      }
      
      private function onAvailableBtnSelect(param1:Event) : void
      {
         refreshResetBtnState();
      }
      
      private function onComboStateChange(param1:InteractiveEvent) : void
      {
         refreshResetBtnState();
         if(param1.target.textField.text != LanguageMgr.GetTranslation("Auction.Search.PleaseSelect"))
         {
            param1.target.textField.textColor = 15523745;
         }
      }
      
      protected function outNameInput(param1:FocusEvent) : void
      {
         if(nameInput.text == "")
         {
            nameInput.text = LanguageMgr.GetTranslation("Auction.Search.EnterGoodName");
            nameTextClicked = false;
         }
         refreshResetBtnState();
      }
      
      private function refreshResetBtnState() : void
      {
         if((nameInput.text == "" || nameTextClicked == false) && !gradeCombo.currentSelectedCellValue && !qualityCombo.currentSelectedCellValue && !jobCombo.currentSelectedCellValue && !availableCheckBtn.selected)
         {
            resetBtn.enable = false;
         }
         else
         {
            resetBtn.enable = true;
         }
      }
      
      private function onNameInputClick(param1:MouseEvent) : void
      {
         if(!nameTextClicked)
         {
            nameInput.text = "";
            nameTextClicked = true;
         }
      }
      
      private function onResetBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         nameInput.text = LanguageMgr.GetTranslation("Auction.Search.EnterGoodName");
         gradeCombo.textField.text = LanguageMgr.GetTranslation("Auction.Search.PleaseSelect");
         qualityCombo.textField.text = LanguageMgr.GetTranslation("Auction.Search.PleaseSelect");
         jobCombo.textField.text = LanguageMgr.GetTranslation("Auction.Search.PleaseSelect");
         gradeCombo.listPanel.scrollToTop();
         qualityCombo.listPanel.scrollToTop();
         jobCombo.listPanel.scrollToTop();
         gradeCombo.reset();
         qualityCombo.reset();
         jobCombo.reset();
         availableCheckBtn.selected = false;
         nameTextClicked = false;
         resetBtn.enable = false;
      }
      
      private function __onTxtChange(param1:Event) : void
      {
         var _loc2_:int = int(nameInput.text.replace(/[^\x00-\xff]/g,"xx").length);
         if(_loc2_ > 16)
         {
            nameInput.text = _txtChange;
            trace(nameInput.text,_txtChange);
         }
         _txtChange = nameInput.text;
         trace(nameInput.text,_txtChange);
         if(nameInput.text == LanguageMgr.GetTranslation("Auction.Search.EnterGoodName"))
         {
            nameInput.textField.textColor = 8547171;
         }
         else
         {
            nameInput.textField.textColor = 15523745;
         }
      }
      
      private function cleanList() : void
      {
         if(!_hotSearchList)
         {
            return;
         }
         while(_hotSearchList.length > 0)
         {
            _hotSearchList.pop().dispose();
         }
         _hotSearchList = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         cleanList();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

