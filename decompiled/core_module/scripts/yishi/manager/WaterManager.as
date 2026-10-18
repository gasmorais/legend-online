package yishi.manager
{
   import com.road.yishi.proto.farm.FarmLogRsp;
   import com.road.yishi.proto.farm.FriendTreeReq;
   import com.road.yishi.proto.farm.FriendTreeRsp;
   import com.road.yishi.proto.farm.TreeInfoMsg;
   import com.road.yishi.proto.farm.TreeUpdateRsp;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FriendFarmStateInfo;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import water.data.WaterLogInfo;
   import water.data.WaterTreeModel;
   import water.events.WaterEvent;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.playerinfo.TreeInfo;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   
   public class WaterManager extends EventDispatcher
   {
      
      private static var _instance:WaterManager;
      
      private var _model:WaterTreeModel;
      
      private var _logList:Array;
      
      public var treeList:Dictionary;
      
      public function WaterManager()
      {
         super();
      }
      
      public static function get instance() : WaterManager
      {
         if(!_instance)
         {
            _instance = new WaterManager();
         }
         return _instance;
      }
      
      public function get model() : WaterTreeModel
      {
         return _model;
      }
      
      public function get logList() : Array
      {
         return _logList;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new WaterTreeModel();
         }
         treeList = new Dictionary();
         _logList = [];
         initEvent();
      }
      
      public function setupList(param1:Array) : void
      {
         if(param1)
         {
            _logList = param1;
         }
         _logList.sortOn("time",2);
      }
      
      public function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4146,__getTreeInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 145,__logUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 147,__treeInfoUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4158,__waterStateHandler);
         thane.addEventListener("THANE_LEVEL_UPDATE",__levelUpgradeHandler);
      }
      
      private function __levelUpgradeHandler(param1:PlayerEvent) : void
      {
         if(thane.preGrade < 11 && thane.grades >= 11)
         {
            sendGetTreeInfoById(thane.userId);
         }
      }
      
      private function __getTreeInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TreeInfo = null;
         var _loc3_:ThaneInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendTreeRsp = new FriendTreeRsp();
         _loc2_ = _loc5_.readBody(_loc2_) as FriendTreeRsp;
         if(_loc2_.treeInfo.length > 0)
         {
            for each(var _loc4_:TreeInfoMsg in _loc2_.treeInfo)
            {
               _loc6_ = treeList[_loc4_.userId];
               if(!_loc6_)
               {
                  _loc6_ = new TreeInfo();
                  treeList[_loc4_.userId] = _loc6_;
               }
               _loc6_.userId = _loc4_.userId;
               _loc6_.nickName = _loc4_.nickName;
               _loc6_.waterCount = _loc4_.waterCount;
               _loc6_.fruitCount = _loc4_.fruitCount;
               _loc6_.isFirstFruit = _loc4_.isFirstFruit;
               _loc6_.nextPickTime = DateFormatter.parse(_loc4_.nextPickTime,"YYYY-MM-DD hh:mm:ss");
               _loc6_.lastWaterTime = DateFormatter.parse(_loc4_.lastWaterTime,"YYYY-MM-DD hh:mm:ss");
               _loc6_.property1 = _loc4_.property1;
               _loc6_.property2 = _loc4_.property2;
               _loc6_.notHasTree = false;
               if(StringHelper.isNullOrEmpty(_loc6_.nickName))
               {
                  _loc3_ = FriendManager.getInstance().getFriendById(_loc6_.userId);
                  if(_loc3_)
                  {
                     _loc6_.nickName = _loc3_.nickName;
                  }
                  else
                  {
                     _loc6_.nickName = "";
                  }
               }
               if(_loc6_.userId == thane.userId)
               {
                  _loc6_.timeLeft = _loc4_.leftTime;
                  _loc6_.leftpickTime = _loc4_.leftPickTime;
                  dispatchEvent(new WaterEvent(WaterEvent.CREATE_TREE,null));
               }
               dispatchEvent(new WaterEvent("TREE_UPDATE",_loc6_));
            }
         }
      }
      
      private function __logUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FarmLogRsp = new FarmLogRsp();
         _loc2_ = _loc3_.readBody(_loc2_) as FarmLogRsp;
         var _loc4_:WaterLogInfo = new WaterLogInfo();
         _loc4_.type = _loc2_.type;
         _loc4_.userId = _loc2_.playerId;
         _loc4_.waterUserId = _loc2_.operUserId;
         _loc4_.nickName = _loc2_.operNickName;
         _loc4_.actionDes = _loc2_.desc;
         _loc4_.time = DateFormatter.parse(_loc2_.operDate,"YYYY-MM-DD hh:mm:ss");
         addLog(_loc4_);
      }
      
      private function __treeInfoUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:TreeInfoMsg = null;
         var _loc6_:TreeInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TreeUpdateRsp = new TreeUpdateRsp();
         _loc2_ = _loc5_.readBody(_loc2_) as TreeUpdateRsp;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.tree.length)
         {
            _loc3_ = _loc2_.tree[_loc4_] as TreeInfoMsg;
            _loc6_ = treeList[_loc3_.userId] as TreeInfo;
            if(!_loc6_)
            {
               _loc6_ = new TreeInfo();
               treeList[_loc3_.userId] = _loc6_;
            }
            _loc6_.userId = _loc3_.userId;
            _loc6_.nickName = _loc3_.nickName;
            _loc6_.waterCount = _loc3_.waterCount;
            _loc6_.fruitCount = _loc3_.fruitCount;
            _loc6_.isFirstFruit = _loc3_.isFirstFruit;
            _loc6_.nextPickTime = DateFormatter.parse(_loc3_.nextPickTime,"YYYY-MM-DD hh:mm:ss");
            _loc6_.lastWaterTime = DateFormatter.parse(_loc3_.lastWaterTime,"YYYY-MM-DD hh:mm:ss");
            _loc6_.property1 = _loc3_.property1;
            _loc6_.property2 = _loc3_.property2;
            if(_loc6_.userId == thane.userId)
            {
               _loc6_.timeLeft = _loc3_.leftTime;
               _loc6_.leftpickTime = _loc3_.leftPickTime;
            }
            dispatchEvent(new WaterEvent("TREE_UPDATE",_loc6_));
            _loc4_++;
         }
      }
      
      private function __waterStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:FriendFarmStateInfo = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FarmLogRsp = new FarmLogRsp();
         _loc2_ = _loc3_.readBody(_loc2_) as FarmLogRsp;
         var _loc4_:int = _loc2_.playerId;
         var _loc6_:int = _loc2_.operUserId;
         if(_loc4_ == thane.userId)
         {
            _loc5_ = farmModel.getFarmStateInfo(_loc6_);
            _loc5_.beginChanges();
            _loc5_.canGivePower = false;
            _loc5_.commitChanges();
            dispatchEvent(new WaterEvent("UPDATA_WATER_STATE",_loc6_));
         }
      }
      
      public function addLog(param1:WaterLogInfo) : void
      {
         _logList.push(param1);
         _logList.sortOn("time",2);
         dispatchEvent(new WaterEvent("WATER_LOG_UPDATE",null));
      }
      
      public function sendGetTreeInfoById(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8219);
         var _loc2_:FriendTreeReq = new FriendTreeReq();
         _loc2_.friendId = [param1];
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function isWatered(param1:int) : Boolean
      {
         return farmModel.getFarmStateInfo(param1).canGivePower;
      }
      
      private function get farmModel() : FarmModel
      {
         return FarmManager.instance.model;
      }
   }
}

