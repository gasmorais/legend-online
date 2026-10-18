package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import managers.IncreasinglyRoadManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.increasingly.IncreasinglyModel;
   import yishi.scene.SceneManager;
   
   public class IncreasinglyRoadControler extends FrameController
   {
      
      private var _isIncreasinglyRoadFrame:Boolean = false;
      
      public function IncreasinglyRoadControler()
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
         SceneManager.instance.setScene("INCREASINGLY_ROAD_SCENE",null,true);
      }
      
      public function get isIncreasinglyRoadFrame() : Boolean
      {
         return _isIncreasinglyRoadFrame;
      }
      
      public function set isIncreasinglyRoadFrame(param1:Boolean) : void
      {
         _isIncreasinglyRoadFrame = param1;
      }
      
      public function get model() : IncreasinglyModel
      {
         return IncreasinglyRoadManager.instance.model;
      }
      
      override public function get frameClassName() : String
      {
         return "increasinglyroad.IncreasinglyRoadFrame";
      }
   }
}

