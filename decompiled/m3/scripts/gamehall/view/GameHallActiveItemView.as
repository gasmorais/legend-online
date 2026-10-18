package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.GameHallEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallGameInfo;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.templates.GameHallTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MoneyUtils;
   
   public class GameHallActiveItemView extends Sprite
   {
      
      private var _activeBtn:IconButton;
      
      private var _selectedEffect:Image;
      
      private var _activeNewFlag:Image;
      
      private var _activeDayTxt:FilterFrameText;
      
      private var _diffContainer:Sprite;
      
      private var _diffBg:Image;
      
      private var _diffBtn1:SelectedTextButton;
      
      private var _diffBtn2:SelectedTextButton;
      
      private var _diffGroup:SelectedButtonGroup;
      
      private var _gameId:int;
      
      private var _isTeamView:Boolean = false;
      
      private var _teamViewState:Boolean = false;
      
      private var _data:GameHallTemplateInfo;
      
      private var _model:GameHallModel = GameHallManager.instance.model;
      
      public function GameHallActiveItemView(param1:int, param2:Boolean = false)
      {
         _gameId = param1;
         _isTeamView = param2;
         super();
         initView();
         addEvent();
         data = TempleteManager.instance.gameHallTemplateCate.getTemplateByID(param1);
      }
      
      private function initView() : void
      {
         _activeBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveItemView.activeBtn" + _gameId);
         _selectedEffect = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveItemView.selectedEffect");
         _activeNewFlag = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveItemView.activeNewFlag");
         _activeDayTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveItemView.activeDayTxt");
         _diffContainer = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveItemView.diffContainer");
         _diffBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveItemView.diffBg");
         _diffBtn1 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveItemView.diffBtn1");
         _diffBtn2 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveItemView.diffBtn2");
         _diffContainer.addChild(_diffBg);
         _diffContainer.addChild(_diffBtn1);
         _diffContainer.addChild(_diffBtn2);
         _activeDayTxt.mouseEnabled = false;
         _diffBtn1.text = LanguageMgr.GetTranslation("gamehall.GameHallActiveItemView.diffBtnTxt1");
         _diffBtn2.text = LanguageMgr.GetTranslation("gamehall.GameHallActiveItemView.diffBtnTxt2");
         _diffContainer.visible = false;
         _selectedEffect.visible = false;
         _activeNewFlag.visible = false;
         addChild(_activeBtn);
         addChild(_selectedEffect);
         addChild(_activeNewFlag);
         addChild(_activeDayTxt);
         addChild(_diffContainer);
         _diffGroup = new SelectedButtonGroup();
         _diffGroup.addSelectItem(_diffBtn1);
         _diffGroup.addSelectItem(_diffBtn2);
         _diffGroup.selectIndex = 0;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(_diffContainer);
         ObjectUtils.disposeObject(_activeBtn);
         _activeBtn = null;
         ObjectUtils.disposeObject(_selectedEffect);
         _selectedEffect = null;
         ObjectUtils.disposeObject(_activeNewFlag);
         _activeNewFlag = null;
         ObjectUtils.disposeObject(_activeDayTxt);
         _activeDayTxt = null;
         ObjectUtils.disposeObject(_diffContainer);
         _diffContainer = null;
         ObjectUtils.disposeObject(_diffBg);
         _diffBg = null;
         ObjectUtils.disposeObject(_diffBtn1);
         _diffBtn1 = null;
         ObjectUtils.disposeObject(_diffBtn2);
         _diffBtn2 = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _diffGroup = null;
         _data = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         _activeBtn.addEventListener("click",__activeBtnClickHandler);
         _diffGroup.addEventListener("change",__selectedChangHandler);
         _model.addEventListener("SELECTED_GAME_INFO_UPDATE",__gameInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         _activeBtn.removeEventListener("click",__activeBtnClickHandler);
         _diffGroup.removeEventListener("change",__selectedChangHandler);
         _model.removeEventListener("SELECTED_GAME_INFO_UPDATE",__gameInfoUpdateHandler);
      }
      
      private function __activeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = _gameId;
         var _loc4_:int = 0;
         var _loc3_:GameHallGameInfo = new GameHallGameInfo();
         _loc3_.gameId = _loc2_;
         if(_loc3_.templateInfo.hasDiffSelect)
         {
            _loc4_ = diffSelected;
         }
         _model.selectedGameId = _loc2_;
         _model.selectedDifficulty = _loc4_;
         _model.updateSelectedGameInfo();
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         var _loc2_:int = _gameId;
         var _loc3_:int = diffSelected;
         _model.selectedGameId = _loc2_;
         _model.selectedDifficulty = _loc3_;
         _model.updateSelectedGameInfo();
      }
      
      private function get diffSelected() : int
      {
         return _diffGroup.selectIndex + 1;
      }
      
      private function __gameInfoUpdateHandler(param1:GameHallEvent) : void
      {
         var _loc2_:int = int(_model.selectedGameId);
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         if(_loc2_ == _gameId)
         {
            _loc3_ = true;
         }
         selected = _loc3_;
         var _loc4_:GameHallGameInfo = new GameHallGameInfo();
         _loc4_.gameId = _loc2_;
         if(_loc4_.templateInfo.hasDiffSelect)
         {
            _diffGroup.removeEventListener("change",__selectedChangHandler);
            _diffGroup.selectIndex = _model.selectedDifficulty - 1;
            _diffGroup.addEventListener("change",__selectedChangHandler);
         }
      }
      
      public function get data() : GameHallTemplateInfo
      {
         return _data;
      }
      
      public function set data(param1:GameHallTemplateInfo) : void
      {
         _data = param1;
         if(data)
         {
            refresh();
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selectedEffect.visible = param1;
      }
      
      private function refresh() : void
      {
         var _loc5_:int = 0;
         if(_isTeamView && Boolean(data.hasDiffSelect))
         {
            _diffContainer.visible = true;
         }
         else
         {
            _diffContainer.visible = false;
         }
         _activeNewFlag.visible = data.isNewGame;
         var _loc2_:Array = data.OpenDays.split(",");
         var _loc1_:int = int(_loc2_.length);
         var _loc8_:String = LanguageMgr.GetTranslation("gamehall.GameHallActiveItemView.week");
         var _loc3_:String = LanguageMgr.GetTranslation("gamehall.GameHallActiveItemView.day");
         var _loc6_:String = LanguageMgr.GetTranslation("gamehall.GameHallActiveItemView.sign");
         var _loc4_:Array = [];
         var _loc7_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc1_)
         {
            _loc7_ = int(_loc2_[_loc5_]);
            if(_loc7_ == 7)
            {
               _loc4_.push(_loc3_);
            }
            else
            {
               _loc4_.push(MoneyUtils.toCNUpper(_loc7_,true));
            }
            _loc5_++;
         }
         _activeDayTxt.text = _loc8_ + _loc4_.join(_loc6_);
         if(GameHallManager.instance.isOpenToday(data.GameId))
         {
            _activeDayTxt.setFrame(1);
            if(_isTeamView)
            {
               _activeBtn.enable = true;
               _diffBtn1.enable = true;
               _diffBtn2.enable = true;
            }
         }
         else
         {
            _activeDayTxt.setFrame(2);
            if(_isTeamView)
            {
               _activeBtn.enable = false;
               _diffBtn1.enable = false;
               _diffBtn2.enable = false;
            }
         }
      }
      
      public function set teamViewState(param1:Boolean) : void
      {
         if(_isTeamView)
         {
            _teamViewState = param1;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

