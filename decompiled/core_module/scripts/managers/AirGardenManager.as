package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.airgarden.AirGardenCampaignDetailMsg;
   import com.road.yishi.proto.airgarden.AirGardenCampaignMsg;
   import com.road.yishi.proto.airgarden.AirGardenCampaignMsgList;
   import com.road.yishi.proto.airgarden.AirGardenCampaignNodeMsg;
   import com.road.yishi.proto.airgarden.AirGardenSelfMsg;
   import com.road.yishi.proto.airgarden.AirGardenStateMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import mvc.module.airgarden.AirGardenCampaignBedInfo;
   import mvc.module.airgarden.AirGardenModel;
   import mvc.module.airgarden.AirGardenPartyInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class AirGardenManager
   {
      
      private static var _instance:AirGardenManager;
      
      private var _model:AirGardenModel;
      
      public function AirGardenManager()
      {
         super();
      }
      
      public static function get instance() : AirGardenManager
      {
         if(!_instance)
         {
            _instance = new AirGardenManager();
         }
         return _instance;
      }
      
      public function get model() : AirGardenModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new AirGardenModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 376,__airGardenStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 377,__partyListUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 380,__selfGardenUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 379,__airGardenCampaignDetailHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 381,__gameStartBackHandler);
      }
      
      private function __airGardenStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AirGardenStateMsg = new AirGardenStateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AirGardenStateMsg;
         if(_loc2_.hasCanCreateParty)
         {
            model.canCreateParty = _loc2_.canCreateParty;
         }
         if(_loc2_.hasCreateBeginTime)
         {
            model.createBeginTime = new Date(Int64Utils.int64ToNumber(_loc2_.createBeginTime));
         }
         if(_loc2_.hasCreateEndTime)
         {
            model.createEndTime = new Date(Int64Utils.int64ToNumber(_loc2_.createEndTime));
         }
         if(_loc2_.hasIsParty)
         {
            model.isParty = _loc2_.isParty;
         }
         if(_loc2_.hasPartyBeginTime)
         {
            model.partyBeginTime = new Date(Int64Utils.int64ToNumber(_loc2_.partyBeginTime));
         }
         if(_loc2_.hasPartyEndTime)
         {
            model.partyEndTime = new Date(Int64Utils.int64ToNumber(_loc2_.partyEndTime));
         }
         if(_loc2_.hasSelfCreatedParty)
         {
            model.selfCreatedParty = _loc2_.selfCreatedParty;
         }
         if(_loc2_.hasSelfUpCount)
         {
            model.selfUpCount = _loc2_.selfUpCount;
         }
         if(_loc2_.hasUpCdEndTime)
         {
            model.upCdEndTime = Int64Utils.int64ToNumber(_loc2_.upCdEndTime);
         }
         MsgMan.notifyObserver("AIRGARDEN_STATE_CHANGE");
      }
      
      private function __partyListUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:AirGardenPartyInfo = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AirGardenCampaignMsgList = new AirGardenCampaignMsgList();
         _loc2_ = _loc3_.readBody(_loc2_) as AirGardenCampaignMsgList;
         if(_loc2_.page == 0 && _loc2_.totalPage == 0)
         {
            model.allPartyDic.clear();
         }
         for each(var _loc5_:AirGardenCampaignMsg in _loc2_.list)
         {
            if(!model.allPartyDic[_loc5_.masterUserId])
            {
               _loc4_ = new AirGardenPartyInfo();
            }
            else
            {
               _loc4_ = model.allPartyDic[_loc5_.masterUserId];
            }
            _loc4_.masterUserId = _loc5_.masterUserId;
            _loc4_.nickName = _loc5_.nickName;
            _loc4_.headId = _loc5_.headId;
            _loc4_.fightPower = _loc5_.fightCapacity;
            _loc4_.intro = _loc5_.intro;
            _loc4_.isParty = _loc5_.isParty;
            _loc4_.upCount = _loc5_.upCount;
            _loc4_.hotCount = _loc5_.hotCount;
            _loc4_.gameRemainList = _loc5_.gameRemainList;
            _loc4_.totalScore = _loc5_.totalScore;
            model.allPartyDic.add(_loc5_.masterUserId,_loc4_);
         }
         MsgMan.notifyObserver("PARTY_LIST_UPDATE");
      }
      
      private function __selfGardenUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:AirGardenSelfMsg = new AirGardenSelfMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as AirGardenSelfMsg;
         if(_loc2_.hasGameRemain)
         {
            model.gameRemain = _loc2_.gameRemain;
         }
         if(_loc2_.hasExtraGameCount)
         {
            model.extraGameCount = _loc2_.extraGameCount;
         }
         if(_loc2_.hasSelfScore)
         {
            model.selfScore = _loc2_.selfScore;
         }
         if(_loc2_.hasThisUpCount)
         {
            model.roomSelfUpCount = _loc2_.thisUpCount;
         }
         MsgMan.notifyObserver("SELF_INFO_UPDATE");
      }
      
      private function __airGardenCampaignDetailHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:AirGardenCampaignBedInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:AirGardenCampaignDetailMsg = new AirGardenCampaignDetailMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as AirGardenCampaignDetailMsg;
         var _loc4_:int = ArmyManager.instance.thane.userId;
         var _loc6_:int = 0;
         if(_loc2_.masterUserId == model.campaignInfo.masterUserId)
         {
            model.campaignInfo.bedNodeList = [];
            if(_loc2_.masterUserId == _loc4_)
            {
               model.bedNodeList = [];
               _loc6_ = 1;
            }
            else
            {
               _loc6_ = 2;
            }
         }
         else if(_loc2_.masterUserId == _loc4_)
         {
            model.bedNodeList = [];
            _loc6_ = 3;
         }
         if(_loc6_ == 0)
         {
            return;
         }
         for each(var _loc3_:AirGardenCampaignNodeMsg in _loc2_.nodeList)
         {
            _loc7_ = new AirGardenCampaignBedInfo();
            _loc7_.campaignNodeId = _loc3_.campaignNodeId;
            _loc7_.nodeTempId = _loc3_.nodeTempId;
            _loc7_.objId = _loc3_.objId;
            _loc7_.tempId = _loc3_.tempId;
            _loc7_.grade = _loc3_.grade;
            if(_loc3_.hasHero)
            {
               _loc7_.heroInfo.userId = _loc3_.hero.playerId;
               _loc7_.heroInfo.grades = _loc3_.hero.grades;
               _loc7_.heroInfo.nickName = _loc3_.hero.nickName;
               _loc7_.heroInfo.sexs = _loc3_.hero.sex;
               _loc7_.heroInfo.templateId = _loc3_.hero.templateId;
               _loc7_.heroInfo.headId = _loc3_.hero.headId;
               _loc7_.heroInfo.armsEquipAvata = _loc3_.hero.arm;
               _loc7_.heroInfo.bodyEquipAvata = _loc3_.hero.cloth;
               _loc7_.heroInfo.wingAvata = _loc3_.hero.wing;
               _loc7_.heroInfo.hairFashionAvata = _loc3_.hero.hat;
               _loc7_.heroInfo.hairEquipAvata = _loc3_.hero.hat;
               _loc7_.heroInfo.armsFashionAvata = _loc3_.hero.fashionArm;
               _loc7_.heroInfo.bodyFashionAvata = _loc3_.hero.fashionCloth;
            }
            if(_loc6_ == 1)
            {
               model.bedNodeList.push(_loc7_);
               model.campaignInfo.bedNodeList.push(_loc7_);
            }
            else if(_loc6_ == 2)
            {
               model.campaignInfo.bedNodeList.push(_loc7_);
            }
            else if(_loc6_ == 3)
            {
               model.bedNodeList.push(_loc7_);
            }
         }
         MsgMan.notifyObserver("CAMPAIGN_DETAIL_UPDATE");
      }
      
      private function __gameStartBackHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CommonMsg;
         if(_loc2_.param1 == 1)
         {
            _loc3_ = "GAME_TYPE_LLK";
         }
         else if(_loc2_.param1 == 2)
         {
            _loc3_ = "GAME_TYPE_MEMORYCARD";
         }
         else if(_loc2_.param1 == 3)
         {
            _loc3_ = "GAME_TYPE_FIVECARD";
         }
         if(!StringHelper.isNullOrEmpty(_loc3_))
         {
            FrameControllerManager.instance.openControllerByInfo("airgarden",_loc3_);
         }
      }
      
      public function requestAirGarden(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5442);
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function reqAirGardenCampaign(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5442);
         var _loc3_:CommonMsg = new CommonMsg();
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function reqAirGardenBed(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5442);
         var _loc3_:CommonMsg = new CommonMsg();
         _loc3_.param1 = 3;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function airGardenCreateParty(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(5442);
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_.param1 = 4;
         _loc2_.param4 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function airGardenJoinGame(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5442);
         var _loc3_:CommonMsg = new CommonMsg();
         _loc3_.param1 = 6;
         _loc3_.param2 = param1;
         _loc3_.param3 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendBedShopBuy(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5442);
         var _loc2_:CommonMsg = new CommonMsg();
         _loc2_.param1 = 9;
         _loc2_.param2 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

