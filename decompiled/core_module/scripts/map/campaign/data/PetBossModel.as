package map.campaign.data
{
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class PetBossModel
   {
      
      public var isOpen:Boolean;
      
      public var mapId:int;
      
      public var nodeId:int = 0;
      
      public var heroId:int;
      
      public var leftTime:Number;
      
      public var countArr:Array;
      
      public var maxCountArr:Array;
      
      public var currentRagePoint:int;
      
      public var maxRagePoint:int;
      
      public var openTimeArr:Array;
      
      private var configCountInfo:ConfigInfosTempInfo;
      
      private var ragePointInfo:ConfigInfosTempInfo;
      
      private var openTimeInfo:ConfigInfosTempInfo;
      
      public function PetBossModel()
      {
         super();
         configCountInfo = TempleteManager.instance.getConfigInfoByConfigName("pet_island_defend_reward_count");
         ragePointInfo = TempleteManager.instance.getConfigInfoByConfigName("pet_island_defend_boss_rage");
         openTimeInfo = TempleteManager.instance.getConfigInfoByConfigName("pet_island_defend_hour");
         if(configCountInfo)
         {
            maxCountArr = configCountInfo.ConfigValue.split(",");
         }
         if(ragePointInfo)
         {
            maxRagePoint = int(ragePointInfo.ConfigValue);
         }
         if(openTimeInfo)
         {
            openTimeArr = openTimeInfo.ConfigValue.split(",");
         }
      }
      
      public function getNearlyOpenTimeSecond() : Number
      {
         var _loc2_:int = 0;
         var _loc9_:Number = NaN;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:Number = playerModel.sysCurtime.hours;
         var _loc1_:Number = playerModel.sysCurTimeBySecond;
         var _loc5_:* = 0;
         if(openTimeArr)
         {
            _loc3_ = int(openTimeArr.length);
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               if(_loc8_ < openTimeArr[_loc6_])
               {
                  _loc5_ = _loc6_;
                  break;
               }
               _loc6_++;
            }
            _loc2_ = int(openTimeArr[_loc5_]);
         }
         if(_loc8_ >= openTimeArr[openTimeArr.length - 1])
         {
            _loc4_ = playerModel.sysCurtime.date + 1;
         }
         else
         {
            _loc4_ = playerModel.sysCurtime.date;
         }
         var _loc7_:Date = new Date(playerModel.sysCurtime.fullYear,playerModel.sysCurtime.month,_loc4_,_loc2_);
         return _loc7_.time / 1000 - _loc1_;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

