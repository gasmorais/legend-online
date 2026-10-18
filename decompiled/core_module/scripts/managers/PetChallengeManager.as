package managers
{
   import com.road.yishi.proto.pet.ChallengeRequestMsg;
   import com.road.yishi.proto.pet.CrossPetInfoMsg;
   import com.road.yishi.proto.pet.CrossPetRankMsg;
   import com.road.yishi.proto.pet.PetInfoMsg;
   import com.road.yishi.proto.pet.PetLogMsg;
   import com.road.yishi.proto.pet.PetRankMsg;
   import com.road.yishi.proto.pet.PetRankRewardMsg;
   import com.road.yishi.proto.pet.PlayerPetMsg;
   import com.road.yishi.proto.player.ChallengeCoolTimeMsg;
   import com.road.yishi.proto.player.ChallengeMsg;
   import com.road.yishi.proto.player.PayTypeMsg;
   import mvc.module.pet.PetData;
   import mvc.module.petchallenge.PetChallengeModel;
   import mvc.module.petchallenge.PetChallengeObjectData;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class PetChallengeManager
   {
      
      private static var _instance:PetChallengeManager;
      
      private var _model:PetChallengeModel;
      
      public function PetChallengeManager()
      {
         super();
      }
      
      public static function get instance() : PetChallengeManager
      {
         if(!_instance)
         {
            _instance = new PetChallengeManager();
         }
         return _instance;
      }
      
      public function get model() : PetChallengeModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new PetChallengeModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4176,__petchallengeTimeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4611,__loadPetChallengeListHandler);
         playerInfo.addEventListener("PLAYER_PET_LIST_CHANGE",__petformationChangeHandler);
      }
      
      private function __petformationChangeHandler(param1:PlayerEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:PetData = null;
         if(playerInfo.petChallengeFormation)
         {
            _loc3_ = playerInfo.petChallengeFormation.split(",");
         }
         model.selfInfo.petList.splice(0);
         for each(var _loc2_:String in _loc3_)
         {
            _loc4_ = playerInfo.getPet(int(_loc2_));
            if(_loc4_)
            {
               model.selfInfo.petList.push(_loc4_);
            }
         }
         model.commitInfoChange();
      }
      
      private function __loadPetChallengeListHandler(param1:SLGSocketEvent) : void
      {
         var _loc11_:Array = null;
         var _loc5_:PetChallengeObjectData = null;
         var _loc12_:PetData = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc4_:PetChallengeObjectData = null;
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrossPetRankMsg = new CrossPetRankMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as CrossPetRankMsg;
         if(_loc2_.param2)
         {
            model.weekResiPointArr = _loc2_.param2.split(",");
         }
         var _loc9_:PetRankMsg = _loc2_.myRank;
         model.selfInfo.uuid = _loc9_.uuid;
         model.selfInfo.userId = _loc9_.userId;
         model.selfInfo.userName = _loc9_.nickName;
         model.selfInfo.serverName = _loc9_.serverName;
         model.selfInfo.score = _loc9_.score;
         model.selfInfo.ranking = _loc9_.rank;
         model.selfInfo.fightCapacity = _loc9_.fightCapacity;
         model.selfInfo.isSelf = true;
         model.selfInfo.petList.splice(0);
         if(playerInfo.petChallengeFormation)
         {
            _loc11_ = playerInfo.petChallengeFormation.split(",");
         }
         for each(var _loc6_:String in _loc11_)
         {
            _loc12_ = playerInfo.getPet(int(_loc6_));
            if(_loc12_)
            {
               model.selfInfo.petList.push(_loc12_);
            }
         }
         model.challengeList.splice(0);
         for each(_loc7_ in _loc2_.otherRank)
         {
            _loc5_ = new PetChallengeObjectData();
            _loc5_.uuid = _loc7_.uuid;
            _loc5_.userId = _loc7_.userId;
            _loc5_.userName = _loc7_.nickName;
            _loc5_.serverName = _loc7_.serverName;
            _loc5_.score = _loc7_.score;
            _loc5_.ranking = _loc7_.rank;
            _loc5_.fightCapacity = _loc7_.fightCapacity;
            for each(_loc3_ in _loc7_.pets)
            {
               _loc12_ = createWithMsg(_loc3_);
               _loc5_.petList.push(_loc12_);
            }
            model.challengeList.push(_loc5_);
         }
         model.challengeList.sortOn("score",0x10 | 2);
         model.reportList.splice(0);
         for each(_loc8_ in _loc2_.log)
         {
            _loc4_ = new PetChallengeObjectData();
            _loc4_.userId = _loc8_.tarUserId;
            _loc4_.userName = _loc8_.tarNickName;
            _loc4_.serverName = _loc8_.tarServerName;
            _loc4_.result = _loc8_.result;
            _loc4_.score = _loc8_.score;
            _loc4_.logDate = DateFormatter.parse(_loc8_.logDate,"YYYY-MM-DD hh:mm:ss").time / 1000;
            for each(_loc3_ in _loc8_.pets)
            {
               _loc12_ = createWithMsg(_loc3_);
               _loc4_.petList.push(_loc12_);
            }
            model.reportList.push(_loc4_);
         }
         model.reportList.sortOn("logDate",0x10 | 2);
         model.commitInfoChange();
      }
      
      private function createWithMsg(param1:CrossPetInfoMsg) : PetData
      {
         var _loc2_:PetData = new PetData();
         _loc2_.templateId = param1.templateId;
         if(param1.quality < 26)
         {
            _loc2_.quality = (param1.quality - 1) / 5 + 1;
         }
         else
         {
            _loc2_.quality = (param1.quality - 1) / 5;
         }
         _loc2_.temQuality = param1.quality;
         _loc2_.name = param1.name;
         _loc2_.grade = param1.grade;
         _loc2_.fightPower = param1.fightCapacity;
         return _loc2_;
      }
      
      private function __petchallengeTimeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChallengeCoolTimeMsg = new ChallengeCoolTimeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChallengeCoolTimeMsg;
         if(_loc2_.type != 1)
         {
            return;
         }
         model.buildingOrder.totalCount = _loc2_.challengeCount;
         model.buildingOrder.currentCount = 0;
         model.buildingOrder.remainTime = _loc2_.leftTime;
         model.commitTimeChange();
      }
      
      public function requestChallengeData(param1:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(8256);
         var _loc2_:ChallengeRequestMsg = new ChallengeRequestMsg();
         _loc2_.type = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendChallengeCommand(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8724);
         var _loc2_:ChallengeMsg = new ChallengeMsg();
         _loc2_.uuid = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendPetFormation(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8725);
         var _loc2_:PlayerPetMsg = new PlayerPetMsg();
         _loc2_.chaPos = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendPetSkills(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8726);
         var _loc3_:PetInfoMsg = new PetInfoMsg();
         _loc3_.petId = param1;
         _loc3_.chaSkillIndexs = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendPetRankOperate(param1:int, param2:int = 0, param3:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8728);
         var _loc4_:PetRankRewardMsg = new PetRankRewardMsg();
         _loc4_.type = param1;
         _loc4_.opType = 1;
         _loc4_.rewardType = 0;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function coolDownChallengeCD(param1:Boolean = true) : void
      {
         var _loc3_:PackageOut = new PackageOut(8265);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         if(!param1)
         {
            _loc2_.payType = 1;
         }
         else
         {
            _loc2_.payType = 2;
         }
         if(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt)
         {
            _loc2_.payType = 0;
         }
         _loc2_.type = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

