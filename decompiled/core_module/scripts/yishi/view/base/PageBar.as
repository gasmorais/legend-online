package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PageBar extends Component
   {
      
      private static const P_nextBtnStyle:String = "nextBtnStyle";
      
      private static const P_preBtnStyle:String = "preBtnStyle";
      
      private static const P_pageBackStyle:String = "pageBackStyle";
      
      private static const P_pageTxtStyle:String = "pageTxtStyle";
      
      private var _nextPageBtn:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _pagBack:DisplayObject;
      
      private var _pagTxt:FilterFrameText;
      
      private var _nextBtnStyle:String;
      
      private var _preBtnStyle:String;
      
      private var _pageBackStyle:String;
      
      private var _pageTxtStyle:String;
      
      private var _pageDataList:Array = null;
      
      private var _pageNum:int;
      
      private var _curPage:int;
      
      private var _maxPage:int;
      
      private var _initBtnEvent:Boolean = false;
      
      public function PageBar()
      {
         super();
      }
      
      public function set nextBtnStyle(param1:String) : void
      {
         _nextBtnStyle = param1;
         onPropertiesChanged("nextBtnStyle");
      }
      
      public function set preBtnStyle(param1:String) : void
      {
         _preBtnStyle = param1;
         onPropertiesChanged("preBtnStyle");
      }
      
      public function set pageBackStyle(param1:String) : void
      {
         _pageBackStyle = param1;
         onPropertiesChanged("pageBackStyle");
      }
      
      public function set pageTxtStyle(param1:String) : void
      {
         _pageTxtStyle = param1;
         onPropertiesChanged("pageTxtStyle");
      }
      
      override protected function addChildren() : void
      {
         if(_pagBack)
         {
            addChild(_pagBack);
         }
         if(_pagTxt)
         {
            addChild(_pagTxt);
         }
         if(_nextPageBtn)
         {
            addChild(_nextPageBtn);
         }
         if(_prePageBtn)
         {
            addChild(_prePageBtn);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["nextBtnStyle"])
         {
            _nextPageBtn = ComponentFactory.Instance.creat(_nextBtnStyle);
         }
         if(_changedPropeties["preBtnStyle"])
         {
            _prePageBtn = ComponentFactory.Instance.creat(_preBtnStyle);
         }
         if(_changedPropeties["pageBackStyle"])
         {
            _pagBack = ComponentFactory.Instance.creat(_pageBackStyle);
         }
         if(_changedPropeties["pageTxtStyle"])
         {
            _pagTxt = ComponentFactory.Instance.creat(_pageTxtStyle);
         }
      }
      
      public function get nextPageBtn() : BaseButton
      {
         return _nextPageBtn;
      }
      
      public function get prePageBtn() : BaseButton
      {
         return _prePageBtn;
      }
      
      public function set text(param1:String) : void
      {
         _pagTxt.text = param1;
      }
      
      public function setAutoPagingData(param1:Array, param2:int = 1) : void
      {
         if(param1 == null || param1.length == 0)
         {
            removeBtnEvent();
            _pageDataList = null;
            _pageNum = param2;
            setMaxPage(1);
            return;
         }
         _pageNum = param2;
         _pageDataList = param1;
         setMaxPage(Math.ceil(_pageDataList.length / _pageNum));
         initBtnEvent();
      }
      
      public function setMaxPage(param1:int) : void
      {
         if(param1 <= 0)
         {
            param1 = 0;
         }
         if(_maxPage == param1)
         {
            return;
         }
         _maxPage = param1;
      }
      
      public function setCurPage(param1:int, param2:Boolean = true) : void
      {
         if(param1 <= 0)
         {
            param1 = 0;
         }
         if(param1 > _maxPage)
         {
            param1 = _maxPage;
         }
         _curPage = param1;
         if(_pagTxt)
         {
            _pagTxt.text = _curPage + "/" + _maxPage;
         }
         if(_prePageBtn)
         {
            _prePageBtn.enable = _curPage > 1;
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.enable = _maxPage > _curPage;
         }
         if(param2)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function getCurPage() : int
      {
         var _loc1_:int = int(_curPage < 1 ? 1 : _curPage);
         if(_loc1_ > _maxPage)
         {
            _loc1_ = _maxPage;
         }
         return _loc1_;
      }
      
      public function getCurPageDatas() : Array
      {
         if(_pageDataList == null)
         {
            return [];
         }
         var _loc2_:int = (_curPage - 1) * _pageNum;
         var _loc4_:int = _loc2_ + _pageNum;
         var _loc3_:int = int(_pageDataList.length);
         if(_loc4_ > _loc3_)
         {
            _loc4_ = _loc3_;
         }
         var _loc1_:Array = _pageDataList.slice(_loc2_,_loc4_);
         if(_loc1_ == null)
         {
            _loc1_ = [];
         }
         return _loc1_;
      }
      
      public function initBtnEvent() : void
      {
         if(_initBtnEvent)
         {
            return;
         }
         _initBtnEvent = true;
         if(_prePageBtn)
         {
            _prePageBtn.addEventListener("click",__clickPreHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.addEventListener("click",__clickNextHandler);
         }
      }
      
      private function removeBtnEvent() : void
      {
         if(!_initBtnEvent)
         {
            return;
         }
         _initBtnEvent = false;
         if(_prePageBtn)
         {
            _prePageBtn.removeEventListener("click",__clickPreHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",__clickNextHandler);
         }
      }
      
      private function __clickPreHandler(param1:MouseEvent) : void
      {
         setCurPage(_curPage - 1);
      }
      
      private function __clickNextHandler(param1:MouseEvent) : void
      {
         setCurPage(_curPage + 1);
      }
      
      override public function dispose() : void
      {
         removeBtnEvent();
         _pageDataList = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_pagBack);
         _pagBack = null;
         ObjectUtils.disposeObject(_pagTxt);
         _pagTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

