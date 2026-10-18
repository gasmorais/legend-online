package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   
   public class GameHallActiveView extends Sprite
   {
      
      private const NEW_TXT_PADDING:int = 120;
      
      private var _border:Scale9CornerImage;
      
      private var _hBox:HBox;
      
      private var _txtContainer:Sprite;
      
      private var _groupBtn1:SelectedIconButton;
      
      private var _eastBtn:SelectedIconButton;
      
      private var _groupBtnList:Vector.<SelectedIconButton>;
      
      private var _newTxtList:Vector.<FilterFrameText>;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _leftView:GameHallActiveLeftView;
      
      private var _rightView:GameHallActiveRightView;
      
      private var _eastView:GameHallActiveEastView;
      
      private var _callBack:Function;
      
      private var _model:GameHallModel = GameHallManager.instance.model;
      
      public function GameHallActiveView(param1:Function = null)
      {
         _callBack = param1;
         super();
         initView();
         addEvent();
         __selectedChangHandler(null);
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveView.border");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveView.hBox");
         _txtContainer = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveView.txtContainer");
         _groupBtn1 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveView.groupBtn1");
         _eastBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveView.eastBtn");
         _leftView = new GameHallActiveLeftView();
         _rightView = new GameHallActiveRightView(_callBack);
         _leftView.x = 0;
         _leftView.y = 31;
         _rightView.x = 210;
         _rightView.y = 31;
         _groupBtnList = new Vector.<SelectedIconButton>();
         _groupBtnList.push(_groupBtn1);
         _newTxtList = new Vector.<FilterFrameText>();
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = _hBox.y - 3;
         if(_model.groupHasValidGame(1))
         {
            _loc1_ = _hBox.x + _loc3_ * 120 - 3;
            _hBox.addChild(_groupBtn1);
            _loc3_++;
            if(_model.groupHasNewGame(1))
            {
               createNewTxt(_loc1_,_loc2_);
            }
         }
         if(_model.groupHasValidGame(1))
         {
            _loc1_ = _hBox.x + _loc3_ * 120 - 3;
            _hBox.addChild(_groupBtn1);
            _loc3_++;
            if(_model.groupHasNewGame(1))
            {
               createNewTxt(_loc1_,_loc2_);
            }
         }
         addChild(_border);
         addChild(_hBox);
         addChild(_txtContainer);
         addChild(_leftView);
         addChild(_rightView);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_groupBtn1);
         if(_model.groupHasValidGame(2))
         {
            _hBox.addChild(_eastBtn);
            _eastView = new GameHallActiveEastView(_callBack);
            _eastView.x = 0;
            _eastView.y = 31;
            addChild(_eastView);
            _btnGroup.addSelectItem(_eastBtn);
            _btnGroup.selectIndex = 1;
         }
         else
         {
            _btnGroup.selectIndex = 0;
         }
      }
      
      private function createNewTxt(param1:int, param2:int) : void
      {
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveView.newTxt");
         _loc3_.text = LanguageMgr.GetTranslation("gamehall.GameHallActiveView.newTxt");
         _loc3_.x = param1;
         _loc3_.y = param2;
         _txtContainer.addChild(_loc3_);
         _newTxtList.push(_loc3_);
      }
      
      private function uninitView() : void
      {
         if(_hBox)
         {
            _hBox.disposeAllChildren();
         }
         if(_groupBtnList)
         {
            for each(var _loc2_:SelectedIconButton in _groupBtnList)
            {
               ObjectUtils.disposeObject(_loc2_);
               _loc2_ = null;
            }
         }
         if(_newTxtList)
         {
            for each(var _loc1_:FilterFrameText in _newTxtList)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
         ObjectUtils.disposeAllChildren(_txtContainer);
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_txtContainer);
         _txtContainer = null;
         ObjectUtils.disposeObject(_groupBtn1);
         _groupBtn1 = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _btnGroup = null;
         _groupBtnList = null;
         _newTxtList = null;
         _callBack = null;
         _model = null;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function addEvent() : void
      {
         _btnGroup.addEventListener("change",__selectedChangHandler);
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__selectedChangHandler);
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(_btnGroup.getSelectedItem() == _eastBtn)
         {
            _leftView.visible = false;
            _rightView.visible = false;
            if(_eastView)
            {
               _eastView.visible = true;
            }
            _model.selectedGameId = 4;
            _model.selectedDifficulty = 0;
         }
         else
         {
            if(_eastView)
            {
               _eastView.visible = false;
            }
            _rightView.visible = true;
            _leftView.visible = true;
            _model.selectedGameId = 1;
            _model.selectedDifficulty = 0;
         }
         _model.updateSelectedGameInfo();
      }
      
      public function defaultView() : void
      {
         if(!_model.inited)
         {
            _model.selectedGameId = 1;
            _model.selectedDifficulty = 0;
            _model.updateSelectedGameInfo();
            _model.inited = true;
         }
      }
      
      public function refreshActiveEasLeftView() : void
      {
         if(_eastView)
         {
            _eastView.refreshView();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

