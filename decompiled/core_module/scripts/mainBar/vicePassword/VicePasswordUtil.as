package mainBar.vicePassword
{
   import com.road.yishi.proto.player.LockAndUnlockMsg;
   import com.road.yishi.proto.player.VicePasswordMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class VicePasswordUtil
   {
      
      public static var CHECK_PW:int = 1;
      
      public static var SET_PW:int = 2;
      
      public static var CHANGE_PW:int = 3;
      
      public static var RESET_PW:int = 4;
      
      public static var recall:Function;
      
      public static var params:Array;
      
      public function VicePasswordUtil()
      {
         super();
      }
      
      public static function vpOp(param1:int, param2:String = "0", param3:String = "0", param4:String = "0") : void
      {
         var _loc6_:PackageOut = null;
         _loc6_ = new PackageOut(8806);
         var _loc5_:VicePasswordMsg = new VicePasswordMsg();
         _loc5_.opType = param1;
         _loc5_.prePass = param4;
         _loc5_.inputPass = param2;
         _loc5_.newPass = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public static function vpLockOp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = null;
         _loc5_ = new PackageOut(8809);
         var _loc4_:LockAndUnlockMsg = new LockAndUnlockMsg();
         _loc4_.opType = param1;
         _loc4_.itemPos = param2;
         _loc4_.petId = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function strCheck(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^\d{6}$/;
         var _loc3_:RegExp = /^[0-9]*$/;
         if(_loc3_.test(param1) == true)
         {
            if(_loc2_.test(param1) == true)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public static function numCheck(param1:String) : int
      {
         var _loc3_:RegExp = /^\d{6}$/;
         var _loc2_:RegExp = /^\d{7,}$/;
         var _loc4_:RegExp = /^[0-9]*$/;
         if(_loc4_.test(param1) == true)
         {
            if(_loc3_.test(param1) == true)
            {
               return 0;
            }
            if(_loc2_.test(param1) == true)
            {
               return 2;
            }
            return 3;
         }
         return 1;
      }
      
      public static function numCheckSame(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^(\d)\1{5}$/;
         if(_loc2_.test(param1) == true)
         {
            return true;
         }
         return false;
      }
      
      public static function numCheckContinuity(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^(012345|123456|234567|345678|456789|987654|876543|765432|654321|543210)$/;
         if(_loc2_.test(param1) == true)
         {
            return true;
         }
         return false;
      }
   }
}

