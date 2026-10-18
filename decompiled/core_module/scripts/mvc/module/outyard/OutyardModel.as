package mvc.module.outyard
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.hugehead.HugeHeadBattleFieldMsg;
   import com.road.yishi.proto.hugehead.HugeHeadForceMsg;
   import com.road.yishi.proto.hugehead.HugeHeadMapNodeMsg;
   import com.road.yishi.proto.hugehead.HugeHeadMySignInStateMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleAreaMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleFieldMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleUserMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import flash.utils.Dictionary;
   import map.campaign.data.OutyardForceInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardModel
   {
      
      public static const OPEN_FRAME:int = 1;
      
      public static const HEART:int = 2;
      
      public static const CLOSE_FRAME:int = 3;
      
      public static const DECLARE:int = 4;
      
      public static const ADD_BATTLE:int = 5;
      
      public static const CHANGE_NOTICE:int = 6;
      
      public static const GET_REWARD:int = 7;
      
      public static const COLLECT_CRYSTAL:int = 8;
      
      public static const SIGNUP:int = 11;
      
      public static const UPDATE_NODES:int = 12;
      
      public static const NB_OP_OPEN:int = 1;
      
      public static const NB_OP_HEART_BEAT:int = 2;
      
      public static const NB_OP_CLOSE:int = 3;
      
      public static const NB_OP_WARP:int = 4;
      
      public static const NB_OP_ATTACK:int = 5;
      
      public static const NB_OP_DEFENCE:int = 6;
      
      public static const NB_OP_UPDATE:int = 7;
      
      public static const NB_OP_BATTLE_START:int = 8;
      
      public static const NB_OP_BATTLE_END:int = 9;
      
      public static const EVENT_CRYSTAL:int = 1;
      
      public static const EVENT_BATTLE:int = 2;
      
      public static const EVENT_EXPLORE:int = 3;
      
      public static const EVENT_CRYSTAL_ROUTINE:int = 4;
      
      public static const EVENT_BATTLE_ROUTINE:int = 5;
      
      public static const EVENT_EXPLORE_ROUTINE:int = 6;
      
      public static const EVENT_TITAN_ROUTINE:int = 7;
      
      private var _stateMsg:HugeHeadStateMsg;
      
      private var _signInMsg:HugeHeadMySignInStateMsg;
      
      private var _battleNodeMsg:HugeHeadNodeBattleFieldMsg;
      
      private var _battleSelfMsg:HugeHeadNodeBattleUserMsg;
      
      private var _forceDic:Dictionary;
      
      private var _nodeDic:Dictionary;
      
      public var curPos:int;
      
      public var reward:String = "";
      
      public function OutyardModel()
      {
         super();
         _nodeDic = new Dictionary();
         _forceDic = new Dictionary();
      }
      
      public function stateInfoHandler(param1:HugeHeadStateMsg) : void
      {
         _stateMsg = param1;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_STATE_INFO"));
         NotificationManager.instance.sendNotification("SPACE_NPC_VISIBLE");
      }
      
      public function fullInfoHandler(param1:HugeHeadBattleFieldMsg) : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:OutyardForceInfo = null;
         var _loc3_:LandPoint = null;
         var _loc2_:HugeHeadForceMsg = null;
         var _loc4_:HugeHeadMapNodeMsg = null;
         var _loc6_:Array = param1.forceList;
         var _loc9_:Array = param1.nodeList;
         if(param1.op == 1)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               _loc2_ = _loc6_[_loc5_] as HugeHeadForceMsg;
               _loc8_ = new OutyardForceInfo();
               _loc8_.forceIndex = _loc2_.forceIndex;
               _loc8_.notice = _loc2_.notice;
               _loc8_.remainAttackCount = _loc2_.remainAttackCount;
               _forceDic[_loc8_.forceIndex] = _loc8_;
               _loc5_++;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc9_.length)
            {
               _loc4_ = _loc9_[_loc5_] as HugeHeadMapNodeMsg;
               _loc3_ = new LandPoint();
               _loc3_.id = _loc4_.nodeId;
               _loc3_.forceIndex = _loc4_.forceIndex;
               _loc3_.nodeState = _loc4_.nodeState;
               _loc3_.battleStartTime = Int64Utils.int64ToNumber(_loc4_.battleStartTime);
               _loc3_.battleEndTime = Int64Utils.int64ToNumber(_loc4_.battleEndTime);
               _loc3_.attackForce = _loc4_.attackForce;
               _loc3_.defenceForce = _loc4_.defenceForce;
               _loc3_.attackCount = _loc4_.attackCount;
               _loc3_.defenceCount = _loc4_.defenceCount;
               _nodeDic[_loc3_.id] = _loc3_;
               _loc5_++;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("GET_LAND_NODE"));
         }
         else if(param1.op == 12)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               _loc2_ = _loc6_[_loc5_] as HugeHeadForceMsg;
               _loc8_ = _forceDic[_loc2_.forceIndex];
               if(_loc8_)
               {
                  if(_loc2_.hasForceIndex)
                  {
                     _loc8_.forceIndex = _loc2_.forceIndex;
                  }
                  if(_loc2_.hasNotice)
                  {
                     _loc8_.notice = _loc2_.notice;
                  }
                  if(_loc2_.hasRemainAttackCount)
                  {
                     _loc8_.remainAttackCount = _loc2_.remainAttackCount;
                  }
               }
               _loc5_++;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc9_.length)
            {
               _loc4_ = _loc9_[_loc5_] as HugeHeadMapNodeMsg;
               _loc3_ = _nodeDic[_loc4_.nodeId];
               if(_loc3_)
               {
                  if(_loc4_.hasNodeId)
                  {
                     _loc3_.id = _loc4_.nodeId;
                  }
                  if(_loc4_.hasForceIndex)
                  {
                     _loc3_.forceIndex = _loc4_.forceIndex;
                  }
                  if(_loc4_.hasNodeState)
                  {
                     _loc3_.nodeState = _loc4_.nodeState;
                  }
                  if(_loc4_.hasBattleStartTime)
                  {
                     _loc3_.battleStartTime = Int64Utils.int64ToNumber(_loc4_.battleStartTime);
                  }
                  if(_loc4_.hasBattleEndTime)
                  {
                     _loc3_.battleEndTime = Int64Utils.int64ToNumber(_loc4_.battleEndTime);
                  }
                  if(_loc4_.hasAttackForce)
                  {
                     _loc3_.attackForce = _loc4_.attackForce;
                  }
                  if(_loc4_.hasDefenceForce)
                  {
                     _loc3_.defenceForce = _loc4_.defenceForce;
                  }
                  if(_loc4_.hasAttackCount)
                  {
                     _loc3_.attackCount = _loc4_.attackCount;
                  }
                  if(_loc4_.hasDefenceCount)
                  {
                     _loc3_.defenceCount = _loc4_.defenceCount;
                  }
               }
               _loc5_++;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("UPDATE_LAND_NODE"));
         }
      }
      
      public function mySignInHandler(param1:HugeHeadMySignInStateMsg) : void
      {
         _signInMsg = param1;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_SIGNIN"));
      }
      
      public function battleFieldHandler(param1:HugeHeadNodeBattleFieldMsg) : void
      {
         var _loc2_:HugeHeadNodeBattleAreaMsg = null;
         var _loc5_:HugeHeadNodeBattleAreaMsg = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.op == 1)
         {
            _battleNodeMsg = param1;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_ROUTE_VIEW"));
         }
         else
         {
            if(!_battleNodeMsg)
            {
               return;
            }
            if(param1.hasOp)
            {
               _battleNodeMsg.op = param1.op;
            }
            if(param1.hasBattleFieldUid)
            {
               _battleNodeMsg.battleFieldUid = param1.battleFieldUid;
            }
            if(param1.hasNodeId)
            {
               _battleNodeMsg.nodeId = param1.nodeId;
            }
            if(param1.hasAttackForce)
            {
               _battleNodeMsg.attackForce = param1.attackForce;
            }
            if(param1.hasAttackCount)
            {
               _battleNodeMsg.attackCount = param1.attackCount;
            }
            if(param1.hasAttackScore)
            {
               _battleNodeMsg.attackScore = param1.attackScore;
            }
            if(param1.hasDefenceForce)
            {
               _battleNodeMsg.defenceForce = param1.defenceForce;
            }
            if(param1.hasDefenceScore)
            {
               _battleNodeMsg.defenceScore = param1.defenceScore;
            }
            if(param1.hasDefenceCount)
            {
               _battleNodeMsg.defenceCount = param1.defenceCount;
            }
            if(param1.hasBattleStartTime)
            {
               _battleNodeMsg.battleStartTime = param1.battleStartTime;
            }
            if(param1.hasBattleEndTime)
            {
               _battleNodeMsg.battleEndTime = param1.battleEndTime;
            }
            if(param1.hasNodeState)
            {
               _battleNodeMsg.nodeState = param1.nodeState;
            }
            if(param1.areaList)
            {
               _loc3_ = 0;
               while(_loc3_ < param1.areaList.length)
               {
                  _loc2_ = param1.areaList[_loc3_];
                  _loc4_ = 0;
                  while(_loc4_ < _battleNodeMsg.areaList.length)
                  {
                     _loc5_ = _battleNodeMsg.areaList[_loc4_];
                     if(_loc5_.pos == _loc2_.pos)
                     {
                        _loc5_.belongForce = _loc2_.belongForce;
                        _loc5_.attackCount = _loc2_.attackCount;
                        _loc5_.defenceCount = _loc2_.defenceCount;
                     }
                     _loc4_++;
                  }
                  _loc3_++;
               }
            }
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("ROUTE_BATTLE_FIELD"));
      }
      
      public function battleUserHandler(param1:HugeHeadNodeBattleUserMsg) : void
      {
         if(param1.op == 1)
         {
            _battleSelfMsg = param1;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_ROUTE_VIEW"));
         }
         else if(param1.op == 3)
         {
            OutyardManager.instance.model.curPos = 0;
            if(!_battleSelfMsg)
            {
               return;
            }
            _battleSelfMsg.op = param1.op;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("OUTYARD_ROUTE_VIEW"));
         }
         else
         {
            if(!_battleSelfMsg)
            {
               return;
            }
            if(param1.hasOp)
            {
               _battleSelfMsg.op = param1.op;
            }
            if(param1.hasPos)
            {
               _battleSelfMsg.pos = param1.pos;
            }
            if(param1.hasCoolDown)
            {
               _battleSelfMsg.coolDown = param1.coolDown;
            }
            if(param1.hasSide)
            {
               _battleSelfMsg.side = param1.side;
            }
            if(param1.hasInGuard)
            {
               _battleSelfMsg.inGuard = param1.inGuard;
            }
            if(param1.hasUserUid)
            {
               _battleSelfMsg.userUid = param1.userUid;
            }
            if(param1.hasNodeBattleFieldUid)
            {
               _battleSelfMsg.nodeBattleFieldUid = param1.nodeBattleFieldUid;
            }
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("ROUTE_SELF_USER"));
      }
      
      public function get forceDic() : Dictionary
      {
         return _forceDic;
      }
      
      public function get nodeDic() : Dictionary
      {
         return _nodeDic;
      }
      
      public function get myForcePos() : int
      {
         return _signInMsg.forceIndex;
      }
      
      public function get myForce() : OutyardForceInfo
      {
         for each(var _loc1_:OutyardForceInfo in _forceDic)
         {
            if(_loc1_.forceIndex == myForcePos)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get occupyNum() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:LandPoint in _nodeDic)
         {
            if(_loc2_.forceIndex == myForcePos && _loc2_.nodeType != 3)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function get myRoute() : HugeHeadNodeBattleAreaMsg
      {
         if(!battleNodeMsg || !_battleSelfMsg)
         {
            return null;
         }
         for each(var _loc1_:HugeHeadNodeBattleAreaMsg in battleNodeMsg.areaList)
         {
            if(_loc1_.pos == _battleSelfMsg.pos)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get attackTower() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:HugeHeadNodeBattleAreaMsg in battleNodeMsg.areaList)
         {
            if(battleNodeMsg.attackForce == _loc2_.belongForce)
            {
               _loc1_++;
            }
         }
         return _loc1_ - 1;
      }
      
      public function get defenceTower() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:HugeHeadNodeBattleAreaMsg in battleNodeMsg.areaList)
         {
            if(battleNodeMsg.defenceForce == _loc2_.belongForce)
            {
               _loc1_++;
            }
         }
         return _loc1_ - 1;
      }
      
      public function getActiveRateByType(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _stateMsg.activeList.length)
         {
            if(_stateMsg.activeList[_loc2_].type == param1)
            {
               return _stateMsg.activeList[_loc2_].effect;
            }
            _loc2_++;
         }
         return 100;
      }
      
      public function get stateMsg() : HugeHeadStateMsg
      {
         return _stateMsg;
      }
      
      public function get signInMsg() : HugeHeadMySignInStateMsg
      {
         return _signInMsg;
      }
      
      public function get battleNodeMsg() : HugeHeadNodeBattleFieldMsg
      {
         return _battleNodeMsg;
      }
      
      public function get battleSelfMsg() : HugeHeadNodeBattleUserMsg
      {
         return _battleSelfMsg;
      }
      
      public function get outyardIsOpen() : Boolean
      {
         if(stateMsg && (stateMsg.stackHeadState == 3 || stateMsg.hugeHeadState == 3))
         {
            return true;
         }
         return false;
      }
   }
}

