package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.event.FarmEvent;
   import flash.display.Sprite;
   import water.view.PlayerTreeExpView;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class FarmInfoView extends Sprite implements Disposeable
   {
      
      private var _myExpView:PlayerTreeExpView;
      
      private var _friendExpView:PlayerTreeExpView;
      
      private var _curSelectedFarm:FarmInfo;
      
      public function FarmInfoView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _myExpView = ComponentFactory.Instance.creatCustomObject("water.TreeExpView");
         _friendExpView = ComponentFactory.Instance.creatCustomObject("water.FriendTreeExpView");
         addChild(_myExpView);
         _myExpView.data = model.myFarm;
      }
      
      private function addEvent() : void
      {
         model.addEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
      }
      
      private function __selectedFarmChangeHandler(param1:FarmEvent) : void
      {
         _curSelectedFarm = param1.data as FarmInfo;
         if(_curSelectedFarm.grade == 0)
         {
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_curSelectedFarm)
         {
            if(_curSelectedFarm.userId == thane.userId)
            {
               _myExpView.data = _curSelectedFarm;
               setFriendViewVisible(false);
            }
            else
            {
               _friendExpView.data = _curSelectedFarm;
               setFriendViewVisible(true);
            }
         }
      }
      
      private function setFriendViewVisible(param1:Boolean) : void
      {
         if(param1)
         {
            addChild(_friendExpView);
         }
         else if(_friendExpView.parent)
         {
            _friendExpView.parent.removeChild(_friendExpView);
         }
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_myExpView)
         {
            _myExpView.dispose();
         }
         _myExpView = null;
         if(_friendExpView)
         {
            _friendExpView.dispose();
         }
         _friendExpView = null;
         _curSelectedFarm = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

