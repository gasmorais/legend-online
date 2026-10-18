package gamehall.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallArmy;
   import mvc.module.gamehall.GameHallTeamInfo;
   import mvc.module.gamehall.GameHallUserInfo;
   import utils.LogicUtils;
   
   public class GameHallSceneTeamView extends Sprite
   {
      
      private var _hBox:HBox;
      
      private var _hero1:GameHallSceneTeamItemView;
      
      private var _hero2:GameHallSceneTeamItemView;
      
      private var _hero3:GameHallSceneTeamItemView;
      
      private var _hero4:GameHallSceneTeamItemView;
      
      private var _hero0:GameHallSceneTeamItemView;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _bg:ScaleBitmapImage;
      
      private var _closeBtn:BaseButton;
      
      private var _playerList:Dictionary;
      
      private var _callBack:Function;
      
      private var _currentSelected:GameHallSceneTeamItemView;
      
      public function GameHallSceneTeamView(param1:Function = null)
      {
         _callBack = param1;
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.bg");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.Box");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.TeamSortFrameClose");
         addChild(_bg);
         addChild(_hBox);
         addChild(_closeBtn);
         _closeBtn.x = 440;
         _closeBtn.y = -5;
         _buttonGroup = new SelectedButtonGroup();
         _playerList = new Dictionary();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            this["_hero" + _loc1_] = new GameHallSceneTeamItemView();
            _hBox.addChild(this["_hero" + _loc1_]);
            _buttonGroup.addSelectItem(this["_hero" + _loc1_] as ISelectable);
            _playerList[_loc1_] = this["_hero" + _loc1_];
            (this["_hero" + _loc1_] as GameHallSceneTeamItemView).index = _loc1_;
            _loc1_++;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         LogicUtils.disposeDisplayCollection(_playerList);
         _playerList = null;
         _callBack = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         for each(var _loc1_:GameHallSceneTeamItemView in _playerList)
         {
            _loc1_.addEventListener("click",__itemClickHandler);
         }
         _closeBtn.addEventListener("click",__closeBtnHandler);
      }
      
      private function removeEvent() : void
      {
         if(_playerList)
         {
            for each(var _loc1_:GameHallSceneTeamItemView in _playerList)
            {
               _loc1_.removeEventListener("click",__itemClickHandler);
            }
         }
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeBtnHandler);
         }
      }
      
      private function __closeBtnHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         _currentSelected = param1.currentTarget as GameHallSceneTeamItemView;
         if(!_currentSelected)
         {
            return;
         }
         if(_currentSelected.data)
         {
            _callBack(_currentSelected.data.userId);
         }
         dispose();
      }
      
      private function refreshView() : void
      {
         var _loc7_:GameHallArmy = null;
         var _loc2_:GameHallUserInfo = null;
         var _loc6_:GameHallSceneTeamItemView = null;
         var _loc5_:int = 0;
         var _loc1_:Array = [];
         var _loc4_:GameHallTeamInfo = GameHallManager.instance.model.selfTeam;
         var _loc3_:int = int(_loc4_.players.length);
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            if(_loc5_ < _loc3_)
            {
               _loc2_ = _loc4_.players[_loc5_];
               _loc7_ = GameHallManager.instance.model.getUserArmyByUserId(_loc2_.userId);
            }
            else
            {
               _loc7_ = null;
            }
            _loc6_ = _playerList[_loc5_] as GameHallSceneTeamItemView;
            _loc6_.data = _loc7_;
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

