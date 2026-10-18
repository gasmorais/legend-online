package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import events.GodTreasureEvent;
   import managers.GodTreasureManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.godTreasure.GodTreasureInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class GodTreasureControler extends FrameController
   {
      
      public function GodTreasureControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         addEvent();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         return "godtreasure.frame";
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      private function addEvent() : void
      {
         GodTreasureManager.instance.addEventListener("INFO_UPDATE",__infoUpdateHandler);
      }
      
      private function __infoUpdateHandler(param1:GodTreasureEvent) : void
      {
         var _loc2_:GodTreasureInfo = param1.data as GodTreasureInfo;
         switch(_loc2_.op - 1)
         {
            case 0:
               frame["openFrame"](_loc2_);
               break;
            case 1:
               frame["updateView"](_loc2_);
               break;
            case 2:
               FrameControllerManager.instance.closeControllerByInfo("godtreasure");
         }
      }
      
      public function openGodTreasureHelpFrame() : void
      {
         var _loc1_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("godtreasure.godtreasureHelpFrame");
         _loc1_.show();
      }
      
      public function sendOpen() : void
      {
         GodTreasureManager.instance.senReq(1);
      }
      
      public function jionHandler(param1:int) : void
      {
         GodTreasureManager.instance.senReq(2,param1);
      }
      
      public function sendGetReward() : void
      {
         GodTreasureManager.instance.senReq(3);
      }
   }
}

