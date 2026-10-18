package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.mail.MailDelReqMsg;
   import com.road.yishi.proto.mail.MailMsg;
   import com.road.yishi.proto.mail.MailSendReqMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class EmailSocketOutManager
   {
      
      public function EmailSocketOutManager()
      {
         super();
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function getAttached(param1:Array, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:PackageOut = new PackageOut(5022);
         var _loc3_:MailMsg = new MailMsg();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.mailsIdArray.push(param1[_loc4_]);
            _loc3_.position.push(param2);
            _loc4_++;
         }
         sendProtoBuffer(_loc5_,_loc3_);
      }
      
      public static function deleteMail(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(8206);
         var _loc2_:MailDelReqMsg = new MailDelReqMsg();
         _loc2_.delList = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendEmail(param1:Array, param2:String, param3:String, param4:int, param5:Boolean = true) : void
      {
         var _loc7_:PackageOut = new PackageOut(8205);
         var _loc6_:MailSendReqMsg = new MailSendReqMsg();
         _loc6_.receiverUserId = param1;
         _loc6_.title = param2;
         _loc6_.contents = param3;
         _loc6_.sendType = param4;
         _loc6_.payType = 0;
         if(!param5)
         {
            _loc6_.payType = 1;
         }
         sendProtoBuffer(_loc7_,_loc6_);
      }
   }
}

