package map.campaign.data
{
   import flash.events.EventDispatcher;
   import map.campaign.event.PvpWarFightEvent;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   
   public class PvpWarFightModel extends EventDispatcher
   {
      
      public static const FLAMETEMPLE_MAX_SCORE:int = 5000;
      
      public static const TEAM_BLUE:int = 1;
      
      public static const TEAM_RED:int = 2;
      
      public static const MIN_SCORE:int = 5;
      
      public static const PERSONAL_REWARDS:Array = [{
         "rank":"1",
         "count":15,
         "count2":40
      },{
         "rank":"2",
         "count":12,
         "count2":30
      },{
         "rank":"3",
         "count":10,
         "count2":20
      },{
         "rank":"4-15",
         "count":6,
         "count2":10
      }];
      
      public var time:String;
      
      public var isFlag:Boolean;
      
      public var pvpWarFightInfo:PvpWarFightInfo;
      
      public var fightReportInfo:WarReportInfo;
      
      private var _warFightOrderList:Array = [];
      
      public var mapId:int;
      
      public var energyGapList:Vector.<FlameTempleEnergyGapInfo> = new Vector.<FlameTempleEnergyGapInfo>();
      
      public function PvpWarFightModel(param1:int)
      {
         super();
         this.mapId = param1;
         energyGapList.push(new FlameTempleEnergyGapInfo(4101009));
         energyGapList.push(new FlameTempleEnergyGapInfo(4101010));
         energyGapList.push(new FlameTempleEnergyGapInfo(4101011));
         pvpWarFightInfo = new PvpWarFightInfo();
      }
      
      public function findSelfInfo() : WarFightOrderInfo
      {
         var _loc2_:WarFightOrderInfo = null;
         var _loc3_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         for each(var _loc1_:WarFightOrderInfo in warFightOrderList)
         {
            if(_loc1_.userId == _loc3_.userId && _loc1_.nickName == _loc3_.nickName && _loc1_.serverName == _loc3_.serviceName)
            {
               _loc2_ = _loc1_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function get warFightOrderList() : Array
      {
         return _warFightOrderList;
      }
      
      public function set warFightOrderList(param1:Array) : void
      {
         _warFightOrderList = param1;
         this.dispatchEvent(new PvpWarFightEvent("PVP_WAR_FIGHT_ORDER_REPORT",param1));
      }
      
      public function getTeamRank() : Array
      {
         sort(_warFightOrderList);
         return _warFightOrderList;
      }
      
      private function sort(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:WarFightOrderInfo = null;
         param1.sortOn(["score","hitCount","honner"],[0x10 | 2,0x10 | 2,0x10 | 2]);
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            _loc3_.order = _loc2_ + 1;
            _loc2_++;
         }
         return param1;
      }
      
      public function getEnergyGapByNodeId(param1:int) : FlameTempleEnergyGapInfo
      {
         for each(var _loc2_:FlameTempleEnergyGapInfo in energyGapList)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function countEnergyGapFor(param1:int) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:FlameTempleEnergyGapInfo in energyGapList)
         {
            if(_loc3_.team == param1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function get blueEnergyGapCount() : int
      {
         return countEnergyGapFor(1);
      }
      
      public function get redEnergyGapCount() : int
      {
         return countEnergyGapFor(2);
      }
      
      public function getPersonRewardNum() : int
      {
         var _loc5_:String = null;
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(pvpWarFightInfo.score < 5)
         {
            return 0;
         }
         for each(var _loc4_:Object in PvpWarFightModel.PERSONAL_REWARDS)
         {
            _loc5_ = _loc4_.rank;
            _loc1_ = _loc5_.split("-");
            _loc2_ = int(_loc1_[0]);
            _loc3_ = _loc2_;
            if(_loc1_.length > 1)
            {
               _loc3_ = int(_loc1_[1]);
            }
            if(pvpWarFightInfo.order >= _loc2_ && pvpWarFightInfo.order <= _loc3_)
            {
               return _loc4_.count;
            }
         }
         return 0;
      }
   }
}

