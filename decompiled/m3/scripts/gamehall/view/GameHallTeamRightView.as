package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.GameHallEvent;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallModel;
   import mvc.module.gamehall.GameHallTeamInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.utils.StringHelper;
   
   public class GameHallTeamRightView extends Sprite implements IEnterFrame
   {
      
      private var _bg:Image;
      
      private var _refreshBtn:IconButton;
      
      private var _createBtn:IconButton;
      
      private var _searchBtn:BaseButton;
      
      private var _searchTxt:FilterFrameText;
      
      private var _searchTipTxt:FilterFrameText;
      
      private var _searchInputTxt:FilterFrameText;
      
      private var _refreshTimeCountTxt:FilterFrameText;
      
      private var _listPanel:ListPanel;
      
      private var _teamViewState:Boolean = false;
      
      private var _lastTime:Number;
      
      private var _autoTimeCount:int = 0;
      
      private var _handTimeCount:int = 0;
      
      private var _countDiff:int = 1;
      
      private var _model:GameHallModel = GameHallManager.instance.model;
      
      public var gameId:int;
      
      public var difficulty:int;
      
      public function GameHallTeamRightView()
      {
         super();
         initView();
         addEvent();
         initRefreshData();
         GameHallManager.instance.teamList();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamRightView.bg");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamRightView.refreshBtn");
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamRightView.createBtn");
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamRightView.searchBtn");
         _searchTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamRightView.searchTxt");
         _searchTipTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamRightView.searchTipTxt");
         _searchInputTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamRightView.searchInputTxt");
         _refreshTimeCountTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamRightView.refreshTimeCountTxt");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamRightView.listPanel");
         _searchTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallTeamRightView.searchTxt");
         _searchTipTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallTeamRightView.searchInputTxt");
         addChild(_bg);
         addChild(_refreshBtn);
         addChild(_createBtn);
         addChild(_searchBtn);
         addChild(_searchTxt);
         addChild(_searchTipTxt);
         addChild(_searchInputTxt);
         addChild(_refreshTimeCountTxt);
         addChild(_listPanel);
      }
      
      private function initRefreshData() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = getTimer();
         var _loc3_:int = 0;
         if(_model.refreshTime != -1)
         {
            _lastTime = _model.refreshTime;
            _loc2_ = _loc1_ - _lastTime;
            _countDiff = _loc2_ / 1000;
            _loc3_ = 20 - _countDiff;
            if(_loc3_ > 0)
            {
               _refreshTimeCountTxt.text = LanguageMgr.GetTranslation("gamehall.view.GameHallTeamRightView",_loc3_);
               _refreshBtn.enable = false;
            }
         }
         else
         {
            _lastTime = _loc1_;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_createBtn);
         _createBtn = null;
         ObjectUtils.disposeObject(_searchBtn);
         _searchBtn = null;
         ObjectUtils.disposeObject(_searchTxt);
         _searchTxt = null;
         ObjectUtils.disposeObject(_searchTipTxt);
         _searchTipTxt = null;
         ObjectUtils.disposeObject(_searchInputTxt);
         _searchInputTxt = null;
         ObjectUtils.disposeObject(_refreshTimeCountTxt);
         _refreshTimeCountTxt = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _model = null;
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
         _createBtn.addEventListener("click",__createBtnClickHandler);
         _searchBtn.addEventListener("click",__searchBtnClickHandler);
         _searchInputTxt.addEventListener("keyDown",__keyDownHandler);
         _searchInputTxt.addEventListener("focusIn",__focusInHandler);
         _searchInputTxt.addEventListener("focusOut",__focusOutHandler);
         _model.addEventListener("SELECTED_GAME_INFO_UPDATE",__infoUpdateHandler);
         _model.addEventListener("INFO_UPDATE",__infoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
         _createBtn.removeEventListener("click",__createBtnClickHandler);
         _searchBtn.removeEventListener("click",__searchBtnClickHandler);
         _searchInputTxt.removeEventListener("keyDown",__keyDownHandler);
         _searchInputTxt.removeEventListener("focusIn",__focusInHandler);
         _searchInputTxt.removeEventListener("focusOut",__focusOutHandler);
         _model.removeEventListener("SELECTED_GAME_INFO_UPDATE",__infoUpdateHandler);
         _model.removeEventListener("INFO_UPDATE",__infoUpdateHandler);
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Number = getTimer();
         var _loc2_:Number = _loc1_ - _lastTime;
         var _loc3_:int = 0;
         if(_loc2_ >= 1000)
         {
            _countDiff = _loc2_ / 1000;
            _autoTimeCount += _countDiff;
            if(!_refreshBtn.enable)
            {
               _handTimeCount += _countDiff;
               _loc3_ = 20 - _handTimeCount;
               _refreshTimeCountTxt.text = LanguageMgr.GetTranslation("gamehall.view.GameHallTeamRightView",_loc3_);
            }
            _lastTime = _loc1_;
         }
         if(_autoTimeCount >= 30)
         {
            _autoTimeCount = 0;
            GameHallManager.instance.teamList();
         }
         if(!_refreshBtn.enable && _handTimeCount >= 20)
         {
            _handTimeCount = 0;
            _model.refreshTime = -1;
            _refreshBtn.enable = true;
            _refreshTimeCountTxt.text = "";
         }
      }
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void
      {
         GameHallManager.instance.teamList(true);
         _model.refreshTime = getTimer();
         _refreshBtn.enable = false;
         _refreshTimeCountTxt.text = LanguageMgr.GetTranslation("gamehall.view.GameHallTeamRightView",20);
      }
      
      private function __createBtnClickHandler(param1:MouseEvent) : void
      {
         GameHallManager.instance.teamCreate(_model.selectedGameId,_model.selectedDifficulty);
      }
      
      private function __searchBtnClickHandler(param1:MouseEvent) : void
      {
         searchSend();
      }
      
      private function searchSend() : void
      {
         var _loc1_:int = int(_searchInputTxt.text);
         GameHallManager.instance.teamSearch(_loc1_);
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            searchSend();
         }
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __focusInHandler(param1:FocusEvent) : void
      {
         _searchTipTxt.visible = false;
      }
      
      private function __focusOutHandler(param1:FocusEvent) : void
      {
         if(StringHelper.isNullOrEmpty(_searchInputTxt.text))
         {
            _searchTipTxt.visible = true;
         }
      }
      
      private function __infoUpdateHandler(param1:GameHallEvent) : void
      {
         refreshList();
      }
      
      private function refreshList() : void
      {
         var _loc3_:GameHallTeamInfo = null;
         var _loc6_:int = 0;
         _listPanel.beginChanges();
         _listPanel.vectorListModel.clear();
         var _loc2_:int = -1;
         var _loc1_:int = int(_model.teamList.length);
         var _loc5_:int = 0;
         var _loc4_:int = int(_model.selectedGameId);
         var _loc7_:int = int(_model.selectedDifficulty);
         _loc6_ = 0;
         while(_loc6_ < _loc1_)
         {
            _loc3_ = _model.teamList[_loc6_];
            if(_loc4_ == _loc3_.gameId)
            {
               if(!(_loc7_ != 0 && _loc7_ != _loc3_.difficulty))
               {
                  _listPanel.vectorListModel.append(_loc3_);
                  if(_model.searchTeam && _loc3_.teamId == _model.searchTeam.teamId)
                  {
                     _loc2_ = _loc5_;
                     _model.searchTeam = null;
                  }
                  _loc5_++;
               }
            }
            _loc6_++;
         }
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         if(_loc2_ != -1)
         {
            _listPanel.list.scrollToIndex(_loc2_);
         }
         _listPanel.list.updateListView();
      }
      
      public function set teamViewState(param1:Boolean) : void
      {
         _teamViewState = param1;
         _createBtn.enable = !_teamViewState;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

