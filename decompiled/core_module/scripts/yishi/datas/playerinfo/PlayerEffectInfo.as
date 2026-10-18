package yishi.datas.playerinfo
{
   public class PlayerEffectInfo
   {
      
      private var _buildTimeAddition:Number = 0;
      
      private var _tecResoueceAddition:Number = 0;
      
      private var _storeLimitAddition:Number = 0;
      
      private var _recruitPawnResourceAddition:Number = 0;
      
      private var _pawnUpgradeSoulAddition:Number = 0;
      
      private var _transferPowerLimitAddition:Number = 0;
      
      private var _transferCoolTimeAddition:Number = 0;
      
      private var _buildTimeAdditionRace:Number = 0;
      
      private var _tecResoueceAdditionRace:Number = 0;
      
      private var _storeLimitAdditionRace:Number = 0;
      
      private var _recruitPawnResourceAdditionRace:Number = 0;
      
      private var _pawnUpgradeSoulAdditionRace:Number = 0;
      
      private var _transferPowerLimitAdditionRace:Number = 0;
      
      private var _transferCoolTimeAdditionRace:Number = 0;
      
      public function PlayerEffectInfo()
      {
         super();
      }
      
      public function set buildTimeAddition(param1:Number) : void
      {
         _buildTimeAddition = param1;
      }
      
      public function set tecResoueceAddition(param1:int) : void
      {
         _tecResoueceAddition = param1;
      }
      
      public function set storeLimitAddition(param1:Number) : void
      {
         _storeLimitAddition = param1;
      }
      
      public function set recruitPawnResourceAddition(param1:Number) : void
      {
         _recruitPawnResourceAddition = param1;
      }
      
      public function set pawnUpgradeSoulAddition(param1:Number) : void
      {
         _pawnUpgradeSoulAddition = param1;
      }
      
      public function set transferPowerLimitAddition(param1:Number) : void
      {
         _transferPowerLimitAddition = param1;
      }
      
      public function set transferCoolTimeAddition(param1:Number) : void
      {
         _transferCoolTimeAddition = param1;
      }
      
      public function set buildTimeAdditionRace(param1:Number) : void
      {
         _buildTimeAdditionRace = param1;
      }
      
      public function set tecResoueceAdditionRace(param1:Number) : void
      {
         _tecResoueceAdditionRace = param1;
      }
      
      public function set storeLimitAdditionRace(param1:Number) : void
      {
         _storeLimitAdditionRace = param1;
      }
      
      public function set recruitPawnResourceAdditionRace(param1:Number) : void
      {
         _recruitPawnResourceAdditionRace = param1;
      }
      
      public function set pawnUpgradeSoulAdditionRace(param1:Number) : void
      {
         _pawnUpgradeSoulAdditionRace = param1;
      }
      
      public function set transferPowerLimitAdditionRace(param1:Number) : void
      {
         _transferPowerLimitAdditionRace = param1;
      }
      
      public function set transferCoolTimeAdditionRace(param1:Number) : void
      {
         _transferCoolTimeAdditionRace = param1;
      }
      
      public function getBuildTimeAdditionValue(param1:Number) : Number
      {
         return param1 * (1 + _buildTimeAdditionRace / 100) + _buildTimeAddition;
      }
      
      public function getPawnUpgradeSoulAddition(param1:Number) : Number
      {
         return param1 * (1 + _pawnUpgradeSoulAdditionRace / 100) + _pawnUpgradeSoulAddition;
      }
      
      public function getRecruitPawnResourceAddition(param1:Number) : Number
      {
         return param1 * (1 + _recruitPawnResourceAdditionRace / 100) + _recruitPawnResourceAddition;
      }
      
      public function getTransferPowerLimitAddition(param1:Number) : Number
      {
         return param1 * (1 + _transferPowerLimitAdditionRace / 100) + _transferPowerLimitAddition;
      }
      
      public function getTransferCoolTimeAddition(param1:Number) : Number
      {
         return param1 * (1 + _transferCoolTimeAdditionRace / 100) + _transferCoolTimeAddition;
      }
   }
}

