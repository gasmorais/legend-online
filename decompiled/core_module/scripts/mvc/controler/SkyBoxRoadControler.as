package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import managers.SkyboxRoadManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import yishi.scene.SceneManager;
   
   public class SkyBoxRoadControler extends FrameController
   {
      
      private var _isInSkyBoxRoadFrame:Boolean = false;
      
      public function SkyBoxRoadControler()
      {
         super();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function enterScene() : void
      {
         SceneManager.instance.setScene("SKYBOX_ROAD_SCENE",null,true);
      }
      
      public function get isInSkyBoxRoadFrame() : Boolean
      {
         return _isInSkyBoxRoadFrame;
      }
      
      public function set isInSkyBoxRoadFrame(param1:Boolean) : void
      {
         _isInSkyBoxRoadFrame = param1;
      }
      
      public function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      public function showCleanFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.SkyBoxRoadCleanPortaFrame");
         _loc1_["show"]();
      }
      
      override public function get frameClassName() : String
      {
         return "skyboxroad.SkyBoxRoadFrame.frame";
      }
   }
}

