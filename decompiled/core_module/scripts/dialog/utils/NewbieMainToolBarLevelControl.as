package dialog.utils
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ui.maintoolbar.MainToolBar;
   import ui.maintoolbar.view.MainToolButton;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   
   public class NewbieMainToolBarLevelControl extends EventDispatcher
   {
      
      private static var _instance:NewbieMainToolBarLevelControl;
      
      private var _isFirst:Boolean = true;
      
      private var _timeId:int;
      
      public function NewbieMainToolBarLevelControl()
      {
         super();
         ArmyManager.instance.thane.addEventListener("THANE_LEVEL_UPDATE",__onLevelUpHandler);
         NotificationManager.instance.addEventListener("TASK_COMMIT",__onTaskCommitHandler);
         _timeId = setTimeout(function():void
         {
            clearTimeout(_timeId);
            __onTaskCommitHandler(null);
            __onLevelUpHandler(null);
            _isFirst = false;
         },500);
      }
      
      public static function get instance() : NewbieMainToolBarLevelControl
      {
         if(_instance == null)
         {
            _instance = new NewbieMainToolBarLevelControl();
         }
         return _instance;
      }
      
      private function __onTaskCommitHandler(param1:Event) : void
      {
         var _loc4_:MainToolButton = null;
         var _loc3_:Object = {};
         _loc3_[2] = 1823;
         _loc3_[4] = 1826;
         _loc3_[3] = 1827;
         for(var _loc2_:String in _loc3_)
         {
            _loc4_ = MainToolBar.instance.getButtnByType(int(_loc2_));
            if(_loc4_)
            {
               _loc4_.isVisible = TaskManage.instance.IsTaskFinish(int(_loc3_[_loc2_]));
               if(_isFirst)
               {
                  _loc4_.enable = _loc4_.isVisible;
               }
            }
         }
         if(_isFirst)
         {
            MainToolBar.instance.doMove();
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __onLevelUpHandler(param1:PlayerEvent) : void
      {
         var _loc4_:MainToolButton = null;
         var _loc3_:Object = {};
         _loc3_[1] = 10;
         _loc3_[2] = 4;
         _loc3_[14] = 50;
         _loc3_[3] = 7;
         _loc3_[5] = 18;
         _loc3_[4] = 7;
         _loc3_[6] = 70;
         _loc3_[7] = 6;
         _loc3_[8] = 13;
         _loc3_[13] = 16;
         _loc3_[17] = 15;
         for(var _loc2_:String in _loc3_)
         {
            _loc4_ = MainToolBar.instance.getButtnByType(int(_loc2_));
            if(_loc4_)
            {
               _loc4_.isVisible = ArmyManager.instance.thane.grades >= int(_loc3_[_loc2_]);
               if(_isFirst || ArmyManager.instance.thane.grades >= 10)
               {
                  _loc4_.enable = _loc4_.isVisible;
               }
            }
         }
         if(_isFirst)
         {
            MainToolBar.instance.doMove();
         }
      }
   }
}

