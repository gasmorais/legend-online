package dragontalker
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontalker.item.DragonTalkerMountPreviewItem;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.dragontalker.DragonTalkerModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class DragonTalkerMountPreviewFrame extends Frame
   {
      
      private var _borderBack:MutipleImage;
      
      private var _mountList:SimpleTileList;
      
      private var _countText:FilterFrameText;
      
      private var _nextBtn:IconButton;
      
      private var _preBtn:IconButton;
      
      private var _pageCount:int = 8;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var itemList:Vector.<DragonTalkerMountPreviewItem>;
      
      public function DragonTalkerMountPreviewFrame()
      {
         super();
         _pageNumMax = Math.ceil(showList.length / _pageCount);
         initView();
         initMountListView();
         currentPageNum = 1;
         addEvent();
         refreshListView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _countText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n7_bskvbskv2n");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.bskv2n.nextBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.bskv2n.preBtn");
         _borderBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.bskv2n.borderBack");
         _mountList = ComponentFactory.Instance.creatCustomObject("DragonTalkerMountPreviewFrame.mountList",[4]);
         addToContent(_borderBack);
         addToContent(_mountList);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_countText);
      }
      
      private function initMountListView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DragonTalkerMountPreviewItem = null;
         itemList = new Vector.<DragonTalkerMountPreviewItem>();
         var _loc2_:Array = currentList;
         _loc3_ = 0;
         while(_loc3_ < _pageCount)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DragonTalkerMountPreviewFrame.mountItem");
            _loc1_.data = _loc2_[_loc3_];
            _mountList.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc3_++;
         }
         _mountList.commitChanges();
      }
      
      private function addEvent() : void
      {
         _nextBtn.addEventListener("click",__onNextPageHandler);
         _preBtn.addEventListener("click",__onLastPageHandler);
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updatePreviewHandler);
         MsgMan.addObserver("CLOSE_PREVIEW_FRAME",this,__closePreviewHandler);
      }
      
      private function removeEvent() : void
      {
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__onNextPageHandler);
         }
         if(_nextBtn)
         {
            _preBtn.removeEventListener("click",__onLastPageHandler);
         }
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updatePreviewHandler);
         MsgMan.removeObserver("CLOSE_PREVIEW_FRAME",this,__closePreviewHandler);
      }
      
      private function __updatePreviewHandler(param1:String, param2:Object) : void
      {
         refreshListView();
      }
      
      private function __closePreviewHandler(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function __onLastPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshListView();
      }
      
      private function __onNextPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshListView();
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
      
      private function refreshListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = currentList;
         _loc2_ = 0;
         while(_loc2_ < itemList.length)
         {
            itemList[_loc2_].data = _loc2_ < _loc1_.length ? _loc1_[_loc2_] : null;
            _loc2_++;
         }
      }
      
      private function updatePageInfo() : void
      {
         if(_preBtn)
         {
            _preBtn.enable = currentPageNum > 1;
         }
         if(_nextBtn)
         {
            _nextBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_countText)
         {
            _countText.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
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
      
      private function get currentList() : Array
      {
         var _loc2_:* = null;
         var _loc1_:int = (currentPageNum - 1) * _pageCount;
         var _loc3_:int = Math.min(_loc1_ + _pageCount,showList.length);
         return showList.slice(_loc1_,_loc3_);
      }
      
      private function get showList() : Array
      {
         return model.battleBeastTempArr;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         this.titleText = LanguageMgr.GetTranslation("DragonTalkerMountPreviewFrame.title.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_borderBack);
         _borderBack = null;
         ObjectUtils.disposeObject(_mountList);
         _mountList = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

