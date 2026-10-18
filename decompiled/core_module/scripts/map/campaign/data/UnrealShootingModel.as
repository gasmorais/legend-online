package map.campaign.data
{
   import flash.events.EventDispatcher;
   import map.campaign.event.UnrealShootingEvent;
   import yishi.datas.ConfigInfoManager;
   
   public class UnrealShootingModel extends EventDispatcher
   {
      
      public static const VEHICLE_TEMPLATE_TYPE:int = 12;
      
      public static const RANK_LIST_PAGE_NUM:int = 10;
      
      public static const MAX_ENTERCOUNT:int = 1;
      
      public static const TEAM_BLUE:int = 1;
      
      public static const TEAM_RED:int = 2;
      
      public var showUnrealShootingBtn:Boolean;
      
      public var shineUnrealShootingBtn:Boolean;
      
      public var leftTime:int;
      
      public var selfPoint:int;
      
      public var selfScore:int;
      
      public var selfTeam:int;
      
      public var openDate:Date;
      
      public var endDate:Date;
      
      public var enterCount:int;
      
      public var teamScoreBlue:int;
      
      public var teamScoreRed:int;
      
      public var currentTime:int;
      
      public var isLocked:Boolean;
      
      public var inFiveSecondCounting:Boolean;
      
      public var myRankInfo:UnrealShootingUserInfo;
      
      private var _selectedTempalteId:int;
      
      private var _finalOrderList:Array = [];
      
      private var _rankDetailList:Array = [];
      
      private var _playerList:Array = [];
      
      private var _unrealShootingTimeArray:Array = [];
      
      private var _unrealShootingPrepareTimeArray:Array = [];
      
      private var _unrealShootingBuffArray:Array = [];
      
      private var _unrealShootingBuffCostArray:Array = [];
      
      public function UnrealShootingModel()
      {
         super();
         var _loc1_:String = ConfigInfoManager.instance.getUnrealshootingTime();
         parseUnrealShootingTime(_loc1_);
         var _loc2_:String = ConfigInfoManager.instance.getUnrealshootingBuffer();
         parseUnrealShootingBuff(_loc2_);
      }
      
      private function parseUnrealShootingTime(param1:String) : void
      {
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:Date = new Date();
         var _loc2_:Array = param1.split("|");
         _loc8_ = 0;
         while(_loc8_ < _loc2_.length)
         {
            _loc10_ = String(_loc2_[_loc8_]);
            _loc9_ = _loc10_.split(",");
            _loc7_ = String(_loc9_[0]);
            _loc6_ = String(_loc9_[1]);
            _loc9_ = _loc7_.split(":");
            _loc4_ = int(_loc9_[0]);
            _loc3_ = int(_loc9_[1]);
            _unrealShootingTimeArray.push(_loc4_);
            _unrealShootingTimeArray.push(_loc3_);
            _loc5_.hours = _loc4_;
            _loc5_.minutes = _loc3_;
            _loc9_ = _loc6_.split(":");
            _loc4_ = int(_loc9_[0]);
            _loc3_ = int(_loc9_[1]);
            _unrealShootingTimeArray.push(_loc4_);
            _unrealShootingTimeArray.push(_loc3_);
            _loc5_.minutes -= 5;
            _loc4_ = _loc5_.hours;
            _loc3_ = _loc5_.minutes;
            _unrealShootingPrepareTimeArray.push(_loc4_);
            _unrealShootingPrepareTimeArray.push(_loc3_);
            _loc5_.minutes += 4;
            _loc4_ = _loc5_.hours;
            _loc3_ = _loc5_.minutes;
            _unrealShootingPrepareTimeArray.push(_loc4_);
            _unrealShootingPrepareTimeArray.push(_loc3_);
            _loc8_++;
         }
      }
      
      private function parseUnrealShootingBuff(param1:String) : void
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Array = param1.split("|");
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc5_ = String(_loc2_[_loc6_]);
            _loc4_ = _loc5_.split(",");
            _loc7_ = int(_loc4_[0]);
            _loc3_ = int(_loc4_[1]);
            _unrealShootingBuffArray.push(_loc7_);
            _unrealShootingBuffCostArray.push(_loc3_);
            _loc6_++;
         }
      }
      
      public function get unrealShootingTimeArray() : Array
      {
         return _unrealShootingTimeArray;
      }
      
      public function get unrealShootingPrepareTimeArray() : Array
      {
         return _unrealShootingPrepareTimeArray;
      }
      
      public function get unrealShootingBuffArray() : Array
      {
         return _unrealShootingBuffArray;
      }
      
      public function get unrealShootingBuffCostArray() : Array
      {
         return _unrealShootingBuffCostArray;
      }
      
      public function get selectedTempalteId() : int
      {
         return _selectedTempalteId;
      }
      
      public function set selectedTempalteId(param1:int) : void
      {
         _selectedTempalteId = param1;
         this.dispatchEvent(new UnrealShootingEvent("UNREAL_SHOOTING_TEMPLATE_ID_CHANGE",param1));
      }
      
      public function get playerList() : Array
      {
         return _playerList;
      }
      
      public function set playerList(param1:Array) : void
      {
         _playerList = param1;
         this.dispatchEvent(new UnrealShootingEvent("UNREAL_SHOOTING_PLAYER_LIST_CHANGE",param1));
      }
      
      public function get rankDetailList() : Array
      {
         return _rankDetailList;
      }
      
      public function set rankDetailList(param1:Array) : void
      {
         _rankDetailList = param1;
         this.dispatchEvent(new UnrealShootingEvent("UNREAL_SHOOTING_RANK_DETAIL_LIST_CHANGE",param1));
      }
      
      public function get finalOrderList() : Array
      {
         return _finalOrderList;
      }
      
      public function set finalOrderList(param1:Array) : void
      {
         _finalOrderList = param1;
         this.dispatchEvent(new UnrealShootingEvent("UNREAL_SHOOTING_FINAL_ORDER_LIST_CHANGE",param1));
      }
      
      public function infoChange() : void
      {
         this.dispatchEvent(new UnrealShootingEvent("UNREAL_SHOOTING_INFO_CHANGE"));
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new UnrealShootingEvent("UNREAL_SHOOTING_ACTIVE_STATE_CHANGE"));
      }
   }
}

