package mvc.module.buildings
{
   import events.BuildingEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   
   public class BuildingModel extends EventDispatcher
   {
      
      public static const ACTIVE_ORDERID:int = 4;
      
      public static const ACTIVE_ORDERID_CONSORTIA_ALTAR:int = 1;
      
      public static const ACTIVE_ORDERID_OFFER_REWARD:int = 2;
      
      public static const ACTIVE_ORDERID_OUTYARD:int = 3;
      
      public static const ACTIVE_ORDERID_NAVIGATION:int = 4;
      
      public static const ACTIVE_ORDERID_PET_CHALLENGE:int = 5;
      
      public static const ACTIVE_ORDERID_CHALLENGE:int = 6;
      
      public static const ACTIVE_ORDERID_CHILD_PVE:int = 7;
      
      public static const ACTIVE_ORDERID_SKY_BOX_ROAD:int = 8;
      
      public static const ACTIVE_ORDERID_MULTI_COPY:int = 9;
      
      public static const ACTIVE_ORDERID_ARCHAEOLOGY:int = 10;
      
      public static const ACTIVE_ORDERID_CHILD_PATROL:int = 11;
      
      public static const ACTIVE_ORDERID_PLANES:int = 12;
      
      public static const ACTIVE_ORDERID_OUTYARD_EXPLORE:int = 13;
      
      public static const ACTIVE_ORDERID_GLORY_ROAD:int = 14;
      
      public static const ACTIVE_ORDERID_SHUTTLE_ROAD:int = 15;
      
      public static const ACTIVE_SPIRIT_EXPEDITION:int = 16;
      
      public static const ACTIVE_ORDERID_CHANGE:String = "ACTIVE_ORDERID_CHANGE";
      
      public var buildOrderCount:int;
      
      public var buildOrderTotal:int;
      
      public var buildOrderLimit:int = 2;
      
      public var activeOrderCount:int;
      
      public var activeOrderTotal:int;
      
      private var _buildingDicByID:SimpleDictionary;
      
      private var _buildOrderList:Array;
      
      private var _colosseumOrderList:Array;
      
      private var _activeOrderList:Array;
      
      public var fieldDic:SimpleDictionary = new SimpleDictionary(true);
      
      public function BuildingModel()
      {
         super();
         _buildingDicByID = new SimpleDictionary();
         _buildOrderList = [];
         _colosseumOrderList = [];
         _activeOrderList = [];
      }
      
      public function addBuildInfo(param1:BuildInfo) : void
      {
         _buildingDicByID.add(param1.buildingId,param1);
         dispatchEvent(new BuildingEvent("ADD_NEW_BUILD",param1));
      }
      
      public function get buildOrderList() : Array
      {
         return _buildOrderList;
      }
      
      public function get colosseumOrderList() : Array
      {
         return _colosseumOrderList;
      }
      
      public function get activeOrderList() : Array
      {
         return _activeOrderList;
      }
      
      public function setOrderList(param1:Array) : void
      {
         buildOrderCount = 0;
         for each(var _loc2_:BuildingOrderInfo in param1)
         {
            if(_loc2_.orderType == 1)
            {
               if(_loc2_.remainTime > 0)
               {
                  buildOrderCount = buildOrderCount + 1;
               }
               _buildOrderList.push(_loc2_);
            }
            else if(_loc2_.orderType == 4)
            {
               if(_loc2_.remainTime > 0)
               {
                  activeOrderCount = activeOrderCount + 1;
               }
               updateSortId(_loc2_);
               _activeOrderList.push(_loc2_);
            }
         }
         _activeOrderList.sortOn("sortId",16);
         buildOrderTotal = _buildOrderList.length;
         activeOrderTotal = _activeOrderList.length;
      }
      
      public function getOrderById(param1:int) : BuildingOrderInfo
      {
         var _loc2_:* = null;
         for each(_loc2_ in _buildOrderList)
         {
            if(_loc2_.orderId == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in _colosseumOrderList)
         {
            if(_loc2_.orderId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getActiveOrderById(param1:int) : BuildingOrderInfo
      {
         var _loc2_:* = null;
         for each(_loc2_ in _activeOrderList)
         {
            if(_loc2_.orderId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addNewOrder(param1:BuildingOrderInfo) : void
      {
         if(param1.orderType == 1)
         {
            _buildOrderList.push(param1);
            buildOrderTotal = _buildOrderList.length;
         }
         if(param1.orderType == 4)
         {
            _activeOrderList.push(param1);
            updateSortId(param1);
            activeOrderTotal = _activeOrderList.length;
         }
      }
      
      private function updateSortId(param1:BuildingOrderInfo) : void
      {
         if(param1.orderId == 1)
         {
            param1.sortId = 1;
         }
         if(param1.orderId == 2)
         {
            param1.sortId = 2;
         }
         if(param1.orderId == 3)
         {
            param1.sortId = 3;
         }
         if(param1.orderId == 13)
         {
            param1.sortId = 4;
         }
         if(param1.orderId == 4)
         {
            param1.sortId = 5;
         }
         if(param1.orderId == 11)
         {
            param1.sortId = 6;
         }
         if(param1.orderId == 5)
         {
            param1.sortId = 7;
         }
         if(param1.orderId == 6)
         {
            param1.sortId = 8;
         }
         if(param1.orderId == 7)
         {
            param1.sortId = 9;
         }
         if(param1.orderId == 8)
         {
            param1.sortId = 10;
         }
         if(param1.orderId == 9)
         {
            param1.sortId = 11;
         }
         if(param1.orderId == 10)
         {
            param1.sortId = 12;
         }
         if(param1.orderId == 12)
         {
            param1.sortId = 13;
         }
         if(param1.orderId == 14)
         {
            param1.sortId = 14;
         }
         if(param1.orderId == 15)
         {
            param1.sortId = 15;
         }
         if(param1.orderId == 16)
         {
            param1.sortId = 16;
         }
      }
      
      public function checkHasIdleColosseumOrder() : Boolean
      {
         for each(var _loc1_:BuildingOrderInfo in _colosseumOrderList)
         {
            if(_loc1_.remainTime <= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setBuilding(param1:BuildInfo) : BuildInfo
      {
         param1.sonType = param1.templeteInfo.SonType;
         var _loc2_:BuildInfo = _buildingDicByID[param1.buildingId];
         if(_loc2_)
         {
            _loc2_.synchronization(param1);
            return _loc2_;
         }
         _buildingDicByID.add(param1.buildingId,param1);
         return param1;
      }
      
      public function getBuildingInfoByBID(param1:int) : BuildInfo
      {
         return _buildingDicByID[param1] as BuildInfo;
      }
      
      public function canBuildOrUpgradeByBuildingId(param1:int) : String
      {
         var _loc2_:BuildInfo = getBuildingInfoByBID(param1);
         return canBuildOrUpgradeByBuildingInfo(_loc2_);
      }
      
      public function canBuildOrUpgradeByBuildingInfo(param1:BuildInfo) : String
      {
         var _loc2_:String = null;
         if(param1 == null)
         {
            _loc2_ = LanguageMgr.GetTranslation("castle.datas.BuildingModel.str");
            throw new ArgumentError("canBuildOrUpgradeByBuildingInfo" + _loc2_ + "null!");
         }
         var _loc3_:BuildingTempInfo = param1.templeteInfo;
         if(param1.templateId == 0)
         {
            _loc3_ = TempleteManager.instance.buildTemplateCate.getMinGradeBuildingTemplete(_loc3_.SonType);
         }
         else
         {
            _loc3_ = TempleteManager.instance.buildTemplateCate.getTemplateByID(_loc3_.NextGradeTemplateId);
            if(_loc3_ == null)
            {
               return LanguageMgr.GetTranslation("SeminaryFrameRightView.command06");
            }
         }
         return getPreBuilding(_loc3_);
      }
      
      public function getPreBuilding(param1:BuildingTempInfo, param2:Boolean = false, param3:Boolean = false) : String
      {
         var _loc8_:BuildingTempInfo = null;
         var _loc11_:BuildInfo = null;
         var _loc9_:BuildingTempInfo = null;
         var _loc4_:String = "";
         var _loc5_:String = "";
         var _loc10_:String = "";
         var _loc6_:Array = param1.PreTemplateId.split(",");
         for each(var _loc7_:int in _loc6_)
         {
            if(_loc7_ != 0)
            {
               _loc8_ = TempleteManager.instance.buildTemplateCate.getTemplateByID(_loc7_);
               _loc5_ += _loc8_.BuildingName + " " + LanguageMgr.GetTranslation("public.level2",_loc8_.BuildingGrade) + "、";
               _loc11_ = getBuildingInfoBySonType(_loc8_.SonType);
               if(_loc11_ == null)
               {
                  _loc4_ += _loc8_.BuildingName + " " + LanguageMgr.GetTranslation("public.level2",_loc8_.BuildingGrade) + "、";
               }
               else
               {
                  _loc9_ = _loc11_.templeteInfo;
                  if(_loc9_.BuildingGrade < _loc8_.BuildingGrade)
                  {
                     _loc4_ += _loc8_.BuildingName + " " + LanguageMgr.GetTranslation("public.level2",_loc8_.BuildingGrade) + "、";
                  }
               }
               if(param1.TemplateId >= 10000)
               {
                  _loc10_ += _loc8_.BuildingName + " " + LanguageMgr.GetTranslation("public.level2",_loc8_.BuildingGrade) + "、";
               }
            }
         }
         if(StringHelper.isNullOrEmpty(_loc4_) == false)
         {
            _loc4_ = _loc4_.substr(0,_loc4_.lastIndexOf("、"));
         }
         if(param2)
         {
            if(param3)
            {
               return _loc10_;
            }
            return _loc5_.substr(0,_loc5_.lastIndexOf("、"));
         }
         if(param3)
         {
            return _loc10_;
         }
         return _loc4_;
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
      
      public function getBuildingInfoByMasterType(param1:int) : BuildInfo
      {
         for each(var _loc2_:BuildInfo in _buildingDicByID)
         {
            if(_loc2_.templeteInfo.MasterType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBuildingInfoBySonType(param1:int) : BuildInfo
      {
         for each(var _loc2_:BuildInfo in _buildingDicByID)
         {
            if(_loc2_.templeteInfo.SonType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function isMaxLevel(param1:int) : Boolean
      {
         var _loc2_:BuildInfo = _buildingDicByID[param1] as BuildInfo;
         if(_loc2_.templateId == 0)
         {
            return false;
         }
         if(TempleteManager.instance.buildTemplateCate.getTemplateByID(_loc2_.templateId).NextGradeTemplateId == 0)
         {
            return true;
         }
         return false;
      }
      
      public function isExistBuildingBySonType(param1:int) : Boolean
      {
         for each(var _loc2_:BuildInfo in _buildingDicByID)
         {
            if(_loc2_.sonType == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isExistBuildingBySontypeAndLevel(param1:int, param2:int) : Boolean
      {
         for each(var _loc3_:BuildInfo in _buildingDicByID)
         {
            if(_loc3_.sonType == param1 && _loc3_.templeteInfo.BuildingGrade >= param2)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get buildingListByID() : SimpleDictionary
      {
         return _buildingDicByID;
      }
      
      public function allExistTec() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:BuildInfo in _buildingDicByID)
         {
            if((_loc2_.templeteInfo.MasterType == 13 || _loc2_.templeteInfo.MasterType == 14) && _loc2_.templeteInfo.BuildingGrade != 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getMaxEffectBuildingTemplate(param1:PawnTemplate) : Array
      {
         var _loc5_:BuildingTempInfo = null;
         var _loc3_:BuildInfo = null;
         var _loc2_:Array = param1.NeedBuilding.split("、");
         var _loc4_:Array = [];
         for each(var _loc6_:int in _loc2_)
         {
            _loc5_ = TempleteManager.instance.buildTemplateCate.getTemplateByID(_loc6_);
            _loc3_ = getBuildingInfoBySonType(_loc5_.SonType);
            _loc5_ = _loc3_.templeteInfo;
            _loc4_.push(_loc5_);
         }
         return _loc4_;
      }
      
      public function getTitanPawnTimeEffect(param1:PawnTemplate) : Number
      {
         var _loc3_:Number = NaN;
         var _loc2_:Array = getMaxEffectBuildingTemplate(param1);
         var _loc4_:BuildingTempInfo = _loc2_.sortOn("Property3",0x10 | 2)[0] as BuildingTempInfo;
         var _loc5_:BuildInfo = getBuildingInfoByMasterType(10);
         if(_loc5_)
         {
            return (int(_loc4_.Property3 - _loc5_.templeteInfo.Property3)) / 100;
         }
         return _loc4_.Property3 / 100;
      }
   }
}

