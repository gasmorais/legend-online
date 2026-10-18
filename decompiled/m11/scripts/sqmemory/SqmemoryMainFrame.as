package sqmemory
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.view.base.PageBar;
   
   public class SqmemoryMainFrame extends Frame
   {
      
      private var _pagebg:ScaleFrameImage;
      
      private var _pagePanel:PageBar;
      
      private var _titleMc:MovieClip;
      
      private var _pageContent:Sprite;
      
      private var _pageMask:MovieClip;
      
      private var _gtitle:GradientText;
      
      private var _pageItemList:Array = [];
      
      public function SqmemoryMainFrame()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         _pagebg = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.pageBg");
         _pageMask = ComponentFactory.Instance.creatCustomObject("asset.sqmemorty.maskMc");
         _pageContent = new Sprite();
         _pagePanel = ComponentFactory.Instance.creatComponentByStylename("ui.sqmomerty.pagebar");
         _titleMc = ComponentFactory.Instance.creatCustomObject("asset.sqmemory.tilteMc");
         _gtitle = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.GradientTitle");
         addToContent(_pageMask);
         addToContent(_pageContent);
         addToContent(_pagePanel);
         addToContent(_titleMc);
         addToContent(_gtitle);
         _pageContent.addChild(_pagebg);
         _titleMc.gotoAndStop(73);
         _titleMc.mouseEnabled = false;
         _pageMask.gotoAndStop(41);
         _pageMask.mouseEnabled = false;
         _pageContent.mask = _pageMask;
      }
      
      private function initData() : void
      {
         _pagePanel.setAutoPagingData([1,1,1,1,1,1,1,1],1);
         _pagePanel.setCurPage(1);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _pagePanel.addEventListener("change",pageChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _pagePanel.removeEventListener("change",pageChangeHandler);
      }
      
      private function pageChangeHandler(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc4_:int = int(_pagePanel.getCurPage());
         var _loc5_:Array = [0,1,2,3,3,4,4,5,5];
         _gtitle.text = LanguageMgr.GetTranslation("sqmemory.page.title" + _loc5_[_loc4_]);
         _pagebg.setFrame(_loc4_);
         var _loc3_:DisplayObject = _pageItemList[_loc4_];
         if(_loc3_ == null)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("sqmemory.page.SqmemoryPage" + _loc4_);
            _pageItemList[_loc4_] = _loc3_;
         }
         if(_pageContent.numChildren > 1)
         {
            _loc2_ = _pageContent.getChildAt(1);
            if(_loc2_ && _loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         _pageContent.addChild(_loc3_);
         _pageMask.gotoAndPlay(1);
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
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:DisplayObject in _pageItemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _pageItemList = null;
         ObjectUtils.disposeObject(_pagebg);
         _pagebg = null;
         ObjectUtils.disposeObject(_pagePanel);
         _pagePanel = null;
         ObjectUtils.disposeObject(_pageContent);
         _pageContent = null;
         ObjectUtils.disposeViolentMc(_titleMc);
         _titleMc = null;
         ObjectUtils.disposeViolentMc(_pageMask);
         _pageMask = null;
         ObjectUtils.disposeObject(_gtitle);
         _gtitle = null;
         super.dispose();
      }
      
      public function show() : void
      {
         _titleMc.gotoAndPlay(1);
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
   }
}

