package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.VersionSwitch;
   
   public class GameHallActiveLeftView extends Sprite
   {
      
      private var _activeItem1:GameHallActiveItemView;
      
      private var _activeItem2:GameHallActiveItemView;
      
      private var _activeItem3:GameHallActiveItemView;
      
      private var _model:GameHallModel = GameHallManager.instance.model;
      
      public function GameHallActiveLeftView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _activeItem1 = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveLeftView.activeItem1",[1]);
         _activeItem2 = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveLeftView.activeItem2",[2]);
         _activeItem3 = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveLeftView.activeItem3",[3]);
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
         ObjectUtils.disposeObject(_activeItem1);
         _activeItem1 = null;
         ObjectUtils.disposeObject(_activeItem2);
         _activeItem2 = null;
         ObjectUtils.disposeObject(_activeItem3);
         _activeItem3 = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _model = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

