package luckyexchange
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.manager.LuckyExchangeManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class LuckyExchangeFrame extends Frame implements IManualSize
   {
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _luckyRightView:LuckyExchangeRightView;
      
      private var _back:ScaleBitmapImage;
      
      private var _bg:Bitmap;
      
      private var _separationLine:Bitmap;
      
      private var _leftVBox:VBox;
      
      private var _current:int = 1;
      
      private var _total:int = 1;
      
      private var _pageSp:Component;
      
      private var _pageBack:Image;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageText:FilterFrameText;
      
      private var _startNum:int;
      
      private var _endNum:int;
      
      private const NUM:int = 9;
      
      private var _showData:Array = [];
      
      public function LuckyExchangeFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         _selectedBtnGroup.selectIndex = 0;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,863,655);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc2_:Date = null;
         var _loc4_:Date = null;
         var _loc3_:Number = NaN;
         var _loc1_:int = 0;
         titleText = LanguageMgr.GetTranslation("luckyexchange.LuckyExchangeFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.luckyexchange.rightViewBg");
         _back = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.MainBgBorder");
         _separationLine = ComponentFactory.Instance.creatBitmap("asset.luckyexchange.separationLine");
         _leftVBox = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.leftVBox");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.nextBtn");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.pageText");
         _pageBack = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.PageNumBack");
         _pageSp = ComponentFactory.Instance.creatCustomObject("luckyexchange.pageSpComponent");
         _luckyRightView = ComponentFactory.Instance.creatCustomObject("luckyexchange.LuckyExchangeRightView");
         _selectedBtnGroup = new SelectedButtonGroup();
         addToContent(_bg);
         addToContent(_back);
         addToContent(_separationLine);
         addToContent(_leftVBox);
         addToContent(_luckyRightView);
         addToContent(_pageSp);
         _pageSp.addChild(_preBtn);
         _pageSp.addChild(_nextBtn);
         _pageSp.addChild(_pageBack);
         _pageSp.addChild(_pageText);
         var _loc5_:Array = LuckyExchangeManager.instance.tempList;
         _loc1_ = 0;
         while(_loc1_ < _loc5_.length)
         {
            _loc2_ = DateFormatter.parse(_loc5_[_loc1_].startTime,"YYYY-MM-DD hh:mm:ss");
            _loc3_ = _loc2_.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
            if(_loc3_ <= 0)
            {
               _loc4_ = DateFormatter.parse(_loc5_[_loc1_].endTime,"YYYY-MM-DD hh:mm:ss");
               _loc3_ = _loc4_.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
               if(_loc3_ >= 0)
               {
                  _showData.push(_loc5_[_loc1_]);
               }
            }
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selectedBtnGroup.addEventListener("change",__selectedHandler);
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__pageHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__pageHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _selectedBtnGroup.removeEventListener("change",__selectedHandler);
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__pageHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__pageHandler);
         }
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         var _loc2_:LuckyExchangeLeftButton = _selectedBtnGroup.getSelectedItem() as LuckyExchangeLeftButton;
         if(!_loc2_)
         {
            return;
         }
         _luckyRightView.data = _loc2_.data;
      }
      
      private function __pageHandler(param1:MouseEvent) : void
      {
         if(param1)
         {
            switch(param1.currentTarget)
            {
               case _preBtn:
                  if(_current >= 2)
                  {
                     _current -= 1;
                  }
                  break;
               case _nextBtn:
                  if(_current < _total)
                  {
                     _current += 1;
                  }
            }
         }
         refreshView();
         if(_showData.length <= _startNum)
         {
            return;
         }
         _selectedBtnGroup.selectIndex = 0;
         _luckyRightView.data = _showData[_startNum];
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:LuckyExchangeLeftButton = null;
         _selectedBtnGroup.removeAllItem();
         _leftVBox.disposeAllChildren();
         _total = Math.ceil(_showData.length / 9);
         if(_current == 1)
         {
            _startNum = 0;
            _endNum = 9;
         }
         else
         {
            _startNum = 9 + 9 * (_current - 2);
            _endNum = _startNum + 9;
         }
         _loc1_ = _startNum;
         while(_loc1_ < _endNum)
         {
            if(_loc1_ >= _showData.length)
            {
               break;
            }
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.leftSelectedBtn");
            _loc2_.data = _showData[_loc1_];
            _selectedBtnGroup.addSelectItem(_loc2_);
            _leftVBox.addChild(_loc2_);
            _loc1_++;
         }
         pageState();
      }
      
      private function pageState() : void
      {
         _pageText.text = _current + "/" + _total;
         _preBtn.enable = _current > 1;
         _nextBtn.enable = _current < _total;
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
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selectedBtnGroup);
         _selectedBtnGroup = null;
         ObjectUtils.disposeObject(_luckyRightView);
         _luckyRightView = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_separationLine);
         _separationLine = null;
         ObjectUtils.disposeObject(_leftVBox);
         _leftVBox = null;
         ObjectUtils.disposeObject(_pageText);
         _pageText = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_pageBack);
         _pageBack = null;
         ObjectUtils.disposeObject(_pageSp);
         _pageSp = null;
         super.dispose();
      }
   }
}

