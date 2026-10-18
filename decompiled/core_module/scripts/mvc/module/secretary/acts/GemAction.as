package mvc.module.secretary.acts
{
   import com.road.yishi.proto.player.PlayerOpMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class GemAction extends ILitteAction
   {
      
      public function GemAction()
      {
         super();
      }
      
      override public function exc() : void
      {
         var _loc2_:PackageOut = new PackageOut(9741);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
         isFinish = true;
      }
   }
}

