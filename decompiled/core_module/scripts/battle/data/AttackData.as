package battle.data
{
   import battle.BattleManager;
   import yishi.datas.objects.RoleInfo;
   
   public class AttackData
   {
      
      public var fId:int;
      
      public var resistType:int;
      
      public var resistValue:int;
      
      public var resiPercent:int;
      
      public var bloodType:int;
      
      public var damageValue:Number = 0;
      
      public var displayBlood:Number;
      
      public var leftHp:Number;
      
      public var extraData:uint;
      
      public var parry:Boolean;
      
      public var skillIds:Array;
      
      public var dropList:Array = [];
      
      private var _roleId:int;
      
      private var _roleInfo:RoleInfo;
      
      public var fire:Boolean;
      
      public var isUpdated:Boolean;
      
      public var hpMaxAdd:int = 0;
      
      public function AttackData()
      {
         super();
      }
      
      public function clone() : AttackData
      {
         var _loc1_:AttackData = new AttackData();
         _loc1_.damageValue = damageValue;
         _loc1_.leftHp = leftHp;
         _loc1_.extraData = extraData;
         _loc1_.roleId = roleId;
         _loc1_.hpMaxAdd = this.hpMaxAdd;
         return _loc1_;
      }
      
      public function get roleInfo() : RoleInfo
      {
         if(!_roleInfo)
         {
            _roleInfo = BattleManager.getInstance().battleModel.getRoleById(_roleId);
         }
         return _roleInfo;
      }
      
      public function set roleId(param1:int) : void
      {
         _roleId = param1;
         _roleInfo = BattleManager.getInstance().battleModel.getRoleById(_roleId);
      }
      
      public function get roleId() : int
      {
         return _roleId;
      }
   }
}

