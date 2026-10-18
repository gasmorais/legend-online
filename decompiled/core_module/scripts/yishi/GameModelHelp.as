package yishi
{
   import mainBar.SmallMapBar;
   import mainBar.TimeBoxView;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class GameModelHelp
   {
      
      public static const RPG_MODEL_STATE:int = 1;
      
      public static const SLG_MODEL_STATE:int = 2;
      
      public static var currentState:int = 1;
      
      public function GameModelHelp()
      {
         super();
      }
      
      public static function switchGameModel(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         currentState = param1;
         if(param2 || param3)
         {
            TopToolsBar.instance.hide();
            TaskTraceBar.instance.hide();
            QueueBar.instance.hide();
            SmallMapBar.instance.hide();
            MainToolBar.instance.getButtnByType(10).visible = false;
            MainToolBar.instance.getButtnByType(15).visible = false;
            MainToolBar.instance.getButtnByType(16).visible = false;
            MainToolBar.instance.getButtnByType(9).enable = true;
            MainToolBar.instance.getMovieImageByType(1).visible = false;
            MainToolBar.instance.getMovieImageByType(2).visible = false;
            TimeBoxView.instance.hide();
            NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",true));
         }
         else
         {
            TopToolsBar.instance.show();
            TaskTraceBar.instance.show();
            SmallMapBar.instance.show();
            MainToolBar.instance.recommendBtnIsExist(null);
            TimeBoxView.instance.show();
            NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",false));
         }
      }
   }
}

