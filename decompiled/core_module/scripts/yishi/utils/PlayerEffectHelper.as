package yishi.utils
{
   import yishi.datas.playerinfo.PlayerEffectInfo;
   
   public class PlayerEffectHelper
   {
      
      public function PlayerEffectHelper()
      {
         super();
      }
      
      public static function updatePlayerEffect(param1:int, param2:int, param3:PlayerEffectInfo) : void
      {
         switch(param1)
         {
            case 6:
               param3.buildTimeAdditionRace = param2;
               break;
            case 7:
               param3.tecResoueceAdditionRace = param2;
               break;
            case 8:
               param3.storeLimitAdditionRace = param2;
               break;
            case 14:
               param3.recruitPawnResourceAdditionRace = param2;
               break;
            case 18:
               param3.pawnUpgradeSoulAdditionRace = param2;
               break;
            case 33:
               param3.transferPowerLimitAdditionRace = param2;
               break;
            case 34:
               param3.transferCoolTimeAdditionRace = param2;
               break;
            case 106:
               param3.buildTimeAddition = param2;
               break;
            case 107:
               param3.tecResoueceAddition = param2;
               break;
            case 108:
               param3.storeLimitAddition = param2;
               break;
            case 114:
               param3.recruitPawnResourceAddition = param2;
               break;
            case 118:
               param3.pawnUpgradeSoulAddition = param2;
               break;
            case 133:
               param3.transferPowerLimitAddition = param2;
               break;
            case 134:
               param3.transferCoolTimeAddition = param2;
         }
      }
   }
}

