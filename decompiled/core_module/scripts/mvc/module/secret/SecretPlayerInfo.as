package mvc.module.secret
{
   import yishi.manager.ArmyManager;
   
   public class SecretPlayerInfo
   {
      
      public var walkCallBack:Function;
      
      private var _armyData:SecretAdArmy;
      
      private var _lastStandNodeId:int;
      
      private var _standNodeId:int;
      
      public function SecretPlayerInfo()
      {
         super();
         if(!_armyData)
         {
            _armyData = new SecretAdArmy();
            _armyData.id = 1;
            _armyData.baseHero = ArmyManager.instance.thane;
         }
      }
      
      public function get armyData() : SecretAdArmy
      {
         return _armyData;
      }
      
      public function commitPostion() : void
      {
      }
      
      public function get standNodeId() : int
      {
         return _standNodeId;
      }
      
      public function set standNodeId(param1:int) : void
      {
         _standNodeId = param1;
      }
      
      public function get lastStandNodeId() : int
      {
         return _lastStandNodeId;
      }
      
      public function set lastStandNodeId(param1:int) : void
      {
         _lastStandNodeId = param1;
         walkCallBack = null;
      }
   }
}

