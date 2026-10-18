package battle.handler
{
   import battle.BattleManager;
   import battle.data.AttackData;
   import battle.data.BufferDamageData;
   import battle.data.DamageData;
   import battle.utils.BattleUtils;
   import battle.view.roles.RoleViewBase;
   import com.road.yishi.proto.battle.DropInfoMsg;
   import yishi.datas.objects.GoddessRoleInfo;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   
   public class BufferHandler
   {
      
      public static var excuteCount:int = 0;
      
      public function BufferHandler()
      {
         super();
      }
      
      public static function bufferAffectAction(param1:BufferDamageData) : void
      {
         var _loc2_:DamageData = param1.damages[0] as DamageData;
         switch(param1.AttackType - 2)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 6:
            case 9:
            case 10:
               break;
            case 4:
               BattleUtils.addSingleDanny([convertDamageDataToAttackData(_loc2_,param1.target)]);
         }
      }
      
      private static function bufferAffectActionII(param1:BufferDamageData, param2:int, param3:int = 0) : void
      {
         var _loc4_:RoleViewBase = null;
         addDanny(param1,param2,param3);
         if(BattleManager.getInstance().battleMap && BattleManager.getInstance().battleMap.rolesDict && BattleManager.getInstance().battleMap.rolesDict[param1.target])
         {
            _loc4_ = BattleManager.getInstance().battleMap.rolesDict[param1.target] as RoleViewBase;
         }
         if(_loc4_)
         {
            _loc4_.addBufferActionEffect(param1.templateId);
         }
      }
      
      private static function addDanny(param1:BufferDamageData, param2:int, param3:int = 0) : void
      {
         var _loc5_:HeroRoleInfo = null;
         var _loc6_:Array = null;
         var _loc7_:AttackData = null;
         var _loc8_:RoleInfo = null;
         if(param1.damages && param1.damages.length > param3)
         {
            _loc6_ = param1.getDamageByDannyCount(param3);
            for each(var _loc4_:DamageData in _loc6_)
            {
               if(!_loc4_.isUpdated)
               {
                  _loc4_.isUpdated = true;
                  _loc7_ = convertDamageDataToAttackData(_loc4_,param1.target);
                  _loc7_.fire = param1.AttackType == 316;
                  if(!_loc7_.isUpdated)
                  {
                     if(_loc7_.bloodType == 9)
                     {
                        if(param2 != _loc7_.roleId)
                        {
                           _loc5_ = BattleManager.getInstance().battleModel.getRoleById(_loc7_.roleId) as HeroRoleInfo;
                           if(_loc5_)
                           {
                              _loc7_.isUpdated = true;
                              _loc5_.updateSp(_loc5_.sp + _loc7_.damageValue,false,false,true);
                           }
                        }
                     }
                     else if(_loc7_.bloodType == 24)
                     {
                        if(param2 != _loc7_.roleId)
                        {
                           _loc5_ = BattleManager.getInstance().battleModel.getRoleById(_loc7_.roleId) as HeroRoleInfo;
                           if(_loc5_)
                           {
                              _loc7_.isUpdated = true;
                              _loc5_.updateHitPoint(_loc5_.hitPoint + _loc7_.damageValue,false,false,true);
                           }
                        }
                     }
                     else if(_loc7_.bloodType == 26)
                     {
                        _loc8_ = BattleManager.getInstance().battleModel.getRoleById(_loc7_.roleId);
                        if(_loc8_ && _loc8_ is GoddessRoleInfo)
                        {
                           _loc7_.isUpdated = true;
                           _loc8_.updateBelief(_loc8_.belief + _loc7_.damageValue);
                        }
                     }
                     else
                     {
                        BattleUtils.addSingleDanny([_loc7_],12,true,0,0,6,false,6710886,false);
                     }
                  }
               }
            }
         }
      }
      
      private static function removeBufferII(param1:BufferDamageData) : void
      {
         var _loc2_:RoleViewBase = null;
         if(BattleManager.getInstance().battleMap.rolesDict && BattleManager.getInstance().battleMap.rolesDict[param1.target])
         {
            _loc2_ = BattleManager.getInstance().battleMap.rolesDict[param1.target] as RoleViewBase;
         }
         if(_loc2_)
         {
            _loc2_.removeBuffer(param1.templateId);
         }
      }
      
      private static function convertDamageDataToAttackData(param1:DamageData, param2:int) : AttackData
      {
         var _loc4_:AttackData = new AttackData();
         _loc4_.bloodType = param1.bloodType;
         _loc4_.damageValue = param1.damageValue;
         _loc4_.displayBlood = param1.displayBlood;
         _loc4_.roleId = param1.target;
         _loc4_.leftHp = param1.leftValue;
         _loc4_.hpMaxAdd = param1.hpMaxAdd;
         for each(var _loc3_:DropInfoMsg in param1.dropList)
         {
            _loc4_.dropList.push(_loc3_);
         }
         return _loc4_;
      }
      
      public static function processBuffer(param1:BufferDamageData, param2:int, param3:int = 0) : void
      {
         var _loc4_:RoleInfo = null;
         excuteCount = excuteCount + 1;
         if(!BattleManager.getInstance().battleModel)
         {
            return;
         }
         if(param1.processType == 2 || param1.currentTurn == 0)
         {
            removeBufferII(param1);
            addDanny(param1,param2,param3);
            return;
         }
         _loc4_ = BattleManager.getInstance().battleModel.getRoleById(param1.target);
         if(!_loc4_)
         {
            return;
         }
         if(param1.processType == 0)
         {
            _loc4_.addBuffer(param1);
            if(param1.damages && param1.damages.length > 0)
            {
               _loc4_.refreshBufferTurnForDanny(param1);
            }
         }
         else
         {
            _loc4_.refreshBufferTurnForDanny(param1);
         }
         _loc4_.refreshBuffer(param1);
         bufferAffectActionII(param1,param2,param3);
      }
   }
}

