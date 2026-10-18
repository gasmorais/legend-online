package yishi.scene
{
   import com.pickgliss.ui.LayerManager;
   import flash.display.MovieClip;
   
   public class EnterBattleSceneSwitchAnimation implements ISceneSwitchAnimation
   {
      
      private var _callBack:Function;
      
      private var _curScene:BaseSceneView;
      
      private var _nextScene:BaseSceneView;
      
      private var _mc:MovieClip;
      
      public function EnterBattleSceneSwitchAnimation(param1:Function)
      {
         super();
         _callBack = param1;
      }
      
      public function set nextScene(param1:BaseSceneView) : void
      {
         _nextScene = param1;
      }
      
      public function set curScene(param1:BaseSceneView) : void
      {
         _curScene = param1;
      }
      
      public function start() : void
      {
         LayerManager.Instance.clearnGameDynamic();
         _callBack();
      }
      
      public function stop() : void
      {
      }
   }
}

