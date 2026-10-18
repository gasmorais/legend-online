package im.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.IMManager;
   import mvc.module.friends.BaseIMInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class IMHistoryView extends Frame
   {
      
      private var _scrollBg:ScaleBitmapImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _cellVBox:VBox;
      
      private var _closeBtn:TextButton;
      
      private var _firstPageBtn:BaseButton;
      
      private var _lastPageBtn:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _curPage:int;
      
      private var _preDate:Date;
      
      private var _data:ThaneInfo;
      
      public function IMHistoryView()
      {
         super();
         initView();
         addEvent();
         setPageBtnEnable();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("friends.im.view.IMHistoryView.title");
         _scrollBg = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryViewScrollBg");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryViewScrollPanel");
         _cellVBox = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryViewCellVBox");
         _scrollPanel.setView(_cellVBox);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryViewCloseBtn");
         _closeBtn.text = LanguageMgr.GetTranslation("public.close");
         _firstPageBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryViewFirstPageBtn");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryViewLastPageBtn");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryViewPrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryViewNextPageBtn");
         _firstPageBtn.tipData = LanguageMgr.GetTranslation("public.firstPage");
         _lastPageBtn.tipData = LanguageMgr.GetTranslation("public.lastPage");
         _prePageBtn.tipData = LanguageMgr.GetTranslation("public.prePage");
         _nextPageBtn.tipData = LanguageMgr.GetTranslation("public.nextPage");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryViewPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryViewPageTxt");
         _pageTxt.text = "1 / 1";
         addToContent(_scrollBg);
         addToContent(_scrollPanel);
         addToContent(_cellVBox);
         addToContent(_closeBtn);
         addToContent(_firstPageBtn);
         addToContent(_lastPageBtn);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageBg);
         addToContent(_pageTxt);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _closeBtn.addEventListener("click",__onCloseBtnClick);
         _firstPageBtn.addEventListener("click",__onFirstPageClick);
         _lastPageBtn.addEventListener("click",__onLastPageClick);
         _prePageBtn.addEventListener("click",__onPrePageClick);
         _nextPageBtn.addEventListener("click",__onNextPageClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _closeBtn.removeEventListener("click",__onCloseBtnClick);
         _firstPageBtn.removeEventListener("click",__onFirstPageClick);
         _lastPageBtn.removeEventListener("click",__onLastPageClick);
         _prePageBtn.removeEventListener("click",__onPrePageClick);
         _nextPageBtn.removeEventListener("click",__onNextPageClick);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __onCloseBtnClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __onFirstPageClick(param1:MouseEvent) : void
      {
         curPage = 1;
      }
      
      private function __onLastPageClick(param1:MouseEvent) : void
      {
         if(_data)
         {
            curPage = imManager.getIMHistoryTotalPages(_data.userId);
         }
      }
      
      private function __onPrePageClick(param1:MouseEvent) : void
      {
         if(_curPage > 1)
         {
            curPage = _curPage - 1;
         }
      }
      
      private function __onNextPageClick(param1:MouseEvent) : void
      {
         if(_data && _curPage < imManager.getIMHistoryTotalPages(_data.userId))
         {
            curPage = _curPage + 1;
         }
      }
      
      private function refreshView() : void
      {
         var _loc4_:* = undefined;
         var _loc3_:IMHistoryCell = null;
         var _loc2_:IMHistoryCell = null;
         _preDate = null;
         clean();
         if(_data)
         {
            _loc4_ = imManager.getCurPageIMHistoryList(_data.userId,_curPage);
            if(!_loc4_)
            {
               return;
            }
            for each(var _loc1_:BaseIMInfo in _loc4_)
            {
               if(!_preDate)
               {
                  _preDate = _loc1_.date;
               }
               else if(_preDate.fullYear != _loc1_.date.fullYear || _preDate.month != _loc1_.date.month || _preDate.date != _loc1_.date.date)
               {
                  _loc3_ = new IMHistoryCell();
                  _loc3_.data = _loc1_.date;
                  _cellVBox.addChild(_loc3_);
                  _preDate = null;
               }
               _loc2_ = new IMHistoryCell();
               _loc2_.data = _loc1_;
               _cellVBox.addChild(_loc2_);
            }
            _cellVBox.refreshChildPos();
            _scrollPanel.invalidateViewport(true);
         }
         _pageTxt.text = _curPage + " / " + imManager.getIMHistoryTotalPages(_data.userId);
         setPageBtnEnable();
      }
      
      private function setPageBtnEnable() : void
      {
         _firstPageBtn.enable = _prePageBtn.enable = _curPage > 1;
         if(_data)
         {
            _lastPageBtn.enable = _nextPageBtn.enable = _curPage < imManager.getIMHistoryTotalPages(_data.userId);
         }
         else
         {
            _lastPageBtn.enable = _nextPageBtn.enable = false;
         }
      }
      
      public function set curPage(param1:int) : void
      {
         if(_curPage == param1)
         {
            return;
         }
         _curPage = param1;
         refreshView();
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         __onLastPageClick(null);
      }
      
      public function show(param1:Frame) : void
      {
         LayerManager.Instance.addTolayerRelated(param1,this,3,true,false);
         this.x -= 28;
         this.y += 32;
      }
      
      private function get imManager() : IMManager
      {
         return IMManager.instance;
      }
      
      private function clean() : void
      {
         var _loc1_:DisplayObject = null;
         while(_cellVBox.numChildren > 0)
         {
            _loc1_ = _cellVBox.getChildAt(0);
            _cellVBox.removeChild(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clean();
         ObjectUtils.disposeAllChildren(this);
         if(_scrollBg)
         {
            _scrollBg.dispose();
         }
         _scrollBg = null;
         if(_scrollPanel)
         {
            _scrollPanel.dispose();
         }
         _scrollPanel = null;
         if(_cellVBox)
         {
            _cellVBox.dispose();
         }
         _cellVBox = null;
         if(_closeBtn)
         {
            _closeBtn.dispose();
         }
         _closeBtn = null;
         if(_firstPageBtn)
         {
            _firstPageBtn.dispose();
         }
         _firstPageBtn = null;
         if(_lastPageBtn)
         {
            _lastPageBtn.dispose();
         }
         _lastPageBtn = null;
         if(_prePageBtn)
         {
            _prePageBtn.dispose();
         }
         _prePageBtn = null;
         if(_nextPageBtn)
         {
            _nextPageBtn.dispose();
         }
         _nextPageBtn = null;
         if(_pageBg)
         {
            _pageBg.dispose();
         }
         _pageBg = null;
         if(_pageTxt)
         {
            _pageTxt.dispose();
         }
         _pageTxt = null;
         _preDate = null;
         _data = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

