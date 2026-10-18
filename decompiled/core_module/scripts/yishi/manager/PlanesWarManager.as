package yishi.manager
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.planes.PlanesEnergyMsg;
   import com.road.yishi.proto.planes.PlanesInfoMsg;
   import com.road.yishi.proto.planes.PlanesLayerInfoMsg;
   import com.road.yishi.proto.planes.PlanesLayerListMsg;
   import com.road.yishi.proto.planes.PlanesResourceListMsg;
   import com.road.yishi.proto.planes.PlanesResourceMsg;
   import com.road.yishi.proto.planes.PlanesWarListMsg;
   import com.road.yishi.proto.planes.PlanesWarMapMsg;
   import com.road.yishi.proto.planes.PlanesWarReqMsg;
   import com.road.yishi.proto.planes.PlanesWarRspMsg;
   import events.PlanesWarEvent;
   import flash.events.EventDispatcher;
   import mvc.controler.PlanesWarControler;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesGridInfo;
   import mvc.module.planeswar.info.PlanesInfo;
   import mvc.module.planeswar.info.PlanesLayerInfo;
   import mvc.module.planeswar.info.PlanesResourceInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.datas.templates.PlanesLayerTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class PlanesWarManager extends EventDispatcher
   {
      
      private static var _instance:PlanesWarManager;
      
      private var _mapView:*;
      
      private var _model:PlanesWarModel;
      
      private var backFuncDic:Object;
      
      public var isNeedOpendEventFrame:Boolean = true;
      
      public function PlanesWarManager()
      {
         super();
      }
      
      public static function get instance() : PlanesWarManager
      {
         if(!_instance)
         {
            _instance = new PlanesWarManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         backFuncDic = {};
         backFuncDic[2] = moveBackHandler;
         backFuncDic[4] = markerBuyBack;
         backFuncDic[3] = funcBuyBack;
         backFuncDic[6] = lifeReviveHandler;
         backFuncDic[19] = leavingBackHandler;
         backFuncDic[15] = tranesferBackHandler;
         backFuncDic[24] = restorePosXYHandler;
         backFuncDic[34] = helpReviveHandler;
         backFuncDic[36] = goLvBackHandler;
         backFuncDic[35] = cardSelectBackHandler;
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4941,__getPlanesListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4943,__updateGridInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4942,__planesWarMsgHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4944,__updateQueueEnergyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4978,__updatePlanesResourceHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4981,__updatePlanesLayerListHandler);
      }
      
      private function __getPlanesListHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PlanesInfo = null;
         var _loc4_:PlanesLayerInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlanesWarListMsg = new PlanesWarListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PlanesWarListMsg;
         model.maxPlanesCount = _loc2_.maxPlanesOwn;
         model.energyLeft = _loc2_.energyLeft;
         model.hasBuyEnergyCount = _loc2_.buyEnergyCount;
         model.planesInfoList = [];
         for each(var _loc6_:PlanesInfoMsg in _loc2_.planesList)
         {
            _loc3_ = new PlanesInfo();
            _loc3_.planesId = _loc6_.planesId;
            _loc3_.planesTemId = _loc6_.planesTempId;
            _loc3_.planesProcess = _loc6_.planesProcess;
            _loc3_.lifePoint = _loc6_.lifePoint;
            _loc3_.lifeReduce = _loc6_.lifeReduce;
            _loc3_.planesLayerList = [];
            for each(var _loc7_:PlanesLayerInfoMsg in _loc6_.layerList)
            {
               _loc4_ = new PlanesLayerInfo();
               _loc4_.layerId = _loc7_.layerId;
               _loc4_.layerTempId = _loc7_.layerTempId;
               _loc4_.occupyUserId = _loc7_.occupyUserid;
               _loc4_.isActived = _loc7_.isActivated;
               _loc4_.iconState = _loc7_.iconState;
               _loc4_.funcArray = _loc7_.buyList;
               _loc3_.planesLayerList.push(_loc4_);
            }
            _loc3_.planesLayerList.sort(sortLayers);
            model.planesInfoList.push(_loc3_);
         }
         model.planesInfoList.sortOn("planesId",16);
         sendDispatchEvent("PLANES_INFO_UPDATE");
         sendDispatchEvent("UPDATE_QUEUE_ENERGY");
      }
      
      private function __updateGridInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:PlanesGridInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlanesWarMapMsg = new PlanesWarMapMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as PlanesWarMapMsg;
         if(_loc2_.stamp > model.planesWarInfo.stamp)
         {
            model.planesWarInfo.gridArr = [];
         }
         else if(_loc2_.stamp < model.planesWarInfo.stamp)
         {
            return;
         }
         model.planesWarInfo.stamp = _loc2_.stamp;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.grid.length)
         {
            _loc5_ = _loc2_.grid[_loc4_].x * 100 + _loc2_.grid[_loc4_].y;
            _loc3_ = model.getGridByXY(_loc2_.grid[_loc4_].x,_loc2_.grid[_loc4_].y);
            if(_loc3_ == null)
            {
               _loc3_ = new PlanesGridInfo();
               model.planesWarInfo.gridArr.push(_loc3_);
            }
            _loc3_.x = _loc2_.grid[_loc4_].x;
            _loc3_.y = _loc2_.grid[_loc4_].y;
            _loc3_.eventId = _loc2_.grid[_loc4_].eventId;
            _loc3_.opened = _loc2_.grid[_loc4_].opened;
            _loc3_.occupied = _loc2_.grid[_loc4_].occupied;
            _loc3_.occupyName = _loc2_.grid[_loc4_].occupyName;
            _loc3_.index = _loc3_.x * 100 + _loc3_.y;
            _loc4_++;
         }
         updateMapAndGridInfo();
      }
      
      private function __planesWarMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlanesWarRspMsg = new PlanesWarRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlanesWarRspMsg;
         updateModel(_loc2_);
         if(_loc2_.hasEventInfo)
         {
            model.planesWarInfo.eventInfo.eventId = _loc2_.eventInfo.eventId;
            model.planesWarInfo.eventInfo.respondTpye = _loc2_.eventInfo.respondType;
            model.planesWarInfo.eventInfo.params = _loc2_.eventInfo.paramInt;
            _loc4_ = "PLANES_WAR_SCENE";
            SocketSceneBufferManager.instance.addPkgToBuffer(_loc3_,_loc4_,__checkisOpenEventFrame);
         }
         else
         {
            model.planesWarInfo.eventInfo.eventId = 0;
         }
         if(backFuncDic[_loc2_.op] != null)
         {
            backFuncDic[_loc2_.op]();
         }
      }
      
      private function __checkisOpenEventFrame(param1:PackageIn) : void
      {
         openEventFrame();
      }
      
      private function updateModel(param1:PlanesWarRspMsg) : void
      {
         if(param1.hasEnergyLeft)
         {
            model.energyLeft = param1.energyLeft;
         }
         if(param1.hasBuyEnergyCount)
         {
            model.hasBuyEnergyCount = param1.buyEnergyCount;
         }
         if(param1.hasPlanesTempId)
         {
            model.planesWarInfo.planesTempId = param1.planesTempId;
         }
         if(param1.hasLayerId)
         {
            model.planesWarInfo.layerId = param1.layerId;
         }
         if(param1.hasLayerTempId)
         {
            model.planesWarInfo.layerTempId = param1.layerTempId;
         }
         if(param1.hasDead)
         {
            model.planesWarInfo.dead = param1.dead;
         }
         if(param1.hasReviveLeft)
         {
            model.planesWarInfo.reviveLeft = param1.reviveLeft;
         }
         if(param1.hasPosX)
         {
            model.planesWarInfo.posX = param1.posX;
         }
         if(param1.hasPosY)
         {
            model.planesWarInfo.posY = param1.posY;
         }
         if(param1.hasGoldKeyCount)
         {
            model.planesWarInfo.goldKeyCount = param1.goldKeyCount;
         }
         if(param1.hasSilverKeyCount)
         {
            model.planesWarInfo.silverKeyCount = param1.silverKeyCount;
         }
         model.createMapData();
         sendDispatchEvent("PLANES_WARINFO_UPDATE");
      }
      
      private function __updatePlanesResourceHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PlanesResourceInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlanesResourceListMsg = new PlanesResourceListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PlanesResourceListMsg;
         model.planesResourceList = [];
         for each(var _loc3_:PlanesResourceMsg in _loc2_.resourceList)
         {
            _loc5_ = new PlanesResourceInfo();
            _loc5_.layerId = _loc3_.layerId;
            _loc5_.x = _loc3_.posX;
            _loc5_.y = _loc3_.posY;
            _loc5_.eventId = _loc3_.eventId;
            _loc5_.totalLeftTime = Math.ceil(Int64Utils.int64ToNumber(_loc3_.totalCountDown) / 1000);
            _loc5_.baseTotalTime = Math.ceil(Int64Utils.int64ToNumber(_loc3_.totalCountDown) / 1000);
            _loc5_.nextRewardTime = Math.ceil(Int64Utils.int64ToNumber(_loc3_.nextRewardCountDown) / 1000);
            _loc5_.canGetCount = _loc3_.canRewardCount;
            _loc5_.baseCanGet = _loc3_.canRewardCount;
            model.planesResourceList.push(_loc5_);
         }
         sendDispatchEvent("PLANES_RESOURCE_UPDATE");
      }
      
      private function __updateQueueEnergyHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlanesEnergyMsg = new PlanesEnergyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlanesEnergyMsg;
         model.energyLeft = _loc2_.energy;
         model.remainTime = Int64Utils.int64ToNumber(_loc2_.countDown) / 1000;
         sendDispatchEvent("UPDATE_QUEUE_ENERGY");
      }
      
      private function __updatePlanesLayerListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PlanesLayerInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlanesLayerListMsg = new PlanesLayerListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PlanesLayerListMsg;
         if(_loc2_.op == 0)
         {
            model.planesLayerList = [];
         }
         for each(var _loc3_:PlanesLayerInfoMsg in _loc2_.layerList)
         {
            _loc4_ = model.getPlanesLayerInfoById(_loc3_.layerId);
            if(_loc4_ == null)
            {
               _loc4_ = new PlanesLayerInfo();
               model.planesLayerList.push(_loc4_);
            }
            _loc4_.layerId = _loc3_.layerId;
            _loc4_.layerTempId = _loc3_.layerTempId;
            _loc4_.occupyUserId = _loc3_.occupyUserid;
            _loc4_.isActived = _loc3_.isActivated;
            _loc4_.iconState = _loc3_.iconState;
            _loc4_.funcArray = _loc3_.buyList;
         }
         model.planesLayerList.sort(sortLayers);
         sendDispatchEvent("PLANES_LAYERLIST_UPDATE");
      }
      
      private function sortLayers(param1:PlanesLayerInfo, param2:PlanesLayerInfo) : int
      {
         var _loc4_:PlanesLayerTemplateInfo = TempleteManager.instance.planesLayerTemplateCate.getTemplateByID(param1.layerTempId);
         var _loc3_:PlanesLayerTemplateInfo = TempleteManager.instance.planesLayerTemplateCate.getTemplateByID(param2.layerTempId);
         if(_loc4_ && _loc3_)
         {
            if(_loc4_.LayerNum < _loc3_.LayerNum)
            {
               return -1;
            }
            if(_loc4_.LayerNum > _loc3_.LayerNum)
            {
               return 1;
            }
            return 0;
         }
         return 0;
      }
      
      public function sendPlanesOpMsg(param1:int, param2:Array = null, param3:Array = null) : void
      {
         var _loc5_:PackageOut = new PackageOut(9527);
         var _loc4_:PlanesWarReqMsg = new PlanesWarReqMsg();
         _loc4_.op = param1;
         if(param2 != null)
         {
            _loc4_.param = param2;
         }
         if(param3 != null)
         {
            _loc4_.paramStr = param3;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendDispatchEvent(param1:String, param2:Object = null) : void
      {
         this.dispatchEvent(new PlanesWarEvent(param1,param2));
      }
      
      public function updateMapAndGridInfo() : void
      {
         model.updateMapData();
         sendDispatchEvent("PLANES_GRIDINFO_UPDATE");
      }
      
      private function moveBackHandler() : void
      {
         sendDispatchEvent("SMALL_MAP_HEROUPDATE");
         if(model.endPoint && model.endPoint.x == model.planesWarInfo.posX && model.endPoint.y == model.planesWarInfo.posY && SceneManager.instance.currentType == "PLANES_WAR_SCENE")
         {
            PlanesWarManager.instance.updateMapAndGridInfo();
            PlanesWarManager.instance.sendPlanesOpMsg(2,[model.planesWarInfo.posX,model.planesWarInfo.posY]);
            model.endPoint = null;
            isNeedOpendEventFrame = true;
            openEventFrame();
         }
      }
      
      private function goLvBackHandler() : void
      {
         SceneManager.instance.setScene("PLANES_WAR_SCENE",null,true);
      }
      
      private function cardSelectBackHandler() : void
      {
         sendDispatchEvent("PLANES_CARDOP_BACK");
      }
      
      private function markerBuyBack() : void
      {
         sendDispatchEvent("PLANES_MARKETOP_BACK");
      }
      
      private function funcBuyBack() : void
      {
         sendDispatchEvent("PLANES_FUNCBUY_BACK");
      }
      
      private function lifeReviveHandler() : void
      {
         sendDispatchEvent("PLANES_REVIVE_BACK");
      }
      
      private function tranesferBackHandler() : void
      {
         model.isInPlanesWar = true;
         SceneManager.instance.setScene("PLANES_WAR_SCENE");
      }
      
      private function leavingBackHandler() : void
      {
         model.isInPlanesWar = false;
         SceneManager.instance.setScene("CASTLE_SCENE");
      }
      
      private function restorePosXYHandler() : void
      {
         sendDispatchEvent("RESTORE_POSXY");
         sendDispatchEvent("SMALL_MAP_HEROUPDATE");
      }
      
      private function helpReviveHandler() : void
      {
         sendDispatchEvent("HELP_RERIVE_BACK");
      }
      
      public function openEventFrame() : void
      {
         var _loc1_:PlanesEventsTemplateInfo = null;
         if(!isNeedOpendEventFrame)
         {
            return;
         }
         if(model.planesWarInfo.eventInfo.eventId != 0)
         {
            _loc1_ = TempleteManager.instance.planesEventsTemplateCate.getTemplateByID(model.planesWarInfo.eventInfo.eventId);
            if(_loc1_)
            {
               PlanesWarManager.instance.control.openEventFrameByEventType(_loc1_.EventType);
               isNeedOpendEventFrame = false;
            }
         }
      }
      
      public function get mapView() : *
      {
         return _mapView;
      }
      
      public function set mapView(param1:*) : void
      {
         _mapView = param1;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get model() : PlanesWarModel
      {
         if(_model == null)
         {
            _model = new PlanesWarModel();
         }
         return _model;
      }
      
      public function get control() : PlanesWarControler
      {
         return FrameControllerManager.instance.planesWarControler;
      }
   }
}

