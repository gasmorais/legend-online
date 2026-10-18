package managers
{
   import com.road.yishi.proto.battle.SkyTrialOrderInfoMsg;
   import com.road.yishi.proto.battle.SkyTrialPointInfoMsg;
   import com.road.yishi.proto.battle.SkyTrialPointMsg;
   import com.road.yishi.proto.skytrial.SkyTrialInfoMsg;
   import com.road.yishi.proto.skytrial.SkyTrialLayerMsg;
   import com.road.yishi.proto.skytrial.SkyTrialRequestMsg;
   import com.road.yishi.proto.skytrial.SkyTrialSearchMsg;
   import flash.events.Event;
   import mvc.module.skyboxroad.SkyBoxRoadPointInfo;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import mvc.module.skyboxroad.SkyboxRoadRankInfo;
   import mvc.module.skyboxroad.SkyboxRoadRewardInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class SkyboxRoadManager
   {
      
      public static const OP_REQ_POINT:int = 8;
      
      public static const OP_OCCP_POINT:int = 9;
      
      public static const OP_REQ_RANK:int = 10;
      
      public static const OP_EXIT_POINT:int = 11;
      
      public static const RANK_100:int = 100;
      
      private static var _instance:SkyboxRoadManager;
      
      private var _model:SkyboxRoadModel;
      
      private var _isFirst:Boolean = true;
      
      public function SkyboxRoadManager()
      {
         super();
         _model = new SkyboxRoadModel();
      }
      
      public static function get instance() : SkyboxRoadManager
      {
         if(!_instance)
         {
            _instance = new SkyboxRoadManager();
         }
         return _instance;
      }
      
      public function get model() : SkyboxRoadModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4552,onInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4551,__updateAreaHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4996,onCleanPortalReward);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 460,__updateSkyBoxRankInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 459,__updateSkyBoxRoadPointInfo);
      }
      
      private function __updateSkyBoxRankInfo(param1:SLGSocketEvent) : void
      {
         var _loc7_:SkyTrialOrderInfoMsg = null;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTrialPointMsg = new SkyTrialPointMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SkyTrialPointMsg;
         var _loc6_:SkyboxRoadRankInfo = new SkyboxRoadRankInfo();
         _loc6_.dayTime = _loc2_.myDayTimer * 60;
         _loc6_.dayOrder = _loc2_.myDayOrder;
         _loc6_.weekTime = _loc2_.myWeekTimer * 60;
         _loc6_.weekOrder = _loc2_.myWeekOrder;
         _model.myRank = _loc6_;
         var _loc3_:int = int(_loc2_.orderInfo.length);
         model.dayRankList = [];
         model.weekRankList = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc7_ = _loc2_.orderInfo[_loc4_];
            _loc6_ = new SkyboxRoadRankInfo();
            _loc6_.uuid = _loc7_.uuid;
            _loc6_.nickName = _loc7_.nickName;
            _loc6_.serverName = _loc7_.svrsName;
            _loc6_.dayTime = _loc7_.daysMinute * 60;
            _loc6_.dayOrder = _loc7_.daysOrder;
            _loc6_.weekTime = _loc7_.weekMinute * 60;
            _loc6_.weekOrder = _loc7_.weekOrder;
            _loc6_.rankType = _loc7_.orderType;
            if(_loc6_.rankType == 1)
            {
               model.dayRankList.push(_loc6_);
            }
            else if(_loc6_.rankType == 2)
            {
               model.weekRankList.push(_loc6_);
            }
            _loc4_ += 1;
         }
         _model.dayRankList.sortOn("dayOrder",16);
         _model.weekRankList.sortOn("weekOrder",16);
         _model.updateRanklist();
      }
      
      private function __updateSkyBoxRoadPointInfo(param1:SLGSocketEvent) : void
      {
         var _loc5_:SkyBoxRoadPointInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTrialPointMsg = new SkyTrialPointMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SkyTrialPointMsg;
         if(_loc2_.hasIsOccpPoint)
         {
            model.isOccpPoint = _loc2_.isOccpPoint;
         }
         model.curPointList = [];
         for each(var _loc3_:SkyTrialPointInfoMsg in _loc2_.pointInfo)
         {
            _loc5_ = new SkyBoxRoadPointInfo();
            _loc5_.portalId = _loc3_.layNumId;
            _loc5_.posIndex = _loc3_.posIndex;
            _loc5_.occpUuid = _loc3_.occpUuid;
            _loc5_.occpUserId = _loc3_.occpUserId;
            _loc5_.nickName = _loc3_.nickName;
            _loc5_.svrsName = _loc3_.svrsName;
            _loc5_.occpDateStr = _loc3_.occpDateStr;
            _loc5_.occpMinute = _loc3_.occpMinute * 60;
            if(_loc3_.hasJob)
            {
               _loc5_.userInfo.job = _loc3_.job;
            }
            if(_loc3_.hasSexJob)
            {
               _loc5_.userInfo.templateId = _loc3_.sexJob;
            }
            if(_loc5_.userInfo.hairFashionAvata != _loc3_.fashionHair)
            {
               _loc5_.userInfo.hairFashionAvata = _loc3_.fashionHair;
            }
            if(_loc5_.userInfo.cloakAvata != _loc3_.fashionHat)
            {
               _loc5_.userInfo.cloakAvata = _loc3_.fashionHat;
            }
            if(_loc5_.userInfo.wingAvata != _loc3_.fashionWing)
            {
               _loc5_.userInfo.wingAvata = _loc3_.fashionWing;
            }
            if(_loc3_.fashionArm)
            {
               if(_loc3_.fashionArm.indexOf("fashion") > -1)
               {
                  if(_loc5_.userInfo.armsFashionAvata != _loc3_.fashionArm)
                  {
                     _loc5_.userInfo.armsFashionAvata = _loc3_.fashionArm;
                  }
               }
               else if(_loc5_.userInfo.armsEquipAvata != _loc3_.fashionArm)
               {
                  _loc5_.userInfo.armsEquipAvata = _loc3_.fashionArm;
               }
            }
            if(_loc3_.fashionCloth)
            {
               if(_loc3_.fashionCloth.indexOf("fashion") > -1)
               {
                  if(_loc5_.userInfo.bodyFashionAvata != _loc3_.fashionCloth)
                  {
                     _loc5_.userInfo.bodyFashionAvata = _loc3_.fashionCloth;
                  }
               }
               else if(_loc5_.userInfo.bodyEquipAvata != _loc3_.fashionCloth)
               {
                  _loc5_.userInfo.bodyEquipAvata = _loc3_.fashionCloth;
               }
            }
            model.curPointList.push(_loc5_);
         }
         model.updateOccupyList();
      }
      
      private function enterScene() : void
      {
         FrameControllerManager.instance.skyBoxRoadControler.isInSkyBoxRoadFrame = true;
         SceneManager.instance.setScene("SKYBOX_ROAD_SCENE",null,true);
      }
      
      public function getData() : void
      {
         var _loc2_:PackageOut = null;
         var _loc1_:SkyTrialRequestMsg = null;
         if(_isFirst)
         {
            _loc2_ = new PackageOut(8636);
            _loc1_ = new SkyTrialRequestMsg();
            _loc1_.op = 1;
            SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
         }
         else
         {
            enterScene();
         }
      }
      
      public function explore(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8636);
         var _loc4_:SkyTrialRequestMsg = new SkyTrialRequestMsg();
         _loc4_.op = param1;
         _loc4_.needHelp = model.callHelper;
         _loc4_.portalId = param2;
         _loc4_.layNumId = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function exitPortal() : void
      {
         var _loc2_:PackageOut = new PackageOut(8636);
         var _loc1_:SkyTrialRequestMsg = new SkyTrialRequestMsg();
         _loc1_.op = 7;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function dekaronBoss(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8636);
         var _loc2_:SkyTrialRequestMsg = new SkyTrialRequestMsg();
         _loc2_.op = 4;
         _loc2_.needHelp = model.callHelper;
         _loc2_.portalId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function buySkill(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8636);
         var _loc2_:SkyTrialRequestMsg = new SkyTrialRequestMsg();
         _loc2_.op = 6;
         _loc2_.buySkillId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function buyEnergy(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8636);
         var _loc2_:SkyTrialRequestMsg = new SkyTrialRequestMsg();
         _loc2_.op = 5;
         _loc2_.payType = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function onInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTrialInfoMsg = new SkyTrialInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SkyTrialInfoMsg;
         if(_loc2_.hasEnergy)
         {
            model.skyTrialInfo.energy = _loc2_.energy;
         }
         if(_loc2_.hasSearchPoint)
         {
            model.skyTrialInfo.searchPoint = _loc2_.searchPoint;
         }
         if(_loc2_.hasBuyEnergyCount)
         {
            model.skyTrialInfo.buyEnergyCount = _loc2_.buyEnergyCount;
         }
         model.skyTrialInfo.setBuffList(_loc2_.buffList);
         model.skyTrialInfo.setSkillList(_loc2_.skillCountList);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.layerList.length)
         {
            model.skyTrialInfo.updateLayerList(_loc2_.layerList[_loc3_]);
            if(SkyTrialLayerMsg(_loc2_.layerList[_loc3_]).layerNum > model.toptLayer)
            {
               model.toptLayer = SkyTrialLayerMsg(_loc2_.layerList[_loc3_]).layerNum;
            }
            _loc3_++;
         }
         if(model.toptLayer == 0)
         {
            model.toptLayer = 1;
         }
         if(_loc2_.op == 1)
         {
            NotificationManager.instance.dispatchEvent(new Event("SKYBOX_ROAD_INFO"));
            _isFirst = false;
            enterScene();
         }
         else if(_loc2_.op == 2)
         {
            NotificationManager.instance.dispatchEvent(new Event("SKYBOX_ROAD_INFO_UPDATE"));
         }
      }
      
      public function set isFirst(param1:Boolean) : void
      {
         _isFirst = param1;
      }
      
      private function __updateAreaHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:SkyboxRoadRewardInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SkyTrialSearchMsg = new SkyTrialSearchMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SkyTrialSearchMsg;
         model.portalRewardArray = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.rewardList.length)
         {
            _loc5_ = new SkyboxRoadRewardInfo();
            _loc5_.type = _loc2_.rewardList[_loc3_];
            _loc5_.tempId = _loc2_.rewardList[_loc3_ + 1];
            _loc5_.count = _loc2_.rewardList[_loc3_ + 2];
            _loc3_ += 2;
            model.portalRewardArray.push(_loc5_);
            _loc3_++;
         }
         NotificationManager.instance.dispatchEvent(new Event("SKYBOX_ROAD_CURRENT_REWARD"));
         if(_loc2_.eventId != 0)
         {
            model.currentEventId = _loc2_.eventId;
            NotificationManager.instance.dispatchEvent(new Event("SKYBOX_ROAD_EVENT"));
         }
      }
      
      private function onCleanPortalReward(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         var _loc3_:String = "SKYBOX_ROAD_SCENE";
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,_loc3_,__warReportCall);
      }
      
      private function __warReportCall(param1:PackageIn) : void
      {
         var _loc2_:SkyTrialSearchMsg = new SkyTrialSearchMsg();
         _loc2_ = param1.readBody(_loc2_) as SkyTrialSearchMsg;
         model.cleanPortalId = _loc2_.portalId;
         FrameControllerManager.instance.skyBoxRoadControler.showCleanFrame();
      }
      
      public function sendRankListRequest() : void
      {
         var _loc2_:PackageOut = new PackageOut(8636);
         var _loc1_:SkyTrialRequestMsg = new SkyTrialRequestMsg();
         _loc1_.op = 10;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendPointOccupyRequest(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(8636);
         var _loc4_:SkyTrialRequestMsg = new SkyTrialRequestMsg();
         _loc4_.op = param1;
         _loc4_.layNumId = param2;
         _loc4_.posIndex = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
   }
}

