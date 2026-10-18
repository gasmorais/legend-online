package battle.transaction
{
   import battle.BattleManager;
   import battle.data.BufferDamageData;
   import battle.data.SkillData;
   import battle.handler.SkillHandlerII;
   import battle.handler.SkillProcessStrategy;
   import battle.skillsys.helper.BloodHelper;
   import battle.utils.BattleFunctionHelper;
   import com.road.yishi.proto.battle.AttackOrderMsg;
   import com.road.yishi.proto.battle.ShowPermanentBuffMsg;
   import logging.LoggerSys;
   import manager.LanguageMgr;
   import map.internals.utils.SocketGameReader;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class BattleAttackTransaction extends BattleBaseTransaction
   {
      
      private var _isFirstAttack:Boolean = true;
      
      public function BattleAttackTransaction()
      {
         super();
      }
      
      private function addHandler() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 173,__specialBufferHandler);
      }
      
      private function __specialBufferHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:HeroRoleInfo = null;
         var _loc7_:BufferDamageData = null;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShowPermanentBuffMsg = new ShowPermanentBuffMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as ShowPermanentBuffMsg;
         var _loc4_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc4_)
         {
            _loc6_ = _loc4_.getRoleById(_loc2_.livingId) as HeroRoleInfo;
            if(_loc6_)
            {
               _loc3_ = _loc2_.bufferId.split(",");
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  _loc7_ = new BufferDamageData();
                  _loc7_.templateId = int(_loc3_[_loc5_]);
                  _loc7_.isPermanent = true;
                  _loc6_.addBuffer(_loc7_);
                  _loc6_.refreshBuffer(_loc7_);
                  _loc5_++;
               }
            }
         }
      }
      
      override public function getCode() : int
      {
         return 153;
      }
      
      override public function configure(param1:Object) : void
      {
         var _loc2_:AttackOrderMsg = null;
         var _loc14_:String = null;
         var _loc10_:String = null;
         var _loc4_:HeroRoleInfo = null;
         var _loc8_:int = 0;
         var _loc3_:* = 0;
         var _loc9_:int = 0;
         if(_isFirstAttack)
         {
            _isFirstAttack = false;
         }
         try
         {
            _pkg = PackageIn(param1);
            _loc2_ = new AttackOrderMsg();
            _loc2_ = _pkg.readBody(_loc2_) as AttackOrderMsg;
         }
         catch(e:Error)
         {
            return;
         }
         var _loc5_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc5_ && _loc2_.battleId != _loc5_.battleId)
         {
            _loc14_ = LanguageMgr.GetTranslation("battle.transaction.BattleAttackTransaction.desc");
            _loc10_ = LanguageMgr.GetTranslation("battle.transaction.BattleAttackTransaction.get");
            LoggerSys.info("BattleId" + _loc14_ + _loc5_.battleId + _loc10_ + _loc2_.battleId);
            return;
         }
         var _loc12_:SkillData = BattleFunctionHelper.instance.readSkill(_loc2_);
         var _loc11_:String = "";
         if(_loc5_.getRoleById(_loc12_.fId) != null)
         {
            _loc11_ = _loc5_.getRoleById(_loc12_.fId).roleName;
            var _loc7_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_loc2_.orderId);
            if(_loc2_.coexist == 1)
            {
               _loc4_ = _loc5_.getRoleById(_loc12_.fId) as HeroRoleInfo;
               _loc8_ = 0;
               while(_loc8_ < _loc4_.titanSkill.length)
               {
                  if(_loc4_.titanSkill[_loc8_] == _loc2_.orderId)
                  {
                     if(FrameControllerManager.instance.outyardControler._isEnterTitanBattle)
                     {
                        _loc9_ = 0;
                        while(_loc9_ < _loc4_.titanSkill.length)
                        {
                           if(_loc4_.titanSkill[_loc9_] != 0)
                           {
                              _loc3_ = _loc9_;
                              break;
                           }
                           _loc9_++;
                        }
                        if(_loc8_ != _loc3_ && !_loc4_.titanSkillUsed[_loc3_])
                        {
                           break;
                        }
                     }
                     _loc4_.titanSkillUsed[_loc8_] = 1;
                     MsgMan.notifyObserver("DragonTitanEvent.TITAN_SKILL_USE");
                  }
                  _loc8_++;
               }
            }
            if(_loc12_.skillId == 41101001)
            {
               _loc4_ = _loc5_.getRoleById(_loc12_.fId) as HeroRoleInfo;
               _loc8_ = 0;
               while(_loc8_ < _loc4_.titanSkill.length)
               {
                  _loc4_.titanSkillUsed[_loc8_] = 0;
                  _loc8_++;
               }
               MsgMan.notifyObserver("DragonTitanEvent.TITAN_SKILL_USE");
            }
            _loc12_.buffers = SocketGameReader.readBufferII(_loc2_);
            _loc12_.awakens = SocketGameReader.readAwakenData(_loc2_);
            if(_loc12_.awakens && _loc12_.awakens.length > 0)
            {
               _loc5_.cacheAwakenRoles(_loc12_.awakens);
            }
            BloodHelper.processBlood(_loc12_);
            var _loc13_:SkillHandlerII = new SkillHandlerII(_loc12_);
            var _loc6_:int = SkillProcessStrategy.processSynchronization(_loc2_.frame,_loc13_.getSkill());
            _loc12_.processStrategy = _loc6_;
            _loc13_.handler();
            if(_loc7_ && (_loc7_.MasterType == 80 || _loc7_.MasterType == 81))
            {
               BattleFunctionHelper.instance.goddessMoiveViewHandler(_loc2_);
            }
            BattleFunctionHelper.instance.sealTitanSkillHandler(_loc12_);
            return;
         }
      }
   }
}

