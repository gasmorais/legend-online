package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.changejob.ChangePlayerInfoMsg;
   import mvc.FrameController;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketSendManager;
   
   public class ChangeJobControler extends FrameController
   {
      
      public function ChangeJobControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "changeJob.ChangeJobFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function sendChooseBranch(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9576);
         var _loc2_:ChangePlayerInfoMsg = new ChangePlayerInfoMsg();
         _loc2_.branch = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendChangeBranch(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9577);
         var _loc2_:ChangePlayerInfoMsg = new ChangePlayerInfoMsg();
         _loc2_.branch = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

