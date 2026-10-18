package mvc.module.vehicle
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class DaimonModel extends EventDispatcher
   {
      
      public static const BUFF_ATTACK:int = 2;
      
      public static const BUFF_DEFENCE:int = 1;
      
      public static const BUFF_HP:int = 100;
      
      private var vehicleObjects:Array;
      
      private var pageSize:int = 6;
      
      private var type:int = 24;
      
      private var bossTempId:int = 2191;
      
      private var _currentVehicleTempid:int;
      
      private var _currentPage:int = 1;
      
      public var totalPage:int = 1;
      
      public function DaimonModel(param1:IEventDispatcher = null)
      {
         super(param1);
         vehicleObjects = [];
         var _loc3_:Dictionary = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplates();
         for each(var _loc2_:VehicleObjectTempInfo in _loc3_)
         {
            if(_loc2_.Type == 1)
            {
               vehicleObjects.push(_loc2_);
            }
         }
         totalPage = Math.ceil(vehicleObjects.length / pageSize);
         _currentVehicleTempid = playerInfo.vehicleTempId;
      }
      
      public function get hp() : int
      {
         if(currentVehicleTempid <= 0)
         {
            return 0;
         }
         var _loc2_:int = grade;
         return int(100 * (_loc2_ - 1));
      }
      
      public function get attack() : int
      {
         if(currentVehicleTempid <= 0)
         {
            return 0;
         }
         var _loc2_:int = grade;
         return int(2 * (_loc2_ - 1));
      }
      
      public function get defence() : int
      {
         if(currentVehicleTempid <= 0)
         {
            return 0;
         }
         var _loc2_:int = grade;
         return int(1 * (_loc2_ - 1));
      }
      
      public function get speed() : int
      {
         if(currentVehicleTempid <= 0)
         {
            return 0;
         }
         return vehicleTemplate.Speed;
      }
      
      public function get skillTemplate() : VehicleSkillTempInfo
      {
         return TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(vehicleTemplate.GeniusSkill);
      }
      
      public function get name() : String
      {
         if(playerInfo.vehicleTempId <= 0)
         {
            return "";
         }
         return vehicleTemplate.TemplateName;
      }
      
      public function get grade() : int
      {
         return playerInfo.vehicleGrade;
      }
      
      public function get maxGp() : int
      {
         var _loc1_:Array = TempleteManager.instance.getTemplatesByType(type);
         var _loc3_:int = grade;
         var _loc4_:int = -1;
         for each(var _loc2_:UpgradeTemplateInfo in _loc1_)
         {
            if(_loc2_.Grades == _loc3_ + 1)
            {
               _loc4_ = _loc2_.Data;
            }
         }
         return _loc4_;
      }
      
      public function get curGp() : int
      {
         var _loc4_:int = 0;
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc1_:int = playerInfo.vehicleGp;
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(type);
         _loc2_.sortOn("Grades",16);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_] as UpgradeTemplateInfo;
            _loc5_ = _loc1_ - _loc3_.Data;
            if(_loc5_ < 0)
            {
               break;
            }
            _loc1_ = _loc5_;
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function get activeVehicles() : Array
      {
         return playerInfo.vehicleList;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get vehicleTemplate() : VehicleObjectTempInfo
      {
         return TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(currentVehicleTempid);
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         if(param1 > totalPage)
         {
            return;
         }
         _currentPage = param1;
      }
      
      public function getShowData() : Array
      {
         var _loc1_:int = (_currentPage - 1) * pageSize;
         var _loc2_:int = _currentPage * pageSize;
         vehicleObjects.sort(compareFun);
         totalPage = Math.ceil(vehicleObjects.length / pageSize);
         if(_loc2_ > vehicleObjects.length)
         {
            _loc2_ = int(vehicleObjects.length);
         }
         return vehicleObjects.slice(_loc1_,_loc2_);
      }
      
      private function compareFun(param1:VehicleObjectTempInfo, param2:VehicleObjectTempInfo) : int
      {
         var _loc4_:int = activeVehicles.indexOf(param1.TemplateId);
         var _loc3_:int = activeVehicles.indexOf(param2.TemplateId);
         if(_loc4_ >= 0 && _loc3_ < 0)
         {
            return -1;
         }
         if(_loc4_ < 0 && _loc3_ >= 0)
         {
            return 1;
         }
         return param1.Sort - param2.Sort;
      }
      
      public function isActive(param1:int) : Boolean
      {
         return activeVehicles.indexOf(param1) >= 0;
      }
      
      public function get currentVehicleTempid() : int
      {
         return _currentVehicleTempid;
      }
      
      public function set currentVehicleTempid(param1:int) : void
      {
         if(_currentVehicleTempid == param1)
         {
            return;
         }
         _currentVehicleTempid = param1;
         dispatchEvent(new PlayerEvent("PLAYER_VEHICLE_CHANGE",null));
      }
   }
}

