package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import events.SacrificeEvent;
   import mvc.FrameController;
   import mvc.module.sacrifice.SacrificeInfo;
   import yishi.manager.SacrificeManager;
   
   public class SacrificeController extends FrameController
   {
      
      private var _isInSacrificeFrame:Boolean = false;
      
      public function SacrificeController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         addEvent();
      }
      
      override public function get frameClassName() : String
      {
         return "sacrifice.SacrificeFrame";
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function get isInSacrificeFrame() : Boolean
      {
         return _isInSacrificeFrame;
      }
      
      public function set isInSacrificeFrame(param1:Boolean) : void
      {
         _isInSacrificeFrame = param1;
      }
      
      private function addEvent() : void
      {
         SacrificeManager.instance.addEventListener("INFO_UPDATE",__infoUpdateHandler);
      }
      
      private function __infoUpdateHandler(param1:SacrificeEvent) : void
      {
         var _loc2_:SacrificeInfo = param1.data as SacrificeInfo;
         switch(_loc2_.op - 1)
         {
            case 0:
               frame["openFrame"](_loc2_);
               break;
            case 1:
               frame["updateReward"](_loc2_.rewardArr);
               break;
            case 2:
               frame["sacrifice"](_loc2_);
               break;
            case 3:
               frame["getRewarFlyAction"](_loc2_);
               break;
            case 4:
               frame["getRewardDisappearAction"](_loc2_);
         }
      }
      
      public function sendOpen() : void
      {
         SacrificeManager.instance.sendReq(1);
      }
      
      public function sendRefreshReward() : void
      {
         SacrificeManager.instance.sendReq(2);
      }
      
      public function sendGetReward(param1:int) : void
      {
         SacrificeManager.instance.sendReq(3,param1);
      }
      
      public function sendSacrifice(param1:int) : void
      {
         SacrificeManager.instance.sendReq(4,param1);
      }
   }
}

