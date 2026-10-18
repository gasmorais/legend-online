package yishi.manager
{
   import com.road.yishi.proto.monster.MonsterExploreClientOpMsg;
   import com.road.yishi.proto.monster.MonsterExploreDropItemMsg;
   import com.road.yishi.proto.monster.MonsterExploreEditListMsg;
   import com.road.yishi.proto.monster.MonsterExploreEditMsg;
   import com.road.yishi.proto.monster.MonsterExploreExpMsg;
   import com.road.yishi.proto.monster.MonsterExploreFightMsg;
   import com.road.yishi.proto.monster.MonsterExploreHeroMsg;
   import com.road.yishi.proto.monster.MonsterExploreUserMsg;
   import mvc.module.monsterexplore.MonsterExploreBattleInfo;
   import mvc.module.monsterexplore.MonsterExploreFormationInfo;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class MonsterExploreManager
   {
      
      private static var _instance:MonsterExploreManager;
      
      private var _model:MonsterExploreModel;
      
      public function MonsterExploreManager()
      {
         super();
      }
      
      public static function get instance() : MonsterExploreManager
      {
         if(!_instance)
         {
            _instance = new MonsterExploreManager();
         }
         return _instance;
      }
      
      public function get model() : MonsterExploreModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new MonsterExploreModel();
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4576,__exploreFormationListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4578,__exploreUserInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4579,__bossRoleInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4577,__exploreBattleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4580,__exploreExpChangeHandler);
      }
      
      private function __exploreFormationListHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:MonsterExploreFormationInfo = null;
         var _loc3_:MonsterExploreFormationInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:MonsterExploreEditListMsg = new MonsterExploreEditListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as MonsterExploreEditListMsg;
         model.formationDic.clear();
         model.exploreMonsterDic.clear();
         for each(var _loc4_:MonsterExploreEditMsg in _loc2_.curEdits)
         {
            _loc6_ = new MonsterExploreFormationInfo();
            _loc3_ = new MonsterExploreFormationInfo();
            _loc3_.index = _loc6_.index = _loc4_.index;
            _loc3_.monsterId = _loc6_.monsterId = _loc4_.monsterId;
            _loc3_.fightPos = _loc6_.fightPos = _loc4_.fightPos;
            _loc3_.isCaptain = _loc6_.isCaptain = _loc4_.isCaptain;
            model.exploreMonsterDic.add(_loc6_.monsterId,_loc6_);
            model.formationDic.add(_loc3_.monsterId,_loc3_);
         }
         MsgMan.notifyObserver("FORMATION_SERVER_BACK");
      }
      
      private function __exploreBattleHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MonsterExploreFightMsg = new MonsterExploreFightMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MonsterExploreFightMsg;
         if(_loc2_.hasState)
         {
            model.exploreState = _loc2_.state;
         }
         if(_loc2_.hasStateTime)
         {
            model.stateTime = _loc2_.stateTime / 1000;
         }
         if(_loc2_.hasIsEditSwitch)
         {
            model.nodeSwitchMcState = _loc2_.isEditSwitch;
         }
         model.selfBattleList = [];
         model.vsBattleList = [];
         resovleBattleMsg(_loc2_.attackers,model.selfBattleList);
         resovleBattleMsg(_loc2_.defender,model.vsBattleList);
         MsgMan.notifyObserver("BATTLE_INFO_CHANGE");
      }
      
      private function resovleBattleMsg(param1:Array, param2:Array) : void
      {
         var _loc4_:MonsterExploreBattleInfo = null;
         for each(var _loc3_:MonsterExploreHeroMsg in param1)
         {
            _loc4_ = new MonsterExploreBattleInfo();
            _loc4_.index = _loc3_.index;
            _loc4_.templateId = _loc3_.templateId;
            _loc4_.name = _loc3_.name;
            _loc4_.isMonster = _loc3_.isMonster;
            _loc4_.hp = _loc3_.curHp;
            _loc4_.maxHp = _loc3_.maxHp;
            _loc4_.damages = _loc3_.damages;
            param2.push(_loc4_);
         }
      }
      
      private function __bossRoleInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MonsterExploreDropItemMsg = new MonsterExploreDropItemMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MonsterExploreDropItemMsg;
         model.bossWinReward = _loc2_.items;
         MsgMan.notifyObserver("MOPUP_BOSS_INFO");
      }
      
      private function __exploreUserInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MonsterExploreUserMsg = new MonsterExploreUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MonsterExploreUserMsg;
         if(_loc2_.hasCurChapterId)
         {
            model.curChapterId = _loc2_.curChapterId;
         }
         if(_loc2_.hasCurNodeId)
         {
            model.curNodeId = _loc2_.curNodeId;
         }
         if(_loc2_.hasPassChapterId)
         {
            model.maxChapterId = _loc2_.passChapterId;
         }
         if(_loc2_.hasPassNodeId)
         {
            model.maxNodeId = _loc2_.passNodeId;
         }
         if(_loc2_.hasIsNodeSwitch)
         {
            model.isNodeSwitch = _loc2_.isNodeSwitch;
         }
         if(_loc2_.hasIsEditSwitch)
         {
            model.isEditSwitch = _loc2_.isEditSwitch;
         }
         if(_loc2_.hasFastTotalCount)
         {
            model.fastTotalCount = _loc2_.fastTotalCount;
         }
         if(_loc2_.hasFastUseCount)
         {
            model.fastUserCount = _loc2_.fastUseCount;
         }
         if(_loc2_.hasBossCount)
         {
            model.bossHasCount = _loc2_.bossCount;
         }
         MsgMan.notifyObserver("USER_INFO_CHANGE");
      }
      
      private function __exploreExpChangeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MonsterExploreExpMsg = new MonsterExploreExpMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MonsterExploreExpMsg;
         model.levelIdAry = _loc2_.indexs;
         MsgMan.notifyObserver("EXPLORE_EXP_CHANGE",{
            "type":_loc2_.type,
            "exp":_loc2_.exp
         });
      }
      
      public function sendClientRequest(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8653);
         var _loc2_:MonsterExploreClientOpMsg = new MonsterExploreClientOpMsg();
         _loc2_.opType = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendChapterNodeSelect(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8653);
         var _loc3_:MonsterExploreClientOpMsg = new MonsterExploreClientOpMsg();
         _loc3_.opType = 3;
         _loc3_.chapterId = param1;
         _loc3_.nodeId = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendMopupBoss(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8653);
         var _loc4_:MonsterExploreClientOpMsg = new MonsterExploreClientOpMsg();
         _loc4_.opType = 6;
         _loc4_.chapterId = param1;
         _loc4_.nodeId = param2;
         _loc4_.quickNum = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function sendMonsterFormation(param1:SimpleDictionary) : void
      {
         var _loc3_:MonsterExploreEditMsg = null;
         var _loc4_:PackageOut = new PackageOut(8653);
         var _loc2_:MonsterExploreClientOpMsg = new MonsterExploreClientOpMsg();
         _loc2_.opType = 2;
         for each(var _loc5_:MonsterExploreFormationInfo in param1)
         {
            _loc3_ = new MonsterExploreEditMsg();
            _loc3_.index = _loc5_.index;
            _loc3_.monsterId = _loc5_.monsterId;
            _loc3_.fightPos = _loc5_.fightPos;
            _loc3_.isCaptain = _loc5_.isCaptain;
            _loc2_.edits.push(_loc3_);
         }
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc2_);
      }
   }
}

