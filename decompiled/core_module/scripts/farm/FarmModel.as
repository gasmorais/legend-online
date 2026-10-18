package farm
{
   import farm.data.FarmInfo;
   import farm.data.FriendFarmStateInfo;
   import farm.event.FarmEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.manager.TempleteManager;
   import yishi.manager.WaterManager;
   import yishi.utils.SimpleDictionary;
   
   public class FarmModel extends EventDispatcher
   {
      
      public static const OPEN:Boolean = true;
      
      public static const LAND_NUM:int = 18;
      
      public static const DEFAULT_OPEN_LAND:int = 3;
      
      public static const MAX_OPEN_LAND:int = 9;
      
      public static const LANDUP_OPEN_LEVEL:int = 30;
      
      public static const MAX_LAND_LEVEL:int = 10;
      
      public static const MAX_STOLEN_COUNT:int = 3;
      
      public var acceleratePay:int;
      
      public var maxDayStealCount:int;
      
      private var _expWeed:int;
      
      private var _expWorm:int;
      
      private var _expRevive:int;
      
      private var _expGivePower:int = 1;
      
      private var _expTreePick:int = 1;
      
      private var _maxDayGpFromFriend:int;
      
      public var preMapId:int;
      
      public var needReturnSpace:Boolean = false;
      
      private var _fullExpType:int;
      
      private var _farmList:SimpleDictionary;
      
      private var _farmStateList:SimpleDictionary;
      
      private var _curSelectedFarmInfo:FarmInfo;
      
      private var _curSelectedUserInfo:ThaneInfo;
      
      private var _masterId:int;
      
      private var _bigBonFireIsOpen:Boolean;
      
      public var showMountMsgInfo:Array = [];
      
      public var currentMountPos:int = -1;
      
      public var isBigBonfire:Boolean;
      
      private var _leftTime:int;
      
      private var _beginLeftTime:int;
      
      public var showHomeFarmValue:int;
      
      public var currentHomeFrameType:int;
      
      public function FarmModel()
      {
         super();
         _farmList = new SimpleDictionary();
         _farmStateList = new SimpleDictionary();
         _expWeed = _expWorm = _expRevive = int(TempleteManager.instance.getConfigInfoByConfigName("FarmCrop_Operate_GP").ConfigValue);
         _maxDayGpFromFriend = int(TempleteManager.instance.getConfigInfoByConfigName("Farm_TodayFromFriend_GP").ConfigValue);
         maxDayStealCount = int(TempleteManager.instance.getConfigInfoByConfigName("Farm_TodayFromFriend_GP").ConfigValue);
         acceleratePay = int(TempleteManager.instance.getConfigInfoByConfigName("Farm_Accelerate_Point").ConfigValue);
      }
      
      public function get beginLeftTime() : int
      {
         return _beginLeftTime;
      }
      
      public function set beginLeftTime(param1:int) : void
      {
         _beginLeftTime = param1;
         dispatchEvent(new Event("FARM_BONFIRE_BEGIN_TIME"));
      }
      
      public function get leftTime() : int
      {
         return _leftTime;
      }
      
      public function set leftTime(param1:int) : void
      {
         _leftTime = param1;
         dispatchEvent(new Event("FARM_BONFIRE_LEFT_TIME"));
      }
      
      public function get masterId() : int
      {
         return _masterId;
      }
      
      public function set masterId(param1:int) : void
      {
         _masterId = param1;
         dispatchEvent(new Event("FARM_SELECTED_CHANGE"));
      }
      
      public function get bigBonFireIsOpen() : Boolean
      {
         return _bigBonFireIsOpen;
      }
      
      public function set bigBonFireIsOpen(param1:Boolean) : void
      {
         _bigBonFireIsOpen = param1;
         dispatchEvent(new Event("FARM_BIGBONFIRE_STATUS"));
      }
      
      public function get myFarm() : FarmInfo
      {
         return getFarmInfo(thane.userId);
      }
      
      public function getFarmInfo(param1:int) : FarmInfo
      {
         return _farmList[param1];
      }
      
      public function addFarmInfo(param1:FarmInfo) : void
      {
         if(param1)
         {
            _farmList.add(param1.userId,param1);
         }
      }
      
      public function delFarmInfo(param1:int) : void
      {
         _farmList.del(param1);
      }
      
      public function getFarmStateInfo(param1:int) : FriendFarmStateInfo
      {
         var _loc2_:FriendFarmStateInfo = _farmStateList[param1];
         if(!_loc2_)
         {
            _loc2_ = new FriendFarmStateInfo();
            _loc2_.userId = param1;
            _farmStateList.add(param1,_loc2_);
         }
         return _loc2_;
      }
      
      public function get curSelectedFarmInfo() : FarmInfo
      {
         return _curSelectedFarmInfo;
      }
      
      public function get curSelectedUserInfo() : ThaneInfo
      {
         return _curSelectedUserInfo;
      }
      
      public function set curSelectedUserInfo(param1:ThaneInfo) : void
      {
         _curSelectedUserInfo = param1;
      }
      
      public function defaultSelectedUserInfo() : void
      {
         if(_curSelectedUserInfo == null)
         {
            _curSelectedUserInfo = thane;
         }
         if(checkIsSelf(_curSelectedUserInfo.userId) && myFarm)
         {
            _curSelectedFarmInfo = myFarm;
         }
         else
         {
            _curSelectedFarmInfo = new FarmInfo();
            _curSelectedFarmInfo.userId = _curSelectedUserInfo.userId;
            _curSelectedFarmInfo.nickName = _curSelectedUserInfo.nickName;
            addFarmInfo(_curSelectedFarmInfo);
         }
         WaterManager.instance.model.currentSelectedUser = _curSelectedUserInfo;
         FarmManager.instance.sendReqFarmInfo(_curSelectedUserInfo.userId);
         commitSelected();
      }
      
      private function commitSelected() : void
      {
         dispatchEvent(new FarmEvent("SELECTED_CHANGE",_curSelectedFarmInfo,_curSelectedUserInfo));
      }
      
      public function expByOper(param1:int) : int
      {
         var _loc2_:ThaneInfo = null;
         if(!curSelectedFarmInfo)
         {
            return 0;
         }
         var _loc4_:int = 0;
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(myFarm.grade + 1,17);
         switch(param1)
         {
            case 2:
               _loc4_ = _expWorm;
               break;
            case 3:
               _loc4_ = _expWeed;
               break;
            case 8:
               _loc4_ = _expRevive;
               break;
            case 23:
               _loc2_ = FriendManager.getInstance().getFriendById(curSelectedFarmInfo.userId);
               _loc4_ = _expGivePower;
               break;
            case 24:
               _loc4_ = _expTreePick;
               break;
            case 4:
               _loc4_ = 1;
               break;
            case 5:
               _loc4_ = 1;
               break;
            case 7:
               _loc4_ = 1;
         }
         if(myFarm.grade >= thane.grades)
         {
            if(!_loc3_)
            {
               _fullExpType = 1;
               return 0;
            }
            if(_loc3_ && myFarm.gp + _loc4_ > _loc3_.Data)
            {
               _loc4_ = _loc3_.Data - myFarm.gp;
               if(_loc4_ <= 0)
               {
                  _fullExpType = 1;
               }
               return _loc4_;
            }
         }
         if(curSelectedFarmInfo.userId != myFarm.userId && myFarm.dayGpFromFriend + _loc4_ > _maxDayGpFromFriend)
         {
            _loc4_ = _maxDayGpFromFriend - myFarm.dayGpFromFriend;
            if(_loc4_ <= 0)
            {
               _fullExpType = 2;
            }
            return _loc4_;
         }
         return _loc4_;
      }
      
      public function get fullExpType() : int
      {
         return _fullExpType;
      }
      
      public function checkIsSelf(param1:int) : Boolean
      {
         return param1 == thane.userId;
      }
      
      public function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

