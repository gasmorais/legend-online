package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.GameHallEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallModel;
   import utils.LogicUtils;
   import yishi.datas.templates.GameHallEasterTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class GameHallTeamEastLeftView extends Sprite
   {
      
      private var _returnBtn:BaseButton;
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<GameHallTeamEastItemView>;
      
      private var _callBack:Function;
      
      private var _model:GameHallModel;
      
      private var _pageNumber:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _nextBtn:BaseButton;
      
      private var _preBtn:BaseButton;
      
      private var _firstPageBtn:BaseButton;
      
      private var _lastPageBtn:BaseButton;
      
      public function GameHallTeamEastLeftView(param1:Function = null)
      {
         super();
         _callBack = param1;
         _model = GameHallManager.instance.model;
         GameHallManager.instance.opEastFrame(0);
         _model.setCurrentPage();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamLeftView.backBtn");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.vbox");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.pageBg");
         _pageNumber = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.pageNumber");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.nextBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.preBtn");
         _firstPageBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.firstPageBtn");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.lastPageBtn");
         addChild(_returnBtn);
         addChild(_vbox);
         addChild(_pageBg);
         addChild(_pageNumber);
         addChild(_nextBtn);
         addChild(_preBtn);
         addChild(_firstPageBtn);
         addChild(_lastPageBtn);
         _returnBtn.x = 45;
         _returnBtn.y = 0;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageNumber);
         _pageNumber = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_firstPageBtn);
         _firstPageBtn = null;
         ObjectUtils.disposeObject(_lastPageBtn);
         _lastPageBtn = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         _returnBtn.addEventListener("click",__backBtnClickHandler);
         if(_model)
         {
            _model.addEventListener("SELECTED_GAME_INFO_UPDATE",__gameInfoUpdateHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_EAST_TEAMLEFTVIEW",__refreshViewHandler);
         }
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__onPageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__onPageBtnHandler);
         }
         if(_firstPageBtn)
         {
            _firstPageBtn.addEventListener("click",__firstPageBtnHandler);
         }
         if(_lastPageBtn)
         {
            _lastPageBtn.addEventListener("click",__lastPageBtnHandler);
         }
         if(_model)
         {
            _model.addEventListener("PAGE_UPDATE",__refreshPage);
         }
      }
      
      private function removeEvent() : void
      {
         _returnBtn.removeEventListener("click",__backBtnClickHandler);
         if(_model)
         {
            _model.removeEventListener("SELECTED_GAME_INFO_UPDATE",__gameInfoUpdateHandler);
         }
         if(_model)
         {
            _model.removeEventListener("SELECTED_GAME_INFO_UPDATE",__refreshViewHandler);
         }
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__onPageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__onPageBtnHandler);
         }
         if(_firstPageBtn)
         {
            _firstPageBtn.removeEventListener("click",__firstPageBtnHandler);
         }
         if(_lastPageBtn)
         {
            _lastPageBtn.removeEventListener("click",__lastPageBtnHandler);
         }
         if(_model)
         {
            _model.removeEventListener("PAGE_UPDATE",__refreshPage);
         }
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.pageBtnHandler(param1.currentTarget == _preBtn);
      }
      
      private function __firstPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.currentPage = 1;
         _model.commitChange();
      }
      
      private function __lastPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.currentPage = _model.totalPage;
         _model.commitChange();
      }
      
      private function __refreshPage(param1:GameHallEvent) : void
      {
         _pageNumber.text = _model.currentPage + "/" + _model.totalPage;
         refreshView();
         setPageBtnEnable();
      }
      
      private function setPageBtnEnable() : void
      {
         if(_preBtn)
         {
            _preBtn.enable = _model.currentPage > 1;
         }
         if(_preBtn)
         {
            _nextBtn.enable = _model.currentPage < _model.totalPage;
         }
         if(_firstPageBtn)
         {
            _firstPageBtn.enable = _model.currentPage > 1;
         }
         if(_lastPageBtn)
         {
            _lastPageBtn.enable = _model.currentPage < _model.totalPage;
         }
      }
      
      private function __gameInfoUpdateHandler(param1:GameHallEvent) : void
      {
         var _loc2_:GameHallTeamEastItemView = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_model.selectedDifficulty);
         _loc4_ = 0;
         while(_loc4_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc4_] as GameHallTeamEastItemView;
            if(_loc2_ && _loc2_.data && _loc3_ == _loc2_.data.TemplateId)
            {
               _loc2_.selected = true;
            }
            else
            {
               _loc2_.selected = false;
            }
            _loc4_++;
         }
      }
      
      private function __refreshViewHandler(param1:GameHallEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:GameHallTeamEastItemView = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:GameHallEasterTemplateInfo = null;
         if(_vbox)
         {
            _vbox.disposeAllChildren();
         }
         _itemList = new Vector.<GameHallTeamEastItemView>();
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc2_ = new GameHallTeamEastItemView();
            _loc2_.data = null;
            _itemList.push(_loc2_);
            if(_vbox)
            {
               _vbox.addChild(_loc2_);
            }
            _loc4_++;
         }
         var _loc1_:Array = _model.eastOpenTemplateIdArr;
         _loc6_ = 0;
         while(_loc6_ < _itemList.length)
         {
            _loc5_ = _loc6_ + (_model.currentPage - 1) * 5;
            _loc3_ = new GameHallEasterTemplateInfo();
            if(_loc5_ < _loc1_.length)
            {
               _loc3_ = TempleteManager.instance.gameHallEastTemplateCate.getTemplateByID(_loc1_[_loc5_]);
               _itemList[_loc6_].data = _loc3_;
            }
            else
            {
               _itemList[_loc6_].data = null;
            }
            _loc6_++;
         }
         if(_pageNumber)
         {
            _pageNumber.text = _model.currentPage + "/" + _model.totalPage;
         }
         setPageBtnEnable();
      }
      
      private function __backBtnClickHandler(param1:MouseEvent) : void
      {
         if(_callBack != null)
         {
            _callBack();
         }
      }
      
      public function set teamViewState(param1:Boolean) : void
      {
         _returnBtn.visible = !param1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

