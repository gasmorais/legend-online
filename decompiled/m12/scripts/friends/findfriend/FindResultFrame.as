package friends.findfriend
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FindResultEvent;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.FriendSocketOutManager;
   import mvc.module.sns.BaseSnsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   
   public class FindResultFrame extends Frame
   {
      
      private var _resultTipTxt:FilterFrameText;
      
      private var _unFindTipTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _curPageTxt:FilterFrameText;
      
      private var _prePageBtn:TextButton;
      
      private var _nextPageBtn:TextButton;
      
      private var _closeBtn:TextButton;
      
      private var _findInfo:BaseSnsInfo;
      
      private var _totalPage:int;
      
      private var _curPage:int;
      
      private var _curList:Array;
      
      private var _pageDic:Dictionary;
      
      public function FindResultFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("friends.findfriend.FindFriendFrame.title");
         _resultTipTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultFrameResultTipTxt");
         _unFindTipTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultFrameUnfindTipTxt");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultFrameScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultFrameVBox");
         _curPageTxt = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultFrameCurPageTxt");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultFrameNextPageBtn");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultFrameCloseBtn");
         _pageDic = new Dictionary();
         _scrollPanel.setView(_vBox);
         _resultTipTxt.text = LanguageMgr.GetTranslation("friends.findfriend.FindResultFrame.resultTip");
         _unFindTipTxt.text = LanguageMgr.GetTranslation("friends.findfriend.FindResultFrame.unfindTip");
         _curPageTxt.text = LanguageMgr.GetTranslation("friends.findfriend.FindResultFrame.curPageTip",1);
         _prePageBtn.text = LanguageMgr.GetTranslation("friends.findfriend.FindResultFrame.prePage");
         _nextPageBtn.text = LanguageMgr.GetTranslation("friends.findfriend.FindResultFrame.nextPage");
         _closeBtn.text = LanguageMgr.GetTranslation("public.close");
         addToContent(_resultTipTxt);
         addToContent(_scrollPanel);
         addToContent(_vBox);
         addToContent(_curPageTxt);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_closeBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _closeBtn.addEventListener("click",__onCloseClick);
         _prePageBtn.addEventListener("click",__onPrePageClick);
         _nextPageBtn.addEventListener("click",__onNextPageClick);
         FriendManager.getInstance().addEventListener("GET_FIND_RESULTS",__getResultsHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__onCloseClick);
         }
         if(_prePageBtn)
         {
            _prePageBtn.removeEventListener("click",__onPrePageClick);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",__onNextPageClick);
         }
         FriendManager.getInstance().removeEventListener("GET_FIND_RESULTS",__getResultsHandler);
      }
      
      private function __getResultsHandler(param1:FindResultEvent) : void
      {
         _totalPage = param1.totalPage;
         _curList = param1.data as Array;
         _pageDic[_curPage] = _curList;
         refreshView();
         setPageBtnEnable();
      }
      
      private function __onPrePageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         curPage -= 1;
      }
      
      private function __onNextPageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         curPage += 1;
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
            case 4:
               dispose();
         }
      }
      
      private function setPageBtnEnable() : void
      {
         _prePageBtn.enable = _curPage > 1;
         _nextPageBtn.enable = _curPage < _totalPage;
      }
      
      public function set findInfo(param1:BaseSnsInfo) : void
      {
         if(_findInfo == param1)
         {
            return;
         }
         _findInfo = param1;
         curPage = 1;
      }
      
      public function get curPage() : int
      {
         return _curPage;
      }
      
      public function set curPage(param1:int) : void
      {
         if(_curPage == param1 || param1 <= 0)
         {
            return;
         }
         _curPage = param1;
         setPageBtnEnable();
         if(_pageDic && _pageDic[_curPage])
         {
            _curList = _pageDic[_curPage];
            refreshView();
         }
         else
         {
            FriendSocketOutManager.sendFindFriend(_findInfo,_curPage);
            _prePageBtn.enable = _nextPageBtn.enable = false;
         }
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:FindResultItem = null;
         clean();
         if(_unFindTipTxt.parent)
         {
            _unFindTipTxt.parent.removeChild(_unFindTipTxt);
         }
         if(_curList && _curList.length > 0)
         {
            _loc2_ = int(_curList.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = new FindResultItem();
               _loc1_.data = _curList[_loc3_];
               _loc1_.setFrame(_loc3_ % 2 + 1);
               _vBox.addChild(_loc1_);
               _loc3_++;
            }
         }
         else
         {
            addChild(_unFindTipTxt);
         }
         _scrollPanel.scrollToTop();
         _scrollPanel.invalidateViewport();
         _curPageTxt.text = LanguageMgr.GetTranslation("friends.findfriend.FindResultFrame.curPageTip",_curPage);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function clean() : void
      {
         var _loc1_:DisplayObject = null;
         if(_vBox)
         {
            while(_vBox.numChildren > 0)
            {
               _loc1_ = _vBox.getChildAt(0);
               _vBox.removeChild(_loc1_);
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clean();
         if(_resultTipTxt)
         {
            _resultTipTxt.dispose();
         }
         _resultTipTxt = null;
         if(_unFindTipTxt)
         {
            _unFindTipTxt.dispose();
         }
         _unFindTipTxt = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         if(_scrollPanel)
         {
            _scrollPanel.dispose();
         }
         _scrollPanel = null;
         if(_curPageTxt)
         {
            _curPageTxt.dispose();
         }
         _curPageTxt = null;
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
         if(_closeBtn)
         {
            _closeBtn.dispose();
         }
         _closeBtn = null;
         _findInfo = null;
         _curList = null;
         _pageDic = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         FrameControllerManager.instance.friendControler.showFindFriendFrame();
      }
   }
}

