package groupchat.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.groupchat.ConsortiaGroupChatHistoryData;
   import mvc.module.groupchat.ConsortiaGroupChatModel;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaGroupChatHistoryView extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _titleImg:Bitmap;
      
      private var _miniCloseBtn:BaseButton;
      
      private var _firstPageBtn:BaseButton;
      
      private var _lastPageBtn:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _output:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _outputWidth:int = 254;
      
      private var _selfCount:int = 1;
      
      private var _curPage:int;
      
      public function ConsortiaGroupChatHistoryView()
      {
         super();
         initView();
         addEvent();
         __onLastPageClick(null);
         setPageBtnEnable();
      }
      
      private function initView() : void
      {
         _vBox = new VBox();
         _back = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.HistoryViewChatListBack");
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.consortiagroupchat.HistoryTitleText");
         _miniCloseBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewMiniCloseBtn");
         _firstPageBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewFirstPageBtn");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewLastPageBtn");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewPrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewNextPageBtn");
         _firstPageBtn.tipData = LanguageMgr.GetTranslation("public.firstPage");
         _lastPageBtn.tipData = LanguageMgr.GetTranslation("public.lastPage");
         _prePageBtn.tipData = LanguageMgr.GetTranslation("public.prePage");
         _nextPageBtn.tipData = LanguageMgr.GetTranslation("public.nextPage");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewPageTxt");
         _pageTxt.text = "1 / 1";
         _output = ComponentFactory.Instance.creatComponentByStylename("consortiagroupchat.HistoryViewChatList");
         _output.setView(_vBox);
         addToContent(_back);
         addToContent(_titleImg);
         addToContent(_miniCloseBtn);
         addToContent(_firstPageBtn);
         addToContent(_lastPageBtn);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(_output);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _miniCloseBtn.addEventListener("click",__onCloseClick);
         _firstPageBtn.addEventListener("click",__onFirstPageClick);
         _lastPageBtn.addEventListener("click",__onLastPageClick);
         _prePageBtn.addEventListener("click",__onPrePageClick);
         _nextPageBtn.addEventListener("click",__onNextPageClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _miniCloseBtn.removeEventListener("click",__onCloseClick);
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
      
      private function __onFirstPageClick(param1:MouseEvent) : void
      {
         curPage = 1;
      }
      
      private function __onLastPageClick(param1:MouseEvent) : void
      {
         curPage = model.getTotalPage();
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
         if(_curPage < model.getTotalPage())
         {
            curPage = _curPage + 1;
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
      
      public function show(param1:Frame) : void
      {
         LayerManager.Instance.addTolayerRelated(param1,this,3,true,false);
         this.x -= 35;
      }
      
      private function refreshView() : void
      {
         var _loc1_:ConsortiaGroupChatHistoryData = null;
         var _loc5_:ConsortiaGroupChatHistoryNotice = null;
         var _loc4_:int = (_curPage - 1) * 30;
         var _loc2_:int = _curPage * 30;
         var _loc3_:int = int(_loc2_ < model.historyArray.length ? _loc2_ : model.historyArray.length);
         _vBox.removeAllChild();
         _loc4_;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = model.historyArray[_loc4_] as ConsortiaGroupChatHistoryData;
            _loc5_ = ObjectPool.getObject(ConsortiaGroupChatHistoryNotice) as ConsortiaGroupChatHistoryNotice;
            _loc5_.data = _loc1_;
            _output.beginChanges();
            _vBox.addChild(_loc5_);
            _vBox.refreshChildPos();
            _output.invalidateViewport(true);
            _output.commitChanges();
            _loc4_++;
         }
         _pageTxt.text = _curPage + " / " + model.getTotalPage();
         setPageBtnEnable();
      }
      
      private function setPageBtnEnable() : void
      {
         _firstPageBtn.enable = _prePageBtn.enable = _curPage > 1;
         _lastPageBtn.enable = _nextPageBtn.enable = _curPage < model.getTotalPage();
      }
      
      private function get model() : ConsortiaGroupChatModel
      {
         return FrameControllerManager.instance.consortiaGroupChatControler.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_back)
         {
            _back.dispose();
         }
         _back = null;
         if(_titleImg)
         {
            _titleImg = null;
         }
         if(_output)
         {
            _output.dispose();
         }
         _output = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         if(_miniCloseBtn)
         {
            _miniCloseBtn.dispose();
         }
         _miniCloseBtn = null;
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
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

