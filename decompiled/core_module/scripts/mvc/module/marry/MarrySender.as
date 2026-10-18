package mvc.module.marry
{
   import com.road.yishi.proto.marriage.MarriageOpMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class MarrySender
   {
      
      public function MarrySender()
      {
         super();
      }
      
      public static function opMarryHeartTimerComplete(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8802);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 3004;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function opMarryHeartAnswer(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8802);
         var _loc3_:MarriageOpMsg = new MarriageOpMsg();
         _loc3_.opType = 3003;
         _loc3_.property1 = param1;
         _loc3_.property2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function opMarryHeartOp(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8802);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function opMarryTree(param1:int, param2:int = -1, param3:int = -1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8773);
         var _loc4_:MarriageOpMsg = new MarriageOpMsg();
         _loc4_.opType = param1;
         _loc4_.payType = param2;
         _loc4_.property1 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function opMarryTask(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8774);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function useTaskGoods(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8774);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 2004;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function weddingDialogConfirm(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8760);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function handGift(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8760);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 104;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function handPoint(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8760);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 112;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function changeRoomPassWord(param1:String = "") : void
      {
         var _loc3_:PackageOut = new PackageOut(8760);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 105;
         _loc2_.property3 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function kickOutGuest(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8760);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 106;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function invite(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8760);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 110;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function oneKeyInvite(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(8760);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 111;
         _loc2_.userIds = param1.concat();
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function proposeQuest(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8759);
         var _loc3_:MarriageOpMsg = new MarriageOpMsg();
         _loc3_.opType = 1;
         _loc3_.property1 = param1;
         _loc3_.property3 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function cancleEngaged(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8759);
         var _loc3_:MarriageOpMsg = new MarriageOpMsg();
         _loc3_.opType = param1;
         _loc3_.payType = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function proposeAnswer(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8759);
         var _loc3_:MarriageOpMsg = new MarriageOpMsg();
         _loc3_.property1 = param1;
         _loc3_.opType = 3;
         _loc3_.property5 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function buyQuality(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(15049);
         var _loc4_:MarriageOpMsg = new MarriageOpMsg();
         _loc4_.opType = 4;
         _loc4_.property1 = param1;
         _loc4_.property2 = param2;
         _loc4_.payType = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function qualityAnswer(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(8759);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 5;
         _loc2_.property5 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function creatWeddingRoom() : void
      {
         var _loc2_:PackageOut = new PackageOut(8759);
         var _loc1_:MarriageOpMsg = new MarriageOpMsg();
         _loc1_.opType = 6;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function rideHorse() : void
      {
         var _loc2_:PackageOut = new PackageOut(8759);
         var _loc1_:MarriageOpMsg = new MarriageOpMsg();
         _loc1_.opType = 7;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function divorce(param1:int, param2:String = "", param3:Boolean = false) : void
      {
         var _loc5_:PackageOut = new PackageOut(8759);
         var _loc4_:MarriageOpMsg = new MarriageOpMsg();
         _loc4_.opType = 8;
         _loc4_.payType = param1;
         _loc4_.property3 = param2;
         _loc4_.property5 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function proposeInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8759);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.property1 = param1;
         _loc2_.opType = 9;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function resquestRoomInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(8759);
         var _loc1_:MarriageOpMsg = new MarriageOpMsg();
         _loc1_.opType = 10;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function riseSatisfactory(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8759);
         var _loc3_:MarriageOpMsg = new MarriageOpMsg();
         _loc3_.opType = 11;
         _loc3_.property1 = param1;
         _loc3_.property2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function upgradeRing(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8759);
         var _loc3_:MarriageOpMsg = new MarriageOpMsg();
         _loc3_.opType = 12;
         _loc3_.payType = param1;
         _loc3_.property1 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function skillUse(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8759);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 19;
         _loc2_.property3 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function enterWeddingRoom(param1:String, param2:String = "", param3:Boolean = false) : void
      {
         var _loc5_:PackageOut = new PackageOut(8759);
         var _loc4_:MarriageOpMsg = new MarriageOpMsg();
         _loc4_.opType = 13;
         _loc4_.property3 = param1;
         _loc4_.property4 = param2;
         _loc4_.property5 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function confirmDivorce(param1:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(8759);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 14;
         _loc2_.property5 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function freeDivorce(param1:String = "") : void
      {
         var _loc3_:PackageOut = new PackageOut(8759);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 15;
         _loc2_.property3 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function consultDivorce(param1:int = -1) : void
      {
         var _loc3_:PackageOut = new PackageOut(8759);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 16;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function agreeDivorce(param1:int = -1, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(8759);
         var _loc3_:MarriageOpMsg = new MarriageOpMsg();
         _loc3_.opType = 17;
         _loc3_.property1 = param1;
         _loc3_.property5 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function helpMateTrain(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(8759);
         var _loc2_:MarriageOpMsg = new MarriageOpMsg();
         _loc2_.opType = 18;
         _loc2_.payType = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function findMates() : void
      {
         var _loc2_:PackageOut = new PackageOut(8759);
         var _loc1_:MarriageOpMsg = new MarriageOpMsg();
         _loc1_.opType = 20;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
   }
}

