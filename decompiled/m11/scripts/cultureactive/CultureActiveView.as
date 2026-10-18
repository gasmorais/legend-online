package cultureactive
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.culture.CultureModel;
   import utils.LogicUtils;
   import yishi.events.NotificationEvent;
   import yishi.manager.CultureActiveManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class CultureActiveView extends Component
   {
      
      private var _index:int;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxtBack:DisplayObject;
      
      private var _pageTxt:FilterFrameText;
      
      private var _goodList:Array;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int;
      
      private var _countGood:int = 0;
      
      private var _descriptionTxt:FilterFrameText;
      
      private var _sortBtn:TextButton;
      
      private var _timeTxt:FilterFrameText;
      
      private var _scoreAllTxt:FilterFrameText;
      
      public function CultureActiveView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _descriptionTxt.text = LanguageMgr.GetTranslation("cultureactive.CultureActiveFrame.descriptionTxt" + _index);
         _descriptionTxt.y = _descriptionTxt.numLines > 1 ? 0 : 15;
         _currentPage = 1;
         CultureActiveManager.instance.OperateCultureReq(1,0,_index);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CultureActiveItem = null;
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("cultureactive.NextPageBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("cultureactive.LastPageBtn");
         _pageTxtBack = ComponentFactory.Instance.creatBitmap("asset.cultureactive.pageNumBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("cultureactive.PageTextStyle1");
         _descriptionTxt = ComponentFactory.Instance.creatComponentByStylename("cultureactive.descriptionTxt");
         _scoreAllTxt = ComponentFactory.Instance.creatComponentByStylename("cultureactive.socreAllTxt");
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("CultureActiveFrame.sortBtn");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("cultureactive.timeTxt");
         addChild(_preBtn);
         _preBtn.enable = false;
         addChild(_nextBtn);
         addChild(_pageTxtBack);
         addChild(_pageTxt);
         _pageTxt.text = "1/1";
         addChild(_descriptionTxt);
         addChild(_sortBtn);
         addChild(_timeTxt);
         addChild(_scoreAllTxt);
         _goodList = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("cultureactive.CultureActiveItem");
            _loc1_.x = 20 + _loc2_ * 200;
            _loc1_.y = 0;
            addChild(_loc1_);
            _goodList.push(_loc1_);
            _loc2_++;
         }
         _sortBtn.text = LanguageMgr.GetTranslation("CultureActiveView.sortBtn.text");
      }
      
      private function initEvent() : void
      {
         _preBtn.addEventListener("click",_preHandler);
         _nextBtn.addEventListener("click",_nextHandler);
         _sortBtn.addEventListener("click",_sortHandler);
         NotificationManager.instance.addEventListener("CULTURE_INFO_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",_preHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",_nextHandler);
         }
         if(_sortBtn)
         {
            _sortBtn.removeEventListener("click",_sortHandler);
         }
         NotificationManager.instance.removeEventListener("CULTURE_INFO_UPDATE",__updateViewHandler);
      }
      
      private function _preHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage - 1;
         updateView();
         updatePageView();
      }
      
      private function _nextHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage + 1;
         updateView();
         updatePageView();
      }
      
      private function _sortHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("cultureactive",1,_index);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _countGood = 0;
         var _loc1_:Array = CultureActiveManager.instance.getCultureActiveByIndex(_index);
         if(_loc1_.length % 4 != 0 || _loc1_.length == 0)
         {
            _totalPage = _loc1_.length / 4 + 1;
         }
         else
         {
            _totalPage = _loc1_.length / 4;
         }
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            if(_currentPage - 1 < 0)
            {
               _loc3_ = _loc5_;
            }
            else
            {
               _loc3_ = _loc5_ + (_currentPage - 1) * 4;
            }
            _goodList[_loc5_].index = _index;
            if(_loc1_.length > _loc3_)
            {
               _countGood = _countGood + 1;
               _goodList[_loc5_].data = _loc1_[_loc3_];
            }
            else
            {
               _goodList[_loc5_].data = null;
            }
            _loc5_++;
         }
         updatePageView();
         var _loc4_:CultureModel = CultureActiveManager.instance.model;
         _timeTxt.htmlText = LanguageMgr.GetTranslation("cultureActiveView.timeTxt",_loc4_.openTime,_loc4_.stopTime);
         var _loc2_:int = 0;
         if(_index == 3)
         {
            _loc2_ = int(_loc4_.myServerScore);
         }
         else if(_index == 2)
         {
            _loc2_ = int(_loc4_.myConsortiaScore);
         }
         else
         {
            _loc2_ = int(_loc4_.myTotalScore);
         }
         _scoreAllTxt.htmlText = LanguageMgr.GetTranslation("CultureActiveView.sorceAllTxt.text0" + _index,_loc2_);
      }
      
      private function updatePageView() : void
      {
         _pageTxt.text = _currentPage + "/" + _totalPage;
         if(_currentPage == 1)
         {
            _preBtn.enable = false;
         }
         else
         {
            _preBtn.enable = true;
         }
         if(_currentPage == _totalPage)
         {
            _nextBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_goodList);
         _goodList = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageTxtBack);
         _pageTxtBack = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_descriptionTxt);
         _descriptionTxt = null;
         ObjectUtils.disposeObject(_sortBtn);
         _sortBtn = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_scoreAllTxt);
         _scoreAllTxt = null;
         super.dispose();
      }
   }
}

