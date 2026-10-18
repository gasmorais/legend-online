package mvc.module.oldplayerreturn
{
   import com.road.yishi.proto.allianceregression.AllyData;
   import com.road.yishi.proto.allianceregression.TaskData;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.OldPlayerReturnPrivilegeTempInfo;
   import yishi.datas.templates.OldPlayerReturnTaskTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleDictionary;
   
   public class OldPlayerReturnModel
   {
      
      public static const DAY_REWARD:int = 1;
      
      public static const WEEK_REWARD:int = 2;
      
      public static const MILESTONE_REWARD:int = 3;
      
      public static const CONTRACT_REWARD:int = 4;
      
      public static const PAGE_NUM:int = 9;
      
      public static const TIMEVORTEX:int = 104;
      
      public static const DEMONLAND:int = 105;
      
      public static const FORBIDDENBOSS:int = 106;
      
      public static const INCREASINGLYROAD:int = 107;
      
      public var isOpen:Boolean = false;
      
      public var isShopOpen:Boolean = false;
      
      public var startDate:String;
      
      public var stopDate:String;
      
      public var type:int;
      
      public var status:int;
      
      public var revokeDate:String;
      
      public var oracleExp:int;
      
      public var dailyNum:int;
      
      public var dailyProcess:String;
      
      public var weekNum:int;
      
      public var weekProcess:String;
      
      public var milestoneScore:int;
      
      public var milestoneProcess:String;
      
      public var returnList:Array = [];
      
      public var oracleList:Array = [];
      
      public var allianceList:Array = [];
      
      public var allyList:Array = [];
      
      public var applyList:Array = [];
      
      public var inviteList:Array = [];
      
      public var shopLimitList:SimpleDictionary = new SimpleDictionary();
      
      public var playerList:Array = [];
      
      private var _currentPage:int = 1;
      
      private var _selectedAllyId:int = 0;
      
      public function OldPlayerReturnModel()
      {
         super();
      }
      
      public function get selectedAllyId() : int
      {
         return _selectedAllyId;
      }
      
      public function set selectedAllyId(param1:int) : void
      {
         _selectedAllyId = param1;
         NotificationManager.instance.sendNotification("SELECTED_ALLYID_EVENT");
      }
      
      public function get isReturnPlayer() : Boolean
      {
         return type == 1;
      }
      
      public function refreshTaskData(param1:Array) : void
      {
         var _loc3_:OldPlayerReturnTaskTempInfo = null;
         returnList = [];
         oracleList = [];
         allianceList = [];
         for each(var _loc2_:TaskData in param1)
         {
            _loc3_ = TempleteManager.instance.oldPlayerReturnTaskTempCate.getTempInfoById(_loc2_.templateId);
            if(_loc3_)
            {
               if(_loc3_.TaskList == 1)
               {
                  returnList.push(_loc2_);
               }
               else if(_loc3_.TaskList == 2)
               {
                  oracleList.push(_loc2_);
               }
               else
               {
                  allianceList.push(_loc2_);
               }
            }
         }
         returnList.sort(sortFun);
         oracleList.sort(sortFun);
      }
      
      private function sortFun(param1:TaskData, param2:TaskData) : int
      {
         var _loc4_:OldPlayerReturnTaskTempInfo = TempleteManager.instance.oldPlayerReturnTaskTempCate.getTempInfoById(param1.templateId);
         var _loc3_:OldPlayerReturnTaskTempInfo = TempleteManager.instance.oldPlayerReturnTaskTempCate.getTempInfoById(param2.templateId);
         if(param1.status == 1)
         {
            if(param2.status == 1)
            {
               if(_loc4_.TaskId < _loc3_.TaskId)
               {
                  return -1;
               }
               if(_loc4_.TaskId > _loc3_.TaskId)
               {
                  return 1;
               }
               return 0;
            }
            return -1;
         }
         if(param1.status == 0)
         {
            if(param2.status == 1)
            {
               return 1;
            }
            if(param2.status == 0)
            {
               if(_loc4_.TaskId < _loc3_.TaskId)
               {
                  return -1;
               }
               if(_loc4_.TaskId > _loc3_.TaskId)
               {
                  return 1;
               }
               return 0;
            }
            return -1;
         }
         return 1;
      }
      
      public function get contractLevel() : int
      {
         var _loc2_:int = 1;
         for each(var _loc1_:AllyData in allyList)
         {
            if(isReturnPlayer)
            {
               if(_loc1_.isBinding)
               {
                  _loc2_ = _loc1_.contractLevel;
               }
            }
            else if(_loc2_ < _loc1_.contractLevel)
            {
               _loc2_ = _loc1_.contractLevel;
            }
         }
         return _loc2_;
      }
      
      public function get shopArr() : Array
      {
         var _loc2_:int = 0;
         var _loc4_:Array = null;
         var _loc1_:Array = [];
         var _loc3_:int = 1;
         if(thane.vocationGrades > 0)
         {
            _loc3_ = 2;
         }
         if(thane.isChangeJob)
         {
            _loc3_ = 3;
         }
         if(thane.isAvenger)
         {
            _loc3_ = 4;
         }
         if(thane.isHoly)
         {
            _loc3_ = 5;
         }
         _loc2_ = 1;
         while(_loc2_ <= _loc3_)
         {
            _loc4_ = TempleteManager.instance.oldPlayerReturnShopTempCate.getTempInfoArrByType(type,_loc2_);
            _loc1_ = _loc1_.concat(_loc4_);
            _loc2_++;
         }
         _loc1_.sortOn("CommodityNum",16);
         return _loc1_;
      }
      
      public function get totalPage() : int
      {
         return Math.ceil(shopArr.length / 9);
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         param1 = int(param1 <= 0 ? 1 : param1);
         _currentPage = param1;
      }
      
      public function shopPageBtnHandler(param1:Boolean) : void
      {
         if(param1 && currentPage > 1)
         {
            currentPage = currentPage - 1;
         }
         else if(!param1 && currentPage < totalPage)
         {
            currentPage = currentPage + 1;
         }
      }
      
      public function getShopShowList() : Array
      {
         var _loc1_:int = (currentPage - 1) * 9;
         var _loc2_:int = _loc1_ + 9;
         if(_loc2_ > shopArr.length)
         {
            _loc2_ = int(shopArr.length);
         }
         return shopArr.slice(_loc1_,_loc2_);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get selectedAllydata() : AllyData
      {
         if(allyList.length > 0)
         {
            for each(var _loc1_:AllyData in allyList)
            {
               if(_loc1_.player.userId == selectedAllyId)
               {
                  return _loc1_;
               }
            }
         }
         return null;
      }
      
      public function get allyMaxLevel() : int
      {
         var _loc1_:int = 0;
         if(allyList.length > 0)
         {
            for each(var _loc2_:AllyData in allyList)
            {
               if(_loc1_ < _loc2_.contractLevel)
               {
                  _loc1_ = _loc2_.contractLevel;
               }
            }
         }
         return _loc1_;
      }
      
      public function get otherLevelArr() : Array
      {
         var _loc1_:Array = [];
         if(allyList.length > 0)
         {
            for each(var _loc2_:AllyData in allyList)
            {
               if(_loc2_.player.userId != selectedAllyId)
               {
                  _loc1_.push(_loc2_.contractLevel);
               }
            }
         }
         _loc1_.sort(16);
         return _loc1_;
      }
      
      public function get timeVortexCount() : int
      {
         return getCount(104);
      }
      
      public function get demonLandCount() : int
      {
         return getCount(105);
      }
      
      public function get forbiddenBossCount() : int
      {
         return getCount(106);
      }
      
      public function get increasinglyRoadCount() : int
      {
         return getCount(107);
      }
      
      public function getCount(param1:int) : int
      {
         var _loc2_:OldPlayerReturnPrivilegeTempInfo = null;
         var _loc3_:SimpleDictionary = TempleteManager.instance.oldPlayerReturnPrivilegeTempCate.getDicByTypePrivilege(type,param1);
         if(_loc3_[contractLevel] && allyList.length > 0 && isOpen)
         {
            _loc2_ = _loc3_[contractLevel];
            return _loc2_.PrivilegeValue;
         }
         return 0;
      }
      
      public function get shopDate() : String
      {
         var _loc4_:int = ConfigInfoManager.instance.allianceDelaydays;
         var _loc1_:Date = DateFormatter.parse(stopDate,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Number = _loc1_.time + _loc4_ * 24 * 3600 * 1000;
         var _loc2_:Date = new Date(_loc3_);
         return DateFormatter.timeFormat4(_loc2_);
      }
   }
}

