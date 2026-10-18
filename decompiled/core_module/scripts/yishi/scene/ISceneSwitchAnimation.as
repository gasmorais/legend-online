package yishi.scene
{
   public interface ISceneSwitchAnimation
   {
      
      function set nextScene(param1:BaseSceneView) : void;
      
      function set curScene(param1:BaseSceneView) : void;
      
      function start() : void;
      
      function stop() : void;
   }
}

