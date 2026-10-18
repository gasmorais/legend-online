package goddess.page
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import goddess.view.GoddessActiveView;
   import goddess.view.GoddessLevelView;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessInfo;
   import yishi.utils.MsgMan;
   
   public class GoddessLevelPage extends Component
   {
      
      private var _activeView:GoddessActiveView;
      
      private var _levelView:GoddessLevelView;
      
      private var _data:GoddessInfo;
      
      public function GoddessLevelPage()
      {
         super();
         initEvent();
         data = model.selectInfo;
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      public function get data() : GoddessInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessInfo) : void
      {
         if(_data == param1 || param1 == null)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_data == null)
         {
            return;
         }
         if(_data.isActive)
         {
            creatLevelView();
         }
         else
         {
            creatActiveView();
         }
      }
      
      private function creatActiveView() : void
      {
         if(_levelView && _levelView.parent)
         {
            _levelView.parent.removeChild(_levelView);
         }
         if(_activeView == null)
         {
            _activeView = new GoddessActiveView();
         }
         _activeView.data = _data;
         addChild(_activeView);
      }
      
      private function creatLevelView() : void
      {
         if(_activeView && _activeView.parent)
         {
            _activeView.parent.removeChild(_activeView);
         }
         if(_levelView == null)
         {
            _levelView = new GoddessLevelView();
         }
         _levelView.data = _data;
         addChild(_levelView);
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("GodDessEvent.choose",this,chooseHandler);
         MsgMan.addObserver("GodDessEvent.isActive",this,activeHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("GodDessEvent.choose",this,chooseHandler);
         MsgMan.removeObserver("GodDessEvent.isActive",this,activeHandler);
      }
      
      private function activeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         if(data == _loc3_)
         {
            refreshView();
         }
      }
      
      private function chooseHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         data = _loc3_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_activeView);
         _activeView = null;
         ObjectUtils.disposeObject(_levelView);
         _levelView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
         _data = null;
      }
   }
}

