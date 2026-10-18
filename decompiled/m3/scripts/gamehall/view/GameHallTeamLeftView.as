package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.VersionSwitch;
   
   public class GameHallTeamLeftView extends Sprite
   {
      
      private var _backBtn:BaseButton;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _activeItem1:GameHallActiveItemView;
      
      private var _activeItem2:GameHallActiveItemView;
      
      private var _activeItem3:GameHallActiveItemView;
      
      private var _teamViewState:Boolean = false;
      
      private var _callBack:Function;
      
      private var _model:GameHallModel = GameHallManager.instance.model;
      
      public function GameHallTeamLeftView(param1:Function = null)
      {
         _callBack = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _backBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamLeftView.backBtn");
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamLeftView.prevBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamLeftView.nextBtn");
         _activeItem1 = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallTeamLeftView.activeItem1",[1,true]);
         _activeItem2 = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallTeamLeftView.activeItem2",[2,true]);
         _activeItem3 = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallTeamLeftView.activeItem3",[3,true]);
         _prevBtn.visible = false;
         _nextBtn.visible = false;
         addChild(_backBtn);
         addChild(_prevBtn);
         addChild(_nextBtn);
         addChild(_activeItem1);
         if(VersionSwitch.LAND_MINE)
         {
            addChild(_activeItem2);
         }
         if(VersionSwitch.PLANE_CRISIS)
         {
            addChild(_activeItem3);
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_backBtn);
         _backBtn = null;
         ObjectUtils.disposeObject(_prevBtn);
         _prevBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_activeItem1);
         _activeItem1 = null;
         ObjectUtils.disposeObject(_activeItem2);
         _activeItem2 = null;
         ObjectUtils.disposeObject(_activeItem3);
         _activeItem3 = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _callBack = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         _backBtn.addEventListener("click",__backBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _backBtn.removeEventListener("click",__backBtnClickHandler);
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
         _teamViewState = param1;
         _backBtn.visible = !_teamViewState;
         _activeItem1.teamViewState = _teamViewState;
         _activeItem2.teamViewState = _teamViewState;
         _activeItem3.teamViewState = _teamViewState;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

