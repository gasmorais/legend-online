package yishi.manager
{
   import com.road.yishi.proto.building.BuildOrderList;
   import com.road.yishi.proto.building.BuildingInfoListMsg;
   import com.road.yishi.proto.building.BuildingInfoMsg;
   import com.road.yishi.proto.building.GiveupWildLandMsg;
   import com.road.yishi.proto.building.OrderInfoMsg;
   import com.road.yishi.proto.building.OrderQuickRspMsg;
   import com.road.yishi.proto.building.TransInfoMsg;
   import com.road.yishi.proto.castle.CastleYieldMsg;
   import com.road.yishi.proto.castle.CastleYieldMsg.WildYieldMsg;
   import com.road.yishi.proto.simple.GoldImposeMsg;
   import events.BuildOrderEvent;
   import events.BuildingEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import managers.BuildingSocketOutManager;
   import map.campaign.CampaignManager;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.buildings.BuildingModel;
   import mvc.module.buildings.FieldData;
   import ui.queuebar.QueueBar;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class BuildingManager extends EventDispatcher
   {
      
      private static var _instance:BuildingManager;
      
      public var castleMap:DisplayObject;
      
      private var _model:BuildingModel;
      
      private var _isShowBuildingName:Boolean = true;
      
      public function BuildingManager()
      {
         super();
      }
      
      public static function get instance() : BuildingManager
      {
         if(!_instance)
         {
            _instance = new BuildingManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new BuildingModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4130,__updateBuildInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4187,__loadBuildOrderHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 102,__orderCoolHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 104,__addOrderHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 103,__transerAddPowerHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 108,__unoccupyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4242,__levyUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 152,__politicsDataHandler);
      }
      
      private function __politicsDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:WildYieldMsg = null;
         var _loc3_:FieldData = null;
         _model.fieldDic.clear();
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:CastleYieldMsg = new CastleYieldMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as CastleYieldMsg;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.wildYield.length)
         {
            _loc4_ = _loc2_.wildYield[_loc5_] as WildYieldMsg;
            _loc3_ = _model.fieldDic[_loc4_.wildPoxName] as FieldData;
            if(!_loc3_)
            {
               _loc3_ = new FieldData();
               _model.fieldDic.add(_loc4_.wildPoxName,_loc3_);
            }
            _loc3_.mapId = _loc4_.mapId;
            _loc3_.site = _loc4_.wildPoxName;
            _loc3_.pos = _loc4_.wildPox;
            _loc3_.fieldGrade = _loc4_.wildGrade;
            _loc3_.fieldName = _loc4_.wildName;
            _loc3_.yield = _loc4_.wildYield;
            _loc3_.refreshTime = _loc4_.wildRefreshTime;
            _loc3_.createDate = DateFormatter.parse(_loc4_.createTime,"YYYY-MM-DD hh:mm:ss");
            _loc5_++;
         }
         dispatchEvent(new BuildingEvent("U_SECURITY_INFO_UPDATE"));
      }
      
      private function __levyUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GoldImposeMsg = new GoldImposeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GoldImposeMsg;
         var _loc4_:BuildInfo = model.getBuildingInfoBySonType(901);
         if(_loc4_)
         {
            _loc4_.property1 = _loc2_.leftImpose;
            _loc4_.property2 = _loc2_.maxImpose;
            dispatchEvent(new BuildingEvent("U_C_GOLD_IMPOSERESULT"));
         }
      }
      
      private function __updateBuildInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc8_:BuildInfo = null;
         var _loc6_:Boolean = false;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:BuildingInfoListMsg = new BuildingInfoListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as BuildingInfoListMsg;
         var _loc3_:Boolean = _loc2_.result;
         if(_loc3_)
         {
            for each(var _loc4_:BuildingInfoMsg in _loc2_.building)
            {
               _loc5_ = _loc4_.buildingId;
               _loc8_ = _model.getBuildingInfoByBID(_loc4_.buildingId);
               _loc6_ = false;
               if(!_loc8_)
               {
                  _loc8_ = new BuildInfo();
                  _loc6_ = true;
               }
               _loc8_.buildingId = _loc4_.buildingId;
               _loc8_.templateId = _loc4_.templateId;
               _loc8_.property1 = _loc4_.propterty1;
               _loc8_.property2 = _loc4_.propterty2;
               _loc8_.sonType = _loc4_.sonType;
               if(_loc6_)
               {
                  _model.addBuildInfo(_loc8_);
                  dispatchEvent(new BuildingEvent("CREATE_NEW_BUILDING",_loc8_));
               }
               else
               {
                  dispatchEvent(new BuildingEvent("BUILDING_UPGRADE_RECEIVE",_loc8_));
               }
               if(_loc8_.templeteInfo.MasterType == 13 || _loc8_.templeteInfo.MasterType == 14)
               {
                  NotificationManager.instance.sendNotification("UPDATE_EXTRABUFFER");
               }
            }
         }
      }
      
      private function calcOrderCount() : void
      {
         var _loc1_:* = null;
         model.buildOrderCount = 0;
         for each(_loc1_ in model.buildOrderList)
         {
            if(_loc1_.remainTime > 0)
            {
               model.buildOrderCount++;
            }
         }
      }
      
      private function __loadBuildOrderHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:BuildingOrderInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:BuildOrderList = new BuildOrderList();
         _loc2_ = _loc6_.readBody(_loc2_) as BuildOrderList;
         var _loc3_:Array = [];
         for each(var _loc5_:OrderInfoMsg in _loc2_.buildOrder)
         {
            _loc4_ = model.getOrderById(_loc5_.orderId);
            if(_loc4_)
            {
               _loc4_.remainTime = _loc5_.remainTime;
            }
         }
         calcOrderCount();
         dispatchEvent(new Event("UPDATE_ORDER"));
      }
      
      private function __orderCoolHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:BuildingOrderInfo = null;
         var _loc3_:String = null;
         var _loc7_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:OrderQuickRspMsg = new OrderQuickRspMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as OrderQuickRspMsg;
         var _loc5_:int = int(_loc2_.orderInfo.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = int(OrderInfoMsg(_loc2_.orderInfo[_loc6_]).orderId);
            _loc9_ = _model.getOrderById(_loc4_);
            if(!_loc9_)
            {
               _loc3_ = LanguageMgr.GetTranslation("yishi.manager.BuildingManager.command01");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            _loc7_ = int(OrderInfoMsg(_loc2_.orderInfo[_loc6_]).orderType);
            _loc9_.remainTime = OrderInfoMsg(_loc2_.orderInfo[_loc6_]).remainTime;
            calcOrderCount();
            dispatchEvent(new BuildOrderEvent("COLL_ONE_ORDER",_loc9_));
            _loc6_++;
         }
      }
      
      private function __addOrderHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:OrderInfoMsg = new OrderInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as OrderInfoMsg;
         var _loc4_:BuildingOrderInfo = new BuildingOrderInfo();
         _loc4_.orderId = _loc2_.orderId;
         _loc4_.orderType = _loc2_.orderType;
         _loc4_.remainTime = _loc2_.remainTime;
         _model.addNewOrder(_loc4_);
         dispatchEvent(new BuildOrderEvent("ADD_ONE_ORDER",_loc4_));
      }
      
      private function __transerAddPowerHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TransInfoMsg = new TransInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TransInfoMsg;
         var _loc3_:int = _loc2_.currentEnergy;
         var _loc5_:BuildInfo = model.buildingListByID[-11];
         _loc5_.property1 = _loc3_;
         dispatchEvent(new BuildingEvent("TRANSFER_POWER_SUCCESS",_loc3_));
      }
      
      private function __unoccupyHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:GiveupWildLandMsg = new GiveupWildLandMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as GiveupWildLandMsg;
         var _loc3_:String = _loc2_.wildLandPos;
         if(_loc3_ != "" && _loc3_ != null)
         {
            _loc4_ = LanguageMgr.GetTranslation("yishi.manager.BuildingManager.command02");
            MessageTipManager.instance().show(_loc4_);
         }
         dispatchEvent(new BuildingEvent("U_UNOCCPWILDLAND",_loc3_));
      }
      
      public function upgradeBuildingByBuildingInfo(param1:BuildInfo) : void
      {
         if(!param1)
         {
            return;
         }
         BuildingSocketOutManager.sendUpgradeBuild(param1.buildingId);
      }
      
      public function setSelfBuildingInfo(param1:Array) : void
      {
         for each(var _loc2_:BuildInfo in param1)
         {
            _model.addBuildInfo(_loc2_);
         }
      }
      
      public function creatBuilding(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc5_:BuildInfo = null;
         var _loc4_:BuildingTempInfo = TempleteManager.instance.buildTemplateCate.getMinGradeBuildingTemplete(param1);
         var _loc2_:String = ResourceManager.instance.canSubtractResources(_loc4_.GoldConsume,_loc4_.CrystalsConsume);
         if(_loc2_ != null)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.BuildingManager.command03",_loc2_);
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         _loc5_ = new BuildInfo();
         _loc5_.templateId = _loc4_.TemplateId;
         _loc5_.sonType = _loc4_.SonType;
         _loc2_ = BuildingManager.instance.model.canBuildOrUpgradeByBuildingInfo(_loc5_);
         if(StringHelper.isNullOrEmpty(_loc2_) == false)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.BuildingManager.command04",_loc2_);
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         BuildingSocketOutManager.sendCreateBuild(param1);
      }
      
      public function checkBuildList(param1:BuildInfo) : Boolean
      {
         var _loc2_:String = null;
         if(_model.buildOrderCount >= _model.buildOrderTotal)
         {
            _loc2_ = "";
            if(_model.buildOrderTotal >= _model.buildOrderLimit)
            {
               _loc2_ = LanguageMgr.GetTranslation("yishi.manager.BuildingManager.command05");
               MessageTipManager.instance().show(_loc2_);
               QueueBar.instance.playItemEffect(1);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("yishi.manager.BuildingManager.command06");
               MessageTipManager.instance().show(_loc2_);
               QueueBar.instance.playItemEffect(1);
            }
            return false;
         }
         return true;
      }
      
      public function allCoolBack(param1:Boolean, param2:int = 0, param3:int = 0, param4:Boolean = true) : void
      {
         var _loc5_:BuildingOrderInfo = null;
         if(param1)
         {
            if(param2 != 0)
            {
               _loc5_ = model.getOrderById(param2);
               if(_loc5_.remainTime <= 0)
               {
                  return;
               }
            }
            else if(point <= 0)
            {
               return;
            }
            BuildingSocketOutManager.sendCoolOrder(param2,param3,param4);
         }
         dispatchEvent(new BuildingEvent("UNAPPLY",model.getOrderById(param2)));
      }
      
      private function get point() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:BuildingOrderInfo in _model.buildOrderList)
         {
            _loc1_ += Math.ceil(_loc2_.remainTime / 600);
         }
         return _loc1_;
      }
      
      public function isUpgradeAvaliable(param1:BuildInfo) : Boolean
      {
         if(checkIsMaxLevel(param1))
         {
            return false;
         }
         if(!checkEnoughResource(param1))
         {
            return false;
         }
         if(!checkPreBuild(param1))
         {
            return false;
         }
         if(!checkPlayerGrade(param1))
         {
            return false;
         }
         return true;
      }
      
      public function checkIsMaxLevel(param1:BuildInfo) : Boolean
      {
         return _model.isMaxLevel(param1.buildingId);
      }
      
      private function checkEnoughResource(param1:BuildInfo) : Boolean
      {
         var _loc4_:BuildingTempInfo = param1.templeteInfo;
         var _loc3_:BuildingTempInfo = TempleteManager.instance.buildTemplateCate.getTemplateByID(param1.templeteInfo.NextGradeTemplateId);
         var _loc2_:String = ResourceManager.instance.canSubtractResources(_loc3_.GoldConsume,_loc3_.CrystalsConsume);
         if(StringHelper.isNullOrEmpty(_loc2_) == false)
         {
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         return true;
      }
      
      private function checkPreBuild(param1:BuildInfo) : Boolean
      {
         var _loc3_:String = null;
         var _loc2_:String = model.canBuildOrUpgradeByBuildingInfo(param1);
         if(StringHelper.isNullOrEmpty(_loc2_) == false)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.manager.BuildingManager.command07",_loc2_);
            MessageTipManager.instance().show(_loc3_);
            return false;
         }
         return true;
      }
      
      private function checkPlayerGrade(param1:BuildInfo) : Boolean
      {
         var _loc2_:String = null;
         var _loc4_:BuildingTempInfo = param1.templeteInfo;
         var _loc3_:BuildingTempInfo = TempleteManager.instance.buildTemplateCate.getTemplateByID(_loc4_.NextGradeTemplateId);
         if(_loc3_.PlayerGrades > thane.grades)
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.manager.BuildingManager.command08",_loc3_.PlayerGrades);
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         return true;
      }
      
      public function isExistBuildingBySonType(param1:int) : Boolean
      {
         return _model.isExistBuildingBySonType(param1);
      }
      
      public function isExistBuildBySontypeAndLevel(param1:int, param2:int) : Boolean
      {
         return _model.isExistBuildingBySontypeAndLevel(param1,param2);
      }
      
      public function getBuildingInfoBySonType(param1:int) : BuildInfo
      {
         return _model.getBuildingInfoBySonType(param1);
      }
      
      public function getMaxEffectBuildingTemplate(param1:PawnTemplate) : Array
      {
         return _model.getMaxEffectBuildingTemplate(param1);
      }
      
      public function getTitanPawnTimeEffect(param1:PawnTemplate) : Number
      {
         return _model.getTitanPawnTimeEffect(param1);
      }
      
      public function getPreBuildingList(param1:BuildingTempInfo) : Array
      {
         var _loc4_:BuildingTempInfo = null;
         var _loc5_:Array = [];
         var _loc2_:Array = param1.PreTemplateId.split(",");
         for each(var _loc3_:int in _loc2_)
         {
            if(_loc3_ != 0)
            {
               _loc4_ = TempleteManager.instance.buildTemplateCate.getTemplateByID(_loc3_);
               _loc5_.push(_loc4_);
            }
         }
         return _loc5_;
      }
      
      public function checkMilitaryTecMaxGrade() : Boolean
      {
         for each(var _loc1_:BuildInfo in _model.buildingListByID)
         {
            if(_loc1_.templeteInfo.MasterType == 5 && _loc1_.templeteInfo.BuildingGrade < 12)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkMilitaryGrade() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         if(CampaignManager.instance.mapModel)
         {
            _loc2_ = CampaignManager.instance.mapModel.mapId;
            if(WorldBossHelper.checkMaze(_loc2_) || WorldBossHelper.checkPve())
            {
               _loc1_ = true;
            }
         }
         if(!_loc1_)
         {
            return false;
         }
         for each(var _loc3_:BuildInfo in _model.buildingListByID)
         {
            if(_loc3_.templeteInfo.MasterType == 4)
            {
               if(thane.grades >= 20 && thane.grades < 30 && _loc3_.templeteInfo.BuildingGrade < 20)
               {
                  return true;
               }
               if(thane.grades >= 30 && thane.grades <= 40 && _loc3_.templeteInfo.BuildingGrade < 30)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get model() : BuildingModel
      {
         return _model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get isShowBuildingName() : Boolean
      {
         return _isShowBuildingName;
      }
      
      public function set isShowBuildingName(param1:Boolean) : void
      {
         if(_isShowBuildingName == param1)
         {
            return;
         }
         _isShowBuildingName = param1;
         dispatchEvent(new BuildingEvent("building_name_show_hide",null));
      }
   }
}

