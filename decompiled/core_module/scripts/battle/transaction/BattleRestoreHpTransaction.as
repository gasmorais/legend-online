package battle.transaction
{
   import battle.BattleManager;
   import battle.data.AttackData;
   import battle.data.ReliveInfo;
   import battle.data.SkillData;
   import battle.skillsys.helper.BloodHelper;
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.battle.AttackOrderMsg;
   import com.road.yishi.proto.battle.DamageMsg;
   import com.road.yishi.proto.battle.DropInfoMsg;
   import com.road.yishi.proto.battle.WaitReviveMsg;
   import logging.LoggerSys;
   import manager.LanguageMgr;
   import map.internals.utils.SocketGameReader;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.utils.DateFormatter;
   
   public class BattleRestoreHpTransaction extends BattleBaseTransaction
   {
      
      public function BattleRestoreHpTransaction()
      {
         super();
      }
      
      override public function configure(param1:Object) : void
      {
         var _loc10_:String = null;
         var _loc4_:String = null;
         var _loc8_:SkillData = null;
         var _loc6_:HeroRoleInfo = null;
         var _loc11_:Array = null;
         var _loc9_:AttackData = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         _pkg = PackageIn(param1);
         var _loc2_:AttackOrderMsg = new AttackOrderMsg();
         _loc2_ = _pkg.readBody(_loc2_) as AttackOrderMsg;
         var _loc3_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc3_ && _loc2_.battleId != _loc3_.battleId)
         {
            _loc10_ = LanguageMgr.GetTranslation("battle.transaction.BattleAttackTransaction.desc");
            _loc4_ = LanguageMgr.GetTranslation("battle.transaction.BattleAttackTransaction.get");
            LoggerSys.info("BattleId" + _loc10_ + _loc3_.battleId + _loc4_ + _loc2_.battleId);
            return;
         }
         if(_loc3_)
         {
            _loc8_ = readSkill(_loc2_);
            _loc8_.buffers = SocketGameReader.readBufferII(_loc2_);
            _loc8_.awakens = SocketGameReader.readAwakenData(_loc2_);
            if(_loc8_.awakens && _loc8_.awakens.length > 0)
            {
               _loc3_.cacheAwakenRoles(_loc8_.awakens);
            }
            BloodHelper.processBlood(_loc8_);
            _loc6_ = _loc3_.getRoleById(_loc8_.fId) as HeroRoleInfo;
            if(_loc6_)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc8_.data.length)
               {
                  _loc11_ = _loc8_.data[_loc7_];
                  _loc5_ = 0;
                  while(_loc5_ < _loc11_.length)
                  {
                     _loc9_ = _loc11_[_loc5_];
                     _loc6_.updateBlood(-_loc9_.damageValue,-_loc9_.displayBlood,false);
                     _loc5_++;
                  }
                  _loc7_++;
               }
            }
         }
      }
      
      private function readSkill(param1:AttackOrderMsg) : SkillData
      {
         var _loc2_:SkillData = readSkillData(param1);
         if(_loc2_.skillId == 0)
         {
            _loc2_.skillId = -1;
         }
         return _loc2_;
      }
      
      private function readSkillData(param1:AttackOrderMsg) : SkillData
      {
         var _loc12_:int = 0;
         var _loc6_:DamageMsg = null;
         var _loc8_:int = 0;
         var _loc5_:AttackData = null;
         var _loc4_:ReliveInfo = null;
         var _loc9_:SkillData = new SkillData();
         _loc9_.skillId = param1.orderId;
         _loc9_.fId = param1.livingId;
         _loc9_.sp = param1.sp;
         _loc9_.spAdded = param1.spAdded;
         _loc9_.hitPoint = param1.hitPoint;
         _loc9_.hitPointAdded = 0;
         _loc9_.attackMillis = DateFormatter.parse(param1.attackMillis,"YYYY-MM-DD hh:mm:ss").time;
         _loc9_.battleId = param1.battleId;
         _loc9_.passive = param1.isPassive;
         _loc9_.liftTime = param1.execFrame;
         var _loc3_:int = int(param1.damages.length);
         var _loc7_:Array = [];
         var _loc10_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc6_ = param1.damages[_loc8_];
            _loc12_ = _loc6_.livingId;
            _loc5_ = new AttackData();
            _loc5_.bloodType = _loc6_.damageType;
            _loc5_.roleId = _loc12_;
            _loc5_.damageValue = Int64Utils.int64ToNumber(_loc6_.damageValue);
            _loc5_.displayBlood = Int64Utils.int64ToNumber(_loc6_.damageValue);
            _loc5_.extraData = _loc6_.extraData;
            _loc5_.parry = _loc6_.parry;
            _loc5_.leftHp = Int64Utils.int64ToNumber(_loc6_.leftValue);
            _loc5_.resistValue = _loc6_.resiValue;
            _loc5_.resistType = _loc6_.resiType;
            _loc5_.resiPercent = _loc6_.resiPercent;
            for each(var _loc2_:DropInfoMsg in _loc6_.dropInfos)
            {
               _loc5_.dropList.push(_loc2_);
            }
            if(_loc7_.indexOf(_loc12_) == -1)
            {
               _loc7_.push(_loc12_);
            }
            _loc10_.push(_loc5_);
            _loc8_++;
         }
         _loc9_.data = dataFormatConversion(_loc7_,_loc10_);
         for each(var _loc11_:WaitReviveMsg in param1.waitRevives)
         {
            _loc4_ = ReliveInfo.createFromMsg(_loc11_);
            _loc9_.reliveList.push(_loc4_);
         }
         return _loc9_;
      }
      
      private function dataFormatConversion(param1:Array, param2:Array) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:AttackData = null;
         var _loc7_:Array = [];
         var _loc8_:int = param2.length / param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            _loc3_ = [];
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc4_ = param2[_loc5_ + _loc6_ * _loc8_] as AttackData;
               _loc3_.push(_loc4_);
               _loc6_++;
            }
            _loc7_.push(_loc3_);
            _loc5_++;
         }
         return _loc7_;
      }
      
      override public function getCode() : int
      {
         return 4849;
      }
   }
}

