package yishi.manager
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossListMsg;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossRankListMsg;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossRecordListMsg;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossUserMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import mvc.module.forbiddenboss.ForbiddenBossModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class ForbiddenBossManager
   {
      
      private static var _instance:ForbiddenBossManager;
      
      private var _model:ForbiddenBossModel;
      
      private var OP_OPEN:int = 1;
      
      private var OP_ENTER:int = 2;
      
      private var OP_REWARD:int = 3;
      
      private var OP_RECORD:int = 4;
      
      public function ForbiddenBossManager()
      {
         super();
      }
      
      public static function get instance() : ForbiddenBossManager
      {
         if(!_instance)
         {
            _instance = new ForbiddenBossManager();
         }
         return _instance;
      }
      
      public function get model() : ForbiddenBossModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new ForbiddenBossModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4293,__forbiddenBossUserHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4294,__forbiddenBossListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4295,__forbiddenBossRankHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4296,__forbiddenBossRecordHandler);
      }
      
      private function __forbiddenBossUserHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ForbiddenBossUserMsg = new ForbiddenBossUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ForbiddenBossUserMsg;
         model.belongReward = _loc2_.belongReward;
         model.joinReward = _loc2_.joinReward;
         model.firstReward = _loc2_.firstReward;
         model.needverify = _loc2_.needVerify;
         model.ConsortiaName = _loc2_.consortiaName;
         MsgMan.notifyObserver("FORBIDDEN_BOSS_USER_UPDATE");
      }
      
      private function __forbiddenBossListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ForbiddenBossListMsg = new ForbiddenBossListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ForbiddenBossListMsg;
         model.bossList = _loc2_.bossList;
         if(_loc2_.bossId != 0)
         {
            model.SelectBoss = _loc2_.bossId;
         }
         MsgMan.notifyObserver("FORBIDDEN_BOSS_LIST_UPDATE");
      }
      
      private function __forbiddenBossRankHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ForbiddenBossRankListMsg = new ForbiddenBossRankListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ForbiddenBossRankListMsg;
         model.rankList = _loc2_.rankList;
         if(_loc2_.hasMaxHp)
         {
            model.maxHp = Int64Utils.int64ToNumber(_loc2_.maxHp);
         }
         MsgMan.notifyObserver("FORBIDDEN_BOSS_RANK_UPDATE");
      }
      
      private function __forbiddenBossRecordHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ForbiddenBossRecordListMsg = new ForbiddenBossRecordListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ForbiddenBossRecordListMsg;
         var _loc3_:Array = _loc2_.recordList;
         _loc3_.sortOn("id",16);
         model.recordArr = _loc3_;
         MsgMan.notifyObserver("FORBIDDEN_BOSS_RECORD_UPDATE");
      }
      
      public function sendOpen() : void
      {
         var _loc2_:PackageOut = new PackageOut(8675);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = OP_OPEN;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendEnter(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8675);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = OP_ENTER;
         _loc2_.id = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendReward(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8675);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = OP_REWARD;
         _loc2_.id = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendRecord() : void
      {
         var _loc2_:PackageOut = new PackageOut(8675);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = OP_RECORD;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
   }
}

