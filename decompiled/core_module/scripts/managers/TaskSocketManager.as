package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.player.CheckSend;
   import com.road.yishi.proto.quest.QuestAddedMsg;
   import com.road.yishi.proto.quest.QuestFinishedReqMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class TaskSocketManager
   {
      
      public function TaskSocketManager()
      {
         super();
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function sendGetTaskReward(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc5_:PackageOut = new PackageOut(5014);
         var _loc4_:QuestFinishedReqMsg = new QuestFinishedReqMsg();
         _loc4_.templateId = param1;
         _loc4_.rewardItemId = param2;
         _loc4_.isPass = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendRequestTask(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageOut = new PackageOut(5012);
         var _loc2_:QuestAddedMsg = new QuestAddedMsg();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.questId.push(param1[_loc3_]);
            _loc3_++;
         }
         sendProtoBuffer(_loc4_,_loc2_);
      }
      
      public static function sendCheckMobileNumber() : void
      {
         var _loc2_:PackageOut = new PackageOut(8524);
         var _loc1_:CheckSend = new CheckSend();
         sendProtoBuffer(_loc2_,_loc1_);
      }
   }
}

