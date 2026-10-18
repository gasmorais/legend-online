package yishi.manager
{
   import com.road.yishi.proto.consortiawar.ConsortiaWarBattleFieldMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarClientOpMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarContributeInfoMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarContributeRankMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarDataMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarDefendRecordMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarDefenderMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarFightInfoMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarFightRankMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarScoreInfoMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarScoreRankMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarSeasonMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarTeamMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarTowerDetailMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarTowerMsg;
   import com.road.yishi.proto.consortiawar.ConsortiaWarUpdateMsg;
   import mvc.module.crossguild.CrossGuildData;
   import mvc.module.crossguild.CrossGuildMemberInfo;
   import mvc.module.crossguild.CrossGuildModel;
   import mvc.module.crossguild.CrossGuildRecordInfo;
   import mvc.module.crossguild.CrossGuildTowerInfo;
   import mvc.module.crossguild.CrossGuildWarTeamInfo;
   import yishi.SwitchPageHelp;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   
   public class CrossGuildManager
   {
      
      private static var _instance:CrossGuildManager;
      
      private var _model:CrossGuildModel;
      
      public function CrossGuildManager()
      {
         super();
      }
      
      public static function get instance() : CrossGuildManager
      {
         if(!_instance)
         {
            _instance = new CrossGuildManager();
         }
         return _instance;
      }
      
      public function get model() : CrossGuildModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new CrossGuildModel();
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4573,__crossGuildSeasonHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4566,__crossGuildMainHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4567,__seasonRankHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4568,__contributionRankHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4569,__fightWarMainHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4570,__fightRankHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4571,__towerDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4572,__warInfoChangeHandler);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__consortiaChangeHandler);
      }
      
      private function __consortiaChangeHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID <= 0)
         {
            model.checkClearData();
         }
      }
      
      private function __crossGuildSeasonHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaWarSeasonMsg = new ConsortiaWarSeasonMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaWarSeasonMsg;
         if(_loc2_.hasSeasonId)
         {
            model.season = _loc2_.seasonId;
         }
         if(_loc2_.hasState)
         {
            model.state = _loc2_.state;
         }
         if(_loc2_.hasSignStartTime)
         {
            model.signStartTime = DateFormatter.parse(_loc2_.signStartTime,"YYYY-MM-DD hh:mm:ss");
         }
         if(_loc2_.hasSignStopTime)
         {
            model.signEndTime = DateFormatter.parse(_loc2_.signStopTime,"YYYY-MM-DD hh:mm:ss");
         }
         if(_loc2_.hasStartTime)
         {
            model.openTime = DateFormatter.parse(_loc2_.startTime,"YYYY-MM-DD hh:mm:ss");
         }
         if(_loc2_.hasStopTime)
         {
            model.endTime = DateFormatter.parse(_loc2_.stopTime,"YYYY-MM-DD hh:mm:ss");
         }
         if(_loc2_.hasFightIndex)
         {
            model.fightIndex = _loc2_.fightIndex;
         }
         if(_loc2_.hasSignType)
         {
            model.signType = _loc2_.signType;
         }
         if(_loc2_.hasIsBye)
         {
            model.isBye = _loc2_.isBye;
         }
         if(_loc2_.hasIsValid)
         {
            model.isValid = _loc2_.isValid;
         }
         if(_loc2_.hasBuffEndTime)
         {
            model.crossGuildBufferEndDate = DateFormatter.parse(_loc2_.buffEndTime,"YYYY-MM-DD hh:mm:ss");
         }
         model.firstGuild = null;
         if(_loc2_.hasFirst && _loc2_.first)
         {
            model.firstGuild = new CrossGuildData();
            model.firstGuild.crossOrder = _loc2_.first.order;
            model.firstGuild.guildUid = _loc2_.first.consortiaUid;
            model.firstGuild.consortiaName = _loc2_.first.consortiaName;
            model.firstGuild.serverName = _loc2_.first.serverName;
            model.firstGuild.score = _loc2_.first.score;
         }
         if(model.state != 6)
         {
            if(model.isInCrossGuildWar)
            {
               model.isInCrossGuildWar = false;
               SocketSceneBufferManager.instance.addPkgToBuffer(_loc3_,"CROSS_GUILD_SCENE",__fightOverHandler);
            }
         }
         MsgMan.notifyObserver("CROSS_GUILD_MAIN_CHANGE");
      }
      
      private function __fightOverHandler(param1:PackageIn) : void
      {
         SceneManager.instance.setScene(SwitchPageHelp.returnScene);
      }
      
      private function __crossGuildMainHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:CrossGuildMemberInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaWarDataMsg = new ConsortiaWarDataMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaWarDataMsg;
         if(_loc2_.hasDefendBuffer)
         {
            model.selfGuildBufferId = _loc2_.defendBuffer;
         }
         if(_loc2_.hasIsBye)
         {
            model.isBye = _loc2_.isBye;
         }
         if(_loc2_.hasIsValid)
         {
            model.isValid = _loc2_.isValid;
         }
         if(_loc2_.hasScore)
         {
            if(model.selfGuild == null)
            {
               model.selfGuild = new CrossGuildData();
            }
            model.selfGuild.score = _loc2_.score;
         }
         model.selfBufferList = _loc2_.userBuffers;
         model.vsGuild = null;
         if(!StringHelper.isNullOrEmpty(_loc2_.rivalConsortiaName))
         {
            model.vsGuild = new CrossGuildData();
            model.vsGuild.consortiaName = _loc2_.rivalConsortiaName;
            model.vsGuild.serverName = _loc2_.rivalServerName;
            model.vsGuild.score = _loc2_.rivalScore;
         }
         model.defendMemberList = [];
         for each(var _loc3_:ConsortiaWarDefenderMsg in _loc2_.defenderList)
         {
            _loc5_ = new CrossGuildMemberInfo();
            _loc5_.userId = _loc3_.userId;
            _loc5_.nickName = _loc3_.nickName;
            _loc5_.headId = _loc3_.headId;
            _loc5_.fightCapacity = _loc3_.fightPower;
            _loc5_.bufferId = _loc3_.bufferId;
            model.defendMemberList.push(_loc5_);
         }
         model.defendMemberList.sortOn("fightCapacity",0x10 | 2);
         MsgMan.notifyObserver("CROSS_GUILD_MAIN_CHANGE",_loc2_.opType);
      }
      
      private function __seasonRankHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:CrossGuildData = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaWarScoreRankMsg = new ConsortiaWarScoreRankMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaWarScoreRankMsg;
         if(_loc2_.uuid != model.guildRankUUID)
         {
            model.guildRankList = [];
         }
         for each(var _loc3_:ConsortiaWarScoreInfoMsg in _loc2_.rankList)
         {
            _loc5_ = new CrossGuildData();
            _loc5_.crossOrder = _loc3_.order;
            _loc5_.guildUid = _loc3_.consortiaUid;
            _loc5_.consortiaName = _loc3_.consortiaName;
            _loc5_.serverName = _loc3_.serverName;
            _loc5_.score = _loc3_.score;
            model.guildRankList.push(_loc5_);
         }
         model.guildRankUUID = _loc2_.uuid;
         model.guildRankList.sortOn("crossOrder",16);
         MsgMan.notifyObserver("CROSS_GUILD_SEASON_RANK");
      }
      
      private function __contributionRankHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:CrossGuildMemberInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaWarContributeRankMsg = new ConsortiaWarContributeRankMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaWarContributeRankMsg;
         model.attackContributionList = [];
         for each(var _loc3_:ConsortiaWarContributeInfoMsg in _loc2_.rankList)
         {
            _loc5_ = new CrossGuildMemberInfo();
            _loc5_.userId = _loc3_.userId;
            _loc5_.nickName = _loc3_.nickName;
            _loc5_.fightCapacity = _loc3_.fightPower;
            _loc5_.headId = _loc3_.headId;
            _loc5_.contributionValue = _loc3_.contribute;
            model.attackContributionList.push(_loc5_);
         }
         model.attackContributionList.sortOn("contributionValue",0x10 | 2);
         MsgMan.notifyObserver("MEMBER_ATTACK_CONTRIBUTION");
      }
      
      private function __fightWarMainHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaWarBattleFieldMsg = new ConsortiaWarBattleFieldMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ConsortiaWarBattleFieldMsg;
         if(_loc2_.hasTeamId)
         {
            model.myTeamId = _loc2_.teamId;
         }
         if(_loc2_.hasSpirit)
         {
            model.curSpirit = _loc2_.spirit;
         }
         if(_loc2_.hasBuyCount)
         {
            model.buySpiritCount = _loc2_.buyCount;
         }
         if(_loc2_.hasBufferCount)
         {
            model.bufferCount = _loc2_.bufferCount;
         }
         if(_loc2_.hasMyTeam)
         {
            model.myTeam = createTeamInfo(_loc2_.myTeam);
         }
         if(_loc2_.hasRivalTeam)
         {
            model.vsTeam = createTeamInfo(_loc2_.rivalTeam);
         }
         model.isInCrossGuildWar = true;
         SceneManager.instance.setScene("CROSS_GUILD_SCENE");
      }
      
      private function createTeamInfo(param1:ConsortiaWarTeamMsg) : CrossGuildWarTeamInfo
      {
         var _loc4_:CrossGuildTowerInfo = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:CrossGuildWarTeamInfo = new CrossGuildWarTeamInfo();
         _loc3_.consortiaName = param1.consortiaName;
         _loc3_.serverName = param1.serverName;
         _loc3_.blood = param1.blood;
         _loc3_.maxBlood = param1.maxBlood;
         _loc3_.guildBufferId = param1.defendBufferId;
         _loc3_.towerDic = new SimpleDictionary();
         for each(var _loc2_:ConsortiaWarTowerMsg in param1.towerList)
         {
            _loc4_ = _loc3_.towerDic[_loc2_.towerId];
            if(_loc4_ == null)
            {
               _loc4_ = new CrossGuildTowerInfo();
            }
            if(_loc2_.hasTeamId)
            {
               _loc4_.teamId = _loc2_.teamId;
            }
            if(_loc2_.hasTowerId)
            {
               _loc4_.towerId = _loc2_.towerId;
            }
            if(_loc2_.hasName)
            {
               _loc4_.nickName = _loc2_.name;
            }
            if(_loc2_.hasBlood)
            {
               _loc4_.blood = _loc2_.blood;
            }
            if(_loc2_.hasQuestId)
            {
               _loc4_.questId = _loc2_.questId;
            }
            if(_loc2_.hasAttackCount)
            {
               _loc4_.attackCount = _loc2_.attackCount;
            }
            if(_loc2_.hasTroubleCount)
            {
               _loc4_.troubleCount = _loc2_.troubleCount;
            }
            _loc4_.sealAry = _loc2_.sealList;
            _loc3_.towerDic.update(_loc4_.towerId,_loc4_);
         }
         return _loc3_;
      }
      
      private function __fightRankHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaWarFightRankMsg = new ConsortiaWarFightRankMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaWarFightRankMsg;
         model.myFightRecordList = [];
         for each(var _loc3_:ConsortiaWarFightInfoMsg in _loc2_.myTeam)
         {
            model.myFightRecordList.push(createRecordInfo(_loc3_));
         }
         model.myFightRecordList.sortOn("totalScore",0x10 | 2);
         model.vsFightRecordList = [];
         for each(var _loc5_:ConsortiaWarFightInfoMsg in _loc2_.rivalTeam)
         {
            model.vsFightRecordList.push(createRecordInfo(_loc5_));
         }
         model.vsFightRecordList.sortOn("totalScore",0x10 | 2);
         MsgMan.notifyObserver("ATTACK_RECORD_BACK");
      }
      
      private function createRecordInfo(param1:ConsortiaWarFightInfoMsg) : CrossGuildRecordInfo
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:CrossGuildRecordInfo = new CrossGuildRecordInfo();
         _loc2_.nickName = param1.nickName;
         _loc2_.headId = param1.headId;
         _loc2_.fightPower = param1.fightPower;
         _loc2_.totalScore = param1.totalSocre;
         _loc2_.count1 = param1.count1;
         _loc2_.score1 = param1.score1;
         _loc2_.count2 = param1.count2;
         _loc2_.score2 = param1.score2;
         _loc2_.count3 = param1.count3;
         _loc2_.score3 = param1.score3;
         return _loc2_;
      }
      
      private function __towerDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:CrossGuildRecordInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaWarTowerDetailMsg = new ConsortiaWarTowerDetailMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ConsortiaWarTowerDetailMsg;
         var _loc6_:CrossGuildWarTeamInfo = _loc2_.teamId == model.myTeamId ? model.myTeam : model.vsTeam;
         if(!_loc6_)
         {
            return;
         }
         var _loc4_:CrossGuildTowerInfo = _loc6_.towerDic[_loc2_.towerId];
         if(!_loc4_)
         {
            return;
         }
         _loc4_.teamId = _loc2_.teamId;
         _loc4_.towerId = _loc2_.towerId;
         _loc4_.nickName = _loc2_.name;
         _loc4_.blood = _loc2_.blood;
         _loc4_.troubleCount = _loc2_.troubleCount;
         _loc4_.fightPower = _loc2_.fightPower;
         _loc4_.sealAry = _loc2_.sealList;
         _loc4_.userBufferId = _loc2_.userBufferId;
         _loc4_.defendRecordList = [];
         for each(var _loc3_:ConsortiaWarDefendRecordMsg in _loc2_.recordList)
         {
            _loc7_ = new CrossGuildRecordInfo();
            _loc7_.orderNum = _loc3_.num;
            _loc7_.nickName = _loc3_.attackName;
            _loc7_.attackType = _loc3_.attackType;
            _loc7_.isWin = _loc3_.isWin;
            _loc7_.loseScore = _loc3_.score;
            _loc4_.defendRecordList.push(_loc7_);
         }
         _loc4_.defendRecordList.sortOn("orderNum",0x10 | 2);
         MsgMan.notifyObserver("TOWER_DETAIL_BACK",_loc4_);
      }
      
      private function __warInfoChangeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:CrossGuildTowerInfo = null;
         var _loc5_:CrossGuildWarTeamInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaWarUpdateMsg = new ConsortiaWarUpdateMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ConsortiaWarUpdateMsg;
         if(!model.myTeam || !model.vsTeam)
         {
            return;
         }
         if(_loc2_.hasSpirit)
         {
            model.curSpirit = _loc2_.spirit;
         }
         if(_loc2_.hasBuyCount)
         {
            model.buySpiritCount = _loc2_.buyCount;
         }
         if(_loc2_.hasBufferCount)
         {
            model.bufferCount = _loc2_.bufferCount;
         }
         if(_loc2_.hasTeamId)
         {
            if(_loc2_.teamId == model.myTeamId)
            {
               _loc5_ = model.myTeam;
            }
            else
            {
               _loc5_ = model.vsTeam;
            }
            if(_loc2_.hasBlood)
            {
               _loc5_.blood = _loc2_.blood;
            }
            if(_loc2_.hasTowerData)
            {
               _loc3_ = _loc5_.towerDic[_loc2_.towerData.towerId];
            }
            if(_loc3_)
            {
               if(_loc2_.towerData.hasTeamId)
               {
                  _loc3_.teamId = _loc2_.towerData.teamId;
               }
               if(_loc2_.towerData.hasTowerId)
               {
                  _loc3_.towerId = _loc2_.towerData.towerId;
               }
               if(_loc2_.towerData.hasName)
               {
                  _loc3_.nickName = _loc2_.towerData.name;
               }
               if(_loc2_.towerData.hasBlood)
               {
                  _loc3_.blood = _loc2_.towerData.blood;
               }
               if(_loc2_.towerData.hasQuestId)
               {
                  _loc3_.questId = _loc2_.towerData.questId;
               }
               if(_loc2_.towerData.hasAttackCount)
               {
                  _loc3_.attackCount = _loc2_.towerData.attackCount;
               }
               if(_loc2_.towerData.hasTroubleCount)
               {
                  _loc3_.troubleCount = _loc2_.towerData.troubleCount;
               }
               _loc3_.sealAry = _loc2_.towerData.sealList;
               _loc5_.towerDic.update(_loc3_.towerId,_loc3_);
            }
         }
         if(_loc2_.hasSpirit)
         {
            model.curSpirit = _loc2_.spirit;
         }
         MsgMan.notifyObserver("WAR_OHTER_INFO_CHANGE",_loc3_);
      }
      
      public function sendCrossGuildSign(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8650);
         var _loc2_:ConsortiaWarClientOpMsg = new ConsortiaWarClientOpMsg();
         _loc2_.opType = 2;
         _loc2_.signType = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendFrameRequest(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8650);
         var _loc2_:ConsortiaWarClientOpMsg = new ConsortiaWarClientOpMsg();
         _loc2_.opType = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendBufferSelect(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8650);
         var _loc3_:ConsortiaWarClientOpMsg = new ConsortiaWarClientOpMsg();
         _loc3_.opType = param1;
         _loc3_.bufferId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendBuySpirit() : void
      {
         var _loc2_:PackageOut = new PackageOut(8650);
         var _loc1_:ConsortiaWarClientOpMsg = new ConsortiaWarClientOpMsg();
         _loc1_.opType = 7;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendCrossGuildWar(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8650);
         var _loc2_:ConsortiaWarClientOpMsg = new ConsortiaWarClientOpMsg();
         _loc2_.opType = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendCrossGuildTowerAttack(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8650);
         var _loc4_:ConsortiaWarClientOpMsg = new ConsortiaWarClientOpMsg();
         _loc4_.opType = 8;
         _loc4_.teamId = param1;
         _loc4_.towerId = param2;
         _loc4_.attackType = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendCrossGuildTowerDetail(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8650);
         var _loc3_:ConsortiaWarClientOpMsg = new ConsortiaWarClientOpMsg();
         _loc3_.opType = 9;
         _loc3_.teamId = param1;
         _loc3_.towerId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

