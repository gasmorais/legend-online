package yishi.lunch
{
   import battle.utils.Int64Utils;
   import com.pickgliss.loader.DisplayLoader;
   import com.road.yishi.proto.army.BaseCastleMsg;
   import com.road.yishi.proto.building.BuildingInfoListMsg;
   import com.road.yishi.proto.building.BuildingInfoMsg;
   import com.road.yishi.proto.farm.FarmInfoRspMsg;
   import com.road.yishi.proto.farm.FarmLandInfoMsg;
   import com.road.yishi.proto.farm.FarmLogRsp;
   import com.road.yishi.proto.farm.FarmPetInfoMsg;
   import com.road.yishi.proto.farm.FriendFarmStateMsg;
   import com.road.yishi.proto.farm.LoadFarmRsp;
   import com.road.yishi.proto.farm.TreeInfoMsg;
   import com.road.yishi.proto.pet.PetRankRewardMsg;
   import com.road.yishi.proto.player.ChallengeCoolTimeMsg;
   import com.road.yishi.proto.player.ChallengeRankRewardMsg;
   import com.road.yishi.proto.player.PlayerAASRefreshMsg;
   import com.road.yishi.proto.player.PlayerDataMsg;
   import com.road.yishi.proto.player.SystemPropertyMsg;
   import com.road.yishi.proto.player.TimeZoneMsg;
   import com.road.yishi.proto.player.VersionMsg;
   import com.road.yishi.proto.simple.FriendGroupMsg;
   import com.road.yishi.proto.simple.FriendRelationList;
   import com.road.yishi.proto.simple.RelationPlayerMsg;
   import com.road.yishi.proto.simple.SNSInfoMsg;
   import farm.FarmManager;
   import farm.data.FarmInfo;
   import farm.data.FarmLandInfo;
   import farm.data.FriendFarmStateInfo;
   import farm.data.PetLandInfo;
   import flash.utils.getTimer;
   import managers.DayGuideSocketOutManager;
   import managers.IMManager;
   import managers.PetChallengeManager;
   import map.internals.data.BaseCastle;
   import map.internals.data.PhysicInfo;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.buildings.BuildingModel;
   import mvc.module.friends.FriendGroupInfo;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.marry.MarryTreeInfo;
   import mvc.module.petchallenge.PetChallengeObjectData;
   import ui.queuebar.QueueBar;
   import water.data.WaterLogInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.playerinfo.TreeInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.WaterManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.community.RenameView;
   
   public class LoginInitDataAccept
   {
      
      private static var total:int = 9;
      
      private var _current:int;
      
      private var _callBack:Function;
      
      private var _time:Number;
      
      private var _setupIm:Boolean = false;
      
      public function LoginInitDataAccept()
      {
         super();
         addEvent();
      }
      
      public static function loginOverRequest() : void
      {
         var _loc1_:PlayerDataMsg = new PlayerDataMsg();
         _loc1_.quest = true;
         _loc1_.shop = true;
         _loc1_.active = true;
         _loc1_.challReward = true;
         _loc1_.switches = true;
         _loc1_.crossScoreReward = true;
         SocketSendManager.instance.loginDataReq(_loc1_);
      }
      
      private function addEvent() : void
      {
         FrameControllerManager.instance;
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4153,__loadCastleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4154,__loadBuildHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4156,__loadFriendListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4157,__loadFarmHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4160,__setSystemTime);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 362,__setTimeZone);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4173,__refreshIndygleTime);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4176,__colosseumTimeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4233,__versionHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4244,__challengeTakeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4245,__snsReqHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4481,__pvpTakeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4613,__petRankRewardHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4157,__loadFarmHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4154,__loadBuildHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4153,__loadCastleHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4156,__loadFriendListHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4160,__setSystemTime);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 362,__setTimeZone);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4173,__refreshIndygleTime);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4176,__colosseumTimeHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4233,__versionHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4245,__snsReqHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4613,__petRankRewardHandler);
      }
      
      private function __petRankRewardHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PetChallengeObjectData = null;
         var _loc3_:Object = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PetRankRewardMsg = new PetRankRewardMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PetRankRewardMsg;
         if(_loc2_.status == 0)
         {
            if(_loc2_.type == 2)
            {
               PlayerManager.instance.currentPlayerModel.playerInfo.canAcceptPetChallWeekReward = true;
               _loc4_ = new PetChallengeObjectData();
               _loc4_.ranking = _loc2_.rank;
               _loc3_ = {
                  "rank":_loc4_,
                  "type":[2]
               };
               PetChallengeManager.instance.model.weekInfo = _loc3_;
            }
         }
      }
      
      private function request() : void
      {
         var _loc1_:PlayerDataMsg = new PlayerDataMsg();
         _loc1_.army = true;
         _loc1_.castle = true;
         _loc1_.build = true;
         _loc1_.friend = true;
         _loc1_.snsReq = true;
         _loc1_.tree = true;
         _loc1_.aas = true;
         _loc1_.bag = true;
         _loc1_.leed = true;
         _loc1_.reward = true;
         _loc1_.smith = true;
         _loc1_.star = true;
         _loc1_.effect = true;
         _loc1_.tower = true;
         _loc1_.sys = true;
         _loc1_.offline = true;
         _loc1_.sweep = true;
         _loc1_.questionnarie = true;
         _loc1_.kingContract = true;
         _loc1_.rebateCharge = true;
         _loc1_.sumActive = true;
         _loc1_.appell = true;
         _loc1_.bottle = true;
         _loc1_.powcardInfo = true;
         _loc1_.petChallengeReward = true;
         _loc1_.christmas = true;
         SocketSendManager.instance.loginDataReq(_loc1_);
         DayGuideSocketOutManager.sendLeedClientUpdate(1);
      }
      
      public function losyBackCall(param1:Function) : void
      {
         _time = getTimer();
         _callBack = param1;
         request();
      }
      
      private function nextStup(param1:String) : void
      {
         _current = _current + 1;
         if(_current >= total)
         {
            removeEvent();
            checkNickName();
         }
      }
      
      private function checkNickName() : void
      {
         var _loc1_:String = PlayerManager.instance.currentPlayerModel.playerInfo.nickName;
         if(_loc1_.indexOf("!") != -1)
         {
            CheckUIModuleUtil.instance.tryCall("rename",renameUiCallback);
         }
         else
         {
            if(_callBack != null)
            {
               _callBack();
            }
            _callBack = null;
         }
      }
      
      private function renameUiCallback() : void
      {
         new RenameView(2,_callBack).show();
         var _loc1_:Class = DisplayLoader.Context.applicationDomain.getDefinition("loading.MaxLoading") as Class;
         if(_loc1_)
         {
            _loc1_.Instance.resetCursor();
         }
      }
      
      private function __challengeTakeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChallengeRankRewardMsg = new ChallengeRankRewardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChallengeRankRewardMsg;
         PlayerManager.instance.currentPlayerModel.playerInfo.isChallReward = _loc2_.isTake;
      }
      
      private function __snsReqHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SNSInfoMsg = new SNSInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SNSInfoMsg;
         if(_loc2_)
         {
            if(_loc2_.hasUserId)
            {
               thane.snsInfo.userId = _loc2_.userId;
            }
            if(_loc2_.hasNickname)
            {
               thane.snsInfo.nickName = _loc2_.nickname;
            }
            if(_loc2_.hasHeadId)
            {
               thane.snsInfo.headId = _loc2_.headId;
            }
            if(_loc2_.hasSignDesc)
            {
               thane.snsInfo.sign = _loc2_.signDesc;
            }
            if(_loc2_.hasSex)
            {
               thane.snsInfo.sex = _loc2_.sex;
            }
            if(_loc2_.hasBirthdayType)
            {
               thane.snsInfo.birthdayType = _loc2_.birthdayType;
            }
            if(_loc2_.hasBirthYear)
            {
               thane.snsInfo.birthYear = _loc2_.birthYear;
            }
            if(_loc2_.hasBirthMonth)
            {
               thane.snsInfo.birthMonth = _loc2_.birthMonth;
            }
            if(_loc2_.hasBirthDay)
            {
               thane.snsInfo.birthDay = _loc2_.birthDay;
            }
            if(_loc2_.hasStarId)
            {
               thane.snsInfo.horoscope = _loc2_.starId;
            }
            if(_loc2_.hasBloodType)
            {
               thane.snsInfo.bloodType = _loc2_.bloodType;
            }
            if(_loc2_.hasCountry)
            {
               thane.snsInfo.country = _loc2_.country;
            }
            if(_loc2_.hasProvince)
            {
               thane.snsInfo.province = _loc2_.province;
            }
            if(_loc2_.hasCity)
            {
               thane.snsInfo.city = _loc2_.city;
            }
         }
         nextStup("__snsReqHandler" + PlayerManager.instance.currentPlayerModel.playerInfo.showVersion.toString());
      }
      
      private function __pvpTakeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChallengeRankRewardMsg = new ChallengeRankRewardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChallengeRankRewardMsg;
         PlayerManager.instance.currentPlayerModel.playerInfo.beginChanges();
         PlayerManager.instance.currentPlayerModel.playerInfo.canAcceptCrossScoreAward = _loc2_.isTake;
         PlayerManager.instance.currentPlayerModel.playerInfo.commit();
      }
      
      private function __versionHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VersionMsg = new VersionMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VersionMsg;
         PlayerManager.instance.currentPlayerModel.playerInfo.showVersion = _loc2_.openVersion;
         PlayerManager.instance.currentPlayerModel.playerInfo.showStory = _loc2_.openStory;
         PlayerManager.instance.currentPlayerModel.playerInfo.showStoryModule = _loc2_.module;
         nextStup("__versionHandler：" + PlayerManager.instance.currentPlayerModel.playerInfo.showVersion.toString());
      }
      
      private function __setSystemTime(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SystemPropertyMsg = new SystemPropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SystemPropertyMsg;
         PlayerManager.instance.currentPlayerModel.sysSecond = Int64Utils.int64ToNumber(_loc2_.sysMillisecond) / 1000;
         PlayerManager.instance.currentPlayerModel.sysCurtime = DateFormatter.parse(_loc2_.sysCurtime,"YYYY-MM-DD hh:mm:ss");
         PlayerManager.instance.currentPlayerModel.sysStartTime = DateFormatter.parse(_loc2_.sysStarTime,"YYYY-MM-DD hh:mm:ss");
         nextStup("__setSystemTime：" + PlayerManager.instance.currentPlayerModel.sysCurtime.toString());
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      private function __setTimeZone(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TimeZoneMsg = new TimeZoneMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TimeZoneMsg;
         PlayerManager.instance.currentPlayerModel.castle_offset = _loc2_.castleOffset;
         PlayerManager.instance.currentPlayerModel.grand_world_offset = _loc2_.grandWorldOffset;
      }
      
      private function __refreshIndygleTime(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerAASRefreshMsg = new PlayerAASRefreshMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlayerAASRefreshMsg;
         PlayerManager.instance.currentPlayerModel.isInAAS = !_loc2_.isCloseAAS;
         PlayerManager.instance.currentPlayerModel.indulgeTime = _loc2_.aasOnlineTime;
         ConfigManager.info.AAS = _loc2_.sysSwitch;
         nextStup("__refreshIndygleTime：" + PlayerManager.instance.currentPlayerModel.indulgeTime.toString());
         NotificationManager.instance.sendNotification("UPDATE_INDYGLE_TIME");
      }
      
      private function __colosseumTimeHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChallengeCoolTimeMsg = new ChallengeCoolTimeMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ChallengeCoolTimeMsg;
         if(_loc2_.type == 1)
         {
            return;
         }
         var _loc5_:BuildingOrderInfo = new BuildingOrderInfo();
         _loc5_.remainTime = _loc2_.leftTime;
         _loc5_.totalCount = _loc2_.totalCount;
         _loc5_.currentCount = _loc2_.challengeCount;
         _loc5_.totalBuyCount = _loc2_.totalBuyCount;
         _loc5_.orderId = 10000;
         _loc5_.orderType = 4;
         BuildingManager.instance.model.colosseumOrderList.push(_loc5_);
         var _loc3_:BuildingOrderInfo = BuildingManager.instance.model.getActiveOrderById(6);
         _loc3_.currentCount = _loc2_.challengeCount;
         _loc3_.totalCount = _loc2_.totalCount;
         _loc3_.totalBuyCount = _loc2_.totalBuyCount;
         _loc3_.remainTime = _loc2_.leftTime;
         nextStup("__colosseumTimeHandler：" + _loc5_.remainTime.toString());
         QueueBar.instance;
      }
      
      private function __loadFriendListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:FriendItemCellInfo = null;
         var _loc8_:FriendGroupInfo = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:FriendRelationList = new FriendRelationList();
         _loc2_ = _loc9_.readBody(_loc2_) as FriendRelationList;
         var _loc6_:Array = [];
         var _loc4_:Array = [];
         for each(var _loc5_:RelationPlayerMsg in _loc2_.relationList)
         {
            _loc3_ = new FriendItemCellInfo();
            _loc3_.uuid = _loc5_.player.uuid;
            _loc3_.userId = _loc5_.player.userId;
            _loc3_.nickName = _loc5_.player.nickName;
            _loc3_.templateId = _loc5_.player.job;
            _loc3_.sexs = _loc5_.player.sexs;
            _loc3_.pics = _loc5_.player.pics;
            _loc3_.camp = _loc5_.player.camp;
            _loc3_.state = _loc5_.player.state;
            _loc3_.consortiaID = _loc5_.player.consortiaID;
            _loc3_.strategy = Int64Utils.int64ToNumber(_loc5_.player.strategy);
            _loc3_.consortiaName = _loc5_.player.consortiaName;
            _loc3_.consortiaOffer = _loc5_.player.consortiaOffer;
            _loc3_.consortiaTotalOffer = _loc5_.player.consortiaTotalOffer;
            _loc3_.claimId = _loc5_.player.claimId;
            _loc3_.claimName = _loc5_.player.claimName;
            _loc3_.grades = _loc5_.player.grades;
            _loc3_.gp = Int64Utils.int64ToNumber(_loc5_.player.gp);
            _loc3_.repute = _loc5_.player.repute;
            _loc3_.logOutTime = DateFormatter.parse(_loc5_.player.logOutTime,"YYYY-MM-DD hh:mm:ss");
            _loc3_.dutyId = _loc5_.player.dutyId;
            _loc3_.parameter1 = _loc5_.player.parameter1;
            _loc3_.playerOrdeInfo.gpOrder = _loc5_.player.gpOrder;
            _loc3_.fightingCapacity = _loc5_.player.fightingCapacity;
            _loc3_.matchWin = _loc5_.player.matchWin;
            _loc3_.matchFailed = _loc5_.player.matchFailed;
            _loc3_.right = _loc5_.player.right;
            _loc3_.relation = _loc5_.relation;
            _loc3_.groupId = _loc5_.groupId;
            _loc3_.type = 0;
            _loc3_.friendGp = _loc5_.friendRp;
            _loc3_.friendGrade = _loc5_.friendGrade;
            _loc3_.IsVipAndNoExpirt = _loc5_.isVip == 1 ? true : false;
            _loc3_.vocationGrades = _loc5_.transGrade;
            _loc3_.vocationIndex = _loc5_.changeBranch;
            if(_loc5_.snsInfo)
            {
               if(_loc5_.snsInfo.hasUserId)
               {
                  _loc3_.snsInfo.userId = _loc5_.snsInfo.userId;
               }
               if(_loc5_.snsInfo.hasNickname)
               {
                  _loc3_.snsInfo.nickName = _loc5_.snsInfo.nickname;
               }
               if(_loc5_.snsInfo.hasHeadId)
               {
                  _loc3_.snsInfo.headId = _loc5_.snsInfo.headId;
               }
               if(_loc5_.snsInfo.hasSignDesc)
               {
                  _loc3_.snsInfo.sign = _loc5_.snsInfo.signDesc;
               }
               if(_loc5_.snsInfo.hasSex)
               {
                  _loc3_.snsInfo.sex = _loc5_.snsInfo.sex;
               }
               if(_loc5_.snsInfo.hasBirthdayType)
               {
                  _loc3_.snsInfo.birthdayType = _loc5_.snsInfo.birthdayType;
               }
               if(_loc5_.snsInfo.hasBirthYear)
               {
                  _loc3_.snsInfo.birthYear = _loc5_.snsInfo.birthYear;
               }
               if(_loc5_.snsInfo.hasBirthMonth)
               {
                  _loc3_.snsInfo.birthMonth = _loc5_.snsInfo.birthMonth;
               }
               if(_loc5_.snsInfo.hasBirthDay)
               {
                  _loc3_.snsInfo.birthDay = _loc5_.snsInfo.birthDay;
               }
               if(_loc5_.snsInfo.hasStarId)
               {
                  _loc3_.snsInfo.horoscope = _loc5_.snsInfo.starId;
               }
               if(_loc5_.snsInfo.hasBloodType)
               {
                  _loc3_.snsInfo.bloodType = _loc5_.snsInfo.bloodType;
               }
               if(_loc5_.snsInfo.hasCountry)
               {
                  _loc3_.snsInfo.country = _loc5_.snsInfo.country;
               }
               if(_loc5_.snsInfo.hasProvince)
               {
                  _loc3_.snsInfo.province = _loc5_.snsInfo.province;
               }
               if(_loc5_.snsInfo.hasCity)
               {
                  _loc3_.snsInfo.city = _loc5_.snsInfo.city;
               }
            }
            _loc6_.push(_loc3_);
         }
         for each(var _loc7_:FriendGroupMsg in _loc2_.group)
         {
            _loc8_ = new FriendGroupInfo();
            _loc8_.groupId = _loc7_.groupId;
            _loc8_.groupName = _loc7_.groupName;
            _loc4_.push(_loc8_);
         }
         if(!_setupIm)
         {
            _setupIm = true;
            if(_loc2_.maxPage > 0)
            {
               total = total + _loc2_.maxPage - 1;
            }
            FriendManager.getInstance().setup(_loc6_,_loc4_);
            IMManager.instance.setup();
         }
         else
         {
            FriendManager.getInstance().addFriends(_loc6_,_loc4_);
         }
         nextStup("::" + _loc2_.maxPage + "__loadFriendListHandler : " + total + " ");
         _loc2_ = null;
         _loc9_ = null;
      }
      
      private function __loadFarmHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:FarmInfo = null;
         var _loc6_:FriendFarmStateInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:LoadFarmRsp = new LoadFarmRsp();
         _loc2_ = _loc5_.readBody(_loc2_) as LoadFarmRsp;
         if(_loc2_.farm && _loc2_.farm.treeInfo)
         {
            _loc3_ = FarmManager.instance.model.getFarmInfo(_loc2_.farm.userId);
            if(_loc3_)
            {
               readFarmInfoMsg(_loc3_,_loc2_.farm);
            }
            else
            {
               _loc3_ = new FarmInfo();
               readFarmInfoMsg(_loc3_,_loc2_.farm);
               FarmManager.instance.model.addFarmInfo(_loc3_);
            }
         }
         for each(var _loc4_:FriendFarmStateMsg in _loc2_.friendFarmState)
         {
            _loc6_ = FarmManager.instance.model.getFarmStateInfo(_loc4_.userId);
            _loc6_.canFarmSteal = _loc4_.isPlantReap;
            _loc6_.canPastureSteal = _loc4_.isAnimalReap;
            _loc6_.canGivePower = _loc4_.isChargeEnergy;
            _loc6_.canRevive = _loc4_.isRevive;
            _loc6_.canWorm = _loc4_.isWorm;
            _loc6_.canWeed = _loc4_.isGrass;
            _loc6_.canFeed = _loc4_.isFeed;
            _loc6_.canFeedLivestock = _loc4_.isFeedLivestock;
            _loc6_.canPacify = _loc4_.isPacify;
            _loc6_.canCure = _loc4_.isCure;
            _loc6_.isShow = true;
         }
         WaterManager.instance.setupList(readTreeLog(_loc2_.farmLog));
         _loc2_ = null;
         _loc5_ = null;
         nextStup("__loadWaterHandler");
      }
      
      private function readFarmInfoMsg(param1:FarmInfo, param2:FarmInfoRspMsg) : FarmInfo
      {
         var _loc7_:FarmLandInfo = null;
         var _loc3_:PetLandInfo = null;
         var _loc5_:MarryTreeInfo = null;
         if(!param1 || !param2)
         {
            return param1;
         }
         param1.userId = param2.userId;
         param1.nickName = param2.nickName;
         param1.grade = param2.grades;
         param1.landGrade = param2.landGrades;
         param1.gp = param2.gp;
         param1.dayGpFromFriend = param2.todayFromFriendGp;
         param1.dayStealCount = param2.todayStolenCount;
         for each(var _loc6_:FarmLandInfoMsg in param2.farmLandInfo)
         {
            _loc7_ = param1.getLandInfo(_loc6_.pos);
            if(_loc7_)
            {
               readLandInfoMsg(_loc7_,_loc6_);
            }
            else
            {
               _loc7_ = new FarmLandInfo();
               readLandInfoMsg(_loc7_,_loc6_);
               param1.addLandInfo(_loc7_);
            }
         }
         for each(var _loc4_:FarmPetInfoMsg in param2.petInfo)
         {
            _loc3_ = param1.getPetLandInfo(_loc4_.pos);
            if(!_loc3_)
            {
               _loc3_ = new PetLandInfo();
            }
            _loc3_ = readPetInfoMsg(_loc3_,_loc4_);
            param1.addPetLandInfo(_loc3_);
         }
         var _loc8_:PetLandInfo = new PetLandInfo();
         _loc8_ = readPetInfoMsg(_loc8_,param2.guardPetInfo);
         if(_loc8_.petId != 0)
         {
            param1.defender = _loc8_;
         }
         else
         {
            param1.defender = null;
         }
         param1.treeInfo = WaterManager.instance.treeList[param2.treeInfo.userId];
         if(param1.treeInfo)
         {
            readTreeInfoMsg(param1.treeInfo,param2.treeInfo);
         }
         else
         {
            param1.treeInfo = new TreeInfo();
            readTreeInfoMsg(param1.treeInfo,param2.treeInfo);
            WaterManager.instance.treeList[param2.treeInfo.userId] = param1.treeInfo;
         }
         if(param2.marriageTree)
         {
            _loc5_ = new MarryTreeInfo();
            _loc5_.userIdA = param2.marriageTree.userIdA;
            _loc5_.nickNameA = param2.marriageTree.nickNameA;
            _loc5_.jobA = param2.marriageTree.jobA;
            _loc5_.userIdB = param2.marriageTree.userIdB;
            _loc5_.nickNameB = param2.marriageTree.nickNameB;
            _loc5_.jobB = param2.marriageTree.jobB;
            _loc5_.stateValue = param2.marriageTree.stateValue;
            _loc5_.feedCount = param2.marriageTree.feedCount;
            _loc5_.startString = param2.marriageTree.startTime;
            _loc5_.endString = param2.marriageTree.endTime;
            _loc5_.trainACount = param2.marriageTree.trainACount;
            _loc5_.trainBCount = param2.marriageTree.trainBCount;
            _loc5_.trainAType = param2.marriageTree.trainAType;
            _loc5_.trainBType = param2.marriageTree.trainBType;
            _loc5_.isGetA = param2.marriageTree.isGetA;
            _loc5_.isGetB = param2.marriageTree.isGetB;
            _loc5_.treeState = param2.marriageTree.treeState;
            param1.marryTreeInfo = _loc5_;
            if(playerInfo.userId == _loc5_.userIdA || playerInfo.userId == _loc5_.userIdB)
            {
               MsgMan.notifyObserver("MarryEventType.TREE_UPDATE",param1.marryTreeInfo);
            }
         }
         return param1;
      }
      
      private function readLandInfoMsg(param1:FarmLandInfo, param2:FarmLandInfoMsg) : FarmLandInfo
      {
         if(!param1 || !param2)
         {
            return param1;
         }
         param1.beginChanges();
         if(param2.hasUserId)
         {
            param1.userId = param2.userId;
         }
         if(param2.hasType)
         {
            param1.type = param2.type;
         }
         if(param2.hasPos)
         {
            param1.pos = param2.pos;
         }
         if(param2.hasItemTemplateId)
         {
            param1.item_template_id = param2.itemTemplateId;
         }
         if(param2.hasAddTime)
         {
            param1.add_time = DateFormatter.parse(param2.addTime,"YYYY-MM-DD hh:mm:ss");
         }
         if(param2.hasFeedTime)
         {
            param1.feed_time = DateFormatter.parse(param2.feedTime,"YYYY-MM-DD hh:mm:ss");
         }
         if(param2.hasMatureTime)
         {
            param1.mature_time = DateFormatter.parse(param2.matureTime,"YYYY-MM-DD hh:mm:ss");
         }
         if(param2.hasCropState)
         {
            param1.crop_state = param2.cropState;
         }
         if(param2.hasAccelerateCount)
         {
            param1.accelerate_count = param2.accelerateCount;
         }
         if(param2.hasStolenCount)
         {
            param1.stolenCount = param2.stolenCount;
         }
         if(param2.hasIsWorm)
         {
            param1.is_worm = param2.isWorm;
         }
         if(param2.hasIsGrass)
         {
            param1.is_grass = param2.isGrass;
         }
         if(param2.hasIsGloomy)
         {
            param1.is_gloomy = param2.isGloomy;
         }
         if(param2.hasIsIll)
         {
            param1.is_ill = param2.isIll;
         }
         if(param2.hasIsCanReap)
         {
            param1.is_can_reap = param2.isCanReap;
         }
         if(param2.hasIsHunger)
         {
            param1.is_hunger = param2.isHunger;
         }
         if(param2.hasStolenCount)
         {
            param1.stolenList = param2.stolenUsers;
         }
         if(param2.hasRewardCount)
         {
            param1.reward_count = param2.rewardCount;
         }
         if(param2.hasOpType)
         {
            param1.op_type = param2.opType;
         }
         if(param2.hasResult)
         {
            param1.result = param2.result;
         }
         if(param2.hasParam1)
         {
            param1.param1 = param2.param1;
         }
         if(param2.hasParam2)
         {
            param1.param2 = param2.param2;
         }
         param1.commitChanges();
         return param1;
      }
      
      private function readPetInfoMsg(param1:PetLandInfo, param2:FarmPetInfoMsg) : PetLandInfo
      {
         if(!param1 || !param2)
         {
            return param1;
         }
         param1.userId = param2.userId;
         param1.petId = param2.petId;
         param1.name = param2.petName;
         if(param2.quality < 26)
         {
            param1.quality = (param2.quality - 1) / 5 + 1;
         }
         else
         {
            param1.quality = (param2.quality - 1) / 5;
         }
         param1.pos = param2.pos;
         param1.petTemplateId = param2.petTemplateId;
         param1.beginTime = param2.beginTime;
         param1.endTime = param2.endTime;
         param1.lastFeedRegion = param2.state;
         return param1;
      }
      
      private function readTreeInfoMsg(param1:TreeInfo, param2:TreeInfoMsg) : TreeInfo
      {
         if(!param1 || !param2)
         {
            return param1;
         }
         param1.userId = param2.userId;
         param1.nickName = param2.nickName;
         param1.waterCount = param2.waterCount;
         param1.fruitCount = param2.fruitCount;
         param1.isFirstFruit = param2.isFirstFruit;
         param1.nextPickTime = DateFormatter.parse(param2.nextPickTime,"YYYY-MM-DD hh:mm:ss");
         param1.lastWaterTime = DateFormatter.parse(param2.lastWaterTime,"YYYY-MM-DD hh:mm:ss");
         param1.property1 = param2.property1;
         param1.property2 = param2.property2;
         param1.notHasTree = false;
         if(param1.userId == thane.userId)
         {
            param1.timeLeft = param2.leftTime;
            param1.leftpickTime = param2.leftPickTime;
         }
         return param1;
      }
      
      private function readTreeLog(param1:Array) : Array
      {
         var _loc3_:WaterLogInfo = null;
         var _loc2_:Array = [];
         for each(var _loc4_:FarmLogRsp in param1)
         {
            _loc3_ = new WaterLogInfo();
            _loc3_.type = _loc4_.type;
            _loc3_.userId = _loc4_.playerId;
            _loc3_.actionDes = _loc4_.desc;
            _loc3_.nickName = _loc4_.operNickName;
            _loc3_.time = DateFormatter.parse(_loc4_.operDate,"YYYY-MM-DD hh:mm:ss");
            _loc3_.waterUserId = _loc4_.operUserId;
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      private function __loadCastleHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:BaseCastleMsg = new BaseCastleMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as BaseCastleMsg;
         var _loc5_:BaseCastle = PlayerManager.instance.currentPlayerModel.mapNodeInfo;
         var _loc3_:PhysicInfo = new PhysicInfo();
         _loc5_.defenceLeftTime = _loc2_.defenceLefttime;
         _loc3_.id = _loc2_.id;
         _loc3_.mapId = _loc2_.mapId;
         _loc3_.occupyLeagueName = _loc2_.occupyLeagueName;
         _loc3_.occupyPlayerId = _loc2_.occupyPlayerId;
         _loc3_.occupyPlayerName = _loc2_.occupyPlayerName;
         _loc3_.posX = _loc2_.posX;
         _loc3_.posY = _loc2_.posY;
         _loc3_.state = _loc2_.state;
         _loc3_.types = _loc2_.type;
         _loc3_.names = _loc2_.castleName;
         _loc3_.grade = _loc2_.grade;
         _loc3_.vipCastleView = _loc2_.vipCastleView;
         _loc3_.vipType = _loc2_.vipType;
         _loc5_.info = _loc3_;
         nextStup("__loadCastleHandler");
         var _loc4_:BuildInfo = new BuildInfo();
         _loc4_.buildingId = -11;
         _loc4_.templateId = 151101;
         _loc4_.property1 = _loc2_.leftEnergy;
         BuildingManager.instance.model.addBuildInfo(_loc4_);
         _loc2_ = null;
         _loc6_ = null;
      }
      
      private function __loadBuildHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc8_:BuildInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:BuildingInfoListMsg = new BuildingInfoListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as BuildingInfoListMsg;
         var _loc5_:BuildingModel = BuildingManager.instance.model;
         var _loc3_:Boolean = _loc2_.result;
         for each(var _loc4_:BuildingInfoMsg in _loc2_.building)
         {
            _loc6_ = _loc4_.buildingId;
            _loc8_ = new BuildInfo();
            _loc8_.buildingId = _loc4_.buildingId;
            _loc8_.templateId = _loc4_.templateId;
            _loc8_.property1 = _loc4_.propterty1;
            _loc8_.property2 = _loc4_.propterty2;
            _loc8_.loadTime = getTimer() / 1000;
            _loc8_.sonType = _loc4_.sonType;
            _loc5_.addBuildInfo(_loc8_);
         }
         _loc2_ = null;
         _loc7_ = null;
         nextStup("__loadBuildHandler");
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

