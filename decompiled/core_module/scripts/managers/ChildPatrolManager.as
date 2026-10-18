package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.childpatrol.ChildPatrolFriendStateListMsg;
   import com.road.yishi.proto.childpatrol.ChildPatrolFriendStateMsg;
   import com.road.yishi.proto.childpatrol.ChildPatrolFriendStateRequestMsg;
   import com.road.yishi.proto.childpatrol.ChildPatrolMsg;
   import com.road.yishi.proto.childpatrol.ChildPatrolQuickMsg;
   import com.road.yishi.proto.childpatrol.ChildPatrolRequestMsg;
   import com.road.yishi.proto.childpatrol.ChildPatrolTowerMsg;
   import events.ChildPatrolEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import mvc.module.childpatrol.ChildPatrolFriendStateInfo;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import tasktracetip.data.TipMessageData;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class ChildPatrolManager extends EventDispatcher
   {
      
      private static var _instance:ChildPatrolManager;
      
      private var _model:ChildPatrolModel;
      
      private var _needTipNext:Boolean = true;
      
      public function ChildPatrolManager()
      {
         super();
      }
      
      public static function get instance() : ChildPatrolManager
      {
         if(!_instance)
         {
            _instance = new ChildPatrolManager();
         }
         return _instance;
      }
      
      public function get model() : ChildPatrolModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new ChildPatrolModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 304,__updateChildPatrolQueue);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 302,__updateChildPatrolFriendStateList);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 303,__updateChildPatrolHandler);
      }
      
      private function __updateChildPatrolHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ChildPatrolTowerInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildPatrolMsg = new ChildPatrolMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ChildPatrolMsg;
         if(_loc2_.op == 1)
         {
            model.headQuartersInfo = new ChildPatrolTowerInfo();
            model.towerInfoList = [];
            model.curUserId = _loc2_.userid;
         }
         else if(model.curUserId != _loc2_.userid)
         {
            return;
         }
         model.freeCount = _loc2_.freeCount;
         if(_loc2_.hasHeadquarters)
         {
            model.headQuartersInfo.towerId = _loc2_.headquarters.towerId;
            model.headQuartersInfo.onGarrison = _loc2_.headquarters.onGarrison;
            model.headQuartersInfo.state = _loc2_.headquarters.state;
            model.headQuartersInfo.level = _loc2_.headquarters.level;
            model.headQuartersInfo.garrisonExpPerMinute = _loc2_.headquarters.garrisonExpPerMinute;
            model.headQuartersInfo.curExp = _loc2_.headquarters.exp;
            model.headQuartersInfo.garrisonChildIdList = _loc2_.headquarters.garrisonChildIdList;
            if(_loc2_.headquarters.garrisonStartTime)
            {
               model.headQuartersInfo.garrisonStartTime = Math.ceil(Int64Utils.int64ToNumber(_loc2_.headquarters.garrisonStartTime) / 1000);
            }
            if(_loc2_.headquarters.garrisonEndTime)
            {
               model.headQuartersInfo.garrisonEndTime = Math.ceil(Int64Utils.int64ToNumber(_loc2_.headquarters.garrisonEndTime) / 1000);
            }
            if(_loc2_.headquarters.hasGarrisonCountDown)
            {
               model.headQuartersInfo.garrisonLeftTime = Math.ceil(Int64Utils.int64ToNumber(_loc2_.headquarters.garrisonCountDown) / 1000);
            }
            sendDispatchEvent("UPDATE_HEADQUARTERS_CHILDPATROL",model.headQuartersInfo);
         }
         if(_loc2_.towerList && _loc2_.towerList.length > 0)
         {
            for each(var _loc3_:ChildPatrolTowerMsg in _loc2_.towerList)
            {
               _loc4_ = model.getChildPatrolTowerInfoByTowerId(_loc3_.towerId);
               if(!_loc4_)
               {
                  _loc4_ = new ChildPatrolTowerInfo();
                  model.towerInfoList.push(_loc4_);
               }
               _loc4_.towerId = _loc3_.towerId;
               if(_loc2_.op == 12)
               {
                  _loc4_.bossId = _loc3_.bossId;
                  _loc4_.bossState = _loc3_.bossStats;
               }
               else
               {
                  _loc4_.onGarrison = _loc3_.onGarrison;
                  _loc4_.state = _loc3_.state;
                  _loc4_.level = _loc3_.level;
                  _loc4_.curExp = _loc3_.exp;
                  _loc4_.garrisonExpPerMinute = _loc3_.garrisonExpPerMinute;
                  _loc4_.garrisonChildIdList = _loc3_.garrisonChildIdList;
                  _loc4_.patrolChildIdList = _loc3_.patrolChildIdList;
                  if(_loc3_.hasGarrisonStartTime)
                  {
                     _loc4_.garrisonStartTime = Math.ceil(Int64Utils.int64ToNumber(_loc3_.garrisonStartTime) / 1000);
                  }
                  if(_loc3_.hasGarrisonEndTime)
                  {
                     _loc4_.garrisonEndTime = Math.ceil(Int64Utils.int64ToNumber(_loc3_.garrisonEndTime) / 1000);
                  }
                  if(_loc3_.hasPatrolStartTime)
                  {
                     _loc4_.patrolStartTime = Math.ceil(Int64Utils.int64ToNumber(_loc3_.patrolStartTime) / 1000);
                  }
                  if(_loc3_.hasPatrolEndTime)
                  {
                     _loc4_.patrolEndTime = Math.ceil(Int64Utils.int64ToNumber(_loc3_.patrolEndTime) / 1000);
                  }
                  if(_loc3_.hasGarrisonCountDown)
                  {
                     _loc4_.garrisonLeftTime = Math.ceil(Int64Utils.int64ToNumber(_loc3_.garrisonCountDown) / 1000);
                  }
                  if(_loc3_.hasPatrolCountDown)
                  {
                     _loc4_.patrolLeftTime = Math.ceil(Int64Utils.int64ToNumber(_loc3_.patrolCountDown) / 1000);
                  }
                  _loc4_.normalMissionId = _loc3_.normalMissionId;
                  _loc4_.normalMissionReached = _loc3_.normalMissionReached;
                  _loc4_.hardMissionId = _loc3_.hardMissionId;
                  _loc4_.hardMissionReached = _loc3_.hardMissionReached;
                  _loc4_.nightmareMissionId = _loc3_.nightmareMissionId;
                  _loc4_.nightmareMissionReached = _loc3_.nightmareMissionReached;
                  _loc4_.exploreChildId = _loc3_.exploreChildId;
                  if(_loc3_.hasExploreCountDown)
                  {
                     _loc4_.exploreLeftTime = Math.ceil(Int64Utils.int64ToNumber(_loc3_.exploreCountDown) / 1000);
                  }
                  _loc4_.bossId = _loc3_.bossId;
                  _loc4_.bossState = _loc3_.bossStats;
               }
            }
            model.towerInfoList.sortOn("towerId",16);
            sendDispatchEvent("UPDATE_TOWERINFO_CHILDPATROL",model.towerInfoList);
         }
         if(_loc2_.op == 7 && model.curUserId == thane.userId)
         {
            model.isAlertReward = false;
            for each(var _loc6_:ChildPatrolTowerInfo in model.towerInfoList)
            {
               if(_loc6_.state == 3)
               {
                  model.isAlertReward = true;
                  break;
               }
            }
         }
      }
      
      private function __updateChildPatrolFriendStateList(param1:SLGSocketEvent) : void
      {
         var _loc4_:ChildPatrolFriendStateInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildPatrolFriendStateListMsg = new ChildPatrolFriendStateListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ChildPatrolFriendStateListMsg;
         for each(var _loc3_:ChildPatrolFriendStateMsg in _loc2_.friendState)
         {
            _loc4_ = model.getChildPatrolFriendStateInfoByUserId(_loc3_.userid);
            if(!_loc4_)
            {
               _loc4_ = new ChildPatrolFriendStateInfo();
               model.friendsStateList.push(_loc4_);
            }
            _loc4_.userId = _loc3_.userid;
            _loc4_.state = _loc3_.state;
         }
         sendDispatchEvent("UPDATE_FRIENDS_STATE_CHILDPATROL");
      }
      
      private function __updateChildPatrolQueue(param1:SLGSocketEvent) : void
      {
         var _loc3_:TipMessageData = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildPatrolQuickMsg = new ChildPatrolQuickMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ChildPatrolQuickMsg;
         model.idleTowerCount = _loc2_.idleCount;
         model.totalTowerCount = _loc2_.totalCount;
         model.isAlertReward = _loc2_.reward;
         model.refreshTime = 1800;
         if(inCastle() || inSpace())
         {
            if(model.isAlertReward)
            {
               if(_needTipNext)
               {
                  _loc3_ = new TipMessageData();
                  _loc3_.title = LanguageMgr.GetTranslation("public.prompt");
                  _loc3_.type = 1002;
                  _loc3_.content = LanguageMgr.GetTranslation("tasktracetip.view.ChildPatrolTaskTipView.Content");
                  TaskTraceTipManager.instance.showView(_loc3_);
                  _needTipNext = false;
               }
            }
            else
            {
               _needTipNext = true;
            }
         }
         sendDispatchEvent("UPDATE_QUEUE_CHILDPATROL_TOWER");
      }
      
      public function showChildPatrolTaskAlertTip() : void
      {
         var _loc1_:TipMessageData = null;
         if(model.isAlertReward)
         {
            _loc1_ = new TipMessageData();
            _loc1_.title = LanguageMgr.GetTranslation("public.prompt");
            _loc1_.type = 1002;
            _loc1_.content = LanguageMgr.GetTranslation("tasktracetip.view.ChildPatrolTaskTipView.Content");
            TaskTraceTipManager.instance.showView(_loc1_);
            _needTipNext = false;
         }
      }
      
      private function inCastle() : Boolean
      {
         return SceneManager.instance.currentType == "CASTLE_SCENE";
      }
      
      private function inSpace() : Boolean
      {
         return SceneManager.instance.currentType == "SPACE_SCENE";
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function sendDispatchEvent(param1:String, param2:Object = null) : void
      {
         this.dispatchEvent(new ChildPatrolEvent(param1,param2));
      }
      
      public function sendChildPatrolOperate(param1:int, param2:int = 0, param3:int = 2, param4:int = 0, param5:Array = null) : void
      {
         var _loc7_:PackageOut = new PackageOut(9578);
         var _loc6_:ChildPatrolRequestMsg = new ChildPatrolRequestMsg();
         _loc6_.op = param1;
         _loc6_.userid = param2;
         _loc6_.payType = param3;
         _loc6_.towerId = param4;
         if(param5 != null)
         {
            _loc6_.childIdList = param5;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc7_,_loc6_);
      }
      
      public function reqFriendFarmState(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(9579);
         var _loc2_:ChildPatrolFriendStateRequestMsg = new ChildPatrolFriendStateRequestMsg();
         if(param1.length <= 0)
         {
            return;
         }
         _loc2_.friendUseridList = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

