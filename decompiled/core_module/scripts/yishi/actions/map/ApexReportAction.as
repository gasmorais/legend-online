package yishi.actions.map
{
   import yishi.manager.FrameControllerManager;
   import yishi.scene.SceneManager;
   
   public class ApexReportAction extends MapBaseAction
   {
      
      public function ApexReportAction()
      {
         super();
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
         {
            dispose();
            FrameControllerManager.instance.openControllerByInfo("apex",7);
         }
      }
      
      override public function prepare() : void
      {
      }
   }
}

