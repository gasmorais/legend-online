package farm
{
   import chat.datas.ChatData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectPool;
   import com.road.yishi.proto.children.BonfireEventMsg;
   import com.road.yishi.proto.children.ChildrenOpMsg;
   import com.road.yishi.proto.children.HomeMsg;
   import com.road.yishi.proto.children.ShowMountMsg;
   import com.road.yishi.proto.farm.FarmInfoRspMsg;
   import com.road.yishi.proto.farm.FarmLandInfoMsg;
   import com.road.yishi.proto.farm.FarmOperReqMsg;
   import com.road.yishi.proto.farm.FarmPetInfoMsg;
   import com.road.yishi.proto.farm.FriendFarmStateMsg;
   import com.road.yishi.proto.farm.FriendUserIdsMsg;
   import com.road.yishi.proto.farm.LoadFarmRsp;
   import com.road.yishi.proto.farm.TreeInfoMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import farm.data.FarmInfo;
   import farm.data.FarmLandInfo;
   import farm.data.FriendFarmStateInfo;
   import farm.data.PetLandInfo;
   import farm.data.ShowMountMsgInfo;
   import farm.vo.FarmAnimationVO;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.marry.MarryTreeInfo;
   import water.events.WaterEvent;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.playerinfo.TreeInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.WaterManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   
   public class FarmManager
   {
      
      private static var _instance:FarmManager;
      
      public static const SIT_DOWN:int = 11;
      
      public static const RANDOM_NUN:int = 12;
      
      public static const SHOW_MOUNT:int = 13;
      
      public static const ENTER_COURTYARD:int = 1002;
      
      public static const INVIDE_FIRENDS:int = 1006;
      
      public static const RESPOND_INVIDE:int = 1007;
      
      public static const FEED_FLAG:int = 1000;
      
      private var _model:FarmModel;
      
      private var _needTipNext:Boolean = true;
      
      private var _bagFrame:Frame;
      
      public function FarmManager()
      {
         super();
      }
      
      public static function get instance() : FarmManager
      {
         if(!_instance)
         {
            _instance = new FarmManager();
         }
         return _instance;
      }
      
      public function get model() : FarmModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new FarmModel();
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4386,__getFarmInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4387,__farmlandUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4969,_onfarmOpHandler);
         PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4753,__homeInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4982,onFarmBonCd);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4190,__getFriendFarmStateHandler);
      }
      
      private function __homeInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:ShowMountMsg = null;
         var _loc4_:ShowMountMsgInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:HomeMsg = new HomeMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as HomeMsg;
         if(_loc2_.hasIsBigBonfire)
         {
            model.isBigBonfire = _loc2_.isBigBonfire;
         }
         if(_loc2_.tarUserId > 0)
         {
            model.masterId = _loc2_.tarUserId;
         }
         model.showMountMsgInfo = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.showMount.length)
         {
            _loc3_ = _loc2_.showMount[_loc5_];
            _loc4_ = new ShowMountMsgInfo();
            _loc4_.pos = _loc3_.pos;
            _loc4_.templateId = _loc3_.templateId;
            _loc4_.starlevel = _loc3_.starlevel;
            _loc4_.isValid = _loc3_.isValid;
            model.showMountMsgInfo.push(_loc4_);
            _loc5_++;
         }
         model.dispatchEvent(new Event("FARM_HOME_INFO"));
      }
      
      private function onFarmBonCd(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HomeMsg = new HomeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HomeMsg;
         if(_loc2_.hasLeftTime)
         {
            model.leftTime = _loc2_.leftTime;
         }
         if(_loc2_.hasBeginLeftTime)
         {
            model.beginLeftTime = _loc2_.beginLeftTime;
         }
      }
      
      private function __getFarmInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FarmInfoRspMsg = new FarmInfoRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as FarmInfoRspMsg;
         var _loc4_:FarmInfo = model.getFarmInfo(_loc2_.userId);
         readFarmInfoMsg(_loc4_,_loc2_);
         model.dispatchEvent(new Event("FARM_CURRENT_USER_CHANGE"));
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
         param1.dayGpFromFriend = param2.todayFromFriendGp;
         param1.dayStealCount = param2.todayStolenCount;
         for each(var _loc6_:FarmLandInfoMsg in param2.farmLandInfo)
         {
            if(_loc6_.pos < 1000)
            {
               _loc7_ = param1.getLandInfo(_loc6_.pos);
               if(!_loc7_)
               {
                  _loc7_ = new FarmLandInfo();
               }
               readLandInfoMsg(_loc7_,_loc6_);
               param1.addLandInfo(_loc7_);
            }
            else
            {
               _loc7_ = param1.getAnimalInfo(_loc6_.pos);
               if(!_loc7_)
               {
                  _loc7_ = new FarmLandInfo();
               }
               readLandInfoMsg(_loc7_,_loc6_);
               param1.addAnimalInfo(_loc7_);
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
         param1.grade = param2.grades;
         param1.landGrade = param2.landGrades;
         param1.gp = param2.gp;
         if(param2.treeInfo)
         {
            param1.treeInfo = waterManager.treeList[param2.treeInfo.userId];
         }
         if(!param1.treeInfo)
         {
            param1.treeInfo = new TreeInfo();
         }
         readTreeInfoMsg(param1.treeInfo,param2.treeInfo);
         if(param2.treeInfo)
         {
            waterManager.treeList[param2.treeInfo.userId] = param1.treeInfo;
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
            _loc5_.feedId = param2.marriageTree.feedUser;
            param1.marryTreeInfo = _loc5_;
            MsgMan.notifyObserver("MarryEventType.TREE_UPDATE",param1.marryTreeInfo);
         }
         return param1;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
         waterManager.dispatchEvent(new WaterEvent("TREE_UPDATE",param1));
         return param1;
      }
      
      private function __farmlandUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:FarmInfo = null;
         var _loc9_:FarmLandInfo = null;
         var _loc6_:PropertyMsg = null;
         var _loc7_:PetLandInfo = null;
         var _loc10_:PetLandInfo = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:FarmInfoRspMsg = new FarmInfoRspMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as FarmInfoRspMsg;
         if(_loc2_.hasUserId)
         {
            _loc3_ = model.getFarmInfo(_loc2_.userId);
         }
         if(_loc3_ == null)
         {
            _loc3_ = model.curSelectedFarmInfo;
         }
         if(_loc3_ == null)
         {
            model.curSelectedUserInfo = thane;
            _loc3_ = model.myFarm;
         }
         if(_loc3_ == null)
         {
            model.curSelectedUserInfo = null;
            return;
         }
         for each(var _loc5_:FarmLandInfoMsg in _loc2_.farmLandInfo)
         {
            if(_loc3_.userId == _loc5_.userId)
            {
               if(_loc5_.pos < 1000)
               {
                  _loc9_ = _loc3_.getLandInfo(_loc5_.pos);
                  if(!_loc9_)
                  {
                     _loc9_ = new FarmLandInfo();
                  }
                  readLandInfoMsg(_loc9_,_loc5_);
                  _loc3_.addLandInfo(_loc9_);
               }
               else
               {
                  _loc9_ = _loc3_.getAnimalInfo(_loc5_.pos);
                  if(!_loc9_)
                  {
                     _loc9_ = new FarmLandInfo();
                  }
                  readLandInfoMsg(_loc9_,_loc5_);
                  _loc3_.addAnimalInfo(_loc9_);
               }
               if(_loc5_.hasParam1 && _loc5_.hasParam2)
               {
                  _loc6_ = new PropertyMsg();
                  _loc6_.param6 = _loc5_.param1;
                  if(_loc5_.param2)
                  {
                     _loc6_.param7 = !ApplicationDomain.currentDomain.hasDefinition(_loc5_.param2);
                  }
                  SocketSendManager.instance.sendMsg(_loc6_);
               }
            }
         }
         for each(var _loc4_:FarmPetInfoMsg in _loc2_.petInfo)
         {
            if(_loc3_.userId == _loc4_.userId)
            {
               _loc7_ = _loc3_.getPetLandInfo(_loc4_.pos);
               if(!_loc7_)
               {
                  _loc7_ = new PetLandInfo();
               }
               _loc7_ = readPetInfoMsg(_loc7_,_loc4_);
               _loc3_.addPetLandInfo(_loc7_);
               _loc7_.commit();
            }
         }
         if(_loc2_.hasGuardPetInfo)
         {
            _loc10_ = new PetLandInfo();
            _loc10_ = readPetInfoMsg(_loc10_,_loc2_.guardPetInfo);
            if(_loc10_.petId != 0)
            {
               _loc3_.defender = _loc10_;
            }
            else
            {
               _loc3_.defender = null;
            }
         }
         updateFriendFarmStateInfo(_loc3_);
      }
      
      private function updateFriendFarmStateInfo(param1:FarmInfo) : void
      {
         var _loc2_:Boolean = false;
         for each(var _loc3_:PetLandInfo in param1.getPetLandList())
         {
            if(_loc3_.canFeed())
            {
               _loc2_ = true;
            }
         }
         var _loc4_:FriendFarmStateInfo = FarmManager.instance.model.getFarmStateInfo(param1.userId);
         if(_loc4_)
         {
            _loc4_.beginChanges();
            _loc4_.canFeed = _loc2_;
            _loc4_.commitChanges();
         }
      }
      
      private function __getFriendFarmStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:FriendFarmStateMsg = null;
         var _loc6_:FriendFarmStateInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:LoadFarmRsp = new LoadFarmRsp();
         _loc2_ = _loc5_.readBody(_loc2_) as LoadFarmRsp;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.friendFarmState.length)
         {
            _loc3_ = _loc2_.friendFarmState[_loc4_];
            if(playerInfo.userId != _loc3_.userId)
            {
               _loc6_ = FarmManager.instance.model.getFarmStateInfo(_loc3_.userId);
               _loc6_.beginChanges();
               _loc6_.canFarmSteal = _loc3_.isPlantReap;
               _loc6_.canPastureSteal = _loc3_.isAnimalReap;
               _loc6_.canGivePower = _loc3_.isChargeEnergy;
               _loc6_.canRevive = _loc3_.isRevive;
               _loc6_.canWorm = _loc3_.isWorm;
               _loc6_.canWeed = _loc3_.isGrass;
               _loc6_.canFeed = _loc3_.isFeed;
               _loc6_.canFeedLivestock = _loc3_.isFeedLivestock;
               _loc6_.canPacify = _loc3_.isPacify;
               _loc6_.canCure = _loc3_.isCure;
               _loc6_.isShow = true;
               _loc6_.commitChanges();
            }
            _loc4_++;
         }
      }
      
      private function inSpecialCampaign() : Boolean
      {
         var _loc1_:int = 0;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            if(CampaignManager.instance.mapModel)
            {
               _loc1_ = CampaignManager.instance.mapModel.mapId;
               if(WorldBossHelper.checkPetLand(_loc1_) || WorldBossHelper.checkMineral(_loc1_))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function inCastle() : Boolean
      {
         return SceneManager.instance.currentType == "CASTLE_SCENE";
      }
      
      private function inSpace() : Boolean
      {
         return SceneManager.instance.currentType == "SPACE_SCENE";
      }
      
      private function __timeUpdateHandler(param1:PlayerEvent) : void
      {
      }
      
      private function checkIsSelf(param1:int) : Boolean
      {
         return param1 == thane.userId;
      }
      
      public function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get waterManager() : WaterManager
      {
         return WaterManager.instance;
      }
      
      public function sendReqFarmInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(15044);
         var _loc2_:FarmOperReqMsg = new FarmOperReqMsg();
         _loc2_.opType = 0;
         _loc2_.friendId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendReqAutoPick(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(15044);
         var _loc3_:FarmOperReqMsg = new FarmOperReqMsg();
         _loc3_.opType = param1;
         _loc3_.friendId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendFarmOper(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:Boolean = true) : void
      {
         var _loc8_:PackageOut = new PackageOut(15044);
         var _loc7_:FarmOperReqMsg = new FarmOperReqMsg();
         _loc7_.friendId = param1;
         _loc7_.opType = param2;
         _loc7_.pos = param3;
         _loc7_.bagPos = param4;
         _loc7_.templateId = param5;
         _loc7_.payType = 0;
         if(!param6)
         {
            _loc7_.payType = 1;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc8_,_loc7_);
         FarmManager.instance.reqFriendFarmState([param1]);
      }
      
      public function reqFriendFarmState(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(8231);
         var _loc2_:FriendUserIdsMsg = new FriendUserIdsMsg();
         if(param1.length == 0)
         {
            param1.push(0);
         }
         _loc2_.friendId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function get checkHasPick() : int
      {
         var _loc1_:FarmInfo = model.myFarm;
         if(!_loc1_)
         {
            return 0;
         }
         for each(var _loc2_:FarmLandInfo in _loc1_.getLandList())
         {
            if(_loc2_.cropPhase == 3)
            {
               return 1;
            }
         }
         for each(var _loc3_:FarmLandInfo in _loc1_.animalList)
         {
            if(_loc3_.cropPhase == 3)
            {
               return 2;
            }
         }
         return 0;
      }
      
      public function get checkHasPickPet() : Boolean
      {
         var _loc2_:FarmInfo = model.myFarm;
         if(!_loc2_)
         {
            return false;
         }
         var _loc3_:Array = _loc2_.getPetLandList();
         for each(var _loc1_:PetLandInfo in _loc3_)
         {
            if(_loc1_.canGains())
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkExistSpecialCrop(param1:FarmInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         for each(var _loc2_:FarmLandInfo in param1.getLandList())
         {
            if(_loc2_.hasCrop && _loc2_.cropTemp && _loc2_.cropTemp.Property5 > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkExistSameSpecialCrop(param1:GoodsTemplateInfo, param2:FarmInfo) : Boolean
      {
         if(!param2 || !param1)
         {
            return false;
         }
         for each(var _loc3_:FarmLandInfo in param2.getLandList())
         {
            if(_loc3_.hasCrop && _loc3_.cropTemp && _loc3_.cropTemp.Property5 > 0 && _loc3_.cropTemp.Property5 == param1.Property5)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkExistEmptyLand(param1:FarmInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         for each(var _loc2_:FarmLandInfo in param1.getLandList())
         {
            if(!_loc2_.hasCrop)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkHasOperNow(param1:FarmLandInfo, param2:int) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         var _loc3_:Boolean = false;
         switch(param2 - 2)
         {
            case 0:
               if(param1.is_worm)
               {
                  _loc3_ = true;
               }
               break;
            case 1:
               if(param1.is_grass)
               {
                  _loc3_ = true;
               }
               break;
            case 2:
               if(param1.is_gloomy)
               {
                  _loc3_ = true;
               }
               break;
            case 3:
               if(param1.is_ill)
               {
                  _loc3_ = true;
               }
               break;
            case 5:
               if(param1.is_hunger)
               {
                  _loc3_ = true;
               }
               break;
            case 6:
               if(param1.isDie)
               {
                  _loc3_ = true;
               }
               break;
            case 12:
               if(param1.is_can_reap && param1.canBeStolen == "")
               {
                  _loc3_ = true;
               }
               if(param1.isDie)
               {
                  _loc3_ = false;
               }
               if(param1.is_worm)
               {
                  _loc3_ = false;
               }
               if(param1.is_grass)
               {
                  _loc3_ = false;
               }
               if(param1.is_ill)
               {
                  _loc3_ = false;
               }
               if(param1.is_gloomy)
               {
                  _loc3_ = false;
               }
         }
         return _loc3_;
      }
      
      public function updateFarmStateByType(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:FriendFarmStateInfo = model.getFarmStateInfo(param1);
         _loc4_.beginChanges();
         switch(param2 - 2)
         {
            case 0:
               _loc4_.canWorm = param3;
               break;
            case 2:
               _loc4_.canPacify = param3;
               break;
            case 3:
               _loc4_.canCure = param3;
               break;
            case 5:
               _loc4_.canFeedLivestock = param3;
               break;
            case 6:
               _loc4_.canRevive = param3;
               break;
            case 12:
               if(FarmManager.instance.model.currentHomeFrameType == 1)
               {
                  _loc4_.canFarmSteal = param3;
               }
               else if(FarmManager.instance.model.currentHomeFrameType == 2)
               {
                  _loc4_.canPastureSteal = param3;
               }
         }
         _loc4_.commitChanges();
      }
      
      public function addChatTip(param1:int, param2:int, param3:int, param4:String, param5:String, param6:int) : void
      {
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc8_:ThaneInfo = null;
         var _loc7_:String = "";
         var _loc12_:String = param6 > 0 ? LanguageMgr.GetTranslation("farm.FarmManager.expAddTip",param6) : "";
         switch(param1 - 1)
         {
            case 0:
               switch(param2 - 2)
               {
                  case 0:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.wormTip1",_loc12_);
                     break;
                  case 1:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.weedTip1",_loc12_);
                     break;
                  case 2:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.pacifyTip",_loc12_);
                     break;
                  case 3:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.cureTip",_loc12_);
                     break;
                  case 5:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.animalFeedTip",_loc12_);
               }
               break;
            case 1:
               _loc8_ = FriendManager.getInstance().getFriendById(param3);
               if(_loc8_)
               {
                  _loc10_ = _loc8_.nickName;
                  _loc11_ = _loc8_.consortiaID;
               }
               else
               {
                  _loc10_ = "";
                  _loc11_ = 0;
               }
               _loc10_ = "<a t=\'1\' id=\'" + param3 + "\'" + " name=\'" + _loc10_ + "\'" + " consortiaId=\'" + _loc11_ + "\'/>";
               switch(param2 - 2)
               {
                  case 0:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.wormTip2",_loc12_);
                     break;
                  case 1:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.weedTip2",_loc12_);
                     break;
                  case 2:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.pacifyTip",_loc12_);
                     break;
                  case 3:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.cureTip",_loc12_);
                     break;
                  case 5:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.animalFeedTip",_loc12_);
                     break;
                  case 6:
                     _loc7_ = LanguageMgr.GetTranslation("farm.FarmManager.reviveTip2",_loc12_);
               }
         }
         if(_loc7_ == "")
         {
            return;
         }
         var _loc9_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc9_.channel = 3;
         _loc9_.msg = _loc7_;
         _loc9_.commit();
         NotificationManager.instance.sendNotification("ADD_CHAT",_loc9_);
      }
      
      public function invideFirends(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 1006;
         _loc2_.inviteFriendids = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function respondInvide(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8873);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 1007;
         _loc3_.property1 = param1;
         _loc3_.property5 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function randomNum() : void
      {
         var _loc2_:PackageOut = new PackageOut(8873);
         var _loc1_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc1_.opType = 12;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sitDown() : void
      {
         var _loc2_:PackageOut = new PackageOut(8873);
         var _loc1_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc1_.opType = 11;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      private function _onfarmOpHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:CampaignArmy = null;
         var _loc3_:FarmAnimationVO = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:BonfireEventMsg = new BonfireEventMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as BonfireEventMsg;
         switch(_loc2_.eventType - 1)
         {
            case 0:
               try
               {
                  _loc4_ = CampaignManager.instance.mapModel.allUserArmy["_" + _loc2_.userId];
                  _loc4_.baseHero.changeShapeId = _loc2_.value;
                  _loc4_.commit();
                  if(isSelf(_loc4_.baseHero.userId))
                  {
                     thane.changeShapeId = _loc2_.value;
                     thane.commit();
                  }
               }
               catch(e:Error)
               {
               }
               break;
            case 1:
               _loc3_ = new FarmAnimationVO();
               _loc3_.armyId = _loc2_.userId;
               _loc3_.name = _loc2_.userName;
               _loc3_.value0 = int(_loc2_.value.toString().charAt(1));
               _loc3_.value1 = int(_loc2_.value.toString().charAt(2));
               NotificationManager.instance.sendNotification("FARM_ARMY_ANIMATION",_loc3_);
               break;
            case 2:
               sitDownArmy(_loc2_.userId);
         }
      }
      
      public function showMount(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8873);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 13;
         _loc2_.property1 = model.currentMountPos;
         _loc2_.property2 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      private function sitDownArmy(param1:int) : void
      {
         var _loc2_:CampaignArmy = CampaignManager.instance.mapModel.allUserArmy["_" + param1];
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.isSitDown = true;
         _loc2_.commit();
      }
      
      protected function isSelf(param1:int) : Boolean
      {
         return param1 == thane.userId;
      }
      
      public function openBagFrame() : void
      {
         if(!_bagFrame)
         {
            _bagFrame = ComponentFactory.Instance.createComponentGroupByStylename("farm.FarmBagFrame");
            _bagFrame.addEventListener("dispose",__bagFrameDisposeHandler);
         }
         if(_bagFrame.parent)
         {
            return;
         }
         _bagFrame["show"]();
      }
      
      public function closeBagFrame() : void
      {
         if(_bagFrame)
         {
            _bagFrame.dispose();
         }
      }
      
      private function __bagFrameDisposeHandler(param1:Event) : void
      {
         _bagFrame.removeEventListener("dispose",__bagFrameDisposeHandler);
         _bagFrame = null;
      }
      
      public function openShopFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",6);
      }
      
      public function openFarmMakeFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("farm","FARM_MAKE_FRAME");
      }
      
      public function openFarmProcessingFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("farm","FARM_PROCESSING_FRAME");
      }
      
      public function openFarmInvideFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("farm","FARM_INVIDE_FRAME");
      }
      
      public function checkIsPartice(param1:int) : Boolean
      {
         var _loc3_:FarmInfo = _model.myFarm;
         if(!_loc3_)
         {
            return false;
         }
         for each(var _loc2_:PetLandInfo in _loc3_.getPetLandList())
         {
            if(_loc2_.petId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkIsDefenser(param1:int) : Boolean
      {
         if(!_model.myFarm)
         {
            return false;
         }
         var _loc2_:PetLandInfo = _model.myFarm.defender;
         if(_loc2_)
         {
            return _loc2_.petId == param1;
         }
         return false;
      }
      
      public function showGatherCropTip() : void
      {
         var _loc1_:* = null;
      }
   }
}

