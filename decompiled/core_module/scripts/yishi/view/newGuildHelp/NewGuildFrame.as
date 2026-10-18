package yishi.view.newGuildHelp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NewGuildHelpManager;
   import yishi.view.tips.MessageTipManager;
   
   public class NewGuildFrame extends Frame
   {
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _closeBtn:BaseButton;
      
      private var _scanBtn:BaseButton;
      
      private var _helpFlag:int;
      
      private var _currentIndex:int;
      
      private var _curFrameData:XML;
      
      private var _curViewList:XMLList;
      
      private var _curGuildView:NewGuildView;
      
      private var _lastClickTime:int = 0;
      
      private var _spriteLeft:Sprite;
      
      private var _spriteRight:Sprite;
      
      private var _frameName:String;
      
      public function NewGuildFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,825,540);
      }
      
      private function initView() : void
      {
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("core.newGuildFrame.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("core.newGuildFrame.nextBtn");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.newGuildFrame.closeBtn");
         _scanBtn = ComponentFactory.Instance.creatComponentByStylename("core.newGuildFrame.scanBtn");
         _spriteLeft = new Sprite();
         _spriteLeft.graphics.beginFill(16777215,0);
         _spriteLeft.graphics.drawRect(-20,-5,405,520);
         _spriteLeft.graphics.endFill();
         _spriteRight = new Sprite();
         _spriteRight.graphics.beginFill(16777215,0);
         _spriteRight.graphics.drawRect(385,-5,405,520);
         _spriteRight.graphics.endFill();
      }
      
      private function createGuildView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _curViewList.length())
         {
            if(_loc1_ == _currentIndex - 1)
            {
               _curGuildView = new NewGuildView(_frameName);
               _curGuildView.data = _curViewList[_currentIndex - 1];
            }
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResposeHandler);
         _preBtn.addEventListener("click",__viewClickHandler);
         _nextBtn.addEventListener("click",__viewClickHandler);
         _closeBtn.addEventListener("click",__onCloseClick);
         _scanBtn.addEventListener("click",__gotoLastPageHandler);
         _spriteLeft.addEventListener("click",__viewClickHandler);
         _spriteRight.addEventListener("click",__viewClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResposeHandler);
         _preBtn.removeEventListener("click",__viewClickHandler);
         _nextBtn.removeEventListener("click",__viewClickHandler);
         _closeBtn.removeEventListener("click",__onCloseClick);
         _scanBtn.removeEventListener("click",__gotoLastPageHandler);
         _spriteLeft.removeEventListener("click",__viewClickHandler);
         _spriteRight.removeEventListener("click",__viewClickHandler);
      }
      
      private function __viewClickHandler(param1:MouseEvent) : void
      {
         if(_curViewList.length() == 1)
         {
            return;
         }
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastClickTime < 600)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastClickTime = _loc2_;
         switch(param1.currentTarget)
         {
            case _preBtn:
            case _spriteLeft:
               if(currentIndex < 2)
               {
                  return;
               }
               currentIndex -= 1;
               break;
            case _nextBtn:
            case _spriteRight:
               if(currentIndex >= _curViewList.length())
               {
                  return;
               }
               currentIndex += 1;
         }
      }
      
      private function __gotoLastPageHandler(param1:MouseEvent) : void
      {
         currentIndex = 1;
      }
      
      private function setButtonVisible(param1:int) : void
      {
         super.closeButton.visible = false;
         if(_curViewList.length() == 1)
         {
            _preBtn.visible = _closeBtn.visible = _scanBtn.visible = _nextBtn.visible = false;
            super.closeButton.visible = true;
            return;
         }
         switch(param1)
         {
            case 1:
               _preBtn.visible = _closeBtn.visible = _scanBtn.visible = false;
               _nextBtn.visible = true;
               break;
            case _curViewList.length():
               _preBtn.visible = _closeBtn.visible = _scanBtn.visible = true;
               _nextBtn.visible = false;
               break;
            default:
               _preBtn.visible = _nextBtn.visible = true;
               _closeBtn.visible = _scanBtn.visible = false;
         }
      }
      
      public function set data(param1:Object) : void
      {
         _frameName = param1.frameName;
         _curFrameData = NewGuildHelpManager.Instance.getFrameDataByFrameName(_frameName);
         _curViewList = NewGuildHelpManager.Instance.getViewDataByViewIndex(_frameName);
         _currentIndex = param1.index;
      }
      
      public function set currentIndex(param1:int) : void
      {
         _currentIndex = param1;
         setButtonVisible(_currentIndex);
         _curGuildView.data = _curViewList[_currentIndex - 1];
      }
      
      public function get currentIndex() : int
      {
         return _currentIndex;
      }
      
      public function show(param1:int = 3) : void
      {
         LayerManager.Instance.addToLayer(this,param1,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         createGuildView();
         addAllChildren();
      }
      
      private function addAllChildren() : void
      {
         super.titleText = LanguageMgr.GetTranslation(_curFrameData.@titleText);
         setButtonVisible(_currentIndex);
         if(_curGuildView)
         {
            addToContent(_curGuildView);
         }
         addToContent(_spriteLeft);
         addToContent(_spriteRight);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_closeBtn);
         addToContent(_scanBtn);
         _curGuildView.x = -45;
         _curGuildView.y = -30;
      }
      
      private function __frameResposeHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

