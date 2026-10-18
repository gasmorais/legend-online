package yishi.lunch
{
   import com.pickgliss.toplevel.StageReferance;
   import com.road.yishi.proto.simple.CollectInfoMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   import yishi.utils.GetUserData;
   
   public class DelayFunsAfterLogin
   {
      
      public function DelayFunsAfterLogin()
      {
         super();
      }
      
      public static function start() : void
      {
         GetUserData.init(StageReferance.stage,saveVersion);
      }
      
      private static function saveVersion(param1:String, param2:String, param3:String) : void
      {
         var _loc5_:PackageOut = null;
         _loc5_ = new PackageOut(8796);
         var _loc4_:CollectInfoMsg = new CollectInfoMsg();
         _loc4_.type = 1;
         _loc4_.strParam1 = param1;
         _loc4_.strParam2 = param2;
         _loc4_.strParam3 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
   }
}

