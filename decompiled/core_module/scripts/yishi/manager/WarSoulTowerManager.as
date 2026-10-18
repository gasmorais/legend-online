package yishi.manager
{
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.warsoultower.ResultRspMsg;
   import com.road.yishi.proto.warsoultower.WarSoulTowerRspMsg;
   import mvc.module.warsoultower.WarSoulTowerModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class WarSoulTowerManager
   {
      
      private static var _instance:WarSoulTowerManager;
      
      private var _model:WarSoulTowerModel;
      
      private var OP_OPEN:int = 0;
      
      private var OP_BATTLE:int = 1;
      
      public function WarSoulTowerManager()
      {
         super();
      }
      
      public static function get instance() : WarSoulTowerManager
      {
         if(!_instance)
         {
            _instance = new WarSoulTowerManager();
         }
         return _instance;
      }
      
      public function get model() : WarSoulTowerModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new WarSoulTowerModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 530,__warSoulTowerHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 531,__warSoulTowerResultHandler);
      }
      
      private function __warSoulTowerHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:WarSoulTowerRspMsg = new WarSoulTowerRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as WarSoulTowerRspMsg;
         model.currentLevel = _loc2_.currentLevel;
         model.highestLevel = _loc2_.highestLevel;
         model.challengeTimes = _loc2_.challengeTimes;
         MsgMan.notifyObserver("WARSOULTOWER_UPDATE");
      }
      
      private function __warSoulTowerResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ResultRspMsg = new ResultRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ResultRspMsg;
         model.isNewRecord = _loc2_.isNewRecord;
         model.highestUnLockLevel = _loc2_.highestUnLockLevel;
         model.startLevel = _loc2_.startLevel;
         model.overLevel = _loc2_.endLevel;
         model.rewards = _loc2_.rewards;
      }
      
      public function sendOpen() : void
      {
         var _loc2_:PackageOut = new PackageOut(9709);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = OP_OPEN;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendBattle() : void
      {
         var _loc2_:PackageOut = new PackageOut(9709);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = OP_BATTLE;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
   }
}

