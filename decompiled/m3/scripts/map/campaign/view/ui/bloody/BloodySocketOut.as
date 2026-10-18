package map.campaign.view.ui.bloody
{
   import com.road.yishi.proto.bloodyrealm.EggInfoMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class BloodySocketOut
   {
      
      public function BloodySocketOut()
      {
         super();
      }
      
      public static function poundEgg() : void
      {
         var _loc2_:PackageOut = null;
         _loc2_ = new PackageOut(9588);
         var _loc1_:EggInfoMsg = new EggInfoMsg();
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function pickUpBox(param1:int) : void
      {
         var _loc3_:PackageOut = null;
         _loc3_ = new PackageOut(9589);
         var _loc2_:EggInfoMsg = new EggInfoMsg();
         _loc2_.id = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
   }
}

