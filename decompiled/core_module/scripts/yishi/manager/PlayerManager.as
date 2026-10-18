package yishi.manager
{
   import battle.BattleManager;
   import battle.utils.Int64Utils;
   import chat.datas.ChatData;
   import com.pickgliss.utils.ObjectPool;
   import com.road.yishi.proto.army.SimpleHeroInfoMsg;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.campaign.DragonCampaingnDataMsg;
   import com.road.yishi.proto.campaign.TowerInfoMsg;
   import com.road.yishi.proto.campaign.TowerListMsg;
   import com.road.yishi.proto.castle.CastleReqMsg;
   import com.road.yishi.proto.children.ChildrenInfoMsg;
   import com.road.yishi.proto.children.ChildrenOpMsg;
   import com.road.yishi.proto.children.PlayerChildInfoMsg;
   import com.road.yishi.proto.customer.FastOpenCustomerMsg;
   import com.road.yishi.proto.fate.FateEditMsg;
   import com.road.yishi.proto.fate.FateInfoMsg;
   import com.road.yishi.proto.fate.FateListMsg;
   import com.road.yishi.proto.item.ItemSmithyMsg;
   import com.road.yishi.proto.novice.NoviceReqMsgMsg;
   import com.road.yishi.proto.pet.PetInfoMsg;
   import com.road.yishi.proto.pet.PlayerPetMsg;
   import com.road.yishi.proto.pet.PlayerPetOpMsg;
   import com.road.yishi.proto.player.CollectCampaignNodeMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import com.road.yishi.proto.player.MultiCampaignEnterCountMsg;
   import com.road.yishi.proto.player.OfflineRewardMsg;
   import com.road.yishi.proto.player.PlayerEnchantMsg;
   import com.road.yishi.proto.player.PlayerMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.player.PropertyUpdatedMsg;
   import com.road.yishi.proto.player.QueryCollectCampaignNodeRspMsg;
   import com.road.yishi.proto.player.RefuseFriendRspMsg;
   import com.road.yishi.proto.player.SynchronizedTimeMsg;
   import com.road.yishi.proto.player.VicePasswordMsg;
   import com.road.yishi.proto.retrieve.RetrieveInfo;
   import com.road.yishi.proto.retrieve.RetrieveInfosMsg;
   import com.road.yishi.proto.room.RoomPlayerListMsg;
   import com.road.yishi.proto.room.RoomPlayerMsg;
   import com.road.yishi.proto.simple.DetailReqMsg;
   import com.road.yishi.proto.simple.InfoReqMsg;
   import com.road.yishi.proto.simple.InfoRspMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.simple.RelationPlayerMsg;
   import com.road.yishi.proto.vehicle.PlayerVehicleListMsg;
   import com.road.yishi.proto.vehicle.PlayerVehicleMsg;
   import com.road.yishi.proto.vehicle.PlayerVehicleProfileMsg;
   import com.road.yishi.proto.watch.HeroWatchMsg;
   import com.road.yishi.proto.watch.HeroWatchOpMsg;
   import com.road.yishi.proto.watch.WatchInfoMsg;
   import events.FriendUpdateEvent;
   import events.PetEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import funny.FunnyEvent;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import managers.IMManager;
   import managers.TaskTraceTipManager;
   import managers.TreasureHuntManager;
   import map.internals.data.NodeMapPhysics;
   import map.internals.data.SpaceNode;
   import map.internals.event.OuterCityEvent;
   import map.internals.utils.SocketGameReader;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import map.space.data.SpaceNodeType;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.children.ChildData;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.findback.FindBackItemInfo;
   import mvc.module.findback.FindBackModel;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.pet.PetData;
   import tasktracetip.data.TipMessageData;
   import utils.GuideUtils;
   import yishi.GlobalConfig;
   import yishi.actions.map.TransferOuterCityAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.BattleGuardInfo;
   import yishi.datas.playerinfo.BattleGuardSocketInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.playerinfo.TowerInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.events.RequestInfoEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.events.ServiceReceiveEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.PlayerEffectHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public final class PlayerManager extends EventDispatcher
   {
      
      private static var _instance:PlayerManager;
      
      public var loginState:int = -1;
      
      private var _playerModel:PlayerModel;
      
      private var _watingList:SimpleDictionary;
      
      public var lookingPlayerName:String = "";
      
      public var openCustomerServiceFrame:int = 0;
      
      private var sortPet:Boolean;
      
      public var isExistNewbieMask:Boolean;
      
      public function PlayerManager()
      {
         super();
         _playerModel = new PlayerModel();
         _watingList = new SimpleDictionary();
      }
      
      public static function get instance() : PlayerManager
      {
         if(!_instance)
         {
            _instance = new PlayerManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      public function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 3,__uPlayerInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4193,__uRefusefriend);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4194,__uRefuseInvite);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4635,__uRefuseTeamInvite);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 110,__playerEffectHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4184,__addComposeTempHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 105,__transferCastleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4159,__transferResultHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 11,__playerListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4195,__hookRewardHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4128,__getSimpleInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4256,__getSimpleAndSnsInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4205,__towerInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4373,__towerListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4234,__sysTimeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4240,__uPlayerEnterCopyNumHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4392,_openCustomerHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4464,__crossPlayerInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4471,__daygesteUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4515,__vehicleProfileChangeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4516,__receiveVehicleListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4501,__vehicleTechHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4540,__petInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4598,__loginSyncMapIdHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4608,__receivePetDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4758,__receiveChildDataHandler);
         SocketManager.instance.listener(4631,__battleguardInfoHandler);
         SocketManager.instance.listener(4555,__dragonSoulReqHandler);
         SocketManager.instance.listener(4556,__dragonSoulTransferHandler);
         SocketManager.instance.listener(4557,__dragonSoulTransferInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4665,dragonCampaignInfoResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4696,__vicePassword);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4811,__receiveYearNodeDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4875,__crisisrewardTimeHandler);
      }
      
      private function __crisisrewardTimeHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         var _loc3_:int = _loc2_.param1;
         PlayerManager.instance.currentPlayerModel.playerInfo.usePlaneCrisis = _loc3_;
      }
      
      private function __receiveYearNodeDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:* = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:QueryCollectCampaignNodeRspMsg = new QueryCollectCampaignNodeRspMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as QueryCollectCampaignNodeRspMsg;
         var _loc5_:Dictionary = new Dictionary();
         var _loc4_:Boolean = false;
         for each(var _loc3_:CollectCampaignNodeMsg in _loc2_.collectCampaignNode)
         {
            _loc5_[_loc3_.campaignDataId] = _loc3_;
         }
         if(SpaceManager.instance.model)
         {
            for each(_loc6_ in SpaceManager.instance.model.mapNodesData)
            {
               if(SpaceNodeType.isYearNode(_loc6_.info.types))
               {
                  if(!_loc5_[_loc6_.info.id])
                  {
                     if((_loc6_ as SpaceNode).stateId != 0)
                     {
                        (_loc6_ as SpaceNode).stateId = 0;
                        _loc6_.dispatchEvent(new OuterCityEvent("UPDATA_MAP_PHYSICS",null));
                     }
                  }
                  else
                  {
                     (_loc6_ as SpaceNode).sonType = _loc5_[_loc6_.info.id].sonType;
                     _loc6_.info.names = _loc5_[_loc6_.info.id].name;
                     if((_loc6_ as SpaceNode).stateId != 1)
                     {
                        (_loc6_ as SpaceNode).stateId = 1;
                        _loc6_.dispatchEvent(new OuterCityEvent("UPDATA_MAP_PHYSICS",null));
                     }
                  }
               }
            }
         }
      }
      
      private function __findBackHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:FindBackItemInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RetrieveInfosMsg = new RetrieveInfosMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RetrieveInfosMsg;
         var _loc3_:FindBackModel = currentPlayerModel.findBackModel;
         if(_loc2_.hasOperate)
         {
            _loc3_.received = _loc2_.operate != 0;
         }
         _loc3_.itemsUsePoint.length = 0;
         _loc3_.itemsUseGold.length = 0;
         for each(var _loc6_:RetrieveInfo in _loc2_.retrieveInfo)
         {
            _loc4_ = FindBackItemInfo.createFromMsg(_loc6_);
            _loc4_.rewards.sort(FindBackModel.sortRewards);
            _loc3_.addItem(_loc4_);
         }
         _loc3_.itemsUsePoint.sort(FindBackModel.sortItem);
         _loc3_.itemsUseGold.sort(FindBackModel.sortItem);
         _loc3_.dispatchChangeEvent();
      }
      
      private function __vicePassword(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:VicePasswordMsg = new VicePasswordMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as VicePasswordMsg;
         if(_loc2_.opType == 1)
         {
            if(_loc2_.result != 0)
            {
               if(_loc2_.result == 1)
               {
                  MsgMan.notifyObserver("yishi.datas.consant.VICE_PASSWORD_OP_SUCCESS_EVENT");
                  GlobalConfig.isConfirmPassword = true;
                  _loc3_ = LanguageMgr.GetTranslation("vicepassword.description16");
                  MessageTipManager.instance().show(_loc3_);
               }
            }
         }
         else if(_loc2_.opType == 2)
         {
            if(_loc2_.result != 0)
            {
               if(_loc2_.result == 1)
               {
                  MsgMan.notifyObserver("yishi.datas.consant.VICE_PASSWORD_OP_SUCCESS_EVENT");
                  currentPlayerModel.playerInfo.hasVicePassword = 1;
                  GlobalConfig.isConfirmPassword = true;
                  _loc3_ = LanguageMgr.GetTranslation("vicepassword.description17");
                  MessageTipManager.instance().show(_loc3_);
               }
            }
         }
         else if(_loc2_.opType == 3)
         {
            if(_loc2_.result != 0)
            {
               if(_loc2_.result == 1)
               {
                  MsgMan.notifyObserver("yishi.datas.consant.VICE_PASSWORD_OP_SUCCESS_EVENT");
                  GlobalConfig.isConfirmPassword = true;
                  _loc3_ = LanguageMgr.GetTranslation("vicepassword.description18");
                  MessageTipManager.instance().show(_loc3_);
               }
            }
         }
         else if(_loc2_.opType == 4)
         {
            if(_loc2_.result != 0)
            {
               if(_loc2_.result == 1)
               {
                  currentPlayerModel.playerInfo.isDuringResetTime = 1;
                  _loc3_ = LanguageMgr.GetTranslation("vicepassword.description19");
                  MessageTipManager.instance().show(_loc3_);
               }
            }
         }
         else if(_loc2_.opType == 5)
         {
            if(_loc2_.result == 0)
            {
               currentPlayerModel.playerInfo.needViceGuild = false;
            }
            else if(_loc2_.result == 1)
            {
               currentPlayerModel.playerInfo.needViceGuild = true;
            }
         }
         else if(_loc2_.opType == 6)
         {
            if(_loc2_.result == 0)
            {
               currentPlayerModel.playerInfo.needShowReward = false;
            }
            else if(_loc2_.result == 1)
            {
               currentPlayerModel.playerInfo.needShowReward = true;
            }
         }
      }
      
      private function dragonCampaignInfoResult(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:DragonCampaingnDataMsg = new DragonCampaingnDataMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as DragonCampaingnDataMsg;
         var _loc3_:Date = new Date();
         BattleManager.molongCountDownTime = _loc3_.time + _loc2_.campaignTm;
         BattleManager.molongLayer = _loc2_.curRound;
      }
      
      private function __sysTimeHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SynchronizedTimeMsg = new SynchronizedTimeMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SynchronizedTimeMsg;
         var _loc3_:Date = DateFormatter.parse(_loc2_.sysCurtime,"YYYY-MM-DD hh:mm:ss");
         _playerModel.sysCurtime = _loc3_;
         _playerModel.sysSecond = Int64Utils.int64ToNumber(_loc2_.sysMillisecond) / 1000;
      }
      
      private function __towerInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TowerInfoMsg = new TowerInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TowerInfoMsg;
         var _loc4_:TowerInfo = currentPlayerModel.towerInfo;
         readTowerInfo(_loc4_,_loc2_);
         if(WorldBossHelper.checkMaze(_loc2_.campaignId))
         {
            _loc4_ = currentPlayerModel.towerInfo1;
         }
         else if(WorldBossHelper.checkMaze2(_loc2_.campaignId))
         {
            _loc4_ = currentPlayerModel.towerInfo2;
         }
         else if(WorldBossHelper.checkMaze3(_loc2_.campaignId))
         {
            _loc4_ = currentPlayerModel.towerInfo3;
         }
         readTowerInfo(_loc4_,_loc2_);
         dispatchEvent(new PlayerEvent("UPDATE_TOWER_INFO",null));
      }
      
      private function __towerListHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:TowerInfo = null;
         var _loc4_:int = 0;
         var _loc3_:TowerInfoMsg = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TowerListMsg = new TowerListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TowerListMsg;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.towerInfo.length)
         {
            _loc3_ = _loc2_.towerInfo[_loc4_];
            if(WorldBossHelper.checkMaze(_loc3_.campaignId))
            {
               _loc6_ = currentPlayerModel.towerInfo1;
            }
            else if(WorldBossHelper.checkMaze2(_loc3_.campaignId))
            {
               _loc6_ = currentPlayerModel.towerInfo2;
            }
            else if(WorldBossHelper.checkMaze3(_loc3_.campaignId))
            {
               _loc6_ = currentPlayerModel.towerInfo3;
            }
            readTowerInfo(_loc6_,_loc3_);
            _loc4_++;
         }
      }
      
      private function readTowerInfo(param1:TowerInfo, param2:TowerInfoMsg) : void
      {
         param1.campaignId = param2.campaignId;
         param1.index = param2.index;
         param1.enterCount = param2.enterCount;
         param1.maxIndex = param2.maxIndex;
         param1.order = param2.order;
         param1.totalGp = param2.totalGp;
         param1.towerIndex = param2.towerIndex;
         param1.maxEnterCount = param2.maxEnterCount;
         param1.itemTempIds = param2.itemTempIds;
         param1.freeEnterCount = param2.freeEnterCount;
         param1.firstBloodId = param2.firstHitId;
         param1.firstBloodName = param2.firstHitName;
         param1.commit();
      }
      
      private function __hookRewardHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:OfflineRewardMsg = new OfflineRewardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as OfflineRewardMsg;
         currentPlayerModel.hookTime = _loc2_.offlineTime;
         currentPlayerModel.hookGp = _loc2_.gpCount;
      }
      
      private function __playerEffectHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyUpdatedMsg = new PropertyUpdatedMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyUpdatedMsg;
         var _loc3_:int = _loc2_.propertyType;
         var _loc5_:int = _loc2_.value;
         PlayerEffectHelper.updatePlayerEffect(_loc3_,_loc5_,_playerModel.playerEffect);
      }
      
      private function __addComposeTempHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ItemSmithyMsg = new ItemSmithyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ItemSmithyMsg;
         var _loc3_:PlayerInfo = currentPlayerModel.playerInfo;
         _loc3_.beginChanges();
         _loc3_.addComposeTemp(_loc2_.composeId);
         _loc3_.commit();
      }
      
      private function __uRefusefriend(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RefuseFriendRspMsg = new RefuseFriendRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RefuseFriendRspMsg;
         _playerModel.playerInfo.refuseFriend = _loc2_.result;
      }
      
      private function __uRefuseInvite(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RefuseFriendRspMsg = new RefuseFriendRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RefuseFriendRspMsg;
         _playerModel.playerInfo.refuseInvite = _loc2_.result;
      }
      
      private function __uRefuseTeamInvite(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RefuseFriendRspMsg = new RefuseFriendRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RefuseFriendRspMsg;
         _playerModel.playerInfo.refuseTeamInvite = _loc2_.result;
      }
      
      private function __uPlayerEnterCopyNumHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MultiCampaignEnterCountMsg = new MultiCampaignEnterCountMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MultiCampaignEnterCountMsg;
         _playerModel.playerInfo.beginChanges();
         _playerModel.playerInfo.multiCopyCount = _loc2_.campaignCount;
         _playerModel.playerInfo.multiCopyMaxCount = _loc2_.campaignMaxcount;
         _playerModel.playerInfo.commit();
      }
      
      private function __uPlayerInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc3_:PlayerInfo = currentPlayerModel.playerInfo;
         _loc3_.beginChanges();
         thane.beginChanges();
         if(_loc3_.userId == 0)
         {
            _loc5_ = true;
         }
         var _loc4_:PlayerMsg = new PlayerMsg();
         _loc4_ = _loc6_.readBody(_loc4_) as PlayerMsg;
         if(_loc4_.hasTeamCount)
         {
            _loc3_.teamCount = _loc4_.teamCount;
         }
         if(_loc4_.hasTeamMaxCount)
         {
            _loc3_.teamMaxCount = _loc4_.teamMaxCount;
         }
         if(_loc4_.hasTerraTempleCount)
         {
            _loc3_.tailaCount = _loc4_.terraTempleCount;
         }
         if(_loc4_.hasTerraTempleMaxCount)
         {
            _loc3_.tailaMaxCount = _loc4_.terraTempleMaxCount;
         }
         if(_loc4_.hasWeekCampaignCount)
         {
            _loc3_.wasteCount = _loc4_.weekCampaignCount;
         }
         if(_loc4_.hasWeekCampaignMaxCount)
         {
            _loc3_.wasteMaxCount = _loc4_.weekCampaignMaxCount;
         }
         if(_loc4_.hasPetPveCount)
         {
            _loc3_.petPveCount = _loc4_.petPveCount;
         }
         if(_loc4_.hasPetPveMaxCount)
         {
            _loc3_.petPveMaxCount = _loc4_.petPveMaxCount;
         }
         if(_loc4_.hasGuardWarCount)
         {
            _loc3_.childWarCount = _loc4_.guardWarCount;
         }
         if(_loc4_.hasGuardWarMaxCount)
         {
            _loc3_.childWarMaxCount = _loc4_.guardWarMaxCount;
         }
         if(_loc4_.hasAbyssPrisonCount)
         {
            _loc3_.deepPrisonCount = _loc4_.abyssPrisonCount;
         }
         if(_loc4_.hasAbyssPrisonMaxCount)
         {
            _loc3_.deepPrisonMaxCount = _loc4_.abyssPrisonMaxCount;
         }
         if(_loc4_.hasSkyStepCount)
         {
            _loc3_.skyStepCount = _loc4_.skyStepCount;
         }
         if(_loc4_.hasSkyStepMaxCount)
         {
            _loc3_.skyStepMaxCount = _loc4_.skyStepMaxCount;
         }
         if(_loc4_.hasSkillProficiency)
         {
            _loc3_.lifeSKillProficiency = _loc4_.skillProficiency;
         }
         if(_loc4_.hasSkills)
         {
            _loc3_.lifeSkillId = _loc4_.skills;
         }
         if(_loc4_.hasSkillGrade)
         {
            _loc3_.lifeSKillGrade = _loc4_.skillGrade;
         }
         if(_loc4_.hasSkillComposeTimes)
         {
            _loc3_.lifeSKillComposeNum = _loc4_.skillComposeTimes;
         }
         if(_loc4_.hasSkillCollectTimes)
         {
            _loc3_.lifeSKillCollectNum = _loc4_.skillCollectTimes;
         }
         if(_loc4_.hasComposeId)
         {
            _loc3_.liftComposeId = _loc4_.composeId;
         }
         if(_loc4_.hasWarFieldCount)
         {
            _loc3_.warFieldCount = _loc4_.warFieldCount;
            InfoTipsManager.instance.updateValue(9,_loc3_.warFieldCount);
         }
         if(_loc4_.hasServerName)
         {
            _loc3_.serviceName = _loc4_.serverName;
         }
         if(_loc4_.hasPlayerId)
         {
            _loc3_.userId = _loc4_.playerId;
         }
         if(_loc4_.hasUuid)
         {
            _loc3_.uuid = _loc4_.uuid;
         }
         if(_loc4_.hasNickName)
         {
            _loc3_.nickName = _loc4_.nickName;
         }
         if(_loc4_.hasRight)
         {
            _loc3_.right = _loc4_.right;
         }
         if(_loc4_.hasSex)
         {
            _loc3_.sexs = _loc4_.sex;
         }
         if(_loc4_.hasPic)
         {
            _loc3_.pics = _loc4_.pic;
         }
         if(_loc4_.hasCamp)
         {
            _loc3_.camp = _loc4_.camp;
         }
         if(_loc4_.hasPoint)
         {
            _loc3_.point = _loc4_.point;
         }
         if(_loc4_.hasGiftToken)
         {
            _loc3_.giftToken = _loc4_.giftToken;
         }
         if(_loc4_.hasState)
         {
            _loc3_.state = _loc4_.state;
         }
         if(_loc4_.hasLastAward)
         {
            _loc3_.lastAward = DateFormatter.parse(_loc4_.lastAward,"YYYY-MM-DD hh:mm:ss");
         }
         if(_loc4_.hasTotalGp)
         {
            _loc3_.totalGP = Int64Utils.int64ToNumber(_loc4_.totalGp);
         }
         if(_loc4_.hasSignSite)
         {
            _loc3_.signSite = _loc4_.signSite;
         }
         if(_loc4_.hasSignTimes)
         {
            _loc3_.signTimes = _loc4_.signTimes;
         }
         if(_loc4_.hasFirstCharge)
         {
            _loc3_.isFirstCharge = _loc4_.firstCharge;
         }
         if(_loc4_.hasQuestSite)
         {
            _loc3_.questSite = _loc4_.questSite;
         }
         if(_loc4_.hasConsortiaId)
         {
            _loc3_.consortiaID = _loc4_.consortiaId;
         }
         if(_loc4_.hasConsortiaName)
         {
            _loc3_.consortiaName = _loc4_.consortiaName;
         }
         if(_loc4_.hasClaimId)
         {
            _loc3_.claimId = _loc4_.claimId;
         }
         if(_loc4_.hasClaimName)
         {
            _loc3_.claimName = _loc4_.claimName;
         }
         if(_loc4_.hasLastOutConsortia)
         {
            _loc3_.lastOutConsortia = DateFormatter.parse(_loc4_.lastOutConsortia,"YYYY-MM-DD hh:mm:ss").getTime() / 1000;
         }
         if(_loc4_.hasIsAuto)
         {
            _loc3_.isAuto = _loc4_.isAuto;
         }
         if(_loc4_.hasBlessingBuff)
         {
            _loc3_.seminaryEffect = _loc4_.blessingBuff;
         }
         if(_loc4_.hasTrialTowerCampaignCount)
         {
            _loc3_.trialTowerCampaignCount = _loc4_.trialTowerCampaignCount;
         }
         if(_loc4_.hasTrialTowerCampaignMaxCount)
         {
            _loc3_.trialTowerCampaignMaxCount = _loc4_.trialTowerCampaignMaxCount;
         }
         if(_loc4_.hasLordsScore)
         {
            _loc3_.gloryPoint = _loc4_.lordsScore;
         }
         if(_loc4_.isReceived)
         {
            _loc3_.isReceived = _loc4_.isReceived;
         }
         if(_loc4_.hasMineScore)
         {
            _loc3_.mineral = _loc4_.mineScore;
         }
         if(_loc4_.hasIsBackPlayer)
         {
            if(_loc4_.isBackPlayer != _loc3_.isBackPlayer)
            {
               FunnyManager.instance.dispatchEvent(new FunnyEvent("REFRESH_TEMP"));
            }
            _loc3_.isBackPlayer = _loc4_.isBackPlayer;
            thane.isBackPlayer = _loc4_.isBackPlayer;
         }
         if(_loc4_.hasCrossGuildScore)
         {
            _loc3_.crossGuildScore = _loc4_.crossGuildScore;
         }
         if(_loc4_.hasJob)
         {
            _loc3_.job = _loc4_.job;
            if(thane.job != _loc4_.job)
            {
               _loc2_ = true;
            }
            thane.job = _loc4_.job;
         }
         if(_loc4_.hasGrades)
         {
            if(thane.grades != _loc4_.grades)
            {
               _loc2_ = true;
            }
            thane.grades = _loc4_.grades;
         }
         if(_loc4_.hasGp)
         {
            if(thane.gp != Int64Utils.int64ToNumber(_loc4_.gp))
            {
               _loc2_ = true;
            }
            thane.gp = Int64Utils.int64ToNumber(_loc4_.gp);
         }
         if(_loc4_.hasLeaveGp)
         {
            if(thane.offlineGp != _loc4_.leaveGp)
            {
               _loc2_ = true;
            }
            thane.offlineGp = _loc4_.leaveGp;
         }
         if(_loc4_.hasGeste)
         {
            if(thane.honer != _loc4_.geste)
            {
               _loc2_ = true;
            }
            thane.honer = _loc4_.geste;
         }
         if(_loc4_.hasCharm)
         {
            if(thane.charms != _loc4_.charm)
            {
               _loc2_ = true;
            }
            thane.charms = _loc4_.charm;
         }
         if(_loc4_.hasLordsScore)
         {
            if(thane.gloryPoint != _loc4_.lordsScore)
            {
               _loc2_ = true;
            }
            thane.gloryPoint = _loc4_.lordsScore;
         }
         if(_loc4_.hasRewardTimes)
         {
            if(thane.rewardCount != _loc4_.rewardTimes)
            {
               _loc2_ = true;
            }
            thane.rewardCount = _loc4_.rewardTimes;
         }
         if(_loc4_.hasGrades)
         {
            if(thane.jewelGrades != _loc4_.storeGrade)
            {
               _loc2_ = true;
            }
            thane.jewelGrades = _loc4_.storeGrade;
         }
         if(_loc4_.hasGradeProcess)
         {
            if(thane.jewelGp != _loc4_.storeGp)
            {
               _loc2_ = true;
            }
            thane.jewelGp = _loc4_.storeGp;
         }
         if(_loc4_.hasSeniorStoreGp)
         {
            if(thane.seniorStoreGp != _loc4_.seniorStoreGp)
            {
               _loc2_ = true;
            }
            thane.seniorStoreGp = _loc4_.seniorStoreGp;
         }
         if(_loc4_.hasSeniorStoreGrade)
         {
            if(thane.seniorStoreGrade != _loc4_.seniorStoreGrade)
            {
               _loc2_ = true;
            }
            thane.seniorStoreGrade = _loc4_.seniorStoreGrade;
         }
         if(_loc4_.hasEquipmentRefiningGrade)
         {
            if(thane.conciseGrades != _loc4_.equipmentRefiningGrade)
            {
               _loc2_ = true;
            }
            thane.conciseGrades = _loc4_.equipmentRefiningGrade;
         }
         if(_loc4_.hasEquipmentRefiningGp)
         {
            if(thane.conciseGp != _loc4_.equipmentRefiningGp)
            {
               _loc2_ = true;
            }
            thane.conciseGp = _loc4_.equipmentRefiningGp;
         }
         if(_loc4_.hasAppellId)
         {
            if(thane.appellId != _loc4_.appellId)
            {
               _loc2_ = true;
            }
            thane.appellId = _loc4_.appellId;
         }
         if(_loc4_.hasIsOpenDragonTalker)
         {
            thane.isOpenDragonTalker = _loc4_.isOpenDragonTalker;
         }
         if(_loc4_.hasIsCurrentDragonTalker)
         {
            thane.dragonTalkerInfo.isDragonTalker = _loc4_.isCurrentDragonTalker;
         }
         if(_loc4_.hasRepute)
         {
            _loc3_.repute = _loc4_.repute;
         }
         if(_loc4_.hasConsortiaOffer)
         {
            _loc3_.consortiaOffer = _loc4_.consortiaOffer;
         }
         if(_loc4_.hasConsortiaTotaloffer)
         {
            _loc3_.consortiaTotalOffer = _loc4_.consortiaTotaloffer;
         }
         if(_loc4_.hasStrategy)
         {
            _loc3_.strategy = Int64Utils.int64ToNumber(_loc4_.strategy);
         }
         if(_loc4_.hasWeary)
         {
            _loc3_.weary = _loc4_.weary;
         }
         if(_loc4_.refuseFriend)
         {
            _loc3_.refuseFriend = _loc4_.refuseFriend;
         }
         if(_loc4_.refuseInvite)
         {
            _loc3_.refuseInvite = _loc4_.refuseInvite;
         }
         if(_loc4_.refuseTeamInvite)
         {
            _loc3_.refuseTeamInvite = _loc4_.refuseTeamInvite;
         }
         if(_loc4_.hasAttackLeftCount)
         {
            _loc3_.attackCount = _loc4_.attackLeftCount;
         }
         if(_loc4_.hasNoviceProcess)
         {
            _loc3_.noviceProcess = _loc4_.noviceProcess;
         }
         if(_loc4_.hasConsortiaAttack)
         {
            _loc3_.consortiaPower = _loc4_.consortiaAttack;
         }
         if(_loc4_.hasConsortiaDefence)
         {
            _loc3_.consortiaDefence = _loc4_.consortiaDefence;
         }
         if(_loc4_.hasConsortiaAgility)
         {
            _loc3_.consortiaAgility = _loc4_.consortiaAgility;
         }
         if(_loc4_.hasConsortiaAbility)
         {
            _loc3_.consortiaIntellect = _loc4_.consortiaAbility;
         }
         if(_loc4_.hasConsortiaCaptain)
         {
            _loc3_.consortiaCaptain = _loc4_.consortiaCaptain;
         }
         if(_loc4_.hasNewPowerLv)
         {
            _loc3_.newPowerLv = _loc4_.newPowerLv;
         }
         if(_loc4_.hasNewAgilityLv)
         {
            _loc3_.newAgilityLv = _loc4_.newAgilityLv;
         }
         if(_loc4_.hasNewIntellectLv)
         {
            _loc3_.newIntellectLv = _loc4_.newIntellectLv;
         }
         if(_loc4_.hasNewPhysiqueLv)
         {
            _loc3_.newPhysiqueLv = _loc4_.newPhysiqueLv;
         }
         if(_loc4_.hasFamGpLv)
         {
            _loc3_.famGpLv = _loc4_.famGpLv;
         }
         if(_loc4_.hasMedalLv)
         {
            _loc3_.medalLv = _loc4_.medalLv;
         }
         if(_loc4_.hasHonorLv)
         {
            _loc3_.honorLv = _loc4_.honorLv;
         }
         if(_loc4_.hasPropertyLv)
         {
            _loc3_.propertyLv = _loc4_.propertyLv;
         }
         if(_loc4_.hasMasterPowerLv)
         {
            _loc3_.masterPowerLv = _loc4_.masterPowerLv;
         }
         if(_loc4_.hasMasterAgilityLv)
         {
            _loc3_.masterAgilityLv = _loc4_.masterAgilityLv;
         }
         if(_loc4_.hasMasterIntellectLv)
         {
            _loc3_.masterIntellectLv = _loc4_.masterIntellectLv;
         }
         if(_loc4_.hasMasterPhysiqueLv)
         {
            _loc3_.masterPhysiqueLv = _loc4_.masterPhysiqueLv;
         }
         if(_loc4_.hasGpOrder)
         {
            _loc3_.playerOrdeInfo.gpOrder = _loc4_.gpOrder;
            _loc3_.playerOrdeInfo.fightCapacityOrder = _loc4_.order.fightCapacityOrder;
            _loc3_.playerOrdeInfo.honourOrder = _loc4_.order.geste_Order;
            _loc3_.playerOrdeInfo.charmsOrder = _loc4_.order.charm_Order;
            _loc3_.playerOrdeInfo.soulScoreOrder = _loc4_.order.soulScore_Order;
         }
         if(_loc4_.hasCrossScore)
         {
            _loc3_.crossScore = _loc4_.crossScore;
         }
         if(_loc4_.hasFightingCapacity)
         {
            thane.fightingCapacity = _loc4_.fightingCapacity;
            _loc3_.fightingCapacity = _loc4_.fightingCapacity;
         }
         if(_loc4_.hasGradeProcess)
         {
            _loc3_.gradeProcess = int(_loc4_.gradeProcess);
         }
         if(_loc4_.hasTimeProcess)
         {
            _loc3_.timeProgress = _loc4_.timeProcess;
         }
         if(_loc4_.hasTimeGet)
         {
            _loc3_.timeGet = _loc4_.timeGet;
         }
         if(_loc4_.hasTimeRun)
         {
            _loc3_.timeRun = _loc4_.timeRun;
         }
         if(_loc4_.hasBlessingBuff)
         {
            _loc3_.seminaryCount = _loc4_.blessingCount;
         }
         if(_loc4_.hasBlessingBuff)
         {
            _loc3_.seminaryMax = _loc4_.blessingMaxCount;
         }
         if(_loc4_.hasReloginProcess)
         {
            _loc3_.reloginProcess = _loc4_.reloginProcess;
         }
         if(_loc4_.hasReloginProcess)
         {
            _loc3_.reloginCount = _loc4_.reloginCount;
         }
         if(_loc4_.hasCampaignSite)
         {
            _loc3_.campaignSite = _loc4_.campaignSite;
         }
         if(_loc4_.hasBagCount)
         {
            _loc3_.bagCount = _loc4_.bagCount;
         }
         if(_loc4_.hasStartFree)
         {
            _loc3_.starFreeCount = _loc4_.startFree;
         }
         if(_loc4_.hasStarCount)
         {
            _loc3_.starBagCount = _loc4_.starCount;
         }
         if(_loc4_.hasStarpoint)
         {
            _loc3_.starPoint = _loc4_.starpoint;
         }
         if(_loc4_.hasAltarConsortiaId)
         {
            _loc3_.demonConsortiaId = _loc4_.altarConsortiaId;
         }
         if(_loc4_.hasMatchWin)
         {
            _loc3_.matchWin = _loc4_.matchWin;
         }
         if(_loc4_.hasMatchFailed)
         {
            _loc3_.matchFailed = _loc4_.matchFailed;
         }
         if(_loc4_.hasConsortiaGold)
         {
            _loc3_.consortiaGold = _loc4_.consortiaGold;
         }
         if(_loc4_.hasConsortiaPhysique)
         {
            _loc3_.consortiaPhysique = _loc4_.consortiaPhysique;
         }
         if(_loc4_.hasJob)
         {
            _loc3_.job = _loc4_.job;
         }
         if(_loc4_.hasCampaignCount)
         {
            _loc3_.multiCopyCount = _loc4_.campaignCount;
         }
         if(_loc4_.hasMatchRoomCount)
         {
            _loc3_.JJCcount = _loc4_.matchRoomCount;
            InfoTipsManager.instance.updateValue(10,_loc3_.JJCcount);
         }
         if(_loc4_.hasQteGuide)
         {
            _loc3_.qteGuide = _loc4_.qteGuide;
         }
         if(_loc4_.hasKingBuff)
         {
            _loc3_.isGetKingBuffer = _loc4_.kingBuff;
         }
         if(_loc4_.hasWearyLimit)
         {
            _loc3_.wearyLimit = _loc4_.wearyLimit;
         }
         if(_loc4_.hasCampaignMaxcount)
         {
            _loc3_.multiCopyMaxCount = _loc4_.campaignMaxcount;
         }
         if(_loc4_.hasDragonCampaign_Count)
         {
            _loc3_.molongRestNum = _loc4_.dragonCampaign_Count;
         }
         if(_loc4_.hasDragonCampaign_MaxCount)
         {
            _loc3_.molongMaxNum = _loc4_.dragonCampaign_MaxCount;
         }
         if(_loc4_.hasFantasyMatrixCampaignCount)
         {
            _loc3_.fantasyMatrixRestNum = _loc4_.fantasyMatrixCampaignCount;
         }
         if(_loc4_.hasFantasyMatrixCampaignMaxCount)
         {
            _loc3_.fantasyMatrixMaxNum = _loc4_.fantasyMatrixCampaignMaxCount;
         }
         if(_loc4_.hasMonopolyCampaignCount)
         {
            _loc3_.monopolyCampaignNum = _loc4_.monopolyCampaignCount;
         }
         if(_loc4_.hasCrossLeagueMedal)
         {
            _loc3_.crossLeagueMedal = _loc4_.crossLeagueMedal;
         }
         if(_loc4_.hasApplleProperty_Open)
         {
            if(!_loc5_ && currentPlayerModel.isOpenAppellAddition == false && _loc4_.applleProperty_Open == true)
            {
               GuideUtils.setGuideStep("appell",1);
            }
            currentPlayerModel.isOpenAppellAddition = _loc4_.applleProperty_Open;
         }
         if(_loc4_.hasHasVicePassword)
         {
            _loc3_.hasVicePassword = _loc4_.hasVicePassword;
         }
         if(_loc4_.hasIsDuringToResetTime)
         {
            _loc3_.isDuringResetTime = _loc4_.isDuringToResetTime;
         }
         if(_loc4_.hasRentalBagTime)
         {
            _loc3_.rentalBagTime = _loc4_.rentalBagTime;
         }
         if(_loc4_.hasStatus)
         {
            _loc3_.rentalBagStatus = _loc4_.status;
         }
         if(_loc4_.hasBloodyRealmCampaignCount)
         {
            _loc3_.randomBossCount = _loc4_.bloodyRealmCampaignCount;
         }
         if(_loc4_.hasBloodyRealmCampaignMaxCount)
         {
            _loc3_.randomBossMaxCount = _loc4_.bloodyRealmCampaignMaxCount;
         }
         if(_loc4_.hasJumpNovice)
         {
            _loc3_.jumpNovice = _loc4_.jumpNovice;
         }
         if(_loc4_.hasSeekSurplusTime)
         {
            _loc3_.seekSurplusTime = _loc4_.seekSurplusTime;
            TreasureHuntManager.instance.model.seekCount = _loc4_.seekSurplusTime;
         }
         if(_loc4_.isCost)
         {
            _loc3_.isCost = _loc4_.isCost;
         }
         if(_loc4_.hasLastFreeSkillLearnTime)
         {
            _loc3_.lastFreeSkillLearnTime = _loc4_.lastFreeSkillLearnTime;
         }
         if(_loc4_.hasStoneBagCount)
         {
            if(_loc3_.stoneBagCount == 0 && _loc4_.stoneBagCount > 0)
            {
               _loc3_.stoneBagCount = _loc4_.stoneBagCount;
               NotificationManager.instance.sendNotification("STORE_BAG_COUNT_CHANGE");
            }
            _loc3_.stoneBagCount = _loc4_.stoneBagCount;
         }
         if(_loc4_.hasTramcarCount)
         {
            _loc3_.tramcarCount = _loc4_.tramcarCount;
         }
         if(_loc4_.hasBlackGoldCaveMaxCount)
         {
            _loc3_.darkKingMaxCount = _loc4_.blackGoldCaveMaxCount;
         }
         if(_loc4_.hasBlackGoldCaveLeftCount)
         {
            _loc3_.darkKIngLeftCount = _loc4_.blackGoldCaveLeftCount;
         }
         if(_loc4_.hasRushCustomsMaxCount)
         {
            _loc3_.raceAgainstTimeMaxCount = _loc4_.rushCustomsMaxCount;
         }
         if(_loc4_.hasRushCustomsLeftCount)
         {
            _loc3_.raceAgainstTimeLeftCount = _loc4_.rushCustomsLeftCount;
         }
         if(_loc4_.hasQuickPassCount)
         {
            _loc3_.rapidPassNum = _loc4_.quickPassCount;
         }
         if(_loc4_.hasTimeVortexCount)
         {
            _loc3_.timeVortexCount = _loc4_.timeVortexCount;
         }
         if(_loc4_.hasTimeVortexNode)
         {
            _loc3_.timeVortexNode = _loc4_.timeVortexNode;
         }
         if(_loc4_.hasElementSilvaMaxCount)
         {
            _loc3_.elementSilvaMaxCount = _loc4_.elementSilvaMaxCount;
         }
         if(_loc4_.hasElementSilvaLeftCount)
         {
            _loc3_.elementSilvaLeftCount = _loc4_.elementSilvaLeftCount;
         }
         if(_loc4_.hasDungeonTurnLeftRewardCount)
         {
            _loc3_.dungeoRestNum = _loc4_.dungeonTurnLeftRewardCount;
         }
         if(_loc4_.hasDungeonTurnMaxRewardCount)
         {
            _loc3_.dungeoTurnMaxNum = _loc4_.dungeonTurnMaxRewardCount;
         }
         if(_loc4_.hasTimeSpaceLeftRewardCount)
         {
            _loc3_.spacetimeRestNum = _loc4_.timeSpaceLeftRewardCount;
         }
         if(_loc4_.hasTimeSpaceMaxRewardCount)
         {
            _loc3_.spacetimeMaxNum = _loc4_.timeSpaceMaxRewardCount;
         }
         if(_loc4_.hasRuneCount)
         {
            _loc3_.runeCount = _loc4_.runeCount;
         }
         if(_loc4_.hasRunePowerPoint)
         {
            _loc3_.runePowerPoint = _loc4_.runePowerPoint;
         }
         if(_loc5_)
         {
            dispatchEvent(new PlayerEvent("LOGIN_SUCCESS",null));
            return;
         }
         _loc3_.commit();
         if(thane.preGrade > 0 && thane.preGrade < 55 && thane.grades >= 55)
         {
            currentPlayerModel.showBattleGuardBtnShine = true;
         }
         if(_loc2_)
         {
            thane.commit();
         }
         _loc4_ = null;
      }
      
      private function __loginSyncMapIdHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         currentPlayerModel.spaceMapId = _loc2_.param1;
      }
      
      private function __transferResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CastleReqMsg = new CastleReqMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CastleReqMsg;
         var _loc3_:BuildInfo = BuildingManager.instance.model.buildingListByID[-11];
         _loc3_.property1 = _loc2_.leftEnergy;
         _loc3_.property2 = _loc2_.leftTime;
         _loc3_.loadTime = getTimer() / 1000;
         dispatchEvent(new ServiceReceiveEvent("TRANSEFER_ARMY_SUCCESS",true,null));
      }
      
      private function __playerListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc7_:ThaneInfo = null;
         var _loc4_:RoomPlayerMsg = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomPlayerListMsg = new RoomPlayerListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as RoomPlayerListMsg;
         var _loc5_:int = _loc2_.state;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.roomPlayer.length)
         {
            _loc7_ = new ThaneInfo();
            _loc4_ = _loc2_.roomPlayer[_loc3_] as RoomPlayerMsg;
            _loc7_.userId = _loc4_.playerId;
            _loc7_.templateId = _loc4_.templateId;
            _loc7_.grades = _loc4_.grades;
            _loc7_.nickName = _loc4_.nickName;
            _loc7_.sexs = _loc4_.sex;
            _loc7_.consortiaID = _loc4_.consortiaId;
            _loc7_.changeShapeId = _loc4_.changeShapeId;
            _loc7_.IsVipAndNoExpirt = _loc4_.isVip;
            _loc7_.vipType = _loc4_.vipType;
            _loc7_.vocationGrades = _loc4_.transferGrade;
            _loc7_.vocationIndex = _loc4_.changeBranch;
            _loc7_.isBackPlayer = _loc4_.isBackPlayer;
            if(_loc4_.hasConsortiaName)
            {
               _loc7_.consortiaName = _loc4_.consortiaName;
            }
            _loc7_.fightingCapacity = _loc4_.fightingCapacity;
            _loc7_.state = _loc5_;
            if(_loc5_ == 1)
            {
               _watingList.add(_loc7_.userId,_loc7_);
            }
            else
            {
               delete this[_watingList.del(_loc7_.userId)];
            }
            _loc3_++;
         }
      }
      
      private function __getSimpleInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:InfoRspMsg = new InfoRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as InfoRspMsg;
         var _loc3_:int = _loc2_.from;
         var _loc4_:FriendItemCellInfo = new FriendItemCellInfo();
         _loc4_.userId = _loc2_.info.userId;
         _loc4_.nickName = _loc2_.info.nickName;
         _loc4_.gp = Int64Utils.int64ToNumber(_loc2_.info.gp);
         _loc4_.grades = _loc2_.info.grades;
         _loc4_.playerOrdeInfo.gpOrder = _loc2_.info.gpOrder;
         _loc4_.sexs = _loc2_.info.sexs;
         _loc4_.pics = _loc2_.info.pics;
         _loc4_.state = _loc2_.info.state;
         _loc4_.consortiaID = _loc2_.info.consortiaID;
         _loc4_.consortiaName = _loc2_.info.consortiaName;
         _loc4_.camp = _loc2_.info.camp;
         _loc4_.claimId = _loc2_.info.claimId;
         _loc4_.claimName = _loc2_.info.claimName;
         _loc4_.consortiaOffer = _loc2_.info.consortiaOffer;
         _loc4_.consortiaTotalOffer = _loc2_.info.consortiaTotalOffer;
         _loc4_.dutyId = _loc2_.info.dutyId;
         _loc4_.fightingCapacity = _loc2_.info.fightingCapacity;
         _loc4_.matchFailed = _loc2_.info.matchFailed;
         _loc4_.matchWin = _loc2_.info.matchWin;
         _loc4_.templateId = _loc2_.info.job;
         _loc4_.job = _loc2_.info.job;
         _loc4_.seniorStoreGrade = _loc2_.info.seniorStoreGrade;
         if(_loc2_.info.hasChangeBranch)
         {
            _loc4_.vocationIndex = _loc2_.info.changeBranch;
         }
         if(_loc2_.info.hasTransGrade)
         {
            _loc4_.vocationGrades = _loc2_.info.transGrade;
         }
         dispatchEvent(new RequestInfoEvent("REQUEST_SIMPLEINFO",_loc3_,_loc4_));
      }
      
      private function __crossPlayerInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SimpleHeroInfoMsg = new SimpleHeroInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SimpleHeroInfoMsg;
         var _loc3_:ThaneInfo = new ThaneInfo();
         _loc3_.templateId = _loc2_.tempateId;
         _loc3_.nickName = _loc2_.nickName;
         _loc3_.armsEquipAvata = _loc2_.arm;
         _loc3_.bodyEquipAvata = _loc2_.cloth;
         _loc3_.wingAvata = _loc2_.wing;
         if(_loc2_.hasHide)
         {
            _loc3_.hideFashion = _loc2_.hide;
         }
         if(_loc2_.hasFashionCloth)
         {
            _loc3_.bodyFashionAvata = _loc2_.fashionCloth;
         }
         if(_loc2_.hasFashionArm)
         {
            _loc3_.armsFashionAvata = _loc2_.fashionArm;
         }
         if(_loc2_.hasHat)
         {
            _loc3_.hairFashionAvata = _loc2_.hat;
         }
         _loc3_.fightingCapacity = _loc2_.fightingCapacity;
         _loc3_.grades = _loc2_.grade;
         _loc3_.attackProrerty.totalPhyAttack = _loc2_.totalPhyAttack;
         _loc3_.attackProrerty.totalPhyDefence = _loc2_.totalPhyDefence;
         _loc3_.attackProrerty.totalMagicAttack = _loc2_.totalMagicAttack;
         _loc3_.attackProrerty.totalMagicDefence = _loc2_.totalMagicDefence;
         _loc3_.attackProrerty.totalForceHit = _loc2_.totalForceHit;
         _loc3_.attackProrerty.totalParry = _loc2_.totalParry;
         _loc3_.attackProrerty.totalConatArmy = _loc2_.totalConatArmy;
         _loc3_.attackProrerty.totalLive = _loc2_.totalLive;
         _loc3_.attackProrerty.totalDingli = _loc2_.totalStunAttr;
         dispatchEvent(new RequestInfoEvent("REQUEST_SIMPLEINFO",10000,_loc3_));
      }
      
      private function __daygesteUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         var _loc3_:Boolean = false;
         if(_loc2_.hasParam1)
         {
            if(thane.honer != _loc2_.param1)
            {
               _loc3_ = true;
            }
            thane.honerDay = _loc2_.param1;
         }
         if(_loc2_.hasParam2)
         {
            if(thane.honer != _loc2_.param2)
            {
               _loc3_ = true;
            }
            thane.honerDayMax = _loc2_.param2;
         }
         if(_loc2_.hasParam3)
         {
            if(thane.honer != _loc2_.param3)
            {
               _loc3_ = true;
            }
            thane.honerDayMedicinal = _loc2_.param3;
         }
         if(_loc3_)
         {
            thane.commit();
         }
      }
      
      private function __vehicleProfileChangeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerVehicleProfileMsg = new PlayerVehicleProfileMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlayerVehicleProfileMsg;
         _playerModel.playerInfo.beginChanges();
         if(_loc2_.hasExp)
         {
            _playerModel.playerInfo.vehicleGp = _loc2_.exp;
         }
         if(_loc2_.hasScore)
         {
            _playerModel.playerInfo.vehicleScore = _loc2_.score;
         }
         if(_loc2_.hasDefaultVehicle)
         {
            _playerModel.playerInfo.vehicleTempId = _loc2_.defaultVehicle;
         }
         _playerModel.playerInfo.commit();
      }
      
      private function __receiveVehicleListHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerVehicleListMsg = new PlayerVehicleListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PlayerVehicleListMsg;
         var _loc3_:Array = _playerModel.playerInfo.vehicleList;
         _playerModel.playerInfo.beginChanges();
         for each(var _loc4_:PlayerVehicleMsg in _loc2_.vehicles)
         {
            _playerModel.playerInfo.addVehicle(_loc4_.templateId);
         }
         if(_playerModel.playerInfo.vehicleList.length == 1)
         {
            _playerModel.playerInfo.vehicleTempId = _loc3_[0];
         }
         _playerModel.playerInfo.commit();
      }
      
      private function __vehicleTechHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(!_loc2_.hasParam1)
         {
            return;
         }
         _playerModel.vehicleTech = _loc2_.param1;
      }
      
      private function __petInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc9_:Boolean = false;
         var _loc5_:int = 0;
         var _loc10_:PetData = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerPetMsg = new PlayerPetMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as PlayerPetMsg;
         var _loc4_:ThaneInfo = thane;
         _loc4_.beginChanges();
         var _loc6_:PlayerInfo = _playerModel.playerInfo;
         _loc6_.beginChanges();
         if(_loc2_.hasPetCount)
         {
            _loc6_.petMaxCount = _loc2_.petCount;
         }
         if(_loc2_.hasChaPos)
         {
            _loc6_.petChallengeFormation = _loc2_.chaPos;
         }
         if(_loc2_.hasMateLordsPos)
         {
            _loc6_.petMatelordsFormation = _loc2_.mateLordsPos;
         }
         if(_loc2_.hasMonopolyPos)
         {
            _loc6_.petMonopolyFormation = _loc2_.monopolyPos;
         }
         if(_loc2_.hasConsortiaPos)
         {
            _loc6_.petConsortiaBossFormation = _loc2_.consortiaPos;
         }
         if(_loc2_.hasTransferPos)
         {
            _loc6_.petFlameFormation = _loc2_.transferPos;
         }
         var _loc7_:PetData = _loc6_.enterWarPet;
         for each(var _loc3_:PetInfoMsg in _loc2_.petInfo)
         {
            if(_loc3_.hasPetId)
            {
               if(_loc3_.hasIsDel && _loc3_.isDel)
               {
                  _loc6_.removePet(_loc3_.petId);
                  _loc4_.removePet(_loc3_.petId);
               }
               else
               {
                  _loc9_ = true;
                  _loc10_ = _loc6_.getPet(_loc3_.petId);
                  if(!_loc10_)
                  {
                     _loc10_ = new PetData();
                     _loc10_.userId = _loc6_.userId;
                     _loc9_ = false;
                  }
                  _loc5_ = _loc10_.grade;
                  _loc10_.beginChanges();
                  PetData.createWithMsg(_loc3_,_loc10_);
                  _loc10_.thaneInfo = ArmyManager.instance.thane;
                  _loc10_.playerInfo = _loc6_;
                  _loc6_.addPet(_loc10_);
                  _loc4_.addPet(_loc10_);
                  _loc10_.commit();
                  if(_loc10_.isEnterWar && _loc9_ && _loc5_ != _loc10_.grade)
                  {
                     dispatchEvent(new PetEvent("PET_LEVEL_UP",_loc10_));
                  }
               }
            }
         }
         if(!sortPet)
         {
            _loc6_.petList.sortOn("pos",16);
            _loc4_.petList.sortOn("pos",16);
            sortPet = true;
         }
         _loc6_.commit();
         if(_loc6_.enterWarPet)
         {
            _loc4_.petTemplateId = _loc6_.enterWarPet.templateId;
            _loc4_.petName = _loc6_.enterWarPet.name;
            _loc4_.petQuaity = _loc6_.enterWarPet.quality;
            _loc4_.temQuality = _loc6_.enterWarPet.temQuality;
         }
         else
         {
            _loc4_.petTemplateId = 0;
            _loc4_.petName = "";
            _loc4_.petQuaity = 1;
            _loc4_.temQuality = 1;
         }
         _loc4_.commit();
      }
      
      private function showAddPointTip() : void
      {
         var _loc1_:TipMessageData = new TipMessageData();
         _loc1_.title = LanguageMgr.GetTranslation("public.prompt");
         _loc1_.type = 32;
         TaskTraceTipManager.instance.showView(_loc1_);
      }
      
      private function __getSimpleAndSnsInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:FriendItemCellInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:RelationPlayerMsg = new RelationPlayerMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as RelationPlayerMsg;
         var _loc3_:int = _loc2_.from;
         var _loc4_:FriendItemCellInfo = new FriendItemCellInfo();
         SocketGameReader.readSimpleAndSnsInfo(_loc4_,_loc2_);
         if(_loc3_ == 3 || _loc3_ == 2)
         {
            _loc5_ = IMManager.instance.getFriendInfo(_loc4_.userId);
            if(_loc5_)
            {
               _loc5_.grades = _loc4_.grades;
               _loc5_.fightingCapacity = _loc4_.fightingCapacity;
               _loc5_.consortiaName = _loc4_.consortiaName;
               _loc5_.snsInfo = _loc4_.snsInfo;
               FriendManager.getInstance().updatePrivatePerson(_loc5_);
               FriendManager.getInstance().dispatchEvent(new FriendUpdateEvent("friendchange",null));
            }
         }
         dispatchEvent(new RequestInfoEvent("REQUEST_SIMPLEANDSNS_INFO",_loc3_,_loc4_));
      }
      
      public function moveBagToBag(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int = 0) : void
      {
         checkConsortiaBagGoods(param4,param5,param6);
         SocketSendManager.instance.sendMoveBagToBag(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function deleteBagGoods(param1:int, param2:int, param3:int, param4:int) : void
      {
         moveBagToBag(param1,param2,-1,param1,param2,param3,param4);
      }
      
      private function checkConsortiaBagGoods(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:ConsortiaInfo = null;
         if(param1 == 6)
         {
            _loc4_ = FrameControllerManager.instance.consortiaController.model.consortiaInfo;
            if(_loc4_.isStorageExpire1 && param3 >= 56 && param3 <= 56 + 49 - 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("bag.view.ConsortiaRentalBagAlertFrame.alertRental"));
            }
            if(_loc4_.isStorageExpire2 && param3 >= 56 + 49 && param3 <= 56 + 49 * 2 - 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("bag.view.ConsortiaRentalBagAlertFrame.alertRental"));
            }
         }
      }
      
      public function get newbieProcess() : int
      {
         return currentPlayerModel.playerInfo.noviceProcess;
      }
      
      public function set newbieProcess(param1:int) : void
      {
         currentPlayerModel.playerInfo.noviceProcess = param1;
      }
      
      public function get isNewbie() : Boolean
      {
         return newbieProcess < 99900;
      }
      
      public function sendRequestSimpleInfo(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8200);
         var _loc3_:InfoReqMsg = new InfoReqMsg();
         _loc3_.otherId = param1;
         _loc3_.from = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendRequestSimpleAndSnsInfo(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(15038);
         var _loc3_:InfoReqMsg = new InfoReqMsg();
         _loc3_.otherId = param1;
         _loc3_.from = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendRequestEquip(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false) : void
      {
         var _loc8_:PackageOut = new PackageOut(8199);
         var _loc7_:DetailReqMsg = new DetailReqMsg();
         _loc7_.otherId = param1;
         _loc7_.itemInfo = param3;
         _loc7_.heroInfo = param4;
         _loc7_.armyInfo = param5;
         _loc7_.pawnInfo = param6;
         SocketManager.instance.socket.sendProtobuffer(_loc8_,_loc7_);
      }
      
      public function synchronizedSystime() : void
      {
         var _loc1_:PackageOut = new PackageOut(20008);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function checkAccelerator() : void
      {
         var _loc1_:PackageOut = new PackageOut(20010);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function useAccelerate() : void
      {
         var _loc2_:PackageOut = new PackageOut(20009);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 0;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function useTools() : void
      {
         var _loc2_:PackageOut = new PackageOut(20009);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendMoveCastle(param1:int, param2:int, param3:int, param4:int) : void
      {
         SocketSendManager.instance.sendMoveCastle(param1,param2,param3,param4);
      }
      
      public function sendLevy(param1:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(8327);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function get currentPlayerModel() : PlayerModel
      {
         return _playerModel;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get watingList() : SimpleDictionary
      {
         return _watingList;
      }
      
      private function _openCustomerHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FastOpenCustomerMsg = new FastOpenCustomerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as FastOpenCustomerMsg;
         openCustomerServiceFrame = _loc2_.canOpen;
      }
      
      public function changeVehicle(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8611);
         var _loc2_:CampaignReqMsg = new CampaignReqMsg();
         _loc2_.paraInt1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendRequestPetData(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8702);
         var _loc2_:PlayerPetOpMsg = new PlayerPetOpMsg();
         _loc2_.petId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendRequistChildData(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8875);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.property1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function __receivePetDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:PetData = null;
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerPetMsg = new PlayerPetMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as PlayerPetMsg;
         for each(var _loc3_:PetInfoMsg in _loc2_.petInfo)
         {
            _loc7_ = new PetData();
            _loc7_.userId = _loc2_.userId;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.equipmets.length)
            {
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _loc2_.equipmets[_loc4_].templateId;
               _loc5_.pos = _loc2_.equipmets[_loc4_].pos;
               _loc5_.isBind = _loc2_.equipmets[_loc4_].isBind;
               _loc5_.join1 = _loc2_.equipmets[_loc4_].join1;
               _loc5_.join2 = _loc2_.equipmets[_loc4_].join2;
               _loc5_.join3 = _loc2_.equipmets[_loc4_].join3;
               _loc5_.join4 = _loc2_.equipmets[_loc4_].join4;
               _loc5_.isBinds = _loc2_.equipmets[_loc4_].isBind;
               _loc5_.randomSkill1 = _loc2_.equipmets[_loc4_].randomSkill1;
               _loc5_.randomSkill2 = _loc2_.equipmets[_loc4_].randomSkill2;
               _loc5_.randomSkill3 = _loc2_.equipmets[_loc4_].randomSkill3;
               _loc5_.randomSkill4 = _loc2_.equipmets[_loc4_].randomSkill4;
               _loc5_.randomSkill5 = _loc2_.equipmets[_loc4_].randomSkill5;
               _loc5_.mouldGrade = _loc2_.equipmets[_loc4_].mouldGrade;
               _loc7_.equipList.push(_loc5_);
               _loc4_++;
            }
            PetData.createWithMsg(_loc3_,_loc7_);
         }
         dispatchEvent(new RequestInfoEvent("QUERY_PETDATA_RESULT",0,null,_loc7_));
      }
      
      private function __receiveChildDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ChildData = null;
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerChildInfoMsg = new PlayerChildInfoMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as PlayerChildInfoMsg;
         for each(var _loc6_:ChildrenInfoMsg in _loc2_.child)
         {
            _loc5_ = new ChildData();
            _loc5_.userIdA = _loc6_.userIdA;
            _loc5_.isSelfData = false;
            _loc3_ = 0;
            while(_loc3_ < _loc6_.equipmets.length)
            {
               _loc4_ = new GoodsInfo();
               _loc4_.id = 1;
               _loc4_.templateId = _loc6_.equipmets[_loc3_].templateId;
               _loc4_.pos = _loc6_.equipmets[_loc3_].pos;
               _loc4_.isBind = _loc6_.equipmets[_loc3_].isBind;
               _loc4_.join1 = _loc6_.equipmets[_loc3_].join1;
               _loc4_.join2 = _loc6_.equipmets[_loc3_].join2;
               _loc4_.join3 = _loc6_.equipmets[_loc3_].join3;
               _loc4_.join4 = _loc6_.equipmets[_loc3_].join4;
               _loc4_.isBinds = _loc6_.equipmets[_loc3_].isBind;
               _loc4_.randomSkill1 = _loc6_.equipmets[_loc3_].randomSkill1;
               _loc4_.randomSkill2 = _loc6_.equipmets[_loc3_].randomSkill2;
               _loc4_.randomSkill3 = _loc6_.equipmets[_loc3_].randomSkill3;
               _loc4_.randomSkill4 = _loc6_.equipmets[_loc3_].randomSkill4;
               _loc4_.randomSkill5 = _loc6_.equipmets[_loc3_].randomSkill5;
               _loc4_.mouldGrade = _loc6_.equipmets[_loc3_].mouldGrade;
               _loc4_.strengthenGrade = _loc6_.equipmets[_loc3_].strengthenGrade;
               _loc4_.objectId = _loc5_.childId;
               _loc5_.equipList.push(_loc4_);
               _loc3_++;
            }
            _loc5_.createChildWithMsg(_loc6_,_loc5_);
         }
         dispatchEvent(new RequestInfoEvent("QUERY_CHILDDATA_RESULT",0,null,_loc5_));
      }
      
      private function __receiveEquipEnchantDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerEnchantMsg = new PlayerEnchantMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlayerEnchantMsg;
      }
      
      private function __transferCastleHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CastleReqMsg = new CastleReqMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CastleReqMsg;
         currentPlayerModel.mapNodeInfo.info.posX = _loc2_.posX;
         currentPlayerModel.mapNodeInfo.info.posY = _loc2_.posY;
         currentPlayerModel.mapNodeInfo.info.mapId = _loc2_.magId;
         currentPlayerModel.mapNodeInfo.info = currentPlayerModel.mapNodeInfo.info;
         var _loc3_:BuildInfo = BuildingManager.instance.model.buildingListByID[-11];
         _loc3_.property1 = _loc2_.leftEnergy;
         _loc3_.property2 = _loc2_.leftTime;
         _loc3_.loadTime = getTimer() / 1000;
         if(ArmyManager.instance.thane.grades >= 13)
         {
            GameBaseQueueManager.instance.addAction(new TransferOuterCityAction());
         }
         else
         {
            SceneManager.instance.setScene("OUTER_CITY_SCENE",null,true);
         }
         dispatchEvent(new ServiceReceiveEvent("TRANSEFER_CASTLE_SUCCESS",true,null));
      }
      
      private function __battleguardInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:BattleGuardSocketInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:HeroWatchMsg = new HeroWatchMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as HeroWatchMsg;
         var _loc3_:ThaneInfo = thane;
         _loc3_.beginChanges();
         if(!_loc3_.battleGuardInfo)
         {
            _loc3_.battleGuardInfo = new BattleGuardInfo();
         }
         for each(var _loc6_:WatchInfoMsg in _loc2_.watchInfo)
         {
            _loc4_ = _loc3_.battleGuardInfo.getSocketInfo(_loc6_.gridType,_loc6_.gridPos - 1);
            _loc4_.addItem(_loc6_.jion1,0);
            _loc4_.addItem(_loc6_.jion2,1);
            _loc4_.addItem(_loc6_.jion3,2);
            _loc4_.commit();
            if(_loc4_.state == 0)
            {
               _loc4_.state = 1;
               _loc3_.battleGuardInfo.dispatchEvent(new NotificationEvent("OPEN_BATTLEGUARD_ITEM",_loc4_));
            }
         }
         _loc3_.commit();
         currentPlayerModel.playerInfo.battleGuardInfo = _loc3_.battleGuardInfo;
      }
      
      public function sendAddBattleGem(param1:int, param2:int, param3:int, param4:GoodsInfo, param5:int) : void
      {
         var _loc9_:String = null;
         var _loc7_:Array = null;
         var _loc8_:BattleGuardSocketInfo = thane.battleGuardInfo.getSocketInfo(param1,param2);
         if(!_loc8_)
         {
            return;
         }
         var _loc11_:int = param4.templateInfo.Property1;
         if(param1 == 1)
         {
            if(_loc11_ != 100)
            {
               _loc9_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
            }
         }
         else
         {
            _loc7_ = [101,102,103,104,105,106];
            if(_loc7_.indexOf(_loc11_) < 0)
            {
               _loc9_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
            }
            else if(_loc8_.existSameGoods(param4.templateId,param3))
            {
               _loc9_ = LanguageMgr.GetTranslation("PlayerManager.sendAddBattleGemTip01");
            }
         }
         if(_loc9_)
         {
            MessageTipManager.instance().show(_loc9_);
            return;
         }
         var _loc10_:PackageOut = new PackageOut(8742);
         var _loc6_:HeroWatchOpMsg = new HeroWatchOpMsg();
         _loc6_.opType = 2;
         _loc6_.gridType = param1;
         _loc6_.gridPos = param2 + 1;
         _loc6_.itemPos = param4.pos;
         _loc6_.jionPos = param3 + 1;
         _loc6_.bagType = param5;
         SocketSendManager.instance.sendProtoBuffer(_loc10_,_loc6_);
      }
      
      public function sendRemoveBattleGem(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8742);
         var _loc4_:HeroWatchOpMsg = new HeroWatchOpMsg();
         _loc4_.opType = 3;
         _loc4_.gridType = param1;
         _loc4_.gridPos = param2 + 1;
         _loc4_.jionPos = param3 + 1;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendOpenBattleItem(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8742);
         var _loc4_:HeroWatchOpMsg = new HeroWatchOpMsg();
         _loc4_.opType = 1;
         _loc4_.gridType = param1;
         _loc4_.gridPos = param2 + 1;
         _loc4_.payType = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      private function __dragonSoulReqHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:FateListMsg = new FateListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as FateListMsg;
         var _loc5_:PlayerInfo = currentPlayerModel.playerInfo;
         _loc5_.beginChanges();
         for each(var _loc4_:FateInfoMsg in _loc2_.fateInfo)
         {
            if(_loc4_.fateTypes > _loc3_)
            {
               _loc3_ = _loc4_.fateTypes;
               _loc5_.dragonSoulType = _loc4_.fateTypes;
               _loc5_.dragonSoulGrade = _loc4_.grades;
               _loc5_.dragonSoulGp = Int64Utils.int64ToNumber(_loc4_.totalGp);
            }
         }
         _loc5_.commit();
      }
      
      private function __dragonSoulTransferHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ChatData = null;
         var _loc14_:SpaceArmy = null;
         var _loc7_:ThaneInfo = null;
         var _loc12_:Object = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as PropertyMsg;
         _loc2_.param1;
         _loc2_.param2;
         _loc2_.param3;
         _loc2_.param4;
         _loc2_.param5;
         var _loc6_:SimplePlayerInfo = new SimplePlayerInfo();
         var _loc10_:int = _loc2_.param1;
         var _loc13_:int = _loc2_.param2;
         _loc6_.vocationGrades = _loc2_.param3;
         var _loc8_:String = _loc2_.param4;
         var _loc15_:String = _loc2_.param5;
         if(_loc10_ == currentPlayerModel.playerInfo.userId)
         {
            currentPlayerModel.playerInfo.transfer();
            CheckUIModuleUtil.instance.tryCall("warlords",showFireworkCall,[0,5,5,3,20]);
         }
         var _loc3_:String = getVocationName(_loc13_,_loc6_.vocationStep,_loc6_.vocationLevel);
         var _loc4_:String = "<a t=\'1\' id=\'" + _loc10_ + "\' name=\'" + _loc8_ + "\' consortiaId=\'" + _loc15_ + "\' />";
         var _loc11_:String = LanguageMgr.GetTranslation("yishi.manager.PlayerManager.TransferTip01",_loc4_,_loc3_);
         _loc5_ = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc5_)
         {
            _loc5_.channel = 3;
            _loc5_.msg = _loc11_;
            _loc5_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc5_);
         }
         if(SpaceManager.instance.model)
         {
            _loc14_ = SpaceManager.instance.model.getUserArmyByUserId(_loc10_);
            if(_loc14_)
            {
               _loc12_ = SpaceManager.instance.controller.getArmyView(_loc14_);
               if(_loc12_)
               {
                  _loc12_["showDragonTransferEffect"]();
               }
               _loc7_ = _loc14_.baseHero;
               _loc7_.beginChanges();
               _loc7_.vocationGrades = _loc6_.vocationGrades;
               _loc7_.commit();
            }
         }
      }
      
      private function showFireworkCall(param1:Array) : void
      {
      }
      
      private function __dragonSoulTransferInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FateInfoMsg = new FateInfoMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as FateInfoMsg;
         var _loc4_:PlayerInfo = currentPlayerModel.playerInfo;
         _loc4_.beginChanges();
         _loc2_.templateId;
         _loc4_.vocationIndex = _loc2_.index;
         _loc4_.vocationGrades = _loc2_.grades;
         _loc4_.vocationGp = Int64Utils.int64ToNumber(_loc2_.totalGp);
         _loc4_.commit();
         var _loc3_:Boolean = thane.vocationIndex != _loc2_.index;
         thane.beginChanges();
         thane.vocationIndex = _loc2_.index;
         thane.vocationGrades = _loc2_.grades;
         thane.vocationGp = Int64Utils.int64ToNumber(_loc2_.totalGp);
         thane.commit();
         if(_loc3_ && thane.templateInfo)
         {
            thane.skillCate.initAllSkill(thane.templateInfo.Job);
            thane.talentData.initAllSkill(thane.templateInfo.Job);
            thane.dispatchEvent(new PlayerEvent("VOCATION_INDEX",null));
         }
      }
      
      public function sendDragonSoulFeed(param1:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(8641);
         var _loc2_:FateEditMsg = new FateEditMsg();
         _loc2_.useItemCount = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendHolyDragonSoulActive() : void
      {
         var _loc2_:PackageOut = new PackageOut(9689);
         var _loc1_:CommonMsg = new CommonMsg();
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendDragonSoulRequest() : void
      {
         var _loc1_:PackageOut = new PackageOut(8642);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function sendDragonSoulTransfer() : void
      {
         var _loc1_:PackageOut = new PackageOut(8643);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function sendAvengerTransfer() : void
      {
         var _loc1_:PackageOut = new PackageOut(8658);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function sendFourTransfer() : void
      {
         var _loc1_:PackageOut = new PackageOut(8663);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function sendSaveProcess(param1:int) : void
      {
         var _loc3_:PackageOut = null;
         var _loc2_:NoviceReqMsgMsg = null;
         if(param1 > 0 && param1 % 100 == 0)
         {
            PlayerManager.instance.newbieProcess = param1;
            _loc3_ = new PackageOut(5017);
            _loc2_ = new NoviceReqMsgMsg();
            _loc2_.noviceProcess = param1;
            SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
         }
      }
      
      public function getVocationName(param1:int, param2:int = 1, param3:int = 1) : String
      {
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc4_:String = "";
         if(param2 < 10)
         {
            _loc4_ += LanguageMgr.GetTranslation("yishi.manager.PlayerManager.VocationStep0" + param2);
         }
         else if(param2 == 10)
         {
            _loc4_ += LanguageMgr.GetTranslation("yishi.manager.PlayerManager.VocationStep" + param2);
         }
         if(param3 > 19)
         {
            _loc5_ = TempleteManager.instance.getTemplateByLevelAndType((param3 - 19) * 10,158);
            if(_loc5_)
            {
               _loc4_ += _loc5_.TemplateName.split("|")[param1 - 1];
            }
         }
         else if(param3 > 16)
         {
            _loc5_ = TempleteManager.instance.getTemplateByLevelAndType((param3 - 16) * 10,152);
            if(_loc5_)
            {
               _loc4_ += " " + _loc5_.TemplateName.split("|")[param1 - 1];
            }
         }
         else if(param3 > 8)
         {
            _loc5_ = TempleteManager.instance.getTemplateByLevelAndType((param3 - 8) * 10,110);
            if(_loc5_)
            {
               _loc4_ += _loc5_.TemplateName.split("|")[param1 - 1];
            }
         }
         else
         {
            _loc4_ += " " + LanguageMgr.GetTranslation("yishi.manager.PlayerManager.VocationJob" + param1 + "Level" + param3);
         }
         return _loc4_;
      }
      
      public function getShortVocationName(param1:int, param2:int = 1) : String
      {
         return LanguageMgr.GetTranslation("yishi.manager.PlayerManager.VocationJob" + param1 + "Level" + param2);
      }
      
      public function matchTransferCondition() : Boolean
      {
         var _loc1_:PlayerInfo = currentPlayerModel.playerInfo;
         if(thane.grades < 80)
         {
            return false;
         }
         if(_loc1_.vocationGrades > 0)
         {
            return false;
         }
         if(!TaskManage.instance.IsTaskFinish(757))
         {
            return false;
         }
         return true;
      }
      
      public function matchChangeJobCondition() : Boolean
      {
         var _loc1_:PlayerInfo = currentPlayerModel.playerInfo;
         if(thane.grades < 80)
         {
            return false;
         }
         if(_loc1_.vocationIndex > 0)
         {
            return false;
         }
         if(thane.talentData.talentGrade < 179 || thane.talentData.advTalentGrade < 50)
         {
            return false;
         }
         if(!TaskManage.instance.IsTaskFinish(1911))
         {
            return false;
         }
         return true;
      }
      
      public function isShowAvengerItem() : Boolean
      {
         var _loc1_:PlayerInfo = currentPlayerModel.playerInfo;
         if(TaskManage.instance.IsTaskFinish(1943) && !_loc1_.isAvenger)
         {
            return true;
         }
         return false;
      }
      
      public function isShowFourTransferItem() : Boolean
      {
         var _loc1_:PlayerInfo = currentPlayerModel.playerInfo;
         if(TaskManage.instance.IsTaskFinish(1964) && !_loc1_.isHoly)
         {
            return true;
         }
         return false;
      }
      
      public function getIsDragonTalkerState(param1:ThaneInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.bodyEquipAvata && param1.bodyEquipAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.armsEquipAvata && param1.armsEquipAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.bodyFashionAvata && param1.bodyFashionAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.armsFashionAvata && param1.armsFashionAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.hairFashionAvata && param1.hairFashionAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.wingAvata && param1.wingAvata.indexOf(PathManager.DRAGONIC) != -1)
         {
            return true;
         }
         return false;
      }
   }
}

