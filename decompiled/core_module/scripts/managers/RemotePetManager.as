package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.pet.PetInfoMsg;
   import com.road.yishi.proto.remotepet.FriendPetMsg;
   import com.road.yishi.proto.remotepet.PetSiteMsg;
   import com.road.yishi.proto.remotepet.RemoteFriendPetMsg;
   import com.road.yishi.proto.remotepet.RemoteFriendPetOpMsg;
   import com.road.yishi.proto.remotepet.RemoteItemMsg;
   import com.road.yishi.proto.remotepet.RemotePetMsg;
   import com.road.yishi.proto.remotepet.RemotePetOpMsg;
   import mvc.module.pet.PetData;
   import mvc.module.remotepet.RemotePetFriendInfo;
   import mvc.module.remotepet.RemotePetModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   
   public class RemotePetManager
   {
      
      private static var _instance:RemotePetManager;
      
      private var _model:RemotePetModel;
      
      public function RemotePetManager()
      {
         super();
         if(!_model)
         {
            _model = new RemotePetModel();
         }
      }
      
      public static function get instance() : RemotePetManager
      {
         if(!_instance)
         {
            _instance = new RemotePetManager();
         }
         return _instance;
      }
      
      public static function sendRemotePetInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(9544);
         var _loc1_:RemotePetOpMsg = new RemotePetOpMsg();
         _loc1_.op = 1;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sendUpdateSkill(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9544);
         var _loc2_:RemotePetOpMsg = new RemotePetOpMsg();
         _loc2_.op = 5;
         _loc2_.skillId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendFriendPetList() : void
      {
         var _loc2_:PackageOut = new PackageOut(15057);
         var _loc1_:RemoteFriendPetOpMsg = new RemoteFriendPetOpMsg();
         _loc1_.op = 1;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sendFriendPetInfo(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(15057);
         var _loc3_:RemoteFriendPetOpMsg = new RemoteFriendPetOpMsg();
         _loc3_.op = 2;
         _loc3_.friendId = param1;
         _loc3_.petId = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendMopup(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9544);
         var _loc2_:RemotePetOpMsg = new RemotePetOpMsg();
         _loc2_.op = 7;
         _loc2_.sweepIndex = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendMopupOP(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9544);
         var _loc3_:RemotePetOpMsg = new RemotePetOpMsg();
         _loc3_.op = param1;
         _loc3_.payType = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public function get model() : RemotePetModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4964,__remotePetHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4965,__friendListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4966,__friendPetInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4967,__rewarldHandler);
      }
      
      private function __remotePetHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Array = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RemotePetMsg = new RemotePetMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RemotePetMsg;
         model.isGet = _loc2_.isGet;
         model.isFrist = _loc2_.isFirst;
         model.skillString = _loc2_.skills;
         model.rank = _loc2_.order;
         model.petListInfo.fight = _loc2_.fight;
         model.petListInfo.formationString = _loc2_.pos;
         model.petListInfo.petPos = _loc2_.pets;
         model.petListInfo.petList.clear();
         for each(var _loc4_:String in model.petListInfo.petPos.split("|"))
         {
            _loc3_ = _loc4_.split(",");
            if(_loc3_[0] != "4" && _loc3_[0] != "5" && _loc3_[0] != "6")
            {
               model.petListInfo.petList[_loc3_[0]] = playerInfo.getPet(_loc3_[1]);
            }
         }
         model.turnInfo.specialIndex = _loc2_.specialIndex;
         model.turnInfo.currTurn = _loc2_.nowIndex + 1;
         model.turnInfo.maxTurn = _loc2_.maxIndex;
         model.turnInfo.goodsList = _loc2_.items;
         model.mopupCount = _loc2_.sweepIndex;
         model.lastOrder = _loc2_.lastOrder;
         model.commit();
      }
      
      private function __friendListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:RemotePetFriendInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RemoteFriendPetMsg = new RemoteFriendPetMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RemoteFriendPetMsg;
         model.friendList = [];
         for each(var _loc3_:FriendPetMsg in _loc2_.pets)
         {
            _loc4_ = new RemotePetFriendInfo();
            _loc4_.friendId = _loc3_.friendId;
            _loc4_.petId = _loc3_.petId;
            _loc4_.petFight = _loc3_.petFight;
            _loc4_.petQuality = _loc3_.petQuality;
            _loc4_.petType = _loc3_.petType;
            _loc4_.petName = _loc3_.petName;
            _loc4_.friendName = _loc3_.friendName;
            model.friendList.push(_loc4_);
         }
         model.commitFriend();
      }
      
      private function __friendPetInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PetInfoMsg = new PetInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PetInfoMsg;
         var _loc4_:PetData = PetData.createWithMsg(_loc2_);
         model.petListInfo.petList[7] = _loc4_;
         model.petChange([_loc4_]);
         model.commit();
      }
      
      private function __rewarldHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Object = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RemoteItemMsg = new RemoteItemMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RemoteItemMsg;
         if(_loc2_.type == 2)
         {
            _loc3_ = {};
            _loc3_.count = _loc2_.count;
            _loc3_.items = _loc2_.items;
            model.mopupList.push(_loc3_);
            model.updateMopup(_loc3_);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function saveRemotePetInfo(param1:Boolean = false) : void
      {
         var _loc7_:PetData = null;
         var _loc5_:PetSiteMsg = null;
         var _loc6_:PackageOut = new PackageOut(9544);
         var _loc2_:RemotePetOpMsg = new RemotePetOpMsg();
         _loc2_.op = 2;
         if(model.petListInfo.formationString == "")
         {
            model.petListInfo.formationString = "-1,-1,-1,-1,-1,-1,-1,-1";
         }
         _loc2_.pos = model.petListInfo.formationString;
         var _loc3_:Array = [];
         for(var _loc4_:String in model.petListInfo.petList)
         {
            if(model.petListInfo.petList[_loc4_])
            {
               _loc7_ = model.petListInfo.petList[_loc4_];
               _loc5_ = new PetSiteMsg();
               _loc5_.petId = _loc7_.petId;
               _loc5_.site = int(_loc4_);
               _loc5_.skills = _loc7_.remotePetSkillsOfString;
               _loc3_.push(_loc5_);
            }
         }
         _loc2_.isFirst = param1;
         _loc2_.pets = _loc3_;
         sendProtoBuffer(_loc6_,_loc2_);
      }
      
      public function sendFight(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(9544);
         var _loc3_:RemotePetOpMsg = new RemotePetOpMsg();
         _loc3_.op = 6;
         _loc3_.index = param1;
         _loc3_.isSpecial = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

