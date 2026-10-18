package yishi.view.frame.planeswar
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesResourceInfo;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class PlanesResourceFrame extends Frame
   {
      
      private var _back:Scale9CornerImage;
      
      private var _bottomLine:Image;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageCount:int = 3;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<PlanesResourceItemView>;
      
      private var _timer:Timer;
      
      public function PlanesResourceFrame()
      {
         super();
         initView();
         addEvent();
         PlanesWarManager.instance.sendPlanesOpMsg(30);
         currentPageNum = 1;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceFrame.back");
         _bottomLine = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceFrame.bottomLine");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceFrame.lookPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceFrame.lookPageTextStyle");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceFrame.lookLastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceFrame.lookNextPageBtn");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceFrame.vbox");
         addToContent(_back);
         addToContent(_bottomLine);
         addToContent(_vbox);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(_lastPageBtn);
         addToContent(_nextPageBtn);
         titleText = LanguageMgr.GetTranslation("planeswar.PlanesResourceFrame.titleText");
         initListView();
         _timer = new Timer(1000);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _lastPageBtn.addEventListener("click",__onLastPageHandler);
         _nextPageBtn.addEventListener("click",__onNextPageHandler);
         PlanesWarManager.instance.addEventListener("PLANES_RESOURCE_UPDATE",__resourceUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _lastPageBtn.removeEventListener("click",__onLastPageHandler);
         _nextPageBtn.removeEventListener("click",__onNextPageHandler);
         PlanesWarManager.instance.removeEventListener("PLANES_RESOURCE_UPDATE",__resourceUpdateHandler);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc4_:PlanesEventsTemplateInfo = null;
         var _loc2_:Array = null;
         for each(var _loc5_:PlanesResourceInfo in model.planesResourceList)
         {
            _loc4_ = TempleteManager.instance.planesEventsTemplateCate.getTemplateByID(_loc5_.eventId);
            _loc2_ = _loc4_.Parameter.split(",");
            if(_loc5_.totalLeftTime <= 0)
            {
               _loc5_.totalLeftTime = 0;
               _loc5_.nextRewardTime = 0;
               _loc5_.isChangeToOver = false;
            }
            else
            {
               if(_loc5_.nextRewardTime == 0)
               {
                  _loc5_.nextRewardTime = _loc2_[1] * 60;
               }
               _loc5_.nextRewardTime--;
               _loc5_.totalLeftTime--;
               _loc5_.isChangeToOver = true;
            }
         }
         for each(var _loc3_:PlanesResourceItemView in _itemList)
         {
            if(_loc3_ != null && _loc3_.data && _loc3_.data.isChangeToOver)
            {
               _loc3_.setTime();
            }
         }
      }
      
      private function __resourceUpdateHandler(param1:PlanesWarEvent) : void
      {
         if(model.planesResourceList.length > 0)
         {
            _pageNumMax = Math.ceil(model.planesResourceList.length / _pageCount);
            currentPageNum = 1;
         }
         refreshView();
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlanesResourceItemView = null;
         _itemList = new Vector.<PlanesResourceItemView>();
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = new PlanesResourceItemView();
            _vbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function __onLastPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshView();
      }
      
      private function __onNextPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlanesResourceItemView = null;
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = _itemList[_loc2_];
            if(!_loc1_)
            {
               _loc1_ = new PlanesResourceItemView();
               _itemList[_loc2_] = _loc1_;
            }
            _loc1_.data = _loc2_ < currentList.length ? currentList[_loc2_] : null;
            _loc2_++;
         }
         resetTimer();
      }
      
      private function resetTimer() : void
      {
         var _loc1_:Boolean = false;
         if(model.planesResourceList.length > 0)
         {
            for each(var _loc2_:PlanesResourceInfo in model.planesResourceList)
            {
               if(_loc2_.totalLeftTime > 0)
               {
                  _loc1_ = true;
                  break;
               }
            }
         }
         if(_loc1_)
         {
            _timer.addEventListener("timer",__timerHandler);
            _timer.start();
         }
         else
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      public function get currentPageNum() : int
      {
         return _currentPageNum;
      }
      
      public function set currentPageNum(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         if(param1 > _pageNumMax)
         {
            return;
         }
         _currentPageNum = param1;
         updatePageInfo();
      }
      
      private function updatePageInfo() : void
      {
         if(_lastPageBtn)
         {
            _lastPageBtn.enable = currentPageNum > 1;
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageTxt)
         {
            _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      private function get currentList() : Array
      {
         var _loc2_:* = null;
         var _loc1_:int = (currentPageNum - 1) * _pageCount;
         var _loc3_:int = Math.min(_loc1_ + _pageCount,model.planesResourceList.length);
         return model.planesResourceList.slice(_loc1_,_loc3_);
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
         KeyBoardRegister.instance.keyEnable = true;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_bottomLine)
         {
            ObjectUtils.disposeObject(_bottomLine);
         }
         _bottomLine = null;
         if(_pageBg)
         {
            ObjectUtils.disposeObject(_pageBg);
         }
         _pageBg = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
         if(_lastPageBtn)
         {
            ObjectUtils.disposeObject(_lastPageBtn);
         }
         _lastPageBtn = null;
         if(_nextPageBtn)
         {
            ObjectUtils.disposeObject(_lastPageBtn);
         }
         _lastPageBtn = null;
         super.dispose();
      }
   }
}

