package mvc.module.secretary.acts
{
   import com.road.yishi.proto.player.PlayerOpMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class LabAction extends ILitteAction
   {
      
      public function LabAction()
      {
         super();
      }
      
      override public function exc() : void
      {
         var _loc2_:PackageOut = new PackageOut(9566);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 11;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
         isFinish = true;
      }
   }
}

