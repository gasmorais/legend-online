package ui.toptoolbar.view
{
   import managers.WorldBossManager;
   import ui.toptoolbar.TopBtnType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.MagicPubManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PokerManager;
   import yishi.manager.TempleteManager;
   
   public class TimeActiveBoxOpenTime
   {
      
      private static var _instance:TimeActiveBoxOpenTime;
      
      private static const START:int = 0;
      
      private static const END:int = 1;
      
      private var timeActiveArr:Array = [];
      
      private var serverOpenStateArr:Array = [];
      
      public function TimeActiveBoxOpenTime()
      {
         super();
         timeActiveArr = [pvpTime,rvrTime,worldBossTime,vehicleTime,mutiCampaignTime,childArenaTime,pokerTime,giftWillTime,daylightOpenTime];
      }
      
      public static function get instance() : TimeActiveBoxOpenTime
      {
         if(!_instance)
         {
            _instance = new TimeActiveBoxOpenTime();
         }
         return _instance;
      }
      
      public function getOpenTimeByIndex(param1:int) : Array
      {
         return timeActiveArr[param1];
      }
      
      private function get pvpState() : Boolean
      {
         return playerInfo.isPVPStart;
      }
      
      private function get pvpTime() : Array
      {
         return ConfigInfoManager.instance.getPvpMatchTime();
      }
      
      private function get rvrTime() : Array
      {
         return ConfigInfoManager.instance.getRvrMatchTime();
      }
      
      private function get rvrState() : Boolean
      {
         return WorldBossManager.instance.pvpWarIsOpen;
      }
      
      private function get worldBossTime() : Array
      {
         var _loc4_:CampaignTemplate = null;
         var _loc2_:int = 0;
         var _loc3_:Array = [5001,5003];
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc4_ = TempleteManager.instance.worldBossTemplateDict[_loc3_[_loc2_]];
            if(_loc4_)
            {
               _loc1_.push(_loc4_.OpenTime + "," + _loc4_.StopTime);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function get worldBossState() : Boolean
      {
         return playerInfo.worldbossState;
      }
      
      private function get vehicleTime() : Array
      {
         return ConfigInfoManager.instance.getVehicleMatchTime();
      }
      
      private function get vehicleState() : Boolean
      {
         return playerInfo.isVehicleStart;
      }
      
      private function get mutiCampaignTime() : Array
      {
         return ConfigInfoManager.instance.getMultiMatchTime();
      }
      
      private function get mutiCampaignState() : Boolean
      {
         return playerInfo.isOpenCrossMutiCampaign;
      }
      
      private function get childArenaTime() : Array
      {
         return ConfigInfoManager.instance.getChildArenaMatchTime();
      }
      
      private function get pokerTime() : Array
      {
         return ConfigInfoManager.instance.getPokerOpenTime();
      }
      
      private function get pokerState() : Boolean
      {
         return PokerManager.instance.openSign;
      }
      
      private function get giftWillTime() : Array
      {
         return ConfigInfoManager.instance.getGiftWillTime();
      }
      
      private function get daylightOpenTime() : Array
      {
         return ConfigInfoManager.instance.getDayLightOpenTime();
      }
      
      private function get monthCardOpenTime() : Array
      {
         return ConfigInfoManager.instance.getDayLightOpenTime();
      }
      
      private function get giftWillState() : Boolean
      {
         return MagicPubManager.instance.openGiftWill;
      }
      
      private function get childArenaState() : Boolean
      {
         return true;
      }
      
      private function getTimeArr(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc6_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc7_:Array = [];
         var _loc2_:Date = new Date(playerModel.sysCurtime.fullYear,playerModel.sysCurtime.month,playerModel.sysCurtime.day);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc6_ = [];
            _loc4_ = param1[_loc3_].split(",");
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc2_.hours = int(_loc4_[_loc5_].split(":")[0]);
               _loc2_.minutes = int(_loc4_[_loc5_].split(":")[1]);
               _loc6_.push(_loc2_.time / 1000);
               _loc5_++;
            }
            _loc7_.push(_loc6_);
            _loc3_++;
         }
         _loc7_.sort(sortByStartTime);
         return _loc7_;
      }
      
      private function sortByStartTime(param1:Array, param2:Array) : int
      {
         var _loc6_:Number = Number(param1[0]);
         var _loc5_:Number = Number(param2[0]);
         var _loc3_:Number = Number(param1[1]);
         var _loc4_:Number = Number(param2[1]);
         if(_loc6_ < _loc5_)
         {
            return -1;
         }
         if(_loc6_ > _loc5_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 1;
      }
      
      public function getOpenStateByIndex(param1:int) : int
      {
         var _loc5_:Array = null;
         serverOpenStateArr = [pvpState,rvrState,worldBossState,vehicleState,mutiCampaignState,childArenaState,pokerState,giftWillState];
         if(serverOpenStateArr[param1])
         {
            return TopBtnType.TIME_ACTIVE_STATE[2];
         }
         var _loc2_:Array = getTimeArr(timeActiveArr[param1]);
         var _loc4_:int = 1800;
         var _loc3_:int = 1;
         while(_loc3_ <= _loc2_.length)
         {
            _loc5_ = _loc2_[_loc3_ - 1];
            if(playerModel.sysCurTimeBySecond < _loc5_[0] - _loc4_)
            {
               return TopBtnType.TIME_ACTIVE_STATE[0];
            }
            if(playerModel.sysCurTimeBySecond < _loc5_[0])
            {
               return TopBtnType.TIME_ACTIVE_STATE[1];
            }
            if(playerModel.sysCurTimeBySecond < _loc5_[1])
            {
               return TopBtnType.TIME_ACTIVE_STATE[0];
            }
            _loc3_++;
         }
         return TopBtnType.TIME_ACTIVE_STATE[3];
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return playerModel.playerInfo;
      }
   }
}

