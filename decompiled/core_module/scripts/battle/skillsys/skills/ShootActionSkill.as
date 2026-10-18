package battle.skillsys.skills
{
   import battle.actions.common.SimpleScriptAction;
   import battle.data.BufferDamageData;
   import battle.handler.BufferHandler;
   import battle.skillsys.executer.BundleShootFrameExecuter;
   import battle.skillsys.executer.ShootFrameExecuter;
   import battle.skillsys.executer.SkillFrameExecuter;
   import battle.skillsys.mode.framedata.SkillFrameData;
   import yishi.manager.TempleteManager;
   
   public class ShootActionSkill extends BaseSkill
   {
      
      private var _shootCount:int = 0;
      
      private var _damageIndex:int = 0;
      
      private var _copyFrameData:Array = [];
      
      public function ShootActionSkill()
      {
         super();
      }
      
      override protected function startRun() : void
      {
         if(!getCurrentRole().isLiving)
         {
            actionAttackLeft(0);
            return;
         }
         createCopyFrameData();
         addPassiveEffectAction();
         addSkillPreEffect();
         _currentRole.addAction(createShootAction());
      }
      
      private function addSkillPreEffect() : void
      {
         var _loc1_:int = TempleteManager.instance.getSkillTemplateInfoById(_skillData.skillId).Priority;
         switch(_loc1_ - 3)
         {
            case 0:
               addProfoundEffect();
               break;
            case 1:
               addProfoundEffect2();
         }
      }
      
      private function createCopyFrameData() : void
      {
         var _loc3_:* = null;
         var _loc2_:SkillFrameData = null;
         var _loc1_:Array = [];
         if(_actionTemplate.shootTime < getSkillData().data.length)
         {
            for each(_loc3_ in _actionTemplate.frames)
            {
               if(_loc3_.shootData)
               {
                  _loc1_.push(_loc3_);
               }
            }
            for each(_loc3_ in _loc1_)
            {
               _loc2_ = _loc3_.clone();
               _loc2_.Frame += 8;
               _loc2_.Frame2 += 8;
               _copyFrameData.push(_loc2_);
            }
         }
      }
      
      private function createShootAction() : SimpleScriptAction
      {
         var shootComplete:* = function():void
         {
            addParryBuffer(_shootCount);
            addBuffer(_shootCount);
            _shootCount = _shootCount + 1;
            if(_shootCount == 1)
            {
               updataSp();
            }
            if(_shootCount >= _actionTemplate.shootTime + _copyFrameData.length)
            {
               action.finish();
            }
         };
         var action:SimpleScriptAction = new SimpleScriptAction(_skillData.liftTime,skillComplete);
         action.onPrepare = function():void
         {
            if(!getCurrentRole().isLiving)
            {
               action.finished = true;
               actionAttackLeft(0);
               return;
            }
            for each(var _loc1_:SkillFrameData in _actionTemplate.frames)
            {
               if(_loc1_.Frame == 0)
               {
                  if(isFrameSexFit(_loc1_))
                  {
                     SkillFrameExecuter.execute(_thisProxy,_loc1_,action);
                  }
               }
            }
            setArrangePriority(true);
         };
         action.onUpdate = function():void
         {
            var _loc3_:* = null;
            var _loc1_:* = null;
            var _loc2_:int = 0;
            started = true;
            if(!getCurrentRole().isLiving)
            {
               action.finished = true;
               actionAttackLeft(_damageIndex);
               return;
            }
            for each(_loc3_ in _actionTemplate.frames)
            {
               if(isFrameSexFit(_loc3_))
               {
                  _loc2_ = _loc3_.Frame;
                  if(_loc2_ == action.frameCount)
                  {
                     if(_loc3_.shootData)
                     {
                        shootFrameExecute(_loc3_,_damageIndex,shootComplete);
                        _damageIndex = _damageIndex + 1;
                     }
                     else
                     {
                        SkillFrameExecuter.execute(_thisProxy,_loc3_,action);
                     }
                  }
               }
            }
            for each(_loc3_ in _copyFrameData)
            {
               if(isFrameSexFit(_loc3_))
               {
                  _loc2_ = _loc3_.Frame;
                  if(_loc2_ == action.frameCount)
                  {
                     shootFrameExecute(_loc3_,_damageIndex,shootComplete);
                     _damageIndex = _damageIndex + 1;
                  }
               }
            }
         };
         return action;
      }
      
      protected function shootFrameExecute(param1:SkillFrameData, param2:int, param3:Function) : void
      {
         if(param1.ActionType == 12)
         {
            new BundleShootFrameExecuter(this,param1,param2,param3);
         }
         else
         {
            new ShootFrameExecuter(this,param1,param2,param3);
         }
      }
      
      override protected function addParryBuffer(param1:int) : void
      {
         if(param1 > 0)
         {
            return;
         }
         if(_skillData.skillBuffers && _skillData.skillBuffers.length > 0)
         {
            for each(var _loc2_:BufferDamageData in _skillData.skillBuffers)
            {
               if(_loc2_.effectiveType == 4)
               {
                  BufferHandler.processBuffer(_loc2_,_skillData.fId,param1);
               }
            }
         }
      }
   }
}

