package outyard.event
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
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.hugehead.HugeHeadActiveMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardEventFrame extends Frame implements IManualSize
   {
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _outyardRightView:OutyardEventRightView;
      
      private var _back:Scale9CornerImage;
      
      private var _gap:MutipleImage;
      
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
      
      private const NUM:int = 7;
      
      private var _showData:Array = [];
      
      public function OutyardEventFrame()
      {
         super();
         initView();
         addEvent();
         _selectedBtnGroup.selectIndex = 0;
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,765,515);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("outyard.event.OutyardEventFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("outyardEventFrame.back");
         _leftVBox = ComponentFactory.Instance.creatComponentByStylename("outyardEvent.leftVBox");
         _gap = ComponentFactory.Instance.creatComponentByStylename("outyardEventFrame.vgap");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("outyardEvent.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("outyardEvent.nextBtn");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("outyardEvent.pageText");
         _pageBack = ComponentFactory.Instance.creatComponentByStylename("outyardEvent.PageNumBack");
         _pageSp = ComponentFactory.Instance.creatCustomObject("outyardEvent.pageSpComponent");
         _outyardRightView = ComponentFactory.Instance.creatCustomObject("outyard.event.OutyardEventRightView");
         _selectedBtnGroup = new SelectedButtonGroup();
         addToContent(_back);
         addToContent(_leftVBox);
         addToContent(_outyardRightView);
         addToContent(_gap);
         addToContent(_pageSp);
         _pageSp.addChild(_preBtn);
         _pageSp.addChild(_nextBtn);
         _pageSp.addChild(_pageBack);
         _pageSp.addChild(_pageText);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selectedBtnGroup.addEventListener("change",__selectedHandler);
         _preBtn.addEventListener("click",__pageHandler);
         _nextBtn.addEventListener("click",__pageHandler);
         NotificationManager.instance.addEventListener("OUTYARD_STATE_INFO",__stateInfoHandler);
         NotificationManager.instance.addEventListener("CLICK_AREA_VIEW",__areaClickHandler);
         __stateInfoHandler(null);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _selectedBtnGroup.removeEventListener("change",__selectedHandler);
         _preBtn.removeEventListener("click",__pageHandler);
         _nextBtn.removeEventListener("click",__pageHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_STATE_INFO",__stateInfoHandler);
         NotificationManager.instance.removeEventListener("CLICK_AREA_VIEW",__areaClickHandler);
      }
      
      private function __stateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         _showData = [];
         var _loc5_:HugeHeadActiveMsg = new HugeHeadActiveMsg();
         _loc5_.type = 4;
         var _loc4_:HugeHeadActiveMsg = new HugeHeadActiveMsg();
         _loc4_.type = 5;
         var _loc3_:HugeHeadActiveMsg = new HugeHeadActiveMsg();
         _loc3_.type = 6;
         _showData.push(_loc5_);
         _showData.push(_loc4_);
         _showData.push(_loc3_);
         _loc6_ = 0;
         while(_loc6_ < _loc2_.activeList.length)
         {
            _showData.push(_loc2_.activeList[_loc6_]);
            _loc6_++;
         }
         refreshView();
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         var _loc2_:OutyardEventLeftButton = _selectedBtnGroup.getSelectedItem() as OutyardEventLeftButton;
         if(!_loc2_)
         {
            return;
         }
         _outyardRightView.data = _loc2_.data;
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
         _outyardRightView.data = _showData[_startNum];
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:OutyardEventLeftButton = null;
         _selectedBtnGroup.removeAllItem();
         _leftVBox.disposeAllChildren();
         _total = Math.ceil(_showData.length / 7);
         if(_current == 1)
         {
            _startNum = 0;
            _endNum = 7;
         }
         else
         {
            _startNum = 7 + 7 * (_current - 2);
            _endNum = _startNum + 7;
         }
         _loc1_ = _startNum;
         while(_loc1_ < _endNum)
         {
            if(_loc1_ >= _showData.length)
            {
               break;
            }
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("outyardEvent.leftSelectedBtn");
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
      
      private function __areaClickHandler(param1:NotificationEvent) : void
      {
         dispose();
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
         ObjectUtils.disposeObject(_outyardRightView);
         _outyardRightView = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
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

