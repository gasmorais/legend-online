package battle.skillsys.helper
{
   import battle.BattleManager;
   import battle.data.AttackData;
   import battle.data.BufferDamageData;
   import battle.data.DamageData;
   import battle.data.ReliveInfo;
   import battle.data.SkillData;
   import flash.utils.Dictionary;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   
   public class BloodHelper
   {
      
      public static var worldBossBloodCached:Number = 0;
      
      public static var worldBossBloodUpdated:Number = 0;
      
      private static var _worldBossSyncTime:Number;
      
      private static var bloodDic:Dictionary = new Dictionary();
      
      public function BloodHelper()
      {
         super();
      }
      
      public static function setup() : void
      {
         bloodDic = new Dictionary();
         worldBossBloodCached = 0;
         worldBossBloodUpdated = 0;
         _worldBossSyncTime = 0;
      }
      
      public static function processBlood(param1:SkillData) : void
      {
         processBufferData(param1,bloodDic);
         processSkillData(param1,bloodDic);
      }
      
      private static function printAllBlood() : void
      {
         var _loc1_:RoleInfo = null;
         var _loc3_:TempRoleBloodInfo = null;
         for(var _loc2_:String in bloodDic)
         {
            _loc1_ = BattleManager.getInstance().battleModel.getRoleById(int(_loc2_));
            if(_loc1_)
            {
               _loc3_ = getTempRoleBlood(_loc1_);
            }
         }
      }
      
      private static function processBufferData(param1:SkillData, param2:Dictionary) : void
      {
         var _loc7_:BufferDamageData = null;
         var _loc4_:DamageData = null;
         var _loc3_:RoleInfo = null;
         var _loc9_:int = 0;
         var _loc8_:TempRoleBloodInfo = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.buffers.length)
         {
            _loc7_ = param1.buffers[_loc5_];
            _loc6_ = 0;
            while(_loc6_ < _loc7_.damages.length)
            {
               _loc4_ = _loc7_.damages[_loc6_];
               _loc4_.buffId = _loc7_.templateId;
               _loc3_ = BattleManager.getInstance().battleModel.getRoleById(_loc4_.target);
               if(_loc3_)
               {
                  _loc8_ = getTempRoleBlood(_loc3_);
                  _loc9_ = updateBlood(_loc8_,_loc4_,param1.attackMillis);
                  param1.recordHurtData(_loc4_.target,_loc9_);
                  if(_loc8_.bloodA <= 0)
                  {
                     param1.willKillSomeBody = true;
                  }
                  obtainWorldBossBlood(_loc4_.target,_loc4_.damageValue);
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      private static function getTempRoleBlood(param1:RoleInfo) : TempRoleBloodInfo
      {
         if(!bloodDic[param1.livingId])
         {
            bloodDic[param1.livingId] = createTempRoleBlood(param1);
         }
         return bloodDic[param1.livingId] as TempRoleBloodInfo;
      }
      
      private static function processSkillData(param1:SkillData, param2:Dictionary) : void
      {
         var _loc8_:AttackData = null;
         var _loc10_:Array = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:RoleInfo = null;
         var _loc6_:TempRoleBloodInfo = null;
         if(param1.data)
         {
            _loc7_ = 0;
            while(_loc7_ < param1.data.length)
            {
               _loc10_ = param1.data[_loc7_];
               _loc5_ = 0;
               while(_loc5_ < _loc10_.length)
               {
                  _loc8_ = _loc10_[_loc5_];
                  if(_loc8_ && _loc8_.roleInfo)
                  {
                     if(!param2[_loc8_.roleId])
                     {
                        param2[_loc8_.roleId] = createTempRoleBlood(_loc8_.roleInfo);
                     }
                     _loc9_ = updateBlood(param2[_loc8_.roleId],_loc8_,param1.attackMillis);
                     param1.recordHurtData(_loc8_.roleId,_loc9_);
                     if(param2[_loc8_.roleId].bloodA <= 0)
                     {
                        param1.willKillSomeBody = true;
                     }
                     obtainWorldBossBlood(_loc8_.roleId,_loc8_.damageValue);
                  }
                  _loc5_++;
               }
               _loc7_++;
            }
         }
         for each(var _loc3_:ReliveInfo in param1.reliveList)
         {
            if(_loc3_.battleId == BattleManager.getInstance().battleModel.battleId)
            {
               _loc4_ = BattleManager.getInstance().battleModel.getRoleById(_loc3_.livingId);
               if(_loc4_)
               {
                  _loc6_ = getTempRoleBlood(_loc4_);
                  _loc6_.bloodA = _loc3_.hp;
                  _loc4_.reliveInfo = _loc3_;
               }
            }
         }
      }
      
      private static function updateBlood(param1:TempRoleBloodInfo, param2:Object, param3:Number) : int
      {
         var _loc7_:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:AttackData = null;
         var _loc4_:DamageData = null;
         if(param2 is AttackData)
         {
            _loc5_ = param2 as AttackData;
            _loc7_ = checkIsSyncForWorldBoss(_loc5_.roleId,param3);
            if(_loc5_.bloodType == 6 || _loc5_.bloodType == 21)
            {
               param1.maxBloodA -= _loc5_.hpMaxAdd;
               _loc5_.damageValue = updateDamageValue(param1.bloodA,_loc5_.displayBlood,param1.maxBloodA,_loc7_);
               _loc6_ = _loc5_.damageValue;
               param1.bloodA -= _loc5_.damageValue;
            }
            else if(_loc5_.bloodType == 7)
            {
               _loc5_.damageValue = updateDamageValue(param1.bloodB,_loc5_.displayBlood,param1.maxBloodB,_loc7_);
               param1.bloodB -= _loc5_.damageValue;
            }
            else if(_loc5_.bloodType == 10)
            {
               _loc6_ = _loc5_.damageValue;
               param1.bloodA -= _loc5_.damageValue;
            }
         }
         else if(param2 is DamageData)
         {
            _loc4_ = param2 as DamageData;
            _loc7_ = checkIsSyncForWorldBoss(_loc4_.target,param3);
            if(_loc4_.bloodType == 6 || _loc4_.bloodType == 21)
            {
               param1.maxBloodA -= _loc4_.hpMaxAdd;
               _loc4_.damageValue = updateDamageValue(param1.bloodA,_loc4_.displayBlood,param1.maxBloodA,_loc7_);
               _loc6_ = _loc4_.damageValue;
               param1.bloodA -= _loc4_.damageValue;
            }
            else if(_loc4_.bloodType == 7)
            {
               _loc4_.damageValue = updateDamageValue(param1.bloodB,_loc4_.displayBlood,param1.maxBloodB,_loc7_);
               param1.bloodB -= _loc4_.damageValue;
            }
         }
         return _loc6_;
      }
      
      private static function updateDamageValue(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : Number
      {
         if(param4)
         {
            return 0;
         }
         if(param1 - param2 > param3)
         {
            return param1 - param3;
         }
         if(param1 - param2 < 0)
         {
            return param1;
         }
         return param2;
      }
      
      private static function createTempRoleBlood(param1:RoleInfo) : TempRoleBloodInfo
      {
         var _loc2_:TempRoleBloodInfo = new TempRoleBloodInfo();
         _loc2_.maxBloodA = param1.totalBloodA;
         _loc2_.maxBloodB = param1.totalBloodB;
         _loc2_.bloodA = param1.realBloodA;
         _loc2_.bloodB = param1.bloodB;
         return _loc2_;
      }
      
      private static function checkIsSyncForWorldBoss(param1:int, param2:Number) : Boolean
      {
         var _loc3_:HeroRoleInfo = battleModel.getWorldBoss();
         if(_loc3_)
         {
            if(_loc3_.livingId == param1)
            {
               if(_worldBossSyncTime > param2)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private static function obtainWorldBossBlood(param1:int, param2:Number) : void
      {
         var _loc3_:HeroRoleInfo = battleModel.getWorldBoss();
         if(_loc3_)
         {
            if(_loc3_.livingId == param1)
            {
               worldBossBloodCached += param2;
               worldBossBloodUpdated += param2;
            }
         }
      }
      
      public static function removeCacheInfoById(param1:uint) : void
      {
         if(bloodDic[param1] != null)
         {
            bloodDic[param1] = null;
            delete bloodDic[param1];
         }
      }
      
      public static function resetRoleBlood(param1:RoleInfo) : void
      {
         var _loc2_:TempRoleBloodInfo = getTempRoleBlood(param1);
         _loc2_.bloodA = param1.bloodA;
         _loc2_.bloodB = param1.bloodB;
         _loc2_.maxBloodA = param1.totalBloodA;
         _loc2_.maxBloodB = param1.totalBloodB;
      }
      
      public static function processWorldBossSyncBlood(param1:Number) : void
      {
         _worldBossSyncTime = param1;
      }
      
      private static function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
   }
}

