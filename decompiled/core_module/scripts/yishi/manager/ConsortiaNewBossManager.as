package yishi.manager
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.consortia.ConsortiaNewBossMsg;
   import com.road.yishi.proto.consortia.ConsortiaNewBossRankListMsg;
   import com.road.yishi.proto.consortia.ConsortiaNewBossRankMsg;
   import com.road.yishi.proto.consortia.ConsortiaNewBossUserMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mvc.module.consortia.ConsortiaNewBossModel;
   import mvc.module.consortia.ConsortiaNewBossRankInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   
   public class ConsortiaNewBossManager extends EventDispatcher
   {
      
      private static var _instance:ConsortiaNewBossManager;
      
      public static var OPEN_FRAME:int = 1;
      
      public static var CLOSE_FRAME:int = 2;
      
      public static var CALL_BOSS:int = 3;
      
      public static var FIGHT_BOSS:int = 4;
      
      public static var BUY_BUFFER:int = 5;
      
      private var _model:ConsortiaNewBossModel;
      
      public function ConsortiaNewBossManager()
      {
         super();
         _model = new ConsortiaNewBossModel();
      }
      
      public static function get instance() : ConsortiaNewBossManager
      {
         if(!_instance)
         {
            _instance = new ConsortiaNewBossManager();
         }
         return _instance;
      }
      
      public function get model() : ConsortiaNewBossModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4283,__bossInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4284,__rankInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4286,__userInfo);
      }
      
      private function __bossInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaNewBossMsg = new ConsortiaNewBossMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaNewBossMsg;
         if(_loc2_)
         {
            _model.bossId = _loc2_.bossId;
            _model.passLevel = _loc2_.passLevel;
            _model.maxLevel = _loc2_.maxLevel;
            _model.callLevel = _loc2_.callLevel;
            _model.hasCallCount = _loc2_.callCount;
            _model.maxCallCount = _loc2_.callMaxCount;
            _model.bufferId = _loc2_.buff;
            _model.bufferBuyCount = _loc2_.buffBuyCount;
            _model.bufferStartTime = DateFormatter.parse(_loc2_.buffStartTime,"YYYY-MM-DD hh:mm:ss");
            _model.bufferStopTime = DateFormatter.parse(_loc2_.buffStopTime,"YYYY-MM-DD hh:mm:ss");
            _model.startTime = DateFormatter.parse(_loc2_.startTime,"YYYY-MM-DD hh:mm:ss");
            _model.stopTime = DateFormatter.parse(_loc2_.stopTime,"YYYY-MM-DD hh:mm:ss");
            _model.bestCount = _loc2_.bestCount;
            _model.hp = Int64Utils.int64ToNumber(_loc2_.hp);
            _model.maxHp = Int64Utils.int64ToNumber(_loc2_.maxHp);
            NotificationManager.instance.dispatchEvent(new Event("CONSORTIA_NEW_BOSS_INFO_UPDATE"));
         }
      }
      
      private function __rankInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaNewBossRankListMsg = new ConsortiaNewBossRankListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaNewBossRankListMsg;
         if(_loc2_)
         {
            _model.rankArray = [];
            _loc3_ = 0;
            while(_loc3_ < _loc2_.ranks.length)
            {
               _model.rankArray.push(readRankInfo(_loc2_.ranks[_loc3_]));
               _model.rankArray.sortOn("rank",16);
               _loc3_++;
            }
            NotificationManager.instance.dispatchEvent(new Event("CONSORTIA_NEW_BOSS_RANK_UPDATE"));
         }
      }
      
      private function readRankInfo(param1:ConsortiaNewBossRankMsg) : ConsortiaNewBossRankInfo
      {
         var _loc2_:ConsortiaNewBossRankInfo = new ConsortiaNewBossRankInfo();
         _loc2_.rank = param1.rank;
         _loc2_.nickName = param1.nickName;
         _loc2_.damage = Int64Utils.int64ToNumber(param1.damage);
         return _loc2_;
      }
      
      private function __userInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaNewBossUserMsg = new ConsortiaNewBossUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaNewBossUserMsg;
         if(_loc2_)
         {
            _model.fightCount = _loc2_.fightCount;
            _model.maxFightCount = _loc2_.fightMaxCount;
            _model.myRank = _loc2_.rank;
            _model.myDamage = Int64Utils.int64ToNumber(_loc2_.damage);
            NotificationManager.instance.dispatchEvent(new Event("CONSORTIA_NEW_BOSS_USERINFO_UPDATE"));
         }
      }
      
      public function openFrame() : void
      {
         var _loc2_:PackageOut = new PackageOut(8670);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = OPEN_FRAME;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function closeFrame() : void
      {
         var _loc2_:PackageOut = new PackageOut(8670);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = CLOSE_FRAME;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function callBOSS(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8670);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.id = param1;
         _loc2_.op = CALL_BOSS;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function fightBOSS() : void
      {
         var _loc2_:PackageOut = new PackageOut(8670);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = FIGHT_BOSS;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function buyBuffer(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8670);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.id = param1;
         _loc2_.op = BUY_BUFFER;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
   }
}

