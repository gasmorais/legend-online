package water.data
{
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   import water.events.WaterEvent;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.playerinfo.TreeInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.WaterManager;
   
   public class WaterTreeModel extends EventDispatcher
   {
      
      private var _currentSelectedUser:ThaneInfo;
      
      private var _currentSelectedTreeInfo:TreeInfo;
      
      public function WaterTreeModel()
      {
         super();
      }
      
      public function set defaultSelectedUser(param1:ThaneInfo) : void
      {
         if(_currentSelectedUser == param1)
         {
            commitChanges();
         }
         else
         {
            currentSelectedUser = param1;
         }
      }
      
      public function set currentSelectedUser(param1:ThaneInfo) : void
      {
         if(_currentSelectedUser == param1)
         {
            return;
         }
         _currentSelectedUser = param1;
         _currentSelectedTreeInfo = WaterManager.instance.treeList[_currentSelectedUser.userId] as TreeInfo;
         if(!_currentSelectedTreeInfo)
         {
            _currentSelectedTreeInfo = new TreeInfo();
            _currentSelectedTreeInfo.userId = _currentSelectedUser.userId;
            _currentSelectedTreeInfo.notHasTree = true;
            WaterManager.instance.treeList[_currentSelectedUser.userId] = _currentSelectedTreeInfo;
         }
         _currentSelectedTreeInfo.requestTime = getTimer();
         if(_currentSelectedTreeInfo.needRequiest)
         {
         }
         commitChanges();
      }
      
      private function commitChanges() : void
      {
         dispatchEvent(new WaterEvent("SELECTED_TREE_CHANGE",_currentSelectedTreeInfo));
      }
      
      public function get currentSelectedUser() : ThaneInfo
      {
         return _currentSelectedUser;
      }
      
      public function get currentSelectedTreeInfo() : TreeInfo
      {
         return _currentSelectedTreeInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

